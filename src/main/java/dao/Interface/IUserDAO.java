package dao.Interface;

import dao.IDAO;
import model.User;

public interface IUserDAO extends IDAO<User> {
    boolean updateActiveStatus(User entity);
    User findByEmail(String email);
    User findByUsername(String username);
    boolean updatePassword(String email, String newPasswordHashed);
    int countUserId(String email);
}
