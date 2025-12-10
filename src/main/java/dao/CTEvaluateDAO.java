package dao;

import model.CTEvaluates;

import java.util.List;

public class CTEvaluateDAO extends ADAO implements IDAO<CTEvaluates> {

    @Override
    public List<CTEvaluates> getAll() {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM ct_evaluates WHERE is_delete = 0")
                        .mapToBean(CTEvaluates.class)
                        .list()
        );
    }

    @Override
    public CTEvaluates findById(CTEvaluates entity) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM ct_evaluates WHERE id = :id AND is_delete = 0")
                        .bind("id", entity.getId())
                        .mapToBean(CTEvaluates.class)
                        .findFirst()
                        .orElse(null)
        );
    }

    @Override
    public boolean create(CTEvaluates entity) {
        return jdbi.withHandle(handle ->
                handle.createUpdate("""
                        INSERT INTO ct_evaluates
                        (content, img, star, create_at, update_at, is_delete)
                        VALUES (:content, :img, :star, :create_at, :update_at, :is_delete)
                        """)
                        .bind("content", entity.getContent())
                        .bind("img", entity.getImg())
                        .bind("star", entity.getStar())
                        .bind("create_at", entity.getCreateAt())
                        .bind("update_at", entity.getUpdateAt())
                        .bind("is_delete", entity.isDelete())
                        .execute() > 0
        );
    }

    @Override
    public boolean update(CTEvaluates entity) {
        return jdbi.withHandle(handle ->
                handle.createUpdate("""
                        UPDATE ct_evaluates SET
                            content = :content,
                            img = :img,
                            star = :star,
                            update_at = :update_at,
                            is_delete = :is_delete
                        WHERE id = :id
                        """)
                        .bind("id", entity.getId())
                        .bind("content", entity.getContent())
                        .bind("img", entity.getImg())
                        .bind("star", entity.getStar())
                        .bind("update_at", entity.getUpdateAt())
                        .bind("is_delete", entity.isDelete())
                        .execute() > 0
        );
    }

    @Override
    public boolean delete(CTEvaluates entity) {
        return jdbi.withHandle(handle ->
                handle.createUpdate("""
                        UPDATE ct_evaluates
                        SET is_delete = 1, update_at = NOW()
                        WHERE id = :id
                        """)
                        .bind("id", entity.getId())
                        .execute() > 0
        );
    }

    @Override
    public List<CTEvaluates> search(String keyword) {
        return jdbi.withHandle(handle ->
                handle.createQuery("""
                        SELECT * FROM ct_evaluates
                        WHERE is_delete = 0
                        AND content LIKE :kw
                        """)
                        .bind("kw", "%" + keyword + "%")
                        .mapToBean(CTEvaluates.class)
                        .list()
        );
    }

    @Override
    public boolean exists(CTEvaluates entity) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT COUNT(*) FROM ct_evaluates WHERE id = :id AND is_delete = 0")
                        .bind("id", entity.getId())
                        .mapTo(Integer.class)
                        .findFirst().isPresent()
        );
    }

    public List<CTEvaluates> getByStar(double star) {
        return jdbi.withHandle(handle ->
                handle.createQuery("""
                        SELECT * FROM ct_evaluates
                        WHERE star = :star AND is_delete = 0
                        """)
                        .bind("star", star)
                        .mapToBean(CTEvaluates.class)
                        .list()
        );
    }

    public CTEvaluates getLatest() {
        return jdbi.withHandle(handle ->
                handle.createQuery("""
                        SELECT * FROM ct_evaluates
                        WHERE is_delete = 0
                        ORDER BY create_at DESC
                        LIMIT 1
                        """)
                        .mapToBean(CTEvaluates.class)
                        .findOnly()
        );
    }
}
