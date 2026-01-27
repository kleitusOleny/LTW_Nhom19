package controller.admin;

import com.google.gson.Gson;
import dao.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Product;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

/**
 * Servlet để load danh sách sản phẩm theo filter (Category, Manufacturer, hoặc
 * ALL)
 * Sử dụng cho modal "Áp dụng mã giảm giá"
 */
@WebServlet("/admin/get-products-by-filter")
public class GetProductsByFilterController extends HttpServlet {

    private ProductDAO productDAO;
    private Gson gson;

    @Override
    public void init() throws ServletException {
        productDAO = new ProductDAO();
        gson = new Gson();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Set response type to JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            // Lấy parameters
            String filterType = request.getParameter("filterType");
            String filterId = request.getParameter("filterId");

            List<Product> products = null;

            // Load sản phẩm dựa trên filterType
            switch (filterType) {
                case "ALL":
                    // Lấy tất cả sản phẩm
                    products = productDAO.getAllProducts();
                    break;

                case "CATEGORY":
                    // Lấy sản phẩm theo category
                    if (filterId != null && !filterId.isEmpty()) {
                        products = productDAO.getProductsByCategoryId(filterId);
                    }
                    break;

                case "MANUFACTURER":
                    // Lấy sản phẩm theo manufacturer
                    if (filterId != null && !filterId.isEmpty()) {
                        products = productDAO.getProductsByManufacturerId(filterId);
                    }
                    break;

                default:
                    products = List.of(); // Empty list
            }

            // Chuyển đổi sang JSON và gửi response
            String jsonResponse = gson.toJson(products);
            PrintWriter out = response.getWriter();
            out.print(jsonResponse);
            out.flush();

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            PrintWriter out = response.getWriter();
            out.print("{\"error\": \"" + e.getMessage() + "\"}");
            out.flush();
        }
    }
}
