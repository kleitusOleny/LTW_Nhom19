package controller.admin;

import dao.ReviewDAO;
import model.ReviewViewModel;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "AdminUpdateReviewController", value = "/admin/update-review")
public class AdminUpdateReviewController extends HttpServlet {
    private ReviewDAO reviewDAO;

    @Override
    public void init() {
        reviewDAO = new ReviewDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            request.setCharacterEncoding("UTF-8");
            
            String idParam = request.getParameter("id");
            String content = request.getParameter("content");
            String starParam = request.getParameter("star");

            if (idParam == null || idParam.isEmpty()) {
                request.getSession().setAttribute("errorMessage", "ID đánh giá không hợp lệ");
                response.sendRedirect(request.getContextPath() + "/admin/manage-reviews");
                return;
            }

            int id = Integer.parseInt(idParam);
            double star = Double.parseDouble(starParam);

            // Validate star rating
            if (star < 1 || star > 5) {
                request.getSession().setAttribute("errorMessage", "Số sao phải từ 1 đến 5");
                response.sendRedirect(request.getContextPath() + "/admin/manage-reviews");
                return;
            }

            boolean success = reviewDAO.updateReview(id, content, star);

            if (success) {
                request.getSession().setAttribute("successMessage", "Cập nhật đánh giá thành công");
            } else {
                request.getSession().setAttribute("errorMessage", "Có lỗi xảy ra khi cập nhật đánh giá");
            }

            response.sendRedirect(request.getContextPath() + "/admin/manage-reviews");
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("errorMessage", "Dữ liệu không hợp lệ");
            response.sendRedirect(request.getContextPath() + "/admin/manage-reviews");
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin/manage-reviews");
        }
    }
}
