package model;

import java.sql.Timestamp;
import java.math.BigDecimal;

public class ShipOrder {
    private int id;
    private int orderId;
    private String carrierName;
    private String trackingNumber;
    private BigDecimal shippingFee;
    private String status;
    private Timestamp estimatedDeliveryDate;

    public ShipOrder() {
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

    public String getCarrierName() {
        return carrierName;
    }

    public void setCarrierName(String carrierName) {
        this.carrierName = carrierName;
    }

    public String getTrackingNumber() {
        return trackingNumber;
    }

    public void setTrackingNumber(String trackingNumber) {
        this.trackingNumber = trackingNumber;
    }

    public BigDecimal getShippingFee() {
        return shippingFee;
    }

    public void setShippingFee(BigDecimal shippingFee) {
        this.shippingFee = shippingFee;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getEstimatedDeliveryDate() {
        return estimatedDeliveryDate;
    }

    public void setEstimatedDeliveryDate(Timestamp estimatedDeliveryDate) {
        this.estimatedDeliveryDate = estimatedDeliveryDate;
    }
}