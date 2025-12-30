<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
            <link rel="stylesheet" href="<%=request.getContextPath()%>/css/favorites_style.css">

            <div class="favorites-container">
                <h2 data-lang-key="favorites">Danh sách yêu thích</h2>

                <c:if test="${not empty sessionScope.error}">
                    <div class="alert alert-danger auto-hide">${sessionScope.error}</div>
                    <c:remove var="error" scope="session" />
                </c:if>

                <c:if test="${not empty sessionScope.success}">
                    <div class="alert alert-success auto-hide">${sessionScope.success}</div>
                    <c:remove var="success" scope="session" />
                </c:if>

                <div class="favorites-list">
                    <c:choose>
                        <c:when test="${empty favouritesList}">
                            <div class="empty-state">
                                <i class="fa-solid fa-heart-crack" style="font-size: 64px; color: #ccc;"></i>
                                <p>Bạn chưa có sản phẩm yêu thích nào.</p>
                                <a href="${pageContext.request.contextPath}/" class="btn-browse">Khám phá sản phẩm</a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="fav" items="${favouritesList}">
                                <div class="product-card">
                                    <div class="product-image">
                                        <a href="${pageContext.request.contextPath}/product/${fav.slug}">
                                            <c:choose>
                                                <c:when test="${not empty fav.image_url}">
                                                    <img src="${pageContext.request.contextPath}/${fav.image_url}"
                                                        alt="${fav.product_name}">
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="${pageContext.request.contextPath}/img/default-product.png"
                                                        alt="${fav.product_name}">
                                                </c:otherwise>
                                            </c:choose>
                                        </a>
                                    </div>
                                    <div class="product-info">
                                        <h3 class="product-name">
                                            <a href="${pageContext.request.contextPath}/product/${fav.slug}">
                                                ${fav.product_name}
                                            </a>
                                        </h3>
                                        <div class="product-extra-details">
                                            <ul>
                                                <c:if test="${not empty fav.origin}">
                                                    <li><strong>Xuất xứ:</strong> ${fav.origin}</li>
                                                </c:if>
                                                <c:if test="${not empty fav.type_id}">
                                                    <li><strong>Loại:</strong> ${fav.type_id}</li>
                                                </c:if>
                                                <c:if test="${not empty fav.capacity}">
                                                    <li><strong>Dung tích:</strong> ${fav.capacity}</li>
                                                </c:if>
                                                <c:if test="${not empty fav.alcohol}">
                                                    <li><strong>Nồng độ:</strong> ${fav.alcohol}%</li>
                                                </c:if>
                                            </ul>
                                        </div>
                                        <p class="product-price">
                                            <fmt:formatNumber value="${fav.price}" type="number" groupingUsed="true" />₫
                                        </p>
                                        <form action="${pageContext.request.contextPath}/favorites" method="post"
                                            onsubmit="return confirm('Bạn có chắc muốn xóa sản phẩm này khỏi danh sách yêu thích?');">
                                            <input type="hidden" name="action" value="remove">
                                            <input type="hidden" name="favouriteId" value="${fav.favourite_id}">
                                            <input type="hidden" name="productId" value="${fav.product_id}">
                                            <button type="submit" class="remove-favorite-btn">
                                                <i class="fa-solid fa-heart-crack"></i> Bỏ yêu thích
                                            </button>
                                        </form>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <script>
                const container = document.querySelector(".favorites-container .favorites-list");
                if (container) {
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
                    }, { passive: false });
                }

                // Auto-hide alerts
                const alerts = document.querySelectorAll(".auto-hide");
                alerts.forEach(alert => {
                    setTimeout(() => {
                        alert.style.transition = "opacity 0.5s ease";
                        alert.style.opacity = "0";
                        setTimeout(() => alert.remove(), 500);
                    }, 3000);
                });
            </script>