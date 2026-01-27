package controller;

import dao.FavouriteDAO;
import dao.ProductDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Product;
import model.Review;
import model.User;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "DetailController", value = { "/detail", "/infoUsers/detail" })
public class DetailController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");

        if (id == null || id.isEmpty()) {
            response.sendRedirect("store");
            return;
        }

        ProductDAO dao = new ProductDAO();
        Product product = dao.getProductById(id);

        if (product == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Sản phẩm không tồn tại");
            return;
        }

        List<Product> relatedProducts = dao.getRelatedProducts();
        List<Review> reviews = dao.getReviews(id);

        HttpSession session = request.getSession(false);
        if (session != null) {
            User user = (User) session.getAttribute("user");
            if (user != null) {
                FavouriteDAO favouriteDAO = new FavouriteDAO();
                List<Map<String, Object>> userFavourites = favouriteDAO
                        .getFavouritesWithProductsByUserID(user.getId());
                Map<String, Boolean> favouriteProductMap = new HashMap<>();
                for (Map<String, Object> fav : userFavourites) {
                    favouriteProductMap.put((String) fav.get("product_id"), true);
                }
                request.setAttribute("favouriteProductMap", favouriteProductMap);
            }
        }

        request.setAttribute("product", product);
        request.setAttribute("relatedProducts", relatedProducts);
        request.setAttribute("reviews", reviews);

        request.getRequestDispatcher("Detail.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) {
    }
}