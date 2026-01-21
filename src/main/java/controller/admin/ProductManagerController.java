package controller.admin;
import dao.ProductDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Manufacturer;
import model.Product;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ProductManagerController", value = "/product-manager")
public class ProductManagerController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProductDAO dao = new ProductDAO();

        List<Product> products = dao.getProducts();
        List<Manufacturer> manufacturers = dao.getAllManufacturers();
        
        request.setAttribute("products", products);
        request.setAttribute("manufacturers", manufacturers);
        
        request.getRequestDispatcher("AdminPages/manage_product.jsp").forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}