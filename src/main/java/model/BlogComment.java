package model;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class BlogComment {
    private int id;
    private int blogId;
    private int userId;
    private String content;
    private LocalDateTime createAt;
    private boolean isHidden;

    // Extra fields for display
    private String userName;
    private String userAvatar;

    public BlogComment() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getBlogId() {
        return blogId;
    }

    public void setBlogId(int blogId) {
        this.blogId = blogId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public LocalDateTime getCreateAt() {
        return createAt;
    }

    public void setCreateAt(LocalDateTime createAt) {
        this.createAt = createAt;
    }

    public boolean isHidden() {
        return isHidden;
    }

    public void setHidden(boolean hidden) {
        isHidden = hidden;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserAvatar() {
        return userAvatar;
    }

    public void setUserAvatar(String userAvatar) {
        this.userAvatar = userAvatar;
    }

    public String getFormattedDate() {
        if (createAt == null)
            return "";
        return createAt.format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm"));
    }
}
