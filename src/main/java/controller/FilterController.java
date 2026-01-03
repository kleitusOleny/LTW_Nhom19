package controller;

import dao.ProductDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Product;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import dao.FavouriteDAO;
import model.User;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "FilterController", value = "/filter")
public class FilterController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        request.setAttribute("curHeader","store");
        ProductDAO dao = new ProductDAO();

        String[] prices = request.getParameterValues("price");
        String[] categories = request.getParameterValues("category");
        String[] manufacturers = request.getParameterValues("manufacturer");
        String[] types = request.getParameterValues("type");
        String[] origins = request.getParameterValues("origin");
        String[] capacities = request.getParameterValues("capacity");
        String[] tags = request.getParameterValues("tag");
        
        String search = request.getParameter("search");
        //Xử lý phân trang
        int pageSize = 24;
        int page = 1;
        try {
            page = Integer.parseInt(request.getParameter("page"));
        } catch (NumberFormatException e) { page = 1; }
        int offset = (page - 1) * pageSize;
        
        List<Product> products = dao.filterProducts(prices, categories, manufacturers, types, origins, capacities, tags, search, pageSize, offset);
        int totalFiltered = dao.countFilteredProducts(prices, categories, manufacturers, types, origins, capacities, tags, search);
        int totalPages = (int) Math.ceil((double) totalFiltered / pageSize);
        
        String queryString = request.getQueryString();
        String keepParams = "";
        if (queryString != null) {
            keepParams = queryString.replaceAll("&?page=\\d+", ""); // Xóa tham số page cũ
            if (!keepParams.isEmpty() && !keepParams.startsWith("&")) {
                keepParams = "&" + keepParams;
            }
        }
        
        double maxPrice = dao.getMaxPrice();
        request.setAttribute("maxPrice", maxPrice > 0 ? maxPrice : 10000000);
        
        request.setAttribute("products", products);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", page);
        request.setAttribute("filterParams", keepParams);
        request.setAttribute("searchKeyword", search);
        
        request.setAttribute("categories", dao.getAllCategories());
        request.setAttribute("types", dao.getAllTypes());
        request.setAttribute("manufacturers", dao.getAllManufacturers());
        request.setAttribute("tags", dao.getAllTags());
        request.setAttribute("origins", dao.getAllOrigins());
        request.setAttribute("capacities", dao.getAllCapacities());
        
        request.setAttribute("selectedPrices", prices != null ? Arrays.asList(prices) : new ArrayList<>());
        request.setAttribute("selectedCategories", categories != null ? Arrays.asList(categories) : new ArrayList<>());
        request.setAttribute("selectedManufacturers", manufacturers != null ? Arrays.asList(manufacturers) : new ArrayList<>());
        request.setAttribute("selectedTypes", types != null ? Arrays.asList(types) : new ArrayList<>());
        request.setAttribute("selectedOrigins", origins != null ? Arrays.asList(origins) : new ArrayList<>());
        request.setAttribute("selectedCapacities", capacities != null ? Arrays.asList(capacities) : new ArrayList<>());
        request.setAttribute("selectedTags", tags != null ? Arrays.asList(tags) : new ArrayList<>());

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

        request.getRequestDispatcher("store.jsp").forward(request, response);
    }
}