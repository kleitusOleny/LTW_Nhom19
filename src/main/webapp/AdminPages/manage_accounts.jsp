<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <title>Quản Lí Tài Khoản Khách</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/AdminPages/admin_css/manage_accounts.css">
</head>
<body>
<div class="dashboard-container">
    <nav class="dashboard-sidebar">
        <ul class="sidebar-items">
            <div class="group-avatar">
                <img src="${pageContext.request.contextPath}/assets/avatar.jpg" class="user-avatar" id="avatar-modal-btn" alt=""/>
                <ion-icon name="notifications-outline" class="icon-header" id="notification-modal-btn"></ion-icon>
            </div>
            <li><a href="admin_dashboard.jsp" class="a-with-icon">
                <ion-icon name="home-outline"></ion-icon>
                Trang Chủ</a></li>
            <li><a href="manage_product.jsp" class="a-with-icon">
                <ion-icon name="bag-remove-outline"></ion-icon>
                Quản Lí Sản Phẩm</a></li>
            <li><a href="manage_accounts.jsp" class="a-with-icon selected">
                <ion-icon name="people"></ion-icon>
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
            <div class="button-group">
                <div class="group-text-welcome">
                    <h2>Quản lí tài khoản khách</h2>
                    <p>Với các records được đánh dấu đỏ, nghĩa là đã khoá tài khoản</p>
                </div>
                <div class="func-group">
                    <button class="button del" id="deleteAll-modal-btn">
                        <ion-icon name="trash-outline"></ion-icon>
                        Khoá (Đã Chọn)
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
                <table id="account-table-main" class="account-table">
                    <thead>
                    <tr class="sample">
                        <th class="col-tick">Chọn</th>
                        <th class="col-id">ID Tài Khoản</th>
                        <th class="col-email">Email</th>
                        <th class="col-phone">Số Liên Lạc</th>
                        <th class="col-fullname">Họ và Tên</th>
                        <th class="col-create">Ngày tạo</th>
                        <th class="col-action">Hành Động</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr class="accounts">
                        <td class="cell-tick"><input type="checkbox" class="row-checkbox"/></td>
                        <td class="cell-id">1001</td>
                        <td class="cell-email">nguyenvana@email.com</td>
                        <td class="cell-phone">0901 234 567</td>
                        <td class="cell-fullname">Nguyễn Văn A</td>
                        <td class="cell-create">06/10/2024</td>
                        <td class="cell-action">
                            <button class="edit btn" id="edit-modal-btn">Sửa</button>
                            <button class="delete btn">Khoá</button>
                        </td>
                    </tr>
                    <tr class="accounts">
                        <td class="cell-tick"><input type="checkbox" class="row-checkbox"/></td>
                        <td class="cell-id">1002</td>
                        <td class="cell-email">yurichangirl752@gmail.com</td>
                        <td class="cell-phone">0901 772 7861</td>
                        <td class="cell-fullname">Đỗ Hoàng Ngọc Ánh</td>
                        <td class="cell-create">03/08/2019</td>
                        <td class="cell-action">
                            <button class="edit btn" id="edit-modal-btn2">Sửa</button>
                            <button class="delete btn">Khoá</button>
                        </td>
                    </tr>
                    <tr class="accounts">
                        <td class="cell-tick"><input type="checkbox" class="row-checkbox"/></td>
                        <td class="cell-id">1003</td>
                        <td class="cell-email">minh.quan.dev@gmail.com</td>
                        <td class="cell-phone">0912 345 678</td>
                        <td class="cell-fullname">Đỗ Minh Quan</td>
                        <td class="cell-create">15/08/2019</td>
                        <td class="cell-action">
                            <button class="edit btn" id="edit-modal-btn3">Sửa</button>
                            <button class="delete btn">Khoá</button>
                        </td>
                    </tr>

                    <tr class="accounts">
                        <td class="cell-tick"><input type="checkbox" class="row-checkbox"/></td>
                        <td class="cell-id">1004</td>
                        <td class="cell-email">thanh.huong99@yahoo.com</td>
                        <td class="cell-phone">0988 123 999</td>
                        <td class="cell-fullname">Nguyễn Thanh Hương</td>
                        <td class="cell-create">20/09/2019</td>
                        <td class="cell-action">
                            <button class="edit btn" id="edit-modal-btn4">Sửa</button>
                            <button class="delete btn">Khoá</button>
                        </td>
                    </tr>

                    <tr class="accounts locked">
                        <td class="cell-tick"><input type="checkbox" class="row-checkbox"/></td>
                        <td class="cell-id">1005</td>
                        <td class="cell-email">bao.gia.it@outlook.com</td>
                        <td class="cell-phone">0355 789 123</td>
                        <td class="cell-fullname">Đỗ Gia Bảo</td>
                        <td class="cell-create">05/01/2020</td>
                        <td class="cell-action">
                            <button class="edit btn" id="edit-modal-btn5">Sửa</button>
                            <button class="delete btn">Mở</button>
                        </td>
                    </tr>

                    <tr class="accounts">
                        <td class="cell-tick"><input type="checkbox" class="row-checkbox"/></td>
                        <td class="cell-id">1006</td>
                        <td class="cell-email">hoang.yen.design@gmail.com</td>
                        <td class="cell-phone">0909 555 321</td>
                        <td class="cell-fullname">Hoàng Như Yến</td>
                        <td class="cell-create">14/02/2020</td>
                        <td class="cell-action">
                            <button class="edit btn" id="edit-modal-btn6">Sửa</button>
                            <button class="delete btn">Khoá</button>
                        </td>
                    </tr>

                    <tr class="accounts">
                        <td class="cell-tick"><input type="checkbox" class="row-checkbox"/></td>
                        <td class="cell-id">1007</td>
                        <td class="cell-email">kaito.kid1412@gmail.com</td>
                        <td class="cell-phone">0933 444 555</td>
                        <td class="cell-fullname">Lê Công Chiến</td>
                        <td class="cell-create">30/04/2020</td>
                        <td class="cell-action">
                            <button class="edit btn" id="edit-modal-btn7">Sửa</button>
                            <button class="delete btn">Khoá</button>
                        </td>
                    </tr>

                    <tr class="accounts locked">
                        <td class="cell-tick"><input type="checkbox" class="row-checkbox"/></td>
                        <td class="cell-id">1008</td>
                        <td class="cell-email">mai.anh.dao@hotmail.com</td>
                        <td class="cell-phone">0866 777 888</td>
                        <td class="cell-fullname">Đào Thị Mai Anh</td>
                        <td class="cell-create">10/10/2021</td>
                        <td class="cell-action">
                            <button class="edit btn" id="edit-modal-btn8">Sửa</button>
                            <button class="delete btn">Mở</button>
                        </td>
                    </tr>

                    <tr class="accounts">
                        <td class="cell-tick"><input type="checkbox" class="row-checkbox"/></td>
                        <td class="cell-id">1009</td>
                        <td class="cell-email">tuan.hung.biz@gmail.com</td>
                        <td class="cell-phone">0914 567 890</td>
                        <td class="cell-fullname">Trần Tuấn Hùng</td>
                        <td class="cell-create">01/01/2022</td>
                        <td class="cell-action">
                            <button class="edit btn" id="edit-modal-btn9">Sửa</button>
                            <button class="delete btn">Khoá</button>
                        </td>
                    </tr>

                    <tr class="accounts">
                        <td class="cell-tick"><input type="checkbox" class="row-checkbox"/></td>
                        <td class="cell-id">1010</td>
                        <td class="cell-email">ngoc.han.hr@company.vn</td>
                        <td class="cell-phone">0977 111 222</td>
                        <td class="cell-fullname">Nguyễn Ngọc Hân</td>
                        <td class="cell-create">15/05/2022</td>
                        <td class="cell-action">
                            <button class="edit btn" id="edit-modal-btn10">Sửa</button>
                            <button class="delete btn">Khoá</button>
                        </td>
                    </tr>

                    <tr class="accounts">
                        <td class="cell-tick"><input type="checkbox" class="row-checkbox"/></td>
                        <td class="cell-id">1011</td>
                        <td class="cell-email">duy.manh.coder@gmail.com</td>
                        <td class="cell-phone">0344 999 000</td>
                        <td class="cell-fullname">Hoàng Duy Mạnh</td>
                        <td class="cell-create">20/08/2023</td>
                        <td class="cell-action">
                            <button class="edit btn" id="edit-modal-btn11">Sửa</button>
                            <button class="delete btn">Khoá</button>
                        </td>
                    </tr>

                    <tr class="accounts locked">
                        <td class="cell-tick"><input type="checkbox" class="row-checkbox"/></td>
                        <td class="cell-id">1012</td>
                        <td class="cell-email">linh.dan.mkt@gmail.com</td>
                        <td class="cell-phone">0905 123 456</td>
                        <td class="cell-fullname">Nguyễn Linh Đan</td>
                        <td class="cell-create">02/09/2023</td>
                        <td class="cell-action">
                            <button class="edit btn" id="edit-modal-btn12">Sửa</button>
                            <button class="delete btn">Mở</button>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </main>
    </div>
