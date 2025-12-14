package model;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.Date;

public class User {
    private int id;
    private String email;
    private String username;
    private String passwordHash;
    private String phoneNumber;
    private int administrator;
    private int active;
    private Timestamp birthDay;

    public Timestamp getBirthDay() {
        return birthDay;
    }

    public void setBirthDay(Timestamp birthDay) {
        this.birthDay = birthDay;
    }

    private Timestamp createdAt;

    public User() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPasswordHash() {
        return passwordHash;
    }

    public void setPasswordHash(String passwordHash) {
        this.passwordHash = passwordHash;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public int getAdministrator() {
        return administrator;
    }

    public void setAdministrator(int administrator) {
        this.administrator = administrator;
    }

    public int getActive() {
        return active;
    }

    public void setActive(int active) {
        this.active = active;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "User{" +
                "user_id='" + id + '\'' +
                ", email='" + email + '\'' +
                ", username='" + username + '\'' +
                ", password_hash='" + passwordHash + '\'' +
                ", phone_number='" + phoneNumber + '\'' +
                ", administrator=" + administrator +
                ", active=" + active +
                ", created_at='" + createdAt + '\'' +
                '}';
    }
}
