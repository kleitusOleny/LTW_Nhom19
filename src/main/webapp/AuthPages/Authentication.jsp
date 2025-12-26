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
    <form id="forgot-password-form" action="${pageContext.request.contextPath}/AuthenticationController" method="POST">
        <input type="hidden" name="action" id="form-action" value="">
        <div class="email-class form-group">
            <div class="container-mail">
                <label for="email" class="label-with-icon">
                    <ion-icon name="mail-outline"></ion-icon>
                    Email</label>
                <input type="email" id="email" name="email" placeholder="Nhập Email để lấy mã xác thực"
                       value="${otpEmail != null ? otpEmail : param.email}"
                       class="${not empty emailError ? 'input-error' : ''}" required>
            </div>
            <div class="group-message">
                <c:if test="${not empty emailError}">
                    <span class="error-msg">${emailError}</span>
                </c:if>
                <c:if test="${not empty message}">
                    <span style="color: green; font-size: 0.85em;">${message}</span>
                </c:if>
            </div>
        </div>
        <div class="verify form-group">
            <div class="verify-title">
                <label for="verify-code" class="label-with-icon">
                    <ion-icon name="chatbox-ellipses-outline"></ion-icon>
                    Mã xác thực</label>
                <input type="text" id="verify-code" name="otpInput" placeholder="Nhập mã xác thực đã gửi" required>
            </div>
            <c:if test="${not empty otpError}">
                <span class="error-msg">${otpError}</span>
            </c:if>
        </div>
        <div class="group-remind">
            <p id="remind">Bạn phải chờ thêm 1 phút để có thể tiếp tục lấy mã</p>
            <div class="group-button-verify">
                <button class="get-verify-code" onclick="setAction('send-otp')" formnovalidate>Lấy mã xác thực</button>
                <button class="submit" type="submit" onclick="setAction('finish-otp')">Đồng ý</button>
            </div>
        </div>
        <a href="Login.jsp" id="backward">Quay Lại Trang Trước</a>
    </form>
</div>
<script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
<script src="${pageContext.request.contextPath}/preventspace.js"></script>
<script>
    function setAction(actionName) {
        document.getElementById('form-action').value = actionName;
    }

    const listFields = ['#email', '#verify-code'];
    preventspace(listFields)
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