<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!doctype html>
            <html lang="vi">

            <head>
                <meta charset="utf-8">
                <meta name="viewport" content="width=device-width, initial-scale=1">
                <title>${blog != null ? blog.title : 'Chi tiết bài viết'}</title>
                <link rel="stylesheet" href="css/blog_style.css">
            </head>

            <body>
                <%@include file="components/header.jsp" %>
                    <div class="container">
                        <main class="blog-post-detail">
                            <c:choose>
                                <c:when test="${blog != null}">
                                    <article class="card">
                                        <div class="media"
                                            style="background-image:url('${blog.blogImage != null ? blog.blogImage : 'img/ruou.jpg'}')"
                                            aria-hidden="true"></div>
                                        <div class="body">
                                            <div class="meta">
                                                ${blog.formattedDate}
                                            </div>
                                            <h2 class="title">${blog.title}</h2>
                                            <div class="full-content">
                                                ${blog.content}
                                            </div>
                                            <a class="readmore" href="${pageContext.request.contextPath}/blog">Quay lại
                                                Blog</a>
                                        </div>
                                    </article>

                                    <c:if test="${not empty relatedBlogs}">
                                        <div class="related-posts"
                                            style="margin-top: 50px; border-top: 1px solid #eee; padding-top: 30px;">
                                            <h3 style="margin-bottom: 20px; font-size: 24px;">Bài viết liên quan</h3>
                                            <div class="grid"
                                                style="display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 20px;">
                                                <c:forEach items="${relatedBlogs}" var="related">
                                                    <article class="card" style="margin-bottom: 0;">
                                                        <a href="${pageContext.request.contextPath}/blog-detail?slug=${related.slug}"
                                                            style="text-decoration: none; color: inherit; display: block;">
                                                            <div class="media"
                                                                style="background-image:url('${related.blogImage != null ? related.blogImage : 'img/ruou.jpg'}'); height: 200px; background-size: cover; background-position: center;"
                                                                aria-hidden="true"></div>
                                                            <div class="body" style="padding: 15px;">
                                                                <div class="meta"
                                                                    style="font-size: 0.9em; color: #888; margin-bottom: 5px;">
                                                                    ${related.cardDate}</div>
                                                                <h4 class="title"
                                                                    style="font-size: 18px; margin: 0; line-height: 1.4;">
                                                                    ${related.title}</h4>
                                                            </div>
                                                        </a>
                                                    </article>
                                                </c:forEach>
                                            </div>
                                        </div>
                    </div>
                    </c:if>

                    <!-- Comments Section -->
                    <div class="comments-section"
                        style="margin-top: 50px; border-top: 1px solid #eee; padding-top: 30px;">
                        <h3 style="margin-bottom: 20px; font-size: 24px;">Bình luận (${comments != null ?
                            comments.size() : 0})</h3>

                        <!-- Comment Form -->
                        <c:if test="${not empty sessionScope.user}">
                            <form action="${pageContext.request.contextPath}/add-comment" method="post"
                                style="margin-bottom: 40px;">
                                <input type="hidden" name="blogId" value="${blog.id}">
                                <input type="hidden" name="slug" value="${blog.slug}">
                                <div style="display: flex; gap: 15px;">
                                    <img src="img/default-avatar.png"
                                        style="width: 50px; height: 50px; border-radius: 50%; object-fit: cover; border: 1px solid #eee;">
                                    <div style="flex-grow: 1;">
                                        <textarea name="content" placeholder="Viết bình luận của bạn..." required
                                            style="width: 100%; height: 80px; padding: 15px; border: 1px solid #ddd; border-radius: 8px; font-family: inherit; resize: vertical;"></textarea>
                                        <button type="submit" class="readmore"
                                            style="margin-top: 10px; border: none; cursor: pointer; padding: 10px 25px;">Gửi
                                            bình luận</button>
                                    </div>
                                </div>
                            </form>
                        </c:if>
                        <c:if test="${empty sessionScope.user}">
                            <div
                                style="background: #f9f9f9; padding: 20px; border-radius: 8px; text-align: center; margin-bottom: 40px;">
                                <p style="margin: 0; color: #666;">Vui lòng <a
                                        href="${pageContext.request.contextPath}/login.jsp"
                                        style="color: #8e1c1c; font-weight: bold; text-decoration: none;">đăng nhập</a>
                                    để tham gia bình luận.</p>
                            </div>
                        </c:if>

                        <!-- Comment List -->
                        <div class="comment-list">
                            <c:forEach items="${comments}" var="comment">
                                <div class="comment-item" style="display: flex; gap: 15px; margin-bottom: 25px;">
                                    <img src="${comment.userAvatar}"
                                        style="width: 50px; height: 50px; border-radius: 50%; object-fit: cover; border: 1px solid #eee;">
                                    <div>
                                        <div style="margin-bottom: 5px;">
                                            <span
                                                style="font-weight: bold; margin-right: 10px; font-size: 16px;">${comment.userName}</span>
                                            <span
                                                style="font-size: 0.85em; color: #999;">${comment.formattedDate}</span>
                                        </div>
                                        <p style="margin: 0; line-height: 1.6; color: #444;">${comment.content}</p>
                                    </div>
                                </div>
                            </c:forEach>
                            <c:if test="${empty comments}">
                                <p style="color: #999; font-style: italic;">Chưa có bình luận nào. Hãy là người đầu tiên
                                    bình luận!</p>
                            </c:if>
                        </div>
                    </div>
                    </c:when>
                    <c:otherwise>
                        <div style="text-align: center; padding: 100px 20px;">
                            <i class="fas fa-exclamation-circle"
                                style="font-size: 60px; color: #ccc; margin-bottom: 20px;"></i>
                            <h2 style="color: #666;">Không tìm thấy bài viết</h2>
                            <p style="color: #999;">Bài viết bạn tìm kiếm không tồn tại hoặc đã bị xóa.</p>
                            <a class="readmore" href="${pageContext.request.contextPath}/blog"
                                style="display: inline-block; margin-top: 20px;">Quay lại Blog</a>
                        </div>
                    </c:otherwise>
                    </c:choose>
                    </main>
                    </div>

                    <script>
                        document.getElementById('year').textContent = new Date().getFullYear();
                    </script>
            </body>

            </html>