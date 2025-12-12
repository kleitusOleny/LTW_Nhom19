package dao;

import model.OrderItem;

import java.util.List;

public class OrderItemDAO extends ADAO implements IDAO<OrderItem> {

    @Override
    public List<OrderItem> getAll() {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM order_items")
                        .mapToBean(OrderItem.class)
                        .list()
        );
    }

    @Override
    public OrderItem findById(OrderItem entity) {
        return jdbi.withHandle(handle ->
                handle.createQuery("""
                                SELECT * FROM order_items
                                WHERE order_id = :oid AND product_id = :pid
                                """)
                        .bind("oid", entity.getOrderId())
                        .bind("pid", entity.getProductId())
                        .mapToBean(OrderItem.class)
                        .findFirst()
                        .orElse(null)
        );
    }

    @Override
    public boolean create(OrderItem entity) {
        return jdbi.withHandle(handle ->
                handle.createUpdate("""
                                INSERT INTO order_items (order_id, product_id, quantity, unit_price)
                                VALUES (:oid, :pid, :qty, :price)
                                """)
                        .bind("oid", entity.getOrderId())
                        .bind("pid", entity.getProductId())
                        .bind("qty", entity.getQuantity())
                        .bind("price", entity.getUnitPrice())
                        .execute() > 0
        );
    }

    @Override
    public boolean update(OrderItem entity) {
        return jdbi.withHandle(handle ->
                handle.createUpdate("""
                                UPDATE order_items
                                SET quantity = :qty,
                                    unit_price = :price
                                WHERE order_id = :oid AND product_id = :pid
                                """)
                        .bind("oid", entity.getOrderId())
                        .bind("pid", entity.getProductId())
                        .bind("qty", entity.getQuantity())
                        .bind("price", entity.getUnitPrice())
                        .execute() > 0
        );
    }

    @Override
    public boolean delete(OrderItem entity) {
        return jdbi.withHandle(handle ->
                handle.createUpdate("""
                                DELETE FROM order_items
                                WHERE order_id = :oid AND product_id = :pid
                                """)
                        .bind("oid", entity.getOrderId())
                        .bind("pid", entity.getProductId())
                        .execute() > 0
        );
    }

    @Override
    public List<OrderItem> search(String keyword) {
        return jdbi.withHandle(handle ->
                handle.createQuery("""
                                SELECT * FROM order_items
                                WHERE product_id LIKE :kw
                                """)
                        .bind("kw", "%" + keyword + "%")
                        .mapToBean(OrderItem.class)
                        .list()
        );
    }

    @Override
    public boolean exists(OrderItem entity) {
        return jdbi.withHandle(handle ->
                handle.createQuery("""
                                SELECT COUNT(*) 
                                FROM order_items 
                                WHERE order_id = :oid AND product_id = :pid
                                """)
                        .bind("oid", entity.getOrderId())
                        .bind("pid", entity.getProductId())
                        .mapTo(Integer.class)
                        .findFirst().isPresent()
        );
    }

    public List<OrderItem> getByOrderId(int orderId) {
        return jdbi.withHandle(handle ->
                handle.createQuery("""
                                SELECT * FROM order_items
                                WHERE order_id = :oid
                                """)
                        .bind("oid", orderId)
                        .mapToBean(OrderItem.class)
                        .list()
        );
    }

    public boolean deleteByOrderId(int orderId) {
        return jdbi.withHandle(handle ->
                handle.createUpdate("""
                                DELETE FROM order_items
                                WHERE order_id = :oid
                                """)
                        .bind("oid", orderId)
                        .execute() > 0
        );
    }
}
