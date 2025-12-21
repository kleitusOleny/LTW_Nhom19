<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <title>Login</title>
    <script src='${pageContext.request.contextPath}/popup.js'></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/AuthPages/auth_css/Login.css">
    <script src="https://accounts.google.com/gsi/client" async defer></script>
</head>
<body>
<div class="main-container">
    <div class="backward-button-container">
        <button class="question" id="btn-question">
            <ion-icon name="help-outline"></ion-icon>
        </button>
    </div>
    <div class="login-page">
        <h2>Đăng Nhập</h2>
        <form id="login-form" action="${pageContext.request.contextPath}/NormalLogin" method="POST">
            <div class="username-input">
                <label for="username" class="label-with-icon">
                    <ion-icon name="person-outline"></ion-icon>
                    Tài Khoản</label>
                <input type="text" id="username" name="username" placeholder="Nhập tài khoản hoặc email hiện có"
                       required>
            </div>

            <div class="password-input">
                <label for="password" class="label-with-icon">
                    <ion-icon name="lock-closed-outline"></ion-icon>
                    Mật Khẩu</label>
                <div class="input-wrapper">
                    <input type="password" id="password" name="password" placeholder="Nhập mật khẩu hiện có" required>
                    <span id="eyeIcon">
                    <ion-icon name="eye-off-outline"></ion-icon>
                </span>
                </div>
            </div>

            <div class="remember-me-input">
                <input type="checkbox" id="remember-me" name="remember-me">
                <label for="remember-me">Ghi nhớ đăng nhập</label>
                <a href="Authentication.jsp">Quên Mật Khẩu</a>
            </div>
            <button>Đăng Nhập</button>
            <div class="register-account">
                <div id="register-remind">Chưa có tài khoản?</div>
                <a href="Register.jsp">Đăng Kí</a>
            </div>
<%--         Đăng nhập bằng google --%>
            <div class="social-login">
                <div id="social-remind">Chọn phương thức khác để đăng nhập:</div>
                <div id="g_id_onload"
                     data-client_id="561993862196-rspl5j67m79f0857je2sdrv8f75m2ijs.apps.googleusercontent.com"
                     data-login_uri="${pageContext.request.contextPath}/LoginGoogle"
                     data-scope="https://www.googleapis.com/auth/user.birthday.read"
                     data-auto_prompt="false">
                </div>
                <div class="g_id_signin"
                     data-type="standard"
                     data-size="large"
                     data-theme="outline"
                     data-text="sign_in_with"
                     data-shape="rectangular"
                     data-logo_alignment="left">
                </div>
            </div>
            <a href="../index.jsp" id="backward">Quay Lại Trang Trước</a>
        </form>
    </div>
</div>
<div class="modal-overlay-question" id="question-account-modal">
    <div class="modal-content-question">
        <h2>Vì sao cần đăng nhập?</h2>
        <div class="group-p">
            <p>
                <ion-icon name="shield-checkmark-outline"></ion-icon>
                Theo quy định về kinh doanh đồ uống có cồn, chúng tôi cần xác minh người mua đã đủ độ tuổi hợp pháp.
            </p>
            <p>
                <ion-icon name="shield-checkmark-outline"></ion-icon>
                Việc đăng nhập cũng giúp bảo mật thông tin đơn hàng, thêm khuyến mãi cho cá nhân và đảm bảo quyền lợi
                tốt nhất cho bạn trong quá trình vận chuyển.
            </p>
        </div>
        <button id="close-btn">Đã rõ</button>
    </div>
</div>
<script>
    setupModal('question-account-modal', 'btn-question', 'close-btn')
    let eyeClosed = document.getElementById('eyeIcon').querySelector('ion-icon');
    let passwordReveal = document.getElementById('password');

    eyeClosed.onclick = () => {
        if (passwordReveal.type === 'password') {
            passwordReveal.type = 'text';
            eyeClosed.setAttribute('name', 'eye-outline');
        } else {
            passwordReveal.type = 'password';
            eyeClosed.setAttribute('name', 'eye-off-outline');
        }
    }
</script>
<script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
<script>
    const urlParams = new URLSearchParams(window.location.search);
    const errorCode = urlParams.get('loginError')
    const errorMessages = {
        '1': "Đăng nhập Google thất bại",
        '2': "Sai thông tin đăng nhập",
        '3': "Thiếu thông tin đăng nhập"
    }
    if (errorCode && errorMessages[errorCode]) {
        alert(errorMessages[errorCode])
        window.history.replaceState(null, '', window.location.pathname);
    }
</script>
</body>
</html>