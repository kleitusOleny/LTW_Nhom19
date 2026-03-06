package controller.admin;

import dao.BlogDAO;
import model.Blogs;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "AdminGetBlogController", value = "/admin/get-blog")
public class AdminGetBlogController extends HttpServlet {
    private BlogDAO blogDAO;

    @Override
    public void init() {
        blogDAO = new BlogDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Blogs blog = blogDAO.getById(id);

            if (blog != null) {
                PrintWriter out = response.getWriter();
                // Manual JSON construction to avoid dependency issues
                StringBuilder json = new StringBuilder();
                json.append("{");
                json.append("\"id\":").append(blog.getId()).append(",");
                json.append("\"title\":\"").append(escapeJson(blog.getTitle())).append("\",");
                json.append("\"content\":\"").append(escapeJson(blog.getContent())).append("\",");
                json.append("\"category\":\"").append(escapeJson(blog.getCategory())).append("\",");
                json.append("\"blogImage\":\"").append(escapeJson(blog.getBlogImage())).append("\",");
                json.append("\"display\":").append(blog.isDisplay());
                json.append("}");

                out.print(json.toString());
                out.flush();
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    private String escapeJson(String input) {
        if (input == null)
            return "";
        return input.replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\n", "\\n")
                .replace("\r", "\\r")
                .replace("\t", "\\t");
    }
}
