package model;

import org.jdbi.v3.core.mapper.reflect.ColumnName;

import java.sql.Timestamp;

public class DiscountProcess {
    @ColumnName("product_id")
    private String productId;

    @ColumnName("discount_id")
    private int discountId;

    @ColumnName("create_at")
    private Timestamp createAt;

    @ColumnName("update_at")
    private Timestamp updateAt;

    @ColumnName("is_delete")
    private boolean isDelete;

    public DiscountProcess() {
    }

    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    public int getDiscountId() {
        return discountId;
    }

    public void setDiscountId(int discountId) {
        this.discountId = discountId;
    }

    public Timestamp getCreateAt() {
        return createAt;
    }

    public void setCreateAt(Timestamp createAt) {
        this.createAt = createAt;
    }

    public Timestamp getUpdateAt() {
        return updateAt;
    }

    public void setUpdateAt(Timestamp updateAt) {
        this.updateAt = updateAt;
    }

    public boolean isDelete() {
        return isDelete;
    }

    public void setDelete(boolean delete) {
        isDelete = delete;
    }
}
