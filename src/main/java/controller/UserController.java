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
    private AuthService authService;
    private UserService userService;

    @Override
    public void init() {
        authService = new AuthService();
        userService = new UserService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(true);

        // code chính là phần comment lại, code đang mở là test session thôi
        /*
         * HttpSession session = request.getSession(false);
         * if (session == null || session.getAttribute("user") == null) {
         * response.sendRedirect(request.getContextPath() + "/login");
         * return;
         * }
         * User user = (User) session.getAttribute("user");
         * request.setAttribute("user", user);
         * request.getRequestDispatcher("../webapp/infoUsers/info_user.jsp").forward(
         * request, response);
         */
        if (session.getAttribute("user") == null) {
            User fakeUser = new User();
            fakeUser.setId(1);
            fakeUser.setFullName("Nguyễn Văn A");
            fakeUser.setEmail("test@gmail.com");
            fakeUser.setPhoneNumber("0909999999");
            LocalDate localDate = LocalDate.of(2000, 11, 20);
            LocalDateTime birthDate = localDate.atStartOfDay();
            fakeUser.setBirthDay(birthDate);
            fakeUser.setPasswordHash(BCrypt.hashpw("123456", BCrypt.gensalt()));
            session.setAttribute("user", fakeUser);
        }

        User user = (User) session.getAttribute("user");
        System.out.println(user);
        request.setAttribute("user", user);
        request.getRequestDispatcher("/infoUsers/info_user.jsp").forward(request, response);
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
