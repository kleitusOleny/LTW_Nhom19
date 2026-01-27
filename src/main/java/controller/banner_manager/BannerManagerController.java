package controller.banner_manager;

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
        List<Banner> banners = dao.getAllBanners();
        request.setAttribute("banners", banners);
        
        // Lưu ý: Kiểm tra lại đường dẫn file JSP này có đúng với cấu trúc dự án của bạn không
        request.getRequestDispatcher("AdminPages/manage_banner.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        BannerDAO dao = new BannerDAO();
        
        try {
            if ("add".equals(action)) {
                Banner b = new Banner();
                b.setUrlBanner(request.getParameter("urlBanner"));
                b.setTargetUrl(request.getParameter("targetUrl"));
                
                String dateStr = request.getParameter("eventDate");
                if(dateStr != null && !dateStr.isEmpty()) {
                    // Xử lý chuỗi ngày tháng để tránh lỗi format
                    if(dateStr.length() <= 10) dateStr += " 00:00:00";
                    b.setEventDate(Timestamp.valueOf(dateStr));
                }
                
                b.setLifeTime(Integer.parseInt(request.getParameter("lifeTime")));
                b.setActive("Active".equals(request.getParameter("status")));
                
                dao.insertBanner(b);
                
            } else if ("delete".equals(action)) {
                String idStr = request.getParameter("id");
                if (idStr != null && !idStr.isEmpty()) {
                    int id = Integer.parseInt(idStr);
                    dao.deleteBanner(id);
                }
            } else if ("edit".equals(action)) {
                // --- LOGIC SỬA BANNER ---
                String idStr = request.getParameter("id");
                if(idStr != null && !idStr.isEmpty()){
                    Banner b = new Banner();
                    b.setId(Integer.parseInt(idStr)); // Set ID cần sửa
                    b.setUrlBanner(request.getParameter("urlBanner"));
                    b.setTargetUrl(request.getParameter("targetUrl"));
                    
                    String dateStr = request.getParameter("eventDate");
                    if(dateStr != null && !dateStr.isEmpty()) {
                        if(dateStr.length() <= 10) dateStr += " 00:00:00";
                        b.setEventDate(Timestamp.valueOf(dateStr));
                    }
                    
                    b.setLifeTime(Integer.parseInt(request.getParameter("lifeTime")));
                    b.setActive("Active".equals(request.getParameter("status")));
                    
                    dao.updateBanner(b);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        // SỬA LỖI TRANG TRẮNG: Dùng contextPath
        response.sendRedirect(request.getContextPath() + "/banner-manager");
    }
}