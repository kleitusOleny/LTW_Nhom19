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
        String cartType = request.getParameter("cartType");
        String redirect = request.getParameter("redirect");

        if ("buyNow".equals(cartType)) {
            Cart cart = (Cart) request.getSession().getAttribute("buyNowCart");
            if (cart != null) {
                cart.removeItem(id);
                if (cart.getItems().isEmpty()) {
                    request.getSession().removeAttribute("buyNowCart");
                    response.sendRedirect("store");
                    return;
                }
            } else {
                response.sendRedirect("store");
                return;
            }
            response.sendRedirect("checkout?from=buyNow");
            return;
        }

        Cart cart = (Cart) request.getSession().getAttribute("cart");
        if (cart == null) {
            request.getSession().setAttribute("cart", new Cart());
            if (redirect != null && !redirect.isEmpty()) {
                response.sendRedirect(redirect);
            } else {
                response.sendRedirect("my-cart");
            }
            return;
        }
        cart.removeItem(id);

        if (redirect != null && !redirect.isEmpty()) {
            response.sendRedirect(redirect);
        } else {
            response.sendRedirect("my-cart");
        }
    }
}