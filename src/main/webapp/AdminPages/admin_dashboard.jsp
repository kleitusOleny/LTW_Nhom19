<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <title>Trang Chủ</title>
    <script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/AdminPages/admin_css/admin_dashboard.css">
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
</head>
<body>
<div class="dashboard-container">
    <nav class="dashboard-sidebar">
        <ul class="sidebar-items">
            <div class="group-avatar">
                <img src="${pageContext.request.contextPath}/assets/avatar.jpg" class="user-avatar" id="avatar-modal-btn" alt=""/>
                <ion-icon name="notifications-outline" class="icon-header" id="notification-modal-btn"></ion-icon>
            </div>
            <li><a href="${pageContext.request.contextPath}/dashboard" class="a-with-icon selected">
                <ion-icon name="home"></ion-icon>
                Trang Chủ</a></li>
            <li><a href="manage_product.jsp" class="a-with-icon">
                <ion-icon name="bag-remove-outline"></ion-icon>
                Quản Lí Sản Phẩm</a></li>
            <li><a href="${pageContext.request.contextPath}/accountmanager" class="a-with-icon">
                <ion-icon name="people-outline"></ion-icon>
                Quản Lí Tài Khoản Khách</a></li>
            <li><a href="manage_orders.jsp" class="a-with-icon">
                <ion-icon name="cart-outline"></ion-icon>
                Quản Lí Đơn Hàng</a></li>
            <li><a href="manage_banner.jsp" class="a-with-icon">
                <ion-icon name="albums-outline"></ion-icon>
                Quản Lí Banner</a></li>
            <li><a href="manage_blog.jsp" class="a-with-icon">
                <ion-icon name="reader-outline"></ion-icon>
                Quản Lí Blog và Tin Tức</a></li>
            <li><a href="manage_promotions.jsp" class="a-with-icon">
                <ion-icon name="ticket-outline"></ion-icon>
                Quản Lí Mã Giảm Giá và Khuyến Mãi</a></li>
            <li><a href="charts.jsp" class="a-with-icon">
                <ion-icon name="stats-chart-outline"></ion-icon>
                Thống Kê</a></li>
        </ul>
        <div class="text">━ Được update tới 2025 ━</div>
    </nav>
    <div class="dashboard-content">
        <main class="dashboard-main-content">
            <h1>Chào mừng quay trở lại, Admin!</h1>
            <div class="stat-cards-container">
                <div class="stat-card">
                    <h3>Đơn Hàng Mới</h3>
                    <p class="stat-number">0</p>
                    <span class="stat-description">Trong 24 giờ qua</span>
                </div>
                <div class="stat-card">
                    <h3>Tổng Doanh Thu (Tháng)</h3>
                    <p class="stat-number">0đ</p>
                    <span class="stat-description">Tháng 10, 2025</span>
                </div>
                <div class="stat-card">
                    <h3>Khách Hàng Mới</h3>
                    <p class="stat-number">0</p>
                    <span class="stat-description">Trong tuần này</span>
                </div>
                <div class="stat-card special" id="out_of_stocks-modal-btn">
                    <div class="group-stat-card">
                        <h3>Sắp Hết Hàng</h3>
                        <ion-icon name="ellipsis-horizontal-outline"></ion-icon>
                    </div>
                    <p class="stat-number">2</p>
                    <span class="stat-description">Sản phẩm có SL < 5</span>
                </div>
            </div>
        </main>
        <div class="group-todo">
            <div class="group-todo">
                <div class="todo-list-container not-finish">
                    <h2><ion-icon name="document-attach-outline"></ion-icon> Danh Sách Cần Làm</h2>
                    <div class="contain-todo">
                        <c:forEach items="${pendingList}" var="f">
                            <div class="todo not-finish todo-trigger"
                                 data-target="generic-todo-modal"
                                 data-id="${f.id}"
                                 data-title="${f.title}"
                                 data-content="${f.content}"
                                 data-status="false">${f.title}
                                <ion-icon name="chevron-forward-outline" class="icon-todo"></ion-icon>
                            </div>
                        </c:forEach>
                    </div>
                </div>

                <div class="todo-list-container finished">
                    <h2><ion-icon name="checkbox-outline"></ion-icon> Đã Hoàn Thành</h2>
                    <div class="contain-todo">
                        <c:forEach items="${doneList}" var="f">
                            <div class="todo finish todo-trigger"
                                 data-target="generic-todo-modal"
                                 data-id="${f.id}"
                                 data-title="${f.title}"
                                 data-content="${f.content}"
                                 data-status="true">${f.title}
                                <ion-icon name="chevron-forward-outline" class="icon-todo"></ion-icon>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
        <h4 class="text-welcome">© 2025 Khoa Công Nghệ Thông Tin.</h4>
    </div>
