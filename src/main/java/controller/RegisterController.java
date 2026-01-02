package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.User;
import services.UserValidationServices;

import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "RegisterController", value = "/register")
public class RegisterController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/AuthPages/Register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String lastname = request.getParameter("lastname");
        String firstname = request.getParameter("firstname");

        String email = request.getParameter("email");
        String username = request.getParameter("username");
        String plainPassword = request.getParameter("password");
        String phoneNumber = request.getParameter("phone-number");
        String birth = request.getParameter("birth");
        String confirmPassword = request.getParameter("confirm-password");

        Map<String, String> allErrors = new HashMap<>();
        UserValidationServices userValidationServices = new UserValidationServices();
        allErrors.putAll(userValidationServices.validateEmail(email));
        allErrors.putAll(userValidationServices.validateFirstAndLastName(lastname, firstname));
        allErrors.putAll(userValidationServices.validateUsername(username));
        allErrors.putAll(userValidationServices.validatePassword(plainPassword));
        allErrors.putAll(userValidationServices.validatePhoneNumber(phoneNumber));
        allErrors.putAll(userValidationServices.validateBirth(birth));
        allErrors.putAll(userValidationServices.isPasswordEqualConfirmed(plainPassword, confirmPassword));

        String registerUrl = "/AuthPages/Register.jsp";
        // Nếu là false thì pass
        if (allErrors.isEmpty()) {
            String fullName = lastname + " " + firstname;
            LocalDate birthDay = LocalDate.parse(birth);
            Timestamp ts = Timestamp.valueOf(birthDay.atStartOfDay());

            // user này chỉ là tạm thời (chỉ dùng để authentication)
            User pendingUser = new User();
            pendingUser.setFullName(fullName);
            pendingUser.setEmail(email);
            pendingUser.setUsername(username);
            pendingUser.setPasswordHash(plainPassword);
            pendingUser.setPhoneNumber(phoneNumber);
            pendingUser.setBirthDay(ts);

            HttpSession session = request.getSession();
            session.setAttribute("pendingUser", pendingUser);
            response.sendRedirect("authentication");
        } else {
            allErrors.forEach(request::setAttribute);
            request.getRequestDispatcher(registerUrl).forward(request, response);
        }
    }
}