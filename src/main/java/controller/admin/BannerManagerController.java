package controller.admin;

import dao.BannerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Banner;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;

@WebServlet(name = "BannerManagerController", value = "/banner-manager")
public class BannerManagerController extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        BannerDAO dao = new BannerDAO();
        
        // Lấy danh sách banner từ DB
        List<Banner> banners = dao.getAllBanners();
        
        // Gửi sang JSP
        request.setAttribute("banners", banners);
        
        request.getRequestDispatcher("manage_banner.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        BannerDAO dao = new BannerDAO();
        
        if ("add".equals(action)) {
            // Xử lý thêm mới
            Banner b = new Banner();
            b.setUrlBanner(request.getParameter("urlBanner")); // Đường dẫn ảnh
            b.setTargetUrl(request.getParameter("targetUrl")); // Link đích
            
            String dateStr = request.getParameter("eventDate");
            if(dateStr != null && !dateStr.isEmpty()) {
                b.setEventDate(Timestamp.valueOf(dateStr + " 00:00:00"));
            }
            
            b.setLifeTime(Integer.parseInt(request.getParameter("lifeTime")));
            b.setActive("Active".equals(request.getParameter("status")));
            
            dao.insertBanner(b);
            
        } else if ("delete".equals(action)) {
            // Xử lý xóa
            int id = Integer.parseInt(request.getParameter("id"));
            dao.deleteBanner(id);
        }
        
        // Sau khi xử lý xong thì reload lại trang
        response.sendRedirect("banner-manager");
    }
}