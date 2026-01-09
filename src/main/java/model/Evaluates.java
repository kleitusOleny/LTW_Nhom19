package model;

import org.jdbi.v3.core.mapper.reflect.ColumnName;

public class Evaluates {
    private String id;

    private int userId;

    private int evaluatesId;

    public Evaluates() {
    }

    public String getId() {
        return id;
    }

    @ColumnName("product_id")
    public void setId(String id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    @ColumnName("user_id")
    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getEvaluatesId() {
        return evaluatesId;
    }

    @ColumnName("evaluate_id")
    public void setEvaluatesId(int evaluatesId) {
        this.evaluatesId = evaluatesId;
    }
}
