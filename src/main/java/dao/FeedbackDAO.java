package dao;

import model.Feedback;
import model.User;

import java.util.List;

public class FeedbackDAO extends ADAO implements IDAO<Feedback> {
    @Override
    public List<Feedback> getAll() {
        return List.of();
    }

    @Override
    public Feedback findById(Feedback id) {
        return null;
    }

    @Override
    public boolean create(Feedback entity) {
        return jdbi.withHandle(handle -> handle.createUpdate("INSERT INTO feedback(user_id, title, content, create_at, is_delete, status) VALUES (:user_id, :title, :content, :create_at, :is_delete, :status)")
                .bind("user_id", entity.getuId())
                .bind("title", entity.getTitle())
                .bind("content", entity.getContent())
                .bind("create_at", entity.getCreateAt())
                .bind("is_delete", entity.isDelete())
                .bind("status", entity.isStatus())
                .execute() > 0);
    }

    public List<Feedback> getPendingFeedbacks(){
        return jdbi.withHandle(handle -> handle.createQuery("SELECT * FROM feedback where status = 0 AND is_delete = 0 ORDER BY create_at DESC")
                .mapToBean(Feedback.class)
                .list());
    }

    public List<Feedback> getCompletedFeedbacks() {
        return jdbi.withHandle(handle -> handle.createQuery("SELECT * FROM feedback where status = 1 AND is_delete = 0 ORDER BY create_at DESC")
                .mapToBean(Feedback.class)
                .list());
    }

    @Override
    public boolean update(Feedback entity) {
        return jdbi.withHandle(handle -> handle.createUpdate("UPDATE feedback SET status = :status, update_at = :update_at WHERE id =:id")
                .bind("status", entity.isStatus())
                .bind("id", entity.getId())
                .bind("update_at", entity.getUpdateAt())
                .execute() > 0);
    }

    @Override
    public boolean delete(Feedback entity) {
        return jdbi.withHandle(handle -> handle.createUpdate("UPDATE feedback SET is_delete = 1 WHERE id =:id")
                .bind("id", entity.getId())
                .execute() > 0);
    }

    @Override
    public List<Feedback> search(String keyword) {
        return List.of();
    }

    @Override
    public boolean exists(Feedback id) {
        return false;
    }
}
