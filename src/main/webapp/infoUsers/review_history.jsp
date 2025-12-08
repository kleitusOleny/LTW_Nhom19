<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<link rel="stylesheet" href="../css/review_history_style.css">

<div id="history-card">
    <h2 data-lang-key="reviewHistory">Lịch sử đánh giá</h2>
    <div id="reviews-container" class="review-history-list">
        <div class="review-card">
            <div class="review-header">
                <div class="product-image">
                    <img src="../img/SKU__VD_0926-22.png" alt="Rượu vang cao cấp">
                </div>
                <div class="product-details">
                    <h3>Vang đỏ cao cấp</h3>
                    <p class="review-date">Đã đánh giá vào ngày 20/10/2025</p>
                </div>
            </div>
            <div class="review-body">
                <div class="star-rating">
                    <i class="fa-solid fa-star"></i>
                    <i class="fa-solid fa-star"></i>
                    <i class="fa-solid fa-star"></i>
                    <i class="fa-solid fa-star"></i>
                    <i class="fa-solid fa-star-half-stroke"></i>
                </div>
                <p class="review-comment">"Chất lượng tuyệt vời, hương vị đậm đà. Sẽ mua lại lần nữa."</p>
            </div>
        </div>
        <div class="review-card">
            <div class="review-header">
                <div class="product-image">
                    <img src="../img/SKU__VD_0926-22.png" alt="Rượu vang cao cấp">
                </div>
                <div class="product-details">
                    <h3>Rượu mạnh thượng hạng</h3>
                    <p class="review-date">Đã đánh giá vào ngày 15/09/2025</p>
                </div>
            </div>
            <div class="review-body">
                <div class="star-rating">
                    <i class="fa-solid fa-star"></i>
                    <i class="fa-solid fa-star"></i>
                    <i class="fa-solid fa-star"></i>
                    <i class="fa-solid fa-star"></i>
                    <i class="fa-solid fa-star"></i>
                </div>
                <p class="review-comment">"Sản phẩm xứng đáng với giá tiền. Rất hài lòng."</p>
            </div>
        </div>
        <div class="review-card">
            <div class="review-header">
                <div class="product-image">
                    <img src="../img/SKU__VD_0926-22.png" alt="Rượu vang cao cấp">
                </div>
                <div class="product-details">
                    <h3>Vang hồng ngọt</h3>
                    <p class="review-date">Đã đánh giá vào ngày 01/10/2025</p>
                </div>
            </div>
            <div class="review-body">
                <div class="star-rating">
                    <i class="fa-solid fa-star"></i>
                    <i class="fa-solid fa-star"></i>
                    <i class="fa-solid fa-star"></i>
                    <i class="fa-solid fa-star"></i>
                    <i class="fa-solid fa-star"></i>
                </div>
                <p class="review-comment">"Ngon tuyệt, sẽ giới thiệu cho bạn bè."</p>
            </div>
        </div>
    </div>
</div>
<script>
    const container = document.getElementById('reviews-container');
    container.addEventListener("wheel", function (e) {
        const scrollTop = container.scrollTop;
        const scrollHeight = container.scrollHeight;
        const offsetHeight = container.offsetHeight;
        const delta = e.deltaY;

        if (
            (delta > 0 && scrollTop + offsetHeight >= scrollHeight) ||
            (delta < 0 && scrollTop <= 0)
        ) {
            e.preventDefault();
        }
    }, {passive: false});
</script>
