package controller.admin_dashboard;

import dao.FeedbackDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Feedback;
import model.User;
import services.FeedbackService;

import java.io.IOException;

@WebServlet(name = "TodoListController", value = "/todo_list")
public class TodoListController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("AdminPages/admin_dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Người dùng điền 4 thông tin từ support.jsp gồm tên, email, chủ đề (title), nội dung (content)
        // Nhưng phương pháp điền 4 thông tin rất dễ security risk vì có thể giả dạng email người khác,
        // => nên phương pháp tốt nhất là giữ lại còn 2 trường là chủ đề và nội dung (Nếu phần hỗ trợ phải Login mới dùng)
        // Dùng session từ user để lấy user_id
        // Cập nhật status từ 0 <-> 1
        String action = request.getParameter("action");
        FeedbackService feedbackService = new FeedbackService();
        if ("update_status".equals(action)) {
            int id = Integer.parseInt(request.getParameter("taskId"));
            boolean status = Boolean.parseBoolean(request.getParameter("status"));
            feedbackService.updateFeedback(id, status);
            response.sendRedirect("dashboard");
        } else if ("delete_task".equals(action)) {
            int id = Integer.parseInt(request.getParameter("taskId"));
            feedbackService.deleteFeedback(id);
            response.sendRedirect("dashboard");
        } else {
            String title = request.getParameter("subject");
            String content = request.getParameter("message");
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");
            if (user != null) {
                feedbackService.insertFeedback(user.getId(), title, content);
                response.sendRedirect(request.getContextPath());
            } else {
                response.sendRedirect("login");
            }
        }
    }
}