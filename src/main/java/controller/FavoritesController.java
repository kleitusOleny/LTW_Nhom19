package controller;

import dao.FavouriteDAO;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet(name = "FavoritesController", value = "/favorites")
public class FavoritesController extends HttpServlet {
    private FavouriteDAO favouriteDAO;

    @Override
    public void init() {
        favouriteDAO = new FavouriteDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "login");
            return;
        }
        User user = (User) session.getAttribute("user");
        if (user == null) {
            String requestedWith = request.getHeader("X-Requested-With");
            if ("XMLHttpRequest".equals(requestedWith)) {
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                response.getWriter().write("{\"error\":\"not_authenticated\"}");
                return;
            }
            response.sendRedirect(request.getContextPath() + "login");
            return;
        }
        List<Map<String, Object>> favouritesList = favouriteDAO.getFavouritesWithProductsByUserID(user.getId());
        request.setAttribute("favouritesList", favouritesList);
        request.getRequestDispatcher("/infoUsers/favorites.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("FavoritesController doPost hit");

        HttpSession session = request.getSession(false);

        if (session == null) {
            session = request.getSession(true);
        }

        User user = (User) session.getAttribute("user");
        if (user == null) {
            String requestedWith = request.getHeader("X-Requested-With");
            if ("XMLHttpRequest".equals(requestedWith)) {
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                response.setContentType("application/json");
                response.getWriter().write("{\"status\":\"error\", \"message\":\"not_authenticated\"}");
                return;
            }
            response.sendRedirect(request.getContextPath() + "login");
            return;
        }

        String action = request.getParameter("action");
        String productId = request.getParameter("productId");
        boolean success = false;
        try {
            if ("add".equals(action)) {
                if (productId == null || productId.trim().isEmpty()) {
                } else {
                    favouriteDAO.create(productId, user.getId());
                    success = true;
                }
            } else if ("remove".equals(action)) {
                String favouriteIdParam = request.getParameter("favouriteId");
                if (favouriteIdParam != null && !favouriteIdParam.isEmpty()) {
                    int favouriteId = Integer.parseInt(favouriteIdParam);
                    favouriteDAO.delete(favouriteId, productId, user.getId());
                    success = true;
                } else if (productId != null && !productId.isEmpty()) {
                    favouriteDAO.deleteByProductIdAndUserId(productId, user.getId());
                    success = true;
                }
            } else if ("sync".equals(action)) {
                String productIdsParam = request.getParameter("productIds");
                if (productIdsParam != null && !productIdsParam.isEmpty()) {
                    String[] productIds = productIdsParam.split(",");
                    for (String pId : productIds) {
                        if (pId != null && !pId.trim().isEmpty()) {
                            favouriteDAO.create(pId.trim(), user.getId());
                        }
                    }
                    success = true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            String requestedWith = request.getHeader("X-Requested-With");
            if ("XMLHttpRequest".equals(requestedWith)) {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("{\"status\":\"error\", \"message\":\"" + e.getMessage() + "\"}");
                return;
            }
            throw new ServletException(e);
        }

        String requestedWith = request.getHeader("X-Requested-With");
        if ("XMLHttpRequest".equals(requestedWith)) {
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter()
                    .write("{\"status\":\"" + (success ? "success" : "error") + "\", \"action\":\"" + action + "\"}");
            return;
        }

        String referer = request.getHeader("Referer");

        if (referer != null && !referer.isEmpty()) {
            response.sendRedirect(referer);
        } else {
            response.sendRedirect(request.getContextPath() + "/favorites");
        }
    }
}
