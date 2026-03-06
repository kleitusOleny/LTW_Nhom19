package dao;

import model.BlogComment;
import java.util.List;

public class BlogCommentDAO extends ADAO {

    public List<BlogComment> getCommentsByBlogId(int blogId) {
        return jdbi.withHandle(handle -> {
            String sql = "SELECT c.*, u.full_name as userName " +
                    "FROM blog_comments c " +
                    "JOIN users u ON c.user_id = u.id " +
                    "WHERE c.blog_id = :blogId AND c.is_hidden = 0 " +
                    "ORDER BY c.created_at DESC";
            return handle.createQuery(sql)
                    .bind("blogId", blogId)
                    .map((rs, ctx) -> {
                        BlogComment c = new BlogComment();
                        c.setId(rs.getInt("id"));
                        c.setBlogId(rs.getInt("blog_id"));
                        c.setUserId(rs.getInt("user_id"));
                        c.setContent(rs.getString("content"));
                        c.setCreateAt(rs.getTimestamp("created_at").toLocalDateTime());
                        c.setHidden(rs.getBoolean("is_hidden"));
                        c.setUserName(rs.getString("userName"));
                        c.setUserAvatar("img/default-avatar.png"); // Default avatar since User table has no avatar
                        return c;
                    }).list();
        });
    }

    public void addComment(BlogComment comment) {
        jdbi.useHandle(handle -> {
            handle.createUpdate("INSERT INTO blog_comments (blog_id, user_id, content, created_at, is_hidden) " +
                    "VALUES (:blogId, :userId, :content, NOW(), 0)")
                    .bind("blogId", comment.getBlogId())
                    .bind("userId", comment.getUserId())
                    .bind("content", comment.getContent())
                    .execute();
        });
    }
}
