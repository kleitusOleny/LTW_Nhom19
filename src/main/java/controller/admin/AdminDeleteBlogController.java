package controller.admin;

import dao.BlogDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "AdminDeleteBlogController", value = "/admin/delete-blog")
public class AdminDeleteBlogController extends HttpServlet {
    private BlogDAO blogDAO;

    @Override
    public void init() {
        blogDAO = new BlogDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            blogDAO.delete(id);
            response.sendRedirect(request.getContextPath() + "/admin/manage-blog");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unable to delete blog");
        }
    }
}
