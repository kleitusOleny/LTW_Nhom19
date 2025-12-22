package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import services.AuthService;

import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;

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

        boolean account;
        String registerUrl = "/AuthPages/Register.jsp";
        AuthService authService = new AuthService();
        try {
            account = authService.register(fullName, email, username, plainPassword, phoneNumber, LocalDate.parse(birth));
            if (account) {
                HttpSession session = request.getSession();
                session.setAttribute("user", true);
                response.sendRedirect(request.getContextPath() + "/AuthPages/Login.jsp");
            } else {
                response.sendRedirect(request.getContextPath() + registerUrl + "?registerError=1");
            }
        } catch (IllegalArgumentException e) {
            String message = e.getMessage();
            String errorCode = switch (message) {
                case "ErrorCode2" -> "2";
                case "ErrorCode3" -> "3";
                case "ErrorCode4" -> "4";
                default -> "1";
            };
            response.sendRedirect(request.getContextPath() + registerUrl + "?registerError=" + errorCode);
        }
    }
}