package controller;

import dao.UserDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import services.AuthService;
import services.EmailServices;

import java.io.IOException;

@WebServlet(name = "AuthenticationController", value = "/AuthenticationController")
public class AuthenticationController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String action = request.getParameter("action");
        String otpInput = request.getParameter("otpInput");
        AuthService authService = new AuthService();
        HttpSession session = request.getSession();
        EmailServices emailServices = new EmailServices();

        boolean canVerify = false;
        long currentTime = System.currentTimeMillis();
        Long lastOtpTime = (Long) session.getAttribute("otpTime"); // Tránh bị NullPoint
        if ("send-otp".equals(action)) {
            if (email == null || email.trim().isEmpty() || !email.matches("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$")) {
                request.setAttribute("emailError", "Email không đúng định dạng hoặc bị bỏ trống");
            } else {
                if (lastOtpTime != null) {
                    long timeElapsed = currentTime - lastOtpTime;
                    if (timeElapsed < 60000){
                        canVerify = true;
                        long secondsLeft = (60000 - timeElapsed) / 1000;
                        request.setAttribute("emailError", "Vui lòng đợi " + secondsLeft + " giây nữa để gửi lại mã");
                    }
                }
                if (!canVerify) {
                    String generatedOtp = authService.generateOtp(email);
                    if (generatedOtp != null) {
                        boolean isGoogleMailSent = emailServices.sendOtpEmail(email, generatedOtp);
                        if (isGoogleMailSent) {
                            session.setAttribute("otpCode", generatedOtp);
                            session.setAttribute("otpEmail", email);
                            session.setAttribute("otpTime", System.currentTimeMillis());
                            request.setAttribute("message", "Mã OTP của bạn đã được gửi, hãy kiểm tra qua Google Mail");
                        } else {
                            request.setAttribute("emailError", "Lỗi gửi mail hệ thống, vui lòng thử lại sau");
                        }
                    } else {
                        request.setAttribute("emailError", "Email không tồn tại");
                    }
                }
            }
            request.getRequestDispatcher("/AuthPages/Authentication.jsp").forward(request, response);
        } else if ("finish-otp".equals(action)) {
            String storedOtp = (String) session.getAttribute("otpCode"); // session đã lưu
            if (otpInput.equals(storedOtp)) {
                session.removeAttribute(storedOtp);
                response.sendRedirect(request.getContextPath() + "/AuthPages/ForgotPassword.jsp");
            } else {
                request.setAttribute("otpError", "Mã OTP không chính xác!");
                request.getRequestDispatcher("/AuthPages/Authentication.jsp").forward(request, response);
            }
        } else {
            System.out.println("Lỗi action trong đoạn code");
            System.out.println(email + action);
        }
    }
}