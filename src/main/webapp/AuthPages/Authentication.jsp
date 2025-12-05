<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <title>Authentication</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/AuthPages/auth_css/Authentication.css">
</head>
<body>
<div class="forgot-password-container">
    <h2>Xác Thực</h2>
    <form id="forgot-password-form">
        <div class="email-class form-group">
            <label for="email" class="label-with-icon">
                <ion-icon name="mail-outline"></ion-icon>
                Email</label>
            <input type="email" id="email" name="email" placeholder="Nhập Email để lấy mã xác thực" required>
        </div>
        <div class="verify form-group">
            <div class="verify-title">
                <label for="verify-code" class="label-with-icon">
                    <ion-icon name="chatbox-ellipses-outline"></ion-icon>
                    Mã xác thực</label>
                <input type="text" id="verify-code" name="verify-code" placeholder="Nhập mã xác thực đã gửi" required>
            </div>
            <ion-icon name="refresh-outline" id="refresh"></ion-icon>
        </div>
        <div id="remind" hidden="hidden">Bạn phải chờ thêm 1 phút để có thể tiếp tục lấy mã</div>
        <button class="get-verify-code">Lấy mã xác thực</button>
        <button class="submit" type="button" onclick="window.location.href='ForgotPassword.html'">
            Đồng ý
        </button>
        <a href="Login.jsp" id="backward">Quay Lại Trang Trước</a>
    </form>
</div>
<script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
</body>
</html>