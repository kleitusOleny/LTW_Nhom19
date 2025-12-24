package controller;

import dao.UserDAO;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;
import services.AuthService;

import java.io.IOException;

@WebServlet("/LoginGoogle")
public class LoginGoogle extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        // Google gửi mã xác thực qua tham số "credential"
        String idTokenString = request.getParameter("credential");
        AuthService authService = new AuthService();
        String emailFromGoogleToken = authService.getEmailFromGoogleToken(idTokenString);

        UserDAO userDao = new UserDAO();
        User user = userDao.findByEmail(emailFromGoogleToken);
        if (user != null) {
            request.getSession().setAttribute("user", user);
            response.sendRedirect(request.getContextPath() + "/index.jsp?loginSuccess");
        } else {
            System.out.println("Token: " + idTokenString);
            request.getSession().setAttribute("googleEmail", emailFromGoogleToken);
            response.sendRedirect(request.getContextPath() + "/AuthPages/OnBoarding.jsp");
        }
    }
}