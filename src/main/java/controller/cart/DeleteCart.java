package controller.cart;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Cart;

import java.io.IOException;

@WebServlet(name = "DeleteCart", value = "/delete-cart")
public class DeleteCart extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        
        Cart cart = (Cart) request.getSession().getAttribute("cart");
        if (cart == null){
            request.getSession().setAttribute("cart",new Cart());
            return;
        }
        cart.removeItem(id);
        response.sendRedirect("my-cart");
    }
}