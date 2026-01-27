package controller;

import dao.FavouriteDAO;
import dao.BlogDAO;
import model.Discount;
import model.User;
import model.Blogs;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet(name = "HomeController", value = { "/home", "/", "" })
public class HomeController extends HttpServlet {
    private FavouriteDAO favouriteDAO;
    private services.DiscountService discountService;
    private BlogDAO blogDAO;

    @Override
    public void init() {
        favouriteDAO = new FavouriteDAO();
        discountService = new services.DiscountService();
        blogDAO = new BlogDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("curHeader", "home");

        List<Map<String, Object>> topFavouritesList = favouriteDAO.getTopFavouritedProducts(4);

    
        if (topFavouritesList != null && !topFavouritesList.isEmpty()) {
            for (Map<String, Object> fav : topFavouritesList) {
                System.out.println("Product: " + fav.get("product_id") +
                        " | discount_type: " + fav.get("discount_type") +
                        " | discount_value: " + fav.get("discount_value"));
            }
        }

        request.setAttribute("topFavouritesList", topFavouritesList);

        HttpSession session = request.getSession(false);
        int userId = 0;
        if (session != null) {
            User user = (User) session.getAttribute("user");
            if (user != null) {
                userId = user.getId();
                List<Map<String, Object>> userFavouritesList = favouriteDAO
                        .getFavouritesWithProductsByUserID(user.getId());
                request.setAttribute("userFavouritesList", userFavouritesList);
            }
        }

        List<Discount> publicVouchers = discountService.getCollectableVouchers(userId);
        request.setAttribute("publicVouchers", publicVouchers);

        List<Blogs> latestBlogs = blogDAO.getLatestBlogs(3);
        request.setAttribute("latestBlogs", latestBlogs);

        request.getRequestDispatcher("index.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }
}