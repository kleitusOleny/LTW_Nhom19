package services;

import dao.UserDAO;
import org.mindrot.jbcrypt.BCrypt;

public class AuthService {
    private final UserDAO userDAO = new UserDAO();
}