</div>

<div class="modal-overlay" id="add-account-modal">
    <div class="modal-content">
        <form id="add-form">
            <div class="username-input">
                <label for="username" class="label-with-icon">
                    <ion-icon name="person-outline"></ion-icon>
                    Tài Khoản</label>
                <input type="text" id="username" name="username" placeholder="Nhập Email" required>
            </div>
            <div class="password-input">
                <label for="password" class="label-with-icon">
                    <ion-icon name="lock-closed-outline"></ion-icon>
                    Mật Khẩu</label>
                <input type="text" id="password" name="password" placeholder="Nhập mật khẩu" required>
            </div>
            <div class="group-button-action section">
                <button type="button" class="cancel element-button" id="close-modal-btn">Huỷ</button>
                <button type="submit" class="add-btn element-button">Thêm</button>
            </div>
        </form>
    </div>
</div>
<div class="modal-overlay-excel" id="excel-account-modal">
    <div class="modal-content-excel">
        <p>Thành công xuất ra file Excel</p>
        <button class="modal-close2" id="close-modal-btn5">
            <ion-icon name="close-outline"></ion-icon>
        </button>
    </div>
</div>
<div class="modal-overlay-deleteAll" id="deleteAll-account-modal">
    <div class="modal-content-deleteAll">
        <div class="group-text-deleteAll">
            <p class="p-deleteAll1">Bạn có chắc chắn muốn khoá toàn bộ tài khoản của các ô được chọn?</p>
            <p class="p-deleteAll2">
                <ion-icon name="warning-outline" class="icon-warning"></ion-icon>
                Có thể hoàn tác hành động này
            </p>
        </div>
        <div class="group-button-action delete-all">
            <button type="button" class="element-button" id="close-modal-btn6">Huỷ</button>
            <button type="submit" class="deleteAll-button">Khoá Tất Cả</button>
        </div>
    </div>
