<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <title>Trang Chủ</title>
    <script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/AdminPages/admin_css/admin_dashboard.css">
</head>
<body>
<div class="dashboard-container">
    <nav class="dashboard-sidebar">
        <ul class="sidebar-items">
            <div class="group-avatar">
                <img src="${pageContext.request.contextPath}/assets/avatar.jpg" class="user-avatar" id="avatar-modal-btn" alt=""/>
                <ion-icon name="notifications-outline" class="icon-header" id="notification-modal-btn"></ion-icon>
            </div>
            <li><a href="admin_dashboard.jsp" class="a-with-icon selected">
                <ion-icon name="home"></ion-icon>
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
            <div class="todo-list-container not-finish">
                <h2>
                    <ion-icon name="document-attach-outline"></ion-icon>
                    Danh Sách Cần Làm
                </h2>
                <div class="contain-todo">
                    <div class="todo not-finish" id="todo-modal-btn-1">
                        Fix lỗi vỡ giao diện trên Mobile (Khách báo)
                        <ion-icon name="chevron-forward-outline" class="icon-todo"></ion-icon>
                    </div>
                    <div class="todo not-finish" id="todo-modal-btn-2">
                        Viết API lấy danh sách khách hàng VIP
                        <ion-icon name="chevron-forward-outline" class="icon-todo"></ion-icon>
                    </div>
                    <div class="todo not-finish" id="todo-modal-btn-3">
                        Đổi màu nút "Mua ngay" sang màu đỏ
                        <ion-icon name="chevron-forward-outline" class="icon-todo"></ion-icon>
                    </div>
                    <div class="todo not-finish" id="todo-modal-btn-4">
                        Trả lời email hỗ trợ đơn hàng #DH005
                        <ion-icon name="chevron-forward-outline" class="icon-todo"></ion-icon>
                    </div>
                    <div class="todo not-finish" id="todo-modal-btn-5">
                        Kiểm tra lỗi bảo mật form Đăng ký
                        <ion-icon name="chevron-forward-outline" class="icon-todo"></ion-icon>
                    </div>
                </div>
            </div>

            <div class="todo-list-container finished">
                <h2>
                    <ion-icon name="checkbox-outline"></ion-icon>
                    Đã Hoàn Thành
                </h2>
                <div class="contain-todo">
                    <div class="todo finish" id="todo-modal-btn-6">
                        Thiết kế xong Banner khuyến mãi tháng 11
                        <ion-icon name="chevron-forward-outline" class="icon-todo"></ion-icon>
                    </div>
                    <div class="todo finish" id="todo-modal-btn-7">
                        Tối ưu tốc độ load database sản phẩm
                        <ion-icon name="chevron-forward-outline" class="icon-todo"></ion-icon>
                    </div>
                    <div class="todo finish" id="todo-modal-btn-8">
                        Gọi điện xác nhận đơn hàng lớn
                        <ion-icon name="chevron-forward-outline" class="icon-todo"></ion-icon>
                    </div>
                    <div class="todo finish" id="todo-modal-btn-9">
                        Thêm hiệu ứng animation cho menu
                        <ion-icon name="chevron-forward-outline" class="icon-todo"></ion-icon>
                    </div>
                    <div class="todo finish" id="todo-modal-btn-10">
                        Backup dữ liệu web lúc 12h đêm
                        <ion-icon name="chevron-forward-outline" class="icon-todo"></ion-icon>
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
<div class="modal-overlay-todo" id="todo-list-modal-1">
    <div class="modal-content-todo">
        <div class="todo-container">
            <h2>Fix lỗi vỡ giao diện trên Mobile (Khách báo)</h2>
            <div class="select-todo">
                <label>Tiến độ:</label>
                <select>
                    <option value="yes">Hoàn Thành</option>
                    <option value="no" selected>Chưa Hoàn Thành</option>
                </select>
            </div>
        </div>
        <div class="group-button-action section">
            <button type="button" class="cancel element-button" id="close-modal-btn-11">Huỷ</button>
            <button type="submit" class="fix-btn element-button">Sửa</button>
        </div>
    </div>
