<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Quản Lí Nhà Sản Xuất</title>
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

            <c:set var="activePage" value="manufacturer" scope="request" />

            <jsp:include page="/AdminPages/components/sidebar_items_component.jsp" />
        </ul>
        <div class="text">━ Được update tới 2025 ━</div>
    </nav>
    <div class="dashboard-content">
        <main class="dashboard-main-content">
            <div class="main-header">
                <h1>Quản Lí Nhà Sản Xuất</h1>
                <div class="header-actions">
                    <button class="btn btn-primary add-product-btn" data-target="modal-san-pham">
                        <ion-icon name="add-outline"></ion-icon>
                        Thêm Nhà SX
                    </button>
                </div>
            </div>

            <div class="filter-card" style="justify-content: flex-end;">
                <div class="filter-right" style="margin: 0; width: 100%;">
                    <div class="search-wrapper">
                        <ion-icon name="search-outline" class="search-icon"></ion-icon>
                        <input type="text" id="custom-search-input" placeholder="Tìm tên nhà sản xuất, quốc gia..." class="search-input">
                    </div>
                </div>
            </div>

            <div class="table-container">
                <table id="manufacturer-datatable" class="product-table">
                    <thead>
                    <tr class="sample">
                        <th class="col-tick"><input type="checkbox" id="select-all-checkbox"></th>
                        <th style="width: 10%;">ID</th>
                        <th style="width: 40%;">Tên Nhà Sản Xuất</th>
<%--                        <th style="width: 35%;">Địa Chỉ / Xuất Xứ</th>--%>
                        <th class="col-action">Hành động</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${manufacturers}" var="m">
                        <tr>
                            <td class="cell-tick"><input type="checkbox" class="row-checkbox"></td>
                            <td style="text-align: center;">${m.id}</td>
                            <td style="font-weight: bold; color: #333;">${m.manufacturerName}</td>
<%--                            <td>--%>
<%--                                <span class="stock-status in-stock" style="color:#000; background-color: #f1f3f5;">--%>
<%--                                        ${m.location}--%>
<%--                                </span>--%>
<%--                            </td>--%>
                            <td>
                                <div class="cell-action">
                                    <button type="button"
                                            class="edit btn edit-button"
                                            data-id="${m.id}"
                                            data-name="${m.manufacturerName}"
                                            data-location="${m.location}">
                                        Sửa
                                    </button>
                                    <form action="manage-manufacturer" method="POST" style="margin:0;">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="id" value="${m.id}">
                                        <button type="submit" class="delete btn delete-button" onclick="return confirm('Xóa nhà sản xuất này?');">Xoá</button>
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
        <h2>Thêm Nhà Sản Xuất</h2>

        <form id="add-manufacturer-form" action="manage-manufacturer" method="POST">
            <input type="hidden" id="form-action" name="action" value="add">

            <input type="hidden" id="manu-id" name="id" value="">

            <div class="form-group">
                <label for="manu-name">Tên Nhà Sản Xuất</label>
                <input type="text" id="manu-name" name="name" placeholder="Ví dụ: Hennessy" required>
            </div>

            <div class="form-group">
                <label for="manu-loc">Quốc gia / Xuất xứ</label>
                <input type="text" id="manu-loc" name="location" placeholder="Ví dụ: Pháp" required>
            </div>

            <div class="form-actions">
                <button type="button" class="btn btn-secondary cancel-form-btn">Hủy Bỏ</button>
                <button type="submit" class="btn btn-primary">Lưu Nhà SX</button>
            </div>
        </form>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.datatables.net/2.0.8/js/dataTables.js"></script>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        // Modal Logic
        const modal = document.getElementById('modal-san-pham');
        const openBtn = document.querySelector('.add-product-btn');
        const closeBtn = document.getElementById('close-form-btn');
        const cancelBtn = document.querySelector('.cancel-form-btn');

        function toggleModal(show) {
            if (show) modal.classList.add('show');
            else modal.classList.remove('show');
        }

        if(openBtn) openBtn.addEventListener('click', () => {
            // 1. XỬ LÝ KHI BẤM THÊM MỚI (Reset form)
            $('#add-manufacturer-form')[0].reset();
            $('#form-action').val('add');
            $('#manu-id').val('');

            $('.modal-content-form h2').text('Thêm Nhà Sản Xuất');
            $('.modal-content-form .btn-primary').text('Lưu Nhà SX');

            toggleModal(true);
        });

        if(closeBtn) closeBtn.addEventListener('click', () => toggleModal(false));
        if(cancelBtn) cancelBtn.addEventListener('click', () => toggleModal(false));

        // 2. XỬ LÝ KHI BẤM NÚT SỬA (Đổ dữ liệu lên form)
        $('#manufacturer-datatable').on('click', '.edit-button', function () {
            let id = $(this).data('id');
            let name = $(this).data('name');
            let location = $(this).data('location'); // Lấy location

            // Đổ dữ liệu vào input
            $('#manu-id').val(id);
            $('#manu-name').val(name);
            $('#manu-loc').val(location);

            // Chuyển chế độ sang Edit
            $('#form-action').val('edit');

            // Đổi text giao diện
            $('.modal-content-form h2').text('Cập Nhật Nhà SX');
            $('.modal-content-form .btn-primary').text('Lưu Thay Đổi');

            toggleModal(true);
        });

        if(openBtn) openBtn.addEventListener('click', () => toggleModal(true));
        if(closeBtn) closeBtn.addEventListener('click', () => toggleModal(false));
        if(cancelBtn) cancelBtn.addEventListener('click', () => toggleModal(false));

        // DataTable Logic
        var table = $('#manufacturer-datatable').DataTable({
            "paging": true,
            "pageLength": 10,
            "language": {
                "url": 'https://cdn.datatables.net/plug-ins/2.0.8/i18n/vi.json'
            },
            "columnDefs": [
                {"orderable": false, "targets": [0, 3]},
                {"searchable": false, "targets": [0, 3]}
            ],
            "dom": '<"top"l>rt<"bottom"ip><"clear">'
        });

        $('#custom-search-input').on('keyup', function () {
            table.search(this.value).draw();
        });
    });
</script>
</body>
</html>