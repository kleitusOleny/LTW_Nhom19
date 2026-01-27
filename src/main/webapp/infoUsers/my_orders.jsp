<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
            <link rel="stylesheet" href="<%=request.getContextPath()%>/css/my_order_style.css">

            <div class="orders-container">
                <h2>Đơn hàng của tôi</h2>

                <c:if test="${empty orders}">
                    <div class="empty-orders" style="text-align: center; padding: 50px;">
                        <i class="fa-solid fa-box-open" style="font-size: 50px; color: #ccc; margin-bottom: 20px;"></i>
                        <p>Bạn chưa có đơn hàng nào.</p>
                        <button class="btn" onclick="location.href='store'" style="margin-top: 20px;">Mua sắm
                            ngay
                        </button>
                    </div>
                </c:if>

                <c:if test="${not empty orders}">
                    <div class="order-filter">
                        <div class="filter-tabs">
                            <button class="filter-btn active" onclick="filterOrders(this, 'all')">Tất cả</button>
                            <button class="filter-btn" onclick="filterOrders(this, 'Chuẩn bị đơn hàng')">Chuẩn bị đơn
                                hàng</button>
                            <button class="filter-btn" onclick="filterOrders(this, 'Đang giao hàng')">Đang giao
                                hàng</button>
                            <button class="filter-btn" onclick="filterOrders(this, 'Giao hàng thành công')">Giao hàng
                                thành công</button>
                            <button class="filter-btn" onclick="filterOrders(this, 'Đã hủy')">Đã hủy</button>
                            <button class="filter-btn" onclick="filterOrders(this, 'Thanh toán thất bại')">Thanh toán
                                thất bại</button>
                        </div>
                    </div>

                    <div class="order-list">
                        <c:forEach items="${orders}" var="order">
                            <c:set var="shipOrder" value="${shipOrderMap[order.id]}" />
                            <c:set var="payment" value="${paymentMap[order.id]}" />
                            <c:choose>
                                <c:when test="${payment != null and payment.status == 'Failed'}">
                                    <c:set var="status" value="Thanh toán thất bại" />
                                </c:when>
                                <c:otherwise>
                                    <c:set var="status"
                                        value="${shipOrder != null ? shipOrder.status : 'Đang xử lý'}" />
                                </c:otherwise>
                            </c:choose>

                            <div class="order-card" data-status="${status}">
                                <div class="order-header">
                                    <span class="order-id">#${order.id}</span>
                                    <c:choose>
                                        <c:when test="${status == 'Thanh toán thất bại'}">
                                            <span class="order-status status-cancelled">${status}</span>
                                        </c:when>
                                        <c:when test="${status == 'Đã hủy'}">
                                            <span class="order-status status-cancelled">${status}</span>
                                        </c:when>
                                        <c:when test="${status == 'Đang xử lý' or status == 'Chuẩn bị đơn hàng'}">
                                            <span class="order-status status-pending">${status}</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="order-status status-completed">${status}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="order-body">
                                    <p><strong>Ngày đặt:</strong> ${order.createAt}</p>
                                    <p><strong>Tổng tiền:</strong>
                                        <fmt:setLocale value="vi_VN" />
                                        <fmt:formatNumber value="${order.totalPrice}" type="currency" currencySymbol="₫"
                                            maxFractionDigits="0" />
                                    </p>
                                </div>
                                <div class="tracking-bar-container">
                                    <div class="tracking-bar">
                                        <c:set var="progressWidth" value="0%" />
                                        <c:choose>
                                            <c:when test="${status == 'Đang giao hàng' || status == 'Đang giao'}">
                                                <c:set var="progressWidth" value="50%" />
                                            </c:when>
                                            <c:when test="${status == 'Giao hàng thành công'}">
                                                <c:set var="progressWidth" value="100%" />
                                            </c:when>
                                        </c:choose>
                                        <div class="tracking-progress" style="width: ${progressWidth};"></div>

                                        <div
                                            class="tracking-step ${status == 'Chuẩn bị đơn hàng' || status == 'Đang giao hàng' || status == 'Đang giao' || status == 'Giao hàng thành công' ? 'active' : ''}">
                                            <div class="step-dot"></div>
                                            <div class="step-label">Đang xử lý</div>
                                        </div>
                                        <div
                                            class="tracking-step ${status == 'Đang giao hàng' || status == 'Đang giao' || status == 'Giao hàng thành công' ? 'active' : ''}">
                                            <div class="step-dot"></div>
                                            <div class="step-label">Đang giao</div>
                                        </div>
                                        <div class="tracking-step ${status == 'Giao hàng thành công' ? 'active' : ''}">
                                            <div class="step-dot"></div>
                                            <div class="step-label">Đã giao</div>
                                        </div>
                                    </div>
                                </div>
                                <div class="order-actions">
                                    <button class="btn"
                                        onclick="location.href='${pageContext.request.contextPath}/order-detail?id=${order.id}'">Xem
                                        chi
                                        tiết
                                    </button>
                                    <button class="btn"
                                        onclick="location.href='${pageContext.request.contextPath}/store'">Mua
                                        lại</button>
                                    <c:if test="${status == 'Giao hàng thành công'}">
                                        <button class="btn"
                                            onclick="location.href='${pageContext.request.contextPath}/evaluate?orderId=${order.id}'">
                                            Đánh
                                            giá
                                        </button>
                                    </c:if>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:if>
            </div>

            <script>
                function filterOrders(btn, filterValue) {
                    document.querySelectorAll('.filter-btn').forEach(b => b.classList.remove('active'));
                    if (btn) btn.classList.add('active');

                    const orderCards = document.querySelectorAll('.order-card');

                    orderCards.forEach(card => {
                        const status = card.getAttribute('data-status').trim();
                        if (filterValue === 'all' || status === filterValue) {
                            card.style.display = 'block';
                        } else {
                            card.style.display = 'none';
                        }
                    });
                }
            </script>