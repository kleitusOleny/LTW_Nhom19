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

@WebServlet(name = "NormalLogin", value = "/login")
public class NormalLogin extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/AuthPages/Login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String pass = request.getParameter("password");
        UserValidationServices userValidationServices = new UserValidationServices();

        Map<String, String> allErrors = new HashMap<>(userValidationServices.validateBothUsernameAndEmail(username, pass));

        User account;
        AuthService authService = new AuthService();
        if (allErrors.isEmpty()) {
            account = authService.login(username, pass);
            if (account != null) {
                if (account.getActive() == 1) {
                    // Session Fixation
                    HttpSession oldSession = request.getSession(false);
                    if (oldSession != null) {
                        oldSession.invalidate(); // Huỷ session cũ
                    }
                    HttpSession session = request.getSession(true);
                    session.setAttribute("user", account);
                    // ---
                    if (account.getAdministrator() == 1) {
                        response.sendRedirect(request.getContextPath() + "/dashboard");
                    } else {
                        response.sendRedirect(request.getContextPath() + "/index.jsp?loginSuccess=1");
                    }
                } else {
                    request.setAttribute("loginError", "Tài khoản của bạn đã bị khoá, vui lòng liên hệ Admin để giải quyết");
                    request.getRequestDispatcher("/AuthPages/Login.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("loginError", "Bạn đã nhập sai tên tài khoản hoặc mật khẩu");
                request.getRequestDispatcher("/AuthPages/Login.jsp").forward(request, response);
            }
        } else {
            allErrors.forEach(request::setAttribute);
            request.getRequestDispatcher("/AuthPages/Login.jsp").forward(request, response);
        }
    }
}