package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import services.AuthService;
import services.UserValidationServices;

import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.Period;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "OnBoardingController", value = "/onboarding")
public class OnBoardingController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/AuthPages/OnBoarding.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String emailToken = (String) request.getSession().getAttribute("googleEmail");
        if (emailToken == null) {
            response.sendRedirect(request.getContextPath() + "/AuthPages/Login.jsp");
        }
        String fullName = request.getParameter("name");
        String username = request.getParameter("username");
        String phoneNumber = request.getParameter("phone-number");
        String birth = request.getParameter("birth");

        UserValidationServices userValidationServices = new UserValidationServices();
        Map<String, String> allErrors = new HashMap<>();
        allErrors.putAll(userValidationServices.validateFullName(fullName));
        allErrors.putAll(userValidationServices.validateUsername(username));
        allErrors.putAll(userValidationServices.validatePhoneNumber(phoneNumber));
        allErrors.putAll(userValidationServices.validateBirth(birth));

        String onBoardingUrl = "/AuthPages/OnBoarding.jsp";
        AuthService authService = new AuthService();
        // Nếu là false thì pass
        if (allErrors.isEmpty()) {
            LocalDate birthDay = LocalDate.parse(birth);
            Timestamp ts = Timestamp.valueOf(birthDay.atStartOfDay());
            authService.register(fullName, emailToken, username, null, phoneNumber, ts);
            response.sendRedirect(request.getContextPath());
        } else {
            allErrors.forEach(request::setAttribute);
            request.getRequestDispatcher(onBoardingUrl).forward(request, response);
        }
    }
}