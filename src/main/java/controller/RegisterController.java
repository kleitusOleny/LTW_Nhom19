package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import services.AuthService;

import java.io.IOException;
import java.sql.Date;

@WebServlet(name = "RegisterController", value = "/RegisterController")
public class RegisterController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fullName = request.getParameter("name");
        String email = request.getParameter("email");
        String username = request.getParameter("username");
        String plainPassword = request.getParameter("password");
        String phoneNumber = request.getParameter("phone-number");
        String birth = request.getParameter("birth");
        if (fullName == null || fullName.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                plainPassword == null || plainPassword.trim().isEmpty() ||
                phoneNumber == null || phoneNumber.trim().isEmpty() ||
                birth == null || birth.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/AuthPages/Register.jsp?registerError=2");
            return;
        }

        boolean account;
        AuthService authService = new AuthService();
        account = authService.register(fullName, email, username, plainPassword, phoneNumber, Date.valueOf(birth));
        if (account) {
            HttpSession session = request.getSession();
            session.setAttribute("user", true);
            response.sendRedirect(request.getContextPath() + "/AuthPages/Login.jsp");
        } else {
            response.sendRedirect(request.getContextPath() + "/AuthPages/Register.jsp?registerError=1");
        }
    }
}