<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <link rel="stylesheet" href="<%=request.getContextPath()%>/css/review_history_style.css">

            <div id="rh-history-card">
                <h2 data-lang-key="reviewHistory">Lịch sử đánh giá</h2>

                <c:if test="${empty evaluates}">
                    <div class="rh-empty" style="text-align: center; padding: 40px; color: #777;">
                        <i class="fa-regular fa-comment-dots" style="font-size: 48px; margin-bottom: 15px;"></i>
                        <p>Bạn chưa có đánh giá nào.</p>
                    </div>
                </c:if>

                <c:if test="${not empty evaluates}">
                    <div id="reviews-container" class="rh-list">
                        <c:forEach var="item" items="${evaluates}">
                            <c:set var="product" value="${products[item.id]}" />
                            <c:set var="review" value="${reviews[item.evaluatesId]}" />

                            <c:if test="${not empty product and not empty review}">
                                <div class="rh-card">
                                    <div class="rh-product-image">
                                        <a href="${pageContext.request.contextPath}/detail?id=${product.id}">
                                            <img src="${pageContext.request.contextPath}/${product.imageUrl}"
                                                alt="${product.productName}"
                                                onerror="this.src='${pageContext.request.contextPath}/img/default.png'">
                                        </a>
                                    </div>
                                    <div class="rh-content-wrapper">
                                        <div class="rh-product-details">
                                            <h3><a href="${pageContext.request.contextPath}/detail?id=${product.id}"
                                                    style="color: inherit; text-decoration: none;">${product.productName}</a>
                                            </h3>
                                            <p class="rh-date">Đã đánh giá vào ngày
                                                <fmt:formatDate value="${review.createAtAsDate}" pattern="dd/MM/yyyy" />
                                            </p>
                                        </div>
                                        <div class="rh-body">
                                            <div class="rh-user-info"
                                                style="display: flex; align-items: center; margin-bottom: 10px;">
                                                <div class="rh-user-avatar" style="margin-right: 10px; color: #888;">
                                                    <i class="fa-solid fa-circle-user" style="font-size: 24px;"></i>
                                                </div>
                                                <span class="rh-username"
                                                    style="font-weight: bold; margin-right: 15px;">${user.fullName}</span>
                                                <div class="rh-star-rating">
                                                    <c:set var="starVal" value="${review.star}" />
                                                    <c:forEach begin="1" end="5" var="i">
                                                        <c:choose>
                                                            <c:when test="${i <= starVal}">
                                                                <i class="fa-solid fa-star"></i>
                                                            </c:when>
                                                            <c:when test="${i - 0.5 <= starVal}">
                                                                <i class="fa-solid fa-star-half-stroke"></i>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <i class="fa-regular fa-star" style="color: #ddd;"></i>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:forEach>
                                                </div>
                                            </div>
                                            <p class="rh-comment">"${review.content}"</p>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>
                    </div>
                </c:if>
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
                }, { passive: false });
            </script>