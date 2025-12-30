package services;

import dao.UserDAO;
import model.User;
import org.mindrot.jbcrypt.BCrypt;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class AccountManagerService {
    UserDAO userDAO = new UserDAO();

    public boolean addAccount(String email, String plainPassword) {
        if (userDAO.countUserId(email) > 0) return false;
        String hashedPass = BCrypt.hashpw(plainPassword, BCrypt.gensalt(12));

        User user = new User();
        user.setEmail(email);
        user.setUsername(null);
        user.setPasswordHash(hashedPass);
        user.setPhoneNumber(null);
        user.setFullName(null);
        user.setBirthDay(null);
        user.setAdministrator(0);
        user.setActive(1);
        user.setCreatedAt(new Timestamp(System.currentTimeMillis()));
        return userDAO.create(user);
    }

    public void updateAccount(String id, String email, String plainPassword, String fullName, String birth, String username, String phoneNumber, String isActive, String isAdministrator) throws ParseException {
        User searchEntity = new User();
        searchEntity.setId(Integer.parseInt(id));
        User currentUser = userDAO.findById(searchEntity);

        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date parsedDate = dateFormat.parse(birth);
        java.sql.Timestamp birthTimestamp = new java.sql.Timestamp(parsedDate.getTime());

        if (currentUser != null) {
            currentUser.setEmail(email);
            if (plainPassword != null) {
                String hashedPass = BCrypt.hashpw(plainPassword, BCrypt.gensalt(12));
                currentUser.setPasswordHash(hashedPass);
            }
            currentUser.setFullName(fullName);
            currentUser.setBirthDay(birthTimestamp);
            currentUser.setUsername(username);
            currentUser.setPhoneNumber(phoneNumber);
            currentUser.setActive(Integer.parseInt(isActive));
            currentUser.setAdministrator(Integer.parseInt(isAdministrator));
            currentUser.setUpdateAt(new Timestamp(System.currentTimeMillis()));
            userDAO.update(currentUser);
        }
    }

    public boolean blockAccount(User user, String presentStatus) {
        if (presentStatus.equals("Khoá")) {
            User currentUser = userDAO.findById(user);
            if (currentUser.getId() == user.getId()) {
                currentUser.setActive(0);
                int isActive = currentUser.getActive();
                return userDAO.updateActive(currentUser.getId(), isActive);
            }
        }
        return false;
    }

    public boolean unlockAccount(User user, String presentStatus) {
        if (presentStatus.equals("Mở")) {
            User currentUser = userDAO.findById(user);
            if (currentUser.getId() == user.getId()) {
                currentUser.setActive(1);
                int isActive = currentUser.getActive();
                return userDAO.updateActive(currentUser.getId(), isActive);
            }
        }
        return false;
    }
}