</div>
<div class="modal-overlay-edit_information" id="edit_information-account-modal">
    <div class="modal-content-edit_information">
        <h2>Bảng thông tin</h2>
        <div class="edit-information-account">
            <div class="userId-section">
                <label for="id">ID:</label>
                <input type="text" id="id" name="id" value="1001" placeholder="ID hiện không có" disabled>
            </div>
            <div class="email-section">
                <label for="email">Email</label>
                <input type="text" id="email" name="email" value="nguyenvana@email.com" placeholder="Chưa có Email"
                       required>
            </div>
            <div class="fullname-section">
                <label for="fullname">Tên Đầy Đủ</label>
                <input type="text" id="fullname" name="fullname" value="Nguyễn Văn A" placeholder="Chưa có tên"
                       required>
            </div>
            <div class="birth-section">
                <label for="birth">Thời Gian Sinh</label>
                <input type="date" id="birth" name="birth" value="2002-12-02" placeholder="Chưa có ngày sinh" required>
            </div>
            <div class="username-section">
                <label for="username_">Tên Đăng Nhập</label>
                <input type="text" id="username_" name="username_" placeholder="Chưa có tên đăng nhập">
            </div>
            <div class="phone-section">
                <label for="phone-number">Số Điện Thoại</label>
                <input type="tel" id="phone-number" name="phone-number" value="0901 234 567"
                       placeholder="Chưa có số điện thoại" required>
            </div>
            <div class="active-section">
                <label for="activeSelect">Đang hoạt động:</label>
                <select id="activeSelect" required>
                    <option value="yes">Có</option>
                    <option value="no">Không</option>
                </select>
            </div>
            <div class="create_account-section">
                <label for="create-account">Ngày tạo</label>
                <input type="date" id="create-account" name="create-account" value="2024-10-06" disabled>
            </div>
        </div>
        <div class="group-button-action section">
            <button type="button" class="cancel element-button" id="close-modal-btn7">Huỷ</button>
            <button type="submit" class="fix-btn element-button">Sửa</button>
        </div>
    </div>
