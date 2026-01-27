package controller;

import dao.ManufacturerDAO;
import dao.ProductDAO;
import dao.FavouriteDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Product;
import model.User;
import services.ProductService;

import java.io.IOException;
import java.util.*;

@WebServlet(name = "StoreController", value = "/store")
public class StoreController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("curHeader","store");
        ProductDAO dao = new ProductDAO();
        ManufacturerDAO manuDAO = new ManufacturerDAO();
        // 1. Cấu hình phân trang
        int pageSize = 16;
        int page = 1;
        
        String pageParam = request.getParameter("page");
        if (pageParam != null && !pageParam.isEmpty()) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                page = 1;
            }
        }
        
        String sort = request.getParameter("sort");
        if (sort == null) {
            sort = "default";
        }
        
        // Tính toán vị trí bắt đầu
        int offset = (page - 1) * pageSize;
        
        // 2. Lấy dữ liệu
        List<Product> products = dao.getProducts(pageSize, offset,sort);
        int totalProducts = ProductService.countTotalProducts();
        double maxPrice = dao.getMaxPrice();
        request.setAttribute("maxPrice", maxPrice > 0 ? maxPrice : 10000000);
        
        // 3. Tính tổng số trang
        int totalPages = (int) Math.ceil((double) totalProducts / pageSize);

        // 4. Load user's favorite product IDs if logged in
        HttpSession session = request.getSession(false);
        if (session != null) {
            User user = (User) session.getAttribute("user");
            if (user != null) {
                FavouriteDAO favouriteDAO = new FavouriteDAO();
                List<Map<String, Object>> userFavourites = favouriteDAO.getFavouritesWithProductsByUserID(user.getId());

                Map<String, Boolean> favouriteProductMap = new HashMap<>();
                for (Map<String, Object> fav : userFavourites) {
                    favouriteProductMap.put((String) fav.get("product_id"), true);
                }
                request.setAttribute("favouriteProductMap", favouriteProductMap);
            }
        }
        
        
        request.setAttribute("currentSort", sort);
        
        // 5. Gửi dữ liệu sang JSP
        request.setAttribute("products", products);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", page);
        request.setAttribute("categories", dao.getAllCategories());
        request.setAttribute("types", dao.getAllTypes());
        request.setAttribute("manufacturers", manuDAO.getAllManufacturers());
        request.setAttribute("tags", dao.getAllTags());
        request.setAttribute("origins", dao.getAllOrigins());
        request.setAttribute("capacities", dao.getAllCapacities());
        request.setAttribute("selectedTags", new ArrayList<>());
        
        
        request.getRequestDispatcher("store.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) {
    }
}