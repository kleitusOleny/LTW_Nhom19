package dao;

import model.Evaluates;
import java.util.List;

public class EvaluateDAO extends ADAO implements IDAO<Evaluates> {

    @Override
    public List<Evaluates> getAll() {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM evaluates")
                        .mapToBean(Evaluates.class)
                        .list()
        );
    }

    @Override
    public Evaluates findById(Evaluates e) {
        return jdbi.withHandle(handle ->
                handle.createQuery("""
                    SELECT * FROM evaluates WHERE id = :id
                """)
                        .bind("id", e.getId())
                        .mapToBean(Evaluates.class)
                        .findFirst()
                        .orElse(null)
        );
    }

    @Override
    public boolean create(Evaluates e) {
        return jdbi.withHandle(handle ->
                handle.createUpdate("""
                    INSERT INTO evaluates(id, user_id, evaluates_id)
                    VALUES (:id, :uid, :eid)
                """)
                        .bind("id", e.getId())
                        .bind("uid", e.getUserId())
                        .bind("eid", e.getEvaluatesId())
                        .execute() > 0
        );
    }

    @Override
    public boolean update(Evaluates e) {
        return jdbi.withHandle(handle ->
                handle.createUpdate("""
                    UPDATE evaluates SET
                        user_id = :uid,
                        evaluates_id = :eid
                    WHERE id = :id
                """)
                        .bind("id", e.getId())
                        .bind("uid", e.getUserId())
                        .bind("eid", e.getEvaluatesId())
                        .execute() > 0
        );
    }

    @Override
    public boolean delete(Evaluates e) {
        return jdbi.withHandle(handle ->
                handle.createUpdate("""
                    DELETE FROM evaluates WHERE id = :id
                """)
                        .bind("id", e.getId())
                        .execute() > 0
        );
    }

    @Override
    public List<Evaluates> search(String keyword) {
        return jdbi.withHandle(handle ->
                handle.createQuery("""
                    SELECT * FROM evaluates
                    WHERE id LIKE :kw
                """)
                        .bind("kw", "%" + keyword + "%")
                        .mapToBean(Evaluates.class)
                        .list()
        );
    }

    @Override
    public boolean exists(Evaluates e) {
        return jdbi.withHandle(handle ->
                handle.createQuery("""
                    SELECT COUNT(*) FROM evaluates
                    WHERE id = :id
                """)
                        .bind("id", e.getId())
                        .mapTo(Integer.class)
                        .findFirst().isPresent()
        );
    }

    public List<Evaluates> getByUserId(int userId) {
        return jdbi.withHandle(handle ->
                handle.createQuery("""
                    SELECT * FROM evaluates
                    WHERE user_id = :uid
                """)
                        .bind("uid", userId)
                        .mapToBean(Evaluates.class)
                        .list()
        );
    }
}
