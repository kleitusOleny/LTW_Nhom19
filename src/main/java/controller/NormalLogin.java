package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Cart;
import model.User;
import services.AuthService;
import services.UserValidationServices;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "NormalLogin", value = "/login")
public class NormalLogin extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/AuthPages/Login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String pass = request.getParameter("password");
        UserValidationServices userValidationServices = new UserValidationServices();

        Map<String, String> allErrors = new HashMap<>(
                userValidationServices.validateBothUsernameAndEmail(username, pass));

        User account;
        AuthService authService = new AuthService();
        if (allErrors.isEmpty()) {
            account = authService.login(username, pass);
            if (account != null) {
                if (account.getActive() == 1) {
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
                    session.setAttribute("user", account);

                    if (cart != null)
                        session.setAttribute("cart", cart);
                    if (buyNowCart != null)
                        session.setAttribute("buyNowCart", buyNowCart);
                    if (checkoutType != null)
                        session.setAttribute("checkoutType", checkoutType);

                    String redirect = request.getParameter("redirect");
                    if (account.getAdministrator() == 1) {
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
                request.setAttribute("loginError", "Bạn đã nhập sai tên tài khoản hoặc mật khẩu");
                request.getRequestDispatcher("/AuthPages/Login.jsp").forward(request, response);
            }
        } else {
            allErrors.forEach(request::setAttribute);
            request.getRequestDispatcher("/AuthPages/Login.jsp").forward(request, response);
        }
    }
}