</div>
<div class="modal-overlay-todo" id="todo-list-modal-2">
    <div class="modal-content-todo">
        <div class="todo-container">
            <h2>Viết API lấy danh sách khách hàng VIP</h2>
            <div class="select-todo">
                <label>Tiến độ:</label>
                <select>
                    <option value="yes">Hoàn Thành</option>
                    <option value="no" selected>Chưa Hoàn Thành</option>
                </select>
            </div>
        </div>
        <div class="group-button-action section">
            <button type="button" class="cancel element-button" id="close-modal-btn-12">Huỷ</button>
            <button type="submit" class="fix-btn element-button">Sửa</button>
        </div>
    </div>
</div>
<div class="modal-overlay-todo" id="todo-list-modal-3">
    <div class="modal-content-todo">
        <div class="todo-container">
            <h2>Đổi màu nút "Mua ngay" sang màu đỏ</h2>
            <div class="select-todo">
                <label>Tiến độ:</label>
                <select>
                    <option value="yes">Hoàn Thành</option>
                    <option value="no" selected>Chưa Hoàn Thành</option>
                </select>
            </div>
        </div>
        <div class="group-button-action section">
            <button type="button" class="cancel element-button" id="close-modal-btn-13">Huỷ</button>
            <button type="submit" class="fix-btn element-button">Sửa</button>
        </div>
    </div>
</div>
<div class="modal-overlay-todo" id="todo-list-modal-4">
    <div class="modal-content-todo">
        <div class="todo-container">
            <h2>Trả lời email hỗ trợ đơn hàng #DH005</h2>
            <div class="select-todo">
                <label>Tiến độ:</label>
                <select>
                    <option value="yes">Hoàn Thành</option>
                    <option value="no" selected>Chưa Hoàn Thành</option>
                </select>
            </div>
        </div>
        <div class="group-button-action section">
            <button type="button" class="cancel element-button" id="close-modal-btn-14">Huỷ</button>
            <button type="submit" class="fix-btn element-button">Sửa</button>
        </div>
    </div>
</div>
<div class="modal-overlay-todo" id="todo-list-modal-5">
    <div class="modal-content-todo">
        <div class="todo-container">
            <h2>Kiểm tra lỗi bảo mật form Đăng ký</h2>
            <div class="select-todo">
                <label>Tiến độ:</label>
                <select>
                    <option value="yes">Hoàn Thành</option>
                    <option value="no" selected>Chưa Hoàn Thành</option>
                </select>
            </div>
        </div>
        <div class="group-button-action section">
            <button type="button" class="cancel element-button" id="close-modal-btn-15">Huỷ</button>
            <button type="submit" class="fix-btn element-button">Sửa</button>
        </div>
    </div>
</div>
<div class="modal-overlay-todo" id="todo-list-modal-6">
    <div class="modal-content-todo">
        <div class="todo-container">
            <h2>Thiết kế xong Banner khuyến mãi tháng 11</h2>
            <div class="select-todo">
                <label>Tiến độ:</label>
                <select>
                    <option value="yes" selected>Hoàn Thành</option>
                    <option value="no">Chưa Hoàn Thành</option>
                </select>
            </div>
        </div>
        <div class="group-button-action section">
            <button type="button" class="cancel element-button" id="close-modal-btn-16">Huỷ</button>
            <button type="submit" class="fix-btn element-button">Sửa</button>
        </div>
    </div>
