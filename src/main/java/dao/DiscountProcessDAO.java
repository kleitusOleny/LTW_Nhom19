package dao;

import org.jdbi.v3.core.Handle;

import java.util.List;

public class DiscountProcessDAO extends ADAO {

    public ApplyResult applyDiscountToProducts(int discountId, List<String> productIds) {
        return jdbi.inTransaction(handle -> upsertProcesses(handle, discountId, productIds));
    }

    private ApplyResult upsertProcesses(Handle handle, int discountId, List<String> productIds) {
        int inserted = 0;
        int reactivated = 0;
        if (productIds == null || productIds.isEmpty()) {
            return new ApplyResult(inserted, reactivated);
        }

        for (String productId : productIds) {
            int updated = handle.createUpdate("""
                            UPDATE dis_process
                            SET is_delete = 0,
                                update_at = NOW()
                            WHERE discount_id = :discountId
                              AND product_id = :productId
                              AND is_delete = 1
                            """)
                    .bind("discountId", discountId)
                    .bind("productId", productId)
                    .execute();

            if (updated > 0) {
                reactivated += updated;
                continue;
            }

            int insertedRows = handle.createUpdate("""
                            INSERT INTO dis_process (product_id, discount_id, create_at, update_at, is_delete)
                            VALUES (:productId, :discountId, NOW(), NOW(), 0)
                            ON DUPLICATE KEY UPDATE update_at = VALUES(update_at), is_delete = 0
                            """)
                    .bind("discountId", discountId)
                    .bind("productId", productId)
                    .execute();

            if (insertedRows > 0) {
                inserted++;
            }
        }

        return new ApplyResult(inserted, reactivated);
    }

    public static class ApplyResult {
        private final int inserted;
        private final int reactivated;

        public ApplyResult(int inserted, int reactivated) {
            this.inserted = inserted;
            this.reactivated = reactivated;
        }

        public int getInserted() {
            return inserted;
        }

        public int getReactivated() {
            return reactivated;
        }
    }
}
