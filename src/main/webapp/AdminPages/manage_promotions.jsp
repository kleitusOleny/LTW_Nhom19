<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Promotions Manage</title>
    <link rel="stylesheet" href="admin_css/manage_promotion_style.css">
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
            <li><a href="manage_blog.jsp" class="a-with-icon">
                <ion-icon name="reader-outline"></ion-icon>
                Quản Lí Blog và Tin Tức</a></li>
            <li><a href="manage_promotions.html" class="a-with-icon selected">
                <ion-icon name="ticket"></ion-icon>
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
                <h2>Quản lí mã giảm giá và khuyến mãi</h2>
                <div class="func-group">
                    <button class="button del" id="deleteAll-modal-btn">
                        <ion-icon name="trash-outline"></ion-icon>
                        Xoá (Đã Chọn)
                    </button>
                    <button class="button add" id="open-modal-btn">
                        <ion-icon name="add-outline" class="type-needCss"></ion-icon>
                        Thêm
                    </button>
                    <button class="button excel" id="excel-modal-btn">
                        <ion-icon name="cloud-download-outline"></ion-icon>
                        Xuất ra Excel
                    </button>
                </div>
            </div>
            <div class="table-container">
                <table id="promotion-table-main" class="promotion-table">
                    <thead>
                    <tr class="sample">
                        <th class="col-tick">Chọn</th>
                        <th class="col-id">ID</th>
                        <th class="col-code">Mã Giảm Giá</th>
                        <th class="col-type">Loại</th>
                        <th class="col-value">Giá Trị</th>
                        <th class="col-start">Ngày Bắt Đầu</th>
                        <th class="col-end">Ngày Kết Thúc</th>
                        <th class="col-status">Trạng Thái</th>
                        <th class="col-action">Hành Động</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr class="promotions">
                        <td class="cell-tick"><input type="checkbox" class="row-checkbox"/></td>
                        <td class="cell-id">1</td>
                        <td class="cell-code">SALE2025</td>
                        <td class="cell-type">Phần trăm</td>
                        <td class="cell-value">10%</td>
                        <td class="cell-start">06/10/2024</td>
                        <td class="cell-end">06/10/2024</td>
                        <td class="cell-status">Hoạt động</td>
                        <td class="cell-action">
                            <button class="edit btn" id="edit-modal-btn">Sửa</button>
                            <button class="delete btn">Xoá</button>
                        </td>
                    </tr>
                    <tr class="promotions">
                        <td class="cell-tick"><input type="checkbox" class="row-checkbox"/></td>
                        <td class="cell-id">2</td>
                        <td class="cell-code">FREESHIP</td>
                        <td class="cell-type">Miễn phí vận chuyển</td>
                        <td class="cell-value">0đ</td>
                        <td class="cell-start">06/10/2024</td>
                        <td class="cell-end">06/10/2024</td>
                        <td class="cell-status">Không hoạt động</td>
                        <td class="cell-action">
                            <button class="edit btn" id="edit-modal-btn2">Sửa</button>
                            <button class="delete btn">Xoá</button>
                        </td>
                    </tr>
                    <tr class="promotions">
                        <td class="cell-tick"><input type="checkbox" class="row-checkbox"/></td>
                        <td class="cell-id">3</td>
                        <td class="cell-code">SUMMER50</td>
                        <td class="cell-type">Số tiền cố định</td>
                        <td class="cell-value">50.000đ</td>
                        <td class="cell-start">06/10/2024</td>
                        <td class="cell-end">06/10/2024</td>
                        <td class="cell-status">Không hoạt động</td>
                        <td class="cell-action">
                            <button class="edit btn" id="edit-modal-btn3">Sửa</button>
                            <button class="delete btn">Xoá</button>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </main>
    </div>
</div>

