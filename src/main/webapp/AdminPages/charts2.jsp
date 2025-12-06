<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <title>Thống Kê 2</title>
    <script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
    <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
    <script src="${pageContext.request.contextPath}/popup.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/AdminPages/admin_css/chart2.css">
</head>
<body>
<div class="dashboard-container">
    <nav class="dashboard-sidebar">
        <ul class="sidebar-items">
            <div class="group-avatar">
                <img src="${pageContext.request.contextPath}/assets/avatar.jpg" class="user-avatar" id="avatar-modal-btn"/>
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
            <li><a href="charts.jsp" class="a-with-icon selected">
                <ion-icon name="stats-chart"></ion-icon>
                Thống Kê</a></li>
        </ul>
        <div class="text">━ Được update tới 2025 ━</div>
    </nav>
    <div class="dashboard-content">
        <main class="dashboard-main-content">
            <h1>Tổng quan thống kê về sản phẩm</h1>
            <div class="group-chart4">
                <h2>Doanh thu theo tháng</h2>
                <div class="total-revenue">
                    <h5>Tổng doanh thu:</h5>
                    <h5 class="number">2679 triệu vnđ</h5>
                </div>
                <div id="chart-revenue"></div>
            </div>
            <div class="group-chart">
                <h2>Số lượng sản phẩm đã bán và tồn đọng</h2>
                <div id="chart"></div>
            </div>
            <div class="group-chart2">
                <h2>Top 5 sản phẩm bán chạy nhất trong tháng</h2>
                <div id="chart2"></div>
            </div>
            <div class="group-chart3">
                <h2>Sản phẩm được yêu thích nhất theo tháng</h2>
                <div id="chart-column"></div>
            </div>
            <div class="group-switch">
                <a href="charts.jsp">
                    <button class="unselected-btn">1</button>
                </a>
                <a href="charts2.html">
                    <button class="selected-btn">2</button>
                </a>
                <div class="group-p">
                    <p id="p1">Bạn hiện đang ở</p>
                    <p id="p2">Trang 2</p>
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
    var options4 = {
        series: [{
            name: 'Doanh Thu',
            type: 'column',
            data: [550, 947, 930, 564, 957, 807, 700, 760, 577]
        }, {
            name: 'Tỉ lệ so với tháng trước',
            type: 'line',
            data: [0, 72.18, -1.8, -39.35, 69.68, -15.67, -13.26, 8.57, -24.08]
        }],
        chart: {
            height: 350,
            type: 'line',
        },
        stroke: {
            width: [0, 4]
        },
        dataLabels: {
            enabled: true,
            enabledOnSeries: [1],
            formatter: function (val) {
                return val + "%"
            }
        },
        labels: ['Tháng 1', 'Tháng 2', 'Tháng 3', 'Tháng 4', 'Tháng 5', 'Tháng 6', 'Tháng 7', 'Tháng 8', 'Tháng 9'],
        yaxis: [{
            title: {
                text: 'Doanh Thu',
                style: {
                    fontSize: '12px',
                    fontWeight: 'bold',
                    fontFamily: 'Mulish, sans-serif, serif',
                    color: '#333'
                }
            },
        }, {
            opposite: true,
            title: {
                text: 'Tỉ lệ',
                style: {
                    fontSize: '12px',
                    fontWeight: 'bold',
                    fontFamily: 'Mulish, sans-serif, serif',
                    color: '#333'
                }
            },
        }],
        tooltip: {
            y: {
                formatter: function (val, {seriesIndex}) {
                    // seriesIndex là biến xác định dòng dữ liệu
                    if (seriesIndex === 0) {
                        return val + " triệu vnđ";
                    }
                    if (seriesIndex === 1) {
                        return val + "%";
                    }
                    return val;
                }
            }
        }
    };

    var chart4 = new ApexCharts(document.querySelector("#chart-revenue"), options4);
    chart4.render();
    /* ---- */
    var options = {
        series: [{
            name: 'Đã bán',
            data: [108, 79, 94, 54, 66, 128, 101, 77, 86]
        }, {
            name: 'Tồn đọng',
            data: [11, 32, 45, 73, 34, 52, 67, 98, 70]
        }],
        chart: {
            height: 350,
            type: 'area'
        },
        dataLabels: {
            enabled: false
        },
        colors: ['#31f631', '#0c74e7'],
        stroke: {
            curve: 'smooth'
        },
        xaxis: {
            categories: ['Tháng 1', 'Tháng 2', 'Tháng 3', 'Tháng 4', 'Tháng 5', 'Tháng 6', 'Tháng 7', 'Tháng 8', 'Tháng 9']
        },
        yaxis: {
            title: {
                text: 'Số lượng',
                style: {
                    fontSize: '12px',
                    fontWeight: 'bold',
                    fontFamily: 'Mulish, sans-serif, serif',
                    color: '#333'
                }
            }
        },
        tooltip: {
            y: {
                formatter: function (val) {
                    return val + " sản phẩm";
                }
            }
        }
    };

    var chart = new ApexCharts(document.querySelector("#chart"), options);
    chart.render();
    // -------
    var options2 = {
        series: [{
            name: 'Rượu Vang Trắng Greywacke Pinot Noir 2022',
            data: [44, 55, 41, 67, 0, 43, 0, 49, 68]
        }, {
            name: 'Rượu vang sủi Freixenet Italian Rosé Sparkling Wine',
            data: [13, 23, 20, 0, 0, 27, 33, 12, 0]
        }, {
            name: 'Rượu vang hồng Dufouleur Monopole',
            data: [11, 17, 0, 15, 24, 0, 0, 0, 34]
        }, {
            name: 'Rượu vang hồng Famille Perrin Côtes-du-Rhône Réserve',
            data: [20, 17, 15, 0, 21, 0, 15, 60, 0]
        }, {
            name: 'Rượu vang hồng Studio By Miraval',
            data: [28, 30, 0, 19, 36, 19, 18, 35, 0]
        }, {
            name: 'Rượu Sâm Panh Champagne Ruinart Rosé',
            data: [0, 0, 19, 20, 60, 23, 48, 41, 25]
        }, {
            name: 'Rượu vang hồng Flor de Muga Rosé',
            data: [0, 0, 19, 49, 60, 23, 48, 0, 64]
        }, {
            name: 'Rượu Vang Hồng Tenuta Ammiraglia Alìe',
            data: [0, 0, 0, 0, 0, 0, 0, 0, 57]
        }],
        chart: {
            type: 'bar',
            height: 350,
            stacked: true,
            stackType: '100%'
        },
        colors: [
            '#c247ff', '#838386', '#2ed573', '#ffa502', '#3742fa', '#ff6b81', '#70a1ff', '#7bed9f', '#04ffae', '#ffd32a'
        ],
        responsive: [{
            breakpoint: 480,
            options: {
                legend: {
                    position: 'bottom',
                    offsetX: -10,
                    offsetY: 0
                }
            }
        }],
        xaxis: {
            categories: ['Tháng 1', 'Tháng 2', 'Tháng 3', 'Tháng 4', 'Tháng 5', 'Tháng 6',
                'Tháng 7', 'Tháng 8', 'Tháng 9'
            ],
        },
        fill: {
            opacity: 1
        },
        legend: {
            position: 'bottom',
            offsetX: 0,
            offsetY: 10
        },
        yaxis: {
            title: {
                text: 'Số lượng',
                style: {
                    fontSize: '12px',
                    fontWeight: 'bold',
                    fontFamily: 'Mulish, sans-serif, serif',
                    color: '#333'
                }
            }
        },
        tooltip: {
            y: {
                formatter: function (val) {
                    return val + " đã bán";
                }
            }
        }
    };

    var chart2 = new ApexCharts(document.querySelector("#chart2"), options2);
    chart2.render();

    /* ---- */
    var wineNames = ["Rượu Vang Đỏ Luce Brunello Di Montalcino 2017", "Rượu Vang Đỏ Sandrone Barolo Le Vigne – 1.5L 2014", "Rượu Vang Đỏ Muga Prado Enea Gran Reserva 2014", "Rượu Vang Trắng Greywacke Pinot Noir 2022", "Rượu vang sủi Freixenet Italian Rosé Sparkling Wine Extra Dry", "Rượu vang hồng Dufouleur Monopole", "Rượu vang hồng Famille Perrin Côtes-du-Rhône Réserve, rose", "Rượu Sâm Panh Champagne Ruinart Rosé", "Rượu vang hồng Flor de Muga Rosé"];
    var options3 = {
        series: [{
            name: 'Loại',
            data: [23, 31, 40, 101, 40, 36, 32, 41, 65]
        }],
        chart: {
            height: 350,
            type: 'bar'
        },
        plotOptions: {
            bar: {
                borderRadius: 2,
                dataLabels: {
                    position: 'top', // top, center, bottom
                },
            }
        },
        dataLabels: {
            enabled: true,
            formatter: function (val, opts) {
                return val + ' lượt thích';
            },
            offsetY: -22,
            style: {
                fontSize: '13px',
                colors: ["#3b2d7c"]
            }
        },

        xaxis: {
            categories: ["Tháng 1", "Tháng 2", "Tháng 3", "Tháng 4", "Tháng 5", "Tháng 6", "Tháng 7", "Tháng 8", "Tháng 9"],
            position: 'top',
            axisBorder: {
                show: false
            },
            axisTicks: {
                show: false
            },
            crosshairs: {
                fill: {
                    type: 'gradient',
                    gradient: {
                        colorFrom: '#D8E3F0',
                        colorTo: '#BED1E6',
                        stops: [0, 100],
                        opacityFrom: 0.4,
                        opacityTo: 0.5,
                    }
                }
            },
        },
        tooltip: {
            enabled: true,
            theme: 'light',
            style: {
                fontSize: '12px',
            },
            y: {
                formatter: function (val, {dataPointIndex}) {
                    var wineName = wineNames[dataPointIndex];
                    return wineName + ' ' + "(" + val + " lượt)";
                },
                title: {
                    formatter: (seriesName) => seriesName + ":",
                }
            },
            fixed: {
                enabled: false,
                position: 'topRight'
            }
        },
        yaxis: {
            title: {
                text: 'Lượt thích',
                style: {
                    fontSize: '12px',
                    fontWeight: 'bold',
                    fontFamily: 'Mulish, sans-serif, serif',
                    color: '#333'
                }
            },
            axisBorder: {
                show: false
            },
            axisTicks: {
                show: false,
            },
        },
    };

    var chart3 = new ApexCharts(document.querySelector("#chart-column"), options3);
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