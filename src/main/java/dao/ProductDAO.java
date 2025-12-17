package dao;

import model.Product;

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
                                        "WHERE p.is_delete = 0 " + // Chỉ lấy sản phẩm chưa xóa
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
}