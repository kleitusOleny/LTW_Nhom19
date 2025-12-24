package model;

import org.jdbi.v3.core.mapper.reflect.ColumnName;

import java.math.BigDecimal;

public class OrderItem {
    @ColumnName("id")
    private int orderId;

    @ColumnName("product_id")
    private String productId;

    @ColumnName("quantity")
    private int quantity;

    @ColumnName("unit_price")
    private BigDecimal unitPrice;

    public OrderItem() {
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(BigDecimal unitPrice) {
        this.unitPrice = unitPrice;
    }
}
