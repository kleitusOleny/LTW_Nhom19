package controller;

import dao.BlogCommentDAO;
import model.BlogComment;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "AddCommentController", value = "/add-comment")
public class AddCommentController extends HttpServlet {
    private BlogCommentDAO commentDAO;

    @Override
    public void init() {
        commentDAO = new BlogCommentDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user"); // Assuming 'user' is the session key

        String slug = request.getParameter("slug"); // To redirect back

        if (user == null) {
            // Redirect to login if not logged in
            response.sendRedirect(request.getContextPath() + "/login.jsp?redirect=blog-detail?slug=" + slug);
            return;
        }

        try {
            int blogId = Integer.parseInt(request.getParameter("blogId"));
            String content = request.getParameter("content");

            if (content != null && !content.trim().isEmpty()) {
                BlogComment comment = new BlogComment();
                comment.setBlogId(blogId);
                comment.setUserId(user.getId());
                comment.setContent(content);

                commentDAO.addComment(comment);
            }

            response.sendRedirect(request.getContextPath() + "/blog-detail?slug=" + slug);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unable to add comment");
        }
    }
}
