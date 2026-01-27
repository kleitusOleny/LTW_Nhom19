package controller.admin;

import dao.BlogDAO;
import model.Blogs;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "AdminUpdateBlogController", value = "/admin/update-blog")
public class AdminUpdateBlogController extends HttpServlet {
    private BlogDAO blogDAO;

    @Override
    public void init() {
        blogDAO = new BlogDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String title = request.getParameter("title");
            String content = request.getParameter("content");
            String category = request.getParameter("category");
            String image = request.getParameter("image");
            boolean display = "Hiện".equals(request.getParameter("status")); // Value from select option

            Blogs blog = new Blogs();
            blog.setId(id);
            blog.setTitle(title);
            blog.setContent(content);
            blog.setCategory(category);
            blog.setBlogImage(image);
            blog.setDisplay(display);

            blogDAO.update(blog);

            response.sendRedirect(request.getContextPath() + "/admin/manage-blog");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unable to update blog");
        }
    }
}
