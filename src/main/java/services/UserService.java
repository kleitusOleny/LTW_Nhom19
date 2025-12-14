package services;

import dao.UserDAO;
import model.User;
import org.mindrot.jbcrypt.BCrypt;

public class UserService {
    private final UserDAO userDAO = new UserDAO();

    private boolean safeCheck(User currentUser, User newUser) {
        if (currentUser == null) return false;
        if (currentUser.getEmail().equals(newUser.getEmail())) return false;
        return true;
    }

    public boolean updateProfile(User newUser) {
        User currentUser = userDAO.findById(newUser);

        if (safeCheck(currentUser, newUser)) {
            currentUser.setUsername(newUser.getUsername());
            currentUser.setEmail(newUser.getEmail());
            currentUser.setActive(newUser.getActive());
            currentUser.setBirthDay(newUser.getBirthDay());
            currentUser.setPhoneNumber(newUser.getPhoneNumber());
        }

        return userDAO.update(currentUser);
    }

    public boolean blockAccount(User newUser) {
        User currentUser = userDAO.findById(newUser);

        if (safeCheck(currentUser, newUser)){
            currentUser.setActive(newUser.getActive());
        }

        return userDAO.updateActiveStatus(currentUser);
    }

    public boolean addAccount(User newUser) {
        int count = userDAO.countUserId(newUser.getEmail());
        if (count > 0) return false;

        String plainPass = newUser.getPasswordHash();
        String hashedPass = BCrypt.hashpw(plainPass, BCrypt.gensalt(12));

        newUser.setPasswordHash(hashedPass);
        newUser.setEmail(newUser.getEmail());
        newUser.setUsername(null);
        newUser.setPhoneNumber("");
        newUser.setAdministrator(0);
        newUser.setActive(1);
        newUser.setBirthDay(null);

        return userDAO.create(newUser);
    }
}
