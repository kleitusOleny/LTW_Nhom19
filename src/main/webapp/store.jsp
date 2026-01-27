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
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"
          integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/store_style.css?v=3">
    <style>
        .price-slider-wrapper {
            width: 100%;
            padding: 10px 0;
            position: relative;
        }

        .slider-track-bg {
            width: 100%;
            height: 6px;
            background-color: #e0e0e0;
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            border-radius: 3px;
            z-index: 1;
        }

        .slider-track-progress {
            height: 6px;
            background-color: #8c3333;
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            z-index: 2;
            border-radius: 3px;
        }

        .range-input-container {
            position: relative;
            width: 100%;
        }

        .range-input-container input[type="range"] {
            position: absolute;
            width: 100%;
            top: -3px;
            left: 0;
            height: 6px;
            -webkit-appearance: none;
            background: none;
            pointer-events: none;
            z-index: 3;
        }

        .range-input-container input[type="range"]::-webkit-slider-thumb {
            -webkit-appearance: none;
            height: 20px;
            width: 20px;
            border-radius: 50%;
            background: #8c3333;
            cursor: pointer;
            pointer-events: auto;
            border: 2px solid #fff;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.3);
        }

        .range-input-container input[type="range"]::-moz-range-thumb {
            height: 20px;
            width: 20px;
            border-radius: 50%;
            background: #8c3333;
            cursor: pointer;
            pointer-events: auto;
            border: 2px solid #fff;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.3);
        }

        .price-values {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 15px;
            font-size: 15px;
            color: #333;
            font-weight: 500;
        }
    </style>
</head>

<body>

<%@ include file="components/header.jsp" %>
<main>

    <div class="content-container"
         style="display: grid; grid-template-columns: 280px 1fr; gap: 30px; align-items: start;">
        <aside class="filter-content">
            <h3 class="filter-title">Bộ Lọc Sản Phẩm</h3>
            <form action="filter" method="get">
                <c:if test="${not empty searchKeyword}">
                    <input type="hidden" name="search" value="${searchKeyword}">
                </c:if>
                <%-- 1. LỌC GIÁ --%>
                <fmt:formatNumber var="maxPriceInt" value="${maxPrice}"
                                  maxFractionDigits="0" groupingUsed="false"/>
                <div class="filter-widget">
                    <h4 class="widget-title">Lọc theo giá</h4>
                    <c:set var="minVal" value="0"/>
                    <c:set var="maxVal" value="${maxPriceInt}"/>

                    <c:if test="${not empty selectedPrices && selectedPrices.size() > 0}">
                        <c:set var="priceRange" value="${selectedPrices[0]}"/>
                        <c:set var="parts" value="${fn:split(priceRange, '-')}"/>
                        <c:if test="${fn:length(parts) == 2}">
                            <c:set var="minVal" value="${parts[0]}"/>
                            <c:set var="maxVal"
                                   value="${parts[1] == 'max' ? maxPriceInt : parts[1]}"/>
                        </c:if>
                    </c:if>

                    <div class="price-slider-wrapper">
                        <div class="slider-track-bg"></div>
                        <div class="slider-track-progress" id="visual-track"></div>
                        <div class="range-input-container">
                            <input type="range" id="input-min" min="0" max="${maxPriceInt}"
                                   step="10000" value="${minVal}">
                            <input type="range" id="input-max" min="0" max="${maxPriceInt}"
                                   step="10000" value="${maxVal}">
                        </div>

                        <input type="hidden" name="price" id="hidden-price-filter"
                               value="${minVal}-${maxVal}">
                    </div>

                    <div class="price-values">
                        <span id="min-price-display">0 ₫</span>
                        <span id="max-price-display">
                                                        <fmt:formatNumber value="${maxPrice}" type="currency"
                                                                          currencySymbol="₫"/>
                                                    </span>
                    </div>

                    <button type="submit" class="btn btn-primary"
                            style="width: 100%; margin-top: 10px;">Áp dụng
                    </button>
                </div>

                <%-- 2. DANH MỤC --%>
                <div class="filter-widget">
                    <h4 class="widget-title">Danh Mục</h4>
                    <ul class="filter-list">
                        <c:forEach var="c" items="${categories}">
                            <c:set var="cid" value="${c.id}"/>
                            <li>
                                <input type="checkbox" id="cat-${c.id}" name="category"
                                       value="${c.id}" ${fn:contains(selectedCategories,
                                        String.valueOf(cid)) ? 'checked' : '' }>
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
                                <input type="checkbox" id="type-${t.id}" name="type"
                                       value="${t.id}" ${fn:contains(selectedTypes,
                                        String.valueOf(tid)) ? 'checked' : '' }>
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
                                <input type="checkbox" id="origin-${loop.index}"
                                       name="origin" value="${o}"
                                    ${fn:contains(selectedOrigins, o)
                                            ? 'checked' : '' }>
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
                                <input type="checkbox" id="manu-${m.id}"
                                       name="manufacturer" value="${m.id}"
                                    ${fn:contains(selectedManufacturers,
                                            String.valueOf(mid)) ? 'checked' : '' }>
                                <label
                                        for="manu-${m.id}">${m.manufacturerName}</label>
                            </li>
                        </c:forEach>
                    </ul>
                </div>

                <%-- 6. DUNG TÍCH --%>
                <div class="filter-widget">
                    <h4 class="widget-title">Dung tích</h4>
                    <ul class="filter-list">
                        <c:forEach var="cap" items="${capacities}"
                                   varStatus="loop">
                            <li>
                                <input type="checkbox"
                                       id="cap-${loop.index}"
                                       name="capacity" value="${cap}"
                                    ${fn:contains(selectedCapacities,
                                            cap) ? 'checked' : '' }>

                                <label
                                        for="cap-${loop.index}">${cap}</label>
                            </li>
                        </c:forEach>
                    </ul>
                </div>

