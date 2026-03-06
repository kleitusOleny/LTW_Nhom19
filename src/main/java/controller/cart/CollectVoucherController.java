package controller.cart;

import com.google.gson.Gson;
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
import java.util.Map;

@WebServlet("/cart/collect-voucher")
public class CollectVoucherController extends HttpServlet {
    private DiscountService discountService = new DiscountService();
    private Gson gson = new Gson();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        Map<String, Object> result = new HashMap<>();

        if (user == null) {
            result.put("success", false);
            result.put("requireLogin", true);
            result.put("message", "Vui lòng đăng nhập để thu thập voucher");
            resp.getWriter().write(gson.toJson(result));
            return;
        }

        try {
            int discountId = Integer.parseInt(req.getParameter("discountId"));
            boolean success = discountService.collectVoucher(user.getId(), discountId);

            if (success) {
                result.put("success", true);
                result.put("message", "Thu thập voucher thành công");
            } else {
                result.put("success", false);
                result.put("message", "Không thể thu thập voucher (đã hết hoặc đã thu thập)");
            }
        } catch (NumberFormatException e) {
            result.put("success", false);
            result.put("message", "Mã voucher không hợp lệ");
        }

        resp.getWriter().write(gson.toJson(result));
    }
}
