package model;

import java.sql.Timestamp;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.Locale;

public class OrderViewModel {
    private int id;
    private String customerName;
    private Timestamp createAt;
    private Double totalPrice;
    private String status;
    private String payStrategy;

    public OrderViewModel() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public Timestamp getCreateAt() {
        return createAt;
    }

    public void setCreateAt(Timestamp createAt) {
        this.createAt = createAt;
    }

    public Double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(Double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getStatus() {
        return status != null ? status : "Chờ xử lý";
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getPayStrategy() {
        return payStrategy;
    }

    public void setPayStrategy(String payStrategy) {
        this.payStrategy = payStrategy;
    }

    public String getFormattedDate() {
        if (createAt == null)
            return "";
        return new SimpleDateFormat("dd/MM/yyyy").format(createAt);
    }

    public String getFormattedTotal() {
        Locale locale = new Locale("vi", "VN");
        NumberFormat currencyFormatter = NumberFormat.getCurrencyInstance(locale);
        return currencyFormatter.format(totalPrice);
    }

    public String getStatusClass() {
        if (status == null)
            return "status-pending";
        switch (status.toLowerCase()) {
            case "giao hàng thành công":
            case "đã giao":
            case "delivered":
                return "status-delivered";
            case "đang giao hàng":
            case "đang giao":
            case "shipping":
                return "status-shipping";
            case "chuẩn bị đơn hàng":
            case "chuẩn bị đơn":
            case "preparing":
                return "status-preparing";
            case "đã hủy":
            case "cancelled":
            case "thanh toán thất bại":
                return "status-cancelled";
            case "đang xử lý":
            case "processing":
            default:
                return "status-processing";
        }
    }

    public String getStatusText() {
        if (status == null)
            return "Chờ xử lý";
        switch (status.toLowerCase()) {
            case "delivered":
                return "Đã giao";
            case "cancelled":
                return "Đã hủy";
            case "processing":
                return "Đang xử lý";
            default:
                return status;
        }
    }
}
