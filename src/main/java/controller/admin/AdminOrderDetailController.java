package controller.admin;

import dao.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;



import java.io.IOException;
import java.io.PrintWriter;
import java.text.NumberFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

@WebServlet(name = "AdminOrderDetailController", value = "/admin/get-order")
public class AdminOrderDetailController extends HttpServlet {
    private OrderDAO orderDAO;

    @Override
    public void init() {
        orderDAO = new OrderDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));

            Map<String, Object> orderInfo = orderDAO.getOrderInfo(id);
            List<Map<String, Object>> items = orderDAO.getOrderItems(id);

            if (orderInfo != null) {
                request.setAttribute("orderInfo", orderInfo);
                request.setAttribute("orderItems", items);

                // Also need the list for the page to render fully
                request.setAttribute("orders", orderDAO.getAllOrdersWithStatus());

                request.getRequestDispatcher("/AdminPages/manage_orders.jsp")
                        .forward(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
