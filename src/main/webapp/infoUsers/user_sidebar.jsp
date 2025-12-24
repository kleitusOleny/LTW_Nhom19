<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Tài khoản người dùng</title>
            <link rel="stylesheet" href="<%= request.getContextPath() %>/css/user_sidebar_style.css">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
        </head>

        <body>
            <%@ include file="../components/header.jsp" %>
                <main>
                    <div class="container">
                        <div class="left-sidebar">
                            <div class="user-info">
                                <img src="https://i.pinimg.com/1200x/44/80/45/448045692c52f8e84fdad5ccc69f1939.jpg"
                                    alt="User Avatar">
                                <span>${user.fullName}</span>
                            </div>
                            <hr>
                            <ul class="nav-menu">
                                <li><a href="info_user.jsp" data-url="<%= request.getContextPath() %>/user"><i
                                            class="fa-solid fa-user"></i> <span data-lang-key="userInfo">Thông
                                            tin</span></a></li>
                                <li><a href="addresses.jsp" data-url="<%= request.getContextPath() %>/address"><i
                                            class="fa-solid fa-location-dot"></i> <span data-lang-key="address">Địa
                                            chỉ</span></a></li>
                                <li><a href="favorites.jsp" data-url="<%= request.getContextPath() %>/user"><i
                                            class="fa-solid fa-heart"></i> <span data-lang-key="viewHistory">Yêu
                                            thích</span></a></li>
                                <li><a href="my_orders.jsp" data-url="<%= request.getContextPath() %>/user"><i
                                            class="fa-solid fa-box"></i> <span data-lang-key="myOrders">Đơn
                                            hàng của tôi</span></a></li>
                                <li><a href="review_history.jsp" data-url="<%= request.getContextPath() %>/user"><i
                                            class="fa-solid fa-star"></i> <span data-lang-key="reviewHistory">Lịch
                                            sử đánh giá</span></a></li>
                                <hr>
                                <li><a href="settings.jsp" data-url="<%= request.getContextPath() %>/user"><i
                                            class="fa-solid fa-gear"></i> <span data-lang-key="settings">Cài
                                            đặt</span></a></li>
                                <li><a href="support.jsp"><i class="fa-solid fa-circle-question"></i> <span
                                            data-lang-key="support">Hỗ trợ</span></a></li>
                                <hr>
                                <li>
                                    <button type="button" class="logout-button">
                                        <i class="fa-solid fa-right-from-bracket"></i>
                                        <span data-lang-key="logout">Đăng xuất</span>
                                    </button>
                                </li>
                            </ul>
                        </div>
                        <div id="main-content"></div>
                    </div>
                </main>
                <%@ include file="../components/footer.jsp" %>


                    <script>
                        document.addEventListener('DOMContentLoaded', function () {
                            const mainContent = document.getElementById('main-content');
                            const navLinks = document.querySelectorAll('.nav-menu a');

                            const loadContent = (url) => {
                                fetch(url, {
                                    headers: {
                                        'X-Requested-With': 'XMLHttpRequest'
                                    }
                                })
                                    .then(response => response.text())
                                    .then(html => {
                                        mainContent.innerHTML = html;
                                        const scripts = mainContent.querySelectorAll("script");
                                        scripts.forEach(script => {
                                            const newScript = document.createElement("script");
                                            newScript.textContent = script.textContent;
                                            script.parentNode.replaceChild(newScript, script);
                                        });
                                    })
                                    .catch(error => {
                                        mainContent.innerHTML = '<p>Error loading page.</p>';
                                        console.error('Error:', error);
                                    });
                            };
                            navLinks.forEach(link => {
                                link.addEventListener('click', function (event) {
                                    event.preventDefault();

                                    const pageUrl = this.getAttribute('href');

                                    navLinks.forEach(l => l.parentElement.classList.remove('active'));
                                    this.parentElement.classList.add('active');

                                    window.location.hash = pageUrl;

                                    loadContent(pageUrl);
                                });
                            });
                            const defaultPage = '<%= request.getContextPath() %>/user';
                            const hashPage = location.hash.replace('#', '');
                            if (hashPage) {
                                if (hashPage.startsWith('/')) {
                                    loadContent(hashPage);
                                    navLinks.forEach(link => {
                                        if (link.getAttribute('href') === hashPage) {
                                            link.parentElement.classList.add('active');
                                        }
                                    });
                                } else {
                                    loadContent(hashPage);
                                    navLinks.forEach(link => {
                                        if (link.getAttribute('href') === hashPage) {
                                            link.parentElement.classList.add('active');
                                        }
                                    });
                                }
                            } else {
                                loadContent(defaultPage);
                                if (navLinks.length > 0) {
                                    navLinks[0].parentElement.classList.add('active');
                                }
                            }
                            const logout = document.querySelector('.logout-button');
                            logout.addEventListener('click', function () {
                                if (confirm('Bạn có chắc chắn muốn đăng xuất')) {
                                    alert("Đăng xuất thành công")
                                }
                            })
                        });
                    </script>
        </body>

        </html>