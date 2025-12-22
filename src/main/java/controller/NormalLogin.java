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
        if (username == null || pass == null || username.isEmpty() || pass.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/AuthPages/Login.jsp?loginError=3");
            return;
        }

        User account;
        AuthService authService = new AuthService();
        account = authService.login(username, pass);
        if (account != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", account);
            response.sendRedirect(request.getContextPath() + "/index.jsp?loginSuccess=1");
        } else {
            response.sendRedirect(request.getContextPath() + "/AuthPages/Login.jsp?loginError=2");
        }
    }
}