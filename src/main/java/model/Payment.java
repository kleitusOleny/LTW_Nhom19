package model;

import org.jdbi.v3.core.mapper.reflect.ColumnName;

import java.sql.Timestamp;
import java.math.BigDecimal;

public class Payment {
    @ColumnName("id")
    private int id;

    @ColumnName("order_id")
    private int orderId;

    @ColumnName("pay_strategy")
    private String payStrategy;

    @ColumnName("status")
    private String status;

    @ColumnName("amount")
    private BigDecimal amount;

    @ColumnName("paid_at")
    private Timestamp paidAt;

    public Payment() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public String getPayStrategy() {
        return payStrategy;
    }

    public void setPayStrategy(String payStrategy) {
        this.payStrategy = payStrategy;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public Timestamp getPaidAt() {
        return paidAt;
    }

    public void setPaidAt(Timestamp paidAt) {
        this.paidAt = paidAt;
    }
}