package dao;

import model.Discount;

import java.util.List;

public class DiscountDAO extends ADAO implements IDAO<Discount> {

    @Override
    public List<Discount> getAll() {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM discounts WHERE is_delete = 0")
                        .mapToBean(Discount.class)
                        .list()
        );
    }

    @Override
    public Discount findById(Discount entity) {
        return jdbi.withHandle(handle ->
                handle.createQuery("""
                                SELECT * FROM discounts
                                WHERE id = :id AND is_delete = 0
                                """)
                        .bind("id", entity.getId())
                        .mapToBean(Discount.class)
                        .findFirst()
                        .orElse(null)
        );
    }

    @Override
    public boolean create(Discount entity) {
        return jdbi.withHandle(handle ->
                handle.createUpdate("""
                                INSERT INTO discounts
                                (discount_code, discount_type, discount_value, discount_from,
                                 discount_to, is_active, create_at, update_at, is_delete)
                                VALUES (:code, :type, :value, :from, :to, :active, :create, :update, :delete)
                                """)
                        .bind("code", entity.getDiscountCode())
                        .bind("type", entity.getDiscountType())
                        .bind("value", entity.getDiscountValue())
                        .bind("from", entity.getDiscountFrom())
                        .bind("to", entity.getDiscountTo())
                        .bind("active", entity.isActive())
                        .bind("create", entity.getCreateAt())
                        .bind("update", entity.getUpdateAt())
                        .bind("delete", entity.getIsDelete())
                        .execute() > 0
        );
    }

    @Override
    public boolean update(Discount entity) {
        return jdbi.withHandle(handle ->
                handle.createUpdate("""
                                UPDATE discounts SET
                                    discount_code = :code,
                                    discount_type = :type,
                                    discount_value = :value,
                                    discount_from = :from,
                                    discount_to = :to,
                                    is_active = :active,
                                    update_at = :update,
                                    is_delete = :delete
                                WHERE id = :id
                                """)
                        .bind("id", entity.getId())
                        .bind("code", entity.getDiscountCode())
                        .bind("type", entity.getDiscountType())
                        .bind("value", entity.getDiscountValue())
                        .bind("from", entity.getDiscountFrom())
                        .bind("to", entity.getDiscountTo())
                        .bind("active", entity.isActive())
                        .bind("update", entity.getUpdateAt())
                        .bind("delete", entity.getIsDelete())
                        .execute() > 0
        );
    }

    @Override
    public boolean delete(Discount entity) {
        return jdbi.withHandle(handle ->
                handle.createUpdate("""
                                UPDATE discounts
                                SET is_delete = 1, update_at = NOW()
                                WHERE id = :id
                                """)
                        .bind("id", entity.getId())
                        .execute() > 0
        );
    }

    @Override
    public List<Discount> search(String keyword) {
        return jdbi.withHandle(handle ->
                handle.createQuery("""
                                SELECT * FROM discounts
                                WHERE is_delete = 0 AND discount_code LIKE :kw
                                """)
                        .bind("kw", "%" + keyword + "%")
                        .mapToBean(Discount.class)
                        .list()
        );
    }

    @Override
    public boolean exists(Discount entity) {
        return jdbi.withHandle(handle ->
                handle.createQuery("""
                                SELECT COUNT(*) FROM discounts
                                WHERE id = :id AND is_delete = 0
                                """)
                        .bind("id", entity.getId())
                        .mapTo(Integer.class)
                        .findFirst().isPresent()
        );
    }

    public Discount findActiveByCode(String code) {
        return jdbi.withHandle(handle ->
                handle.createQuery("""
                                SELECT * FROM discounts
                                WHERE discount_code = :code
                                  AND is_delete = 0
                                  AND is_active = 1
                                  AND NOW() BETWEEN discount_from AND discount_to
                                """)
                        .bind("code", code)
                        .mapToBean(Discount.class)
                        .findFirst()
                        .orElse(null)
        );
    }
}
