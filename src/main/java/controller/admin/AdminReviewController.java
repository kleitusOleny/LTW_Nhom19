package controller.admin;

import dao.ReviewDAO;
import model.ReviewViewModel;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminReviewController", value = "/admin/manage-reviews")
public class AdminReviewController extends HttpServlet {
    private ReviewDAO reviewDAO;

    @Override
    public void init() {
        reviewDAO = new ReviewDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy danh sách tất cả đánh giá
            List<ReviewViewModel> reviews = reviewDAO.getAllReviews();
            request.setAttribute("reviews", reviews);

            // Lấy thống kê
            int totalReviews = reviewDAO.countAllReviews();
            double avgRating = reviewDAO.getAverageRating();
            request.setAttribute("totalReviews", totalReviews);
            request.setAttribute("avgRating", String.format("%.1f", avgRating));

            // Check for error/success message in session and move to request
            String errorMessage = (String) request.getSession().getAttribute("errorMessage");
            if (errorMessage != null) {
                request.setAttribute("errorMessage", errorMessage);
                request.getSession().removeAttribute("errorMessage");
            }

            String successMessage = (String) request.getSession().getAttribute("successMessage");
            if (successMessage != null) {
                request.setAttribute("successMessage", successMessage);
                request.getSession().removeAttribute("successMessage");
            }

            request.getRequestDispatcher("/AdminPages/manage_reviews.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unable to load reviews");
        }
    }
}