<%--               s--%>

                <button type="submit" class="btn btn-primary"
                        style="width: 100%; margin-top: 10px; border: #000000 2px solid ;">Áp
                    dụng bộ lọc
                </button>

            </form>
        </aside>

        <div class="product-content">
            <div class="shop-content">
                <c:choose>
                    <c:when test="${not empty searchKeyword}">
                        <h3 class="type-wine">Kết quả tìm kiếm cho: "${searchKeyword}"</h3>
                        <p>Tìm thấy ${products.size()} sản phẩm</p>
                    </c:when>
                    <c:otherwise>
                        <h3 class="type-wine">Tất cả sản phẩm</h3>
                    </c:otherwise>
                </c:choose>

                <div class="display-container">
                    <p>Hiển thị kết quả 1-24 trong số</p>
                    <div class="display-mode-container">
                        <select id="view-mode" class="form-select">
                            <option value="default" ${param.sort == 'default' ? 'selected' : ''}>Thứ tự mặc định</option>
                            <option value="price-asc" ${param.sort == 'price-asc' ? 'selected' : ''}>Giá: Thấp đến Cao</option>
                            <option value="price-desc" ${param.sort == 'price-desc' ? 'selected' : ''}>Giá: Cao đến Thấp</option>
                            <option value="rating" ${param.sort == 'rating' ? 'selected' : ''}>Đánh giá cao nhất</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="product-grid">

                <c:if test="${empty products}">
                    <p style="text-align: center; width: 100%;">Không tìm thấy sản phẩm nào phù
                        hợp.</p>
                </c:if>
                <c:forEach var="p" items="${products}">
                    <div class="product-card">
                        <div class="product-image">
                            <form action="favorites" method="post" class="wishlist-form"
                                  onsubmit="toggleFavorite(event, this)">
                                <c:choose>
                                    <c:when
                                            test="${not empty favouriteProductMap and favouriteProductMap[p.id]}">
                                        <input type="hidden" name="action" value="remove">
                                        <input type="hidden" name="productId" value="${p.id}">
                                        <button type="submit" class="wishlist-btn active"
                                                aria-label="Xóa khỏi yêu thích">
                                            <i class="fa-solid fa-heart"></i>
                                        </button>
                                    </c:when>
                                    <c:otherwise>
                                        <input type="hidden" name="action" value="add">
                                        <input type="hidden" name="productId" value="${p.id}">
                                        <button type="submit" class="wishlist-btn"
                                                aria-label="Thêm vào yêu thích">
                                            <i class="fa-regular fa-heart"></i>
                                        </button>
                                    </c:otherwise>
                                </c:choose>
                            </form>

                            <a href="detail?id=${p.id}" class="product-link">
                                <c:choose>
                                    <c:when test="${not empty p.imageUrl}">
                                        <img src="${p.imageUrl}" alt="${p.productName}">
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
                                <fmt:formatNumber var="roundedRating" value="${p.rating}"
                                                  maxFractionDigits="0"/>

                                <c:forEach begin="1" end="5" var="i">
                                    <c:choose>
                                        <c:when test="${i <= roundedRating}">
                                            <i class="fa-solid fa-star"
                                               style="color: #FFD700;"></i>
                                        </c:when>
                                        <c:otherwise>
                                            <i class="fa-regular fa-star"
                                               style="color: #ccc;"></i>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>

                                <span
                                        style="font-size: 12px; color: #666;">(${p.totalReviews})</span>
                            </div>

                            <p class="product-price">
                                <fmt:setLocale value="vi_VN"/>
                                <fmt:formatNumber value="${p.price}" type="currency"
                                                  currencySymbol="₫" maxFractionDigits="0"/>
                            </p>

                            <c:choose>
                                <c:when test="${p.quantity > 0}">
                                    <a href="add-cart?productId=${p.id}&quantity=1" class="add-to-cart-btn">
                                        Thêm vào giỏ
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <span class="add-to-cart-btn" style="background-color: #ccc; cursor: not-allowed; pointer-events: none;">
                                        Hết hàng
                                    </span>
                                </c:otherwise>
                            </c:choose>
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
                        <a class="page-link"
                           href="${baseUrl}?page=${currentPage - 1}${filterParams}"
                           aria-label="Previous">
                            <i class="fa-solid fa-angle-left"></i>
                        </a>
                    </li>

                    <%-- Các số trang --%>
                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                            <a class="page-link"
                               href="${baseUrl}?page=${i}${filterParams}">${i}</a>
                        </li>
                    </c:forEach>

                    <%-- Nút Next --%>
                    <li
                            class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                        <a class="page-link"
                           href="${baseUrl}?page=${currentPage + 1}${filterParams}"
                           aria-label="Next">
                            <i class="fa-solid fa-angle-right"></i>
                        </a>
                    </li>
                </ul>
            </nav>
        </div>
    </div>
