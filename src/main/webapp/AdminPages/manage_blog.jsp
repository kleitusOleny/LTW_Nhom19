<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Blog Manage</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
    <script src="../popup.js"></script>
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css">
    <link rel="stylesheet" href="admin_css/manager_blog_style.css">
</head>
<body>
<div class="dashboard-container">
    <nav class="dashboard-sidebar">
        <ul class="sidebar-items">
            <div class="group-avatar">
                <img src="../assets/avatar.jpg" class="user-avatar" id="avatar-modal-btn"/>
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
            <li><a href="manage_banner.jsp" class="a-with-icon">
                <ion-icon name="albums-outline"></ion-icon>
                Quản Lí Banner</a></li>
            <li><a href="manage_blog.html" class="a-with-icon selected">
                <ion-icon name="reader"></ion-icon>
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
            <div class="button-group">
                <h2>Quản lí Blog và Tin tức</h2>
                <div class="func-group">
                    <button class="button del" id="deleteAll-modal-btn">
                        <ion-icon name="trash-outline"></ion-icon>
                        Xoá (Đã chon)
                    </button>
                    <button class="button add" id="open-modal-btn">
                        <ion-icon name="add-outline" class="type-needCss"></ion-icon>
                        Duyệt Bài
                    </button>
                    <button class="button excel" id="excel-modal-btn">
                        <ion-icon name="cloud-download-outline"></ion-icon>
                        Xuất ra Excel
                    </button>
                </div>
            </div>
            <div class="table-container">
                <table id="account-table-main" class="account-table">
                    <thead>
                    <tr class="sample">
                        <th class="col-tick">Chọn</th>
                        <th class="col-id">ID</th>
                        <th class="col-title">Tiêu đề</th>
                        <th class="col-author">Tác giả</th>
                        <th class="col-date">Ngày đăng</th>
                        <th class="col-status">Trạng thái</th>
                        <th class="col-action">Hành động</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr class="blogs">
                        <td class="cell-tick"><input type="checkbox" class="row-checkbox"/></td>
                        <td class="cell-id">1</td>
                        <td class="cell-title">Bài viết mẫu 1</td>
                        <td class="cell-author">Admin</td>
                        <td class="cell-date">06/10/2024</td>
                        <td class="cell-status">Hiện</td>
                        <td class="cell-action">
                            <button class="edit btn" id="edit-modal-btn">Sửa</button>
                            <button class="delete btn">Xoá</button>
                        </td>
                    </tr>
                    <tr class="blogs">
                        <td class="cell-tick"><input type="checkbox" class="row-checkbox"/></td>
                        <td class="cell-id">2</td>
                        <td class="cell-title">Bài viết mẫu 2</td>
                        <td class="cell-author">Nguyễn Văn A</td>
                        <td class="cell-date">06/10/2024</td>
                        <td class="cell-status">Ẩn</td>
                        <td class="cell-action">
                            <button class="edit btn" id="edit-modal-btn2">Sửa</button>
                            <button class="delete btn">Xoá</button>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </main>
    </div>
</div>

<div class="modal-overlay" id="add-blog-modal">
    <div class="modal-content approve-modal">
        <h2>Duyệt Bài Viết</h2>
        <table class="approve-table">
            <thead>
            <tr>
                <th>Nguồn</th>
                <th>Tiêu đề</th>
                <th>Hành động</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>User A</td>
                <td>Bài viết mẫu 1</td>
                <td>
                    <button class="preview-btn">Xem trước</button>
                    <button class="approve-btn">Duyệt</button>
                    <button class="delete-btn">Xóa</button>
                </td>
            </tr>
            <tr>
                <td>User B</td>
                <td>Bài viết mẫu 2</td>
                <td>
                    <button class="preview-btn">Xem trước</button>
                    <button class="approve-btn">Duyệt</button>
                    <button class="delete-btn">Xóa</button>
                </td>
            </tr>
            <tr>
                <td>User C</td>
                <td>Bài viết mẫu 3</td>
                <td>
                    <button class="preview-btn">Xem trước</button>
                    <button class="approve-btn">Duyệt</button>
                    <button class="delete-btn">Xóa</button>
                </td>
            </tr>
            </tbody>
        </table>
        <div class="group-button-action section">
            <button type="button" class="cancel element-button" id="close-modal-btn">Đóng</button>
        </div>
    </div>
</div>
<div class="modal-overlay-excel" id="excel-blog-modal">
    <div class="modal-content-excel">
        <p>Thành công xuất ra file Excel</p>
        <button class="modal-close2" id="close-modal-btn5">
            <ion-icon name="close-outline"></ion-icon>
        </button>
    </div>
