package dao;

import model.Blogs;
import java.util.List;

public class BlogDAO extends ADAO {

    /**
     * Get all active blogs (display=true, is_delete=false)
     * Ordered by upload_at DESC
     */
    public List<Blogs> getAllActiveBlogs() {
        return jdbi.withHandle(handle -> {
            return handle.createQuery(
                    "SELECT * FROM blogs WHERE display = 1 AND is_delete = 0 ORDER BY upload_at DESC")
                    .mapToBean(Blogs.class)
                    .list();
        });
    }

    /**
     * Get blog by ID
     */
    public Blogs getById(int id) {
        return jdbi.withHandle(handle -> {
            return handle.createQuery(
                    "SELECT * FROM blogs WHERE id = :id AND is_delete = 0")
                    .bind("id", id)
                    .mapToBean(Blogs.class)
                    .findOne()
                    .orElse(null);
        });
    }

    /**
     * Get blog by slug
     */
    public Blogs getBySlug(String slug) {
        return jdbi.withHandle(handle -> {
            return handle.createQuery(
                    "SELECT * FROM blogs WHERE slug = :slug AND display = 1 AND is_delete = 0")
                    .bind("slug", slug)
                    .mapToBean(Blogs.class)
                    .findOne()
                    .orElse(null);
        });
    }

    /**
     * Get latest N blogs
     */
    public List<Blogs> getLatestBlogs(int limit) {
        return jdbi.withHandle(handle -> {
            return handle.createQuery(
                    "SELECT * FROM blogs WHERE display = 1 AND is_delete = 0 ORDER BY upload_at DESC LIMIT :limit")
                    .bind("limit", limit)
                    .mapToBean(Blogs.class)
                    .list();
        });
    }

    /**
     * Get all blogs (for admin)
     */
    public List<Blogs> getAll() {
        return jdbi.withHandle(handle -> {
            return handle.createQuery("SELECT * FROM blogs WHERE is_delete = 0 ORDER BY upload_at DESC")
                    .mapToBean(Blogs.class)
                    .list();
        });
    }

    /**
     * Search blogs by text (title/content) and category
     */
    public List<Blogs> searchBlogs(String text, String category) {
        StringBuilder sql = new StringBuilder("SELECT * FROM blogs WHERE display = 1 AND is_delete = 0");

        if (text != null && !text.trim().isEmpty()) {
            sql.append(" AND (title LIKE :text OR content LIKE :text)");
        }

        if (category != null && !category.trim().isEmpty() && !"Tất cả".equalsIgnoreCase(category)) {
            sql.append(" AND category = :category");
        }

        sql.append(" ORDER BY upload_at DESC");

        return jdbi.withHandle(handle -> {
            var query = handle.createQuery(sql.toString());

            if (text != null && !text.trim().isEmpty()) {
                query.bind("text", "%" + text + "%");
            }

            if (category != null && !category.trim().isEmpty() && !"Tất cả".equalsIgnoreCase(category)) {
                query.bind("category", category);
            }

            return query.mapToBean(Blogs.class).list();
        });
    }

    /**
     * Count total blogs for pagination
     */
    public int countBlogs(String text, String category) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM blogs WHERE display = 1 AND is_delete = 0");
        if (text != null && !text.trim().isEmpty()) {
            sql.append(" AND (title LIKE :text OR content LIKE :text)");
        }
        if (category != null && !category.trim().isEmpty() && !"Tất cả".equalsIgnoreCase(category)) {
            sql.append(" AND category = :category");
        }
        return jdbi.withHandle(handle -> {
            var query = handle.createQuery(sql.toString());
            if (text != null && !text.trim().isEmpty())
                query.bind("text", "%" + text + "%");
            if (category != null && !category.trim().isEmpty() && !"Tất cả".equalsIgnoreCase(category))
                query.bind("category", category);
            return query.mapTo(Integer.class).one();
        });
    }

    /**
     * Search blogs with pagination
     */
    public List<Blogs> searchBlogs(String text, String category, int limit, int offset) {
        StringBuilder sql = new StringBuilder("SELECT * FROM blogs WHERE display = 1 AND is_delete = 0");
        if (text != null && !text.trim().isEmpty()) {
            sql.append(" AND (title LIKE :text OR content LIKE :text)");
        }
        if (category != null && !category.trim().isEmpty() && !"Tất cả".equalsIgnoreCase(category)) {
            sql.append(" AND category = :category");
        }
        sql.append(" ORDER BY upload_at DESC LIMIT :limit OFFSET :offset");

        return jdbi.withHandle(handle -> {
            var query = handle.createQuery(sql.toString());
            if (text != null && !text.trim().isEmpty())
                query.bind("text", "%" + text + "%");
            if (category != null && !category.trim().isEmpty() && !"Tất cả".equalsIgnoreCase(category))
                query.bind("category", category);
            query.bind("limit", limit);
            query.bind("offset", offset);
            return query.mapToBean(Blogs.class).list();
        });
    }

    /**
     * Get related blogs (same category, excluding current one)
     */
    public List<Blogs> getRelatedBlogs(int currentId, String category, int limit) {
        return jdbi.withHandle(handle -> {
            String sql = "SELECT * FROM blogs WHERE display = 1 AND is_delete = 0 AND id != :id";

            if (category != null) {
                sql += " AND category = :category";
            }

            sql += " ORDER BY upload_at DESC LIMIT :limit";

            var query = handle.createQuery(sql)
                    .bind("id", currentId)
                    .bind("limit", limit);

            if (category != null) {
                query.bind("category", category);
            }

            return query.mapToBean(Blogs.class).list();
        });
    }

    /**
     * Soft delete blog
     */
    public void delete(int id) {
        jdbi.useHandle(handle -> {
            handle.createUpdate("UPDATE blogs SET is_delete = 1 WHERE id = :id")
                    .bind("id", id)
                    .execute();
        });
    }

    /**
     * Update blog
     */
    public void update(Blogs blog) {
        jdbi.useHandle(handle -> {
            handle.createUpdate("UPDATE blogs SET title = :title, content = :content, blog_image = :image, " +
                    "category = :category, display = :display, update_at = NOW() WHERE id = :id")
                    .bind("title", blog.getTitle())
                    .bind("content", blog.getContent())
                    .bind("image", blog.getBlogImage())
                    .bind("category", blog.getCategory())
                    .bind("display", blog.isDisplay())
                    .bind("id", blog.getId())
                    .execute();
        });
    }

    /**
     * Insert new blog
     */
    public void insert(Blogs blog) {
        jdbi.useHandle(handle -> {
            handle.createUpdate(
                    "INSERT INTO blogs (title, content, blog_image, category, display, upload_at, create_at, is_delete) "
                            +
                            "VALUES (:title, :content, :image, :category, :display, NOW(), NOW(), 0)")
                    .bind("title", blog.getTitle())
                    .bind("content", blog.getContent())
                    .bind("image", blog.getBlogImage())
                    .bind("category", blog.getCategory())
                    .bind("display", blog.isDisplay())
                    .execute();
        });
    }
}
