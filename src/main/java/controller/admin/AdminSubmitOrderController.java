package controller.admin;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import dao.OrderDAO;
import dao.OrderItemDAO;
import dao.ShipOrderDAO;
import dao.AddressDAO;
import dao.UserDAO;
import model.Order;
import model.OrderItem;
import model.ShipOrder;
import model.Address;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

@WebServlet(name = "AdminSubmitOrderController", value = "/admin/submit-order")
public class AdminSubmitOrderController extends HttpServlet {
    private OrderDAO orderDAO;
    private OrderItemDAO orderItemDAO;
    private ShipOrderDAO shipOrderDAO;
    private AddressDAO addressDAO;
    private UserDAO userDAO;
    private Gson gson;

    @Override
    public void init() {
        orderDAO = new OrderDAO();
        orderItemDAO = new OrderItemDAO();
        shipOrderDAO = new ShipOrderDAO();
        addressDAO = new AddressDAO();
        userDAO = new UserDAO();
        gson = new Gson();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        try {
            // Lấy thông tin khách hàng
            String customerName = request.getParameter("customerName");
            String customerPhone = request.getParameter("customerPhone");
            String customerEmail = request.getParameter("customerEmail");
            String customerAddress = request.getParameter("customerAddress");
            String orderNote = request.getParameter("orderNote");
            String paymentMethod = request.getParameter("paymentMethod");
            String cartDataJson = request.getParameter("cartData");

            // Validate
            if (customerName == null || customerName.trim().isEmpty() ||
                    customerPhone == null || customerPhone.trim().isEmpty() ||
                    customerAddress == null || customerAddress.trim().isEmpty()) {
                request.getSession().setAttribute("errorMessage", "Vui lòng điền đầy đủ thông tin khách hàng!");
                response.sendRedirect(request.getContextPath() + "/admin/create-order");
                return;
            }

            if (cartDataJson == null || cartDataJson.trim().isEmpty() || "[]".equals(cartDataJson.trim())) {
                request.getSession().setAttribute("errorMessage", "Vui lòng chọn ít nhất một sản phẩm!");
                response.sendRedirect(request.getContextPath() + "/admin/create-order");
                return;
            }

            // Parse cart data
            List<Map<String, Object>> cartItems = gson.fromJson(cartDataJson,
                    new TypeToken<List<Map<String, Object>>>() {
                    }.getType());

            if (cartItems == null || cartItems.isEmpty()) {
                request.getSession().setAttribute("errorMessage", "Giỏ hàng trống!");
                response.sendRedirect(request.getContextPath() + "/admin/create-order");
                return;
            }

            // Tìm hoặc tạo user dựa trên email/phone
            int userId = 1; // Default guest user
            if (customerEmail != null && !customerEmail.trim().isEmpty()) {
                User existingUser = userDAO.findByEmail(customerEmail.trim());
                if (existingUser != null) {
                    userId = existingUser.getId();
                }
            }

            // Tạo địa chỉ giao hàng
            Address address = new Address();
            address.setUserId(userId);
            address.setFullName(customerName.trim());
            address.setPhoneNumber(customerPhone.trim());
            address.setAddressLine(customerAddress.trim());
            address.setCity(""); // Có thể parse từ địa chỉ nếu cần
            address.setWard("");
            address.setDefault(false);

            addressDAO.create(address);
            // Lấy ID địa chỉ vừa tạo
            List<Address> userAddresses = addressDAO.getByUserID(userId);
            int addressId = userAddresses.isEmpty() ? 1 : userAddresses.get(userAddresses.size() - 1).getId();

            // Tính tổng tiền
            double totalPrice = 0;
            for (Map<String, Object> item : cartItems) {
                double unitPrice = ((Number) item.get("unitPrice")).doubleValue();
                int quantity = ((Number) item.get("quantity")).intValue();
                totalPrice += unitPrice * quantity;
            }

            // Tạo đơn hàng
            Order order = new Order();
            order.setUserId(userId);
            order.setShippingAddressId(addressId);
            order.setTotalPrice(totalPrice);
            order.setCreateAt(Timestamp.valueOf(LocalDateTime.now()));
            order.setUpdateAt(Timestamp.valueOf(LocalDateTime.now()));
            order.setDelete(false);

            // Lưu email khách hàng vào note với prefix EMAIL:
            // và ghi chú đơn hàng (nếu có)
            String noteContent = "";
            if (customerEmail != null && !customerEmail.trim().isEmpty()) {
                noteContent = "EMAIL:" + customerEmail.trim();
            }
            if (orderNote != null && !orderNote.trim().isEmpty()) {
                if (!noteContent.isEmpty()) {
                    noteContent += " | Ghi chú: " + orderNote.trim();
                } else {
                    noteContent = orderNote.trim();
                }
            }
            order.setNote(noteContent);

            int orderId = orderDAO.createAndReturnId(order);

            if (orderId > 0) {
                // Tạo các order items
                for (Map<String, Object> item : cartItems) {
                    String productId = (String) item.get("productId");
                    double unitPrice = ((Number) item.get("unitPrice")).doubleValue();
                    int quantity = ((Number) item.get("quantity")).intValue();

                    OrderItem orderItem = new OrderItem();
                    orderItem.setOrderId(orderId);
                    orderItem.setProductId(productId);
                    orderItem.setQuantity(quantity);
                    orderItem.setUnitPrice(unitPrice);

                    orderItemDAO.create(orderItem);
                }

                // Tạo thông tin vận chuyển
                ShipOrder shipOrder = new ShipOrder();
                shipOrder.setOrderId(orderId);
                shipOrder.setStatus("Chờ xác nhận");
                shipOrder.setCarrierName("Giao hàng nhanh");
                shipOrder.setShippingFee(0);
                shipOrder.setEstimatedDeliveryDate(Timestamp.valueOf(LocalDateTime.now().plusDays(3)));

                shipOrderDAO.create(shipOrder);

                request.getSession().setAttribute("successMessage",
                        "Tạo đơn hàng #" + orderId + " thành công!");
                response.sendRedirect(request.getContextPath() + "/admin/manage-orders");
            } else {
                throw new Exception("Không thể tạo đơn hàng");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage",
                    "Có lỗi xảy ra khi tạo đơn hàng: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin/create-order");
        }
    }
}
