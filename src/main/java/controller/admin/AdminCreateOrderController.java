package controller.admin;

import dao.ProductDAO;
import dao.UserDAO;
import model.Product;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminCreateOrderController", value = "/admin/create-order")
public class AdminCreateOrderController extends HttpServlet {
    private ProductDAO productDAO;
    private UserDAO userDAO;

    @Override
    public void init() {
        productDAO = new ProductDAO();
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy tham số tìm kiếm và lọc
            String keyword = request.getParameter("keyword");
            String filterType = request.getParameter("filterType");
            
            // Lấy danh sách sản phẩm
            List<Product> products = productDAO.getProducts(50, 0);
            
            // Lọc theo từ khóa nếu có
            if (keyword != null && !keyword.trim().isEmpty()) {
                String kw = keyword.toLowerCase().trim();
                products = products.stream()
                    .filter(p -> p.getProductName().toLowerCase().contains(kw) 
                              || p.getId().toLowerCase().contains(kw)
                              || (p.getOrigin() != null && p.getOrigin().toLowerCase().contains(kw)))
                    .toList();
            }
            
            // Lọc theo loại nếu có
            if (filterType != null && !filterType.isEmpty() && !"all".equals(filterType)) {
                products = products.stream()
                    .filter(p -> p.getTypeId() != null && p.getTypeId().toLowerCase().contains(filterType.toLowerCase()))
                    .toList();
            }
            
            request.setAttribute("products", products);
            request.setAttribute("keyword", keyword);
            request.setAttribute("filterType", filterType != null ? filterType : "all");
            
            // Lấy danh sách khách hàng gần đây (tùy chọn)
            List<User> recentCustomers = userDAO.getAll().stream().limit(10).toList();
            request.setAttribute("recentCustomers", recentCustomers);
            
            request.getRequestDispatcher("/AdminPages/create_order.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Không thể tải trang tạo đơn hàng");
        }
    }
}
