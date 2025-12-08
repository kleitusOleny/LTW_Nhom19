<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết đơn hàng</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../css/store_style.css">
    <link rel="stylesheet" href="../css/detail_order_style.css">
</head>
<header class="site-header">
    <div class="header-top">
        <div class="container">
            <div class="header-logo">
                <a href="../index.html" class="logo">LOGO</a>
            </div>

            <div class="header-center">
                <form class="search-form" action="#" method="get">
                    <input type="text" name="search" placeholder="Tìm kiếm sản phẩm...">
                    <button type="submit" aria-label="Search">
                        <i class="fas fa-search"></i>
                    </button>
                </form>
            </div>

            <div class="header-right">
                <a href="#" aria-label="Account">
                    <i class="fas fa-user"></i>
                </a>
                <a href="../Cart.html" class="cart-link" aria-label="Cart">
                    <i class="fa-solid fa-cart-shopping"></i>
                    <span class="cart-count">0</span>
                </a>
            </div>
        </div>
    </div>
    <div class="header-nav-bar">
        <div class="container">
            <nav class="header-nav">
                <ul>
                    <li><a href="../index.html">Trang Chủ</a></li>
                    <li class="has-dropdown">
                        <a href="../store.html">
                            Rượu Vang
                            <i class="fa-solid fa-caret-down"></i>
                        </a>
                        <div class="mega-menu">
                            <div class="mega-menu-grid">
                                <div class="mega-menu-column">
                                    <h4 class="mega-menu-title">Theo Loại Vang</h4>
                                    <ul class="mega-menu-list">
                                        <li><a href="../store.html" class="mega-menu-link">Rượu Vang Đỏ</a></li>
                                        <li><a href="../store.html" class="mega-menu-link">Rượu Vang Trắng</a></li>
                                        <li><a href="../store.html" class="mega-menu-link">Rượu Vang Hồng</a></li>
                                        <li><a href="../store.html" class="mega-menu-link">Sâm Panh / Vang Nổ</a></li>
                                        <li><a href="../store.html" class="mega-menu-link">Rượu Vang Ngọt</a></li>
                                        <li><a href="../store.html" class="mega-menu-link">Cognac & Rượu Mạnh</a></li>
                                    </ul>
                                </div>

                                <div class="mega-menu-column">
                                    <h4 class="mega-menu-title">Nhãn Hàng Nổi Bật</h4>
                                    <ul class="mega-menu-list">
                                        <li><a href="#" class="mega-menu-link">CHÂTEAU CORBIN</a></li>
                                        <li><a href="#" class="mega-menu-link">TENUTA LUCE</a></li>
                                        <li><a href="#" class="mega-menu-link">MAISON LOUIS LATOUR</a></li>
                                        <li><a href="#" class="mega-menu-link">Domaine Faiveley</a></li>
                                        <li><a href="#" class="mega-menu-link">BODEGAS MUGA</a></li>
                                        <li><a href="#" class="mega-menu-link">CHAMPAGNE RUINART</a></li>
                                    </ul>
                                </div>

                                <div class="mega-menu-column">
                                    <h4 class="mega-menu-title">Theo Tag</h4>
                                    <ul class="mega-menu-list">
                                        <li><a href="#" class="mega-menu-link">Giá Đặc Biệt (gcc)</a></li>
                                        <li><a href="#" class="mega-menu-link">Bộ Sưu Tập Giá Tốt</a></li>
                                        <li><a href="#" class="mega-menu-link">Vang Hồng Giá Tốt</a></li>
                                        <li><a href="#" class="mega-menu-link">Bộ Sưu Tập</a></li>
                                    </ul>
                                </div>

                                <div class="mega-menu-column">
                                    <h4 class="mega-menu-title">Theo Vùng Nổi Bật</h4>
                                    <ul class="mega-menu-list">
                                        <li><a href="#" class="mega-menu-link">Bordeaux (Pháp)</a></li>
                                        <li><a href="#" class="mega-menu-link">Tuscany (Ý)</a></li>
                                        <li><a href="#" class="mega-menu-link">Napa Valley (Mỹ)</a></li>
                                        <li><a href="#" class="mega-menu-link">Champagne (Pháp)</a></li>
                                        <li><a href="#" class="mega-menu-link">Rioja (Tây Ban Nha)</a></li>
                                        <li><a href="#" class="mega-menu-link">Marlborough (New Zealand)</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </li>
                    <li><a href="../blog.jsp">Blog</a></li>
                    <li><a href="../about_us.jsp">About Us</a></li>
                </ul>
            </nav>
        </div>
    </div>
</header>
<body>

