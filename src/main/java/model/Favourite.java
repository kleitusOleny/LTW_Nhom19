package model;

import org.jdbi.v3.core.mapper.reflect.ColumnName;

public class Favourite {
    @ColumnName("id")
    private int id;

    @ColumnName("product_id")
    private String productId;

    @ColumnName("user_id")
    private String userId;

    public Favourite() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }
}