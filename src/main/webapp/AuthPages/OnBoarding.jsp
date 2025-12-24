<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <title>OnBoarding</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/AuthPages/auth_css/OnBoarding.css">
</head>
<body>
<div class="register-page">
    <h2>Tiếp Tục Đăng Kí Với Google</h2>
    <p>(* là trường bắt buộc)</p>
    <form id="register-form" action="${pageContext.request.contextPath}/OnBoardingController" method="POST">
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
    <div class="group-confirm">
        <div class="confirm-age">
            <input type="checkbox" id="age-confirm" class="checkbox">
            <label for="age-confirm">Xác nhận bạn đã đủ 18 tuổi</label>
        </div>
        <div class="confirm-license">
            <input type="checkbox" id="license-confirm" class="checkbox license">
            <label for="license-confirm">Xác nhận bạn sẽ tuân thủ chính sách</label>
        </div>
    </div>
    <button type="submit">Xác Nhận</button>
    <a href="Login.jsp" id="backward">Quay Lại Trang Trước</a>
    </form>
</div>
<script src="${pageContext.request.contextPath}/preventspace.js"></script>
<script>
    const listFields = ['#username, #phone-number, #birth'];
    preventspace(listFields)

    const onBoardingForm = document.getElementById('register-form');

    onBoardingForm.addEventListener('submit', function(event) {
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
