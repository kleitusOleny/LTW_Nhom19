<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Orders Manage</title>
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
            <li><a href="manage_orders.html" class="a-with-icon selected">
                <ion-icon name="cart"></ion-icon>
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
            <div class="button-group">
                <h2>Quản lí đơn hàng</h2>
                <div class="func-group">
                    <button class="button del" id="deleteAll-modal-btn">
                        <ion-icon name="trash-outline"></ion-icon>
                        Xoá (Đã chọn)
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
                <table id="order-table-main" class="order-table">
                    <thead>
                    <tr class="sample">
                        <th class="col-tick">Chọn</th>
                        <th class="col-id">ID Đơn Hàng</th>
                        <th class="col-customer">Khách Hàng</th>
                        <th class="col-date">Ngày Đặt</th>
                        <th class="col-total">Tổng Tiền</th>
                        <th class="col-status">Trạng Thái</th>
                        <th class="col-action">Hành Động</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr class="orders">
                        <td class="cell-tick"><input type="checkbox" class="row-checkbox"/></td>
                        <td class="cell-id">DH001</td>
                        <td class="cell-customer">Nguyễn Văn A</td>
                        <td class="cell-date">06/10/2024</td>
                        <td class="cell-total">1.500.000đ</td>
                        <td class="cell-status">Đang xử lý</td>
                        <td class="cell-action">
                            <button class="view btn" id="view-modal-btn">Xem</button>
                            <button class="delete btn">Xoá</button>
                        </td>
                    </tr>
                    <tr class="orders">
                        <td class="cell-tick"><input type="checkbox" class="row-checkbox"/></td>
                        <td class="cell-id">DH002</td>
                        <td class="cell-customer">Trần Thị B</td>
                        <td class="cell-date">03/08/2019</td>
                        <td class="cell-total">2.300.000đ</td>
                        <td class="cell-status">Đã giao</td>
                        <td class="cell-action">
                            <button class="view btn" id="view-modal-btn2">Xem</button>
                            <button class="delete btn">Xoá</button>
                        </td>
                    </tr>
                    <tr class="orders">
                        <td class="cell-tick"><input type="checkbox" class="row-checkbox"/></td>
                        <td class="cell-id">DH003</td>
                        <td class="cell-customer">Lê Văn C</td>
                        <td class="cell-date">15/08/2019</td>
                        <td class="cell-total">850.000đ</td>
                        <td class="cell-status">Đã hủy</td>
                        <td class="cell-action">
                            <button class="view btn" id="view-modal-btn3">Xem</button>
                            <button class="delete btn">Xoá</button>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </main>
    </div>
</div>

<div class="modal-overlay" id="add-order-modal">
    <div class="modal-content">
        <form id="add-form">
            <div class="customer-input">
                <label for="customer" class="label-with-icon">
                    <ion-icon name="person-outline"></ion-icon>
                    Khách Hàng</label>
                <input type="text" name="customer" placeholder="Nhập tên khách hàng" required>
            </div>
            <div class="date-input">
                <label for="date" class="label-with-icon">
                    <ion-icon name="calendar-outline"></ion-icon>
                    Ngày Đặt</label>
                <input type="date" name="date" required>
            </div>
            <div class="total-input">
                <label for="total" class="label-with-icon">
                    <ion-icon name="cash-outline"></ion-icon>
                    Tổng Tiền</label>
                <input type="text" name="total" placeholder="Nhập tổng tiền" required>
            </div>
            <div class="status-input">
                <label for="status" class="label-with-icon">
                    <ion-icon name="checkmark-circle-outline"></ion-icon>
                    Trạng Thái</label>
                <select id="status" name="status" required>
                    <option value="processing">Đang xử lý</option>
                    <option value="delivered">Đã giao</option>
                    <option value="cancelled">Đã hủy</option>
                </select>
            </div>
            <div class="group-button-action section">
                <button type="button" class="cancel element-button" id="close-modal-btn">Huỷ</button>
                <button type="submit" class="add-btn element-button">Thêm</button>
            </div>
        </form>
    </div>
