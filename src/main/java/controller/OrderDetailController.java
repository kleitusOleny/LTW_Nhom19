package controller;

import dao.*;
import model.*;
import services.ProductService;
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

@WebServlet(name = "OrderDetailController", value = "/order-detail")
public class OrderDetailController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        String orderIdStr = request.getParameter("id");
        if (orderIdStr == null || orderIdStr.isEmpty()) {
            response.sendRedirect("orders");
            return;
        }

        try {
            int orderId = Integer.parseInt(orderIdStr);
            OrderDAO orderDAO = new OrderDAO();
            Order order = orderDAO.findById(orderId);

            if (order == null) {
                response.sendRedirect("orders");
                return;
            }

            if (order.getUserId() != user.getId()) {
                response.sendRedirect("orders");
                return;
            }

            OrderItemDAO orderItemDAO = new OrderItemDAO();
            List<OrderItem> items = orderItemDAO.getByOrderId(orderId);
            order.setItems(items);

            ProductService productService = new ProductService();
            Map<String, Product> productMap = new HashMap<>();
            for (OrderItem item : items) {
                Product product = productService.getProduct(item.getProductId());
                if (product == null) {
                } else {
                    productMap.put(item.getProductId(), product);
                }
            }

            request.setAttribute("order", order);
            request.setAttribute("productMap", productMap);

            AddressDAO addressDAO = new AddressDAO();
            Address shippingAddress = addressDAO.getById(order.getShippingAddressId());
            request.setAttribute("shippingAddress", shippingAddress);

            PaymentDAO paymentDAO = new PaymentDAO();
           Payment payment = paymentDAO.findByOrderId(orderId);
            request.setAttribute("payment", payment);

            ShipOrderDAO shipOrderDAO = new ShipOrderDAO();
            ShipOrder shipOrder = shipOrderDAO.getByOrderId(orderId);
            request.setAttribute("shipOrder", shipOrder);

            request.getRequestDispatcher("infoUsers/detail_order.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect("orders");
        } catch (Exception e) {
            e.printStackTrace();
            throw e; // Re-throw to let container handle 500
        }
    }
}
