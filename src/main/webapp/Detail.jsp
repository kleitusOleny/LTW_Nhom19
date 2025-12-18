
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>${product.productName} | Store</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"/>
    <link rel="stylesheet" href="css/detail_style.css">
</head>
<body>
<%@ include file="components/header.jsp" %>
<main>
    <div class="product-detail-container">
        <div class="detail-grid-container">
            <div class="product-gallery-column">
                <div class="main-image-container">
                    <img src="https://via.placeholder.com/500x700?text=Wine" alt="${product.productName}" id="main-product-image">
                </div>
            </div>

            <div class="product-info-column">
                <h1 class="product-detail-title">${product.productName}</h1>

                <ul class="product-specs-list">
                    <li><span>Xuất xứ:</span> <strong>${product.origin}</strong></li>
                    <li><span>Loại rượu:</span> <strong>${product.typeId}</strong></li>
                    <li><span>Nồng độ:</span> <strong>${product.alcohol}%</strong></li>
                    <li><span>Dung tích:</span> <strong>${product.capacity}</strong></li>
                    <li><span>Nhà sản xuất:</span> <strong>${product.manufacturerId}</strong></li>
                </ul>

                <div class="product-detail-price">
                    <p>
                        <fmt:setLocale value="vi_VN"/>
                        <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="VNĐ" maxFractionDigits="0"/>
                    </p>
                </div>

                <div class="product-actions-container">
                    <div class="quantity-selector">
                        <button class="quantity-btn" id="decrease-qty">-</button>
                        <input type="number" id="product-quantity" value="1" min="1">
                        <button class="quantity-btn" id="increase-qty">+</button>
                    </div>
                    <a href="AddToCartServlet?id=${product.id}&quantity=1" id="add-to-cart-link" class="btn btn-primary add-to-cart-detail">
                        Thêm vào giỏ hàng
                    </a>
                </div>

                <button class="btn btn-secondary buy-now-detail">Mua ngay</button>

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
                        <p class="service-widget-text">Gọi ngay cho chúng tôi để được hỗ trợ nhanh nhất!</p>

                        <a href="tel:012345678" class="service-contact-link">
                            <i class="fa-solid fa-phone"></i>
                            <span>037 420 5336</span>
                        </a>

                        <a href="#" class="service-contact-link"> <i class="fa-solid fa-comment-dots"></i>
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
                <p><c:out value="${product.detail}" escapeXml="false" default="Đang cập nhật..."/></p>
            </div>

            <div class="tab-content" id="tab-reviews">
                <p>Chưa có đánh giá nào về sản phẩm</p>
            </div>
        </div>
    </div>

    <section class="related-products-section">
        <h2 class="section-title">Các Sản Phẩm Khác</h2>
        <div class="product-grid related-grid">
            <c:forEach var="r" items="${relatedProducts}">
                <div class="product-card">
                    <div class="product-image">
                        <a href="detail?id=${r.id}">
                            <img src="https://via.placeholder.com/300x400?text=Wine" alt="${r.productName}">
                        </a>
                    </div>
                    <div class="product-info">
                        <h3 class="product-name"><a href="detail?id=${r.id}">${r.productName}</a></h3>
                        <p class="product-price">
                            <fmt:formatNumber value="${r.price}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                        </p>
                        <a href="AddToCartServlet?id=${r.id}" class="add-to-cart-btn">Thêm vào giỏ</a>
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
        const baseHref = addBtn.getAttribute('href'); // Lấy link gốc

        function updateLink() {
            let qty = qtyInput.value;
            addBtn.setAttribute('href', baseHref.replace('quantity=1', 'quantity=' + qty));
        }

        document.getElementById('increase-qty').onclick = () => {
            qtyInput.value = parseInt(qtyInput.value) + 1;
            updateLink();
        };
        document.getElementById('decrease-qty').onclick = () => {
            if(qtyInput.value > 1) {
                qtyInput.value = parseInt(qtyInput.value) - 1;
                updateLink();
            }
        };
        qtyInput.onchange = updateLink;
    </script>
</main>
<%@ include file="components/footer.jsp" %>
</body>
</html>