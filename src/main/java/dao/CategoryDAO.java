package dao;

import model.Category;
import java.util.List;

public class CategoryDAO extends ADAO {
    
    // Lấy tất cả danh mục chưa bị xóa
    public List<Category> selectAll() {
        String query = "SELECT id, category_name, slug, create_at, is_delete FROM categorys WHERE is_delete = 0";
        return jdbi.withHandle(handle ->
                handle.createQuery(query)
                        .mapToBean(Category.class)
                        .list());
    }
    
    // Thêm danh mục mới
    public int insert(Category c) {
        String query = "INSERT INTO categorys (category_name, slug, create_at, is_delete) VALUES (:categoryName, :slug, NOW(), 0)";
        return jdbi.withHandle(handle ->
                handle.createUpdate(query)
                        .bindBean(c)
                        .execute());
    }
    
    // Xóa mềm danh mục (cập nhật is_delete = 1)
    public int delete(String id) {
        String query = "UPDATE categorys SET is_delete = 1 WHERE id = :id";
        return jdbi.withHandle(handle ->
                handle.createUpdate(query)
                        .bind("id", id)
                        .execute());
    }
    
    public int update(Category c) {
        String query = "UPDATE categorys SET category_name = :categoryName, slug = :slug WHERE id = :id";
        return jdbi.withHandle(handle ->
                handle.createUpdate(query)
                        .bind("id", c.getId()) // Đảm bảo ID là int
                        .bind("categoryName", c.getCategoryName())
                        .bind("slug", c.getSlug())
                        .execute());
    }
}