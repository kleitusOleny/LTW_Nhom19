package controller.admin;

import com.google.gson.Gson;
import dao.DiscountDAO;
import dao.DiscountProcessDAO;
import dao.ProductDAO;
import model.Discount;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/admin/apply-discount")
public class AdminApplyDiscountController extends HttpServlet {

    private DiscountDAO discountDAO = new DiscountDAO();
    private ProductDAO productDAO = new ProductDAO();
    private DiscountProcessDAO discountProcessDAO = new DiscountProcessDAO();
    private Gson gson = new Gson();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        Map<String, Object> result = new HashMap<>();

        try {
            String discountIdStr = req.getParameter("discountId");
            String applyType = req.getParameter("applyType");

            if (discountIdStr == null || applyType == null) {
                result.put("success", false);
                result.put("message", "Thiếu thông tin bắt buộc");
                resp.getWriter().write(gson.toJson(result));
                return;
            }

            int discountId = Integer.parseInt(discountIdStr);
            Discount discount = new Discount();
            discount.setId(discountId);
            Discount existingDiscount = discountDAO.findById(discount);

            if (existingDiscount == null) {
                result.put("success", false);
                result.put("message", "Mã giảm giá không tồn tại");
                resp.getWriter().write(gson.toJson(result));
                return;
            }

            if (!existingDiscount.isActive()) {
                result.put("success", false);
                result.put("message", "Mã giảm giá đang bị vô hiệu hóa");
                resp.getWriter().write(gson.toJson(result));
                return;
            }

            // Check expiry? The DAO query in ProductDAO checks NOW() BETWEEN from AND to,
            // but here we are applying it. We should probably check if it's expired.
            // But maybe admin wants to apply it even if it starts in the future?
            // Let's just check active status for now.

            List<String> productIdsToApply = new ArrayList<>();

            switch (applyType) {
                case "CATEGORY":
                    String[] categoryIds = req.getParameterValues("categoryIds");
                    if (categoryIds != null && categoryIds.length > 0) {
                        productIdsToApply = productDAO.getProductIdsByCategoryIds(Arrays.asList(categoryIds));
                    }
                    break;
                case "MANUFACTURER":
                    String[] manufacturerIds = req.getParameterValues("manufacturerIds");
                    if (manufacturerIds != null && manufacturerIds.length > 0) {
                        productIdsToApply = productDAO.getProductIdsByManufacturerIds(Arrays.asList(manufacturerIds));
                    }
                    break;
                case "PRODUCT":
                    String[] pIds = req.getParameterValues("productIds");
                    if (pIds != null && pIds.length > 0) {
                        productIdsToApply = Arrays.asList(pIds);
                    }
                    break;
                default:
                    result.put("success", false);
                    result.put("message", "Loại áp dụng không hợp lệ");
                    resp.getWriter().write(gson.toJson(result));
                    return;
            }

            if (productIdsToApply.isEmpty()) {
                result.put("success", false);
                result.put("message", "Không tìm thấy sản phẩm nào để áp dụng");
                resp.getWriter().write(gson.toJson(result));
                return;
            }

            DiscountProcessDAO.ApplyResult applyResult = discountProcessDAO.applyDiscountToProducts(discountId,
                    productIdsToApply);

            result.put("success", true);
            result.put("message", "Áp dụng thành công! Đã thêm mới: " + applyResult.getInserted() + ", Kích hoạt lại: "
                    + applyResult.getReactivated());

        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
            result.put("message", "Lỗi server: " + e.getMessage());
        }

        resp.getWriter().write(gson.toJson(result));
    }
}