</div>
<div class="modal-overlay-edit_information" id="edit_information-account-modal-2">
    <div class="modal-content-edit_information">
        <h2>Bảng thông tin</h2>
        <div class="edit-information-account">
            <div class="userId-section">
                <label>ID:</label>
                <input type="text" name="id" value="1002" disabled>
            </div>
            <div class="email-section">
                <label>Email</label>
                <input type="text" name="email" value="yurichangirl752@gmail.com">
            </div>
            <div class="fullname-section">
                <label for="fullname">Tên Đầy Đủ</label>
                <input type="text" name="fullname" value="Đỗ Hoàng Ngọc Ánh" placeholder="Chưa có tên" required>
            </div>
            <div class="birth-section">
                <label for="birth">Thời Gian Sinh</label>
                <input type="date" name="birth" value="2005-10-03" placeholder="Chưa có ngày sinh" required>
            </div>
            <div class="username-section">
                <label>Tên Đăng Nhập</label>
                <input type="text" name="username_" value="jukisyuri">
            </div>
            <div class="phone-section">
                <label>Số Điện Thoại</label>
                <input type="tel" name="phone-number" value="0901 772 7861">
            </div>
            <div class="active-section">
                <label>Đang hoạt động:</label>
                <select>
                    <option value="yes" selected>Có</option>
                    <option value="no">Không</option>
                </select>
            </div>
            <div class="create_account-section">
                <label>Ngày tạo</label>
                <input type="date" name="create-account" value="2019-08-03" disabled>
            </div>
        </div>
        <div class="group-button-action section">
            <button type="button" class="cancel element-button" id="close-modal-btn-2">Huỷ</button>
            <button type="submit" class="fix-btn element-button">Sửa</button>
        </div>
    </div>
</div>
<div class="modal-overlay-edit_information" id="edit_information-account-modal-3">
    <div class="modal-content-edit_information">
        <h2>Bảng thông tin</h2>
        <div class="edit-information-account">
            <div class="userId-section">
                <label>ID:</label>
                <input type="text" name="id" value="1003" disabled>
            </div>
            <div class="email-section">
                <label>Email</label>
                <input type="text" name="email" value="minh.quan.dev@gmail.com">
            </div>
            <div class="fullname-section">
                <label for="fullname">Tên Đầy Đủ</label>
                <input type="text" name="fullname" value="Đỗ Minh Quan" placeholder="Chưa có tên" required>
            </div>
            <div class="birth-section">
                <label for="birth">Thời Gian Sinh</label>
                <input type="date" name="birth" value="2000-12-04" placeholder="Chưa có ngày sinh" required>
            </div>
            <div class="username-section">
                <label>Tên Đăng Nhập</label>
                <input type="text" name="username_" value="minh_quan_dev">
            </div>
            <div class="phone-section">
                <label>Số Điện Thoại</label>
                <input type="tel" name="phone-number" value="0912 345 678">
            </div>
            <div class="active-section">
                <label>Đang hoạt động:</label>
                <select>
                    <option value="yes" selected>Có</option>
                    <option value="no">Không</option>
                </select>
            </div>
            <div class="create_account-section">
                <label>Ngày tạo</label>
                <input type="date" name="create-account" value="2019-08-15" disabled>
            </div>
        </div>
        <div class="group-button-action section">
            <button type="button" class="cancel element-button" id="close-modal-btn-3">Huỷ</button>
            <button type="submit" class="fix-btn element-button">Sửa</button>
        </div>
    </div>
</div>

