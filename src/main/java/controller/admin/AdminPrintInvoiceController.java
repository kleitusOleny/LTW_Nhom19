package controller.admin;

import dao.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.text.NumberFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

@WebServlet(name = "AdminPrintInvoiceController", value = "/admin/print-invoice")
public class AdminPrintInvoiceController extends HttpServlet {
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
                // Format currency
                Locale locale = new Locale("vi", "VN");
                NumberFormat currencyFormatter = NumberFormat.getCurrencyInstance(locale);

                for (Map<String, Object> item : items) {
                    // Normalize keys
                    Map<String, Object> lowerCaseItem = new HashMap<>();
                    for (Map.Entry<String, Object> entry : item.entrySet()) {
                        lowerCaseItem.put(entry.getKey().toLowerCase(), entry.getValue());
                    }
                    item.putAll(lowerCaseItem);

                    Object unitPriceObj = item.get("unit_price");
                    Object quantityObj = item.get("quantity");

                    double price = 0;
                    int quantity = 0;

                    if (unitPriceObj instanceof Number) {
                        price = ((Number) unitPriceObj).doubleValue();
                    }
                    if (quantityObj instanceof Number) {
                        quantity = ((Number) quantityObj).intValue();
                    }

                    item.put("formattedPrice", currencyFormatter.format(price));
                    item.put("formattedTotal", currencyFormatter.format(price * quantity));
                }

                double total = 0;
                Object totalPriceObj = orderInfo.get("total_price");
                if (totalPriceObj instanceof Number) {
                    total = ((Number) totalPriceObj).doubleValue();
                }
                orderInfo.put("formattedTotal", currencyFormatter.format(total));

                request.setAttribute("info", orderInfo);
                request.setAttribute("items", items);
                request.getRequestDispatcher("/AdminPages/invoice_print.jsp").forward(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Order not found");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
