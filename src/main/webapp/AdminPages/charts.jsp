<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <title>Thống Kê</title>
    <script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
    <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
    <script src="${pageContext.request.contextPath}/popup.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/AdminPages/admin_css/charts.css">
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
            <li><a href="manage_accounts.jsp" class="a-with-icon">
                <ion-icon name="people-outline"></ion-icon>
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
            <li><a href="charts.html" class="a-with-icon selected">
                <ion-icon name="stats-chart"></ion-icon>
                Thống Kê</a></li>
        </ul>
        <div class="text">━ Được update tới 2025 ━</div>
    </nav>
    <div class="dashboard-content">
        <main class="dashboard-main-content">
            <h1>Tổng quan thống kê về người dùng</h1>
            <div class="group">
                <div class="stat chart-customers-live">
                    <h2>Phân bố người mua</h2>
                    <div id="chart"></div>
                </div>
                <div class="sub-group">
                    <div class="stat chart-accounts">
                        <h2>Số lượng tài khoản đăng nhập trang web</h2>
                        <div id="chart-line1"></div>
                    </div>
                    <div class="stat chart-delivery">
                        <h2>Trạng thái đơn hàng</h2>
                        <div id="chart-pie"></div>
                    </div>
                </div>
            </div>
            <div class="group-switch">
                <a href="charts.html">
                    <button class="selected-btn">1</button>
                </a>
                <a href="charts2.jsp">
                    <button class="unselected-btn">2</button>
                </a>
                <div class="group-p">
                    <p id="p1">Bạn hiện đang ở</p>
                    <p id="p2">Trang 1</p>
                </div>
            </div>
        </main>
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

<script>
    var options2 = {
        series: [120, 65, 47],
        chart: {
            width: 380,
            type: 'pie',
        },
        labels: ['Xác Nhận', 'Đang Giao Hàng', 'Hoàn Thành'],
        colors: ['#992ce1', '#2c80e1', '#2ec72e'],
        responsive: [{
            breakpoint: 480,
            options: {
                chart: {
                    width: 200
                },
                legend: {
                    position: 'bottom'
                }
            }
        }],
        tooltip: {
            y: {
                formatter: function (val) {
                    return "Số lượng " + val
                }
            }
        }
    };

    var chart = new ApexCharts(document.querySelector("#chart-pie"), options2);
    chart.render();
    // --------
    var options = {
        series: [{
            name: 'Đã bán',
            data: [20, 30, 48, 68, 42, 32, 26, 54, 67]
        }],
        chart: {
            type: 'bar',
            height: 350
        },
        plotOptions: {
            bar: {
                borderRadius: 4,
                borderRadiusApplication: 'end',
                horizontal: true,
            }
        },
        dataLabels: {
            enabled: false
        },
        xaxis: {
            categories: [
                'Thanh Hoá', 'Kiên Giang', 'Tiền Giang', 'Tây Ninh', 'Đắk Lắk', 'Thừa Thiên Huế', 'Đà Nẵng', 'Hà Nội', 'TPHCM'
            ],
        },
        tooltip: {
            y: {
                formatter: function (val) {
                    return val + " khách mua"
                }
            }
        }
    };

    var chart2 = new ApexCharts(document.querySelector("#chart"), options);
    chart2.render();
    // ---------
    var optionsLine2 = {
        series: [{
            name: "Tài Khoản",
            data: [45, 69, 42, 82, 91, 57, 71, 77, 101]
        }],
        xaxis: {
            categories: ['Tháng 1', 'Tháng 2', 'Tháng 3', 'Tháng 4', 'Tháng 5', 'Tháng 6', 'Tháng 7', 'Tháng 8', 'Tháng 9']
        },
        chart: {
            id: 'tw',
            type: 'line',
            height: 160
        },
        colors: ['#367379']
    };

    var chartLine2 = new ApexCharts(document.querySelector("#chart-line1"), optionsLine2);
    chartLine2.render();

    // ---
    var options3 = {
        series: [
            {
                name: "Đã bán",
                data: [28, 29, 33, 36, 32, 32, 33, 50, 43, 56, 41, 58]
            },
            {
                name: "Tồn đọng",
                data: [12, 11, 14, 18, 17, 13, 13, 200, 157, 101, 60, 21]
            }
        ],
        chart: {
            height: 350,
            type: 'line',
            dropShadow: {
                enabled: true,
                color: '#000',
                top: 18,
                left: 7,
                blur: 10,
                opacity: 0.5
            },
            zoom: {
                enabled: false
            },
            toolbar: {
                show: false
            }
        },
        colors: ['#18c70a', '#2c80e1'],
        dataLabels: {
            enabled: true,
        },
        stroke: {
            curve: 'smooth'
        },
        grid: {
            borderColor: '#e7e7e7',
            row: {
                colors: ['#f3f3f3', 'transparent'],
                opacity: 0.5
            },
        },
        markers: {
            size: 1
        },
        xaxis: {
            categories:
                ['Tháng 1', 'Tháng 2', 'Tháng 3', 'Tháng 4', 'Tháng 5', 'Tháng 6', 'Tháng 7', 'Tháng 8', 'Tháng 9', 'Tháng 10', 'Tháng 11', 'Tháng 12'],
        },
        legend: {
            position: 'top',
            horizontalAlign: 'right',
            floating: true,
            offsetY: -25,
            offsetX: -5
        },
    };

    var chart3 = new ApexCharts(document.querySelector("#chart-line2"), options3);
    chart3.render();
</script>
<script>
    // Run Pop-up function
    document.addEventListener("DOMContentLoaded", function () {
        setupModal('notification-account-modal', 'notification-modal-btn', 'close-modal-btn8');
        setupModal('avatar-account-modal', 'avatar-modal-btn', 'close-modal-btn9');
    });
</script>
</body>
</html>