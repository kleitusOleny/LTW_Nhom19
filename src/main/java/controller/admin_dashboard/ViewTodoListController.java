package controller.admin_dashboard;

import dao.FeedbackDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Feedback;
import services.FeedbackService;

import java.io.IOException;
import java.util.List;

//@WebServlet(name = "ViewTodoList", value = "/dashboard")
public class ViewTodoListController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        FeedbackDAO feedbackDAO = new FeedbackDAO();
        List<Feedback> pendingList = feedbackDAO.getPendingFeedbacks();
        List<Feedback> doneList = feedbackDAO.getCompletedFeedbacks();
        request.setAttribute("pendingList", pendingList);
        request.setAttribute("doneList", doneList);
        request.getRequestDispatcher("AdminPages/admin_dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}