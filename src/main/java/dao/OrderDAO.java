package dao;

import model.Order;

import java.util.List;

public class OrderDAO extends ADAO implements IDAO<Order> {

    @Override
    public List<Order> getAll() {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM orders WHERE is_delete = 0")
                        .mapToBean(Order.class)
                        .list()
        );
    }

    @Override
    public Order findById(Order entity) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM orders WHERE id = :id AND is_delete = 0")
                        .bind("id", entity.getId())
                        .mapToBean(Order.class)
                        .findFirst()
                        .orElse(null)
        );
    }

    @Override
    public boolean create(Order entity) {
        return jdbi.withHandle(handle ->
                handle.createUpdate("""
                                INSERT INTO orders 
                                (user_id, shipping_address_id, discount_id, total_price, create_at, update_at, is_delete)
                                VALUES (:user_id, :shipping_address_id, :discount_id, :total_price, :create_at, :update_at, :is_delete)
                                """)
                        .bind("user_id", entity.getUserId())
                        .bind("shipping_address_id", entity.getShippingAddressId())
                        .bind("discount_id", entity.getDiscountId())
                        .bind("total_price", entity.getTotalPrice())
                        .bind("create_at", entity.getCreateAt())
                        .bind("update_at", entity.getUpdateAt())
                        .bind("is_delete", entity.isDelete())
                        .execute() > 0
        );
    }

    @Override
    public boolean update(Order entity) {
        return jdbi.withHandle(handle ->
                handle.createUpdate("""
                                UPDATE orders SET
                                    user_id = :user_id,
                                    shipping_address_id = :shipping_address_id,
                                    discount_id = :discount_id,
                                    total_price = :total_price,
                                    update_at = :update_at,
                                    is_delete = :is_delete
                                WHERE id = :id
                                """)
                        .bind("id", entity.getId())
                        .bind("user_id", entity.getUserId())
                        .bind("shipping_address_id", entity.getShippingAddressId())
                        .bind("discount_id", entity.getDiscountId())
                        .bind("total_price", entity.getTotalPrice())
                        .bind("update_at", entity.getUpdateAt())
                        .bind("is_delete", entity.isDelete())
                        .execute() > 0
        );
    }

    @Override
    public boolean delete(Order entity) {
        return jdbi.withHandle(handle ->
                handle.createUpdate("""
                                UPDATE orders 
                                SET is_delete = 1, update_at = NOW()
                                WHERE id = :id
                                """)
                        .bind("id", entity.getId())
                        .execute() > 0
        );
    }

    @Override
    public List<Order> search(String keyword) {
        return jdbi.withHandle(handle ->
                handle.createQuery("""
                                SELECT * FROM orders
                                WHERE is_delete = 0
                                AND (CAST(id AS CHAR) LIKE :kw OR CAST(user_id AS CHAR) LIKE :kw)
                                """)
                        .bind("kw", "%" + keyword + "%")
                        .mapToBean(Order.class)
                        .list()
        );
    }

    @Override
    public boolean exists(Order entity) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT COUNT(*) FROM orders WHERE id = :id AND is_delete = 0")
                        .bind("id", entity.getId())
                        .mapTo(Integer.class)
                        .findFirst().isPresent()
        );
    }

    public List<Order> getByUserId(int userId) {
        return jdbi.withHandle(handle ->
                handle.createQuery("""
                                SELECT * FROM orders
                                WHERE user_id = :uid AND is_delete = 0
                                ORDER BY create_at DESC
                                """)
                        .bind("uid", userId)
                        .mapToBean(Order.class)
                        .list()
        );
    }

    public Order getLatestOrder(int userId) {
        return jdbi.withHandle(handle ->
                handle.createQuery("""
                                SELECT * FROM orders
                                WHERE user_id = :uid AND is_delete = 0
                                ORDER BY create_at DESC
                                LIMIT 1
                                """)
                        .bind("uid", userId)
                        .mapToBean(Order.class)
                        .findFirst().orElse(null)
        );
    }

    public int countOrdersOfUser(int userId) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT COUNT(*) FROM orders WHERE user_id = :uid AND is_delete = 0")
                        .bind("uid", userId)
                        .mapTo(Integer.class).findFirst().orElse(null)
        );
    }
}
