package model;

import org.jdbi.v3.core.mapper.reflect.ColumnName;

public class ProductType {
    // Khai báo biến
    @ColumnName("id")
    private int id;

    @ColumnName("type_name")
    private String typeName;

    @ColumnName("is_delete")
    private boolean isDelete;

    // Constructor rỗng
    public ProductType() {
    }

    // Getter và Setter
    public int getId() {
        return id;
    }

    public void setTypeId(int id) {
        this.id = id;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    public boolean isDelete() {
        return isDelete;
    }

    public void setDelete(boolean delete) {
        isDelete = delete;
    }
}