<div class="modal-overlay" id="add-promotion-modal">
    <div class="modal-content">
        <form id="add-form">
            <div class="code-input">
                <label for="code" class="label-with-icon">
                    <ion-icon name="pricetag-outline"></ion-icon>
                    Mã Giảm Giá</label>
                <input type="text" id="code" name="code" placeholder="Nhập mã giảm giá" required>
            </div>
            <div class="type-input">
                <label for="type" class="label-with-icon">
                    <ion-icon name="options-outline"></ion-icon>
                    Loại</label>
                <select id="type" name="type" required>
                    <option value="Phần trăm">Phần trăm</option>
                    <option value="Số tiền cố định">Số tiền cố định</option>
                    <option value="Miễn phí vận chuyển">Miễn phí vận chuyển</option>
                </select>
            </div>
            <div class="value-input">
                <label for="value" class="label-with-icon">
                    <ion-icon name="cash-outline"></ion-icon>
                    Giá Trị</label>
                <input type="text" id="value" name="value" placeholder="Nhập giá trị" required>
            </div>
            <div class="start-input">
                <label for="start" class="label-with-icon">
                    <ion-icon name="calendar-outline"></ion-icon>
                    Ngày Bắt Đầu</label>
                <input type="date" id="start" name="start" required>
            </div>
            <div class="end-input">
                <label for="end" class="label-with-icon">
                    <ion-icon name="calendar-outline"></ion-icon>
                    Ngày Kết Thúc</label>
                <input type="date" id="end" name="end" required>
            </div>
            <div class="status-input">
                <label for="status" class="label-with-icon">
                    <ion-icon name="checkmark-circle-outline"></ion-icon>
                    Trạng Thái</label>
                <select id="status" name="status" required>
                    <option value="Hoạt động">Hoạt động</option>
                    <option value="Không hoạt động">Không hoạt động</option>
                </select>
            </div>
            <div class="group-button-action section">
                <button type="button" class="cancel element-button" id="close-modal-btn">Huỷ</button>
                <button type="submit" class="add-btn element-button">Thêm</button>
            </div>
        </form>
    </div>
</div>
<div class="modal-overlay-excel" id="excel-promotion-modal">
    <div class="modal-content-excel">
        <p>Thành công xuất ra file Excel</p>
        <button class="modal-close2" id="close-modal-btn5">
            <ion-icon name="close-outline"></ion-icon>
        </button>
    </div>
</div>
<div class="modal-overlay-deleteAll" id="deleteAll-promotion-modal">
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
<div class="modal-overlay-edit_information" id="edit_information-promotion-modal">
    <div class="modal-content-edit_information">
        <h2>Bảng thông tin khuyến mãi</h2>
        <div class="edit-information-promotion">
            <div class="id-section">
                <label for="id">ID:</label>
                <input type="text" id="id" name="id" value="1" placeholder="ID hiện không có">
            </div>
            <div class="code-section">
                <label for="code_edit">Mã Giảm Giá</label>
                <input type="text" id="code_edit" name="code_edit" value="SALE2025" placeholder="Chưa có mã" required>
            </div>
            <div class="type-section">
                <label for="type_edit">Loại</label>
                <select id="type_edit" name="type_edit" required>
                    <option value="Phần trăm" selected>Phần trăm</option>
                    <option value="Số tiền cố định">Số tiền cố định</option>
                    <option value="Miễn phí vận chuyển">Miễn phí vận chuyển</option>
                </select>
            </div>
            <div class="value-section">
                <label for="value_edit">Giá Trị</label>
                <input type="text" id="value_edit" name="value_edit" value="10%" placeholder="Chưa có giá trị" required>
            </div>
            <div class="start-section">
                <label for="start_edit">Ngày Bắt Đầu</label>
                <input type="date" id="start_edit" name="start_edit" value="2025-01-01" required>
            </div>
            <div class="end-section">
                <label for="end_edit">Ngày Kết Thúc</label>
                <input type="date" id="end_edit" name="end_edit" value="2025-12-31" required>
            </div>
            <div class="status-section">
                <label for="status_edit">Trạng Thái</label>
                <select id="status_edit" name="status_edit" required>
                    <option value="Hoạt động" selected>Hoạt động</option>
                    <option value="Không hoạt động">Không hoạt động</option>
                </select>
            </div>
        </div>
        <div class="group-button-action section">
            <button type="button" class="cancel element-button" id="close-modal-btn7">Huỷ</button>
            <button type="submit" class="fix-btn element-button">Sửa</button>
        </div>
    </div>
