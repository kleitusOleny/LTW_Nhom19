package services;

import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.gson.GsonFactory;
import dao.UserDAO;
import model.User;
import org.mindrot.jbcrypt.BCrypt;

import java.io.IOException;
import java.security.GeneralSecurityException;
import java.sql.Timestamp;
import java.util.Collections;

public class AuthService {
    private final UserDAO userDAO = new UserDAO();
    private static final String CLIENT_ID = "561993862196-rspl5j67m79f0857je2sdrv8f75m2ijs.apps.googleusercontent.com";

    public String getEmailFromGoogleToken(String idTokenString){
        try {
            GoogleIdTokenVerifier verifier = new GoogleIdTokenVerifier.Builder(new NetHttpTransport(), new GsonFactory())
                    .setAudience(Collections.singletonList(CLIENT_ID))
                    .build();

            GoogleIdToken idToken = verifier.verify(idTokenString);
            if (idToken != null) {
                GoogleIdToken.Payload payload = idToken.getPayload();
                System.out.println(payload.getEmail());
                return payload.getEmail();
            }
        } catch (GeneralSecurityException | IOException e) {
            throw new RuntimeException(e);
        }
        return null;
    }

    public String generateOtp(String email) {
        User user = userDAO.findByEmail(email);
        String otp = null;
        if (user != null) {
            otp = String.valueOf((int) (Math.random() * 900000) + 100000);
            System.out.println("User " + email + "has OTP: " + otp);
        }
        return otp;
    }

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

    public void register(String fullName, String email, String username, String plainPassword, String phoneNumber, Timestamp birthday) {
        if (userDAO.countUserId(email) > 0) return;
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

        userDAO.create(user);
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
