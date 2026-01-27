<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!doctype html>
    <html lang="vi">

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Blog Rượu Vang & Đồ Uống Cao Cấp</title>
        <link rel="stylesheet" href="css/blog_style.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"
            integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A=="
            crossorigin="anonymous" referrerpolicy="no-referrer" />

    </head>

    <body>
        <%@include file="components/header.jsp" %>
            <div class="container">
                <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
                    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
                        <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
                            <div class="toolbar">
                                <form action="${pageContext.request.contextPath}/blog" method="get" class="search"
                                    style="width: 100%;">
                                    <input name="search" type="search"
                                        placeholder="Tìm bài viết... (tiêu đề, thẻ, mô tả)" value="${paramSearch}">
                                    <c:if test="${not empty paramCategory}">
                                        <input type="hidden" name="category" value="${paramCategory}">
                                    </c:if>
                                </form>
                                <div class="filters" id="filters">
                                    <a href="${pageContext.request.contextPath}/blog"
                                        class="chip ${empty paramCategory ? 'active' : ''}">Tất cả</a>
                                    <a href="${pageContext.request.contextPath}/blog?category=Tin tức"
                                        class="chip ${paramCategory == 'Tin tức' ? 'active' : ''}">Tin tức</a>
                                    <a href="${pageContext.request.contextPath}/blog?category=Hướng dẫn"
                                        class="chip ${paramCategory == 'Hướng dẫn' ? 'active' : ''}">Hướng dẫn</a>
                                    <a href="${pageContext.request.contextPath}/blog?category=Đánh giá"
                                        class="chip ${paramCategory == 'Đánh giá' ? 'active' : ''}">Đánh giá</a>
                                    <a href="${pageContext.request.contextPath}/blog?category=Pairing"
                                        class="chip ${paramCategory == 'Pairing' ? 'active' : ''}">Pairing</a>
                                </div>
                            </div>

                            <c:choose>
                                <c:when test="${not empty blogs && blogs.size() > 0}">
                                    <!-- Featured blog (first one) -->
                                    <section class="featured">
                                        <article class="card" data-title="${blogs[0].title}">
                                            <div class="media"
                                                style="background-image:url('${blogs[0].blogImage != null ? blogs[0].blogImage : 'img/ruou.jpg'}')"
                                                aria-hidden="true"></div>
                                            <div class="body">
                                                <div class="meta">
                                                    ${blogs[0].cardDate}
                                                </div>
                                                <h2 class="title">${blogs[0].title}</h2>
                                                <p class="excerpt">
                                                    ${fn:length(blogs[0].content) > 150 ? fn:substring(blogs[0].content,
                                                    0, 150).concat('...') : blogs[0].content}
                                                </p>
                                                <a class="readmore"
                                                    href="${pageContext.request.contextPath}/blog-detail?slug=${blogs[0].slug}">Đọc
                                                    tiếp</a>
                                            </div>
                                        </article>
                                    </section>

                                    <!-- Other blogs in grid -->
                                    <section style="margin-top:18px">
                                        <div class="grid" id="posts">
                                            <c:forEach items="${blogs}" var="blog" begin="1">
                                                <article class="card" data-title="${blog.title}">
                                                    <div class="media"
                                                        style="background-image:url('${blog.blogImage != null ? blog.blogImage : 'img/ruou2.jpg'}')">
                                                    </div>
                                                    <div class="body">
                                                        <div class="meta">
                                                            ${blog.cardDate}
                                                        </div>
                                                        <h3 class="title">${blog.title}</h3>
                                                        <p class="excerpt">
                                                            ${fn:length(blog.content) > 100 ? fn:substring(blog.content,
                                                            0, 100).concat('...') : blog.content}
                                                        </p>
                                                        <a class="readmore"
                                                            href="${pageContext.request.contextPath}/blog-detail?slug=${blog.slug}">Đọc
                                                            tiếp</a>
                                                    </div>
                                                </article>
                                            </c:forEach>
                                        </div>
                                    </section>

                                    <!-- Pagination -->
                                    <c:if test="${totalPages > 1}">
                                        <div class="pagination"
                                            style="display: flex; justify-content: center; gap: 10px; margin-top: 40px; margin-bottom: 40px;">
                                            <c:if test="${currentPage > 1}">
                                                <a href="?page=${currentPage - 1}&search=${paramSearch}&category=${paramCategory}"
                                                    class="page-link"
                                                    style="padding: 8px 16px; border: 1px solid #ddd; color: #333; text-decoration: none; border-radius: 4px;">&laquo;
                                                    Trước</a>
                                            </c:if>

                                            <c:forEach begin="1" end="${totalPages}" var="i">
                                                <a href="?page=${i}&search=${paramSearch}&category=${paramCategory}"
                                                    class="page-link ${currentPage == i ? 'active' : ''}"
                                                    style="padding: 8px 16px; border: 1px solid #ddd; text-decoration: none; border-radius: 4px; ${currentPage == i ? 'background: #8e1c1c; color: white; border-color: #8e1c1c;' : 'color: #333;'}">
                                                    ${i}
                                                </a>
                                            </c:forEach>

                                            <c:if test="${currentPage < totalPages}">
                                                <a href="?page=${currentPage + 1}&search=${paramSearch}&category=${paramCategory}"
                                                    class="page-link"
                                                    style="padding: 8px 16px; border: 1px solid #ddd; color: #333; text-decoration: none; border-radius: 4px;">Sau
                                                    &raquo;</a>
                                            </c:if>
                                        </div>
                                    </c:if>
                                </c:when>
                                <c:otherwise>
                                    <!-- No blogs found -->
                                    <section style="text-align: center; padding: 100px 20px;">
                                        <i class="fas fa-search"
                                            style="font-size: 60px; color: #ccc; margin-bottom: 20px;"></i>
                                        <h2 style="color: #666;">Không tìm thấy bài viết nào</h2>
                                        <p style="color: #999;">Thử tìm kiếm với từ khóa khác hoặc chọn danh mục khác.
                                        </p>
                                        <a href="${pageContext.request.contextPath}/blog" class="readmore"
                                            style="display: inline-block; margin-top: 20px;">Xem tất cả bài viết</a>
                                    </section>
                                </c:otherwise>
                            </c:choose>
            </div>
            <%@include file="components/footer.jsp" %>
                <script>
                    (function () {
                        const yearEl = document.getElementById('year');
                        if (yearEl) {
                            yearEl.textContent = new Date().getFullYear();
                        }
                    })();
                </script>
    </body>

    </html>