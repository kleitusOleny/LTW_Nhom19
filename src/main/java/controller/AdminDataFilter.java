package controller;

import dao.FeedbackDAO;
import dao.ProductDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;

import java.io.IOException;

@WebFilter(urlPatterns = {"/dashboard", "/account-manager", "/product-manager", "/manage-orders", "/banner-manager", "/manage-blog", "/manage-promotions"})
public class AdminDataFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        FeedbackDAO feedbackDAO = new FeedbackDAO();
        request.setAttribute("pendingList", feedbackDAO.getPendingFeedbacks());
        chain.doFilter(request, response);
    }
}
