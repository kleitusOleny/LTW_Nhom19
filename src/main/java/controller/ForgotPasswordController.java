package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.User;
import services.AuthService;

import java.io.IOException;

@WebServlet(name = "ForgotPassword", value = "/forgotpassword")
public class ForgotPasswordController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/AuthPages/ForgotPassword.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String plainPassword = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm-password");

        boolean hasError = false;
        if (plainPassword == null || plainPassword.trim().isEmpty() ||
                !plainPassword.matches("^(?=.*[a-z])(?=.*[A-Z])(?=.*[^A-Za-z0-9]).{8,}$")) {
            request.setAttribute("passwordError", "Mật khẩu cần ít nhất 8 ký tự, gồm chữ hoa, chữ thường và ký tự đặc biệt");
            hasError = true;
        }

        if (!plainPassword.equals(confirmPassword)) {
            request.setAttribute("confirmedPasswordError", "Mật khẩu xác nhận không khớp, vui lòng nhập lại");
            hasError = true;
        }

        AuthService authService = new AuthService();
        if (!hasError){
            String emailGetFromSession = (String) session.getAttribute("otpEmail");
            if (emailGetFromSession != null) {
                boolean renewPassword = authService.updatePasswordAfterAuthentication(emailGetFromSession, plainPassword);
                if (renewPassword) {
                    response.sendRedirect("login");
                } else {
                    request.setAttribute("userError", "Tài khoản này không tồn tại");
                }
            } else {
                response.sendRedirect("authentication" + "?failResetPassword");
            }
        } else {
            request.getRequestDispatcher("/AuthPages/ForgotPassword.jsp").forward(request, response);
        }
    }
}