</div>
<div class="modal-overlay-notification" id="notification-account-modal">
    <div class="modal-content-notification">
        <div class="group-notification">
            <h2 class="notification-title">Thông báo</h2>
            <button class="modal-close" id="close-modal-btn8">
                <ion-icon name="close-outline"></ion-icon>
            </button>
        </div>
        <div class="notification-empty-state">
            <ion-icon name="notifications-off-outline"></ion-icon>
            <p>Hiện tại chưa có thông báo mới</p>
        </div>
    </div>
</div>
<div class="modal-overlay-avatar" id="avatar-account-modal">
    <div class="modal-content-avatar">
        <button class="modal-close2" id="close-modal-btn9">
            <ion-icon name="close-outline"></ion-icon>
        </button>
        <a href="${pageContext.request.contextPath}/home" class="btn-menu-item">
            <ion-icon name="person-circle-outline"></ion-icon>
            <span>Trở về trang người dùng</span>
        </a>
        <a href="${pageContext.request.contextPath}/logout" class="btn-menu-item">
            <ion-icon name="log-out-outline"></ion-icon>
            <span>Đăng xuất tài khoản</span>
        </a>
    </div>
</div>
<div class="modal-overlay-todo" id="generic-todo-modal">
    <div class="modal-content-todo">
        <form id="todo-form" action="${pageContext.request.contextPath}/todo_list" method="POST">
            <input type="hidden" name="action" id="modal-action" value="update_status">
            <input type="hidden" name="taskId" id="modal-task-id"> <div class="todo-container">
            <h2 id="modal-task-title">Tiêu đề task</h2>
            <p id="modal-task-content" style="color: #555;"></p>
            <div class="select-todo">
                <label>Tiến độ:</label>
                <select name="status" id="modal-task-status">
                    <option value="false">Chưa Hoàn Thành</option>
                    <option value="true">Hoàn Thành</option>
                </select>
            </div>
        </div>
            <div class="group-button-action section">
                <button type="button" class="cancel element-button close-todo-modal">Huỷ</button>
                <button type="button" class="delete element-button" onclick="submitDelete()">Xoá</button>
                <button type="submit" class="fix-btn element-button">Cập nhật</button>
            </div>
        </form>
    </div>
</div>
<div class="modal-overlay-out_of_stocks" id="out_of_stocks-modal">
    <div class="modal-content-out_of_stocks">
        <div class="text-group-out_of_stocks">
            <h2>
                <ion-icon name="cube-outline"></ion-icon>
                Sản phẩm sắp hết hàng
            </h2>
            <ion-icon name="close-outline" id="close-modal-out_of_stock"></ion-icon>
        </div>
        <div class="out-of-stocks-container">
            <div class="text-name">
                <p>- Rượu vang đỏ Famille Perrin Les Sinards Châteauneuf-Du-Pape Rouge 2022</p>
                <p class="text-b">(VD/1193-22)</p>
            </div>
            <div class="text-name">
                <p>- Rượu Sâm Panh Champagne Ruinart Rosé</p>
                <p class="text-b">(VD/1233)</p>
            </div>
        </div>
    </div>
</div>
<script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
<link href="https://fonts.googleapis.com/css2?family=Philosopher&display=swap" rel="stylesheet">
<script src="${pageContext.request.contextPath}/popup.js"></script>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        setupModal('notification-account-modal', 'notification-modal-btn', 'close-modal-btn8');
        setupModal('avatar-account-modal', 'avatar-modal-btn', 'close-modal-btn9');
        setupModal('out_of_stocks-modal', 'out_of_stocks-modal-btn', 'close-modal-out_of_stock');

        if (typeof setupDynamicModals === "function") {
            setupDynamicModals('todo-trigger', 'close-todo-modal');
        }

        // Script điền dữ liệu
        const taskItems = document.querySelectorAll('.todo-trigger');
        taskItems.forEach(item => {
            item.addEventListener('click', function () {
                // Lấy dữ liệu từ dòng đã click
                const id = this.getAttribute('data-id');
                const title = this.getAttribute('data-title');
                const content = this.getAttribute('data-content');
                const status = this.getAttribute('data-status');

                // Điền vào Form trong Modal
                document.getElementById('modal-task-id').value = id;
                document.getElementById('modal-task-title').innerText = title;
                document.getElementById('modal-task-content').innerText = content;
                document.getElementById('modal-task-status').value = status;
            });
        });
    });
    function submitDelete() {
        if (confirm("Bạn có chắc chắn muốn xoá phản hồi này không?")) {
            // Thay đổi action thành delete_task
            document.getElementById('modal-action').value = 'delete_task';
            document.getElementById('todo-form').submit();
        }
    }
</script>
</body>
</html>