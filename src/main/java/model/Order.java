package model;

import org.jdbi.v3.core.mapper.reflect.ColumnName;

import java.sql.Timestamp;
import java.util.List;

public class Order {
    @ColumnName("id")
    private int id;

    @ColumnName("user_id")
    private int userId;

    @ColumnName("shipping_address_id")
    private int shippingAddressId;

    @ColumnName("discount_id")
    private int discountId;

    @ColumnName("shipping_discount_id")
    private int shippingDiscountId;

    @ColumnName("voucher_discount_id")
    private int voucherDiscountId;

    @ColumnName("loyalty_discount_id")
    private int loyaltyDiscountId;

    @ColumnName("total_price")
    private double totalPrice;

    @ColumnName("create_at")
    private Timestamp createAt;

    @ColumnName("update_at")
    private Timestamp updateAt;

    @ColumnName("is_delete")
    private boolean isDelete;

    @ColumnName("note")
    private String note;

    private List<OrderItem> items;

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public java.util.List<OrderItem> getItems() {
        return items;
    }

    public void setItems(java.util.List<OrderItem> items) {
        this.items = items;
    }

    public Order() {
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

    public int getShippingAddressId() {
        return shippingAddressId;
    }

    public void setShippingAddressId(int shippingAddressId) {
        this.shippingAddressId = shippingAddressId;
    }

    public int getDiscountId() {
        return discountId;
    }

    public void setDiscountId(int discountId) {
        this.discountId = discountId;
    }

    public int getShippingDiscountId() {
        return shippingDiscountId;
    }

    public void setShippingDiscountId(int shippingDiscountId) {
        this.shippingDiscountId = shippingDiscountId;
    }

    public int getVoucherDiscountId() {
        return voucherDiscountId;
    }

    public void setVoucherDiscountId(int voucherDiscountId) {
        this.voucherDiscountId = voucherDiscountId;
    }

    public int getLoyaltyDiscountId() {
        return loyaltyDiscountId;
    }

    public void setLoyaltyDiscountId(int loyaltyDiscountId) {
        this.loyaltyDiscountId = loyaltyDiscountId;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
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
