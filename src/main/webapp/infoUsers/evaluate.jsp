<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đánh giá nhanh đơn hàng</title>

    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../css/store_style.css">
    <link rel="stylesheet" href="../css/evalute_style.css">
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
                                        <li><a href="#" class="mega-menu-link">Rượu Vang Trắng</a></li>
                                        <li><a href="#" class="mega-menu-link">Rượu Vang Hồng</a></li>
                                        <li><a href="#" class="mega-menu-link">Sâm Panh / Vang Nổ</a></li>
                                        <li><a href="#" class="mega-menu-link">Rượu Vang Ngọt</a></li>
                                        <li><a href="#" class="mega-menu-link">Cognac & Rượu Mạnh</a></li>
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
<div class="review-container">
    <h1>Đánh giá nhanh đơn hàng #1001</h1>

    <div class="product-review">
        <img src="../img/SKU__VD_0939.png" alt="Rượu vang đỏ cao cấp">
        <div class="review-content">
            <h3>Rượu vang đỏ cao cấp</h3>
            <div class="stars" data-rating="0">
                <i class="fa-regular fa-star" data-value="1"></i>
                <i class="fa-regular fa-star" data-value="2"></i>
                <i class="fa-regular fa-star" data-value="3"></i>
                <i class="fa-regular fa-star" data-value="4"></i>
                <i class="fa-regular fa-star" data-value="5"></i>
            </div>
            <textarea placeholder="Viết cảm nhận của bạn..."></textarea>
            <button>Gửi đánh giá</button>
        </div>
    </div>

    <div class="product-review">
        <img src="../img/SKU__VD_0939.png" alt="Whisky cao cấp">
        <div class="review-content">
            <h3>Whisky cao cấp</h3>
            <div class="stars" data-rating="0">
                <i class="fa-regular fa-star" data-value="1"></i>
                <i class="fa-regular fa-star" data-value="2"></i>
                <i class="fa-regular fa-star" data-value="3"></i>
                <i class="fa-regular fa-star" data-value="4"></i>
                <i class="fa-regular fa-star" data-value="5"></i>
            </div>
            <textarea placeholder="Viết cảm nhận của bạn..."></textarea>
            <button>Gửi đánh giá</button>
        </div>
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

    // Nút gửi đánh giá
    document.querySelectorAll('.review-content button').forEach(btn => {
        btn.addEventListener('click', (e) => {
            alert(`Cảm ơn bạn đã đánh giá sản phẩm`);
        });
    });
</script>

</body>
</html>