</div>
<div class="modal-overlay-excel" id="excel-order-modal">
    <div class="modal-content-excel">
        <p>Thành công xuất ra file Excel</p>
        <button class="modal-close2" id="close-modal-btn5">
            <ion-icon name="close-outline"></ion-icon>
        </button>
    </div>
</div>
<div class="modal-overlay-deleteAll" id="deleteAll-order-modal">
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
<div class="modal-overlay-edit_information" id="edit_information-order-modal">
    <div class="modal-content-edit_information">
        <h2>Bảng thông tin đơn hàng</h2>
        <div class="edit-information-order">
            <div class="orderId-section">
                <label for="id">ID Đơn Hàng:</label>
                <input type="text" id="id" name="id" value="DH001" placeholder="ID hiện không có">
            </div>
            <div class="customer-section">
                <label for="customer">Khách Hàng</label>
                <input type="text" id="customer" name="customer" value="Nguyễn Văn A" placeholder="Chưa có khách hàng"
                       required>
            </div>
            <div class="date-section">
                <label for="date">Ngày Đặt</label>
                <input type="date" id="date" name="date" value="2024-10-06" required>
            </div>
            <div class="total-section">
                <label for="total">Tổng Tiền</label>
                <input type="text" id="total" name="total" value="1.500.000đ" placeholder="Chưa có tổng tiền" required>
            </div>
            <div class="status-section">
                <label for="statusSelect">Trạng Thái:</label>
                <select id="statusSelect" required>
                    <option value="processing">Đang xử lý</option>
                    <option value="delivered">Đã giao</option>
                    <option value="cancelled">Đã hủy</option>
                </select>
            </div>
        </div>
        <div class="group-button-action section">
            <button type="button" class="cancel element-button" id="close-modal-btn7">Huỷ</button>
            <button type="submit" class="fix-btn element-button">Sửa</button>
        </div>
    </div>
</div>
<div class="modal-overlay-edit_information" id="edit_information-order-modal-2">
    <div class="modal-content-edit_information">
        <h2>Bảng thông tin đơn hàng</h2>
        <div class="edit-information-order">
            <div class="orderId-section">
                <label>ID Đơn Hàng:</label>
                <input type="text" name="id" value="DH002" readonly>
            </div>
            <div class="customer-section">
                <label>Khách Hàng</label>
                <input type="text" name="customer" value="Trần Thị B">
            </div>
            <div class="date-section">
                <label>Ngày Đặt</label>
                <input type="date" name="date" value="2019-08-03">
            </div>
            <div class="total-section">
                <label>Tổng Tiền</label>
                <input type="text" name="total" value="2.300.000đ">
            </div>
            <div class="status-section">
                <label>Trạng Thái:</label>
                <select>
                    <option value="delivered" selected>Đã giao</option>
                    <option value="processing">Đang xử lý</option>
                    <option value="cancelled">Đã hủy</option>
                </select>
            </div>
        </div>
        <div class="group-button-action section">
            <button type="button" class="cancel element-button" id="close-modal-btn-2">Huỷ</button>
            <button type="submit" class="fix-btn element-button">Sửa</button>
        </div>
    </div>
</div>
<div class="modal-overlay-edit_information" id="edit_information-order-modal-3">
    <div class="modal-content-edit_information">
        <h2>Bảng thông tin đơn hàng</h2>
        <div class="edit-information-order">
            <div class="orderId-section">
                <label>ID Đơn Hàng:</label>
                <input type="text" name="id" value="DH003" readonly>
            </div>
            <div class="customer-section">
                <label>Khách Hàng</label>
                <input type="text" name="customer" value="Lê Văn C">
            </div>
            <div class="date-section">
                <label>Ngày Đặt</label>
                <input type="date" name="date" value="2019-08-15">
            </div>
            <div class="total-section">
                <label>Tổng Tiền</label>
                <input type="text" name="total" value="850.000đ">
            </div>
            <div class="status-section">
                <label>Trạng Thái:</label>
                <select>
                    <option value="cancelled" selected>Đã hủy</option>
                    <option value="processing">Đang xử lý</option>
                    <option value="delivered">Đã giao</option>
                </select>
            </div>
        </div>
        <div class="group-button-action section">
            <button type="button" class="cancel element-button" id="close-modal-btn-3">Huỷ</button>
            <button type="submit" class="fix-btn element-button">Sửa</button>
        </div>
    </div>
