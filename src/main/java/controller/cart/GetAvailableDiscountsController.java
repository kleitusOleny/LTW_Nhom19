package controller.cart;

import com.google.gson.Gson;
import model.Cart;
import model.Discount;
import model.User;
import services.DiscountService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/cart/get-discounts")
public class GetAvailableDiscountsController extends HttpServlet {
    private DiscountService discountService = new DiscountService();
    private Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        Cart cart = (Cart) session.getAttribute("cart");

        Map<String, Object> result = new HashMap<>();

        if (user != null) {
            List<Discount> allUserVouchers = discountService.getUserVouchers(user.getId());

            List<Discount> shippingDiscounts = new java.util.ArrayList<>();
            List<Discount> otherVouchers = new java.util.ArrayList<>();

            for (Discount d : allUserVouchers) {
                if (d.getApplyType() != null && d.getApplyType().toUpperCase().contains("SHIP")) {
                    shippingDiscounts.add(d);
                } else {
                    otherVouchers.add(d);
                }
            }

            result.put("userVouchers", otherVouchers);
            result.put("shippingDiscounts", shippingDiscounts);

            List<Discount> collectableVouchers = discountService.getCollectableVouchers(user.getId());
            result.put("collectableVouchers", collectableVouchers);
        } else {
            // For guests, maybe show generic shipping discounts or nothing?
            // Original code showed getAvailableShippingDiscounts() which are global.
            // But user requirement implies we only show what they have collected?
            // Or maybe we still show global shipping discounts for guests?
            // Let's keep global shipping discounts for guests if needed, but the user
            // complaint was about collected ones.
            // If I remove getAvailableShippingDiscounts(), guests won't see any.
            // But the prompt says "bên ngoài cart vẫn không có mã giảm giá dù tôi đã lấy
            // rồi" -> implies logged in user.
            // So for logged in user, we override shippingDiscounts with collected ones.
            List<Discount> shippingDiscounts = discountService.getAvailableShippingDiscounts();
            result.put("shippingDiscounts", shippingDiscounts);
        }

        if (cart != null) {
            double loyaltyRate = discountService.calculateWholesaleDiscountRate(cart.getTotalQuantity());
            double loyaltyAmount = discountService.calculateWholesaleAmount(cart);
            Map<String, Object> loyalty = new HashMap<>();
            loyalty.put("rate", loyaltyRate);
            loyalty.put("amount", loyaltyAmount);
            result.put("loyalty", loyalty);
        }

        resp.getWriter().write(gson.toJson(result));
    }
}
