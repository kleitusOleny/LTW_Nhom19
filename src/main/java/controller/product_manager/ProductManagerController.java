package controller.product_manager;

import dao.ManufacturerDAO;
import dao.ProductDAO;
import model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.nio.file.Paths;

@WebServlet(name = "ProductManagerController", urlPatterns = {"/product-manager"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10,      // 10MB
        maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class ProductManagerController extends HttpServlet {
    
    ProductDAO productDAO = new ProductDAO();
    ManufacturerDAO manufacturerDAO = new ManufacturerDAO();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        req.setAttribute("products", productDAO.listProduct());
        req.setAttribute("categories", productDAO.getAllCategories());
        req.setAttribute("types", productDAO.getAllTypes());
        req.setAttribute("manufacturers", manufacturerDAO.getAllManufacturers());
        req.getRequestDispatcher("/AdminPages/manage_product.jsp").forward(req, resp);
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        
        try {
            if ("add".equals(action) || "edit".equals(action)) { // Gộp logic Add và Edit
                // 1. Lấy dữ liệu chung
                String name = req.getParameter("name");
                double price = Double.parseDouble(req.getParameter("price"));
                int quantity = Integer.parseInt(req.getParameter("stock"));
                String origin = req.getParameter("origin");
                String capacity = req.getParameter("capacity");
                double alcohol = Double.parseDouble(req.getParameter("alcohol"));
                String detail = req.getParameter("detail");
                
                // Xử lý Upload ảnh
                Part filePart = req.getPart("image");
                String imageUrl = "";
                
                // Nếu có file mới được upload
                if (filePart != null && filePart.getSize() > 0) {
                    String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                    String uploadPath = getServletContext().getRealPath("") + File.separator + "assets" + File.separator + "products";
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) uploadDir.mkdir();
                    
                    String finalFileName = System.currentTimeMillis() + "_" + fileName;
                    filePart.write(uploadPath + File.separator + finalFileName);
                    imageUrl = "assets/products/" + finalFileName;
                } else {
                    // Nếu không up ảnh mới -> Lấy lại ảnh cũ (đối với edit)
                    imageUrl = req.getParameter("oldImage");
                }
                
                // Map dữ liệu
                Product p = new Product();
                p.setProductName(name);
                p.setSlug(name.toLowerCase().replace(" ", "-"));
                p.setOrigin(origin);
                p.setPrice(BigDecimal.valueOf(price));
                p.setCapacity(capacity);
                p.setAlcohol(alcohol);
                p.setQuantity(quantity);
                p.setDetail(detail);
                p.setImageUrl(imageUrl);
                p.setTypeId(req.getParameter("type"));
                p.setManufacturerId(req.getParameter("manufacturer"));
                p.setCategoryId(req.getParameter("category"));
                
                if ("add".equals(action)) {
                    p.setId("P" + System.currentTimeMillis() % 100000);
                    productDAO.insert(p);
                } else {
                    // Trường hợp Edit: Lấy ID từ form
                    p.setId(req.getParameter("id"));
                    productDAO.update(p);
                }
                
            } else if ("delete".equals(action)) {
                // Xóa 1 sản phẩm
                String id = req.getParameter("id");
                productDAO.delete(id);
                
            } else if ("delete-list".equals(action)) {
                // XỬ LÝ XÓA NHIỀU (Dựa trên chuỗi ID cách nhau dấu phẩy)
                String ids = req.getParameter("ids"); // VD: "P123,P456"
                if (ids != null && !ids.isEmpty()) {
                    String[] idArray = ids.split(",");
                    for (String id : idArray) {
                        productDAO.delete(id);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        resp.sendRedirect("product-manager");
    }
}