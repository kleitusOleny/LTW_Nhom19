package model;

import java.sql.Timestamp;

public class Review {
    private String fullName;
    private Double star;
    private String content;
    private Timestamp createAt;
    
    public Review() {}
    
    // Getters and Setters
    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }
    
    public Double getStar() { return star; }
    public void setStar(Double star) { this.star = star; }
    
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    
    public Timestamp getCreateAt() { return createAt; }
    public void setCreateAt(Timestamp createAt) { this.createAt = createAt; }
}