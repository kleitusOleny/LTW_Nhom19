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
                <%@ include file="/AdminPages/components/avatar.jsp" %>
                <%@ include file="/AdminPages/components/notify_icon.jsp" %>
            </div>
            <c:set var="activePage" value="dashboard" scope="request" />
            <%@ include file="/AdminPages/components/sidebar_items_component.jsp" %>
        </ul>
        <div class="text">━ Được update tới 2025 ━</div>
    </nav>
    <div class="dashboard-content">
        <main class="dashboard-main-content">
            <h1>Chào mừng quay trở lại, Admin!</h1>
            <div class="stat-cards-container">
                <div class="stat-card">
                    <h3>Đơn Hàng Mới</h3>
                    <p class="stat-number">${newOrderLastWeek}</p>
                    <span class="stat-description">Trong tuần này</span>
                </div>
                <div class="stat-card">
                    <h3>Tổng Doanh Thu (Tháng)</h3>
                    <p class="stat-number">${sumTotalPriceLastMonth}đ</p>
                    <span class="stat-description">Dựa theo từng tháng</span>
                </div>
                <div class="stat-card">
                    <h3>Tài Khoản Mới</h3>
                    <p class="stat-number">${newUsersLastWeek}</p>
                    <span class="stat-description">Trong tuần này</span>
                </div>
                <div class="stat-card special" id="out_of_stocks-modal-btn">
                    <div class="group-stat-card">
                        <h3>Sắp Hết Hàng</h3>
                        <ion-icon name="ellipsis-horizontal-outline"></ion-icon>
                    </div>
                    <p class="stat-number">${outOfStockList.size()}</p>
                    <span class="stat-description">Sản phẩm có SL <= 5</span>
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
<%@ include file="/AdminPages/components/notify_modal.jsp" %>
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
            <c:choose>
                <c:when test="${not empty outOfStockList}">
                    <c:forEach items="${outOfStockList}" var="p">
                        <div class="text-name">
                            <p>- ${p.productName}</p>
                            <p class="text-b">(SL: ${p.quantity} - ID: ${p.id})</p>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <p>Hiện không có sản phẩm nào sắp hết hàng.</p>
                </c:otherwise>
            </c:choose>
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