<div class="modal-overlay-edit_information" id="edit_information-account-modal-4">
    <div class="modal-content-edit_information">
        <h2>Bảng thông tin</h2>
        <div class="edit-information-account">
            <div class="userId-section">
                <label>ID:</label>
                <input type="text" name="id" value="1004" disabled>
            </div>
            <div class="email-section">
                <label>Email</label>
                <input type="text" name="email" value="thanh.huong99@yahoo.com">
            </div>
            <div class="fullname-section">
                <label for="fullname">Tên Đầy Đủ</label>
                <input type="text" name="fullname" value="Nguyễn Thanh Hương" placeholder="Chưa có tên" required>
            </div>
            <div class="birth-section">
                <label for="birth">Thời Gian Sinh</label>
                <input type="date" name="birth" value="2005-01-03" placeholder="Chưa có ngày sinh" required>
            </div>
            <div class="username-section">
                <label>Tên Đăng Nhập</label>
                <input type="text" name="username_" value="huong_thanh_99">
            </div>
            <div class="phone-section">
                <label>Số Điện Thoại</label>
                <input type="tel" name="phone-number" value="0988 123 999">
            </div>
            <div class="active-section">
                <label>Đang hoạt động:</label>
                <select>
                    <option value="yes" selected>Có</option>
                    <option value="no">Không</option>
                </select>
            </div>
            <div class="create_account-section">
                <label>Ngày tạo</label>
                <input type="date" name="create-account" value="2019-09-20" disabled>
            </div>
        </div>
        <div class="group-button-action section">
            <button type="button" class="cancel element-button" id="close-modal-btn-4">Huỷ</button>
            <button type="submit" class="fix-btn element-button">Sửa</button>
        </div>
    </div>
</div>

<div class="modal-overlay-edit_information" id="edit_information-account-modal-5">
    <div class="modal-content-edit_information">
        <h2>Bảng thông tin</h2>
        <div class="edit-information-account">
            <div class="userId-section">
                <label>ID:</label>
                <input type="text" name="id" value="1005" disabled>
            </div>
            <div class="email-section">
                <label>Email</label>
                <input type="text" name="email" value="bao.gia.it@outlook.com">
            </div>
            <div class="fullname-section">
                <label for="fullname">Tên Đầy Đủ</label>
                <input type="text" name="fullname" value="Đỗ Gia Bảo" placeholder="Chưa có tên" required>
            </div>
            <div class="birth-section">
                <label for="birth">Thời Gian Sinh</label>
                <input type="date" name="birth" value="2001-09-05" placeholder="Chưa có ngày sinh" required>
            </div>
            <div class="username-section">
                <label>Tên Đăng Nhập</label>
                <input type="text" name="username_" value="baogia_coder">
            </div>
            <div class="phone-section">
                <label>Số Điện Thoại</label>
                <input type="tel" name="phone-number" value="0355 789 123">
            </div>
            <div class="active-section">
                <label>Đang hoạt động:</label>
                <select>
                    <option value="yes">Có</option>
                    <option value="no" selected>Không</option>
                </select>
            </div>
            <div class="create_account-section">
                <label>Ngày tạo</label>
                <input type="date" name="create-account" value="2020-01-05" disabled>
            </div>
        </div>
        <div class="group-button-action section">
            <button type="button" class="cancel element-button" id="close-modal-btn-5">Huỷ</button>
            <button type="submit" class="fix-btn element-button">Sửa</button>
        </div>
    </div>
</div>

<div class="modal-overlay-edit_information" id="edit_information-account-modal-6">
    <div class="modal-content-edit_information">
        <h2>Bảng thông tin</h2>
        <div class="edit-information-account">
            <div class="userId-section">
                <label>ID:</label>
                <input type="text" name="id" value="1006" disabled>
            </div>
            <div class="email-section">
                <label>Email</label>
                <input type="text" name="email" value="hoang.yen.design@gmail.com">
            </div>
            <div class="fullname-section">
                <label for="fullname">Tên Đầy Đủ</label>
                <input type="text" name="fullname" value="Hoàng Như Yến" placeholder="Chưa có tên" required>
            </div>
            <div class="birth-section">
                <label for="birth">Thời Gian Sinh</label>
                <input type="date" name="birth" value="2005-01-03" placeholder="Chưa có ngày sinh" required>
            </div>
            <div class="username-section">
                <label>Tên Đăng Nhập</label>
                <input type="text" name="username_" value="hoangyen_ds">
            </div>
            <div class="phone-section">
                <label>Số Điện Thoại</label>
                <input type="tel" name="phone-number" value="0909 555 321">
            </div>
            <div class="active-section">
                <label>Đang hoạt động:</label>
                <select>
                    <option value="yes" selected>Có</option>
                    <option value="no">Không</option>
                </select>
            </div>
            <div class="create_account-section">
                <label>Ngày tạo</label>
                <input type="date" name="create-account" value="2020-02-14" disabled>
            </div>
        </div>
        <div class="group-button-action section">
            <button type="button" class="cancel element-button" id="close-modal-btn-6">Huỷ</button>
            <button type="submit" class="fix-btn element-button">Sửa</button>
        </div>
    </div>
