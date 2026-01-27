<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Quản Lí Banner</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
    <script src="<%= request.getContextPath() %>/popup.js"></script>
    <link rel="stylesheet" href="https://cdn.datatables.net/2.0.8/css/dataTables.dataTables.css"/>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/manage_banner_style.css">
</head>

<body>
<div class="dashboard-container">
    <nav class="dashboard-sidebar">
        <ul class="sidebar-items">
            <div class="group-avatar"><img src="<%= request.getContextPath() %>/assets/avatar.jpg" class="user-avatar" id="avatar-modal-btn"/>
                <ion-icon name="notifications-outline" class="icon-header" id="notification-modal-btn"></ion-icon>
            </div>
            <li><a href="admin_dashboard.jsp" class="a-with-icon">
                <ion-icon name="home-outline"></ion-icon>
                Trang Chủ</a></li>
            <li><a href="manage_product.jsp" class="a-with-icon">
                <ion-icon name="bag-remove-outline"></ion-icon>
                Quản Lí Sản Phẩm</a></li>
            <li><a href="manage_accounts.jsp" class="a-with-icon">
                <ion-icon name="people-outline"></ion-icon>
                Quản Lí Tài Khoản Khách</a></li>
            <li><a href="manage_orders.jsp" class="a-with-icon">
                <ion-icon name="cart-outline"></ion-icon>
                Quản Lí Đơn Hàng</a></li>
            <li><a href="#" class="a-with-icon selected">
                <ion-icon name="albums"></ion-icon>
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

            <div class="main-header">
                <h1>Quản Lí Slideshow Trang Chủ</h1>
                <div class="header-actions">
                    <button class="btn btn-danger" id="delete-selected-btn">
                        <ion-icon name="trash-outline"></ion-icon>
                        Xóa (Đã chọn)
                    </button>
                    <label for="excel-file-input" class="btn btn-secondary">
                        <ion-icon name="cloud-upload-outline"></ion-icon>
                        Nhập từ Excel
                        <input type="file" id="excel-file-input" accept=".xlsx, .xls" class="hidden-file-input">
                    </label>

                    <button class="btn btn-primary add-banner-btn" data-target="banner-form-modal">
                        <ion-icon name="add-outline"></ion-icon>
                        Thêm Banner
                    </button>
                </div>
            </div>

            <div class="table-container">
                <table id="banner-datatable" class="product-table">
                    <thead>
                    <tr class="sample">
                        <th class="col-tick">Chọn</th>
                        <th class="col-id">ID Banner</th>
                        <th class="col-img">Ảnh Banner</th>
                        <th class="col-link">Link Đích</th>
                        <th class="col-date">Ngày Sự Kiện</th>
                        <th class="col-duration">T/g Tồn Tại</th>
                        <th class="col-status">Trạng Thái</th>
                        <th class="col-action">Hành Động</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="b" items="${banners}">
                        <tr class="row">
                            <td class="cell-tick"><input type="checkbox" class="row-checkbox" value="${b.id}"/></td>
                            <td class="cell-id">${b.id}</td>
                            <td class="cell-img">
                                <img class="banner-preview" src="<%= request.getContextPath() %>/${b.urlBanner}" alt="Banner Preview"
                                     onerror="this.src='<%= request.getContextPath() %>/assets/banners/main_banner.jpg'">
                            </td>
                            <td class="cell-link">
                                <a href="${b.targetUrl}" target="_blank" title="${b.targetUrl}">${b.targetUrl}</a>
                            </td>
                            <td class="cell-date">
                                <fmt:formatDate value="${b.eventDate}" pattern="yyyy-MM-dd"/>
                            </td>
                            <td class="cell-duration" style="text-align: center;">${b.lifeTime}</td>
                            <td class="cell-status" style="text-align: center;">
                                <c:choose>
                                    <c:when test="${b.active}">
                                        <span class="status-badge active">Active</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="status-badge inactive">Inactive</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <div class="cell-action">
                                    <button class="edit btn" onclick="editBanner(${b.id})">Sửa</button>

                                    <form action="banner-manager" method="post" style="display:inline;" onsubmit="return confirm('Bạn có chắc chắn muốn xóa?');">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="id" value="${b.id}">
                                        <button type="button"
                                                class="delete btn btn-open-delete"
                                                data-target="delete-confirm-modal"
                                                data-id="${b.id}">
                                            Xoá
                                        </button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>

        </main>
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
</div>

