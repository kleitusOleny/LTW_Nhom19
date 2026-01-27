package controller.admin;

import dao.BlogDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "AdminBulkDeleteBlogController", value = "/admin/bulk-delete-blog")
public class AdminBulkDeleteBlogController extends HttpServlet {
    private BlogDAO blogDAO;

    @Override
    public void init() {
        blogDAO = new BlogDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String[] blogIds = request.getParameterValues("blogIds");

            if (blogIds == null || blogIds.length == 0) {
                response.sendRedirect(request.getContextPath() + "/admin/manage-blog");
                return;
            }

            // Delete each selected blog
            for (String idStr : blogIds) {
                try {
                    int id = Integer.parseInt(idStr);
                    blogDAO.delete(id);
                } catch (NumberFormatException e) {
                    // Skip invalid IDs
                    e.printStackTrace();
                }
            }

            response.sendRedirect(request.getContextPath() + "/admin/manage-blog");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unable to delete blogs");
        }
    }
}
