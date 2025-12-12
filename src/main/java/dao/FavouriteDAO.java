package dao;

import model.Address;
import model.Favourite;

import java.util.List;

public class FavouriteDAO extends ADAO implements IDAO<Favourite> {
    @Override
    public List<Favourite> getAll() {
        return jdbi.withHandle(handle -> {
            return handle.createQuery("select * from favourites where is_delete = 0").mapToBean(Favourite.class).list();
        });
    }

    @Override
    public Favourite findById(Favourite id) {
        return null;
    }

    @Override
    public boolean create(Favourite entity) {
        return jdbi.withHandle(handle -> handle.createUpdate("""
                INSERT INTO favourites (product_id,user_id) VALUES (:product_id, :user_id)
                """).bind("product_id", entity.getProductId()).bind("user_id", entity.getUserId()).execute() > 0);
    }

    @Override
    public boolean update(Favourite entity) {
        return false;
    }

    @Override
    public boolean delete(Favourite id) {
        return jdbi.withHandle(handle -> handle.createUpdate("""
                 DELETE FROM favourites
                 WHERE user_id=:uid AND id=:id AND product_id=:pid
                """).bind("user_id", id.getUserId()).bind("id", id.getId()).bind("product_id", id.getProductId()).execute() > 0);
    }

    @Override
    public List<Favourite> search(String keyword) {
        return List.of();
    }

    @Override
    public boolean exists(Favourite id) {
        return false;
    }

    public List<Favourite> getByUserID(int id) {
        return jdbi.withHandle(handle -> {
            return handle.createQuery("select id, product_id,user_id from favourites where user_id=:id").bind("user_id", id).mapToBean(Favourite.class).list();
        });
    }

    public List<Favourite> getByProductID(int id) {
        return jdbi.withHandle(handle -> {
            return handle.createQuery("select id, product_id,user_id from favourites where product_id=:id").bind("product_id", id).mapToBean(Favourite.class).list();
        });
    }
}
