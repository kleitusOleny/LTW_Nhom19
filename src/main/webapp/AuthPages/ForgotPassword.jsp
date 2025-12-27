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
    <form id="forgot-password-form" action="${pageContext.request.contextPath}/forgotpassword" method="POST">
        <div class="email-class form-group">
            <label for="password" class="label-with-icon">
                <ion-icon name="lock-closed-outline"></ion-icon>
                Nhập mật khẩu mới</label>
            <input type="password" id="password" name="password" placeholder="Nhập mật khẩu mới"
                   class="${not empty passwordError ? 'input-error' : ''}" required>
            <span class="error-msg">${passwordError}</span>
        </div>
        <div class="verify form-group">
            <div class="verify-title">
                <label for="confirm-password" class="label-with-icon">
                    <ion-icon name="checkbox-outline"></ion-icon>
                    </ion-icon>Xác nhận mật khẩu mới</label>
                <input type="password" id="confirm-password" name="confirm-password" placeholder="Nhập lại mật khẩu mới"
                       class="${not empty confirmedPasswordError ? 'input-error' : ''}" required>
                <span class="error-msg">${confirmedPasswordError}</span>
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
<script src="${pageContext.request.contextPath}/preventspace.js"></script>
<script>
    const passwordInput = document.getElementById('password');
    const confirmInput = document.getElementById('confirm-password');

    // Các checkbox hiển thị trạng thái
    const remindWords = document.getElementById('remind-words');
    const remindUppercase = document.getElementById('remind-uppercase');
    const remindSpecial = document.getElementById('remind-special');
    const remindConfirm = document.getElementById('remind-confirm');

    const listPreventSpace = ['#password, #confirm-password'];
    preventspace(listPreventSpace);

    function validateWords() {
        const value = passwordInput.value;
        remindWords.checked = value.length >= 8;
        const hasUpper = /[A-Z]/.test(value);
        const hasLower = /[a-z]/.test(value);
        remindUppercase.checked = hasUpper && hasLower;
        remindSpecial.checked = /[!@#$%^&*(),.?":{}|<>]/.test(value);
        validateConfirm();
    }

    function validateConfirm() {
        const passValue = passwordInput.value;
        const confirmValue = confirmInput.value;
        remindConfirm.checked = passValue.length > 0 && passValue === confirmValue;
    }

    passwordInput.addEventListener('input', validateWords);
    confirmInput.addEventListener('input', validateConfirm);
</script>
<style>
    .error-msg {
        color: red;
        font-size: 0.85em;
        font-style: italic;
        margin-top: -5px;
        display: block;
    }
    input.input-error {
        border: 1px solid red;
    }
</style>
</body>
</html>