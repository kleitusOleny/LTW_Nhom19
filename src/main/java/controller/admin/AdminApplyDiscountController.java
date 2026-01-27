package controller.admin;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import dao.DiscountDAO;
import dao.DiscountProcessDAO;
import dao.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Discount;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.Instant;
import java.util.HashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

@WebServlet(name = "AdminApplyDiscountController", value = "/admin/api/discount/apply")
public class AdminApplyDiscountController extends HttpServlet {

    private transient DiscountDAO discountDAO;
    private transient ProductDAO productDAO;
    private transient DiscountProcessDAO discountProcessDAO;
    private transient Gson gson;

    @Override
    public void init() throws ServletException {
        discountDAO = new DiscountDAO();
        productDAO = new ProductDAO();
        discountProcessDAO = new DiscountProcessDAO();
        gson = new GsonBuilder().create();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try (BufferedReader reader = request.getReader()) {
            ApplyRequest payload = gson.fromJson(reader, ApplyRequest.class);
            if (payload == null || payload.discountId <= 0 || payload.applyType == null) {
                writeJson(response, HttpServletResponse.SC_BAD_REQUEST,
                        Map.of("success", false, "message", "Dữ liệu không hợp lệ."));
                return;
            }

            ApplyType type = ApplyType.from(payload.applyType);
            if (type == null) {
                writeJson(response, HttpServletResponse.SC_BAD_REQUEST,
                        Map.of("success", false, "message", "Kiểu áp dụng không hợp lệ."));
                return;
            }

            Discount discount = discountDAO.findById(new Discount() {{ setId(payload.discountId); }});
            if (discount == null) {
                writeJson(response, HttpServletResponse.SC_NOT_FOUND,
                        Map.of("success", false, "message", "Không tìm thấy mã giảm giá."));
                return;
            }
            if (!discount.isActive() || discount.getIsDelete()) {
                writeJson(response, HttpServletResponse.SC_BAD_REQUEST,
                        Map.of("success", false, "message", "Mã giảm giá đã bị vô hiệu."));
                return;
            }
            Instant now = Instant.now();
            if (discount.getDiscountFrom() != null && discount.getDiscountFrom().toInstant().isAfter(now)) {
                writeJson(response, HttpServletResponse.SC_BAD_REQUEST,
                        Map.of("success", false, "message", "Mã giảm giá chưa tới thời gian áp dụng."));
                return;
            }
            if (discount.getDiscountTo() != null && discount.getDiscountTo().toInstant().isBefore(now)) {
                writeJson(response, HttpServletResponse.SC_BAD_REQUEST,
                        Map.of("success", false, "message", "Mã giảm giá đã hết hạn."));
                return;
            }

            List<String> targetIds = normalizeTargets(payload.targetIds);
            if (targetIds.isEmpty()) {
                writeJson(response, HttpServletResponse.SC_BAD_REQUEST,
                        Map.of("success", false, "message", "Vui lòng chọn danh sách áp dụng."));
                return;
            }

            List<String> productIds = resolveProductIds(type, targetIds);
            if (productIds.isEmpty()) {
                writeJson(response, HttpServletResponse.SC_BAD_REQUEST,
                        Map.of("success", false, "message", "Không tìm thấy sản phẩm phù hợp."));
                return;
            }

            DiscountProcessDAO.ApplyResult result = discountProcessDAO.applyDiscountToProducts(discount.getId(), productIds);
            Map<String, Object> payloadResp = new HashMap<>();
            payloadResp.put("success", true);
            payloadResp.put("message",
                    String.format(Locale.getDefault(), "Đã áp dụng cho %d sản phẩm, khôi phục %d liên kết.",
                            result.getInserted(), result.getReactivated()));
            payloadResp.put("inserted", result.getInserted());
            payloadResp.put("reactivated", result.getReactivated());
            payloadResp.put("totalProducts", productIds.size());

            writeJson(response, HttpServletResponse.SC_OK, payloadResp);
        } catch (IllegalArgumentException ex) {
            writeJson(response, HttpServletResponse.SC_BAD_REQUEST,
                    Map.of("success", false, "message", ex.getMessage()));
        } catch (Exception ex) {
            ex.printStackTrace();
            writeJson(response, HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    Map.of("success", false, "message", "Có lỗi xảy ra khi áp dụng mã."));
        }
    }

    private List<String> resolveProductIds(ApplyType type, List<String> targetIds) {
        return switch (type) {
            case CATEGORY -> productDAO.getProductIdsByCategoryIds(targetIds);
            case MANUFACTURER -> productDAO.getProductIdsByManufacturerIds(targetIds);
            case PRODUCT -> productDAO.filterExistingProductIds(targetIds);
        };
    }

    private List<String> normalizeTargets(List<String> ids) {
        if (ids == null || ids.isEmpty()) {
            return List.of();
        }
        Set<String> distinct = new LinkedHashSet<>();
        for (String id : ids) {
            if (id != null && !id.isBlank()) {
                distinct.add(id.trim());
            }
        }
        return distinct.stream().collect(Collectors.toList());
    }

    private void writeJson(HttpServletResponse response, int status, Map<String, ?> payload) throws IOException {
        response.setStatus(status);
        try (PrintWriter writer = response.getWriter()) {
            writer.print(gson.toJson(payload));
        }
    }

    private enum ApplyType {
        CATEGORY,
        PRODUCT,
        MANUFACTURER;

        static ApplyType from(String raw) {
            if (raw == null) {
                return null;
            }
            try {
                return ApplyType.valueOf(raw.toUpperCase(Locale.ROOT));
            } catch (IllegalArgumentException ex) {
                return null;
            }
        }
    }

    private static class ApplyRequest {
        int discountId;
        String applyType;
        List<String> targetIds;
    }
}
