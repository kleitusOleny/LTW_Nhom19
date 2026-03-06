package dao;

import model.Order;
import model.OrderViewModel;

import java.sql.Timestamp;
import java.sql.Types;
import java.util.List;

public class OrderDAO extends ADAO implements IDAO<Order> {

    @Override
    public List<Order> getAll() {
        return jdbi.withHandle(
                handle -> handle.createQuery("SELECT * FROM orders WHERE is_delete IS NULL")
                        .mapToBean(Order.class)
                        .list());
    }

    @Override
    public Order findById(Order id) {
        return null;
    }

    public Order findById(int id) {
        return jdbi.withHandle(handle -> handle
                .createQuery("SELECT * FROM orders WHERE id = :id AND is_delete IS NULL")
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
                                    (user_id, shipping_address_id, discount_id, shipping_discount_id, voucher_discount_id, loyalty_discount_id, total_price, create_at, update_at, is_delete, note)
                                    VALUES (:user_id, :shipping_address_id, :discount_id, :shipping_discount_id, :voucher_discount_id, :loyalty_discount_id, :total_price, :create_at, :update_at, :is_delete, :note)
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

            if (entity.getShippingDiscountId() == 0)
                update.bindNull("shipping_discount_id", Types.INTEGER);
            else
                update.bind("shipping_discount_id", entity.getShippingDiscountId());

            if (entity.getVoucherDiscountId() == 0)
                update.bindNull("voucher_discount_id", Types.INTEGER);
            else
                update.bind("voucher_discount_id", entity.getVoucherDiscountId());

            if (entity.getLoyaltyDiscountId() == 0)
                update.bindNull("loyalty_discount_id", Types.INTEGER);
            else
                update.bind("loyalty_discount_id", entity.getLoyaltyDiscountId());

            if (entity.isDelete()) {
                update.bind("is_delete", new Timestamp(System.currentTimeMillis()));
            } else {
                update.bindNull("is_delete", Types.TIMESTAMP);
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
                                    (user_id, shipping_address_id, discount_id, shipping_discount_id, voucher_discount_id, loyalty_discount_id, total_price, create_at, update_at, is_delete, note)
                                    VALUES (:user_id, :shipping_address_id, :discount_id, :shipping_discount_id, :voucher_discount_id, :loyalty_discount_id, :total_price, :create_at, :update_at, :is_delete, :note)
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

            if (entity.getShippingDiscountId() == 0)
                update.bindNull("shipping_discount_id", Types.INTEGER);
            else
                update.bind("shipping_discount_id", entity.getShippingDiscountId());

            if (entity.getVoucherDiscountId() == 0)
                update.bindNull("voucher_discount_id", Types.INTEGER);
            else
                update.bind("voucher_discount_id", entity.getVoucherDiscountId());

            if (entity.getLoyaltyDiscountId() == 0)
                update.bindNull("loyalty_discount_id", Types.INTEGER);
            else
                update.bind("loyalty_discount_id", entity.getLoyaltyDiscountId());

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
                update.bind("is_delete", new Timestamp(System.currentTimeMillis()));
            } else {
                update.bindNull("is_delete", Types.TIMESTAMP);
            }

            return update.execute() > 0;
        });
    }

    @Override
    public boolean delete(Order entity) {
        return jdbi.withHandle(handle -> handle.createUpdate("""
                UPDATE orders
                SET is_delete = NOW(), update_at = NOW()
                WHERE id = :id
                """)
                .bind("id", entity.getId())
                .execute() > 0);
    }

    @Override
    public List<Order> search(String keyword) {
        return jdbi.withHandle(handle -> handle.createQuery("""
                SELECT * FROM orders
                WHERE is_delete IS NULL
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
                                "SELECT COUNT(*) FROM orders WHERE id = :id AND is_delete IS NULL")
                        .bind("id", entity.getId())
                        .mapTo(Integer.class)
                        .findFirst().isPresent());
    }

    public List<Order> getByUserId(int userId) {
        return jdbi.withHandle(handle -> handle.createQuery("""
                SELECT * FROM orders
                WHERE user_id = :uid AND is_delete IS NULL
                ORDER BY create_at DESC
                """)
                .bind("uid", userId)
                .mapToBean(Order.class)
                .list());
    }

    public Order getLatestOrder(int userId) {
        return jdbi.withHandle(handle -> handle.createQuery("""
                SELECT * FROM orders
                WHERE user_id = :uid AND is_delete IS NULL
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
                        "SELECT COUNT(*) FROM orders WHERE user_id = :uid AND is_delete IS NULL")
                        .bind("uid", userId)
                        .mapTo(Integer.class).findFirst().orElse(null));
    }

    public List<java.util.Map<String, Object>> getOrdersWithItemsByUserId(int userId) {
        return jdbi.withHandle(handle -> {
            return handle.createQuery("""
                        SELECT o.id as order_id, o.total_price, o.create_at,
                               oi.product_id, oi.quantity, oi.unit_price,
                               p.product_name,
                               (SELECT pi.url_img FROM p_img pi
                                WHERE pi.product_id = p.id LIMIT 1) as image_url
                        FROM orders o
                        LEFT JOIN order_items oi ON o.id = oi.order_id
                        LEFT JOIN products p ON oi.product_id = p.id
                        WHERE o.user_id = :userId AND o.is_delete IS NULL
                        ORDER BY o.create_at DESC, oi.product_id
                    """)
                    .bind("userId", userId)
                    .mapToMap()
                    .list();
        });
    }

    public List<OrderViewModel> getAllOrdersWithStatus() {
        return jdbi.withHandle(handle -> handle.createQuery("""
                SELECT o.id, o.create_at, o.total_price,
                       COALESCE(a.full_name, u.full_name) as customerName,
                       s.status as status,
                       pm.pay_strategy as payStrategy
                FROM orders o
                LEFT JOIN users u ON o.user_id = u.id
                LEFT JOIN addresses a ON o.shipping_address_id = a.id
                LEFT JOIN ship_orders s ON o.id = s.order_id
                LEFT JOIN payments pm ON o.id = pm.order_id
                WHERE o.is_delete IS NULL
                ORDER BY o.create_at DESC
                """)
                .mapToBean(OrderViewModel.class)
                .list());
    }

    public List<java.util.Map<String, Object>> getOrderItems(int orderId) {
        return jdbi.withHandle(handle -> handle.createQuery("""
                SELECT oi.*, p.product_name,
                       (SELECT url_img FROM p_img WHERE product_id = p.id LIMIT 1) as url_img
                FROM order_items oi
                JOIN products p ON oi.product_id = p.id
                WHERE oi.order_id = :orderId
                """)
                .bind("orderId", orderId)
                .mapToMap()
                .list());
    }

    public java.util.Map<String, Object> getOrderInfo(int orderId) {
        return jdbi.withHandle(handle -> handle.createQuery("""
                SELECT o.id, o.user_id, o.shipping_address_id, o.discount_id, 
                       o.total_price, o.create_at, o.update_at, o.is_delete,
                       COALESCE(a.full_name, u.full_name) as full_name,
                       COALESCE(a.phone_number, u.phone_number) as phone_number,
                       CASE 
                           WHEN o.note LIKE 'EMAIL:%' THEN 
                               CASE 
                                   WHEN LOCATE(' | Ghi chú: ', o.note) > 0 
                                   THEN SUBSTRING(o.note, 7, LOCATE(' | Ghi chú: ', o.note) - 7)
                                   ELSE SUBSTRING(o.note, 7)
                               END
                           ELSE u.email
                       END as email,
                       CASE 
                           WHEN o.note LIKE 'EMAIL:%' AND LOCATE(' | Ghi chú: ', o.note) > 0 
                           THEN SUBSTRING(o.note, LOCATE(' | Ghi chú: ', o.note) + 13)
                           WHEN o.note NOT LIKE 'EMAIL:%' THEN o.note
                           ELSE ''
                       END as note,
                       s.status as ship_status, s.carrier_name,
                       a.address_line as specific_address, a.ward, a.city,
                       pm.pay_strategy,
                       (SELECT NULL) as district, (SELECT NULL) as province_city
                FROM orders o
                LEFT JOIN users u ON o.user_id = u.id
                LEFT JOIN ship_orders s ON o.id = s.order_id
                LEFT JOIN addresses a ON o.shipping_address_id = a.id
                LEFT JOIN payments pm ON o.id = pm.order_id
                WHERE o.id = :orderId
                """)
                .bind("orderId", orderId)
                .mapToMap()
                .findFirst().orElse(null));
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
