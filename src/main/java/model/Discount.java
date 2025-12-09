package model;

import java.sql.Timestamp;
import java.math.BigDecimal;

public class Discount {
    private int id;
    private String discountCode;
    private String discountType;
    private BigDecimal discountValue;
    private Timestamp discountFrom;
    private Timestamp discountTo;
    private boolean isActive;
    private Timestamp createAt;
    private Timestamp updateAt;
    private boolean isDelete;

    // Constructor rỗng
    public Discount() {
    }

    // Getter và Setter
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

    public BigDecimal getDiscountValue() {
        return discountValue;
    }

    public void setDiscountValue(BigDecimal discountValue) {
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

    public void setActive(boolean active) {
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

    public boolean getIsDelete() {
        return isDelete;
    }

    public void setIsDelete(boolean isDelete) {
        this.isDelete = isDelete;
    }
}