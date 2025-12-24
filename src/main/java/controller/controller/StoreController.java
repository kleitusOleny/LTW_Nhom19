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


public class StoreController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProductDAO productDAO = new ProductDAO();
        
        // 1. Cấu hình phân trang
        int pageSize = 24;
        int page = 1;
        
        String pageParam = request.getParameter("page");
        if (pageParam != null && !pageParam.isEmpty()) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                page = 1;
            }
        }
        
        // Tính toán vị trí bắt đầu (OFFSET) trong SQL
        int offset = (page - 1) * pageSize;
        
        // 2. Lấy dữ liệu
        List<Product> products = productDAO.getProducts(pageSize, offset);
        int totalProducts = productDAO.countTotalProducts();
        
        // 3. Tính tổng số trang
        int totalPages = (int) Math.ceil((double) totalProducts / pageSize);
        
        // 4. Gửi dữ liệu sang JSP
        request.setAttribute("products", products);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", page);
        
        request.getRequestDispatcher("store.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) {
    }
}