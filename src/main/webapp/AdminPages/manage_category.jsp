<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Quản Lí Danh Mục</title>
    <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/manage_product_style.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/2.0.8/css/dataTables.dataTables.css"/>
</head>
<body>
<div class="dashboard-container">
    <nav class="dashboard-sidebar">
        <ul class="sidebar-items">
            <div class="group-avatar">
                <img src="<%= request.getContextPath() %>/assets/avatar.jpg" class="user-avatar" id="avatar-modal-btn"/>
                <ion-icon name="notifications-outline" class="icon-header" id="notification-modal-btn"></ion-icon>
            </div>

            <c:set var="activePage" value="category" scope="request" />

            <jsp:include page="/AdminPages/components/sidebar_items_component.jsp" />
        </ul>
        <div class="text">━ Được update tới 2025 ━</div>
    </nav>
    <div class="dashboard-content">
        <main class="dashboard-main-content">
            <div class="main-header">
                <h1>Quản Lí Danh Mục</h1>
                <div class="header-actions">
                    <button class="btn btn-primary add-product-btn" data-target="modal-san-pham">
                        <ion-icon name="add-outline"></ion-icon>
                        Thêm Danh Mục
                    </button>
                </div>
            </div>

            <div class="filter-card" style="justify-content: flex-end;">
                <div class="filter-right" style="margin: 0; width: 100%;">
                    <div class="search-wrapper">
                        <ion-icon name="search-outline" class="search-icon"></ion-icon>
                        <input type="text" id="custom-search-input" placeholder="Tìm tên danh mục, slug..." class="search-input">
                    </div>
                </div>
            </div>

            <div class="table-container">
                <table id="category-datatable" class="product-table">
                    <thead>
                    <tr class="sample">
                        <th class="col-tick"><input type="checkbox" id="select-all-checkbox"></th>
                        <th style="width: 10%;">ID</th>
                        <th style="width: 30%;">Tên Danh Mục</th>
<%--                        <th style="width: 30%;">Slug (Đường dẫn)</th>--%>
                        <th style="width: 15%;">Ngày tạo</th>
                        <th class="col-action">Hành động</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${categories}" var="c">
                        <tr>
                            <td class="cell-tick"><input type="checkbox" class="row-checkbox"></td>
                            <td style="text-align: center;">${c.id}</td>
                            <td style="font-weight: bold; color: #333;">${c.categoryName}</td>
<%--                            <td><span class="stock-status low-stock">${c.slug}</span></td>--%>
                            <td><fmt:formatDate value="${c.createAt}" pattern="yyyy-MM-dd"/></td>
                            <td>
                                <div class="cell-action">
                                    <button type="button"
                                            class="edit btn edit-button"
                                            data-id="${c.id}"
                                            data-name="${c.categoryName}"
                                            data-slug="${c.slug}">
                                        Sửa
                                    </button>
                                    <form action="category-manager" method="POST" style="margin:0;">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="id" value="${c.id}">
                                        <button type="submit" class="delete btn delete-button" onclick="return confirm('Bạn chắc chắn muốn xóa danh mục ID: ${c.id}?');">Xoá</button>
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
</div>

<div class="modal-overlay-form product-form-modal" id="modal-san-pham" style="--modal-width: 500px;">
    <div class="modal-content-form">
        <button class="modal-close-form" id="close-form-btn">
            <ion-icon name="close-outline"></ion-icon>
        </button>
        <h2>Thêm Danh Mục Mới</h2>

        <form id="add-category-form" action="category-manager" method="POST">
            <input type="hidden" id="form-action" name="action" value="add">

            <input type="hidden" id="cat-id" name="id" value="">

            <div class="form-group">
                <label for="cat-name">Tên danh mục</label>
                <input type="text" id="cat-name" name="name" placeholder="Ví dụ: Rượu Vang Đỏ" required>
            </div>

            <div class="form-group">
                <label for="cat-slug">Slug (URL thân thiện)</label>
                <input type="text" id="cat-slug" name="slug" placeholder="Ví dụ: ruou-vang-do" required>
            </div>

            <div class="form-actions">
                <button type="button" class="btn btn-secondary cancel-form-btn">Hủy Bỏ</button>
                <button type="submit" class="btn btn-primary">Lưu Danh Mục</button>
            </div>
        </form>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.datatables.net/2.0.8/js/dataTables.js"></script>
<script src="<%= request.getContextPath() %>/popup.js"></script> <script>
    document.addEventListener("DOMContentLoaded", function () {
        // Logic mở Modal (Sử dụng code cũ hoặc viết lại đơn giản)
        const modal = document.getElementById('modal-san-pham');
        const openBtn = document.querySelector('.add-product-btn');
        const closeBtn = document.getElementById('close-form-btn');
        const cancelBtn = document.querySelector('.cancel-form-btn');

        $('#category-datatable').on('click', '.edit-button', function () {
            // Lấy dữ liệu từ nút bấm (đã gắn ở Bước 3.1)
            let id = $(this).data('id');
            let name = $(this).data('name');
            let slug = $(this).data('slug');

            // Đổ dữ liệu vào Form Modal
            $('#cat-id').val(id);
            $('#cat-name').val(name);
            $('#cat-slug').val(slug);

            // Chuyển action của form thành 'edit'
            $('#form-action').val('edit');

            // Đổi tiêu đề Modal và nút Submit cho người dùng dễ hiểu
            $('.modal-content-form h2').text('Cập Nhật Danh Mục');
            $('.modal-content-form .btn-primary').text('Lưu Thay Đổi');

            // Mở Modal
            $('#modal-san-pham').addClass('show');
        });

        // 2. XỬ LÝ KHI BẤM NÚT THÊM MỚI (Reset lại form về trạng thái Thêm)
        $('.add-product-btn').on('click', function () {
            // Xóa trắng form
            $('#add-category-form')[0].reset();

            // Chuyển action về 'add'
            $('#form-action').val('add');
            $('#cat-id').val(''); // Xóa ID ẩn

            // Đổi lại tiêu đề
            $('.modal-content-form h2').text('Thêm Danh Mục Mới');
            $('.modal-content-form .btn-primary').text('Lưu Danh Mục');

            $('#modal-san-pham').addClass('show');
        });

        function toggleModal(show) {
            if (show) modal.classList.add('show');
            else modal.classList.remove('show');
        }

        if(openBtn) openBtn.addEventListener('click', () => toggleModal(true));
        if(closeBtn) closeBtn.addEventListener('click', () => toggleModal(false));
        if(cancelBtn) cancelBtn.addEventListener('click', () => toggleModal(false));

        // Khởi tạo DataTable
        var table = $('#category-datatable').DataTable({
            "paging": true,
            "pageLength": 10,
            "language": {
                "url": 'https://cdn.datatables.net/plug-ins/2.0.8/i18n/vi.json'
            },
            "columnDefs": [
                {"orderable": false, "targets": [0, 4]}, // Tắt sort cột check và action
                {"searchable": false, "targets": [0, 4]}
            ],
            "dom": '<"top"l>rt<"bottom"ip><"clear">'
        });

        // Search Custom
        $('#custom-search-input').on('keyup', function () {
            table.search(this.value).draw();
        });
    });
</script>
</body>
</html>