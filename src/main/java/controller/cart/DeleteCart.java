package controller.cart;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Cart;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;

@WebServlet(name = "DeleteCart", value = "/delete-cart")
public class DeleteCart extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        String listId = request.getParameter("listId");
        String isAjax = request.getParameter("ajax");
        
        Cart cart = (Cart) request.getSession().getAttribute("cart");

        if (cart != null) {
            if (listId != null && !listId.isEmpty()) {
                String[] ids = listId.split(",");
                for (String itemId : ids) {
                    cart.removeItem(itemId.trim());
                }
            } else if (id != null) {
                cart.removeItem(id);
            }
        }
        
        // Trả về kết quả
        if ("true".equals(isAjax)) {
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            PrintWriter out = response.getWriter();
            
            BigDecimal total = BigDecimal.ZERO;
            if (cart != null) {
                // Đảm bảo cart.getTotal() trả về đúng kiểu dữ liệu
                total = new BigDecimal(String.valueOf(cart.getTotal()));
            }
            
            // Trả về tổng tiền mới
            out.print("{\"total\":" + total + "}");
            out.flush();
        } else {
            response.sendRedirect("my-cart");
        }
    }

}