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

@WebServlet(name = "AdminGetReviewController", value = "/admin/get-review")
public class AdminGetReviewController extends HttpServlet {
    private ReviewDAO reviewDAO;

    @Override
    public void init() {
        reviewDAO = new ReviewDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String idParam = request.getParameter("id");

            if (idParam == null || idParam.isEmpty()) {
                request.getSession().setAttribute("errorMessage", "ID đánh giá không hợp lệ");
                response.sendRedirect(request.getContextPath() + "/admin/manage-reviews");
                return;
            }

            int id = Integer.parseInt(idParam);
            ReviewViewModel reviewEdit = reviewDAO.getReviewById(id);

            if (reviewEdit == null) {
                request.getSession().setAttribute("errorMessage", "Không tìm thấy đánh giá");
                response.sendRedirect(request.getContextPath() + "/admin/manage-reviews");
                return;
            }

            // Lấy danh sách tất cả đánh giá
            List<ReviewViewModel> reviews = reviewDAO.getAllReviews();
            request.setAttribute("reviews", reviews);
            request.setAttribute("reviewEdit", reviewEdit);

            // Lấy thống kê
            int totalReviews = reviewDAO.countAllReviews();
            double avgRating = reviewDAO.getAverageRating();
            request.setAttribute("totalReviews", totalReviews);
            request.setAttribute("avgRating", String.format("%.1f", avgRating));

            request.getRequestDispatcher("/AdminPages/manage_reviews.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("errorMessage", "ID đánh giá không hợp lệ");
            response.sendRedirect(request.getContextPath() + "/admin/manage-reviews");
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin/manage-reviews");
        }
    }
}
