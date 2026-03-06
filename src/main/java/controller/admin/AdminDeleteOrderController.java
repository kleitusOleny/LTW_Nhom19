package controller.admin;

import dao.OrderDAO;
import model.Order;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "AdminDeleteOrderController", value = "/admin/delete-order")
public class AdminDeleteOrderController extends HttpServlet {
    private OrderDAO orderDAO;

    @Override
    public void init() {
        orderDAO = new OrderDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String idsParam = request.getParameter("ids");
            if (idsParam != null && !idsParam.isEmpty()) {
                String[] ids = idsParam.split(",");
                for (String idStr : ids) {
                    try {
                        int id = Integer.parseInt(idStr.trim());
                        Order o = new Order();
                        o.setId(id);
                        orderDAO.delete(o);
                    } catch (NumberFormatException e) {
                        e.printStackTrace();
                    }
                }
            } else {
                // Fallback for single delete if 'id' param is used (though 'ids' is preferred
                // now)
                String idParam = request.getParameter("id");
                if (idParam != null) {
                    int id = Integer.parseInt(idParam);
                    Order o = new Order();
                    o.setId(id);
                    orderDAO.delete(o);
                }
            }
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("{\"success\": true, \"message\": \"Xoá đơn hàng thành công!\"}");
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter()
                    .write("{\"success\": false, \"message\": \"Lỗi khi xoá đơn hàng: " + e.getMessage() + "\"}");
        }
    }
}
