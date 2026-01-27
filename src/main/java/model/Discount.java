package model;

import org.jdbi.v3.core.mapper.reflect.ColumnName;

import java.sql.Timestamp;

public class Discount {
    @ColumnName("id")
    private int id;

    @ColumnName("discount_code")
    private String discountCode;

    @ColumnName("discount_type")
    private String discountType;

    @ColumnName("discount_value")
    private double discountValue;

    @ColumnName("discount_from")
    private Timestamp discountFrom;

    @ColumnName("discount_to")
    private Timestamp discountTo;

    @ColumnName("apply_type")
    private String applyType;

    @ColumnName("is_active")
    private boolean isActive;

    @ColumnName("create_at")
    private Timestamp createAt;

    @ColumnName("update_at")
    private Timestamp updateAt;

    @ColumnName("is_delete")
    private boolean isDelete;

    @ColumnName("quantity")
    private int quantity;

    public Discount() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDiscountCode() {
        return discountCode;
    }

    public void setDiscountCode(String discountCode) {
        this.discountCode = discountCode;
    }

    public String getDiscountType() {
        return discountType;
    }

    public void setDiscountType(String discountType) {
        this.discountType = discountType;
    }

    public double getDiscountValue() {
        return discountValue;
    }

    public void setDiscountValue(double discountValue) {
        this.discountValue = discountValue;
    }

    public Timestamp getDiscountFrom() {
        return discountFrom;
    }

    public void setDiscountFrom(Timestamp discountFrom) {
        this.discountFrom = discountFrom;
    }

    public Timestamp getDiscountTo() {
        return discountTo;
    }

    public void setDiscountTo(Timestamp discountTo) {
        this.discountTo = discountTo;
    }

    public boolean isActive() {
        return isActive;
    }

    public boolean getIsActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }

    public void setIsActive(boolean active) {
        isActive = active;
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

    public String getApplyType() {
        return applyType;
    }

    public void setApplyType(String applyType) {
        this.applyType = applyType;
    }

    public boolean getIsDelete() {
        return isDelete;
    }

    public void setIsDelete(boolean isDelete) {
        this.isDelete = isDelete;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
}