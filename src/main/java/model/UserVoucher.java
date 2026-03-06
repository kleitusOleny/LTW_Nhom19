package model;

import org.jdbi.v3.core.mapper.reflect.ColumnName;

import java.io.Serializable;
import java.sql.Timestamp;

public class UserVoucher implements Serializable {
    @ColumnName("id")
    private int id;

    @ColumnName("user_id")
    private int userId;

    @ColumnName("discount_id")
    private int discountId;

    @ColumnName("is_used")
    private boolean isUsed;

    @ColumnName("created_at")
    private Timestamp createdAt;

    public UserVoucher() {
    }

    public UserVoucher(int userId, int discountId) {
        this.userId = userId;
        this.discountId = discountId;
        this.isUsed = false;
        this.createdAt = new Timestamp(System.currentTimeMillis());
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getDiscountId() {
        return discountId;
    }

    public void setDiscountId(int discountId) {
        this.discountId = discountId;
    }

    public boolean isUsed() {
        return isUsed;
    }

    public void setUsed(boolean used) {
        isUsed = used;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}
