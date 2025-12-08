<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<link rel="stylesheet" href="../AdminPages/admin_css/my_order_style.css">

<div class="orders-container">
    <h2>Đơn hàng của tôi</h2>

    <div class="order-filter">
        <select id="statusFilter">
            <option selected>Tất cả trạng thái</option>
            <option>Đang xử lý</option>
            <option>Hoàn thành</option>
            <option>Đã hủy</option>
        </select>
    </div>

    <div class="order-list">
        <div class="order-card" data-status="completed">
            <div class="order-header">
                <span class="order-id">#1001</span>
                <span class="order-status status-completed">Hoàn thành</span>
            </div>
            <div class="order-body">
                <p><strong>Ngày đặt:</strong> 15/01/2025</p>
                <p><strong>Tổng tiền:</strong> 2.350.000₫</p>
            </div>
            <div class="tracking-bar-container">
                <div class="tracking-bar">
                    <div class="tracking-progress" style="width: 100%;"></div>
                    <div class="tracking-step active">
                        <div class="step-dot"></div>
                        <div class="step-label">Đang xử lý</div>
                    </div>
                    <div class="tracking-step active">
                        <div class="step-dot"></div>
                        <div class="step-label">Đang giao</div>
                    </div>
                    <div class="tracking-step active">
                        <div class="step-dot"></div>
                        <div class="step-label">Đã giao</div>
                    </div>
                </div>
            </div>
            <div class="order-actions">
                <button class="btn" onclick="location.href='detail_order.jsp'">Xem chi tiết</button>
                <button class="btn">Mua lại</button>
                <button class="btn" onclick="location.href='evaluate.jsp'">Đánh giá</button>
            </div>
        </div>

        <div class="order-card" data-status="pending">
            <div class="order-header">
                <span class="order-id">#1002</span>
                <span class="order-status status-pending">Đang xử lý</span>
            </div>
            <div class="order-body">
                <p><strong>Ngày đặt:</strong> 18/01/2025</p>
                <p><strong>Tổng tiền:</strong> 950.000₫</p>
            </div>
            <div class="tracking-bar-container">
                <div class="tracking-bar">
                    <div class="tracking-progress" style="width: 50%;"></div>
                    <div class="tracking-step active">
                        <div class="step-dot"></div>
                        <div class="step-label">Đang xử lý</div>
                    </div>
                    <div class="tracking-step active">
                        <div class="step-dot"></div>
                        <div class="step-label">Đang giao</div>
                    </div>
                    <div class="tracking-step">
                        <div class="step-dot"></div>
                        <div class="step-label">Đã giao</div>
                    </div>
                </div>
            </div>
            <div class="order-actions">
                <button class="btn" onclick="location.href='detail_order.jsp'">Xem chi tiết</button>
                <button class="btn">Mua lại</button>
            </div>
        </div>

        <div class="order-card" data-status="cancelled">
            <div class="order-header">
                <span class="order-id">#1003</span>
                <span class="order-status status-cancelled">Đã hủy</span>
            </div>
            <div class="order-body">
                <p><strong>Ngày đặt:</strong> 20/01/2025</p>
                <p><strong>Tổng tiền:</strong> 1.200.000₫</p>
            </div>
            <div class="order-actions">
                <button class="btn" onclick="location.href='detail_order.jsp'">Xem chi tiết</button>
                <button class="btn">Mua lại</button>
            </div>
        </div>
    </div>
</div>
