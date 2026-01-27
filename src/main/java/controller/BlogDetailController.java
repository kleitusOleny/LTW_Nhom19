package controller;

import dao.BlogDAO;
import model.Blogs;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "BlogDetailController", value = "/blog-detail")
public class BlogDetailController extends HttpServlet {
    private BlogDAO blogDAO;

    @Override
    public void init() {
        blogDAO = new BlogDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String slug = request.getParameter("slug");
            String idParam = request.getParameter("id");

            Blogs blog = null;

            if (slug != null && !slug.isEmpty()) {
                blog = blogDAO.getBySlug(slug);
            } else if (idParam != null) {
                try {
                    int id = Integer.parseInt(idParam);
                    blog = blogDAO.getById(id);
                } catch (NumberFormatException e) {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid blog ID");
                    return;
                }
            }

            if (blog == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Blog not found");
                return;
            }

            // Set blog as request attribute
            request.setAttribute("blog", blog);

            // Get related blogs (3 items)
            java.util.List<Blogs> relatedBlogs = blogDAO.getRelatedBlogs(blog.getId(), blog.getCategory(), 3);
            request.setAttribute("relatedBlogs", relatedBlogs);

            // Get comments
            dao.BlogCommentDAO commentDAO = new dao.BlogCommentDAO();
            java.util.List<model.BlogComment> comments = commentDAO.getCommentsByBlogId(blog.getId());
            request.setAttribute("comments", comments);

            // Forward to blog_detail.jsp
            request.getRequestDispatcher("blog_detail.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to load blog: " + e.getMessage());
        }
    }
}
