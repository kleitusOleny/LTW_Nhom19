package services;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;
import org.mindrot.jbcrypt.BCrypt;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import java.util.Objects;

public class UserService {
    private final UserDAO userDAO = new UserDAO();

    private boolean safeCheck(User currentUser, User newUser) {
        if (currentUser == null)
            return false;
        if (currentUser.getEmail().equals(newUser.getEmail()))
            return false;
        return true;
    }

    public boolean updateProfile(User newUser) {
        if (newUser == null)
            return false;

        User currentUser = userDAO.findById(newUser);
        if (currentUser == null)
            return false;

        if (!Objects.equals(currentUser.getEmail(), newUser.getEmail())) {
            if (userDAO.findByEmail(newUser.getEmail()) != null) {
                throw new IllegalArgumentException("Email đã tồn tại");
            }
            currentUser.setEmail(newUser.getEmail());
        }

        if (newUser.getUsername() != null)
            currentUser.setUsername(newUser.getUsername());

        if (newUser.getFullName() != null)
            currentUser.setFullName(newUser.getFullName());

        if (newUser.getBirthDay() != null)
            currentUser.setBirthDay(newUser.getBirthDay());

        if (newUser.getPhoneNumber() != null)
            currentUser.setPhoneNumber(newUser.getPhoneNumber());

        currentUser.setActive(newUser.getActive());

        return userDAO.update(currentUser);
    }

    public boolean blockAccount(User newUser) {
        User currentUser = userDAO.findById(newUser);

        if (safeCheck(currentUser, newUser)) {
            currentUser.setActive(newUser.getActive());
        }

        return userDAO.updateActiveStatus(currentUser);
    }

    public boolean addAccount(User newUser) {
        int count = userDAO.countUserId(newUser.getEmail());
        if (count > 0)
            return false;

        String plainPass = newUser.getPasswordHash();
        String hashedPass = BCrypt.hashpw(plainPass, BCrypt.gensalt(12));

        newUser.setEmail(newUser.getEmail());
        newUser.setUsername(null);
        newUser.setPasswordHash(hashedPass);
        newUser.setPhoneNumber("");
        newUser.setFullName("");
        newUser.setBirthDay(null);
        newUser.setAdministrator(0);
        newUser.setActive(1);
        newUser.setCreatedAt(LocalDateTime.now());

        return userDAO.create(newUser);
    }
    public void updateProfile(HttpServletRequest request, HttpServletResponse response)
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

        this.updateProfile(user);

        session.setAttribute("user", user);

        session.setAttribute("success", "Cập nhật thông tin thành công");
        request.setAttribute("user", user);
        request.getRequestDispatcher("/infoUsers/user_sidebar.jsp").forward(request, response);
    }
}
