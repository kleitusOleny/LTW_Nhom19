package controller.cart;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Cart;
import model.CartItem;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal; // Import BigDecimal

@WebServlet(name = "UpdateItem", value = "/update-item")
public class UpdateItem extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Cart cart = (Cart) request.getSession().getAttribute("cart");
        
        if (cart == null) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        
        String id = request.getParameter("id");
        String setQuantityStr = request.getParameter("setQuantity");
        String quantityStr = request.getParameter("quantity");
        
        // Logic update giỏ hàng
        if (setQuantityStr != null) {
            try {
                cart.updateItem(id, Integer.parseInt(setQuantityStr));
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        } else if (quantityStr != null) {
            try {
                int quantity = Integer.parseInt(quantityStr);
                cart.updateQuantity(id, quantity);
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }
        
        // Tính toán lại subtotal cho item vừa update
        BigDecimal itemSubtotal = BigDecimal.ZERO;
        int newQuantity = 0;
        
        // Cần duyệt danh sách để tìm đúng item và lấy giá trị mới nhất
        for (CartItem item : cart.getItems()) {
            if (item.getProduct().getId().equals(id)) {
                // getPrice() là BigDecimal, quantity là int
                // subtotal = price * quantity
                itemSubtotal = item.getProduct().getPrice().multiply(BigDecimal.valueOf(item.getQuantity()));
                newQuantity = item.getQuantity();
                break;
            }
        }
        
        // Lấy tổng giỏ hàng (Giả định cart.getTotal() cũng trả về BigDecimal hoặc double)
        // Nếu cart.getTotal() trả về double, bạn dùng new BigDecimal(cart.getTotal())
        // Nếu cart.getTotal() trả về BigDecimal, dùng trực tiếp.
        // Ở đây mình viết an toàn cho cả hai trường hợp bằng cách ép sang String rồi tạo BigDecimal
        BigDecimal cartTotal = new BigDecimal(String.valueOf(cart.getTotal()));
        
        // Trả về JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        PrintWriter out = response.getWriter();
        StringBuilder json = new StringBuilder();
        json.append("{");
        json.append("\"quantity\":").append(newQuantity).append(",");
        // subtotal và total gửi về dạng số nguyên (bỏ phần thập phân nếu muốn giống fmt:formatNumber maxFractionDigits="0")
        // Hoặc gửi nguyên số thực để JS format
        json.append("\"subtotal\":").append(itemSubtotal).append(",");
        json.append("\"total\":").append(cartTotal);
        json.append("}");
        
        out.print(json.toString());
        out.flush();
    }
}