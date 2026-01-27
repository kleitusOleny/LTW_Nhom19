package controller;

import dao.BlogDAO;
import model.Blogs;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "BlogController", value = "/blog")
public class BlogController extends HttpServlet {
    private BlogDAO blogDAO;

    @Override
    public void init() {
        blogDAO = new BlogDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String search = request.getParameter("search");
            String category = request.getParameter("category");

            // Pagination settings
            int page = 1;
            int limit = 6; // Show 6 blogs per page
            if (request.getParameter("page") != null) {
                try {
                    page = Integer.parseInt(request.getParameter("page"));
                } catch (NumberFormatException e) {
                    page = 1;
                }
            }
            int offset = (page - 1) * limit;

            // Get paginated data
            List<Blogs> blogs = blogDAO.searchBlogs(search, category, limit, offset);
            int totalBlogs = blogDAO.countBlogs(search, category);
            int totalPages = (int) Math.ceil((double) totalBlogs / limit);

            request.setAttribute("blogs", blogs);
            request.setAttribute("paramSearch", search);
            request.setAttribute("paramCategory", category);

            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);

            request.getRequestDispatcher("blog.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to load blogs: " + e.getMessage());
        }
    }
}
