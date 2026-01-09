package dao;

import model.Payment;
import java.util.List;

public class PaymentDAO extends ADAO implements IDAO<Payment> {

    @Override
    public List<Payment> getAll() {
        return jdbi.withHandle(handle -> handle.createQuery("SELECT * FROM payments")
                .mapToBean(Payment.class)
                .list());
    }

    @Override
    public Payment findById(Payment id) {
        return null;
    }

    public Payment findById(int id) {
        return jdbi.withHandle(handle -> handle.createQuery("SELECT * FROM payments WHERE id = :id")
                .bind("id", id)
                .mapToBean(Payment.class)
                .findFirst()
                .orElse(null));
    }
    
    public Payment findByOrderId(int orderId) {
        return jdbi.withHandle(handle -> handle.createQuery("SELECT * FROM payments WHERE order_id = :orderId")
                .bind("orderId", orderId)
                .mapToBean(Payment.class)
                .findFirst()
                .orElse(null));
    }

    @Override
    public boolean create(Payment entity) {
        return jdbi.withHandle(handle -> handle.createUpdate("""
                INSERT INTO payments (order_id, pay_strategy, status, amount, paid_at)
                VALUES (:orderId, :payStrategy, :status, :amount, :paidAt)
                """)
                .bind("orderId", entity.getOrderId())
                .bind("payStrategy", entity.getPayStrategy())
                .bind("status", entity.getStatus())
                .bind("amount", entity.getAmount())
                .bind("paidAt", entity.getPaidAt())
                .execute() > 0);
    }

    @Override
    public boolean update(Payment entity) {
        return jdbi.withHandle(handle -> handle.createUpdate("""
                UPDATE payments SET
                    order_id = :orderId,
                    pay_strategy = :payStrategy,
                    status = :status,
                    amount = :amount,
                    paid_at = :paidAt
                WHERE id = :id
                """)
                .bind("id", entity.getId())
                .bind("orderId", entity.getOrderId())
                .bind("payStrategy", entity.getPayStrategy())
                .bind("status", entity.getStatus())
                .bind("amount", entity.getAmount())
                .bind("paidAt", entity.getPaidAt())
                .execute() > 0);
    }

    @Override
    public boolean delete(Payment entity) {
        return jdbi.withHandle(handle -> handle.createUpdate("DELETE FROM payments WHERE id = :id")
                .bind("id", entity.getId())
                .execute() > 0);
    }

    @Override
    public List<Payment> search(String keyword) {
        return null;
    }

    @Override
    public boolean exists(Payment entity) {
        return findById(entity.getId()) != null;
    }
}
