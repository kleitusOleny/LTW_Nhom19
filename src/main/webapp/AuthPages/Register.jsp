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
    <form id="register-form" action="${pageContext.request.contextPath}/RegisterController" method="POST">
        <div class="fullname form-group">
            <label for="name">Họ và Tên *</label>
            <input type="text" id="name" name="name"
                   placeholder="Nhập đầy đủ họ và tên của bạn"
                   value="${param.name}"
                   class="${not empty fullNameError ? 'input-error' : ''}" required>
            <span class="error-msg">${fullNameError}</span>
            <span class="error-msg">${fullNameError2}</span>
            <span class="error-msg">${fullNameError3}</span>
        </div>

        <div class="username-full form-row">
            <div class="email-class form-group">
                <label for="email">Email *</label>
                <input type="text" id="email" name="email"
                       placeholder="Nhập vào định dạng Email"
                       value="${param.email}"
                       class="${not empty emailError ? 'input-error' : ''}" required>
                <span class="error-msg">${emailError}</span>
                <span class="error-msg">${emailError2}</span>
            </div>
            <div class="username-class form-group">
                <label for="username">Tên Đăng Nhập</label>
                <input type="text" id="username" name="username"
                       placeholder="Nhập tên đăng nhập (tùy chọn)"
                       value="${param.username}"
                       class="${not empty usernameError ? 'input-error' : ''}">
                <span class="error-msg">${usernameError}</span>
                <div class="reminder">
                    <div class="remind-item">
                        <input type="checkbox" id="remind-username" name="remind-username" disabled>
                        <label for="remind-username">Tên tài khoản phải từ 4-30 kí tự</label>
                    </div>
                </div>
            </div>
        </div>

        <div class="password form-group">
            <label for="password">Mật Khẩu *</label>
            <input type="password" id="password" name="password"
                   placeholder="Nhập mật khẩu dựa theo quy tắc được nêu"
                   class="${not empty passwordError ? 'input-error' : ''}" required>
            <span class="error-msg">${passwordError}</span>
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
                   placeholder="Nhập lại mật khẩu để xác nhận"
                   class="${not empty confirmedPasswordError ? 'input-error' : ''}" required>
            <span class="error-msg">${confirmedPasswordError}</span>
        </div>

        <div class="reminder confirm">
            <div class="remind-item">
                <input type="checkbox" id="remind-confirm" name="remind-lowercase" disabled>
                <label for="remind-confirm">Mật khẩu nhập trùng khớp</label>
            </div>
        </div>
        <div class="phone-number form-group">
            <label for="phone-number">Số Điện Thoại *</label>
            <input type="tel" id="phone-number" name="phone-number"
                   placeholder="Nhập số điện thoại của bạn"
                   value="${param['phone-number']}"
                   class="${not empty phoneNumberError ? 'input-error' : ''}" required>
            <span class="error-msg">${phoneNumberError}</span>
        </div>
        <div class="birth form-group">
            <label for="birth">Chọn Ngày Sinh *</label>
            <input type="date" id="birth" name="birth" lang="vi"
                   value="${param.birth}"
                   class="${not empty birthError || not empty ageError ? 'input-error' : ''}" required>
            <span class="error-msg-birth">${birthError}</span>
            <span class="error-msg-birth">${ageError}</span>
        </div>
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
<script>
    const passwordInput = document.getElementById('password');
    const confirmInput = document.getElementById('confirm-password');
    const usernameInput = document.getElementById('username');

    // Các checkbox hiển thị trạng thái
    const remindWords = document.getElementById('remind-words');
    const remindUppercase = document.getElementById('remind-uppercase');
    const remindSpecial = document.getElementById('remind-special');
    const remindUsernameLength = document.getElementById('remind-username');
    const remindConfirm = document.getElementById('remind-confirm');

    const preventSpaceFields = document.querySelectorAll('#email, #username, #password, #confirm-password, #phone-number, #birth');
    preventSpaceFields.forEach(field => {
        // Chặn ngay khi nhấn phím
        field.addEventListener('keydown', function(e) {
            if (e.key === ' ') {
                e.preventDefault();
            }
        });

        // Xóa khoảng trắng nếu người dùng cố tình paste vào
        field.addEventListener('input', function() {
            this.value = this.value.replace(/\s/g, '');
        });
    });

    function validatePassword() {
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

    function validateUsername() {
        const usernameValue = usernameInput.value;
        remindUsernameLength.checked = usernameValue.length >= 4 && usernameValue.length <= 30;
    }
    passwordInput.addEventListener('input', validatePassword);
    confirmInput.addEventListener('input', validateConfirm);
    usernameInput.addEventListener('input', validateUsername);

    const registerForm = document.getElementById('register-form');

    registerForm.addEventListener('submit', function(event) {
        const ageChecked = document.getElementById('age-confirm').checked;
        const licenseChecked = document.getElementById('license-confirm').checked;

        if (!ageChecked || !licenseChecked) {
            event.preventDefault();
            alert("Bạn phải xác nhận đủ 18 tuổi và đồng ý với chính sách để tiếp tục.");
        }
    });
</script>
<style>
    .error-msg, .error-msg-birth {
        color: red;
        font-size: 0.85em;
        font-style: italic;
        margin-top: -5px;
        display: block;
    }
    .error-msg-birth {
        margin-top: -8px;
    }
    input.input-error {
        border: 1px solid red;
    }
</style>
</body>
</html>