package controller;

import dao.ProductDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Product;
import model.Review;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "DetailController", value = "/detail")
public class DetailController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");

        if (id == null || id.isEmpty()) {
            response.sendRedirect("store");
            return;
        }
        
        ProductDAO dao = new ProductDAO();
        Product product = dao.getProductById(id);
        
        if (product == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Sản phẩm không tồn tại");
            return;
        }
        
        List<Product> relatedProducts = dao.getRelatedProducts();
        List<Review> reviews = dao.getReviews(id);
        
        request.setAttribute("product", product);
        request.setAttribute("relatedProducts", relatedProducts);
        request.setAttribute("reviews", reviews);
        
        request.getRequestDispatcher("Detail.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) {
    }
}