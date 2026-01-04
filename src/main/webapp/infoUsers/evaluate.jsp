<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="vi">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/evalute_style.css">
    <%@ include file="../components/header.jsp" %>

        <body>
            <div class="review-container">
                <h1>Đánh giá đơn hàng #${order.id}</h1>

                <c:if test="${not empty param.success}">
                    <div class="alert alert-success"
                        style="background-color: #d4edda; color: #155724; padding: 10px; margin-bottom: 20px; border-radius: 5px;">
                        Cảm ơn bạn đã đánh giá sản phẩm!
                    </div>
                </c:if>

                <c:forEach items="${items}" var="item">
                    <c:set var="product" value="${productMap[item.productId]}" />
                    <div class="product-review">
                        <img src="${product.imageUrl}" alt="${product.productName}"
                            onerror="this.src='../img/default.png'">
                        <div class="review-content">
                            <h3>${product.productName}</h3>
                            <form action="${pageContext.request.contextPath}/evaluate" method="post">
                                <input type="hidden" name="orderId" value="${order.id}">
                                <input type="hidden" name="productId" value="${item.productId}">
                                <input type="hidden" name="rating" id="rating-${item.productId}" value="5">

                                <div class="stars" data-product-id="${item.productId}">
                                    <i class="fa-regular fa-star" data-value="1"></i>
                                    <i class="fa-regular fa-star" data-value="2"></i>
                                    <i class="fa-regular fa-star" data-value="3"></i>
                                    <i class="fa-regular fa-star" data-value="4"></i>
                                    <i class="fa-regular fa-star" data-value="5"></i>
                                </div>

                                <textarea name="content" placeholder="Viết cảm nhận của bạn..." required></textarea>
                                <button type="submit">Gửi đánh giá</button>
                            </form>
                        </div>
                    </div>
                </c:forEach>

                <div style="text-align: center; margin-top: 20px;">
                    <a href="orders" class="btn"
                        style="background-color: #666; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px;">Quay
                        lại đơn hàng</a>
                </div>
            </div>

            <%@ include file="../components/footer.jsp" %>

                <script>
                    function previewImage(input, previewId) {
                        const preview = document.getElementById(previewId);
                        if (input.files && input.files[0]) {
                            const reader = new FileReader();
                            reader.onload = function (e) {
                                preview.src = e.target.result;
                                preview.style.display = 'block';
                            }
                            reader.readAsDataURL(input.files[0]);
                        } else {
                            preview.style.display = 'none';
                        }
                    }

                    document.addEventListener('DOMContentLoaded', function () {
                        const starContainers = document.querySelectorAll('.stars');

                        starContainers.forEach(container => {
                            const stars = container.querySelectorAll('i');
                            const productId = container.getAttribute('data-product-id');
                            const ratingInput = document.getElementById('rating-' + productId);

                            stars.forEach((star, index) => {
                                star.addEventListener('mousemove', function (e) {
                                    const rect = this.getBoundingClientRect();
                                    const isLeftHalf = e.clientX - rect.left < rect.width / 2;
                                    const value = index + (isLeftHalf ? 0.5 : 1);
                                    highlightStars(container, value);
                                });

                                star.addEventListener('click', function (e) {
                                    const rect = this.getBoundingClientRect();
                                    const isLeftHalf = e.clientX - rect.left < rect.width / 2;
                                    const value = index + (isLeftHalf ? 0.5 : 1);
                                    ratingInput.value = value;
                                    updateStars(container, value);
                                });
                            });

                            container.addEventListener('mouseleave', function () {
                                const currentValue = parseFloat(ratingInput.value);
                                updateStars(container, currentValue);
                            });

                            // Initialize with 5 stars
                            updateStars(container, 5);
                        });

                        function updateStars(container, value) {
                            const stars = container.querySelectorAll('i');
                            stars.forEach((star, index) => {
                                star.className = 'fa-regular fa-star'; // Reset
                                star.style.color = '#ccc';

                                if (value >= index + 1) {
                                    star.className = 'fa-solid fa-star';
                                    star.style.color = '#ffc107';
                                } else if (value >= index + 0.5) {
                                    star.className = 'fa-solid fa-star-half-stroke';
                                    star.style.color = '#ffc107';
                                }
                            });
                        }

                        function highlightStars(container, value) {
                            updateStars(container, value);
                        }
                    });
                </script>

        </body>

    </html>