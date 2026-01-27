package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.User;

import java.io.IOException;

@jakarta.servlet.annotation.WebFilter("/*")
public class WebFilter implements Filter {
    private static final String[] PROTECTED_AUTH_URLS = {
            "/login",
            "/register",
            "/authentication",
            "/forgotpassword",
            "/onboarding"
    };
    private static final String[] PROTECTED_ADMIN_URLS = {
            "/dashboard",
            "/account-manager",
            "/product-manager",
            "/banner-manager",
            "/manage-blog",
            "/manage-orders",
            "/manage-promotions"
    };
    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;

        String uri = request.getRequestURI();
        String contextPath = request.getContextPath();
        String path = uri.substring(contextPath.length());
        if (path.matches(".*\\.(css|js|png|jpg|jpeg|gif|svg|ico|woff|woff2|ttf|eot|mp4|webp)$")) {
            filterChain.doFilter(request, response);
            return;
        }

        HttpSession session = request.getSession(false);

        boolean isProtected = false;
        boolean isAdminPath = false;
        for (String protectedUrl : PROTECTED_AUTH_URLS) {
            if (path.startsWith(protectedUrl)) {
                isProtected = true;
                break;
            }
        }

        for (String adminUrl : PROTECTED_ADMIN_URLS) {
            if (path.startsWith(adminUrl)) {
                isAdminPath = true;
                break;
            }
        }

        boolean loggedIn = (session != null && session.getAttribute("user") != null);
        if (loggedIn && isProtected) {
            // Nếu đã đăng nhập mà còn cố vào trong list PROTECTED_AUTH_URLS
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (isAdminPath && (user == null || user.getAdministrator() == 0)) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
        filterChain.doFilter(request, response);
    }
}