package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.User;
import services.AuthService;
import services.UserValidationServices;

import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDate;
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
            response.sendRedirect(request.getContextPath() + "login");
        }
        String lastname = request.getParameter("lastname");
        String firstname = request.getParameter("firstname");
        String username = request.getParameter("username");
        String phoneNumber = request.getParameter("phone-number");
        String birth = request.getParameter("birth");

        UserValidationServices userValidationServices = new UserValidationServices();
        Map<String, String> allErrors = new HashMap<>();
        allErrors.putAll(userValidationServices.validateFirstAndLastName(lastname, firstname));
        allErrors.putAll(userValidationServices.validateUsername(username));
        allErrors.putAll(userValidationServices.validatePhoneNumber(phoneNumber));
        allErrors.putAll(userValidationServices.validateBirth(birth));

        User account;
        String onBoardingUrl = "/AuthPages/OnBoarding.jsp";
        AuthService authService = new AuthService();
        // Nếu là false thì pass
        if (allErrors.isEmpty()) {
            String fullName = lastname + " " + firstname;
            HttpSession session = request.getSession();
            LocalDate birthDay = LocalDate.parse(birth);
            Timestamp ts = Timestamp.valueOf(birthDay.atStartOfDay());
            account = authService.register(fullName, emailToken, username, null, phoneNumber, ts);
            if (account != null) {
                session.setAttribute("user", account);
                response.sendRedirect(request.getContextPath() + "/home" + "?loginSuccess");
            } else {
                response.sendRedirect(request.getContextPath() + "onboarding");
            }
        } else {
            allErrors.forEach(request::setAttribute);
            request.getRequestDispatcher(onBoardingUrl).forward(request, response);
        }
    }
}