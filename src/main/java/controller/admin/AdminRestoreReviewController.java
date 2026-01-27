package controller.admin;

import dao.ReviewDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "AdminRestoreReviewController", value = "/admin/restore-review")
public class AdminRestoreReviewController extends HttpServlet {
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
            boolean success = reviewDAO.restoreReview(id);

            if (success) {
                request.getSession().setAttribute("successMessage", "Khôi phục đánh giá thành công");
            } else {
                request.getSession().setAttribute("errorMessage", "Có lỗi xảy ra khi khôi phục đánh giá");
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
        doPost(request, response);
    }
}
