package controller.admin;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import dao.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Product;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.stream.Collectors;

@WebServlet(name = "AdminProductSearchController", value = "/admin/api/products")
public class AdminProductSearchController extends HttpServlet {

    private transient ProductDAO productDAO;
    private transient Gson gson;

    @Override
    public void init() throws ServletException {
        productDAO = new ProductDAO();
        gson = new GsonBuilder().serializeNulls().create();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String keyword = request.getParameter("keyword");
        String limitParam = request.getParameter("limit");
        int limit = 40;
        if (limitParam != null) {
            try {
                limit = Math.max(1, Math.min(100, Integer.parseInt(limitParam)));
            } catch (NumberFormatException ignored) {
            }
        }

        List<Product> products = new ArrayList<>(productDAO.getProducts());
        if (keyword != null && !keyword.isBlank()) {
            String lowered = keyword.toLowerCase(Locale.ROOT);
            products = products.stream()
                    .filter(product -> matchesKeyword(product, lowered))
                    .collect(Collectors.toList());
        }

        if (products.size() > limit) {
            products = products.subList(0, limit);
        }

        List<ProductListItem> payload = products.stream()
                .map(ProductListItem::from)
                .collect(Collectors.toList());

        try (PrintWriter writer = response.getWriter()) {
            writer.print(gson.toJson(payload));
        }
    }

    private boolean matchesKeyword(Product product, String keyword) {
        return containsIgnoreCase(product.getProductName(), keyword)
                || containsIgnoreCase(product.getSlug(), keyword)
                || containsIgnoreCase(product.getOrigin(), keyword)
                || containsIgnoreCase(product.getTypeId(), keyword)
                || containsIgnoreCase(product.getId(), keyword);
    }

    private boolean containsIgnoreCase(String source, String keyword) {
        return source != null && source.toLowerCase(Locale.ROOT).contains(keyword);
    }

    private record ProductListItem(String id,
            String name,
            String sku,
            String origin,
            String type,
            double price,
            int stock,
            String imageUrl,
            String capacity) {

        static ProductListItem from(Product product) {
            String image = product.getImageUrl();
            if (image == null || image.isBlank()) {
                image = "/assets/images/placeholder-wine.png";
            }
            return new ProductListItem(
                    product.getId(),
                    product.getProductName(),
                    product.getSlug() != null ? product.getSlug() : product.getId(),
                    product.getOrigin(),
                    product.getTypeId(),
                    product.getPrice(),
                    product.getQuantity(),
                    image,
                    product.getCapacity());
        }
    }
}
