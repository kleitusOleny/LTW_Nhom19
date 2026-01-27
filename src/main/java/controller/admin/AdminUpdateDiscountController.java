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

@WebServlet(name = "AdminUpdateDiscountController", value = "/admin/update-promotion")
public class AdminUpdateDiscountController extends HttpServlet {
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
            int id = Integer.parseInt(request.getParameter("id"));
            String code = request.getParameter("code_edit");
            String type = request.getParameter("type_edit");
            String valueStr = request.getParameter("value_edit");
            String startStr = request.getParameter("start_edit");
            String endStr = request.getParameter("end_edit");
            String status = request.getParameter("status_edit");
            String quantityStr = request.getParameter("quantity_edit");
            String applyType = request.getParameter("apply_type_edit");

            // Clean value string
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

            Discount d = new Discount();
            d.setId(id);
            Discount existing = discountDAO.findById(d);

            if (existing != null) {
                existing.setDiscountCode(code);
                existing.setDiscountType(type);
                existing.setDiscountValue(value);
                existing.setDiscountFrom(Timestamp.valueOf(startStr + " 00:00:00"));
                existing.setDiscountTo(Timestamp.valueOf(endStr + " 23:59:59"));
                existing.setActive(isActive);
                existing.setUpdateAt(Timestamp.valueOf(LocalDateTime.now()));
                existing.setQuantity(quantity);
                existing.setApplyType(applyType != null ? applyType : "order");

                discountDAO.update(existing);
            }

            response.sendRedirect(request.getContextPath() + "/admin/manage-promotions");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unable to update promotion");
        }
    }
}