</div>
<div class="modal-overlay-deleteAll" id="deleteAll-blog-modal">
    <div class="modal-content-deleteAll">
        <div class="group-text-deleteAll">
            <p class="p-deleteAll1">Bạn có chắc chắn muốn xoá toàn bộ dữ liệu của các ô được chọn?</p>
            <p class="p-deleteAll2">
                <ion-icon name="warning-outline" class="icon-warning"></ion-icon>
                Hành động này sẽ không thể hoàn tác
            </p>
        </div>
        <div class="group-button-action delete-all">
            <button type="button" class="element-button" id="close-modal-btn6">Huỷ</button>
            <button type="submit" class="deleteAll-button">Xoá Tất Cả</button>
        </div>
    </div>
</div>
<div class="modal-overlay-edit_information" id="edit_information-blog-modal">
    <div class="modal-content-edit_information">
        <h2>Bảng thông tin</h2>
        <div class="edit-information-account">
            <div class="title-section">
                <label for="title">Tiêu đề</label>
                <input type="text" id="title" name="title" value="Bài viết mẫu 1" placeholder="Chưa có tiêu đề"
                       required>
            </div>
            <div class="author-section">
                <label for="author">Tác giả</label>
                <input type="text" id="author" name="author" value="Admin" placeholder="Chưa có tác giả" required>
            </div>
            <div class="date-section">
                <label for="date">Ngày đăng</label>
                <input type="date" id="date" name="date" value="2025-01-01" required>
            </div>
            <div class="status-section">
                <label for="status">Trạng thái</label>
                <select id="status" required>
                    <option value="Hiện">Hiện</option>
                    <option value="Ẩn">Ẩn</option>
                </select>
            </div>
            <div class="content-section">
                <label for="content">Nội dung</label>
                <textarea id="content" name="content" placeholder="Chưa có nội dung"></textarea>
            </div>
        </div>
        <div class="group-button-action section">
            <button type="button" class="cancel element-button" id="close-modal-btn7">Huỷ</button>
            <button type="submit" class="fix-btn element-button">Sửa</button>
        </div>
    </div>
</div>
<div class="modal-overlay-edit_information" id="edit_information-blog-modal-2">
    <div class="modal-content-edit_information">
        <h2>Bảng thông tin</h2>
        <div class="edit-information-account">
            <div class="title-section">
                <label>Tiêu đề</label>
                <input type="text" name="title" value="Bài viết mẫu 2">
            </div>
            <div class="author-section">
                <label>Tác giả</label>
                <input type="text" name="author" value="Nguyễn Văn A">
            </div>
            <div class="date-section">
                <label>Ngày đăng</label>
                <input type="date" name="date" value="2025-02-10">
            </div>
            <div class="status-section">
                <label>Trạng thái</label>
                <select>
                    <option value="Hiện">Hiện</option>
                    <option value="Ẩn" selected>Ẩn</option>
                </select>
            </div>
            <div class="content-section">
                <label>Nội dung</label>
                <textarea name="content" placeholder="Chưa có nội dung"></textarea>
            </div>
        </div>
        <div class="group-button-action section">
            <button type="button" class="cancel element-button" id="close-modal-btn-2">Huỷ</button>
            <button type="submit" class="fix-btn element-button">Sửa</button>
        </div>
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
        <button class="btn-menu-item">
            <ion-icon name="person-circle-outline"></ion-icon>
            <span>Trở về trang người dùng</span>
        </button>
        <button class="btn-menu-item">
            <ion-icon name="log-out-outline"></ion-icon>
            <span>Đăng xuất tài khoản</span>
        </button>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="https://cdn.datatables.net/2.3.4/css/dataTables.dataTables.css"/>
<script src="https://cdn.datatables.net/2.3.4/js/dataTables.js"></script>
<script src="../popup.js"></script>
<script>
    // Run Pop-up function
    document.addEventListener("DOMContentLoaded", function () {
        setupModal('add-blog-modal', 'open-modal-btn', 'close-modal-btn');
        setupModal('excel-blog-modal', 'excel-modal-btn', 'close-modal-btn5');
        setupModal('deleteAll-blog-modal', 'deleteAll-modal-btn', 'close-modal-btn6');
        setupModal('edit_information-blog-modal', 'edit-modal-btn', 'close-modal-btn7');
        setupModal('edit_information-blog-modal-2', 'edit-modal-btn2', 'close-modal-btn-2');
        setupModal('notification-account-modal', 'notification-modal-btn', 'close-modal-btn8');
        setupModal('avatar-account-modal', 'avatar-modal-btn', 'close-modal-btn9');

        $(document).ready(function () {
            $('#account-table-main').DataTable({
                language: {
                    url: 'https://cdn.datatables.net/plug-ins/2.3.5/i18n/vi.json',
                },
            });
        });
    });
</script>

</body>
</html>