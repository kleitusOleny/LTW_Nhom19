package controller;

import dao.UserDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.User;
import services.AccountManagerService;
import services.UserValidationServices;

import java.io.IOException;
import java.text.ParseException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "EditAccountController", value = "/accountmanager/edit")
public class EditAccountController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        String email = request.getParameter("email");
        String newPassword = request.getParameter("password_");
        String fullName = request.getParameter("fullname");
        String birth = request.getParameter("birth");
        String username = request.getParameter("username_");
        String phoneNumber = request.getParameter("phone-number");
        String isActive = request.getParameter("activeSelect");
        String isAdministrator = request.getParameter("administratorSelect");
        AccountManagerService accountManagerService = new AccountManagerService();
        UserDAO userDAO = new UserDAO();

        Map<String, String> allErrors = new HashMap<>();
        UserValidationServices userValidationServices = new UserValidationServices();
        allErrors.putAll(userValidationServices.validateEmail(email));
        allErrors.putAll(userValidationServices.validateFullName(fullName));
        allErrors.putAll(userValidationServices.validateBirth(birth));
        allErrors.putAll(userValidationServices.validateUsername(username));
        allErrors.putAll(userValidationServices.validatePhoneNumber(phoneNumber));
        if (newPassword != null && !newPassword.trim().isEmpty()) {
            allErrors.putAll(userValidationServices.validatePassword(newPassword));
        }

        List<User> userList = userDAO.getAll();
        if (allErrors.isEmpty()) {
            try {
                accountManagerService.updateAccount(id, email, newPassword, fullName, birth, username, phoneNumber, isActive, isAdministrator);
            } catch (ParseException e) {
                throw new RuntimeException(e);
            }
            response.sendRedirect(request.getContextPath() + "/accountmanager");
        } else {
            request.setAttribute("editingId", id);
            request.setAttribute("errorSource", "edit_account");
            request.setAttribute("errorList", allErrors.values());
            allErrors.forEach(request::setAttribute);
            request.setAttribute("listAccount", userList);
            request.getRequestDispatcher("/AdminPages/manage_accounts.jsp").forward(request, response);
        }
    }
}