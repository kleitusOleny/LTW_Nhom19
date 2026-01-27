package model;

import org.jdbi.v3.core.mapper.reflect.ColumnName;

public class Manufacturer {
    @ColumnName("id")
    private int id;

    @ColumnName("manufacturer_name")
    private String manufacturerName;

    @ColumnName("location")
    private String location;

    @ColumnName("is_delete")
    private boolean isDelete;

    public Manufacturer() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getManufacturerName() {
        return manufacturerName;
    }

    public void setManufacturerName(String manufacturerName) {
        this.manufacturerName = manufacturerName;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public boolean isDelete() {
        return isDelete;
    }

    public void setDelete(boolean delete) {
        isDelete = delete;
    }
}