</div>

<div class="modal-overlay-edit_information" id="edit_information-account-modal-7">
    <div class="modal-content-edit_information">
        <h2>Bảng thông tin</h2>
        <div class="edit-information-account">
            <div class="userId-section">
                <label>ID:</label>
                <input type="text" name="id" value="1007" disabled>
            </div>
            <div class="email-section">
                <label>Email</label>
                <input type="text" name="email" value="kaito.kid1412@gmail.com">
            </div>
            <div class="fullname-section">
                <label for="fullname">Tên Đầy Đủ</label>
                <input type="text" name="fullname" value="Lê Công Chiến" placeholder="Chưa có tên" required>
            </div>
            <div class="birth-section">
                <label for="birth">Thời Gian Sinh</label>
                <input type="date" name="birth" value="2003-09-03" placeholder="Chưa có ngày sinh" required>
            </div>
            <div class="username-section">
                <label>Tên Đăng Nhập</label>
                <input type="text" name="username_" value="kaitokid_thief">
            </div>
            <div class="phone-section">
                <label>Số Điện Thoại</label>
                <input type="tel" name="phone-number" value="0933 444 555">
            </div>
            <div class="active-section">
                <label>Đang hoạt động:</label>
                <select>
                    <option value="yes" selected>Có</option>
                    <option value="no">Không</option>
                </select>
            </div>
            <div class="create_account-section">
                <label>Ngày tạo</label>
                <input type="date" name="create-account" value="2020-04-30" disabled>
            </div>
        </div>
        <div class="group-button-action section">
            <button type="button" class="cancel element-button" id="close-modal-btn-7">Huỷ</button>
            <button type="submit" class="fix-btn element-button">Sửa</button>
        </div>
    </div>
</div>

<div class="modal-overlay-edit_information" id="edit_information-account-modal-8">
    <div class="modal-content-edit_information">
        <h2>Bảng thông tin</h2>
        <div class="edit-information-account">
            <div class="userId-section">
                <label>ID:</label>
                <input type="text" name="id" value="1008" disabled>
            </div>
            <div class="email-section">
                <label>Email</label>
                <input type="text" name="email" value="mai.anh.dao@hotmail.com">
            </div>
            <div class="fullname-section">
                <label for="fullname">Tên Đầy Đủ</label>
                <input type="text" name="fullname" value="Đào Thị Mai Anh" placeholder="Chưa có tên" required>
            </div>
            <div class="birth-section">
                <label for="birth">Thời Gian Sinh</label>
                <input type="date" name="birth" value="2006-05-27" placeholder="Chưa có ngày sinh" required>
            </div>
            <div class="username-section">
                <label>Tên Đăng Nhập</label>
                <input type="text" name="username_" value="cherry_blossom">
            </div>
            <div class="phone-section">
                <label>Số Điện Thoại</label>
                <input type="tel" name="phone-number" value="0866 777 888">
            </div>
            <div class="active-section">
                <label>Đang hoạt động:</label>
                <select>
                    <option value="yes">Có</option>
                    <option value="no" selected>Không</option>
                </select>
            </div>
            <div class="create_account-section">
                <label>Ngày tạo</label>
                <input type="date" name="create-account" value="2021-10-10" disabled>
            </div>
        </div>
        <div class="group-button-action section">
            <button type="button" class="cancel element-button" id="close-modal-btn-8">Huỷ</button>
            <button type="submit" class="fix-btn element-button">Sửa</button>
        </div>
    </div>
</div>

