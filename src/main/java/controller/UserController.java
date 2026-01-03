package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;
import org.mindrot.jbcrypt.BCrypt;
import services.AuthService;
import services.UserService;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

@WebServlet(name = "UserController", value = "/user")
public class UserController extends HttpServlet {
    private UserService userService;

    @Override
    public void init() {
        userService = new UserService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            String requestedWith = request.getHeader("X-Requested-With");
            if ("XMLHttpRequest".equals(requestedWith)) {
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                response.getWriter().write("{\"error\":\"not_authenticated\"}");
                return;
            }
            response.sendRedirect(request.getContextPath() + "login");
            return;
        }
        User user = (User) session.getAttribute("user");
        String page = request.getParameter("page");
        if (page == null) {
            page = "info";
        }

        try {
            request.setAttribute("user", user);
            switch (page) {
                case "settings":
                    request.getRequestDispatcher("/infoUsers/settings.jsp").forward(request, response);
                    break;
                case "reviews":
                    request.getRequestDispatcher("/infoUsers/review_history.jsp").forward(request, response);
                    break;
                case "support":
                    request.getRequestDispatcher("/infoUsers/support.jsp").forward(request, response);
                    break;
                default:
                    request.getRequestDispatcher("/infoUsers/info_user.jsp").forward(request, response);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Có lỗi xảy ra");
            response.sendRedirect(request.getContextPath() + "/");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("updateProfile".equals(action)) {
            try {
                userService.updateProfile(request, response);
            } catch (ParseException e) {
                throw new RuntimeException(e);
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Action không hợp lệ");
        }
    }

}
