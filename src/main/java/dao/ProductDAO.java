package dao;

import model.*;

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

                                        "(SELECT url_img FROM p_img WHERE product_id = p.id LIMIT 1) AS imageUrl, " +

                                        "(SELECT AVG(ct.star) " +
                                        " FROM evaluates e " +
                                        " JOIN ct_evaluates ct ON e.evaluate_id = ct.id " +
                                        " WHERE e.product_id = p.id) AS rating, " +

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

    public int countTotalProducts() {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT COUNT(*) FROM products WHERE is_delete = 0")
                        .mapTo(Integer.class).stream().findFirst().orElse(0)
        );
    }

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
    
    public List<Category> getAllCategories() {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT id, category_name AS categoryName FROM categorys WHERE is_delete = 0")
                        .mapToBean(Category.class)
                        .list()
        );
    }
    
    public List<ProductType> getAllTypes() {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT id AS typeId, type_name AS typeName FROM product_types WHERE is_delete = 0")
                        .mapToBean(ProductType.class)
                        .list()
        );
    }
    
    public List<Manufacturer> getAllManufacturers() {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT id, manufacturer_name AS manufacturerName FROM manufacturers WHERE is_delete = 0")
                        .mapToBean(Manufacturer.class)
                        .list()
        );
    }
    
    public List<Tag> getAllTags() {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT id, tag_name AS tagName FROM tags WHERE is_delete = 0")
                        .mapToBean(Tag.class)
                        .list()
        );
    }
    
    // Lấy danh sách xuất xứ
    public List<String> getAllOrigins() {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT DISTINCT origin FROM products WHERE is_delete = 0 AND origin IS NOT NULL")
                        .mapTo(String.class)
                        .list()
        );
    }
    
    // Lấy danh sách dung tích
    public List<String> getAllCapacities() {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT DISTINCT capacity FROM products WHERE is_delete = 0 AND capacity IS NOT NULL")
                        .mapTo(String.class)
                        .list()
        );
    }
    
    //Lấy danh sách đã lọc
    public List<Product> filterProducts(String[] prices, String[] categories, String[] manufacturers, String[] types, String[] origins, String[] capacities, String[] tags, int limit, int offset) {
        StringBuilder sql = new StringBuilder(
                "SELECT p.id, p.product_name, p.slug, p.price, p.capacity, p.alcohol, p.origin, " +
                        "t.type_name AS typeId, m.manufacturer_name AS manufacturerId, " +
                        "(SELECT url_img FROM p_img WHERE product_id = p.id LIMIT 1) AS imageUrl, " +
                        "(SELECT AVG(ct.star) FROM evaluates e JOIN ct_evaluates ct ON e.evaluate_id = ct.id WHERE e.product_id = p.id) AS rating, " +
                        "(SELECT COUNT(*) FROM evaluates WHERE product_id = p.id) AS totalReviews " +
                        "FROM products p " +
                        "LEFT JOIN product_types t ON p.type_id = t.id " +
                        "LEFT JOIN manufacturers m ON p.manufacturer_id = m.id " +
                        "WHERE p.is_delete = 0 "
        );
        
        // Truyền thêm tags vào hàm nối chuỗi
        appendFilterConditions(sql, prices, categories, manufacturers, types, origins, capacities, tags);
        
        sql.append(" LIMIT :limit OFFSET :offset");
        
        return jdbi.withHandle(handle ->
                handle.createQuery(sql.toString())
                        .bind("limit", limit)
                        .bind("offset", offset)
                        .mapToBean(Product.class)
                        .list()
        );
    }
    
    public int countFilteredProducts(String[] prices, String[] categories, String[] manufacturers, String[] types, String[] origins, String[] capacities, String[] tags) {
        StringBuilder sql = new StringBuilder(
                "SELECT COUNT(*) FROM products p " +
                        "LEFT JOIN product_types t ON p.type_id = t.id " +
                        "LEFT JOIN manufacturers m ON p.manufacturer_id = m.id " +
                        "WHERE p.is_delete = 0 "
        );
        
        appendFilterConditions(sql, prices, categories, manufacturers, types, origins, capacities, tags);
        
        return jdbi.withHandle(handle ->
                handle.createQuery(sql.toString())
                        .mapTo(Integer.class)
                        .findOnly()
        );
    }
    
    // Phương thức private hỗ trợ nối chuỗi SQL cho lọc
    private void appendFilterConditions(StringBuilder sql, String[] prices, String[] categories, String[] manufacturers, String[] types, String[] origins, String[] capacities, String[] tags) {
        
        if (categories != null && categories.length > 0) {
            sql.append(" AND p.category_id IN (");
            for (int i = 0; i < categories.length; i++) {
                sql.append(categories[i]);
                if (i < categories.length - 1) {
                    sql.append(",");
                }
            }
            sql.append(")");
        }
        
        if (manufacturers != null && manufacturers.length > 0) {
            sql.append(" AND p.manufacturer_id IN (");
            for (int i = 0; i < manufacturers.length; i++) {
                sql.append(manufacturers[i]);
                if (i < manufacturers.length - 1) {
                    sql.append(",");
                }
            }
            sql.append(")");
        }

        if (types != null && types.length > 0) {
            sql.append(" AND p.type_id IN (");
            for (int i = 0; i < types.length; i++) {
                sql.append(types[i]);
                if (i < types.length - 1) {
                    sql.append(",");
                }
            }
            sql.append(")");
        }

        if (origins != null && origins.length > 0) {
            sql.append(" AND p.origin IN (");
            for (int i = 0; i < origins.length; i++) {
                // Thêm dấu nháy đơn bao quanh giá trị: 'Pháp'
                sql.append("'").append(origins[i]).append("'");
                if (i < origins.length - 1) {
                    sql.append(",");
                }
            }
            sql.append(")");
        }

        if (prices != null && prices.length > 0) {
            sql.append(" AND (");
            
            for (int i = 0; i < prices.length; i++) {
                String[] range = prices[i].split("-");
                
                if (i > 0) {
                    sql.append(" OR ");
                }
                
                if (range.length == 2) {
                    String min = range[0];
                    String max = range[1];
                    
                    if ("max".equalsIgnoreCase(max)) {
                        sql.append("p.price >= ").append(min);
                    } else {
                        sql.append("(p.price >= ").append(min)
                                .append(" AND p.price <= ").append(max).append(")");
                    }
                }
            }
            sql.append(")");
        }
        
        if (capacities != null && capacities.length > 0) {
            sql.append(" AND p.capacity IN (");
            for (int i = 0; i < capacities.length; i++) {
                sql.append("'").append(capacities[i]).append("'");
                if (i < capacities.length - 1) {
                    sql.append(",");
                }
            }
            sql.append(")");
        }
        
        if (tags != null && tags.length > 0) {
            sql.append(" AND p.id IN (SELECT pt.product_id FROM product_tags pt WHERE pt.tag_id IN (");
            for (int i = 0; i < tags.length; i++) {
                sql.append(tags[i]);
                if (i < tags.length - 1) {
                    sql.append(",");
                }
            }
            sql.append("))");
        }
    }
    
}