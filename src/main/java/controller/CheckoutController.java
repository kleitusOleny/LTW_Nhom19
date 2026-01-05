package controller;

import dao.OrderDAO;
import dao.OrderItemDAO;
import dao.AddressDAO;
import dao.PaymentDAO;
import model.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "CheckoutController", value = "/checkout")
public class CheckoutController extends HttpServlet {
    private OrderDAO orderDAO;
    private OrderItemDAO orderItemDAO;
    private dao.ProductDAO productDAO;

    @Override
    public void init() {
        orderDAO = new OrderDAO();
        orderItemDAO = new OrderItemDAO();
        productDAO = new dao.ProductDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");
        Cart cart;
        String from = request.getParameter("from");
        if ("buyNow".equals(from)) {
            cart = (Cart) session.getAttribute("buyNowCart");
            session.setAttribute("checkoutType", "buyNow");
        } else {
            cart = (Cart) session.getAttribute("cart");
            session.setAttribute("checkoutType", "cart");
        }

        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        if (cart == null || cart.getItems().isEmpty()) {
            response.sendRedirect("store");
            return;
        }

        AddressDAO addressDAO = new AddressDAO();
        List<Address> addresses = addressDAO.getByUserID(user.getId());

        if (addresses.isEmpty()) {
            response.sendRedirect("address");
            return;
        }

        Address shippingAddress = addresses.stream()
                .filter(Address::isDefault)
                .findFirst()
                .orElse(addresses.get(0));

        Order order = new Order();
        order.setUserId(user.getId());
        order.setTotalPrice(cart.getTotal());
        order.setCreateAt(new Timestamp(System.currentTimeMillis()));
        order.setUpdateAt(new Timestamp(System.currentTimeMillis()));
        order.setDelete(false);
        order.setShippingAddressId(shippingAddress.getId());

        List<OrderItem> items = new ArrayList<>();
        Map<String, Product> productMap = new HashMap<>();

        for (CartItem ci : cart.getItems()) {
            OrderItem oi = new OrderItem();
            oi.setProductId(ci.getProduct().getId());
            oi.setQuantity(ci.getQuantity());
            oi.setUnitPrice(ci.getPrice());

            items.add(oi);
            productMap.put(ci.getProduct().getId(), ci.getProduct());
        }

        order.setItems(items);

        session.setAttribute("pendingOrder", order);

        request.setAttribute("order", order);
        request.setAttribute("shippingAddress", shippingAddress);
        request.setAttribute("productMap", productMap);
        request.getRequestDispatcher("payment.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        Order order = (Order) session.getAttribute("pendingOrder");

        if (user == null || order == null) {
            response.sendRedirect("store");
            return;
        }

        try {
            order.setNote(request.getParameter("notes"));
            order.setUpdateAt(new Timestamp(System.currentTimeMillis()));

            for (OrderItem item : order.getItems()) {
                int currentStock = productDAO.getQuantity(item.getProductId());
                if (currentStock < item.getQuantity()) {
                    String productName = productDAO.getProductById(item.getProductId()).getProductName();
                    session.setAttribute("errorMessage", "Sản phẩm '" + productName
                            + "' không đủ số lượng trong kho (Còn lại: " + currentStock + ")");
                    String checkoutType = (String) session.getAttribute("checkoutType");
                    if ("buyNow".equals(checkoutType)) {
                        response.sendRedirect("checkout?from=buyNow");
                    } else {
                        response.sendRedirect("checkout");
                    }
                    return;
                }
            }

            int orderId = orderDAO.createAndReturnId(order);
            order.setId(orderId);

            for (OrderItem item : order.getItems()) {
                item.setOrderId(orderId);
                orderItemDAO.create(item);

                int currentStock = productDAO.getQuantity(item.getProductId());
                productDAO.updateQuantity(item.getProductId(), currentStock - item.getQuantity());
            }
            String paymentMethod = request.getParameter("payment_method");

            PaymentDAO paymentDAO = new PaymentDAO();
            Payment payment = new Payment();
            payment.setOrderId(orderId);
            payment.setAmount(order.getTotalPrice());
            payment.setPaidAt(new Timestamp(System.currentTimeMillis()));

            String checkoutType = (String) session.getAttribute("checkoutType");

            if ("ewallet".equals(paymentMethod)) {
                payment.setPayStrategy("VNPay");
                payment.setStatus("Pending");
                paymentDAO.create(payment);

                if ("buyNow".equals(checkoutType)) {
                    session.removeAttribute("buyNowCart");
                } else {
                    session.removeAttribute("cart");
                }
                session.removeAttribute("pendingOrder");
                session.removeAttribute("checkoutType");
                response.sendRedirect("payment?orderId=" + orderId);
            } else {
                payment.setPayStrategy("COD");
                payment.setStatus("Pending");
                paymentDAO.create(payment);

                dao.ShipOrderDAO shipOrderDAO = new dao.ShipOrderDAO();
                model.ShipOrder shipOrder = new model.ShipOrder();
                shipOrder.setOrderId(orderId);
                shipOrder.setCarrierName("Giao hàng tiêu chuẩn");
                shipOrder.setTrackingNumber("COD" + System.currentTimeMillis());
                shipOrder.setShippingFee(java.math.BigDecimal.ZERO);
                shipOrder.setStatus("Chuẩn bị đơn hàng");
                shipOrder.setEstimatedDeliveryDate(new Timestamp(System.currentTimeMillis() + 3 * 24 * 60 * 60 * 1000));
                shipOrderDAO.create(shipOrder);

                if ("buyNow".equals(checkoutType)) {
                    session.removeAttribute("buyNowCart");
                } else {
                    session.removeAttribute("cart");
                }
                session.removeAttribute("pendingOrder");
                session.removeAttribute("checkoutType");
                response.sendRedirect("order-success?orderId=" + orderId);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, "Không thể đặt hàng");
        }
    }
}
