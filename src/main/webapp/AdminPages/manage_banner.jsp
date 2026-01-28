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
                <link rel="stylesheet" href="https://cdn.datatables.net/2.0.8/css/dataTables.dataTables.css" />
                <link rel="stylesheet" href="<%= request.getContextPath() %>/css/manage_banner_style.css">
            </head>

            <body>
                <div class="dashboard-container">
                    <nav class="dashboard-sidebar">
                        <ul class="sidebar-items">
                            <div class="group-avatar">
                                <%@ include file="/AdminPages/components/avatar.jsp" %>
                                    <%@ include file="/AdminPages/components/notify_icon.jsp" %>
                            </div>
                            <c:set var="activePage" value="banner" scope="request" />
                            <%@ include file="/AdminPages/components/sidebar_items_component.jsp" %>
                        </ul>
                        <div class="text">━ Được update tới 2025 ━</div>
                    </nav>
                    <div class="dashboard-content">
                        <main class="dashboard-main-content">

                            <div class="main-header">
                                <h1>Quản Lí Slideshow Trang Chủ</h1>
                                <div class="header-actions">
                                    <button class="btn btn-primary add-banner-btn" data-target="banner-form-modal">
                                        <ion-icon name="add-outline"></ion-icon>
                                        Thêm Banner
                                    </button>
                                </div>
                            </div>

                            <div class="filter-card"
                                style="display: flex; justify-content: flex-end; margin-bottom: 15px; background: #fff; padding: 15px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.05);">
                                <div class="search-wrapper" style="position: relative; width: 100%; max-width: 300px;">
                                    <ion-icon name="search-outline" class="search-icon"
                                        style="position: absolute; left: 12px; top: 50%; transform: translateY(-50%); color: #666; font-size: 18px;">
                                    </ion-icon>
                                    <input type="text" id="custom-search-input" placeholder="Tìm kiếm banner..."
                                        style="width: 100%; padding: 10px 15px 10px 38px; border: 1px solid #ddd; border-radius: 20px; outline: none; font-size: 14px;">
                                </div>
                            </div>

                            <div class="table-container">
                                <table id="banner-datatable" class="product-table">
                                    <thead>
                                        <tr class="sample">
                                            <th class="col-tick">Chọn</th>
                                            <th class="col-id">ID</th>
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
                                                <td class="cell-tick"><input type="checkbox" class="row-checkbox"
                                                        value="${b.id}" /></td>
                                                <td class="cell-id">${b.id}</td>
                                                <td class="cell-img">
                                                    <img class="banner-preview"
                                                        src="<%= request.getContextPath() %>/${b.urlBanner}"
                                                        alt="Banner Preview"
                                                        onerror="this.src='<%= request.getContextPath() %>/assets/banners/main_banner.jpg'">
                                                </td>
                                                <td class="cell-link">
                                                    <a href="${b.targetUrl}" target="_blank"
                                                        title="${b.targetUrl}">${b.targetUrl}</a>
                                                </td>
                                                <td class="cell-date">
                                                    <fmt:formatDate value="${b.eventDate}" pattern="yyyy-MM-dd" />
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
                                                        <button type="button" class="edit btn edit-banner-btn"
                                                            data-id="${b.id}" data-url="${b.urlBanner}"
                                                            data-target="${b.targetUrl}"
                                                            data-date="<fmt:formatDate value='${b.eventDate}' pattern='yyyy-MM-dd'/>"
                                                            data-life="${b.lifeTime}"
                                                            data-active="${b.active ? 'Active' : 'Inactive'}">
                                                            Sửa
                                                        </button>

                                                        <form action="${pageContext.request.contextPath}/banner-manager"
                                                            method="post" style="display:inline;"
                                                            onsubmit="return confirm('Bạn có chắc chắn muốn xóa banner ID: ${b.id}?');">
                                                            <input type="hidden" name="action" value="delete">
                                                            <input type="hidden" name="id" value="${b.id}">
                                                            <button type="submit" class="delete btn">Xoá</button>
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
                </div>

                <div class="modal-overlay-form" id="banner-form-modal">
                    <div class="modal-content-form">
                        <button class="modal-close-form" id="close-form-btn">
                            <ion-icon name="close-outline"></ion-icon>
                        </button>
                        <h2>Thêm / Cập Nhật Banner</h2>

                        <form id="banner-form" action="${pageContext.request.contextPath}/banner-manager" method="post">
                            <input type="hidden" id="form-action" name="action" value="add">
                            <input type="hidden" id="banner-id" name="id" value="">

                            <div class="form-group">
                                <label for="banner-link">LINK ĐÍCH</label>
                                <input type="text" id="banner-link" name="targetUrl"
                                    placeholder="VD: /store?category=..." required>
                            </div>

                            <div class="form-grid">
                                <div class="form-group">
                                    <label for="banner-date">NGÀY SỰ KIỆN</label>
                                    <input type="date" id="banner-date" name="eventDate" required>
                                </div>

                                <div class="form-group">
                                    <label for="banner-duration">T/G TỒN TẠI (Ngày)</label>
                                    <input type="number" id="banner-duration" name="lifeTime" placeholder="VD: 5"
                                        min="0" required>
                                </div>

                                <div class="form-group">
                                    <label for="banner-status">TRẠNG THÁI</label>
                                    <select id="banner-status" name="status" class="form-control">
                                        <option value="Active">Active</option>
                                        <option value="Inactive">Inactive</option>
                                    </select>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="banner-image">URL ẢNH BANNER</label>
                                <input type="text" id="banner-image-url" name="urlBanner" class="form-control"
                                    placeholder="Nhập link ảnh..." required>
                            </div>

                            <div class="form-actions">
                                <button type="button" class="btn btn-secondary cancel-form-btn">Hủy Bỏ</button>
                                <button type="submit" class="btn btn-primary" id="ac-form-btn">Lưu Banner</button>
                            </div>
                        </form>
                    </div>
                </div>

                <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
                <script src="https://cdn.datatables.net/2.0.8/js/dataTables.js"></script>

                <script>
                    document.addEventListener("DOMContentLoaded", function () {
                        // 1. Setup Modal (Giữ nguyên logic cũ của bạn)
                        setupModal('avatar-account-modal', 'avatar-modal-btn', 'close-modal-btn9');
                        setupModal('notification-account-modal', 'notification-modal-btn', 'close-modal-btn8');
                        setupDynamicModals('add-banner-btn', 'cancel-form-btn');
                        setupDynamicModals('btn-open-delete', 'close-delete-btn');
                        setupDynamicModals('btn-open-delete', 'cancel-delete-btn');

                        // 2. Kiểm tra nếu bảng đã được tạo thì hủy nó đi trước khi tạo mới (Tránh lỗi reinitialise)
                        if ($.fn.DataTable.isDataTable('#banner-datatable')) {
                            $('#banner-datatable').DataTable().destroy();
                        }

                        // 3. Khởi tạo DataTable Mới
                        var table = $('#banner-datatable').DataTable({
                            "columnDefs": [
                                // Tắt sort ở cột: 0(Checkbox), 2(Ảnh), 7(Hành động)
                                { "orderable": false, "targets": [0, 2, 7] }
                            ],
                            "language": {
                                "url": "https://cdn.datatables.net/plug-ins/2.0.8/i18n/vi.json"
                            },
                            // Ẩn thanh tìm kiếm mặc định để dùng thanh custom của bạn
                            "dom": '<"top"l>rt<"bottom"ip><"clear">'
                        });

                        // 4. KẾT NỐI THANH TÌM KIẾM CUSTOM
                        $('#custom-search-input').on('keyup', function () {
                            table.search(this.value).draw();
                        });

                        // 5. LOGIC MODAL THÊM / SỬA
                        const modal = document.getElementById('banner-form-modal');
                        const openBtn = document.querySelector('.add-banner-btn');
                        const closeBtn = document.getElementById('close-form-btn');
                        const cancelBtn = document.querySelector('.cancel-form-btn');

                        function toggleModal(show) {
                            if (show) modal.classList.add('show');
                            else modal.classList.remove('show');
                        }

                        // Đóng modal
                        if (closeBtn) closeBtn.addEventListener('click', () => toggleModal(false));
                        if (cancelBtn) cancelBtn.addEventListener('click', () => toggleModal(false));

                        // Xử lý nút THÊM MỚI
                        if (openBtn) {
                            openBtn.addEventListener('click', function () {
                                $('#banner-form')[0].reset();
                                $('#form-action').val('add');
                                $('#banner-id').val('');

                                $('#banner-form-modal h2').text('Thêm Banner Mới');
                                $('#ac-form-btn').text('Lưu Banner');

                                toggleModal(true);
                            });
                        }

                        // Xử lý nút SỬA (Dùng event delegation)
                        $('#banner-datatable').on('click', '.edit-banner-btn', function () {
                            let id = $(this).data('id');
                            let url = $(this).data('url');
                            let target = $(this).data('target');
                            let date = $(this).data('date');
                            let life = $(this).data('life');
                            let active = $(this).data('active');

                            $('#banner-id').val(id);
                            $('#banner-image-url').val(url);
                            $('#banner-link').val(target);
                            $('#banner-date').val(date);
                            $('#banner-duration').val(life);
                            $('#banner-status').val(active).change();

                            $('#form-action').val('edit');
                            $('#banner-form-modal h2').text('Cập Nhật Banner');
                            $('#ac-form-btn').text('Lưu Thay Đổi');

                            toggleModal(true);
                        });
                    });
                </script>
            </body>

            </html>