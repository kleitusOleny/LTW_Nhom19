package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.User;
import services.AuthService;
import services.EmailServices;

import java.io.IOException;

@WebServlet(name = "AuthenticationController", value = "/authentication")
public class AuthenticationController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/AuthPages/Authentication.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String action = request.getParameter("action");
        String otpInput = request.getParameter("otpInput");

        AuthService authService = new AuthService();
        HttpSession session = request.getSession();
        EmailServices emailServices = new EmailServices();
        User account = (User) session.getAttribute("pendingUser");

        // ------------------------ Button cho lấy mã OTP ---------------------------------
        if ("send-otp".equals(action)) {
            if (email == null || email.trim().isEmpty() || !email.matches("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$")) {
                request.setAttribute("emailError", "Email không đúng định dạng hoặc bị bỏ trống");
            }
            else {
                Long lastOtpTime = (Long) session.getAttribute("otpTime");
                if (lastOtpTime != null && (System.currentTimeMillis() - lastOtpTime < 60000)) {
                    long secondsLeft = (60000 - (System.currentTimeMillis() - lastOtpTime)) / 1000;
                    request.setAttribute("emailError", "Vui lòng đợi " + secondsLeft + " giây nữa để gửi lại mã");
                }
                else {
                    if (account != null) {
                        // luồng từ register
                        if (!email.equalsIgnoreCase(account.getEmail())) {
                            request.setAttribute("emailError", "Email không khớp với thông tin đã đăng ký!");
                        } else {
                            sendAndSaveOtp(email, authService.generateRandomOtp(), session, request, emailServices);
                        }
                    } else {
                        // luồng quên mật khẩu
                        String generatedOtp = authService.generateOtp(email);
                        if (generatedOtp != null) {
                            sendAndSaveOtp(email, generatedOtp, session, request, emailServices);
                        } else {
                            request.setAttribute("emailError", "Email không tồn tại trên hệ thống");
                        }
                    }
                }
            }
            request.getRequestDispatcher("/AuthPages/Authentication.jsp").forward(request, response);

        // ------------------------ Button cho xác nhận ---------------------------------
        } else if ("finish-otp".equals(action)) {
            String storedOtp = (String) session.getAttribute("otpCode");
            if (otpInput != null && otpInput.equals(storedOtp)) {
                if (account != null) {
                    // luồng từ register
                    User realAccount = authService.register(
                            account.getFullName(), account.getEmail(), account.getUsername(),
                            account.getPasswordHash(), account.getPhoneNumber(), account.getBirthDay()
                    );
                    if (realAccount != null) {
                        session.removeAttribute("pendingUser");
                        session.setAttribute("user", realAccount);
                        session.removeAttribute("otpCode");
                        response.sendRedirect(request.getContextPath() + "?registerSuccess=1");
                    } else {
                        request.setAttribute("otpError", "Lỗi lưu dữ liệu, vui lòng thử lại!");
                        request.getRequestDispatcher("/AuthPages/Authentication.jsp").forward(request, response);
                    }
                } else {
                    // Luồng từ quên mật khẩu
                    session.removeAttribute("otpCode");
                    response.sendRedirect("forgotpassword");
                }
            } else {
                request.setAttribute("otpError", "Mã OTP không chính xác!");
                request.getRequestDispatcher("/AuthPages/Authentication.jsp").forward(request, response);
            }
        }
    }

    private void sendAndSaveOtp(String email, String otp, HttpSession session, HttpServletRequest request, EmailServices emailServices) {
        if (emailServices.sendOtpEmail(email, otp)) {
            session.setAttribute("otpCode", otp);
            session.setAttribute("otpEmail", email);
            session.setAttribute("otpTime", System.currentTimeMillis());
            request.setAttribute("message", "Mã OTP đã được gửi tới Google Mail của bạn");
        } else {
            request.setAttribute("emailError", "Lỗi gửi mail hệ thống, vui lòng thử lại sau");
        }
    }
}