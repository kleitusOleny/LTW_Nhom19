package model;

import java.sql.Timestamp;
import java.util.Date;

public class Blogs {
    private int id;
    private String title;
    private String content;
    private Timestamp uploadAt;
    private boolean display;
    private String bImage;
    private String slug;
    private Timestamp createAt;
    private Timestamp updateAt;
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

    public Date getUploadAt() {
        return uploadAt;
    }

    public void setUploadAt(Timestamp uploadAt) {
        this.uploadAt = uploadAt;
    }

    public boolean isDisplay() {
        return display;
    }

    public void setDisplay(boolean display) {
        this.display = display;
    }

    public String getbImage() {
        return bImage;
    }

    public void setbImage(String bImage) {
        this.bImage = bImage;
    }

    public String getSlug() {
        return slug;
    }

    public void setSlug(String slug) {
        this.slug = slug;
    }

    public Date getCreateAt() {
        return createAt;
    }

    public void setCreateAt(Timestamp createAt) {
        this.createAt = createAt;
    }

    public Date getUpdateAt() {
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
}
