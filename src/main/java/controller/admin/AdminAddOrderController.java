package controller.admin;

import dao.OrderDAO;
import dao.ShipOrderDAO;
import model.Order;
import model.ShipOrder;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDateTime;

@WebServlet(name = "AdminAddOrderController", value = "/admin/add-order")
public class AdminAddOrderController extends HttpServlet {
    private OrderDAO orderDAO;
    private ShipOrderDAO shipOrderDAO;

    @Override
    public void init() {
        orderDAO = new OrderDAO();
        shipOrderDAO = new ShipOrderDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        try {
            String customerEmail = request.getParameter("customerEmail");
            int userId = 1; // Default to admin/dummy user

            dao.UserDAO userDAO = new dao.UserDAO();
            model.User user = userDAO.findByEmail(customerEmail);
            if (user != null) {
                userId = user.getId();
            }

            String dateStr = request.getParameter("date");
            String totalStr = request.getParameter("total");
            String status = request.getParameter("status");

            double total = 0;
            try {
                total = Double.parseDouble(totalStr.replaceAll("[^0-9.]", ""));
            } catch (NumberFormatException e) {
                total = 0;
            }

            Order order = new Order();
            order.setUserId(userId);
            order.setTotalPrice(total);
            order.setCreateAt(Timestamp.valueOf(dateStr + " 00:00:00"));
            order.setUpdateAt(Timestamp.valueOf(LocalDateTime.now()));
            order.setDelete(false);
            // Set other required fields to defaults
            order.setShippingAddressId(1); // Default

            int orderId = orderDAO.createAndReturnId(order);

            if (orderId > 0) {
                ShipOrder shipOrder = new ShipOrder();
                shipOrder.setOrderId(orderId);
                shipOrder.setStatus(status);
                shipOrder.setCarrierName("Giao hàng nhanh"); // Default
                shipOrder.setShippingFee(0);
                shipOrder.setEstimatedDeliveryDate(Timestamp.valueOf(LocalDateTime.now().plusDays(3)));

                shipOrderDAO.create(shipOrder);
            }

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("{\"success\": true, \"message\": \"Thêm đơn hàng thành công!\"}");
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter()
                    .write("{\"success\": false, \"message\": \"Lỗi khi thêm đơn hàng: " + e.getMessage() + "\"}");
        }
    }
}