<div class="order-detail">
    <h1>Chi tiết đơn hàng #1001</h1>

    <div class="section info">
        <h2>Thông tin khách hàng</h2>
        <p><strong>Họ và tên:</strong> Nguyễn Văn A</p>
        <p><strong>Email:</strong> nguyenvan@example.com</p>
        <p><strong>Điện thoại:</strong> 0987654321</p>
        <p><strong>Địa chỉ:</strong> 123 Đường ABC, Quận 1, TP.HCM</p>
        <p><strong>Hình thức thanh toán:</strong> Thanh toán khi nhận hàng</p>
    </div>

    <div class="section">
        <h2>Sản phẩm</h2>
        <table>
            <thead>
            <tr>
                <th>Hình ảnh</th>
                <th>Sản phẩm</th>
                <th>Số lượng</th>
                <th>Đơn giá</th>
                <th>Tổng</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td><img class="product-img" src="../img/SKU__VD_0926-22.png" alt="Rượu vang đỏ"></td>
                <td>Rượu vang đỏ cao cấp</td>
                <td>2</td>
                <td>1.200.000₫</td>
                <td>2.400.000₫</td>
            </tr>
            <tr>
                <td><img class="product-img" src="../img/SKU__VD_0926-22.png" alt="Whisky cao cấp"></td>
                <td>Whisky cao cấp</td>
                <td>1</td>
                <td>1.500.000₫</td>
                <td>1.500.000₫</td>
            </tr>
            </tbody>
            <tfoot>
            <tr>
                <th colspan="4" style="text-align:right">Tổng cộng:</th>
                <th>3.900.000₫</th>
            </tr>
            </tfoot>
        </table>
    </div>

    <div class="section">
        <h2>Trạng thái đơn hàng</h2>
        <span class="status completed">Hoàn thành</span>

        <div class="tracking-bar">
            <div class="tracking-progress" style="width: 100%;"></div>
            <div class="tracking-step active">
                <div class="step-dot"></div>
                <div class="step-label">Đang xử lý</div>
            </div>
            <div class="tracking-step active">
                <div class="step-dot"></div>
                <div class="step-label">Đang giao</div>
            </div>
            <div class="tracking-step active">
                <div class="step-dot"></div>
                <div class="step-label">Đã giao</div>
            </div>
        </div>
    </div>

    <div class="actions">
        <button class="btn">Mua lại</button>
        <button class="btn" id="exportPDF">In hóa đơn</button>
    </div>
</div>
<footer class="site-footer">
    <div class="container">
        <div class="footer-grid">
            <div class="footer-column">
                <h4 class="footer-heading">Về Chúng Tôi</h4>
                <p class="footer-text">
                    Mô tả ngắn gọn về dự án của bạn.
                    Nội dung này giúp người dùng hiểu rõ hơn về mục đích của bạn.
                </p>
                <div class="footer-socials">
                    <a href="#" class="social-link" aria-label="Facebook">
                        <i class="fa-brands fa-facebook-f"></i>
                    </a>
                    <a href="#" class="social-link" aria-label="Instagram">
                        <i class="fa-brands fa-instagram"></i>
                    </a>
                    <a href="#" class="social-link" aria-label="Twitter">
                        <i class="fa-brands fa-x-twitter"></i>
                    </a>
                </div>
            </div>

            <div class="footer-column">
                <h4 class="footer-heading">Liên Kết Nhanh</h4>
                <ul class="footer-links">
                    <li><a href="#">Trang chủ</a></li>
                    <li><a href="#">Giới thiệu</a></li>
                    <li><a href="#">Dịch vụ</a></li>
                    <li><a href="#">Liên hệ</a></li>
                    <li><a href="#">Chính sách</a></li>
                </ul>
            </div>

            <div class="footer-column">
                <h4 class="footer-heading">Liên Hệ</h4>
                <ul class="footer-contact">
                    <li><strong>Địa chỉ:</strong> Khu Phố 6, P. Linh Trung, Q. Thủ Đức, TP.HCM</li>
                    <li><strong>Email:</strong> Olenydev@gmail.com</li>
                    <li><strong>Điện thoại:</strong> (+84) 1234 5678</li>
                </ul>
            </div>
        </div>

        <div class="footer-bottom">
            <p>&copy; 2025 Khoa Công Nghệ Thông Tin.</p>
        </div>
    </div>
</footer>
<script>
    document.getElementById("exportPDF").addEventListener("click", function () {

        const element = document.querySelector(".order-detail");

        const sections = document.querySelectorAll(".order-detail .section");
        const actions = document.querySelector(".order-detail .actions");

        let removedSection = null;
        if (sections[2]) {
            removedSection = sections[2];
            removedSection.style.display = "none";
        }

        let removedActions = null;
        if (actions) {
            removedActions = actions;
            removedActions.style.display = "none";
        }

        const opt = {
            margin: 10,
            filename: 'don-hang.pdf',
            image: {type: 'jpeg', quality: 0.98},
            html2canvas: {scale: 2, scrollY: 0},
            jsPDF: {unit: 'mm', format: 'a4', orientation: 'portrait'}
        };

        html2pdf().from(element).set(opt).save()
            .then(() => {
                if (removedSection) removedSection.style.display = "";
                if (removedActions) removedActions.style.display = "";
            });

    });


</script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"></script>
</body>
</html>
