package services;

import dao.UserDAO;
import model.User;
import org.mindrot.jbcrypt.BCrypt;

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

    public boolean register(User newUser) {
        int count = userDAO.countUserId(newUser.getEmail());
        if (count > 0) return false;

        String plainPass = newUser.getPasswordHash();
        String hashedPass = BCrypt.hashpw(plainPass, BCrypt.gensalt(12));

        newUser.setEmail(newUser.getEmail());
        newUser.setUsername(newUser.getUsername() != null ? newUser.getUsername() : null);
        newUser.setPasswordHash(hashedPass);
        newUser.setPhoneNumber(newUser.getPhoneNumber());
        newUser.setFullName(newUser.getFullName());
        newUser.setBirthDay(newUser.getBirthDay());
        newUser.setAdministrator(0);
        newUser.setActive(1);
        newUser.setCreatedAt(new Timestamp(System.currentTimeMillis()));

        return userDAO.create(newUser);
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
