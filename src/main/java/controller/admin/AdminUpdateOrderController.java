package controller.admin;

import dao.ShipOrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ShipOrder;

import java.io.IOException;

@WebServlet(name = "AdminUpdateOrderController", value = "/admin/update-order")
public class AdminUpdateOrderController extends HttpServlet {
    private ShipOrderDAO shipOrderDAO;

    @Override
    public void init() {
        shipOrderDAO = new ShipOrderDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String status = request.getParameter("statusSelect");

            if (status == null) {
                status = request.getParameter("status");
            }
            boolean updated = false;
            if (status != null) {
                updated = shipOrderDAO.updateStatus(id, status);
                System.out.println(updated);
                if (!updated) {
                    ShipOrder shipOrder = new ShipOrder();
                    shipOrder.setOrderId(id);
                    shipOrder.setStatus(status);
                    shipOrder.setShippingFee(0.0);

                    updated = shipOrderDAO.create(shipOrder);
                }
            }
            response.sendRedirect(request.getContextPath() + "/admin/manage-orders");
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(
                    "{\"success\": false, \"message\": \"Lỗi khi cập nhật trạng thái: " + e.getMessage() + "\"}");
        }
    }
}
