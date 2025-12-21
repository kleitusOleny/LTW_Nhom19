package services;

import dao.UserDAO;
import model.User;
import org.mindrot.jbcrypt.BCrypt;

import java.sql.Date;
import java.sql.Timestamp;

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

    public boolean register(String fullName, String email, String username, String plainPassword, String phoneNumber, Date birthday) {
        if (userDAO.countUserId(email) > 0) return false;
        String hashedPass = BCrypt.hashpw(plainPassword, BCrypt.gensalt(12));

        User user = new User();
        user.setEmail(user.getEmail());
        user.setUsername(user.getUsername() != null ? user.getUsername() : null);
        user.setPasswordHash(hashedPass);
        user.setPhoneNumber(user.getPhoneNumber());
        user.setFullName(user.getFullName());
        user.setBirthDay(user.getBirthDay());
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
