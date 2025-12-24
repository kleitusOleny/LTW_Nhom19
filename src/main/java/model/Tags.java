package model;

import org.jdbi.v3.core.mapper.reflect.ColumnName;

public class Tag {
    @ColumnName("id")
    private int id;

    @ColumnName("tag_name")
    private String tagName;

    @ColumnName("is_delete")
    private boolean isDelete;

    public Tags() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTagName() {
        return tagName;
    }

    public void setTagName(String tagName) {
        this.tagName = tagName;
    }

    public boolean isDelete() {
        return isDelete;
    }

    public void setDelete(boolean delete) {
        isDelete = delete;
    }
}
