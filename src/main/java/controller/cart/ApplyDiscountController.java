package controller.cart;

import com.google.gson.Gson;
import model.Cart;
import model.Discount;
import services.DiscountService;
import dao.DiscountDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

import java.util.HashMap;
import java.util.Map;

@WebServlet("/cart/apply-discount")
public class ApplyDiscountController extends HttpServlet {
    private DiscountService discountService = new DiscountService();
    private DiscountDAO discountDAO = new DiscountDAO();
    private Gson gson = new Gson();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        String type = req.getParameter("type");
        String code = req.getParameter("code");

        HttpSession session = req.getSession();
        String checkoutType = (String) session.getAttribute("checkoutType");
        Cart cart;

        if ("buyNow".equals(checkoutType)) {
            cart = (Cart) session.getAttribute("buyNowCart");
        } else {
            cart = (Cart) session.getAttribute("cart");
        }

        Map<String, Object> result = new HashMap<>();

        if (cart == null) {
            result.put("success", false);
            result.put("message", "Giỏ hàng trống");
            resp.getWriter().write(gson.toJson(result));
            return;
        }

        if (code == null || code.trim().isEmpty()) {
            if ("shipping".equals(type)) {
                cart.setShippingDiscount(null);
            } else if ("voucher".equals(type)) {
                cart.setVoucherDiscount(null);
            }
        } else {
            Discount discount = discountDAO.findActiveByCode(code);
            if (discount == null) {
                result.put("success", false);
                result.put("message", "Mã không hợp lệ");
                resp.getWriter().write(gson.toJson(result));
                return;
            }

            if ("shipping".equals(type)) {
                cart.setShippingDiscount(discount);
            } else if ("voucher".equals(type)) {
                cart.setVoucherDiscount(discount);
            }
        }

        double loyaltyAmount = discountService.calculateWholesaleAmount(cart);
        cart.setLoyaltyDiscountAmount(loyaltyAmount);

        result.put("success", true);
        result.put("newTotal", cart.getTotal());
        result.put("message", "Áp dụng thành công");

        if ("buyNow".equals(checkoutType)) {
            session.setAttribute("buyNowCart", cart);
        } else {
            session.setAttribute("cart", cart);
        }
        resp.getWriter().write(gson.toJson(result));
    }
}