</main>
<%@ include file="components/footer.jsp" %>

<div id="notification-modal" class="modal-overlay-custom">
    <div class="modal-content-custom">
        <div class="modal-icon-custom">
            <i class="fa-solid fa-circle-xmark"></i>
        </div>
        <h3 class="modal-title-custom">Thông báo</h3>
        <p class="modal-text-custom" id="modal-message-content">Nội dung thông báo...</p>
        <button class="btn-close-custom" onclick="closeModalCustom()">Đã hiểu</button>
    </div>
</div>

<%-- LOGIC NHẬN THÔNG BÁO TỪ SERVER --%>
<c:if test="${not empty sessionScope.failedMsg}">
    <div id="server-msg-hidden" style="display:none;" data-msg="<c:out value='${sessionScope.failedMsg}'/>"></div>
    <%
        // Xóa ngay session để không hiện lại khi F5
        session.removeAttribute("failedMsg");
    %>
</c:if>

<script>
    // Hàm mở modal
    function showModalCustom(message) {
        const modal = document.getElementById('notification-modal');
        const content = document.getElementById('modal-message-content');
        if (modal && content) {
            content.innerText = message; // Dùng innerText thay vì textContent để an toàn
            modal.classList.add('show');
            console.log("Đã mở modal với nội dung:", message);
        } else {
            console.error("Không tìm thấy ID modal trong HTML");
        }
    }

    // Hàm đóng modal
    function closeModalCustom() {
        const modal = document.getElementById('notification-modal');
        if (modal) modal.classList.remove('show');
    }

    // Đóng khi click ra ngoài
    window.addEventListener('click', function(e) {
        const modal = document.getElementById('notification-modal');
        if (e.target === modal) closeModalCustom();
    });

    // TỰ ĐỘNG CHẠY KHI LOAD TRANG
    document.addEventListener("DOMContentLoaded", function() {
        const msgDiv = document.getElementById('server-msg-hidden');
        if (msgDiv) {
            const msg = msgDiv.getAttribute('data-msg');
            if (msg && msg.trim() !== "") {
                showModalCustom(msg);
            }
        }
    });
