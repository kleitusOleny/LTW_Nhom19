package controller;

import dao.CTEvaluateDAO;
import dao.EvaluateDAO;
import dao.OrderDAO;
import dao.OrderItemDAO;
import dao.ProductDAO;
import model.CTEvaluates;
import model.Evaluates;
import model.Order;
import model.OrderItem;
import model.Product;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "EvaluateController", value = "/evaluate")
public class EvaluateController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        String orderIdStr = request.getParameter("orderId");
        if (orderIdStr == null) {
            response.sendRedirect("orders");
            return;
        }

        try {
            int orderId = Integer.parseInt(orderIdStr);
            OrderDAO orderDAO = new OrderDAO();
            Order order = orderDAO.findById(orderId);

            if (order == null || order.getUserId() != user.getId()) {
                response.sendRedirect("orders");
                return;
            }

            OrderItemDAO orderItemDAO = new OrderItemDAO();
            List<OrderItem> items = orderItemDAO.getByOrderId(orderId);

            ProductDAO productDAO = new ProductDAO();
            Map<String, Product> productMap = new HashMap<>();
            for (OrderItem item : items) {
                Product p = productDAO.getProductById(item.getProductId());
                if (p != null) {
                    productMap.put(item.getProductId(), p);
                }
            }

            request.setAttribute("order", order);
            request.setAttribute("items", items);
            request.setAttribute("productMap", productMap);
            request.getRequestDispatcher("infoUsers/evaluate.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect("orders");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        String productId = request.getParameter("productId");
        String ratingStr = request.getParameter("rating");
        String content = request.getParameter("content");
        String orderId = request.getParameter("orderId");

        if (productId != null && ratingStr != null) {
            try {
                double star = Double.parseDouble(ratingStr);

                CTEvaluateDAO ctEvaluateDAO = new CTEvaluateDAO();
                CTEvaluates ctEvaluates = new CTEvaluates();
                ctEvaluates.setContent(content);
                ctEvaluates.setStar(star);
                ctEvaluates.setCreateAt(java.time.LocalDateTime.now());
                ctEvaluates.setUpdateAt(java.time.LocalDateTime.now());
                ctEvaluates.setIsDelete(null);

                int evaluateId = ctEvaluateDAO.createAndReturnId(ctEvaluates);

                EvaluateDAO evaluateDAO = new EvaluateDAO();
                Evaluates evaluates = new Evaluates();
                evaluates.setId(productId);
                evaluates.setUserId(user.getId());
                evaluates.setEvaluatesId(evaluateId);

                evaluateDAO.create(evaluates);

            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        // Redirect back to evaluate page or order list
        if (orderId != null) {
            response.sendRedirect("evaluate?orderId=" + orderId + "&success=true");
        } else {
            response.sendRedirect("orders");
        }
    }
}