</div>
<div class="modal-overlay-edit_information" id="edit_information-promotion-modal-2">
    <div class="modal-content-edit_information">
        <h2>Bảng thông tin khuyến mãi</h2>
        <div class="edit-information-promotion">
            <div class="id-section">
                <label>ID:</label>
                <input type="text" name="id" value="2" readonly>
            </div>
            <div class="code-section">
                <label>Mã Giảm Giá</label>
                <input type="text" name="code_edit" value="FREESHIP">
            </div>
            <div class="type-section">
                <label>Loại</label>
                <select name="type_edit">
                    <option value="Miễn phí vận chuyển" selected>Miễn phí vận chuyển</option>
                    <option value="Phần trăm">Phần trăm</option>
                    <option value="Số tiền cố định">Số tiền cố định</option>
                </select>
            </div>
            <div class="value-section">
                <label>Giá Trị</label>
                <input type="text" name="value_edit" value="0đ">
            </div>
            <div class="start-section">
                <label>Ngày Bắt Đầu</label>
                <input type="date" name="start_edit" value="2025-03-15">
            </div>
            <div class="end-section">
                <label>Ngày Kết Thúc</label>
                <input type="date" name="end_edit" value="2025-04-15">
            </div>
            <div class="status-section">
                <label>Trạng Thái</label>
                <select name="status_edit">
                    <option value="Hoạt động">Hoạt động</option>
                    <option value="Không hoạt động" selected>Không hoạt động</option>
                </select>
            </div>
        </div>
        <div class="group-button-action section">
            <button type="button" class="cancel element-button" id="close-modal-btn-2">Huỷ</button>
            <button type="submit" class="fix-btn element-button">Sửa</button>
        </div>
    </div>
</div>
<div class="modal-overlay-edit_information" id="edit_information-promotion-modal-3">
    <div class="modal-content-edit_information">
        <h2>Bảng thông tin khuyến mãi</h2>
        <div class="edit-information-promotion">
            <div class="id-section">
                <label>ID:</label>
                <input type="text" name="id" value="3" readonly>
            </div>
            <div class="code-section">
                <label>Mã Giảm Giá</label>
                <input type="text" name="code_edit" value="SUMMER50">
            </div>
            <div class="type-section">
                <label>Loại</label>
                <select name="type_edit">
                    <option value="Số tiền cố định" selected>Số tiền cố định</option>
                    <option value="Phần trăm">Phần trăm</option>
                    <option value="Miễn phí vận chuyển">Miễn phí vận chuyển</option>
                </select>
            </div>
            <div class="value-section">
                <label>Giá Trị</label>
                <input type="text" name="value_edit" value="50.000đ">
            </div>
            <div class="start-section">
                <label>Ngày Bắt Đầu</label>
                <input type="date" name="start_edit" value="2025-06-01">
            </div>
            <div class="end-section">
                <label>Ngày Kết Thúc</label>
                <input type="date" name="end_edit" value="2025-08-31">
            </div>
            <div class="status-section">
                <label>Trạng Thái</label>
                <select name="status_edit">
                    <option value="Hoạt động">Hoạt động</option>
                    <option value="Không hoạt động" selected>Không hoạt động</option>
                </select>
            </div>
        </div>
        <div class="group-button-action section">
            <button type="button" class="cancel element-button" id="close-modal-btn-3">Huỷ</button>
            <button type="submit" class="fix-btn element-button">Sửa</button>
        </div>
    </div>
</div>

<div class="modal-overlay-notification" id="notification-promotion-modal">
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

<div class="modal-overlay-avatar" id="avatar-promotion-modal">
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
<script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
<link href="https://fonts.googleapis.com/css2?family=Philosopher&display=swap" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="https://cdn.datatables.net/2.3.4/css/dataTables.dataTables.css"/>
<script src="https://cdn.datatables.net/2.3.4/js/dataTables.js"></script>
<script src="../popup.js"></script>
<script>
    // Run Pop-up function
    document.addEventListener("DOMContentLoaded", function () {
        setupModal('add-promotion-modal', 'open-modal-btn', 'close-modal-btn');
        setupModal('excel-promotion-modal', 'excel-modal-btn', 'close-modal-btn5');
        setupModal('deleteAll-promotion-modal', 'deleteAll-modal-btn', 'close-modal-btn6');
        setupModal('edit_information-promotion-modal', 'edit-modal-btn', 'close-modal-btn7');
        setupModal('edit_information-promotion-modal-2', 'edit-modal-btn2', 'close-modal-btn-2');
        setupModal('edit_information-promotion-modal-3', 'edit-modal-btn3', 'close-modal-btn-3');
        setupModal('notification-promotion-modal', 'notification-modal-btn', 'close-modal-btn8');
        setupModal('avatar-promotion-modal', 'avatar-modal-btn', 'close-modal-btn9');

        $(document).ready(function () {
            $('#promotion-table-main').DataTable({
                language: {
                    url: 'https://cdn.datatables.net/plug-ins/2.3.5/i18n/vi.json',
                },
            });
        });
    });
</script>
</body>
</html>