package controller.account_manager;

import dao.UserDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.User;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "AccountManagerController", value = "/account-manager")
public class AccountManagerController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserDAO userDAO = new UserDAO();
        List<User> userList = userDAO.getAll();
        if (userList != null) {
            request.setAttribute("listAccount", userList);
            request.getRequestDispatcher("AdminPages/manage_accounts.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/accountmanage" + "?fetchDataError");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}