</script>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        const sortSelect = document.getElementById('view-mode');

        if (sortSelect) {
            sortSelect.addEventListener('change', function () {
                const selectedSort = this.value;

                // Lấy URL hiện tại
                const currentUrl = new URL(window.location.href);

                // Cập nhật hoặc thêm tham số 'sort'
                currentUrl.searchParams.set('sort', selectedSort);

                // Reset về trang 1 khi thay đổi cách sắp xếp để tránh lỗi phân trang
                currentUrl.searchParams.set('page', '1');

                // Reload trang với URL mới
                window.location.href = currentUrl.toString();
            });
        }
    });

    document.addEventListener("DOMContentLoaded", function () {
        const rangeMin = document.getElementById("input-min");
        const rangeMax = document.getElementById("input-max");
        const visualTrack = document.getElementById("visual-track");
        const displayMin = document.getElementById("min-price-display");
        const displayMax = document.getElementById("max-price-display");
        const hiddenInput = document.getElementById("hidden-price-filter");

        const minLimit = 0;
        const maxLimit = parseInt(rangeMax.max);
        const gap = maxLimit / 20;// Khoảng cách tối thiểu giữa 2 nút

        function formatCurrency(value) {
            return new Intl.NumberFormat('vi-VN', {style: 'currency', currency: 'VND'}).format(value);
        }

        function updateSlider() {
            let minVal = parseInt(rangeMin.value);
            let maxVal = parseInt(rangeMax.value);

            // Chặn không cho 2 nút kéo qua nhau
            if (maxVal - minVal < gap) {
                if (this === rangeMin) {
                    rangeMin.value = maxVal - gap;
                    minVal = maxVal - gap;
                } else {
                    rangeMax.value = minVal + gap;
                    maxVal = minVal + gap;
                }
            }

            // Tính toán % để vẽ thanh màu đỏ
            // Công thức: left = % của nút min, right = 100% - % của nút max
            let percentMin = (minVal / maxLimit) * 100;
            let percentMax = (maxVal / maxLimit) * 100;

            visualTrack.style.left = percentMin + "%";
            visualTrack.style.width = (percentMax - percentMin) + "%";

            // Hiển thị text
            displayMin.textContent = formatCurrency(minVal);
            displayMax.textContent = formatCurrency(maxVal);

            // Cập nhật input ẩn
            hiddenInput.value = minVal + "-" + maxVal;
        }

        rangeMin.addEventListener("input", updateSlider);
        rangeMax.addEventListener("input", updateSlider);



        // Khởi chạy lần đầu
        updateSlider();
    });
</script>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        // ... existing slider code ...

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
                    // Update form action to 'remove' visually (though logic is handled in toggle)
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
                            // Optional: Reload to reflect server state, or just let it be
                            // window.location.reload();
                        }
                    })
                    .catch(err => console.error('Sync failed:', err));
            }
        }
    });

    function toggleFavorite(event, form) {
        event.preventDefault();

        const isLoggedIn = "${not empty sessionScope.user}" === "true";
        const formData = new FormData(form);
        const productId = formData.get('productId');
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

        // Handle Logged In Mode (Server)
        const url = form.getAttribute('action');
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
                    // Should not happen if isLoggedIn check works, but just in case
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
                    revertUI(button, icon, wasActive);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                revertUI(button, icon, wasActive);
            });
    }

    function revertUI(button, icon, wasActive) {
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
</script>
</body>

</html>