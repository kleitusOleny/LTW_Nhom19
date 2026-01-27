package controller;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;
import services.AuthService;

import java.io.IOException;

@WebServlet("/LoginGoogle")
public class LoginGoogle extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        // Google gửi mã xác thực qua tham số "credential"
        String idTokenString = request.getParameter("credential");
        AuthService authService = new AuthService();
        String emailFromGoogleToken = authService.getEmailFromGoogleToken(idTokenString);

        UserDAO userDao = new UserDAO();
        User user = userDao.findByEmail(emailFromGoogleToken);
        if (user != null) {
            if (user.getActive() == 1) {
                // Session Fixation
                HttpSession oldSession = request.getSession(false);
                if (oldSession != null) {
                    oldSession.invalidate();
                }
                HttpSession session = request.getSession(true);
                session.setAttribute("user", user);
                // ---
                if (user.getAdministrator() == 1) {
                    response.sendRedirect(request.getContextPath() + "/dashboard");
                } else {
                    response.sendRedirect(request.getContextPath() + "/index.jsp?loginSuccess");
                }
            } else {
                request.setAttribute("loginError", "Tài khoản của bạn đã bị khoá, vui lòng liên hệ Admin để giải quyết");
                request.getRequestDispatcher("/AuthPages/Login.jsp").forward(request, response);
            }
        } else {
            System.out.println("Token: " + idTokenString);
            request.getSession().setAttribute("googleEmail", emailFromGoogleToken);
            response.sendRedirect(request.getContextPath() + "/onboarding");
        }
    }
}