</div>

<div class="modal-overlay" id="orderDetailModal">
    <button class="modal-close-outside" id="closeModal">
        <ion-icon name="close-outline"></ion-icon>
    </button>
    <div class="modal-content">
        <h2>Chi Tiết Đơn Hàng #DH001</h2>

        <div class="section info">
            <h3>Thông tin khách hàng</h3>
            <p><strong>Họ và tên:</strong> Nguyễn Văn A</p>
            <p><strong>Email:</strong> nguyenvan@example.com</p>
            <p><strong>Điện thoại:</strong> 0987654321</p>
            <p><strong>Địa chỉ:</strong> 123 Đường ABC, Quận 1, TP.HCM</p>
            <p><strong>Hình thức thanh toán:</strong> Thanh toán khi nhận hàng</p>
        </div>

        <div class="section">
            <h3>Sản phẩm</h3>
            <table>
                <thead>
                <tr>
                    <th>Hình ảnh</th>
                    <th>Sản phẩm</th>
                    <th>Số lượng</th>
                    <th>Đơn giá</th>
                    <th>Tổng</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td><img class="product-img" src="../img/SKU__VD_0926-22.png" alt="Rượu vang đỏ"></td>
                    <td>Rượu vang đỏ cao cấp</td>
                    <td>2</td>
                    <td>1.200.000₫</td>
                    <td>2.400.000₫</td>
                </tr>
                <tr>
                    <td><img class="product-img" src="../img/SKU__VD_0926-22.png" alt="Whisky cao cấp"></td>
                    <td>Whisky cao cấp</td>
                    <td>1</td>
                    <td>1.500.000₫</td>
                    <td>1.500.000₫</td>
                </tr>
                </tbody>
                <tfoot>
                <tr>
                    <th colspan="4" style="text-align:right;">Tổng cộng:</th>
                    <th>3.900.000₫</th>
                </tr>
                </tfoot>
            </table>
        </div>

        <div class="section">
            <h3>Trạng thái đơn hàng</h3>
            <span class="status completed">Hoàn thành</span>

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
    </div>
</div>
<div class="modal-overlay-notification" id="notification-order-modal">
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
<div class="modal-overlay-avatar" id="avatar-order-modal">
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
        setupModal('add-order-modal', 'open-modal-btn', 'close-modal-btn');
        setupModal('excel-order-modal', 'excel-modal-btn', 'close-modal-btn5');
        setupModal('deleteAll-order-modal', 'deleteAll-modal-btn', 'close-modal-btn6');
        setupModal('notification-order-modal', 'notification-modal-btn', 'close-modal-btn8');
        setupModal('avatar-order-modal', 'avatar-modal-btn', 'close-modal-btn9');

        // Setup view buttons for order details
        const viewButtons = document.querySelectorAll('.view.btn');
        const orderDetailModal = document.getElementById('orderDetailModal');
        const closeModal = document.getElementById('closeModal');

        viewButtons.forEach(btn => {
            btn.addEventListener('click', () => {
                orderDetailModal.classList.add('show');
            });
        });

        closeModal.addEventListener('click', () => {
            orderDetailModal.classList.remove('show');
        });

        orderDetailModal.addEventListener('click', (e) => {
            if (e.target === orderDetailModal) {
                orderDetailModal.classList.remove('show');
            }
        });

        $(document).ready(function () {
            $('#order-table-main').DataTable({
                language: {
                    url: 'https://cdn.datatables.net/plug-ins/2.3.5/i18n/vi.json',
                },
            });
        });
    });
</script>
</body>
</html>