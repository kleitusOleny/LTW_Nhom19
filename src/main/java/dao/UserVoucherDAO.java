package dao;

import model.UserVoucher;
import java.util.List;

public class UserVoucherDAO extends ADAO implements IDAO<UserVoucher> {

    @Override
    public List<UserVoucher> getAll() {
        return jdbi.withHandle(handle -> handle.createQuery("SELECT * FROM user_vouchers")
                .mapToBean(UserVoucher.class)
                .list());
    }

    @Override
    public UserVoucher findById(UserVoucher entity) {
        return jdbi.withHandle(handle -> handle.createQuery("SELECT * FROM user_vouchers WHERE id = :id")
                .bind("id", entity.getId())
                .mapToBean(UserVoucher.class)
                .findFirst()
                .orElse(null));
    }

    public List<UserVoucher> findByUserId(int userId) {
        return jdbi.withHandle(
                handle -> handle.createQuery("SELECT * FROM user_vouchers WHERE user_id = :userId AND is_used = 0")
                        .bind("userId", userId)
                        .mapToBean(UserVoucher.class)
                        .list());
    }

    @Override
    public boolean create(UserVoucher entity) {
        return jdbi.withHandle(handle -> handle.createUpdate(
                "INSERT INTO user_vouchers (user_id, discount_id, is_used, created_at) VALUES (:userId, :discountId, :used, :createdAt)")
                .bindBean(entity)
                .execute() > 0);
    }

    @Override
    public boolean update(UserVoucher entity) {
        return jdbi
                .withHandle(handle -> handle.createUpdate("UPDATE user_vouchers SET is_used = :isUsed WHERE id = :id")
                        .bind("isUsed", entity.isUsed())
                        .bind("id", entity.getId())
                        .execute() > 0);
    }

    public boolean markAsUsed(int id) {
        return jdbi.withHandle(handle -> handle.createUpdate("UPDATE user_vouchers SET is_used = 1 WHERE id = :id")
                .bind("id", id)
                .execute() > 0);
    }

    @Override
    public boolean delete(UserVoucher entity) {
        return jdbi.withHandle(handle -> handle.createUpdate("DELETE FROM user_vouchers WHERE id = :id")
                .bind("id", entity.getId())
                .execute() > 0);
    }

    @Override
    public List<UserVoucher> search(String keyword) {
        return null;
    }

    @Override
    public boolean exists(UserVoucher entity) {
        return findById(entity) != null;
    }
}
