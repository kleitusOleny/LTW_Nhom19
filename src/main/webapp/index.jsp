<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <title>Main Menu</title>
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
                        rel="stylesheet"
                        integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
                        crossorigin="anonymous">
                    <link rel="stylesheet"
                        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"
                        integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A=="
                        crossorigin="anonymous" referrerpolicy="no-referrer" />
                    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/index_style.css">
                </head>

                <body>
                    <%@ include file="components/header.jsp" %>
                        <main>
                            <section class="hero-section p-0">
                                <div id="heroCarousel" class="carousel slide carousel-fade" data-bs-ride="carousel"
                                    data-bs-interval="5000">

                                    <div class="carousel-indicators">
                                        <button type="button" data-bs-target="#heroCarousel" data-bs-slide-to="0"
                                            class="active" aria-current="true" aria-label="Slide 1"></button>
                                        <button type="button" data-bs-target="#heroCarousel" data-bs-slide-to="1"
                                            aria-label="Slide 2"></button>
                                        <button type="button" data-bs-target="#heroCarousel" data-bs-slide-to="2"
                                            aria-label="Slide 3"></button>
                                        <button type="button" data-bs-target="#heroCarousel" data-bs-slide-to="3"
                                            aria-label="Slide 4"></button>
                                    </div>

                                    <div class="carousel-inner">

                                        <div class="carousel-item active">
                                            <div class="hero-overlay"></div>
                                            <img src="assets/banners/main_banner.jpg" class="d-block w-100"
                                                alt="Banner 1">
                                            <div class="carousel-caption d-none d-md-block hero-content">
                                                <h1 class="hero-title">Bộ Sưu Tập Vang Thượng Hạng</h1>
                                                <p class="hero-subtitle">Khám phá hương vị tinh tế từ những vườn nho nổi
                                                    tiếng nhất
                                                    thế
                                                    giới.</p>
                                                <a href="store.jsp" class="btn btn-primary hero-btn">Xem Ngay</a>
                                            </div>
                                        </div>

                                        <div class="carousel-item">
                                            <div class="hero-overlay"></div>
                                            <img src="assets/banners/banner-vang-bordeaux.jpg" class="d-block w-100"
                                                alt="Banner 2">
                                            <div class="carousel-caption d-none d-md-block hero-content">
                                                <h1 class="hero-title">Hương Vị Mùa Hè Tươi Mát</h1>
                                                <p class="hero-subtitle">Tuyển tập những chai vang trắng và vang hồng
                                                    xuất sắc nhất
                                                    cho mùa
                                                    hè.</p>
                                                <a href="store.jsp" class="btn btn-primary hero-btn">Khám Phá</a>
                                            </div>
                                        </div>

                                        <div class="carousel-item">
                                            <div class="hero-overlay"></div>
                                            <img src="assets/banners/banner-vang-bourgogne.jpg" class="d-block w-100"
                                                alt="Banner 3">
                                            <div class="carousel-caption d-none d-md-block hero-content">
                                                <h1 class="hero-title">Quà Tặng Doanh Nghiệp</h1>
                                                <p class="hero-subtitle">Giải pháp quà tặng sang trọng, đẳng cấp dành
                                                    cho đối tác và
                                                    khách
                                                    hàng.</p>
                                                <a href="store.jsp" class="btn btn-primary hero-btn">Liên Hệ</a>
                                            </div>
                                        </div>

                                        <div class="carousel-item">
                                            <div class="hero-overlay"></div>
                                            <img src="assets/banners/banner-vang-bordeaux.jpg" class="d-block w-100"
                                                alt="Banner 4">
                                            <div class="carousel-caption d-none d-md-block hero-content">
                                                <h1 class="hero-title">Hương Vị Mùa Hè Tươi Mát</h1>
                                                <p class="hero-subtitle">Tuyển tập những chai vang trắng và vang hồng
                                                    xuất sắc nhất
                                                    cho mùa
                                                    hè.</p>
                                                <a href="store.jsp" class="btn btn-primary hero-btn">Khám Phá</a>
                                            </div>
                                        </div>

                                    </div>

                                    <button class="carousel-control-prev" type="button" data-bs-target="#heroCarousel"
                                        data-bs-slide="prev">
                                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                        <span class="visually-hidden">Previous</span>
                                    </button>
                                    <button class="carousel-control-next" type="button" data-bs-target="#heroCarousel"
                                        data-bs-slide="next">
                                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                        <span class="visually-hidden">Next</span>
                                    </button>
                                </div>
                            </section>

                            <!-- Voucher Section -->
                            <c:if test="${not empty publicVouchers}">
                                <section class="voucher-section container my-5">
                                    <h2 class="section-title text-center mb-4">Mã Giảm Giá Dành Cho Bạn</h2>
                                    <div class="row g-4">
                                        <c:forEach var="v" items="${publicVouchers}">
                                            <c:set var="typeUpper" value="${fn:toUpperCase(v.applyType)}" />
                                            <c:if
                                                test="${fn:contains(typeUpper, 'USER') or fn:contains(typeUpper, 'SHIP')}">
                                                <div class="col-md-4 col-sm-6">
                                                    <div
                                                        class="voucher-card ${fn:contains(typeUpper, 'SHIP') ? 'voucher-card-shipping' : 'voucher-card-premium'} p-3 rounded shadow-sm d-flex align-items-center justify-content-between">
                                                        <div class="voucher-icon me-3">
                                                            <c:choose>
                                                                <c:when test="${fn:contains(typeUpper, 'SHIP')}">
                                                                    <i
                                                                        class="fa-solid fa-truck-fast fa-2x text-white"></i>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <i class="fa-solid fa-gift fa-2x text-warning"></i>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                        <div class="voucher-info flex-grow-1">
                                                            <h5
                                                                class="mb-1 fw-bold ${fn:contains(typeUpper, 'SHIP') ? 'text-white' : 'text-dark'}">
                                                                ${v.discountCode}</h5>
                                                            <p class="mb-0 ${fn:contains(typeUpper, 'SHIP') ? 'text-warning fw-bold' : 'text-danger fw-bold'}"
                                                                style="font-size: 1.1em;">
                                                                Giảm
                                                                <c:choose>
                                                                    <c:when
                                                                        test="${fn:toUpperCase(v.discountType) == 'PERCENT'}">
                                                                        <fmt:formatNumber value="${v.discountValue}"
                                                                            type="number" maxFractionDigits="0" />%
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <fmt:formatNumber value="${v.discountValue}"
                                                                            type="number" maxFractionDigits="0" />₫
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </p>
                                                            <small
                                                                class="${fn:contains(typeUpper, 'SHIP') ? 'text-white fw-bold' : 'text-dark fw-bold'}">HSD:
                                                                <fmt:formatDate value="${v.discountTo}"
                                                                    pattern="dd/MM/yyyy" />
                                                            </small>
                                                        </div>
                                                        <c:choose>
                                                            <c:when test="${collectedVoucherIds.contains(v.id)}">
                                                                <button class="btn btn-sm btn-secondary ms-2" disabled>
                                                                    Đã Thu Thập
                                                                </button>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <button
                                                                    class="btn btn-sm ${fn:contains(typeUpper, 'SHIP') ? 'btn-light text-success' : 'btn-dark'} ms-2"
                                                                    onclick="collectVoucherHome(${v.id})">
                                                                    Thu Thập
                                                                </button>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </div>
                                            </c:if>
                                        </c:forEach>
                                    </div>
                                </section>
                                <style>
                                    .voucher-card-shipping {
                                        background: linear-gradient(135deg, #28a745, #218838);
                                        color: white;
                                    }

                                    .voucher-card-premium {
                                        background: linear-gradient(135deg, #fff, #f8f9fa);
                                        border: 1px solid gold;
                                        border-left: 5px solid #ffc107;
                                    }
                                </style>
                                <script>
                                    function collectVoucherHome(discountId) {
                                        fetch('cart/collect-voucher?discountId=' + discountId, {
                                            method: 'POST'
                                        })
                                            .then(response => response.json())
                                            .then(data => {
                                                if (data.success) {
                                                    alert(data.message);
                                                    location.reload();
                                                } else {
                                                    alert(data.message);
                                                }
                                            })
                                            .catch(error => console.error('Error collecting voucher:', error));
                                    }
                                </script>
                            </c:if>

                            <c:if test="${not empty topFavouritesList}">
                                <section class="featured-products container" style="position: relative;">
                                    <h2 class="section-title">Sản Phẩm Được Yêu Thích Nhiều Nhất</h2>
                                    <p class="section-subtitle">Những chai vang được khách hàng yêu thích và đánh giá

                                        <!-- Navigation Buttons -->


                                        cao
                                    </p>

                                    <!-- Navigation Buttons -->
                                    <button class="scroll-btn scroll-btn-left" onclick="scrollFavorites('left')"
                                        style="position: absolute; left: -20px; top: 50%; transform: translateY(-50%); z-index: 10; background: rgba(255,255,255,0.9); border: 1px solid #ddd; border-radius: 50%; width: 40px; height: 40px; cursor: pointer; box-shadow: 0 2px 8px rgba(0,0,0,0.15);">
                                        <i class="fa-solid fa-chevron-left"></i>
                                    </button>
                                    <button class="scroll-btn scroll-btn-right" onclick="scrollFavorites('right')"
                                        style="position: absolute; right: -20px; top: 50%; transform: translateY(-50%); z-index: 10; background: rgba(255,255,255,0.9); border: 1px solid #ddd; border-radius: 50%; width: 40px; height: 40px; cursor: pointer; box-shadow: 0 2px 8px rgba(0,0,0,0.15);">
                                        <i class="fa-solid fa-chevron-right"></i>
                                    </button>

                                    <div class="product-grid" id="topFavoritesGrid"
                                        style="overflow-x: auto; scroll-behavior: smooth; scrollbar-width: none; -ms-overflow-style: none;">
                                        <c:forEach var="fav" items="${topFavouritesList}">
                                            <div class="product-card">
                                                <div class="product-image" style="position: relative;">
                                                    <form action="${pageContext.request.contextPath}/favorites"
                                                        method="post" class="wishlist-form"
                                                        onsubmit="toggleFavorite(event, this)">
                                                        <input type="hidden" name="action" value="add">
                                                        <input type="hidden" name="productId" value="${fav.product_id}">
                                                        <button type="submit" class=" wishlist-btn"
                                                            aria-label="Thêm vào yêu thích">
                                                            <i class="fa-regular fa-heart"></i>
                                                        </button>
                                                    </form>

                                                    <a href="${pageContext.request.contextPath}/detail?id=${fav.product_id}"
                                                        class="product-link">
                                                        <c:choose>
                                                            <c:when test="${not empty fav.image_url}">
                                                                <img src="${pageContext.request.contextPath}/${fav.image_url}"
                                                                    alt="${fav.product_name}">
                                                            </c:when>
                                                            <c:otherwise>
                                                                <img src="https://via.placeholder.com/300x400?text=Wine"
                                                                    alt="Chưa có ảnh">
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </a>

                                                    <!-- DEBUG: VD/0281 | discount_type=[${fav.discount_type}] | discount_value=[${fav.discount_value}] | empty?=${empty fav.discount_type} -->

                                                    <!-- Discount badge -->
                                                    <c:if
                                                        test="${fav.discount_type == 'PERCENT' or fav.discount_type == 'percent'}">
                                                        <div
                                                            style="position: absolute; top: 10px; left: 10px; background: #dc3545; color: white; padding: 8px 12px; border-radius: 5px; font-weight: bold; font-size: 14px; z-index: 5; box-shadow: 0 2px 4px rgba(0,0,0,0.2);">
                                                            -
                                                            <fmt:formatNumber value="${fav.discount_value}"
                                                                maxFractionDigits="0" />%
                                                        </div>
                                                    </c:if>
                                                    <c:if
                                                        test="${fav.discount_type == 'AMOUNT' or fav.discount_type == 'amount'}">
                                                        <div
                                                            style="position: absolute; top: 10px; left: 10px; background: #dc3545; color: white; padding: 8px 12px; border-radius: 5px; font-weight: bold; font-size: 14px; z-index: 5; box-shadow: 0 2px 4px rgba(0,0,0,0.2);">
                                                            Giảm
                                                            <fmt:formatNumber value="${fav.discount_value}"
                                                                maxFractionDigits="0" />₫
                                                        </div>
                                                    </c:if>
                                                </div>
                                                <div class="product-info">
                                                    <h3 class="product-name">
                                                        <a
                                                            href="${pageContext.request.contextPath}/detail?id=${fav.product_id}">
                                                            <c:choose>
                                                                <c:when test="${fn:length(fav.product_name) > 50}">
                                                                    ${fn:substring(fav.product_name, 0, 50)}...
                                                                </c:when>
                                                                <c:otherwise>
                                                                    ${fav.product_name}
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </a>
                                                    </h3>

                                                    <div class="product-extra-details">
                                                        <ul>
                                                            <li><strong>Xuất xứ:</strong> ${fav.origin}</li>
                                                            <li><strong>Loại:</strong> ${fav.type_name}</li>
                                                            <li><strong>Nồng độ:</strong> ${fav.alcohol}%</li>
                                                        </ul>
                                                    </div>

                                                    <p class="product-producer">Nhà sản xuất:
                                                        ${fav.manufacturer_name}
                                                    </p>

                                                    <p class="product-price">
                                                        <c:set var="price" value="${fav.price}" />
                                                        <c:set var="discountValue" value="${fav.discount_value}" />
                                                        <c:set var="discountType" value="${fav.discount_type}" />
                                                        <c:set var="discountedPrice" value="${price}" />

                                                        <c:if test="${not empty discountType}">
                                                            <c:set var="discountTypeUpper"
                                                                value="${fn:toUpperCase(discountType)}" />
                                                            <c:choose>
                                                                <c:when test="${discountTypeUpper == 'PERCENT'}">
                                                                    <c:set var="discountedPrice"
                                                                        value="${price * (1 - discountValue / 100.0)}" />
                                                                </c:when>
                                                                <c:when test="${discountTypeUpper == 'AMOUNT'}">
                                                                    <c:set var="discountedPrice"
                                                                        value="${price - discountValue}" />
                                                                </c:when>
                                                            </c:choose>
                                                        </c:if>

                                                        <fmt:setLocale value="vi_VN" />
                                                        <c:choose>
                                                            <c:when test="${discountedPrice < price}">
                                                                <span
                                                                    style="color: #8c3333; font-weight: bold; font-size: 1.1rem;"
                                                                    class="me-2">
                                                                    <fmt:formatNumber value="${discountedPrice}"
                                                                        type="number" maxFractionDigits="0" />₫
                                                                </span>
                                                                <span class="text-muted text-decoration-line-through"
                                                                    style="font-size: 0.9rem;">
                                                                    <fmt:formatNumber value="${price}" type="number"
                                                                        maxFractionDigits="0" />₫
                                                                </span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span style="color: #8c3333; font-weight: bold;">
                                                                    <fmt:formatNumber value="${price}" type="number"
                                                                        maxFractionDigits="0" />₫
                                                                </span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </p>

                                                    <a href="${pageContext.request.contextPath}/add-cart?productId=${fav.product_id}&quantity=1"
                                                        class="add-to-cart-btn">Thêm vào giỏ</a>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>

                                    <style>
                                        #topFavoritesGrid::-webkit-scrollbar {
                                            display: none;
                                        }

                                        .scroll-btn:hover {
                                            background: #fff !important;
                                            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2) !important;
                                        }
                                    </style>
                                </section>
                            </c:if>

                            <c:if test="${not empty userFavouritesList}">
                                <h2 class="section-title">Sản Phẩm Yêu Thích Của Tôi</h2>
                                <p class="section-subtitle">Những chai vang được yêu thích</p>
                                <section class="featured-products container" style="position: relative;">
                                    <div id="userFavoritesCarousel" class="carousel slide" data-bs-ride="false">
                                        <div class="carousel-inner">
                                            <c:forEach var="fav" items="${userFavouritesList}" varStatus="status">
                                                <c:if test="${status.index % 4 == 0}">
                                                    <div class="carousel-item ${status.index == 0 ? 'active' : ''}">
                                                        <div class="product-grid"
                                                            style="grid-template-columns: repeat(4, 1fr); gap: 30px;">
                                                </c:if>

                                                <div class="product-card">
                                                    <div class="product-image">
                                                        <form action="${pageContext.request.contextPath}/favorites"
                                                            method="post" class="wishlist-form"
                                                            onsubmit="toggleFavorite(event, this)">
                                                            <input type="hidden" name="action" value="remove">
                                                            <input type="hidden" name="favouriteId"
                                                                value="${fav.favourite_id}">
                                                            <input type="hidden" name="productId"
                                                                value="${fav.product_id}">
                                                            <button type="submit" class="wishlist-btn active"
                                                                aria-label="Xóa khỏi yêu thích">
                                                                <i class="fa-solid fa-heart"></i>
                                                            </button>
                                                        </form>

                                                        <a href="${pageContext.request.contextPath}/detail?id=${fav.product_id}"
                                                            class="product-link">
                                                            <c:choose>
                                                                <c:when test="${not empty fav.image_url}">
                                                                    <img src="${pageContext.request.contextPath}/${fav.image_url}"
                                                                        alt="${fav.product_name}">
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <img src="https://via.placeholder.com/300x400?text=Wine"
                                                                        alt="Chưa có ảnh">
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </a>
                                                    </div>
                                                    <div class="product-info">
                                                        <h3 class="product-name">
                                                            <a
                                                                href="${pageContext.request.contextPath}/detail?id=${fav.product_id}">
                                                                <c:choose>
                                                                    <c:when test="${fn:length(fav.product_name) > 50}">
                                                                        ${fn:substring(fav.product_name, 0, 50)}...
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        ${fav.product_name}
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </a>
                                                        </h3>

                                                        <div class="product-extra-details">
                                                            <ul>
                                                                <li><strong>Xuất xứ:</strong> ${fav.origin}</li>
                                                                <li><strong>Loại:</strong> ${fav.type_name}</li>
                                                                <li><strong>Nồng độ:</strong> ${fav.alcohol}%</li>
                                                            </ul>
                                                        </div>

                                                        <p class="product-producer">Nhà sản xuất:
                                                            ${fav.manufacturer_name}</p>

                                                        <p class="product-price">
                                                            <c:set var="price" value="${fav.price}" />
                                                            <c:set var="discountValue" value="${fav.discount_value}" />
                                                            <c:set var="discountType" value="${fav.discount_type}" />
                                                            <c:set var="discountedPrice" value="${price}" />

                                                            <c:if test="${not empty discountType}">
                                                                <c:set var="discountTypeUpper"
                                                                    value="${fn:toUpperCase(discountType)}" />
                                                                <c:choose>
                                                                    <c:when test="${discountTypeUpper == 'PERCENT'}">
                                                                        <c:set var="discountedPrice"
                                                                            value="${price * (1 - discountValue / 100.0)}" />
                                                                    </c:when>
                                                                    <c:when test="${discountTypeUpper == 'AMOUNT'}">
                                                                        <c:set var="discountedPrice"
                                                                            value="${price - discountValue}" />
                                                                    </c:when>
                                                                </c:choose>
                                                            </c:if>

                                                            <fmt:setLocale value="vi_VN" />
                                                            <c:choose>
                                                                <c:when test="${discountedPrice < price}">
                                                                    <span style="color: #8c3333; font-weight: bold;"
                                                                        class="me-2">
                                                                        <fmt:formatNumber value="${discountedPrice}"
                                                                            type="number" maxFractionDigits="0" />₫
                                                                    </span>
                                                                    <span
                                                                        class="text-muted text-decoration-line-through small">
                                                                        <fmt:formatNumber value="${price}" type="number"
                                                                            maxFractionDigits="0" />₫
                                                                    </span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span style="color: #8c3333; font-weight: bold;">
                                                                        <fmt:formatNumber value="${price}" type="number"
                                                                            maxFractionDigits="0" />₫
                                                                    </span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </p>

                                                        <a href="${pageContext.request.contextPath}/add-cart?productId=${fav.product_id}&quantity=1"
                                                            class="add-to-cart-btn">Thêm vào giỏ</a>
                                                    </div>
                                                </div>

                                                <c:if test="${status.index % 4 == 3 || status.last}">
                                        </div>
                                    </div>
                            </c:if>
                            </c:forEach>
                            </div>

                            <button class="carousel-control-prev" type="button" data-bs-target="#userFavoritesCarousel"
                                data-bs-slide="prev" style="left: -60px; top: -290px">
                                <span class="carousel-control-prev-icon" aria-hidden="true"
                                    style="background-color: #8c3333; border-radius: 50%; padding: 20px;"></span>
                                <span class="visually-hidden">Previous</span>
                            </button>
                            <button class="carousel-control-next" type="button" data-bs-target="#userFavoritesCarousel"
                                data-bs-slide="next" style="top: -240px">
                                <span class="carousel-control-next-icon" aria-hidden="true"
                                    style="background-color: #8c3333; border-radius: 50%; padding: 20px;"></span>
                                <span class="visually-hidden">Next</span>
                            </button>
                            </div>
                            </section>
                            </c:if>

                            <section class="featured-products container">

                                <h2 class="section-title">Sản Phẩm Nổi Bật</h2>
                                <p class="section-subtitle">Những chai vang được yêu thích và đánh giá cao nhất</p>

                                <div class="product-grid">

                                    <div class="product-card">
                                        <div class="product-image">
                                            <a href="Detail.jsp">
                                                <img src="img/SKU__VD_0834-14-1.5L.jpg"
                                                    alt="Rượu Vang Đỏ Sandrone Barolo Le Vigne – 1.5L 2014">
                                            </a>
                                            <button class="wishlist-btn" aria-label="Thêm vào yêu thích">
                                                <i class="fa-regular fa-heart"></i>
                                            </button>
                                        </div>
                                        <div class="product-info">
                                            <h3 class="product-name"><a href="#">Rượu Vang Đỏ Sandrone Barolo Le
                                                    Vigne –
                                                    1.5L 2014</a></h3>
                                            <div class="product-extra-details">
                                                <ul>
                                                    <li><strong>Xuất xứ:</strong> Ý</li>
                                                    <li><strong>Loại:</strong> Rượu Vang Đỏ</li>
                                                    <li><strong>Nồng độ:</strong> 14.5%</li>
                                                </ul>
                                            </div>
                                            <p class="product-producer">Nhà sản xuất: LUCIANO SANDRONE</p>
                                            <div class="product-rating">
                                                <i class="fa-solid fa-star"></i>
                                                <i class="fa-solid fa-star"></i>
                                                <i class="fa-solid fa-star"></i>
                                                <i class="fa-solid fa-star"></i>
                                                <i class="fa-regular fa-star"></i>
                                            </div>
                                            <p class="product-price">13.486.000₫</p>
                                            <a href="#" class="add-to-cart-btn">Thêm vào giỏ</a>
                                        </div>
                                    </div>

                                    <div class="product-card">
                                        <div class="product-image">
                                            <a href="#">
                                                <img src="img/SKU__VD_0845-17.jpg"
                                                    alt="Rượu Vang Đỏ Luce Brunello Di Montalcino 2017">
                                            </a>
                                            <button class="wishlist-btn" aria-label="Thêm vào yêu thích">
                                                <i class="fa-regular fa-heart"></i>
                                            </button>
                                        </div>
                                        <div class="product-info">
                                            <h3 class="product-name"><a href="#">Rượu Vang Đỏ Luce Brunello Di
                                                    Montalcino 2017</a></h3>
                                            <div class="product-extra-details">
                                                <ul>
                                                    <li><strong>Xuất xứ:</strong> Ý</li>
                                                    <li><strong>Loại:</strong> Rượu Vang Đỏ</li>
                                                    <li><strong>Nồng độ:</strong> 15.0%</li>
                                                </ul>
                                            </div>
                                            <p class="product-producer">Nhà sản xuất: TENUTA LUCE</p>
                                            <div class="product-rating">
                                                <i class="fa-solid fa-star"></i>
                                                <i class="fa-solid fa-star"></i>
                                                <i class="fa-solid fa-star"></i>
                                                <i class="fa-solid fa-star"></i>
                                                <i class="fa-solid fa-star"></i>
                                            </div>
                                            <p class="product-price">5.989.500₫</p>
                                            <a href="#" class="add-to-cart-btn">Thêm vào giỏ</a>
                                        </div>
                                    </div>

                                    <div class="product-card">
                                        <div class="product-image">
                                            <a href="#">
                                                <img src="img/SKU__VD_0883-09-3L.jpg"
                                                    alt="Rượu Vang Đỏ Muga Prado Enea Gran Reserva 2009 3 Lít">
                                            </a>
                                            <button class="wishlist-btn" aria-label="Thêm vào yêu thích">
                                                <i class="fa-regular fa-heart"></i>
                                            </button>
                                        </div>
                                        <div class="product-info">
                                            <h3 class="product-name">
                                                <a href="#">Rượu Vang Đỏ Muga Prado Enea Gran Reserva 2009 3 Lít</a>
                                            </h3>
                                            <div class="product-extra-details">
                                                <ul>
                                                    <li><strong>Xuất xứ:</strong> Tây Ban Nha</li>
                                                    <li><strong>Loại:</strong> Rượu Vang Đỏ</li>
                                                    <li><strong>Nồng độ:</strong> 14.5%</li>
                                                </ul>
                                            </div>
                                            <p class="product-producer">Nhà sản xuất: BODEGAS MUGA</p>
                                            <div class="product-rating">
                                                <i class="fa-solid fa-star"></i>
                                                <i class="fa-solid fa-star"></i>
                                                <i class="fa-solid fa-star"></i>
                                                <i class="fa-solid fa-star"></i>
                                                <i class="fa-regular fa-star"></i>
                                            </div>
                                            <p class="product-price">9.460.000₫</p>
                                            <a href="#" class="add-to-cart-btn">Thêm vào giỏ</a>
                                        </div>
                                    </div>

                                    <div class="product-card">
                                        <div class="product-image">
                                            <a href="#">
                                                <img src="img/SKU__VD_0883-14.jpg"
                                                    alt="Rượu Vang Đỏ Muga Prado Enea Gran Reserva 2014">
                                            </a>
                                            <button class="wishlist-btn" aria-label="Thêm vào yêu thích">
                                                <i class="fa-regular fa-heart"></i>
                                            </button>
                                        </div>
                                        <div class="product-info">
                                            <h3 class="product-name"><a href="#">Rượu Vang Đỏ Muga Prado Enea Gran
                                                    Reserva 2014</a></h3>
                                            <div class="product-extra-details">
                                                <ul>
                                                    <li><strong>Xuất xứ:</strong> Tây Ban Nha</li>
                                                    <li><strong>Loại:</strong> Rượu Vang Đỏ</li>
                                                    <li><strong>Nồng độ:</strong> 14.5%</li>
                                                </ul>
                                            </div>
                                            <p class="product-producer">Nhà sản xuất: BODEGAS MUGA</p>
                                            <div class="product-rating">
                                                <i class="fa-solid fa-star"></i>
                                                <i class="fa-solid fa-star"></i>
                                                <i class="fa-solid fa-star"></i>
                                                <i class="fa-solid fa-star"></i>
                                                <i class="fa-regular fa-star"></i>
                                            </div>
                                            <p class="product-price">2.783.000₫</p>
                                            <a href="#" class="add-to-cart-btn">Thêm vào giỏ</a>
                                        </div>
                                    </div>

                                </div>
                            </section>
                            <section class="featured-brands">
                                <div class="container">

                                    <h2 class="section-title">Thương Hiệu Nổi Bật</h2>
                                    <p class="section-subtitle">Những nhà sản xuất danh tiếng hàng đầu</p>

                                    <div class="brands-grid">

                                        <a href="store.jsp" class="brand-logo-box">
                                            <img src="img/Alfred-gratien-80.jpg" alt="Thương hiệu 1">
                                        </a>

                                        <a href="#" class="brand-logo-box">
                                            <img src="img/Billecart-Salmon-80.jpg" alt="Thương hiệu 2">
                                        </a>

                                        <a href="#" class="brand-logo-box">
                                            <img src="img/Cantenac-Brown-80.jpg" alt="Thương hiệu 3">
                                        </a>

                                        <a href="#" class="brand-logo-box">
                                            <img src="img/Chateau-de-Meursault-80.jpg" alt="Thương hiệu 4">
                                        </a>

                                        <a href="#" class="brand-logo-box">
                                            <img src="img/Freixenet-80.jpg" alt="Thương hiệu 5">
                                        </a>

                                        <a href="#" class="brand-logo-box">
                                            <img src="img/Louis-latour-80.jpg" alt="Thương hiệu 6">
                                        </a>

                                    </div>
                                </div>
                            </section>

                            <c:if test="${not empty latestBlogs}">
                                <section class="blog-section">
                                    <div class="container">

                                        <h2 class="section-title">Cẩm Nang Rượu Vang</h2>
                                        <p class="section-subtitle">Khám phá kiến thức và nghệ thuật thưởng thức rượu
                                            vang</p>

                                        <div class="blog-grid">
                                            <c:forEach items="${latestBlogs}" var="blog" varStatus="status" end="5">
                                                <article class="blog-card">
                                                    <div class="blog-image">
                                                        <a
                                                            href="${pageContext.request.contextPath}/blog-detail?slug=${blog.slug}">
                                                            <img src="${blog.blogImage != null ? blog.blogImage : 'img/ruou.jpg'}"
                                                                alt="${blog.title}">
                                                        </a>
                                                        <span class="blog-date">
                                                            ${blog.cardDate}
                                                        </span>
                                                    </div>
                                                    <div class="blog-content">
                                                        <h3 class="blog-title">
                                                            <a
                                                                href="${pageContext.request.contextPath}/blog-detail?slug=${blog.slug}">
                                                                ${blog.title}
                                                            </a>
                                                        </h3>
                                                        <p class="blog-excerpt">
                                                            ${fn:length(blog.content) > 100 ? fn:substring(blog.content,
                                                            0, 100).concat('...') : blog.content}
                                                        </p>
                                                        <a href="${pageContext.request.contextPath}/blog-detail?slug=${blog.slug}"
                                                            class="read-more-btn">
                                                            Xem thêm <i class="fa-solid fa-arrow-right"></i>
                                                        </a>
                                                    </div>
                                                </article>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </section>
                            </c:if>

                            <section class="service-commitment-section">
                                <div class="container">
                                    <div class="service-grid">

                                        <div class="service-item">
                                            <i class="fa-solid fa-truck-fast"></i>
                                            <h4>Giao Hàng Nhanh</h4>
                                            <p>Giao hàng hỏa tốc 2H tại TP.HCM</p>
                                        </div>

                                        <div class="service-item">
                                            <i class="fa-solid fa-shield-halved"></i>
                                            <h4>100% Chính Hãng</h4>
                                            <p>Cam kết sản phẩm nhập khẩu chính ngạch</p>
                                        </div>

                                        <div class="service-item">
                                            <i class="fa-solid fa-comments"></i>
                                            <h4>Tư Vấn Chuyên Nghiệp</h4>
                                            <p>Đội ngũ am hiểu, hỗ trợ 24/7</p>
                                        </div>

                                        <div class="service-item">
                                            <i class="fa-solid fa-box-open"></i>
                                            <h4>Đóng Gói An Toàn</h4>
                                            <p>Bảo vệ sản phẩm cẩn thận, an toàn</p>
                                        </div>

                                    </div>
                                </div>
                            </section>
                        </main>
                        <!-- Notification Modal -->
                        <div class="modal fade" id="notificationModal" tabindex="-1"
                            aria-labelledby="notificationModalLabel" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered">
                                <div class="modal-content">
                                    <div class="modal-header border-0">
                                        <h5 class="modal-title" id="notificationModalLabel">Thông báo</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"
                                            aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body text-center py-4">
                                        <div id="notificationIcon" class="mb-3"></div>
                                        <p id="notificationMessage" class="mb-0 fs-5"></p>
                                    </div>
                                    <div class="modal-footer border-0 justify-content-center">
                                        <button type="button" id="modalSecondaryBtn" class="btn btn-secondary px-4 me-2"
                                            data-bs-dismiss="modal" style="display:none;">Không</button>
                                        <button type="button" id="modalPrimaryBtn" class="btn btn-primary px-4"
                                            data-bs-dismiss="modal">Đồng ý</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <script>
                            function showNotification(message, type = 'info', requireLogin = false) {
                                const modal = new bootstrap.Modal(document.getElementById('notificationModal'));
                                const msgEl = document.getElementById('notificationMessage');
                                const iconEl = document.getElementById('notificationIcon');
                                const primaryBtn = document.getElementById('modalPrimaryBtn');
                                const secondaryBtn = document.getElementById('modalSecondaryBtn');

                                msgEl.textContent = message;

                                // Icon
                                if (type === 'success') {
                                    iconEl.innerHTML = '<i class="fa-solid fa-circle-check text-success fa-3x"></i>';
                                } else if (type === 'error') {
                                    iconEl.innerHTML = '<i class="fa-solid fa-circle-exclamation text-danger fa-3x"></i>';
                                } else {
                                    iconEl.innerHTML = '<i class="fa-solid fa-circle-info text-primary fa-3x"></i>';
                                }

                                // Buttons
                                if (requireLogin) {
                                    secondaryBtn.style.display = 'inline-block';
                                    secondaryBtn.textContent = 'Không';

                                    primaryBtn.textContent = 'Đăng nhập';
                                    primaryBtn.onclick = function () {
                                        window.location.href = 'AuthPages/Login.jsp';
                                    };
                                } else {
                                    secondaryBtn.style.display = 'none';
                                    primaryBtn.textContent = 'Đồng ý';
                                    primaryBtn.onclick = function () {
                                        if (type === 'success') location.reload();
                                        else modal.hide();
                                    };
                                }

                                modal.show();
                            }

                            function collectVoucherHome(discountId) {
                                fetch('cart/collect-voucher?discountId=' + discountId, {
                                    method: 'POST'
                                })
                                    .then(response => response.json())
                                    .then(data => {
                                        if (data.success) {
                                            showNotification(data.message, 'success');
                                        } else {
                                            showNotification(data.message, 'error', data.requireLogin);
                                        }
                                    })
                                    .catch(error => console.error('Error collecting voucher:', error));
                            }
                        </script>
                        <%@ include file="components/footer.jsp" %>
                            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
                                integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
                                crossorigin="anonymous"></script>
                            <script>
                                document.addEventListener("DOMContentLoaded", function () {
                                    const wishlistBtns = document.querySelectorAll('.wishlist-btn');

                                    wishlistBtns.forEach(btn => {
                                        btn.addEventListener('click', function (e) {
                                            e.preventDefault(); // Ngăn chặn click vào thẻ a bao quanh (nếu có)

                                            this.classList.toggle('active');
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
                            <script>
                                function scrollFavorites(direction) {
                                    const grid = document.getElementById('topFavoritesGrid');
                                    const scrollAmount = 300; // pixels to scroll

                                    if (direction === 'left') {
                                        grid.scrollLeft -= scrollAmount;
                                    } else {
                                        grid.scrollLeft += scrollAmount;
                                    }
                                }

                                function scrollUserFavorites(direction) {
                                    const grid = document.getElementById('userFavoritesGrid');
                                    const scrollAmount = 300; // pixels to scroll

                                    if (direction === 'left') {
                                        grid.scrollLeft -= scrollAmount;
                                    } else {
                                        grid.scrollLeft += scrollAmount;
                                    }
                                }
                            </script>
                            <script>
                                const urlParams = new URLSearchParams(window.location.search);
                                if (urlParams.has('loginSuccess')) {
                                    alert("Bạn đã đăng nhập thành công!");
                                    window.history.replaceState({}, document.title, window.location.pathname);
                                }
                                if (urlParams.has('registerSuccess')) {
                                    alert("Bạn đã đăng kí thành công!");
                                    window.history.replaceState({}, document.title, window.location.pathname);
                                }
                            </script>
                            <script>
                                document.addEventListener("DOMContentLoaded", function () {
                                    // Guest Favorites Logic
                                    const isLoggedIn = "${not empty sessionScope.user}" === "true";

                                    // 1. Initialize UI from localStorage if guest
                                    if (!isLoggedIn) {
                                        const guestFavorites = JSON.parse(localStorage.getItem('guestFavorites')) || [];
                                        document.querySelectorAll('.wishlist-form').forEach(form => {
                                            const productId = form.querySelector('input[name="productId"]').value;
                                            const button = form.querySelector('button');
                                            const icon = button.querySelector('i');

                                            if (guestFavorites.includes(productId)) {
                                                button.classList.add('active');
                                                icon.classList.remove('fa-regular');
                                                icon.classList.add('fa-solid');
                                            }
                                        });
                                    }

                                    // 2. Sync if logged in and has pending favorites
                                    if (isLoggedIn) {
                                        const guestFavorites = JSON.parse(localStorage.getItem('guestFavorites')) || [];
                                        if (guestFavorites.length > 0) {
                                            console.log('Syncing guest favorites:', guestFavorites);
                                            fetch('favorites', {
                                                method: 'POST',
                                                headers: {
                                                    'Content-Type': 'application/x-www-form-urlencoded',
                                                    'X-Requested-With': 'XMLHttpRequest'
                                                },
                                                body: new URLSearchParams({
                                                    action: 'sync',
                                                    productIds: guestFavorites.join(',')
                                                })
                                            })
                                                .then(response => response.json())
                                                .then(data => {
                                                    if (data.status === 'success') {
                                                        console.log('Sync successful');
                                                        localStorage.removeItem('guestFavorites');
                                                    }
                                                })
                                                .catch(err => console.error('Sync failed:', err));
                                        }
                                    }
                                });

                                function toggleFavorite(event, form) {
                                    event.preventDefault(); // Prevent default form submission

                                    const isLoggedIn = "${not empty sessionScope.user}" === "true";
                                    const formData = new FormData(form);
                                    const productId = formData.get('productId');
                                    const url = form.getAttribute('action');
                                    const button = form.querySelector('button');
                                    const icon = button.querySelector('i');
                                    const wasActive = button.classList.contains('active');

                                    // Optimistic UI Update
                                    button.classList.toggle('active');
                                    if (button.classList.contains('active')) {
                                        icon.classList.remove('fa-regular');
                                        icon.classList.add('fa-solid');
                                    } else {
                                        icon.classList.remove('fa-solid');
                                        icon.classList.add('fa-regular');
                                    }

                                    if (!isLoggedIn) {
                                        // Handle Guest Mode (localStorage)
                                        let guestFavorites = JSON.parse(localStorage.getItem('guestFavorites')) || [];

                                        if (wasActive) {
                                            // Remove
                                            guestFavorites = guestFavorites.filter(id => id !== productId);
                                        } else {
                                            // Add
                                            if (!guestFavorites.includes(productId)) {
                                                guestFavorites.push(productId);
                                            }
                                        }

                                        localStorage.setItem('guestFavorites', JSON.stringify(guestFavorites));
                                        console.log('Guest favorites updated:', guestFavorites);
                                        return; // Stop here, don't call server
                                    }

                                    fetch(url, {
                                        method: 'POST',
                                        body: new URLSearchParams(formData),
                                        headers: {
                                            'X-Requested-With': 'XMLHttpRequest',
                                            'Content-Type': 'application/x-www-form-urlencoded'
                                        }
                                    })
                                        .then(response => {
                                            if (response.status === 401) {
                                                window.location.href = '${pageContext.request.contextPath}/AuthPages/Login.jsp';
                                                return;
                                            }
                                            return response.json();
                                        })
                                        .then(data => {
                                            if (data && data.status === 'success') {
                                                // Success
                                            } else {
                                                // Revert UI
                                                console.error('Action failed, reverting UI');
                                                if (wasActive) {
                                                    button.classList.add('active');
                                                    icon.classList.remove('fa-regular');
                                                    icon.classList.add('fa-solid');
                                                } else {
                                                    button.classList.remove('active');
                                                    icon.classList.remove('fa-solid');
                                                    icon.classList.add('fa-regular');
                                                }
                                            }
                                        })
                                        .catch(error => {
                                            console.error('Error:', error);
                                            // Revert UI
                                            if (wasActive) {
                                                button.classList.add('active');
                                                icon.classList.remove('fa-regular');
                                                icon.classList.add('fa-solid');
                                            } else {
                                                button.classList.remove('active');
                                                icon.classList.remove('fa-solid');
                                                icon.classList.add('fa-regular');
                                            }
                                        });
                                }
                            </script>
                </body>

                </html>