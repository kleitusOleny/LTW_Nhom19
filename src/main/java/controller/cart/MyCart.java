package controller.cart;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Discount;
import model.User;
import services.DiscountService;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "MyCart", value = "/my-cart")
public class MyCart extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User user = (User) request.getSession().getAttribute("user");
        if (user != null) {
            DiscountService discountService = new DiscountService();
            List<Discount> allUserVouchers = discountService.getUserVouchers(user.getId());

            List<Discount> shippingDiscounts = new ArrayList<>();
            List<Discount> otherVouchers = new ArrayList<>();

            for (model.Discount d : allUserVouchers) {
                if (d.getApplyType() != null && d.getApplyType().toUpperCase().contains("SHIP")) {
                    shippingDiscounts.add(d);
                } else {
                    otherVouchers.add(d);
                }
            }
            request.setAttribute("allUserVouchers", allUserVouchers);
            request.setAttribute("shippingDiscounts", shippingDiscounts);
            request.setAttribute("otherVouchers", otherVouchers);
        }

        request.getRequestDispatcher("Cart.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }
}