package dao;

import model.Address;
import model.Favourite;

import java.util.List;
import java.util.Map;

public class FavouriteDAO extends ADAO {
    public List<Favourite> getAll() {
        return jdbi.withHandle(handle -> {
            return handle.createQuery("select * from favourites where is_delete = 0").mapToBean(Favourite.class).list();
        });
    }

    public boolean create(String idProduct, int idUser) {
        try {
            return jdbi.withHandle(handle -> {
                try {
                    Integer existing = handle.createQuery(
                            "SELECT COUNT(*) FROM favourites WHERE product_id = :product_id AND user_id = :user_id")
                            .bind("product_id", idProduct)
                            .bind("user_id", idUser)
                            .mapTo(Integer.class)
                            .one();

                    if (existing > 0) {
                        return false;
                    }

                    int rowsAffected = handle.createUpdate("""
                            INSERT INTO favourites (product_id, user_id) VALUES (:product_id, :user_id)
                            """)
                            .bind("product_id", idProduct)
                            .bind("user_id", idUser)
                            .execute();

                    boolean result = rowsAffected > 0;
                    return result;
                } catch (Exception e) {
                    e.printStackTrace();
                    throw e;
                }
            });
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean delete(int idFavourite, String idProduct, int idUser) {
        return jdbi.withHandle(handle -> handle.createUpdate("""
                 DELETE FROM favourites
                 WHERE user_id=:user_id AND id=:id AND product_id=:product_id
                """).bind("user_id", idUser).bind("id", idFavourite).bind("product_id", idProduct).execute() > 0);
    }

    public boolean deleteByProductIdAndUserId(String idProduct, int idUser) {
        return jdbi.withHandle(handle -> handle.createUpdate("""
                 DELETE FROM favourites
                 WHERE user_id=:user_id AND product_id=:product_id
                """).bind("user_id", idUser).bind("product_id", idProduct).execute() > 0);
    }

    public List<Favourite> getByUserID(int id) {
        return jdbi.withHandle(handle -> {
            return handle.createQuery("select id, product_id,user_id from favourites where user_id=:id")
                    .bind("user_id", id).mapToBean(Favourite.class).list();
        });
    }

    public List<Favourite> getByProductID(String id) {
        return jdbi.withHandle(handle -> {
            return handle.createQuery("select id, product_id,user_id from favourites where product_id=:id")
                    .bind("product_id", id).mapToBean(Favourite.class).list();
        });
    }

    public List<Map<String, Object>> getFavouritesWithProductsByUserID(int userId) {
        return jdbi.withHandle(handle -> {
            return handle
                    .createQuery(
                            """
                                    SELECT f.id AS favourite_id, f.user_id,
                                    p.id AS product_id, p.product_name, p.slug, p.price, p.capacity, p.alcohol,
                                    p.origin, p.detail, p.create_at, p.update_at,
                                    t.type_name AS type_name, m.manufacturer_name AS manufacturer_name,
                                    c.category_name AS category_name,
                                    d.discount_value AS discount_value, d.discount_type AS discount_type,
                                    (SELECT pi.url_img FROM p_img pi WHERE pi.product_id = p.id LIMIT 1) AS image_url
                                    FROM favourites f
                                    JOIN products p ON f.product_id = p.id
                                    LEFT JOIN product_types t ON p.type_id = t.id
                                    LEFT JOIN manufacturers m ON p.manufacturer_id = m.id
                                    LEFT JOIN categorys c ON p.category_id = c.id
                                    LEFT JOIN dis_process dp ON p.id = dp.product_id AND dp.is_delete = 0
                                    LEFT JOIN discounts d ON dp.discount_id = d.id AND d.is_active = 1 AND d.is_delete = 0 AND NOW() BETWEEN d.discount_from AND d.discount_to
                                    WHERE f.user_id = :userId AND p.is_delete = 0
                                    ORDER BY f.id DESC
                                    """)
                    .bind("userId", userId)
                    .mapToMap()
                    .list();
        });
    }

    public List<java.util.Map<String, Object>> getTopFavouritedProducts(int limit) {
        return jdbi.withHandle(handle -> {
            return handle
                    .createQuery(
                            """
                                    SELECT p.id AS product_id, p.product_name,  p.price, p.capacity, p.alcohol,
                                    p.origin,
                                    t.type_name AS type_name, m.manufacturer_name AS manufacturer_name,
                                    c.category_name AS category_name,
                                    d.discount_value AS discount_value, d.discount_type AS discount_type,
                                    (SELECT pi.url_img FROM p_img pi WHERE pi.product_id = p.id LIMIT 1) AS image_url,
                                    COUNT(f.id) AS favorite_count
                                    FROM products p
                                    LEFT JOIN favourites f ON p.id = f.product_id
                                    LEFT JOIN product_types t ON p.type_id = t.id
                                    LEFT JOIN manufacturers m ON p.manufacturer_id = m.id
                                    LEFT JOIN categorys c ON p.category_id = c.id
                                    LEFT JOIN dis_process dp ON p.id = dp.product_id AND dp.is_delete = 0
                                    LEFT JOIN discounts d ON dp.discount_id = d.id AND d.is_active = 1 AND d.is_delete = 0 AND NOW() BETWEEN d.discount_from AND d.discount_to
                                    WHERE p.is_delete = 0
                                    GROUP BY p.id, p.product_name, p.slug, p.price, p.capacity, p.alcohol,
                                             p.origin, p.detail,
                                             t.type_name, m.manufacturer_name, c.category_name,
                                             d.discount_value, d.discount_type
                                    HAVING COUNT(f.id) > 0
                                    ORDER BY favorite_count DESC, p.id DESC
                                    LIMIT :limit
                                    """)
                    .bind("limit", limit)
                    .mapToMap()
                    .list();
        });
    }
}
