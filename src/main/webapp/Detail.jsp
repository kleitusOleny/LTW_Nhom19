<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <title>${product.productName} | Store</title>
                <link rel="stylesheet"
                    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" />
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/detail_style.css?v=2">
            </head>

            <body>
                <%@ include file="components/header.jsp" %>
                    <main>
                        <div class="product-detail-container">
                            <div class="detail-grid-container">
                                <div class="product-gallery-column">
                                    <div class="main-image-container">
                                        <c:choose>
                                            <c:when test="${not empty product.imageUrl}">
                                                <img src="${product.imageUrl}" alt="${product.productName}"
                                                    id="main-product-image">
                                            </c:when>
                                            <c:otherwise>
                                                <img src="https://via.placeholder.com/300x400?text=Wine"
                                                    alt="Chưa có ảnh" id="main-product-image">
                                            </c:otherwise>
                                        </c:choose>
                                        <div id="lens" class="img-zoom-lens"></div>
                                        <form action="<%= request.getContextPath() %>/favorites" method="post"
                                            class="wishlist-form" onsubmit="toggleFavorite(event, this)">
                                            <c:choose>
                                                <c:when
                                                    test="${not empty favouriteProductMap and favouriteProductMap[product.id]}">
                                                    <input type="hidden" name="action" value="remove">
                                                    <input type="hidden" name="productId" value="${product.id}">
                                                    <button type="submit" class="wishlist-btn active"
                                                        aria-label="Xóa khỏi yêu thích">
                                                        <i class="fa-solid fa-heart"></i>
                                                    </button>
                                                </c:when>
                                                <c:otherwise>
                                                    <input type="hidden" name="action" value="add">
                                                    <input type="hidden" name="productId" value="${product.id}">
                                                    <button type="submit" class="wishlist-btn"
                                                        aria-label="Thêm vào yêu thích">
                                                        <i class="fa-regular fa-heart"></i>
                                                    </button>
                                                </c:otherwise>
                                            </c:choose>
                                        </form>
                                    </div>
                                    <div id="myresult" class="img-zoom-result"></div>
                                </div>

                                <div class="product-info-column">
                                    <div
                                        style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 15px;">
                                        <h1 class="product-detail-title">${product.productName}</h1>

                                    </div>

                                    <ul class="product-specs-list">
                                        <li><span>Xuất xứ:</span> <strong>${product.origin}</strong></li>
                                        <li><span>Loại rượu:</span> <strong>${product.typeId}</strong></li>
                                        <li><span>Nồng độ:</span> <strong>${product.alcohol}%</strong></li>
                                        <li><span>Dung tích:</span> <strong>${product.capacity}</strong></li>
                                        <li><span>Nhà sản xuất:</span> <strong>${product.manufacturerId}</strong></li>
                                    </ul>

                                    <div class="product-detail-price">
                                        <p>
                                            <fmt:setLocale value="vi_VN" />
                                            <fmt:formatNumber value="${product.price}" type="currency"
                                                currencySymbol="VNĐ" maxFractionDigits="0" />
                                        </p>
                                    </div>

                                    <div class="product-actions-container">
                                        <div class="quantity-selector">
                                            <button class="quantity-btn" id="decrease-qty">-</button>
                                            <input type="number" id="product-quantity" value="1" min="1">
                                            <button class="quantity-btn" id="increase-qty">+</button>
                                        </div>
                                        <a href="add-cart?productId=${product.id}&quantity=1" id="add-to-cart-link"
                                            class="btn btn-primary add-to-cart-detail">
                                            Thêm vào giỏ hàng
                                        </a>
                                    </div>

                                    <a href="add-cart?productId=${product.id}&quantity=1&redirect=checkout"
                                        id="buy-now-link" class="btn btn-secondary buy-now-detail">Mua ngay</a>

                                    <div class="product-meta">
                                        <div class="meta-item">
                                            <strong>Mã SP:</strong> <span>${product.id}</span>
                                        </div>
                                        <div class="meta-item">
                                            <strong>Danh mục:</strong> <span>${product.categoryId}</span>
                                        </div>
                                    </div>
                                </div>

                                <div class="product-service-column">
                                    <div class="service-widget">
                                        <h4 class="service-widget-title">Cần tư vấn?</h4>
                                        <p class="service-widget-text">Gọi ngay cho chúng tôi để được hỗ trợ nhanh nhất!
                                        </p>

                                        <a href="tel:012345678" class="service-contact-link">
                                            <i class="fa-solid fa-phone"></i>
                                            <span>037 420 5336</span>
                                        </a>

                                        <a href="#" class="service-contact-link"> <i
                                                class="fa-solid fa-comment-dots"></i>
                                            <span>Tư vấn qua Zalo</span>
                                        </a>
                                    </div>

                                    <div class="service-widget">
                                        <h4 class="service-widget-title">Cam kết dịch vụ</h4>
                                        <ul class="service-list">
                                            <li>
                                                <i class="fa-solid fa-truck-fast"></i>
                                                <span>Giao hàng nhanh 2H tại TP.HCM.</span>
                                            </li>
                                            <li>
                                                <i class="fa-solid fa-shield-halved"></i>
                                                <span>Cam kết 100% sản phẩm chính hãng.</span>
                                            </li>
                                            <li>
                                                <i class="fa-solid fa-box-open"></i>
                                                <span>Đổi trả dễ dàng trong vòng 7 ngày.</span>
                                            </li>
                                            <li>
                                                <i class="fa-solid fa-wine-glass"></i>
                                                <span>Tư vấn & thử rượu miễn phí tại cửa hàng.</span>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="product-tabs-container">
                            <div class="tab-nav">
                                <button class="tab-link active" data-tab="tab-description">Mô tả</button>
                                <button class="tab-link" data-tab="tab-reviews">Đánh giá</button>
                            </div>
                            <div class="tab-content-container">
                                <div class="tab-content active" id="tab-description">
                                    <h3>Chi tiết sản phẩm</h3>
                                    <p>
                                        <c:out value="${product.detail}" escapeXml="false" default="Đang cập nhật..." />
                                    </p>
                                </div>

                                <div class="tab-content" id="tab-reviews">
                                    <div class="review-filter-bar"
                                        style="background: #fffbf8; border: 1px solid #f9ede5; padding: 30px; margin-bottom: 20px; border-radius: 2px; display: flex; align-items: center; gap: 15px;">
                                        <button class="filter-btn active" data-star="all"
                                            onclick="filterReviews('all', this)"
                                            style="padding: 5px 15px; border: 1px solid rgba(0,0,0,.09); background: #fff; cursor: pointer; border-radius: 2px;">Tất
                                            cả</button>
                                        <button class="filter-btn" data-star="5" onclick="filterReviews(5, this)"
                                            style="padding: 5px 15px; border: 1px solid rgba(0,0,0,.09); background: #fff; cursor: pointer; border-radius: 2px;">5
                                            Sao</button>
                                        <button class="filter-btn" data-star="4" onclick="filterReviews(4, this)"
                                            style="padding: 5px 15px; border: 1px solid rgba(0,0,0,.09); background: #fff; cursor: pointer; border-radius: 2px;">4
                                            Sao</button>
                                        <button class="filter-btn" data-star="3" onclick="filterReviews(3, this)"
                                            style="padding: 5px 15px; border: 1px solid rgba(0,0,0,.09); background: #fff; cursor: pointer; border-radius: 2px;">3
                                            Sao</button>
                                        <button class="filter-btn" data-star="2" onclick="filterReviews(2, this)"
                                            style="padding: 5px 15px; border: 1px solid rgba(0,0,0,.09); background: #fff; cursor: pointer; border-radius: 2px;">2
                                            Sao</button>
                                        <button class="filter-btn" data-star="1" onclick="filterReviews(1, this)"
                                            style="padding: 5px 15px; border: 1px solid rgba(0,0,0,.09); background: #fff; cursor: pointer; border-radius: 2px;">1
                                            Sao</button>
                                    </div>

                                    <c:if test="${not empty reviews}">
                                        <div class="reviews-list">
                                            <c:forEach var="r" items="${reviews}">
                                                <div class="review-item" data-star="${r.star}"
                                                    style="display: flex; align-items: flex-start; padding: 20px 0; border-bottom: 1px solid rgba(0,0,0,.09);">
                                                    <div class="reviewer-avatar"
                                                        style="margin-right: 15px; width: 40px; text-align: center;">
                                                        <i class="fa-solid fa-circle-user"
                                                            style="font-size: 40px; color: #ccc;"></i>
                                                    </div>
                                                    <div class="review-body" style="flex: 1;">
                                                        <div class="reviewer-name"
                                                            style="font-size: 12px; color: #333; margin-bottom: 5px;">
                                                            ${r.fullName}</div>

                                                        <div class="review-stars"
                                                            style="color: #ee4d2d; font-size: 10px; margin-bottom: 5px;">
                                                            <c:set var="starVal" value="${r.star}" />
                                                            <c:forEach begin="1" end="5" var="i">
                                                                <c:choose>
                                                                    <c:when test="${i <= starVal}"><i
                                                                            class="fa-solid fa-star"></i></c:when>
                                                                    <c:when test="${i - 0.5 <= starVal}"><i
                                                                            class="fa-solid fa-star-half-stroke"></i>
                                                                    </c:when>
                                                                    <c:otherwise><i class="fa-regular fa-star"
                                                                            style="color: #ddd;"></i></c:otherwise>
                                                                </c:choose>
                                                            </c:forEach>
                                                        </div>

                                                        <div class="review-meta"
                                                            style="color: rgba(0,0,0,.54); font-size: 12px; margin-bottom: 15px;">
                                                            <fmt:formatDate value="${r.createAt}"
                                                                pattern="yyyy-MM-dd HH:mm" />
                                                        </div>

                                                        <div class="review-content"
                                                            style="font-size: 14px; color: rgba(0,0,0,.87); line-height: 1.4;">
                                                            <div>${r.content}</div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </c:if>

                                    <script>
                                        function filterReviews(star, btn) {
                                            // Update active button
                                            document.querySelectorAll('.filter-btn').forEach(b => {
                                                b.style.borderColor = 'rgba(0,0,0,.09)';
                                                b.style.color = '#333';
                                                b.classList.remove('active');
                                            });
                                            btn.style.borderColor = '#ee4d2d';
                                            btn.style.color = '#ee4d2d';
                                            btn.classList.add('active');

                                            // Filter items
                                            const items = document.querySelectorAll('.review-item');
                                            items.forEach(item => {
                                                const itemStar = parseFloat(item.getAttribute('data-star'));
                                                if (star === 'all') {
                                                    item.style.display = 'flex';
                                                } else {
                                                    // Simple logic: show if star matches integer part (e.g. 4.5 matches 4 star filter? Or 5? Usually floor or round. Let's use floor for "4 star and up" or exact match? 
                                                    // User usually expects "5 Star" to mean 5.0. "4 Star" to mean 4.0-4.9.
                                                    // Let's use Math.floor(itemStar) == star
                                                    if (Math.floor(itemStar) == star) {
                                                        item.style.display = 'flex';
                                                    } else {
                                                        item.style.display = 'none';
                                                    }
                                                }
                                            });
                                        }
                                    </script>

                                    <c:if test="${empty reviews}">
                                        <p style="text-align: center; color: #666; padding: 20px;">
                                            Hiện chưa có đánh giá nào cho sản phẩm này. Hãy là người đầu tiên đánh giá!
                                        </p>
                                    </c:if>
                                </div>
                            </div>
                        </div>

                        <section class="related-products-section">
                            <h2 class="section-title">Các Sản Phẩm Khác</h2>
                            <div
                                style="display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 30px; padding-top: 5px;">
                                <c:forEach var="r" items="${relatedProducts}">
                                    <div class="product-card">
                                        <div class="product-image">
                                            <a href="detail?id=${r.id}">
                                                <img src="${r.imageUrl}" alt="${r.productName}">
                                            </a>
                                        </div>
                                        <div class="product-info">
                                            <h3 class="product-name"><a href="detail?id=${r.id}">${r.productName}</a>
                                            </h3>
                                            <p class="product-price">
                                                <fmt:formatNumber value="${r.price}" type="currency" currencySymbol="₫"
                                                    maxFractionDigits="0" />
                                            </p>
                                            <a href="productId=${r.id}&quantity=1" class="add-to-cart-btn">Thêm vào
                                                giỏ</a>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </section>

                        <script>
                            const tabLinks = document.querySelectorAll('.tab-link');
                            const tabContents = document.querySelectorAll('.tab-content');
                            tabLinks.forEach(link => {
                                link.addEventListener('click', () => {
                                    const tabId = link.getAttribute('data-tab');
                                    tabLinks.forEach(item => item.classList.remove('active'));
                                    tabContents.forEach(item => item.classList.remove('active'));
                                    link.classList.add('active');
                                    document.getElementById(tabId).classList.add('active');
                                });
                            });

                            const qtyInput = document.getElementById('product-quantity');
                            const addBtn = document.getElementById('add-to-cart-link');
                            const buyNowBtn = document.getElementById('buy-now-link');
                            const baseHref = addBtn.getAttribute('href'); // Lấy link gốc
                            const baseBuyNowHref = buyNowBtn.getAttribute('href');

                            function updateLink() {
                                let qty = qtyInput.value;
                                addBtn.setAttribute('href', baseHref.replace('quantity=1', 'quantity=' + qty));
                                buyNowBtn.setAttribute('href', baseBuyNowHref.replace('quantity=1', 'quantity=' + qty));
                            }

                            document.getElementById('increase-qty').onclick = () => {
                                qtyInput.value = parseInt(qtyInput.value) + 1;
                                updateLink();
                            };
                            document.getElementById('decrease-qty').onclick = () => {
                                if (qtyInput.value > 1) {
                                    qtyInput.value = parseInt(qtyInput.value) - 1;
                                    updateLink();
                                }
                            };
                            qtyInput.onchange = updateLink;

                            document.addEventListener("DOMContentLoaded", function () {
                                const isLoggedIn = "${not empty sessionScope.user}" === "true";

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
                                event.preventDefault();

                                const isLoggedIn = "${not empty sessionScope.user}" === "true";
                                const formData = new FormData(form);
                                const productId = formData.get('productId');
                                const button = form.querySelector('button');
                                const icon = button.querySelector('i');
                                const wasActive = button.classList.contains('active');

                                button.classList.toggle('active');
                                if (button.classList.contains('active')) {
                                    icon.classList.remove('fa-regular');
                                    icon.classList.add('fa-solid');
                                } else {
                                    icon.classList.remove('fa-solid');
                                    icon.classList.add('fa-regular');
                                }

                                if (!isLoggedIn) {
                                    let guestFavorites = JSON.parse(localStorage.getItem('guestFavorites')) || [];

                                    if (wasActive) {
                                        guestFavorites = guestFavorites.filter(id => id !== productId);
                                    } else {
                                        if (!guestFavorites.includes(productId)) {
                                            guestFavorites.push(productId);
                                        }
                                    }

                                    localStorage.setItem('guestFavorites', JSON.stringify(guestFavorites));
                                    console.log('Guest favorites updated:', guestFavorites);
                                    return;
                                }

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

                            document.addEventListener("DOMContentLoaded", function () {
                                imageZoom("main-product-image", "myresult");
                            });

                            function imageZoom(imgID, resultID) {
                                var img, lens, result, cx, cy;
                                img = document.getElementById(imgID);
                                result = document.getElementById(resultID);
                                lens = document.getElementById("lens");

                                function initZoom() {
                                    var lensWasHidden = lens.style.display === "none" || getComputedStyle(lens).display === "none";
                                    var resultWasHidden = result.style.display === "none" || getComputedStyle(result).display === "none";

                                    if (lensWasHidden) lens.style.display = "block";
                                    if (resultWasHidden) result.style.display = "block";

                                    cx = result.offsetWidth / lens.offsetWidth;
                                    cy = result.offsetHeight / lens.offsetHeight;

                                    result.style.backgroundImage = "url('" + img.src + "')";
                                    result.style.backgroundSize = (img.width * cx) + "px " + (img.height * cy) + "px";

                                    if (lensWasHidden) lens.style.display = "none";
                                    if (resultWasHidden) result.style.display = "none";
                                }

                                if (img.complete) {
                                    initZoom();
                                } else {
                                    img.onload = initZoom;
                                }

                                window.addEventListener('resize', initZoom);

                                lens.addEventListener("mousemove", moveLens);
                                img.addEventListener("mousemove", moveLens);

                                lens.addEventListener("touchmove", moveLens);
                                img.addEventListener("touchmove", moveLens);

                                img.addEventListener("mouseenter", function () {
                                    result.style.display = "block";
                                    lens.style.display = "block";
                                });

                                img.addEventListener("mouseleave", function () {
                                    result.style.display = "none";
                                    lens.style.display = "none";
                                });

                                lens.addEventListener("mouseleave", function () {
                                    result.style.display = "none";
                                    lens.style.display = "none";
                                });


                                function moveLens(e) {
                                    var pos, x, y;
                                    e.preventDefault();
                                    pos = getCursorPos(e);
                                    x = pos.x - (lens.offsetWidth / 2);
                                    y = pos.y - (lens.offsetHeight / 2);
                                    if (x > img.width - lens.offsetWidth) {
                                        x = img.width - lens.offsetWidth;
                                    }
                                    if (x < 0) {
                                        x = 0;
                                    }
                                    if (y > img.height - lens.offsetHeight) {
                                        y = img.height - lens.offsetHeight;
                                    }
                                    if (y < 0) {
                                        y = 0;
                                    }
                                    lens.style.left = x + "px";
                                    lens.style.top = y + "px";
                                    result.style.backgroundPosition = "-" + (x * cx) + "px -" + (y * cy) + "px";
                                }

                                function getCursorPos(e) {
                                    var a, x = 0, y = 0;
                                    e = e || window.event;
                                    a = img.getBoundingClientRect();
                                    x = e.pageX - a.left;
                                    y = e.pageY - a.top;
                                    x = x - window.pageXOffset;
                                    y = y - window.pageYOffset;
                                    return { x: x, y: y };
                                }
                            }
                        </script>
                    </main>
                    <%@ include file="components/footer.jsp" %>
            </body>

            </html>