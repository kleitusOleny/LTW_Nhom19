package controller.admin;

import dao.DiscountDAO;
import model.Discount;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDateTime;

@WebServlet(name = "AdminAddDiscountController", value = "/admin/add-promotion")
public class AdminAddDiscountController extends HttpServlet {
    private DiscountDAO discountDAO;

    @Override
    public void init() {
        discountDAO = new DiscountDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        try {
            String code = request.getParameter("code");
            String type = request.getParameter("type");
            String valueStr = request.getParameter("value");
            String startStr = request.getParameter("start");
            String endStr = request.getParameter("end");
            String status = request.getParameter("status");
            String quantityStr = request.getParameter("quantity");
            String applyType = request.getParameter("apply_type");

            // Clean value string (remove non-numeric chars except dot)
            double value = 0;
            try {
                value = Double.parseDouble(valueStr.replaceAll("[^0-9.]", ""));
            } catch (NumberFormatException e) {
                value = 0;
            }

            boolean isActive = "Hoạt động".equals(status);

            int quantity = 100; // Default
            try {
                quantity = Integer.parseInt(quantityStr);
            } catch (NumberFormatException e) {
                quantity = 100;
            }

            // Convert type from Vietnamese to English
            String discountType = "FIXED"; // Default
            if ("Phần trăm".equals(type)) {
                discountType = "PERCENT";
            } else if ("Số tiền cố định".equals(type)) {
                discountType = "FIXED";
            } else if ("Miễn phí vận chuyển".equals(type)) {
                discountType = "AMOUNT";
            }

            Discount discount = new Discount();
            discount.setDiscountCode(code);
            discount.setDiscountType(discountType);
            discount.setDiscountValue(value);
            discount.setDiscountFrom(Timestamp.valueOf(startStr + " 00:00:00"));
            discount.setDiscountTo(Timestamp.valueOf(endStr + " 23:59:59"));
            discount.setActive(isActive);
            discount.setCreateAt(Timestamp.valueOf(LocalDateTime.now()));
            discount.setUpdateAt(Timestamp.valueOf(LocalDateTime.now()));
            discount.setIsDelete(false);
            discount.setQuantity(quantity);
            discount.setApplyType(applyType != null ? applyType : "order");

            discountDAO.create(discount);

            response.sendRedirect(request.getContextPath() + "/admin/manage-promotions");
        } catch (org.jdbi.v3.core.statement.UnableToExecuteStatementException e) {
            if (e.getCause() instanceof java.sql.SQLIntegrityConstraintViolationException) {
                request.getSession().setAttribute("errorMessage", "Mã giảm giá đã tồn tại! Vui lòng chọn mã khác.");
            } else {
                e.printStackTrace();
                request.getSession().setAttribute("errorMessage", "Lỗi cơ sở dữ liệu: " + e.getMessage());
            }
            response.sendRedirect(request.getContextPath() + "/admin/manage-promotions");
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Lỗi hệ thống: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin/manage-promotions");
        }
    }
}
