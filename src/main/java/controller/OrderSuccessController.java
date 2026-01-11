package controller;

import dao.OrderDAO;
import model.Order;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;

@WebServlet(name = "OrderSuccessController", value = "/order-success")
public class OrderSuccessController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String orderIdStr = request.getParameter("orderId");
        if (orderIdStr == null) {
            response.sendRedirect("store");
            return;
        }

        try {
            int orderId = Integer.parseInt(orderIdStr);
            OrderDAO orderDAO = new OrderDAO();
            Order order = orderDAO.findById(orderId);

            if (order == null) {
                response.sendRedirect("store");
                return;
            }

            request.setAttribute("transResult", true);
            request.setAttribute("orderId", String.valueOf(orderId));
            request.setAttribute("paymentCode", "COD");
            request.setAttribute("amount", order.getTotalPrice());
            request.setAttribute("orderInfo", "Thanh toan khi nhan hang");
            request.setAttribute("payDate", new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new Date()));

            request.getRequestDispatcher("vnpay/vnpay_return.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect("store");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
