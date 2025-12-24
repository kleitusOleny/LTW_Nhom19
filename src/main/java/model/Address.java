package model;

import org.jdbi.v3.core.mapper.reflect.ColumnName;

import java.time.LocalDateTime;

public class Address {
    @ColumnName("id")
    private int id;

    @ColumnName("user_id")
    private int userId;

    @ColumnName("full_name")
    private String fullName;

    @ColumnName("phone_number")
    private String phoneNumber;

    @ColumnName("address_line")
    private String addressLine;

    @ColumnName("city")
    private String city;

    @ColumnName("ward")
    private String ward;

    @ColumnName("country")
    private String country;

    @ColumnName("is_default")
    private boolean isDefault;

    @ColumnName("create_at")
    private LocalDateTime createdAt;

    @ColumnName("update_at")
    private LocalDateTime updateAt;

    @ColumnName("is_delete")
    private boolean isDelete;

    public Address() {
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

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getAddressLine() {
        return addressLine;
    }

    public void setAddressLine(String addressLine) {
        this.addressLine = addressLine;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getWard() {
        return ward;
    }

    public void setWard(String ward) {
        this.ward = ward;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public boolean isDefault() {
        return isDefault;
    }

    public void setDefault(boolean aDefault) {
        isDefault = aDefault;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDateTime getUpdateAt() {
        return updateAt;
    }

    public void setUpdateAt(LocalDateTime updateAt) {
        this.updateAt = updateAt;
    }

    public boolean isDelete() {
        return isDelete;
    }

    public void setDelete(boolean delete) {
        isDelete = delete;
    }

    @Override
    public String toString() {
        return "Address{" +
                "id=" + id +
                ", userId=" + userId +
                ", fullName='" + fullName + '\'' +
                ", phoneNumber='" + phoneNumber + '\'' +
                ", addressLine='" + addressLine + '\'' +
                ", city='" + city + '\'' +
                ", ward='" + ward + '\'' +
                ", country='" + country + '\'' +
                ", isDefault=" + isDefault +
                ", createdAt=" + createdAt +
                ", updateAt=" + updateAt +
                ", isDelete=" + isDelete +
                '}';
    }
}
