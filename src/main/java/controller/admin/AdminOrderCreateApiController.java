package controller.admin;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import dao.OrderDAO;
import dao.OrderItemDAO;
import dao.PaymentDAO;
import dao.ShipOrderDAO;
import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Order;
import model.OrderItem;
import model.Payment;
import model.ShipOrder;
import model.User;

import java.io.BufferedReader;
import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "AdminOrderCreateApiController", value = "/admin/api/orders")
public class AdminOrderCreateApiController extends HttpServlet {

    private transient OrderDAO orderDAO;
    private transient OrderItemDAO orderItemDAO;
    private transient ShipOrderDAO shipOrderDAO;
    private transient PaymentDAO paymentDAO;
    private transient UserDAO userDAO;
    private transient Gson gson;

    @Override
    public void init() throws ServletException {
        orderDAO = new OrderDAO();
        orderItemDAO = new OrderItemDAO();
        shipOrderDAO = new ShipOrderDAO();
        paymentDAO = new PaymentDAO();
        userDAO = new UserDAO();
        gson = new GsonBuilder().serializeNulls().create();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try (BufferedReader reader = request.getReader()) {
            CreateOrderRequest payload = gson.fromJson(reader, CreateOrderRequest.class);
            if (payload == null || payload.items == null || payload.items.isEmpty()) {
                writeJson(response, HttpServletResponse.SC_BAD_REQUEST, Map.of("success", false, "message", "Danh sách sản phẩm không hợp lệ."));
                return;
            }

            double total = payload.items.stream()
                    .mapToDouble(item -> item.unitPrice * item.quantity)
                    .sum();

            int userId = resolveUserId(payload);
            int shippingAddressId = payload.addressId != null ? payload.addressId : 1;

            Order order = new Order();
            order.setUserId(userId);
            order.setShippingAddressId(shippingAddressId);
            order.setTotalPrice(total);
            order.setCreateAt(Timestamp.valueOf(LocalDateTime.now()));
            order.setUpdateAt(Timestamp.valueOf(LocalDateTime.now()));
            order.setDelete(false);
            order.setNote(payload.note);

            int orderId = orderDAO.createAndReturnId(order);

            for (CreateOrderRequest.Item item : payload.items) {
                OrderItem orderItem = new OrderItem();
                orderItem.setOrderId(orderId);
                orderItem.setProductId(item.productId);
                orderItem.setQuantity(item.quantity);
                orderItem.setUnitPrice(item.unitPrice);
                orderItemDAO.create(orderItem);
            }

            ShipOrder shipOrder = new ShipOrder();
            shipOrder.setOrderId(orderId);
            shipOrder.setCarrierName("Giao hàng nhanh");
            shipOrder.setShippingFee(payload.shippingFee != null ? payload.shippingFee : 0);
            shipOrder.setStatus(payload.shippingStatus != null ? payload.shippingStatus : "Chuẩn bị đơn hàng");
            shipOrder.setEstimatedDeliveryDate(Timestamp.valueOf(LocalDateTime.now().plusDays(3)));
            shipOrderDAO.create(shipOrder);

            Payment payment = new Payment();
            payment.setOrderId(orderId);
            payment.setPayStrategy(payload.paymentMethod != null ? payload.paymentMethod : "COD");
            payment.setStatus("Chưa thanh toán");
            payment.setAmount(total);
            paymentDAO.create(payment);

            writeJson(response, HttpServletResponse.SC_OK, Map.of(
                    "success", true,
                    "message", "Đã tạo đơn hàng thành công",
                    "orderId", orderId));
        } catch (Exception ex) {
            ex.printStackTrace();
            writeJson(response, HttpServletResponse.SC_INTERNAL_SERVER_ERROR, Map.of(
                    "success", false,
                    "message", "Không thể tạo đơn hàng: " + ex.getMessage()));
        }
    }

    private int resolveUserId(CreateOrderRequest payload) {
        if (payload.userId != null) {
            return payload.userId;
        }
        User found = null;
        if (payload.customerEmail != null && !payload.customerEmail.isBlank()) {
            found = userDAO.findByEmail(payload.customerEmail.trim());
        }
        if (found == null && payload.customerPhone != null && !payload.customerPhone.isBlank()) {
            found = userDAO.findByPhoneNumber(payload.customerPhone.trim());
        }
        return found != null ? found.getId() : 1;
    }

    private void writeJson(HttpServletResponse response, int status, Map<String, ?> payload) throws IOException {
        response.setStatus(status);
        gson.toJson(payload, response.getWriter());
    }

    private static class CreateOrderRequest {
        String customerName;
        String customerPhone;
        String customerEmail;
        String customerAddress;
        String note;
        String paymentMethod;
        String shippingStatus;
        Double shippingFee;
        Integer userId;
        Integer addressId;
        List<Item> items;

        private static class Item {
            String productId;
            int quantity;
            double unitPrice;
        }
    }
}
