package controller.admin;

import dao.DiscountDAO;
import dao.ProductDAO;
import model.Category;
import model.Discount;
import model.Manufacturer;
import model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminDiscountController", value = "/admin/manage-promotions")
public class AdminDiscountController extends HttpServlet {
    private DiscountDAO discountDAO;
    private ProductDAO productDAO;

    @Override
    public void init() {
        discountDAO = new DiscountDAO();
        productDAO = new ProductDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy danh sách discounts
            List<Discount> discounts = discountDAO.getAll();
            request.setAttribute("discounts", discounts);

            List<Category> categories = productDAO.getAllCategories();
            List<Manufacturer> manufacturers = productDAO.getAllManufacturers();
            List<Product> products = productDAO.listProduct();

            request.setAttribute("categories", categories);
            request.setAttribute("manufacturers", manufacturers);
            request.setAttribute("products", products);

            // Check for error message in session and move to request
            String errorMessage = (String) request.getSession().getAttribute("errorMessage");
            if (errorMessage != null) {
                request.setAttribute("errorMessage", errorMessage);
                request.getSession().removeAttribute("errorMessage");
            }

            request.getRequestDispatcher("/AdminPages/manage_promotions.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unable to load promotions");
        }
    }
}
