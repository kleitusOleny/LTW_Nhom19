package controller.product_manager;

import dao.ProductDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Product;
import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.nio.file.Paths;

@WebServlet(name = "AddProductController", value = "/add-product")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 50
)
public class AddProductController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8"); // Đảm bảo tiếng Việt
        try {
            // Lấy dữ liệu cơ bản
            String id = request.getParameter("id");
            String name = request.getParameter("productName");
            String origin = request.getParameter("origin");
            
            // XỬ LÝ SỐ LIỆU (Parse cẩn thận)
            double price = 0;
            try { price = Double.parseDouble(request.getParameter("price")); } catch (NumberFormatException e) {}
            
            double alcohol = 0;
            try { alcohol = Double.parseDouble(request.getParameter("alcohol")); } catch (NumberFormatException e) {}
            
            int stock = 0;
            try { stock = Integer.parseInt(request.getParameter("stock")); } catch (NumberFormatException e) {}
            
            String capacity = request.getParameter("capacity");
            String detail = request.getParameter("detail");
            
            // --- THAY ĐỔI QUAN TRỌNG: Lấy ID từ dropdown ---
            int typeId = Integer.parseInt(request.getParameter("type"));
            int manufacturerId = Integer.parseInt(request.getParameter("manufacturer"));
            int categoryId = Integer.parseInt(request.getParameter("category"));
            
            // Xử lý file ảnh (Giữ nguyên logic cũ)
            Part filePart = request.getPart("image");
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String imageUrl = "";
            if (fileName != null && !fileName.isEmpty()) {
                String uploadPath = getServletContext().getRealPath("/") + "assets/products";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdir();
                filePart.write(uploadPath + File.separator + fileName);
                imageUrl = "assets/products/" + fileName;
            }
            
            // Đóng gói object Product
            Product p = new Product();
            p.setId(id);
            p.setProductName(name);
            p.setSlug(toSlug(name)); // Bạn nên có hàm tạo slug
            p.setPrice(BigDecimal.valueOf(price));
            p.setCapacity(capacity);
            p.setAlcohol(alcohol);
            p.setOrigin(origin);
            p.setQuantity(stock);
            p.setDetail(detail);
            p.setImageUrl(imageUrl);
            
            // Set các ID khóa ngoại
//            p.setTypeId(typeId);              // Cần đảm bảo Model Product có setter này
//            p.setManufacturerId(manufacturerId); // Cần đảm bảo Model Product có setter này
//            p.setCategoryId(categoryId);      // Cần đảm bảo Model Product có setter này
            
            ProductDAO dao = new ProductDAO();
            dao.insert(p);
            
            
            response.sendRedirect("manage_product.jsp"); // Hoặc redirect về controller load danh sách
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Dữ liệu đầu vào không hợp lệ: " + e.getMessage());
        }
    }
    
    // Hàm tiện ích tạo slug đơn giản (nếu chưa có)
    private String toSlug(String input) {
        if (input == null) return "";
        return input.toLowerCase().replaceAll("[^a-z0-9\\s]", "").replaceAll("\\s+", "-");
    }
}