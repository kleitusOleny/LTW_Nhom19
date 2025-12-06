<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <title>Register</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/AuthPages/auth_css/Register.css">
</head>
<body>
<div class="register-page">
    <h2>Đăng Kí</h2>
    <p>(* là trường bắt buộc)</p>
    <form id="register-form">
        <div class="fullname form-group">
            <label for="name">Họ và Tên *</label>
            <input type="text" id="name" name="name" placeholder="Nhập đầy đủ họ và tên của bạn" required>
        </div>

        <div class="username-full form-row">
            <div class="email-class form-group">
                <label for="email">Email *</label>
                <input type="text" id="email" name="email" placeholder="Nhập vào định dạng Email" required>
            </div>
            <div class="username-class form-group">
                <label for="username">Tên Đăng Nhập</label>
                <input type="text" id="username" name="username" placeholder="Nhập vào định dạng tên bạn muốn">
            </div>
        </div>

        <div class="password form-group">
            <label for="password">Mật Khẩu *</label>
            <input type="password" id="password" name="password" placeholder="Nhập mật khẩu dựa theo quy tắc được nêu"
                   required>
        </div>

        <div class="reminder">
            <div class="remind-item">
                <input type="checkbox" id="remind-words" name="remind-words" disabled>
                <label for="remind-words">Mật khẩu phải ít nhất 8 kí tự</label>
            </div>
            <div class="remind-item">
                <input type="checkbox" id="remind-uppercase" name="remind-uppercase" disabled>
                <label for="remind-uppercase">Mật khẩu phải bao gồm chữ hoa và chữ thường</label>
            </div>
            <div class="remind-item">
                <input type="checkbox" id="remind-special" name="remind-special" disabled>
                <label for="remind-special">Mật khẩu phải bao gồm kí tự đặc biệt</label>
            </div>
        </div>

        <div class="confirm-password form-group">
            <label for="confirm-password">Nhập lại Mật Khẩu *</label>
            <input type="password" id="confirm-password" name="confirm-password"
                   placeholder="Nhập lại mật khẩu để xác nhận" required>
        </div>

        <div class="reminder confirm">
            <div class="remind-item">
                <input type="checkbox" id="remind-confirm" name="remind-lowercase" disabled>
                <label for="remind-confirm">Mật khẩu nhập trùng khớp</label>
            </div>
        </div>
        <div class="phone-number form-group">
            <label for="phone-number">Số Điện Thoại *</label>
            <input type="tel" id="phone-number" name="phone-number" placeholder="Nhập số điện thoại của bạn" required>
        </div>
        <div class="birth form-group">
            <label for="birth">Chọn Ngày Sinh *</label>
            <input type="date" id="birth" name="birth" lang="vi" required>
        </div>

        <!--        <div class="address-row">-->
        <!--            <div class="form-group">-->
        <!--                <label for="street">Số nhà & đường: *</label>-->
        <!--                <input type="text" id="street" name="street" required>-->
        <!--            </div>-->
        <!--            <div class="form-group">-->
        <!--                <label for="ward">Phường/Xã: *</label>-->
        <!--                <input type="text" id="ward" name="ward" required>-->
        <!--            </div>-->
        <!--            <div class="form-group">-->
        <!--                <label for="district">Quận/Huyện: *</label>-->
        <!--                <input type="text" id="district" name="district" required>-->
        <!--            </div>-->
        <!--            <div class="form-group">-->
        <!--                <label for="city">Tỉnh/Thành phố: *</label>-->
        <!--                <input type="text" id="city" name="city" required>-->
        <!--            </div>-->
        <!--        </div>-->

        <div class="confirm-age">
            <input type="checkbox" id="age-confirm" class="checkbox">
            <label for="age-confirm">Xác nhận bạn đã đủ 18 tuổi</label>
        </div>

        <div class="confirm-license">
            <input type="checkbox" id="license-confirm" class="checkbox license">
            <label for="license-confirm">Xác nhận bạn sẽ tuân thủ chính sách</label>
        </div>
        <button type="submit">Đăng Kí</button>
        <a href="Login.jsp" id="backward">Quay Lại Trang Trước</a>
    </form>
</div>
</body>
</html>