package services;

import dao.UserDAO;
import model.User;
import org.mindrot.jbcrypt.BCrypt;

import java.time.LocalDateTime;
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
}
