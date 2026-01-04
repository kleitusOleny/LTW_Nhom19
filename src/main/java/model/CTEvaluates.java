package model;

import org.jdbi.v3.core.mapper.reflect.ColumnName;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.Date;

public class CTEvaluates {
    @ColumnName("id")
    private int id;

    @ColumnName("content")
    private String content;

    @ColumnName("star")
    private double star;

    @ColumnName("create_at")
    private LocalDateTime createAt;

    @ColumnName("update_at")
    private LocalDateTime updateAt;

    @ColumnName("is_delete")
    private LocalDateTime isDelete;

    public CTEvaluates() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public double getStar() {
        return star;
    }

    public void setStar(double star) {
        this.star = star;
    }

    public LocalDateTime getCreateAt() {
        return createAt;
    }

    public void setCreateAt(LocalDateTime createAt) {
        this.createAt = createAt;
    }

    public LocalDateTime getUpdateAt() {
        return updateAt;
    }

    public void setUpdateAt(LocalDateTime updateAt) {
        this.updateAt = updateAt;
    }

    public LocalDateTime getIsDelete() {
        return isDelete;
    }

    public void setIsDelete(LocalDateTime isDelete) {
        this.isDelete = isDelete;
    }

    public boolean isDelete() {
        return isDelete != null;
    }

    public Date getCreateAtAsDate() {
        return createAt == null ? null : Timestamp.valueOf(createAt);
    }
}
