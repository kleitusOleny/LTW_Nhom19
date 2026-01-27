package controller.admin_dashboard;

import dao.FeedbackDAO;
import dao.ProductDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Feedback;
import model.Product;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ViewTodoList", value = "/dashboard")
public class DashBoardController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        FeedbackDAO feedbackDAO = new FeedbackDAO();
        ProductDAO productDAO = new ProductDAO();
        List<Feedback> pendingList = feedbackDAO.getPendingFeedbacks();
        List<Feedback> doneList = feedbackDAO.getCompletedFeedbacks();
        List<Product> outOfStockList = productDAO.countOutOfStocks();
        request.setAttribute("outOfStockList", outOfStockList);
        request.setAttribute("pendingList", pendingList);
        request.setAttribute("doneList", doneList);
        request.getRequestDispatcher("AdminPages/admin_dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}