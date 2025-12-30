package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

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
    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        HttpSession session = request.getSession(false);
        String path = request.getServletPath();

        boolean isProtected = false;
        for (String protectedUrl : PROTECTED_AUTH_URLS){
            if (path.startsWith(protectedUrl)) {
                isProtected = true;
                break;
            }
        }

        boolean loggedIn = (session != null && session.getAttribute("user") != null);
        if (loggedIn && isProtected) {
            // Nếu đã đăng nhập mà còn cố vào trong list PROTECTED_AUTH_URLS
            response.sendRedirect(request.getContextPath());
            return;
        }
        filterChain.doFilter(request, response);
    }
}