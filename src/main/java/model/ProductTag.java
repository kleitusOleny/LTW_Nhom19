package model;

import org.jdbi.v3.core.mapper.reflect.ColumnName;

public class ProductTag {
    @ColumnName("product_id")
    private String productId;

    @ColumnName("tag_id")
    private String tagId;

    @ColumnName("is_delete")
    private boolean isDelete;

    public ProductTag() {
    }

    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    public String getTagId() {
        return tagId;
    }

    public void setTagId(String tagId) {
        this.tagId = tagId;
    }

    public boolean isDelete() {
        return isDelete;
    }

    public void setDelete(boolean delete) {
        isDelete = delete;
    }
}