<div class="modal-overlay-form" id="delete-confirm-modal" style="--modal-width: 450px;">
    <div class="modal-content-form">
        <button class="modal-close-form" id="close-delete-btn">
            <ion-icon name="close-outline"></ion-icon>
        </button>
        <h2 class="modal-confirm-title">
            <ion-icon name="warning-outline"></ion-icon>
            Xác nhận xóa
        </h2>
        <p class="modal-confirm-text">Bạn có chắc chắn muốn xóa Banner này không? Hành động này không thể hoàn tác.</p>
        <div class="form-actions">
            <button type="button" class="btn btn-secondary" id="cancel-delete-btn">Hủy Bỏ</button>
            <button type="button" class="btn btn-danger" id="ac-delete-btn">Xác Nhận Xóa</button>
        </div>
    </div>
</div>
<div class="modal-overlay-form" id="banner-form-modal">
    <div class="modal-content-form">
        <button class="modal-close-form" id="close-form-btn">
            <ion-icon name="close-outline"></ion-icon>
        </button>
        <h2>Thêm / Cập Nhật Banner</h2>

        <form action="banner-manager" method="post">
            <input type="hidden" name="action" value="add">

            <div class="form-group">
                <label for="banner-link">LINK ĐÍCH</label>
                <input type="text" id="banner-link" name="targetUrl" placeholder="VD: /store?category=..." required>
            </div>

            <div class="form-grid">
                <div class="form-group">
                    <label for="banner-date">NGÀY SỰ KIỆN</label>
                    <input type="date" id="banner-date" name="eventDate" required>
                </div>

                <div class="form-group">
                    <label for="banner-duration">T/G TỒN TẠI (Ngày)</label>
                    <input type="number" id="banner-duration" name="lifeTime" placeholder="VD: 5" min="0" required>
                </div>

                <div class="form-group">
                    <label for="banner-status">TRẠNG THÁI</label>
                    <select id="banner-status" name="status" style="width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 4px; background: #fff;">
                        <option value="Active">Active</option>
                        <option value="Inactive">Inactive</option>
                    </select>
                </div>
            </div>

            <div class="form-group">
                <label for="banner-image">URL ẢNH BANNER</label>
                <input type="text" id="banner-image-url" name="urlBanner" class="form-control" placeholder="Nhập link ảnh..." required>
            </div>

            <div class="form-actions">
                <button type="button" class="btn btn-secondary cancel-form-btn">Hủy Bỏ</button>
                <button type="submit" class="btn btn-primary" id="ac-form-btn">Lưu Banner</button>
            </div>
        </form>
    </div>
</div>

<div class="modal-overlay-form modal-overlay-edit_information" id="delete-confirm-modal" style="--modal-width: 450px;">
    <div class="modal-content-form">
        <button type="button" class="modal-close-form btn-close-delete" id="close-delete-btn">
            <ion-icon name="close-outline"></ion-icon>
        </button>

        <h2 class="modal-confirm-title">
            <ion-icon name="warning-outline"></ion-icon>
            Xác nhận xóa
        </h2>

        <p class="modal-confirm-text">
            Bạn có chắc chắn muốn xóa Banner này không?<br>
            Hành động này không thể hoàn tác.
        </p>

        <form action="banner-manager" method="post">
            <input type="hidden" name="action" value="delete">
            <input type="hidden" name="id" id="input-delete-banner-id" value="">

            <div class="form-actions">
                <button type="button" class="btn btn-secondary btn-close-delete" id="cancel-delete-btn">Hủy Bỏ</button>
                <button type="submit" class="btn btn-danger" id="ac-delete-btn">Xác Nhận Xóa</button>
            </div>
        </form>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"
        integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script src="https://cdn.datatables.net/2.0.8/js/dataTables.js"></script>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        setupDynamicModals('add-banner-btn', 'cancel-form-btn');
        setupDynamicModals('btn-open-delete','close-delete-btn');
        setupDynamicModals('btn-open-delete','cancel-delete-btn')
        $(document).ready(function () {
            $('#banner-datatable').DataTable({
                // Tắt sắp xếp cho cột Ảnh và Hành động
                "columnDefs": [
                    {
                        "orderable": false,
                        "targets": [2, 7]
                    }
                ],
                "language": {
                    "search": "Tìm kiếm:",
                    "lengthMenu": "Hiển thị _MENU_ mục",
                    "info": "Hiển thị từ _START_ đến _END_ của _TOTAL_ mục",
                    "infoEmpty": "Không tìm thấy mục nào",
                    "infoFiltered": "(được lọc từ _MAX_ mục)",
                    "zeroRecords": "Không tìm thấy dữ liệu",
                    "paginate": {
                        "first": "<ion-icon name='play-skip-back-outline'></ion-icon>",
                        "last": "<ion-icon name='play-skip-forward-outline'></ion-icon>",
                        "next": "<ion-icon name='chevron-forward-outline'></ion-icon>",
                        "previous": "<ion-icon name='chevron-back-outline'></ion-icon>"
                    }
                }
            });
        });
    });
</script>
</body>
</html>