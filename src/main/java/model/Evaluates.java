package model;

import org.jdbi.v3.core.mapper.reflect.ColumnName;

public class Evaluates {
    @ColumnName("product_id")
    private String id;

    @ColumnName("user_id")
    private int userId;

    @ColumnName("evaluate_id")
    private int evaluatesId;

    public Evaluates() {
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getEvaluatesId() {
        return evaluatesId;
    }

    public void setEvaluatesId(int evaluatesId) {
        this.evaluatesId = evaluatesId;
    }
}
