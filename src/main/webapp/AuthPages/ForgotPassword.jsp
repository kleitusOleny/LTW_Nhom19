<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <title>Forgot Password</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/AuthPages/auth_css/ForgotPassword.css">
</head>
<body>
<div class="forgot-password-container">
    <h2>Quên Mật Khẩu</h2>
    <form id="forgot-password-form">
        <div class="email-class form-group">
            <label for="password" class="label-with-icon">
                <ion-icon name="lock-closed-outline"></ion-icon>
                Nhập mật khẩu mới</label>
            <input type="password" id="password" name="password" placeholder="Nhập mật khẩu mới" required>
        </div>
        <div class="verify form-group">
            <div class="verify-title">
                <label for="confirm-password" class="label-with-icon">
                    <ion-icon name="checkbox-outline"></ion-icon>
                    </ion-icon>Xác nhận mật khẩu mới</label>
                <input type="password" id="confirm-password" name="confirm-password" placeholder="Nhập lại mật khẩu mới"
                       required>
            </div>
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
            <div class="remind-item">
                <input type="checkbox" id="remind-confirm" name="remind-confirm" disabled>
                <label for="remind-confirm">Mật khẩu nhập đã trùng khớp</label>
            </div>
        </div>
        <button>Xác nhận</button>
    </form>
</div>
<script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
</body>
</html>