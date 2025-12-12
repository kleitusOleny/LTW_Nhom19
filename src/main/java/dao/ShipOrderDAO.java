package dao;

import model.ShipOrder;

import java.util.List;

public class ShipOrderDAO extends ADAO implements IDAO<ShipOrder> {

    @Override
    public List<ShipOrder> getAll() {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM ship_orders")
                        .mapToBean(ShipOrder.class)
                        .list()
        );
    }

    @Override
    public ShipOrder findById(ShipOrder entity) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM ship_orders WHERE id = :id")
                        .bind("id", entity.getId())
                        .mapToBean(ShipOrder.class)
                        .findFirst()
                        .orElse(null)
        );
    }

    @Override
    public boolean create(ShipOrder entity) {
        return jdbi.withHandle(handle ->
                handle.createUpdate("""
                                INSERT INTO ship_orders 
                                (order_id, carrier_name, tracking_number, shipping_fee, status, estimated_delivery_date)
                                VALUES (:order_id, :carrier_name, :tracking_number, :shipping_fee, :status, :estimated_delivery_date)
                                """)
                        .bind("order_id", entity.getOrderId())
                        .bind("carrier_name", entity.getCarrierName())
                        .bind("tracking_number", entity.getTrackingNumber())
                        .bind("shipping_fee", entity.getShippingFee())
                        .bind("status", entity.getStatus())
                        .bind("estimated_delivery_date", entity.getEstimatedDeliveryDate())
                        .execute() > 0
        );
    }

    @Override
    public boolean update(ShipOrder entity) {
        return jdbi.withHandle(handle ->
                handle.createUpdate("""
                                UPDATE ship_orders SET
                                    order_id = :order_id,
                                    carrier_name = :carrier_name,
                                    tracking_number = :tracking_number,
                                    shipping_fee = :shipping_fee,
                                    status = :status,
                                    estimated_delivery_date = :estimated_delivery_date
                                WHERE id = :id
                                """)
                        .bind("id", entity.getId())
                        .bind("order_id", entity.getOrderId())
                        .bind("carrier_name", entity.getCarrierName())
                        .bind("tracking_number", entity.getTrackingNumber())
                        .bind("shipping_fee", entity.getShippingFee())
                        .bind("status", entity.getStatus())
                        .bind("estimated_delivery_date", entity.getEstimatedDeliveryDate())
                        .execute() > 0
        );
    }

    @Override
    public boolean delete(ShipOrder entity) {
        return jdbi.withHandle(handle ->
                handle.createUpdate("DELETE FROM ship_orders WHERE id = :id")
                        .bind("id", entity.getId())
                        .execute() > 0
        );
    }

    @Override
    public List<ShipOrder> search(String keyword) {
        return jdbi.withHandle(handle ->
                handle.createQuery("""
                                SELECT * FROM ship_orders
                                WHERE carrier_name LIKE :kw
                                OR tracking_number LIKE :kw
                                OR status LIKE :kw
                                """)
                        .bind("kw", "%" + keyword + "%")
                        .mapToBean(ShipOrder.class)
                        .list()
        );
    }

    @Override
    public boolean exists(ShipOrder entity) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT COUNT(*) FROM ship_orders WHERE id = :id")
                        .bind("id", entity.getId())
                        .mapTo(Integer.class)
                        .findFirst().isPresent()
        );
    }


    public ShipOrder getByOrderId(int orderId) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM ship_orders WHERE order_id = :oid")
                        .bind("oid", orderId)
                        .mapToBean(ShipOrder.class)
                        .findFirst()
                        .orElse(null)
        );
    }

    public boolean updateStatus(int orderId, String status) {
        return jdbi.withHandle(handle ->
                handle.createUpdate("""
                                UPDATE ship_orders
                                SET status = :status
                                WHERE order_id = :oid
                                """)
                        .bind("status", status)
                        .bind("oid", orderId)
                        .execute() > 0
        );
    }

    public ShipOrder findByTracking(String trackingNumber) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM ship_orders WHERE tracking_number = :tn")
                        .bind("tn", trackingNumber)
                        .mapToBean(ShipOrder.class)
                        .findFirst()
                        .orElse(null)
        );
    }
}
