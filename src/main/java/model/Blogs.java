package model;

import org.jdbi.v3.core.mapper.reflect.ColumnName;

import java.time.LocalDate;
import java.time.LocalDateTime;

public class Blogs {
    @ColumnName("id")
    private int id;

    @ColumnName("title")
    private String title;

    @ColumnName("content")
    private String content;

    @ColumnName("upload_at")
    private LocalDate uploadAt;

    @ColumnName("display")
    private boolean display;

    @ColumnName("blog_image")
    private String blogImage;

    @ColumnName("slug")
    private String slug;

    @ColumnName("category")
    private String category;

    @ColumnName("create_at")
    private LocalDate createAt;

    @ColumnName("update_at")
    private LocalDate updateAt;

    @ColumnName("is_delete")
    private boolean isDelete;

    public Blogs() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public LocalDate getUploadAt() {
        return uploadAt;
    }

    public void setUploadAt(LocalDate uploadAt) {
        this.uploadAt = uploadAt;
    }

    public boolean isDisplay() {
        return display;
    }

    public void setDisplay(boolean display) {
        this.display = display;
    }

    public String getBlogImage() {
        return blogImage;
    }

    public void setBlogImage(String blogImage) {
        this.blogImage = blogImage;
    }

    public String getSlug() {
        return slug;
    }

    public void setSlug(String slug) {
        this.slug = slug;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public LocalDate getCreateAt() {
        return createAt;
    }

    public void setCreateAt(LocalDate createAt) {
        this.createAt = createAt;
    }

    public void setUpdateAt(LocalDate updateAt) {
        this.updateAt = updateAt;
    }

    public boolean isDelete() {
        return isDelete;
    }

    public void setDelete(boolean delete) {
        isDelete = delete;
    }

    public String getFormattedDate() {
        if (uploadAt != null) {
            return uploadAt.format(java.time.format.DateTimeFormatter.ofPattern("dd 'tháng' MM, yyyy"));
        }
        return "";
    }

    public String getCardDate() {
        if (uploadAt != null) {
            return uploadAt.format(java.time.format.DateTimeFormatter.ofPattern("MMM dd, yyyy"));
        }
        return "";
    }
}
