package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.User;
import services.AuthService;

import java.io.IOException;

@WebServlet(name = "NormalLogin", value = "/NormalLogin")
public class NormalLogin extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String pass = request.getParameter("password");

        boolean hasError = false;
        if (username == null || pass == null || username.isEmpty() || pass.isEmpty()) {
            request.setAttribute("inputError", "Tên tài khoản/email hoặc mật khẩu hiện không chứa nội dung gì");
            hasError = true;
        }

        if (username.length() < 4 || username.length() > 80) {
            request.setAttribute("usernameError", "Tên tài khoản hoặc email quá ngắn hoặc quá dài");
            hasError = true;
        }

        User account;
        AuthService authService = new AuthService();
        if (!hasError) {
            account = authService.login(username, pass);
            if (account != null) {
                HttpSession session = request.getSession();
                session.setAttribute("user", account);
                response.sendRedirect(request.getContextPath() + "/index.jsp?loginSuccess=1");
            } else {
                request.setAttribute("loginError", "Bạn đã nhập sai tên tài khoản hoặc mật khẩu");
                request.getRequestDispatcher("/AuthPages/Login.jsp").forward(request, response);
            }
        } else {
            request.getRequestDispatcher("/AuthPages/Login.jsp").forward(request, response);
        }
    }
}