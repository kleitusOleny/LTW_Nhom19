package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.User;
import services.AuthService;
import services.UserValidationServices;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

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

        UserValidationServices userValidationServices = new UserValidationServices();
        Map<String, String> allErrors = new HashMap<>();
        allErrors.putAll(userValidationServices.isPasswordEqualConfirmed(plainPassword, confirmPassword));
        allErrors.putAll(userValidationServices.validatePassword(plainPassword));

        AuthService authService = new AuthService();
        if (allErrors.isEmpty()){
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
            allErrors.forEach(request::setAttribute);
            request.getRequestDispatcher("/AuthPages/ForgotPassword.jsp").forward(request, response);
        }
    }
}