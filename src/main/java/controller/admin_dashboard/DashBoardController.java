package controller.admin_dashboard;

import dao.FeedbackDAO;
import dao.OrderDAO;
import dao.ProductDAO;
import dao.UserDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Feedback;
import model.Product;
import model.User;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ViewTodoList", value = "/dashboard")
public class DashBoardController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        FeedbackDAO feedbackDAO = new FeedbackDAO();
        ProductDAO productDAO = new ProductDAO();
        OrderDAO orderDAO = new OrderDAO();
        UserDAO userDAO = new UserDAO();

        List<Feedback> doneList = feedbackDAO.getCompletedFeedbacks();
        List<Product> outOfStockList = productDAO.countOutOfStocks();
        int countNewUsers = userDAO.countNewUsersLastWeek();
        int countOrderId = orderDAO.countOrderIdLastWeek();
        double sumTotalPriceOrder = orderDAO.sumTotalPriceLastMonth();

        request.setAttribute("outOfStockList", outOfStockList);
        request.setAttribute("doneList", doneList);
        request.setAttribute("newUsersLastWeek", countNewUsers);
        request.setAttribute("newOrderLastWeek", countOrderId);
        request.setAttribute("sumTotalPriceLastMonth", sumTotalPriceOrder);
        request.getRequestDispatcher("AdminPages/admin_dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}