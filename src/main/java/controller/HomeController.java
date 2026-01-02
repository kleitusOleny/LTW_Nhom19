package controller;

import dao.FavouriteDAO;
import model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet(name = "HomeController", value = { "/home", "/", "" })
public class HomeController extends HttpServlet {
    private FavouriteDAO favouriteDAO;

    @Override
    public void init() {
        favouriteDAO = new FavouriteDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("curHeader", "home");

        List<Map<String, Object>> topFavouritesList = favouriteDAO.getTopFavouritedProducts(4);
        request.setAttribute("topFavouritesList", topFavouritesList);

        HttpSession session = request.getSession(false);
        if (session != null) {
            User user = (User) session.getAttribute("user");
            if (user != null) {
                List<Map<String, Object>> userFavouritesList = favouriteDAO
                        .getFavouritesWithProductsByUserID(user.getId());
                request.setAttribute("userFavouritesList", userFavouritesList);
            }
        }

        request.getRequestDispatcher("index.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }
}