<div class="modal-overlay-edit_information" id="edit_information-account-modal-9">
    <div class="modal-content-edit_information">
        <h2>Bảng thông tin</h2>
        <div class="edit-information-account">
            <div class="userId-section">
                <label>ID:</label>
                <input type="text" name="id" value="1009" disabled>
            </div>
            <div class="email-section">
                <label>Email</label>
                <input type="text" name="email" value="tuan.hung.biz@gmail.com">
            </div>
            <div class="fullname-section">
                <label for="fullname">Tên Đầy Đủ</label>
                <input type="text" name="fullname" value="Trần Tuấn Hùng" placeholder="Chưa có tên" required>
            </div>
            <div class="birth-section">
                <label for="birth">Thời Gian Sinh</label>
                <input type="date" name="birth" value="2004-10-03" placeholder="Chưa có ngày sinh" required>
            </div>
            <div class="username-section">
                <label>Tên Đăng Nhập</label>
                <input type="text" name="username_" value="tuanhung_boss">
            </div>
            <div class="phone-section">
                <label>Số Điện Thoại</label>
                <input type="tel" name="phone-number" value="0914 567 890">
            </div>
            <div class="active-section">
                <label>Đang hoạt động:</label>
                <select>
                    <option value="yes" selected>Có</option>
                    <option value="no">Không</option>
                </select>
            </div>
            <div class="create_account-section">
                <label>Ngày tạo</label>
                <input type="date" name="create-account" value="2022-01-01" disabled>
            </div>
        </div>
        <div class="group-button-action section">
            <button type="button" class="cancel element-button" id="close-modal-btn-9">Huỷ</button>
            <button type="submit" class="fix-btn element-button">Sửa</button>
        </div>
    </div>
</div>

<div class="modal-overlay-edit_information" id="edit_information-account-modal-10">
    <div class="modal-content-edit_information">
        <h2>Bảng thông tin</h2>
        <div class="edit-information-account">
            <div class="userId-section">
                <label>ID:</label>
                <input type="text" name="id" value="1010" disabled>
            </div>
            <div class="email-section">
                <label>Email</label>
                <input type="text" name="email" value="ngoc.han.hr@company.vn">
            </div>
            <div class="fullname-section">
                <label for="fullname">Tên Đầy Đủ</label>
                <input type="text" name="fullname" value="Nguyễn Ngọc Hân" placeholder="Chưa có tên" required>
            </div>
            <div class="birth-section">
                <label for="birth">Thời Gian Sinh</label>
                <input type="date" name="birth" value="2005-2-09" placeholder="Chưa có ngày sinh" required>
            </div>
            <div class="username-section">
                <label>Tên Đăng Nhập</label>
                <input type="text" name="username_" value="ngochan_hr">
            </div>
            <div class="phone-section">
                <label>Số Điện Thoại</label>
                <input type="tel" name="phone-number" value="0977 111 222">
            </div>
            <div class="active-section">
                <label>Đang hoạt động:</label>
                <select>
                    <option value="yes" selected>Có</option>
                    <option value="no">Không</option>
                </select>
            </div>
            <div class="create_account-section">
                <label>Ngày tạo</label>
                <input type="date" name="create-account" value="2022-05-15" disabled>
            </div>
        </div>
        <div class="group-button-action section">
            <button type="button" class="cancel element-button" id="close-modal-btn-10">Huỷ</button>
            <button type="submit" class="fix-btn element-button">Sửa</button>
        </div>
    </div>
</div>

<div class="modal-overlay-edit_information" id="edit_information-account-modal-11">
    <div class="modal-content-edit_information">
        <h2>Bảng thông tin</h2>
        <div class="edit-information-account">
            <div class="userId-section">
                <label>ID:</label>
                <input type="text" name="id" value="1011" disabled>
            </div>
            <div class="email-section">
                <label>Email</label>
                <input type="text" name="email" value="duy.manh.coder@gmail.com">
            </div>
            <div class="fullname-section">
                <label for="fullname">Tên Đầy Đủ</label>
                <input type="text" name="fullname" value="Hoàng Duy Mạnh" placeholder="Chưa có tên" required>
            </div>
            <div class="birth-section">
                <label for="birth">Thời Gian Sinh</label>
                <input type="date" name="birth" value="2005-12-03" placeholder="Chưa có ngày sinh" required>
            </div>
            <div class="username-section">
                <label>Tên Đăng Nhập</label>
                <input type="text" name="username_" value="duymanh_fullstack">
            </div>
            <div class="phone-section">
                <label>Số Điện Thoại</label>
                <input type="tel" name="phone-number" value="0344 999 000">
            </div>
            <div class="active-section">
                <label>Đang hoạt động:</label>
                <select>
                    <option value="yes" selected>Có</option>
                    <option value="no">Không</option>
                </select>
            </div>
            <div class="create_account-section">
                <label>Ngày tạo</label>
                <input type="date" name="create-account" value="2023-08-20" disabled>
            </div>
        </div>
        <div class="group-button-action section">
            <button type="button" class="cancel element-button" id="close-modal-btn-11">Huỷ</button>
            <button type="submit" class="fix-btn element-button">Sửa</button>
        </div>
    </div>
