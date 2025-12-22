package dao;

import model.Product;
import model.Review;

import java.util.List;

public class ProductDAO extends ADAO {
    public List<Product> getProducts() {
        return jdbi.withHandle(handle ->
                handle.createQuery(
                                "SELECT " +
                                        "p.id, " +
                                        "p.product_name, " +
                                        "p.slug, " +
                                        "p.price, " +
                                        "p.capacity, " +
                                        "p.alcohol, " +
                                        "p.origin, " +
                                        "p.detail, " +
                                        "p.create_at, " +
                                        "p.update_at, " +
                                        "p.is_delete, " +
                                        "t.type_name AS typeId, " +
                                        "m.manufacturer_name AS manufacturerId, " +
                                        "c.category_name AS categoryId " +
                                        "FROM products p " +
                                        "LEFT JOIN product_types t ON p.type_id = t.id " +
                                        "LEFT JOIN manufacturers m ON p.manufacturer_id = m.id " +
                                        "LEFT JOIN categorys c ON p.category_id = c.id " +
                                        "LIMIT 24"
                        )
                        .mapToBean(Product.class)
                        .list()
        );
        
    }
    
    public List<Product> getProducts(int limit, int offset) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT " +
                                        "p.id, p.product_name, p.slug, p.price, p.capacity, p.alcohol, p.origin, " +
                                        "t.type_name AS typeId, " +
                                        "m.manufacturer_name AS manufacturerId, " +
                                        
                                        // 1. Lấy 1 ảnh từ bảng
                                        "(SELECT url_img FROM p_img WHERE product_id = p.id LIMIT 1) AS imageUrl, " +
                                        
                                        // 2. Tính trung bình sao
                                        "(SELECT AVG(ct.star) " +
                                        " FROM evaluates e " +
                                        " JOIN ct_evaluates ct ON e.evaluate_id = ct.id " +
                                        " WHERE e.product_id = p.id) AS rating, " +
                                        
                                        // 3. Đếm tổng số lượt đánh giá
                                        "(SELECT COUNT(*) FROM evaluates WHERE product_id = p.id) AS totalReviews " +
                                        
                                        "FROM products p " +
                                        "LEFT JOIN product_types t ON p.type_id = t.id " +
                                        "LEFT JOIN manufacturers m ON p.manufacturer_id = m.id " +
                                        "WHERE p.is_delete = 0 " +
                                        "LIMIT :limit OFFSET :offset"
                        )
                        .bind("limit", limit)
                        .bind("offset", offset)
                        .mapToBean(Product.class)
                        .list()
        );
    }
    
    // 2. Hàm đếm tổng số sản phẩm
    public int countTotalProducts() {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT COUNT(*) FROM products WHERE is_delete = 0")
                        .mapTo(Integer.class).stream().findFirst().orElse(0)
        );
    }
    
    // Thêm vào trong class ProductDAO
    public Product getProductById(String id) {
        return jdbi.withHandle(handle ->
                handle.createQuery(
                                "SELECT " +
                                        "p.id, p.product_name, p.slug, p.price, p.capacity, p.alcohol, p.origin, p.detail, p.create_at, p.update_at, p.is_delete, " +
                                        "t.type_name AS typeId, " +
                                        "m.manufacturer_name AS manufacturerId, " +
                                        "c.category_name AS categoryId " +
                                        "FROM products p " +
                                        "LEFT JOIN product_types t ON p.type_id = t.id " +
                                        "LEFT JOIN manufacturers m ON p.manufacturer_id = m.id " +
                                        "LEFT JOIN categorys c ON p.category_id = c.id " +
                                        "WHERE p.id = :id AND p.is_delete = 0"
                        )
                        .bind("id", id)
                        .mapToBean(Product.class)
                        .findFirst().orElse(null)
        );
    }
    
    // Hàm lấy 4 sản phẩm liên quan
    public List<Product> getRelatedProducts() {
        return jdbi.withHandle(handle ->
                handle.createQuery(
                                "SELECT " +
                                        "p.id, p.product_name, p.slug, p.price, p.capacity, p.alcohol, p.origin, p.detail, p.create_at, p.update_at, p.is_delete, " +
                                        "t.type_name AS typeId, " +
                                        "m.manufacturer_name AS manufacturerId, " +
                                        "c.category_name AS categoryId " +
                                        "FROM products p " +
                                        "LEFT JOIN product_types t ON p.type_id = t.id " +
                                        "LEFT JOIN manufacturers m ON p.manufacturer_id = m.id " +
                                        "LEFT JOIN categorys c ON p.category_id = c.id " +
                                        "WHERE p.is_delete = 0 " +
                                        "ORDER BY RAND() LIMIT 4"
                        )
                        .mapToBean(Product.class)
                        .list()
        );
    }
    
    public List<Review> getReviews(String productId) {
        return jdbi.withHandle(handle ->
                handle.createQuery(
                                "SELECT " +
                                        "u.full_name AS fullName, " +
                                        "ct.star, " +
                                        "ct.content, " +
                                        "ct.create_at AS createAt " +
                                        "FROM evaluates e " +
                                        "JOIN users u ON e.user_id = u.id " +
                                        "JOIN ct_evaluates ct ON e.evaluate_id = ct.id " +
                                        "WHERE e.product_id = :productId AND ct.is_delete IS NULL " +
                                        "ORDER BY ct.create_at DESC"
                        )
                        .bind("productId", productId)
                        .mapToBean(Review.class)
                        .list()
        );
    }
    
}