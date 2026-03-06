package controller;

import dao.OrderDAO;
import model.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "OrderController", value = "/orders")
public class OrderController extends HttpServlet {
    private OrderDAO orderDAO;

    @Override
    public void init() {
        orderDAO = new OrderDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(true);
        User user = (User) session.getAttribute("user");
        if (user == null) {
            String requestedWith = request.getHeader("X-Requested-With");
            if ("XMLHttpRequest".equals(requestedWith)) {
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                response.getWriter().write("{\"error\":\"not_authenticated\"}");
                return;
            }
            response.sendRedirect(request.getContextPath() + "login");
            return;
        }

        List<Order> orders = orderDAO.getByUserId(user.getId());

        dao.ShipOrderDAO shipOrderDAO = new dao.ShipOrderDAO();
        dao.PaymentDAO paymentDAO = new dao.PaymentDAO();
        java.util.Map<Integer, ShipOrder> shipOrderMap = new java.util.HashMap<>();
        java.util.Map<Integer, Payment> paymentMap = new java.util.HashMap<>();

        for (Order order : orders) {
            ShipOrder shipOrder = shipOrderDAO.getByOrderId(order.getId());
            if (shipOrder != null) {
                shipOrderMap.put(order.getId(), shipOrder);
            }

            Payment payment = paymentDAO.findByOrderId(order.getId());
            if (payment != null) {
                paymentMap.put(order.getId(), payment);
            }
        }

        request.setAttribute("orders", orders);
        request.setAttribute("shipOrderMap", shipOrderMap);
        request.setAttribute("paymentMap", paymentMap);
        request.getRequestDispatcher("infoUsers/my_orders.jsp").forward(request, response);
    }
}
