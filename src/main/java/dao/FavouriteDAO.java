package dao;

import model.Address;
import model.Favourite;

import java.util.List;

public class FavouriteDAO extends ADAO {
    public List<Favourite> getAll() {
        return jdbi.withHandle(handle -> {
            return handle.createQuery("select * from favourites where is_delete = 0").mapToBean(Favourite.class).list();
        });
    }

    public boolean create(int idProduct, int idUser) {
        return jdbi.withHandle(handle -> handle.createUpdate("""
                INSERT INTO favourites (product_id,user_id) VALUES (:product_id, :user_id)
                """).bind("product_id", idProduct).bind("user_id", idUser).execute() > 0);
    }

    public boolean delete(int idFavourite, int idProduct, int idUser) {
        return jdbi.withHandle(handle -> handle.createUpdate("""
                 DELETE FROM favourites
                 WHERE user_id=:uid AND id=:id AND product_id=:pid
                """).bind("user_id", idUser).bind("id", idFavourite).bind("product_id", idProduct).execute() > 0);
    }

    public List<Favourite> getByUserID(int id) {
        return jdbi.withHandle(handle -> {
            return handle.createQuery("select id, product_id,user_id from favourites where user_id=:id")
                    .bind("user_id", id).mapToBean(Favourite.class).list();
        });
    }

    public List<Favourite> getByProductID(int id) {
        return jdbi.withHandle(handle -> {
            return handle.createQuery("select id, product_id,user_id from favourites where product_id=:id")
                    .bind("product_id", id).mapToBean(Favourite.class).list();
        });
    }

    public List<java.util.Map<String, Object>> getFavouritesWithProductsByUserID(int userId) {
        return jdbi.withHandle(handle -> {
            return handle.createQuery("""
                        SELECT f.id as favourite_id, f.user_id,
                               p.id as product_id, p.product_name, p.price, p.origin,
                               p.type_id, p.slug, p.capacity, p.alcohol,
                               (SELECT pi.url_img FROM product_img pi
                                WHERE pi.product_id = p.id LIMIT 1) as image_url
                        FROM favourites f
                        JOIN products p ON f.product_id = p.id
                        WHERE f.user_id = :userId AND p.is_delete = 0
                        ORDER BY f.id DESC
                    """)
                    .bind("userId", userId)
                    .mapToMap()
                    .list();
        });
    }
}
