<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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

            <div class="filter-widget">
                <h4 class="widget-title">Lọc theo giá</h4>

                <ul class="filter-list">
                    <li>
                        <input type="checkbox" id="price-1">
                        <label for="price-1">Dưới 500.000₫</label>
                    </li>
                    <li>
                        <input type="checkbox" id="price-2">
                        <label for="price-2">500.000₫ - 1.000.000₫</label>
                    </li>
                    <li>
                        <input type="checkbox" id="price-3">
                        <label for="price-3">1.000.000₫ - 2.000.000₫</label>
                    </li>
                    <li>
                        <input type="checkbox" id="price-4">
                        <label for="price-4">2.000.000₫ - 5.000.000₫</label>
                    </li>
                    <li>
                        <input type="checkbox" id="price-5">
                        <label for="price-5">Trên 5.000.000₫</label>
                    </li>
                </ul>

            </div>

            <div class="filter-widget">
                <h4 class="widget-title">Danh Mục</h4>
                <ul class="filter-list">
                    <li>
                        <input type="checkbox" id="cat-bordeaux">
                        <label for="cat-bordeaux">Bordeaux</label>
                    </li>
                    <li>
                        <input type="checkbox" id="cat-khuyenmai">
                        <label for="cat-khuyenmai">Khuyến Mại</label>
                    </li>
                    <li>
                        <input type="checkbox" id="cat-nhapkhau">
                        <label for="cat-nhapkhau">Rượu Vang Nhập Khẩu</label>
                    </li>
                    <li>
                        <input type="checkbox" id="cat-phap">
                        <label for="cat-phap">Rượu Vang Pháp</label>
                    </li>
                    <li>
                        <input type="checkbox" id="cat-saint-emilion">
                        <label for="cat-saint-emilion">Saint-Émilion</label>
                    </li>
                </ul>
            </div>

            <div class="filter-widget">
                <h4 class="widget-title">Loại Rượu</h4>
                <ul class="filter-list">
                    <li>
                        <input type="checkbox" id="type-vangdo">
                        <label for="type-vangdo">Rượu Vang Đỏ</label>
                    </li>
                    <li>
                        <input type="checkbox" id="type-vangtrang">
                        <label for="type-vangtrang">Rượu Vang Trắng</label>
                    </li>
                    <li>
                        <input type="checkbox" id="type-vanghong">
                        <label for="type-vanghong">Rượu Vang Hồng</label>
                    </li>
                </ul>
            </div>

            <div class="filter-widget">
                <h4 class="widget-title">Xuất Xứ</h4>
                <ul class="filter-list">
                    <li>
                        <input type="checkbox" id="origin-phap">
                        <label for="origin-phap">Pháp</label>
                    </li>
                    <li>
                        <input type="checkbox" id="origin-y">
                        <label for="origin-y">Ý</label>
                    </li>
                    <li>
                        <input type="checkbox" id="origin-chile">
                        <label for="origin-chile">Chile</label>
                    </li>
                    <li>
                        <input type="checkbox" id="origin-my">
                        <label for="origin-my">Mỹ</label>
                    </li>
                </ul>
            </div>

            <div class="filter-widget">
                <h4 class="widget-title">Nhà sản xuất</h4>
                <ul class="filter-list">
                    <li>
                        <input type="checkbox" id="manu-corbin">
                        <label for="manu-corbin">CHÂTEAU CORBIN</label>
                    </li>
                    <li>
                        <input type="checkbox" id="manu-cantine">
                        <label for="manu-cantine">Cantine</label>
                    </li>
                    <li>
                        <input type="checkbox" id="manu-penfolds">
                        <label for="manu-penfolds">Penfolds</label>
                    </li>
                </ul>
            </div>

            <div class="filter-widget">
                <h4 class="widget-title">Dung tích</h4>
                <ul class="filter-list">
                    <li>
                        <input type="checkbox" id="cap-750">
                        <label for="cap-750">750ML</label>
                    </li>
                    <li>
                        <input type="checkbox" id="cap-1500">
                        <label for="cap-1500">1.5L</label>
                    </li>
                    <li>
                        <input type="checkbox" id="cap-3000">
                        <label for="cap-3000">3L</label>
                    </li>
                </ul>
            </div>

            <div class="filter-widget">
                <h4 class="widget-title">Tags</h4>
                <ul class="filter-list">
                    <li>
                        <input type="checkbox" id="tag-dacbiet">
                        <label for="tag-dacbiet">gcc giá đặc biệt</label>
                    </li>
                    <li>
                        <input type="checkbox" id="tag-quatang">
                        <label for="tag-quatang">Quà tặng</label>
                    </li>
                </ul>
            </div>
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
                <ul class="pagination">

                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                        <a class="page-link" href="store?page=${currentPage - 1}" aria-label="Previous">
                            <i class="fa-solid fa-angle-left"></i>
                        </a>
                    </li>

                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                            <a class="page-link" href="store?page=${i}">${i}</a>
                        </li>
                    </c:forEach>

                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                        <a class="page-link" href="store?page=${currentPage + 1}" aria-label="Next">
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