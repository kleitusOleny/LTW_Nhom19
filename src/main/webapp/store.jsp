<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Store</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"
          integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
    <link rel="stylesheet" href="css/store_style.css">
</head>
<body>

<%@ include file="components/header.jsp" %>
<main>
    <div class="content-container">
        <aside class="filter-content">
            <h3 class="filter-title">Bộ Lọc Sản Phẩm</h3>
            <form action="filter" method="get">
                <%-- 1. LỌC GIÁ --%>
                <div class="filter-widget">
                    <h4 class="widget-title">Lọc theo giá</h4>
                    <ul class="filter-list">
                        <li><input type="checkbox" id="p1" name="price" value="0-500000"><label for="p1">Dưới
                            500.000₫</label></li>
                        <li><input type="checkbox" id="p2" name="price" value="500000-1000000"><label for="p2">500.000₫
                            -
                            1.000.000₫</label></li>
                        <li><input type="checkbox" id="p3" name="price" value="1000000-2000000"><label for="p3">1.000.000₫
                            -
                            2.000.000₫</label></li>
                        <li><input type="checkbox" id="p4" name="price" value="2000000-5000000"><label for="p4">2.000.000₫
                            -
                            5.000.000₫</label></li>
                        <li><input type="checkbox" id="p5" name="price" value="5000000-max"><label for="p5">Trên
                            5.000.000₫</label></li>
                    </ul>
                </div>

                <%-- 2. DANH MỤC --%>
                <div class="filter-widget">
                    <h4 class="widget-title">Danh Mục</h4>
                    <ul class="filter-list">
                        <c:forEach var="c" items="${categories}">
                            <c:set var="cid" value="${c.id}"/>
                            <li>
                                <input type="checkbox" id="cat-${c.id}" name="category" value="${c.id}"
                                    ${fn:contains(selectedCategories, String.valueOf(cid)) ? 'checked' : ''}>
                                <label for="cat-${c.id}">${c.categoryName}</label>
                            </li>
                        </c:forEach>
                    </ul>
                </div>

                <%-- 3. LOẠI RƯỢU --%>
                <div class="filter-widget">
                    <h4 class="widget-title">Loại Rượu</h4>
                    <ul class="filter-list">
                        <c:forEach var="t" items="${types}">
                            <c:set var="tid" value="${t.id}"/>
                            <li>
                                <input type="checkbox" id="type-${t.id}" name="type" value="${t.id}"
                                    ${fn:contains(selectedTypes, String.valueOf(tid)) ? 'checked' : ''}>
                                <label for="type-${t.id}">${t.typeName}</label>
                            </li>
                        </c:forEach>
                    </ul>
                </div>

                <%-- 4. XUẤT XỨ --%>
                <div class="filter-widget">
                    <h4 class="widget-title">Xuất Xứ</h4>
                    <ul class="filter-list">
                        <c:forEach var="o" items="${origins}" varStatus="loop">
                            <li>
                                <input type="checkbox" id="origin-${loop.index}" name="origin" value="${o}"
                                    ${fn:contains(selectedOrigins, o) ? 'checked' : ''}>
                                <label for="origin-${loop.index}">${o}</label>
                            </li>
                        </c:forEach>
                    </ul>
                </div>

                <%-- 5. NHÀ SẢN XUẤT--%>
                <div class="filter-widget">
                    <h4 class="widget-title">Nhà sản xuất</h4>
                    <ul class="filter-list">
                        <c:forEach var="m" items="${manufacturers}">
                            <c:set var="mid" value="${m.id}"/>
                            <li>
                                <input type="checkbox" id="manu-${m.id}" name="manufacturer" value="${m.id}"
                                    ${fn:contains(selectedManufacturers, String.valueOf(mid)) ? 'checked' : ''}>
                                <label for="manu-${m.id}">${m.manufacturerName}</label>
                            </li>
                        </c:forEach>
                    </ul>
                </div>

                <%-- 6. DUNG TÍCH --%>
                <div class="filter-widget">
                    <h4 class="widget-title">Dung tích</h4>
                    <ul class="filter-list">
                        <c:forEach var="cap" items="${capacities}" varStatus="loop">
                            <li>
                                <input type="checkbox" id="cap-${loop.index}" name="capacity" value="${cap}"
                                    ${fn:contains(selectedCapacities, cap) ? 'checked' : ''}>

                                <label for="cap-${loop.index}">${cap}</label>
                            </li>
                        </c:forEach>
                    </ul>
                </div>

                <div class="filter-widget">
                    <h4 class="widget-title">Tags nổi bật</h4>
                    <ul class="filter-list">
                        <c:forEach var="tag" items="${tags}">
                            <c:set var="tagid" value="${tag.id}"/>
                            <li>
                                <input type="checkbox" id="tag-${tag.id}" name="tag" value="${tag.id}"
                                    ${fn:contains(selectedTags, String.valueOf(tagid)) ? 'checked' : ''}>
                                <label for="tag-${tag.id}">${tag.tagName}</label>
                            </li>
                        </c:forEach>
                    </ul>
                </div>

                <button type="submit" class="btn btn-primary" style="width: 100%; margin-top: 10px; border: #000000 2px solid ;">Áp dụng bộ lọc
                </button>
            </form>
        </aside>

        <div class="product-content">
            <div class="shop-content">
                <h3 class="type-wine">Rượu Vang Đỏ</h3>
                <div class="display-container">
                    <p>Hiển thị kết quả 1-24 trong số</p>
                    <div class="display-mode-container">
                        <select id="view-mode">
                            <option value="default">Thứ tự mặc định</option>
                            <option value="price-asc">Giá: Thấp đến Cao</option>
                            <option value="price-desc">Giá: Cao đến Thấp</option>
                            <option value="rating">Đánh giá cao nhất</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="product-grid">
                <jsp:useBean id="products" scope="request" type="java.util.List"/>
                <c:if test="${empty products}">
                    <p style="text-align: center; width: 100%;">Không tìm thấy sản phẩm nào phù hợp.</p>
                </c:if>

                <c:forEach var="p" items="${products}">
                    <div class="product-card">
                        <div class="product-image">
                            <a href="detail?id=${p.id}">
                                <c:choose>
                                    <c:when test="${not empty p.imageUrl}">
                                        <img src="${p.imageUrl}" alt="${p.productName}">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="https://via.placeholder.com/300x400?text=Wine" alt="Chưa có ảnh">
                                    </c:otherwise>
                                </c:choose>
                            </a>
                            <button class="wishlist-btn" aria-label="Thêm vào yêu thích" data-id="${p.id}">
                                <i class="fa-regular fa-heart"></i>
                            </button>
                        </div>

                        <div class="product-info">
                            <h3 class="product-name">
                                <a href="detail?id=${p.id}">${p.productName}</a>
                            </h3>

                            <div class="product-extra-details">
                                <ul>
                                    <li><strong>Xuất xứ:</strong> ${p.origin}</li>

                                    <li><strong>Loại:</strong> ${p.typeId}</li>

                                    <li><strong>Nồng độ:</strong> ${p.alcohol}%</li>
                                </ul>
                            </div>

                            <p class="product-producer">Nhà sản xuất: ${p.manufacturerId}</p>

                            <div class="product-rating">
                                <fmt:formatNumber var="roundedRating" value="${p.rating}" maxFractionDigits="0"/>

                                <c:forEach begin="1" end="5" var="i">
                                    <c:choose>
                                        <c:when test="${i <= roundedRating}">
                                            <i class="fa-solid fa-star" style="color: #FFD700;"></i>
                                        </c:when>
                                        <c:otherwise>
                                            <i class="fa-regular fa-star" style="color: #ccc;"></i>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>

                                <span style="font-size: 12px; color: #666;">(${p.totalReviews})</span>
                            </div>

                            <p class="product-price">
                                <fmt:setLocale value="vi_VN"/>
                                <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="₫"
                                                  maxFractionDigits="0"/>
                            </p>

                            <a href="AddToCartServlet?id=${p.id}" class="add-to-cart-btn">Thêm vào giỏ</a>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <nav class="pagination-container" aria-label="Page navigation">

                <%-- Xác định đường dẫn gốc: store hay filter --%>
                <c:set var="baseUrl"
                       value="${requestScope['javax.servlet.forward.servlet_path'] == '/filter' ? 'filter' : 'store'}"/>

                <ul class="pagination">
                    <%-- Nút Previous --%>
                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                        <%-- Link: baseUrl + page mới + filterParams cũ --%>
                        <a class="page-link" href="${baseUrl}?page=${currentPage - 1}${filterParams}"
                           aria-label="Previous">
                            <i class="fa-solid fa-angle-left"></i>
                        </a>
                    </li>

                    <%-- Các số trang --%>
                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                            <a class="page-link" href="${baseUrl}?page=${i}${filterParams}">${i}</a>
                        </li>
                    </c:forEach>

                    <%-- Nút Next --%>
                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                        <a class="page-link" href="${baseUrl}?page=${currentPage + 1}${filterParams}" aria-label="Next">
                            <i class="fa-solid fa-angle-right"></i>
                        </a>
                    </li>
                </ul>
            </nav>
        </div>
    </div>
</main>
<%@ include file="components/footer.jsp" %>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        const wishlistBtns = document.querySelectorAll('.wishlist-btn');

        wishlistBtns.forEach(btn => {
            btn.addEventListener('click', function (e) {
                e.preventDefault();

                this.classList.toggle('active');

                // Đổi icon
                const icon = this.querySelector('i');
                if (this.classList.contains('active')) {
                    icon.classList.remove('fa-regular');
                    icon.classList.add('fa-solid');
                } else {
                    icon.classList.remove('fa-solid');
                    icon.classList.add('fa-regular');
                }
            });
        });
    });
</script>
</body>
</html>