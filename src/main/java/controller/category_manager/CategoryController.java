package controller.category_manager;

import dao.CategoryDAO;
import model.Category;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.UUID; // Dùng để tạo ID ngẫu nhiên nếu database không tự tăng chuỗi

@WebServlet(name = "CategoryController", urlPatterns = {"/category-manager"})
public class CategoryController extends HttpServlet {
    
    CategoryDAO categoryDAO = new CategoryDAO();
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        // Lấy danh sách danh mục
        List<Category> list = categoryDAO.selectAll();
        req.setAttribute("categories", list);
        
        // Chuyển hướng sang trang JSP
        req.getRequestDispatcher("AdminPages/manage_category.jsp").forward(req, resp);
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        
        try {
            if ("add".equals(action)) {
                String name = req.getParameter("name");
                String slug = req.getParameter("slug");
                
                Category c = new Category();
//            c.setId(UUID.randomUUID().toString().substring(0, 8));
                c.setCategoryName(name);
                c.setSlug(slug);
                
                categoryDAO.insert(c);
            } else if ("delete".equals(action)) {
                String id = req.getParameter("id");
                categoryDAO.delete(id);
            } else if ("edit".equals(action)) { // Xử lý hành động Sửa
                String idStr = req.getParameter("id");
                String name = req.getParameter("name");
                String slug = req.getParameter("slug");
                
                if (idStr != null && !idStr.isEmpty()) {
                    Category c = new Category();
                    c.setId(String.valueOf(Integer.parseInt(idStr))); // Chuyển String sang int
                    c.setCategoryName(name);
                    c.setSlug(slug);
                    
                    categoryDAO.update(c); // Gọi hàm update bên DAO
                }
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        resp.sendRedirect("category-manager");
    }
}