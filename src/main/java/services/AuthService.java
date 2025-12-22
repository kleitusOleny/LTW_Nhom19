package services;

import dao.UserDAO;
import model.User;
import org.mindrot.jbcrypt.BCrypt;

import java.sql.Date;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.util.Locale;

public class AuthService {
    private final UserDAO userDAO = new UserDAO();

    public User login(String loginKey, String plainPassword) {
        User user;
        if (loginKey.contains("@")) {
            user = userDAO.findByEmail(loginKey);
        } else {
            user = userDAO.findByUsername(loginKey);
        }
        if (user == null) return null;
        String hashedPass = user.getPasswordHash();
        if (BCrypt.checkpw(plainPassword, hashedPass)) {
            return user;
        } else {
            return null;
        }
    }

    public boolean register(String fullName, String email, String username, String plainPassword, String phoneNumber, LocalDate birthday) {
        // Kiểm tra lần 1
        if (fullName == null || fullName.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                plainPassword == null || plainPassword.trim().isEmpty() ||
                phoneNumber == null || phoneNumber.trim().isEmpty() ||
                birthday == null) {
            throw new IllegalArgumentException("ErrorCode2");
        }

        // Kiểm tra lần 2
        // Có số, Không phải chữ Unicode, 2 dấu cách liền
        if (fullName.matches(".*\\d.*") || !fullName.matches("^[\\p{L} ]+$") || fullName.matches(".*\\s{2,}.*") ||
                // Sai định dạng chuẩn
                !email.matches("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$") ||
                // Thiếu chữ hoa, thường, số, ký tự đặc biệt hoặc < 8 ký tự
                !plainPassword.matches("^(?=.*[a-z])(?=.*[A-Z])(?=.*[^A-Za-z0-9]).{8,}$") ||
                // Không bắt đầu bằng 0 hoặc độ dài không phải 10-11 số
                !phoneNumber.matches("^0\\d{9,10}$")) {
            throw new IllegalArgumentException("ErrorCode3");
        }
        LocalDate now = LocalDate.now();
        if (now.getYear() - birthday.getYear() < 18) {
            throw new IllegalArgumentException("ErrorCode4");
        }
        if (userDAO.countUserId(email) > 0) return false;
        String hashedPass = BCrypt.hashpw(plainPassword, BCrypt.gensalt(12));

        User user = new User();
        user.setEmail(email);
        user.setUsername(username);
        user.setPasswordHash(hashedPass);
        user.setPhoneNumber(phoneNumber);
        user.setFullName(fullName);
        user.setBirthDay(birthday);
        user.setAdministrator(0);
        user.setActive(1);
        user.setCreatedAt(new Timestamp(System.currentTimeMillis()));

        return userDAO.create(user);
    }

    // unfinished
    public boolean startPasswordReset(String email) {
        if (email.contains("@")) {
            userDAO.findByEmail(email);
            return true;
        }
        return false;
    }

    // unfinished
    public boolean resetPassword(String email, String newPlainPassword) {
        if (startPasswordReset(email)) {
            String hashedPass = BCrypt.hashpw(newPlainPassword, BCrypt.gensalt(12));
            return userDAO.updatePassword(email, hashedPass);
        }
        return false;
    }
}
