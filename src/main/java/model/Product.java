package model;

import org.jdbi.v3.core.mapper.reflect.ColumnName;

import java.io.Serializable;
import java.sql.Timestamp;
import java.math.BigDecimal;

public class Product implements Serializable {
    @ColumnName("id")
    private String id;

    @ColumnName("product_name")
    private String productName;

    @ColumnName("slug")
    private String slug;

    @ColumnName("type_id")
    private String typeId;

    @ColumnName("price")
    private BigDecimal price;

    @ColumnName("capacity")
    private String capacity;

    @ColumnName("alcohol")
    private Double alcohol;

    @ColumnName("origin")
    private String origin;

    @ColumnName("manufacturer_id")
    private String manufacturer;

    @ColumnName("category_id")
    private String category;

    @ColumnName("detail")
    private String detail;

    @ColumnName("create_at")
    private Timestamp createAt;

    @ColumnName("update_at")
    private Timestamp updateAt;

    @ColumnName("is_delete")
    private boolean isDelete;
    private String imageUrl;
    private Double rating;
    private int totalReviews;

    public Product() {
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getSlug() {
        return slug;
    }

    public void setSlug(String slug) {
        this.slug = slug;
    }

    public String getTypeId() {
        return typeId;
    }

    public void setTypeId(String typeId) {
        this.typeId = typeId;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public String getCapacity() {
        return capacity;
    }

    public void setCapacity(String capacity) {
        this.capacity = capacity;
    }

    public Double getAlcohol() {
        return alcohol;
    }

    public void setAlcohol(Double alcohol) {
        this.alcohol = alcohol;
    }

    public String getOrigin() {
        return origin;
    }

    public void setOrigin(String origin) {
        this.origin = origin;
    }

    public String getManufacturerId() {
        return manufacturer;
    }

    public void setManufacturerId(String manufacturerId) {
        this.manufacturer = manufacturerId;
    }

    public String getCategoryId() {
        return category;
    }

    public void setCategoryId(String categoryId) {
        this.category = categoryId;
    }

    public String getDetail() {
        return detail;
    }

    public void setDetail(String detail) {
        this.detail = detail;
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
    
    public String getImageUrl() {
        return imageUrl;
    }
    
    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }
    
    public Double getRating() {
        return rating == null ? 0.0 : rating;
    }
    
    public void setRating(Double rating) {
        this.rating = rating;
    }
    
    public int getTotalReviews() {
        return totalReviews;
    }
    
    public void setTotalReviews(int totalReviews) {
        this.totalReviews = totalReviews;
    }
    
    @Override
    public String toString() {
        return "Product{" +
                "id='" + id + '\'' +
                ", productName='" + productName + '\'' +
                ", slug='" + slug + '\'' +
                ", typeId='" + typeId + '\'' +
                ", price=" + price +
                ", capacity='" + capacity + '\'' +
                ", alcohol=" + alcohol +
                ", origin='" + origin + '\'' +
                ", manufacturerId='" + manufacturer + '\'' +
                ", categoryId='" + category + '\'' +
                ", detail='" + detail + '\'' +
                ", createAt=" + createAt +
                ", updateAt=" + updateAt +
                ", isDelete=" + isDelete +
                '}';
    }
}