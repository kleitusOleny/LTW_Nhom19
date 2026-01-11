package dao;

import model.Banner;
import java.util.List;

public class BannerDAO extends ADAO {
    
    // 1. Lấy tất cả banner
    public List<Banner> getAllBanners() {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM banners WHERE is_delete = 0 ORDER BY create_at DESC")
                        .mapToBean(Banner.class)
                        .list()
        );
    }
    
    // 2. Thêm banner mới
    public boolean insertBanner(Banner b) {
        return jdbi.withHandle(handle ->
                handle.createUpdate("INSERT INTO banners (url_banner, target_url, event_date, life_time, active, create_at, is_delete) " +
                                "VALUES (:urlBanner, :targetUrl, :eventDate, :lifeTime, :active, NOW(), 0)")
                        .bindBean(b)
                        .execute() > 0
        );
    }
    
    // 3. Xóa banner (Soft delete)
    public boolean deleteBanner(int id) {
        return jdbi.withHandle(handle ->
                handle.createUpdate("UPDATE banners SET is_delete = 1 WHERE id = :id")
                        .bind("id", id)
                        .execute() > 0
        );
    }
    
    // 4. Cập nhật banner
    public boolean updateBanner(Banner b) {
        return jdbi.withHandle(handle ->
                handle.createUpdate("UPDATE banners SET url_banner=:urlBanner, target_url=:targetUrl, " +
                                "event_date=:eventDate, life_time=:lifeTime, active=:active, update_at=NOW() " +
                                "WHERE id=:id")
                        .bindBean(b)
                        .execute() > 0
        );
    }
    
    // 5. Lấy banner theo ID
    public Banner getBannerById(int id) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM banners WHERE id = :id")
                        .bind("id", id)
                        .mapToBean(Banner.class)
                        .findFirst().orElse(null)
        );
    }
}