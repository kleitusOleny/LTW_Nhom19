package controller.cart;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Cart;
import model.CartItem;
import model.Product;
import services.ProductService;
import java.io.IOException;

@WebServlet(name = "AddCart", value = "/add-cart")
public class AddCart extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String productId = request.getParameter("productId");
        
        int quantityToAdd = 1;
        try {
            quantityToAdd = Integer.parseInt(request.getParameter("quantity"));
        } catch (NumberFormatException e) {
            quantityToAdd = 1;
        }
        
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null){
            cart = new Cart();
        }
        
        ProductService productService = new ProductService();
        Product product = productService.getProduct(productId);
        
        if (product != null) {
            // --- KIỂM TRA TỒN KHO ---
            int currentInCart = 0;
            for (CartItem item : cart.getItems()) {
                if(item.getProduct().getId().equals(productId)){
                    currentInCart = item.getQuantity();
                    break;
                }
            }
            
            int totalExpected = currentInCart + quantityToAdd;
            int stock = product.getQuantity();
            
            if (totalExpected > stock) {
                System.out.println("DEBUG: Quá tồn kho! Current=" + currentInCart + ", Add=" + quantityToAdd + ", Stock=" + stock);
                
                session.setAttribute("failedMsg", "Rất tiếc! Kho chỉ còn " + stock + " sản phẩm.");
                
                String referer = request.getHeader("Referer");
                response.sendRedirect(referer != null ? referer : "store");
                return;
            }
            // ------------------------
            
            String redirect = request.getParameter("redirect");
            if ("checkout".equals(redirect)) {
                Cart buyNowCart = new Cart();
                buyNowCart.addItem(product, quantityToAdd);
                session.setAttribute("buyNowCart", buyNowCart);
                response.sendRedirect("checkout?from=buyNow");
            } else {
                cart.addItem(product, quantityToAdd);
                session.setAttribute("cart", cart);
                
                // Lấy referer để quay lại đúng trang (Store hoặc Detail)
                String referer = request.getHeader("Referer");
                if (referer != null && !referer.isEmpty()) {
                    response.sendRedirect(referer);
                } else {
                    response.sendRedirect("store");
                }
            }
            return;
        }
        
        request.setAttribute("msg","Product not found");
        request.getRequestDispatcher("/store").forward(request,response);
    }
}