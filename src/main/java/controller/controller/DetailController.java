package controller.controller;

import dao.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Product;

import java.io.IOException;
import java.util.List;

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
        
        request.setAttribute("product", product);
        request.setAttribute("relatedProducts", relatedProducts);
        
        request.getRequestDispatcher("Detail.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) {
    }
}