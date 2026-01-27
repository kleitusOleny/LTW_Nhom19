package dao;

import model.Order;

import java.sql.Timestamp;
import java.sql.Types;
import java.util.List;

public class OrderDAO extends ADAO implements IDAO<Order> {

    @Override
    public List<Order> getAll() {
        return jdbi.withHandle(
                handle -> handle.createQuery("SELECT * FROM orders WHERE (is_delete = 0 OR is_delete IS NULL)")
                        .mapToBean(Order.class)
                        .list());
    }

    @Override
    public Order findById(Order id) {
        return null;
    }

    public Order findById(int id) {
        return jdbi.withHandle(handle -> handle
                .createQuery("SELECT * FROM orders WHERE id = :id AND (is_delete = 0 OR is_delete IS NULL)")
                .bind("id", id)
                .mapToBean(Order.class)
                .findFirst()
                .orElse(null));
    }

    @Override
    public boolean create(Order entity) {
        return jdbi.withHandle(handle -> {
            var update = handle
                    .createUpdate(
                            """
                                    INSERT INTO orders
                                    (user_id, shipping_address_id, discount_id, total_price, create_at, update_at, is_delete, note)
                                    VALUES (:user_id, :shipping_address_id, :discount_id, :total_price, :create_at, :update_at, :is_delete, :note)
                                    """)
                    .bind("user_id", entity.getUserId())
                    .bind("shipping_address_id", entity.getShippingAddressId())
                    .bind("total_price", entity.getTotalPrice())
                    .bind("create_at", entity.getCreateAt())
                    .bind("update_at", entity.getUpdateAt())
                    .bind("note", entity.getNote());

            if (entity.getDiscountId() == 0) {
                update.bindNull("discount_id", java.sql.Types.INTEGER);
            } else {
                update.bind("discount_id", entity.getDiscountId());
            }

            if (entity.isDelete()) {
                update.bind("is_delete", new java.sql.Timestamp(System.currentTimeMillis()));
            } else {
                update.bindNull("is_delete", java.sql.Types.TIMESTAMP);
            }

            return update.execute() > 0;
        });
    }

    public int createAndReturnId(Order entity) {
        return jdbi.withHandle(handle -> {
            var update = handle
                    .createUpdate(
                            """
                                    INSERT INTO orders
                                    (user_id, shipping_address_id, discount_id, total_price, create_at, update_at, is_delete, note)
                                    VALUES (:user_id, :shipping_address_id, :discount_id, :total_price, :create_at, :update_at, :is_delete, :note)
                                    """)
                    .bind("user_id", entity.getUserId())
                    .bind("shipping_address_id", entity.getShippingAddressId())
                    .bind("total_price", entity.getTotalPrice())
                    .bind("create_at", entity.getCreateAt())
                    .bind("update_at", entity.getUpdateAt())
                    .bind("note", entity.getNote());

            if (entity.getDiscountId() == 0) {
                update.bindNull("discount_id", Types.INTEGER);
            } else {
                update.bind("discount_id", entity.getDiscountId());
            }

            if (entity.isDelete()) {
                update.bind("is_delete", new Timestamp(System.currentTimeMillis()));
            } else {
                update.bindNull("is_delete", Types.TIMESTAMP);
            }

            return update.executeAndReturnGeneratedKeys("id")
                    .mapTo(Integer.class)
                    .one();
        });
    }

    @Override
    public boolean update(Order entity) {
        return jdbi.withHandle(handle -> {
            var update = handle.createUpdate("""
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
                    .bind("update_at", entity.getUpdateAt());

            if (entity.isDelete()) {
                update.bind("is_delete", new java.sql.Timestamp(System.currentTimeMillis()));
            } else {
                update.bindNull("is_delete", java.sql.Types.TIMESTAMP);
            }

            return update.execute() > 0;
        });
    }

    @Override
    public boolean delete(Order entity) {
        return jdbi.withHandle(handle -> handle.createUpdate("""
                UPDATE orders
                SET is_delete = 1, update_at = NOW()
                WHERE id = :id
                """)
                .bind("id", entity.getId())
                .execute() > 0);
    }

    @Override
    public List<Order> search(String keyword) {
        return jdbi.withHandle(handle -> handle.createQuery("""
                SELECT * FROM orders
                WHERE (is_delete = 0 OR is_delete IS NULL)
                AND (CAST(id AS CHAR) LIKE :kw OR CAST(user_id AS CHAR) LIKE :kw)
                """)
                .bind("kw", "%" + keyword + "%")
                .mapToBean(Order.class)
                .list());
    }

    @Override
    public boolean exists(Order entity) {
        return jdbi
                .withHandle(handle -> handle
                        .createQuery(
                                "SELECT COUNT(*) FROM orders WHERE id = :id AND (is_delete = 0 OR is_delete IS NULL)")
                        .bind("id", entity.getId())
                        .mapTo(Integer.class)
                        .findFirst().isPresent());
    }

    public List<Order> getByUserId(int userId) {
        return jdbi.withHandle(handle -> handle.createQuery("""
                SELECT * FROM orders
                WHERE user_id = :uid AND (is_delete = 0 OR is_delete IS NULL)
                ORDER BY create_at DESC
                """)
                .bind("uid", userId)
                .mapToBean(Order.class)
                .list());
    }

    public Order getLatestOrder(int userId) {
        return jdbi.withHandle(handle -> handle.createQuery("""
                SELECT * FROM orders
                WHERE user_id = :uid AND (is_delete = 0 OR is_delete IS NULL)
                ORDER BY create_at DESC
                LIMIT 1
                """)
                .bind("uid", userId)
                .mapToBean(Order.class)
                .findFirst().orElse(null));
    }

    public int countOrdersOfUser(int userId) {
        return jdbi.withHandle(
                handle -> handle.createQuery(
                        "SELECT COUNT(*) FROM orders WHERE user_id = :uid AND (is_delete = 0 OR is_delete IS NULL)")
                        .bind("uid", userId)
                        .mapTo(Integer.class).findFirst().orElse(null));
    }

    public List<java.util.Map<String, Object>> getOrdersWithItemsByUserId(int userId) {
        return jdbi.withHandle(handle -> {
            return handle.createQuery("""
                        SELECT o.id as order_id, o.total_price, o.create_at,
                               oi.product_id, oi.quantity, oi.unit_price,
                               p.product_name,
                               (SELECT pi.url_img FROM product_img pi
                                WHERE pi.product_id = p.id LIMIT 1) as image_url
                        FROM orders o
                        LEFT JOIN order_items oi ON o.id = oi.order_id
                        LEFT JOIN products p ON oi.product_id = p.id
                        WHERE o.user_id = :userId AND (o.is_delete = 0 OR o.is_delete IS NULL)
                        ORDER BY o.create_at DESC, oi.product_id
                    """)
                    .bind("userId", userId)
                    .mapToMap()
                    .list();
        });
    }

    public int countOrderIdLastWeek() {
        return jdbi.withHandle(handle -> handle.createQuery("SELECT COUNT(id) FROM orders WHERE create_at >= DATE_SUB(NOW(), INTERVAL 7 DAY) AND is_delete = 0")
                .mapTo(Integer.class)
                .findOnly());
    }

    public double sumTotalPriceLastMonth() {
        return jdbi.withHandle(handle -> handle.createQuery("SELECT SUM(total_price) FROM orders WHERE create_at >= DATE_SUB(NOW(), INTERVAL 1 MONTH) AND is_delete = 0")
                .mapTo(Double.class)
                .findOne().orElse(0.0));
    }
}
