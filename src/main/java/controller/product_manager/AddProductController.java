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
        try {
            // Lấy dữ liệu chuỗi
            String id = request.getParameter("id");
            String name = request.getParameter("productName");
            String type = request.getParameter("type");
            String origin = request.getParameter("origin");
            String manufacturer = request.getParameter("manufacturer");
            double price = Double.parseDouble(request.getParameter("price"));
            String capacity = request.getParameter("capacity");
            String alcohol = request.getParameter("alcohol");
            int stock = Integer.parseInt(request.getParameter("stock"));
            String category = request.getParameter("category");
            String tags = request.getParameter("tags");
            String detail = request.getParameter("detail");
            
            // Xử lý file ảnh
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
            
            // Đóng gói vào object (Giả sử model Product của bạn có các field này)
            Product p = new Product();
            p.setId(id);
            p.setProductName(name);
            p.setPrice(BigDecimal.valueOf(price));
            p.setCapacity(capacity);
            p.setAlcohol(Double.parseDouble(alcohol));
            p.setOrigin(origin);
            p.setQuantity(stock);
            p.setDetail(detail);
            p.setImageUrl(imageUrl);
            
            ProductDAO dao = new ProductDAO();
            boolean success = dao.insertProduct(p, type, manufacturer, category, tags);
            
            if (success) {
                response.sendRedirect("product-manager");
            } else {
                response.getWriter().write("Lỗi khi thêm sản phẩm.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Dữ liệu đầu vào không hợp lệ.");
        }
    }
}