package controller.cart;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Cart;

import java.io.IOException;

@WebServlet(name = "UpdateItem", value = "/update-item")
public class UpdateItem extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Cart cart = (Cart) request.getSession().getAttribute("cart");
        
        if (cart == null) {
            response.sendRedirect("my-cart");
            return;
        }
        
        String id = request.getParameter("id");
        String setQuantityStr = request.getParameter("setQuantity");
        
        if (setQuantityStr != null){
            cart.updateItem(id,Integer.parseInt(setQuantityStr));
        }else {
            
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            
            cart.updateQuantity(id, quantity);
        }
        
        response.sendRedirect("my-cart");
    }
}