</div>
<div class="modal-overlay-todo" id="todo-list-modal-7">
    <div class="modal-content-todo">
        <div class="todo-container">
            <h2>Tối ưu tốc độ load database sản phẩm</h2>
            <div class="select-todo">
                <label>Tiến độ:</label>
                <select>
                    <option value="yes" selected>Hoàn Thành</option>
                    <option value="no">Chưa Hoàn Thành</option>
                </select>
            </div>
        </div>
        <div class="group-button-action section">
            <button type="button" class="cancel element-button" id="close-modal-btn-17">Huỷ</button>
            <button type="submit" class="fix-btn element-button">Sửa</button>
        </div>
    </div>
</div>
<div class="modal-overlay-todo" id="todo-list-modal-8">
    <div class="modal-content-todo">
        <div class="todo-container">
            <h2>Gọi điện xác nhận đơn hàng lớn</h2>
            <div class="select-todo">
                <label>Tiến độ:</label>
                <select>
                    <option value="yes" selected>Hoàn Thành</option>
                    <option value="no">Chưa Hoàn Thành</option>
                </select>
            </div>
        </div>
        <div class="group-button-action section">
            <button type="button" class="cancel element-button" id="close-modal-btn-18">Huỷ</button>
            <button type="submit" class="fix-btn element-button">Sửa</button>
        </div>
    </div>
</div>
<div class="modal-overlay-todo" id="todo-list-modal-9">
    <div class="modal-content-todo">
        <div class="todo-container">
            <h2>Thêm hiệu ứng animation cho menu</h2>
            <div class="select-todo">
                <label>Tiến độ:</label>
                <select>
                    <option value="yes" selected>Hoàn Thành</option>
                    <option value="no">Chưa Hoàn Thành</option>
                </select>
            </div>
        </div>
        <div class="group-button-action section">
            <button type="button" class="cancel element-button" id="close-modal-btn-19">Huỷ</button>
            <button type="submit" class="fix-btn element-button">Sửa</button>
        </div>
    </div>
</div>
<div class="modal-overlay-todo" id="todo-list-modal-10">
    <div class="modal-content-todo">
        <div class="todo-container">
            <h2>Backup dữ liệu web lúc 12h đêm</h2>
            <div class="select-todo">
                <label>Tiến độ:</label>
                <select>
                    <option value="yes" selected>Hoàn Thành</option>
                    <option value="no">Chưa Hoàn Thành</option>
                </select>
            </div>
        </div>
        <div class="group-button-action section">
            <button type="button" class="cancel element-button" id="close-modal-btn-20">Huỷ</button>
            <button type="submit" class="fix-btn element-button">Sửa</button>
        </div>
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
    // Run Pop-up function
    document.addEventListener("DOMContentLoaded", function () {
        setupModal('notification-account-modal', 'notification-modal-btn', 'close-modal-btn8');
        setupModal('avatar-account-modal', 'avatar-modal-btn', 'close-modal-btn9');
        setupModal('todo-list-modal-1', 'todo-modal-btn-1', 'close-modal-btn-11');
        setupModal('todo-list-modal-2', 'todo-modal-btn-2', 'close-modal-btn-12');
        setupModal('todo-list-modal-3', 'todo-modal-btn-3', 'close-modal-btn-13');
        setupModal('todo-list-modal-4', 'todo-modal-btn-4', 'close-modal-btn-14');
        setupModal('todo-list-modal-5', 'todo-modal-btn-5', 'close-modal-btn-15');
        setupModal('todo-list-modal-6', 'todo-modal-btn-6', 'close-modal-btn-16');
        setupModal('todo-list-modal-7', 'todo-modal-btn-7', 'close-modal-btn-17');
        setupModal('todo-list-modal-8', 'todo-modal-btn-8', 'close-modal-btn-18');
        setupModal('todo-list-modal-9', 'todo-modal-btn-9', 'close-modal-btn-19');
        setupModal('todo-list-modal-10', 'todo-modal-btn-10', 'close-modal-btn-20');
        setupModal('out_of_stocks-modal', 'out_of_stocks-modal-btn', 'close-modal-out_of_stock');
    });
</script>
</body>
</html>