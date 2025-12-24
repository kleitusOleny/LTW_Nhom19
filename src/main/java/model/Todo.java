package model;

import org.jdbi.v3.core.mapper.reflect.ColumnName;

public class Todo {
    @ColumnName("id")
    private int id;

    @ColumnName("title")
    private String title;

    @ColumnName("description")
    private String description;

    @ColumnName("status")
    private boolean status;

    public Todo() {
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }
}
