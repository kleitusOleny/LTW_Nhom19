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

@WebServlet(name = "FilterController", value = "/filter")
public class FilterController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProductDAO dao = new ProductDAO();

        String[] prices = request.getParameterValues("price");
        String[] categories = request.getParameterValues("category");
        String[] manufacturers = request.getParameterValues("manufacturer");
        String[] types = request.getParameterValues("type");
        String[] origins = request.getParameterValues("origin");
        String[] capacities = request.getParameterValues("capacity");
        String[] tags = request.getParameterValues("tag");
        //Xử lý phân trang
        int pageSize = 24;
        int page = 1;
        try {
            page = Integer.parseInt(request.getParameter("page"));
        } catch (NumberFormatException e) { page = 1; }
        int offset = (page - 1) * pageSize;
        
        List<Product> products = dao.filterProducts(prices, categories, manufacturers, types, origins,capacities, tags, pageSize, offset);
        int totalFiltered = dao.countFilteredProducts(prices, categories, manufacturers, types, origins, capacities, tags);
        int totalPages = (int) Math.ceil((double) totalFiltered / pageSize);
        
        // GIỮ LẠI BỘ LỌC
        String queryString = request.getQueryString();
        String keepParams = "";
        if (queryString != null) {
            keepParams = queryString.replaceAll("&?page=\\d+", ""); // Xóa tham số page cũ
            if (!keepParams.isEmpty() && !keepParams.startsWith("&")) {
                keepParams = "&" + keepParams;
            }
        }

        request.setAttribute("products", products);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", page);
        request.setAttribute("filterParams", keepParams);

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
        
        request.getRequestDispatcher("store.jsp").forward(request, response);
    }
}