</div>

<div class="modal-overlay-edit_information" id="edit_information-account-modal-12">
    <div class="modal-content-edit_information">
        <h2>Bảng thông tin</h2>
        <div class="edit-information-account">
            <div class="userId-section">
                <label>ID:</label>
                <input type="text" name="id" value="1012" disabled>
            </div>
            <div class="email-section">
                <label>Email</label>
                <input type="text" name="email" value="linh.dan.mkt@gmail.com">
            </div>
            <div class="fullname-section">
                <label for="fullname">Tên Đầy Đủ</label>
                <input type="text" name="fullname" value="Nguyễn Linh Đan" placeholder="Chưa có tên" required>
            </div>
            <div class="birth-section">
                <label for="birth">Thời Gian Sinh</label>
                <input type="date" name="birth" value="2005-10-09" placeholder="Chưa có ngày sinh" required>
            </div>
            <div class="username-section">
                <label>Tên Đăng Nhập</label>
                <input type="text" name="username_" value="linhdan_marketing">
            </div>
            <div class="phone-section">
                <label>Số Điện Thoại</label>
                <input type="tel" name="phone-number" value="0905 123 456">
            </div>
            <div class="active-section">
                <label>Đang hoạt động:</label>
                <select>
                    <option value="yes">Có</option>
                    <option value="no" selected>Không</option>
                </select>
            </div>
            <div class="create_account-section">
                <label>Ngày tạo</label>
                <input type="date" name="create-account" value="2023-09-02" disabled>
            </div>
        </div>
        <div class="group-button-action section">
            <button type="button" class="cancel element-button" id="close-modal-btn-12">Huỷ</button>
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
<script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
<link href="https://fonts.googleapis.com/css2?family=Philosopher&display=swap" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="https://cdn.datatables.net/2.3.4/css/dataTables.dataTables.css"/>
<script src="https://cdn.datatables.net/2.3.4/js/dataTables.js"></script>
<script src="${pageContext.request.contextPath}/popup.js"></script>
<script>
    // Run Pop-up function
    document.addEventListener("DOMContentLoaded", function () {
        setupModal('add-account-modal', 'open-modal-btn', 'close-modal-btn');
        setupModal('excel-account-modal', 'excel-modal-btn', 'close-modal-btn5');
        setupModal('deleteAll-account-modal', 'deleteAll-modal-btn', 'close-modal-btn6');
        setupModal('edit_information-account-modal', 'edit-modal-btn', 'close-modal-btn7');
        setupModal('edit_information-account-modal-2', 'edit-modal-btn2', 'close-modal-btn-2');
        setupModal('edit_information-account-modal-3', 'edit-modal-btn3', 'close-modal-btn-3');
        setupModal('edit_information-account-modal-4', 'edit-modal-btn4', 'close-modal-btn-4');
        setupModal('edit_information-account-modal-5', 'edit-modal-btn5', 'close-modal-btn-5');
        setupModal('edit_information-account-modal-6', 'edit-modal-btn6', 'close-modal-btn-6');
        setupModal('edit_information-account-modal-7', 'edit-modal-btn7', 'close-modal-btn-7');
        setupModal('edit_information-account-modal-8', 'edit-modal-btn8', 'close-modal-btn-8');
        setupModal('edit_information-account-modal-9', 'edit-modal-btn9', 'close-modal-btn-9');
        setupModal('edit_information-account-modal-10', 'edit-modal-btn10', 'close-modal-btn-10');
        setupModal('edit_information-account-modal-11', 'edit-modal-btn11', 'close-modal-btn-11');
        setupModal('edit_information-account-modal-12', 'edit-modal-btn12', 'close-modal-btn-12');
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