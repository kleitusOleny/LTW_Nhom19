package controller.admin;

import dao.DiscountDAO;
import model.Discount;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;

@WebServlet(name = "AdminGetDiscountController", value = "/admin/get-promotion")
public class AdminGetDiscountController extends HttpServlet {
    private DiscountDAO discountDAO;

    @Override
    public void init() {
        discountDAO = new DiscountDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int id = Integer.parseInt(request.getParameter("id"));

            Discount d = new Discount();
            d.setId(id);
            Discount discount = discountDAO.findById(d);

            if (discount != null) {
                request.setAttribute("discountEdit", discount);
                request.setAttribute("discounts", discountDAO.getAll());
                request.getRequestDispatcher("/AdminPages/manage_promotions.jsp")
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
