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
                updateProfile(request, response);
            } catch (ParseException e) {
                throw new RuntimeException(e);
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Action không hợp lệ");
        }
    }

    private void updateProfile(HttpServletRequest request, HttpServletResponse response)
            throws ParseException, ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        Date birthDay = formatter.parse(request.getParameter("birthDay"));
        LocalDateTime birthDateTime = birthDay.toInstant().atZone(ZoneId.systemDefault()).toLocalDateTime();
        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");

        if (newPassword != null && !newPassword.isEmpty()) {
            if (!BCrypt.checkpw(oldPassword, user.getPasswordHash())) {
                session.setAttribute("error", "Mật khẩu cũ không đúng");
                request.setAttribute("user", user);
                request.getRequestDispatcher("/infoUsers/user_sidebar.jsp").forward(request, response);
                return;
            }
            String hashedPass = BCrypt.hashpw(newPassword, BCrypt.gensalt(12));
            user.setPasswordHash(hashedPass);
        }
        user.setEmail(email);
        user.setFullName(fullName);
        user.setPhoneNumber(phone);
        user.setBirthDay(birthDateTime);

        userService.updateProfile(user);

        session.setAttribute("user", user);

        session.setAttribute("success", "Cập nhật thông tin thành công");
        request.setAttribute("user", user);
        request.getRequestDispatcher("/infoUsers/user_sidebar.jsp").forward(request, response);
    }

}
