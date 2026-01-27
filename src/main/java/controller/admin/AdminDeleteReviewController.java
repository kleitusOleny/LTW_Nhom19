package controller.admin;

import dao.ReviewDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "AdminDeleteReviewController", value = "/admin/delete-review")
public class AdminDeleteReviewController extends HttpServlet {
    private ReviewDAO reviewDAO;

    @Override
    public void init() {
        reviewDAO = new ReviewDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String idParam = request.getParameter("id");
            if (idParam == null || idParam.isEmpty()) {
                request.getSession().setAttribute("errorMessage", "ID đánh giá không hợp lệ");
                response.sendRedirect(request.getContextPath() + "/admin/manage-reviews");
                return;
            }

            int id = Integer.parseInt(idParam);
            
            // Kiểm tra tham số hard delete
            String hardDelete = request.getParameter("hard");
            boolean success;
            
            if ("true".equals(hardDelete)) {
                // Xóa vĩnh viễn
                success = reviewDAO.hardDeleteReview(id);
            } else {
                // Xóa mềm (đánh dấu is_delete)
                success = reviewDAO.deleteReview(id);
            }

            if (success) {
                request.getSession().setAttribute("successMessage", "Xóa đánh giá thành công");
            } else {
                request.getSession().setAttribute("errorMessage", "Có lỗi xảy ra khi xóa đánh giá");
            }

            response.sendRedirect(request.getContextPath() + "/admin/manage-reviews");
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("errorMessage", "ID đánh giá không hợp lệ");
            response.sendRedirect(request.getContextPath() + "/admin/manage-reviews");
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin/manage-reviews");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect GET requests to POST for safety
        doPost(request, response);
    }
}
