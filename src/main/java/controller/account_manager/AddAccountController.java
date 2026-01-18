package controller.account_manager;

import dao.UserDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.User;
import services.AccountManagerService;
import services.UserValidationServices;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "AddAccountController", value = "/accountmanager/add")
public class AddAccountController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserDAO userDAO = new UserDAO();
        String email = request.getParameter("email");
        String plainPassword = request.getParameter("password");

        Map<String, String> allErrors = new HashMap<>();
        UserValidationServices userValidationServices = new UserValidationServices();
        allErrors.putAll(userValidationServices.validateEmail(email));
        allErrors.putAll(userValidationServices.validatePassword(plainPassword));

        AccountManagerService accountManagerService = new AccountManagerService();
        List<User> userList = userDAO.getAll();
        if (allErrors.isEmpty()) {
            boolean isSuccess = accountManagerService.addAccount(email, plainPassword);
            if (isSuccess) {
                response.sendRedirect(request.getContextPath() + "/accountmanager?success=true");
            } else {
                request.setAttribute("emailError", "Email này đã tồn tại trong hệ thống!");
                request.setAttribute("listAccount", userList);
                request.getRequestDispatcher("/AdminPages/manage_accounts.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("errorSource", "add_account");
            allErrors.forEach(request::setAttribute);
            request.setAttribute("listAccount", userList);
            request.getRequestDispatcher("/AdminPages/manage_accounts.jsp").forward(request, response);
        }
    }
}