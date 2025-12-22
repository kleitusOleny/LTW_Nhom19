package controller;

import dao.ProductDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Product;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "StoreController", value = "/store")
public class StoreController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProductDAO dao = new ProductDAO();
        
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
        
        // Tính toán vị trí bắt đầu
        int offset = (page - 1) * pageSize;
        
        // 2. Lấy dữ liệu
        List<Product> products = dao.getProducts(pageSize, offset);
        int totalProducts = dao.countTotalProducts();
        
        // 3. Tính tổng số trang
        int totalPages = (int) Math.ceil((double) totalProducts / pageSize);
        
        // 4. Gửi dữ liệu sang JSP
        request.setAttribute("products", products);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", page);
        request.setAttribute("categories", dao.getAllCategories());
        request.setAttribute("types", dao.getAllTypes());
        request.setAttribute("manufacturers", dao.getAllManufacturers());
        request.setAttribute("tags", dao.getAllTags());
        request.setAttribute("origins", dao.getAllOrigins());
        request.setAttribute("capacities", dao.getAllCapacities());
//        request.setAttribute("selectedTags", new ArrayList<>());
        
        
        request.getRequestDispatcher("store.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) {
    }
}