package controller;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Cart;
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
                HttpSession oldSession = request.getSession(false);
                Cart cart = null;
                Cart buyNowCart = null;
                String checkoutType = null;

                if (oldSession != null) {
                    cart = (Cart) oldSession.getAttribute("cart");
                    buyNowCart = (Cart) oldSession.getAttribute("buyNowCart");
                    checkoutType = (String) oldSession.getAttribute("checkoutType");
                    oldSession.invalidate();
                }
                HttpSession session = request.getSession(true);
                session.setAttribute("user", user);

                if (cart != null)
                    session.setAttribute("cart", cart);
                if (buyNowCart != null)
                    session.setAttribute("buyNowCart", buyNowCart);
                if (checkoutType != null)
                    session.setAttribute("checkoutType", checkoutType);

                String redirect = request.getParameter("redirect");
                if (user.getAdministrator() == 1) {
                    response.sendRedirect("dashboard");
                } else if (redirect != null && !redirect.isEmpty()) {
                    if ("checkout".equals(redirect)) {
                        if ("buyNow".equals(checkoutType)) {
                            response.sendRedirect("checkout?from=buyNow");
                        } else {
                            response.sendRedirect("checkout");
                        }
                    } else {
                        response.sendRedirect(redirect);
                    }
                } else {
                    response.sendRedirect(request.getContextPath() + "/home?loginSuccess=1");
                }
            } else {
                request.setAttribute("loginError",
                        "Tài khoản của bạn đã bị khoá, vui lòng liên hệ Admin để giải quyết");
                request.getRequestDispatcher("/AuthPages/Login.jsp").forward(request, response);
            }
        } else {
            System.out.println("Token: " + idTokenString);
            request.getSession().setAttribute("googleEmail", emailFromGoogleToken);
            response.sendRedirect(request.getContextPath() + "/onboarding");
        }
    }
}