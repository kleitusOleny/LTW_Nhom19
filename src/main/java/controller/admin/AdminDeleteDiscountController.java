package controller.admin;

import dao.DiscountDAO;
import model.Discount;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "AdminDeleteDiscountController", value = "/admin/delete-promotion")
public class AdminDeleteDiscountController extends HttpServlet {
    private DiscountDAO discountDAO;

    @Override
    public void init() {
        discountDAO = new DiscountDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Discount d = new Discount();
            d.setId(id);
            discountDAO.delete(d);
            response.sendRedirect(request.getContextPath() + "/admin/manage-promotions");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unable to delete promotion");
        }
    }
}
