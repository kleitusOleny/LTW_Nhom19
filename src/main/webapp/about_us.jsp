<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - Wine & Spirits</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"
          integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/store_style.css">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #faf7f3;
            color: #333;
        }

        .about-text h2 {
            color: #8c3333;
            font-size: 32px;
            margin-bottom: 20px;
            position: relative;
        }

        .about-text h2::after {
            content: '';
            width: 60px;
            height: 3px;
            background-color: #c7a17a;
            display: block;
            margin-top: 8px;
            border-radius: 2px;
        }

        .about-text p {
            font-size: 20px;
            margin-bottom: 15px;
            color: #4a4a4a;
        }

        .about-image video {
            width: 300px;
            border-radius: 12px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
            transition: transform 0.3s ease;
        }

        .about-image video:hover {
            transform: scale(1.03);
        }

        .mission h3 {
            font-size: 28px;
            color: #8c3333;
            margin-bottom: 20px;
        }

        .mission p {
            font-size: 20px;
            color: #5a4a42;
        }

        .card-custom {
            background-color: #fff8f0;
            border-left: 5px solid #c7a17a;
            border-radius: 12px;
            padding: 25px 20px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            height: 100%;
        }

        .card-custom:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 25px rgba(0, 0, 0, 0.15);
        }

        .card-custom h4 {
            color: #8c3333;
            margin-bottom: 12px;
            font-size: 22px;
        }

        .card-custom p {
            color: #4a4a4a;
            font-size: 15px;
        }

        .policies-section {
            margin-top: 90px;
        }
    </style>
</head>
<body>
<header class="site-header">
    <div class="header-top">
        <div class="container">
            <div class="header-logo">
                <a href="index.jsp" class="logo">LOGO</a>
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
                <a href="infoUsers/user_sidebar.jsp" aria-label="Account">
                    <i class="fas fa-user"></i>
                </a>
                <a href="Cart.jsp" class="cart-link" aria-label="Cart">
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
                    <li><a href="index.jsp">Trang Chủ</a></li>
                    <li class="has-dropdown">
                        <a href="store.jsp">
                            Rượu Vang
                            <i class="fa-solid fa-caret-down"></i>
                        </a>
                        <div class="mega-menu">
                            <div class="mega-menu-grid">
                                <div class="mega-menu-column">
                                    <h4 class="mega-menu-title">Theo Loại Vang</h4>
                                    <ul class="mega-menu-list">
                                        <li><a href="store.jsp" class="mega-menu-link">Rượu Vang Đỏ</a></li>
                                        <li><a href="store.jsp" class="mega-menu-link">Rượu Vang Trắng</a></li>
                                        <li><a href="store.jsp" class="mega-menu-link">Rượu Vang Hồng</a></li>
                                        <li><a href="store.jsp" class="mega-menu-link">Sâm Panh / Vang Nổ</a></li>
                                        <li><a href="store.jsp" class="mega-menu-link">Rượu Vang Ngọt</a></li>
                                        <li><a href="store.jsp" class="mega-menu-link">Cognac & Rượu Mạnh</a></li>
                                    </ul>
                                </div>

                                <div class="mega-menu-column">
                                    <h4 class="mega-menu-title">Nhãn Hàng Nổi Bật</h4>
                                    <ul class="mega-menu-list">
                                        <li><a href="store.jsp" class="mega-menu-link">CHÂTEAU CORBIN</a></li>
                                        <li><a href="store.jsp" class="mega-menu-link">TENUTA LUCE</a></li>
                                        <li><a href="store.jsp" class="mega-menu-link">MAISON LOUIS LATOUR</a></li>
                                        <li><a href="store.jsp" class="mega-menu-link">Domaine Faiveley</a></li>
                                        <li><a href="store.jsp" class="mega-menu-link">BODEGAS MUGA</a></li>
                                        <li><a href="store.jsp" class="mega-menu-link">CHAMPAGNE RUINART</a></li>
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
                    <li><a href="blog.jsp">Blog</a></li>
                    <li><a href="about_us.html" class="active">About Us</a></li>
                </ul>
            </nav>
        </div>
    </div>
</header>

<div class="container my-5">
    <section class="about-section row align-items-center mb-5">
        <div class="about-text col-md-6">
            <h2>Về chúng tôi</h2>
            <p>Wine & Spirits mang đến trải nghiệm thưởng thức rượu vang và đồ uống cao cấp đẳng cấp thế giới ngay tại
                Việt Nam. Mỗi sản phẩm đều được tuyển chọn kỹ lưỡng từ các vùng rượu danh tiếng.</p>
            <p>Chúng tôi tự hào mang đến cho khách hàng những bữa tiệc trọn vẹn, tinh tế với dịch vụ tư vấn chuyên
                nghiệp từ đội ngũ chuyên gia am hiểu rượu vang.</p>
        </div>
        <div class="about-image col-md-6 text-center">
            <video class="img-fluid rounded" autoplay muted loop playsinline>
                <source src="img/about_us.mp4" type="video/mp4">
                Trình duyệt của bạn không hỗ trợ video.
            </video>
        </div>

    </section>

    <section class="mission text-center mb-5">
        <h3>Sứ mệnh của chúng tôi</h3>
        <p class="mx-auto">Mang văn hóa thưởng thức rượu vang và đồ uống có cồn cao cấp đến gần hơn với khách hàng Việt
            Nam, tạo ra trải nghiệm tinh tế và đáng nhớ trong mỗi ly rượu.</p>
    </section>

    <section class="highlight-cards row g-4">
        <div class="col-md-4">
            <div class="card-custom h-100">
                <h4>Rượu vang nhập khẩu</h4>
                <p>Tuyển chọn từ các vùng rượu danh tiếng, đảm bảo hương vị tinh tế và chất lượng cao nhất.</p>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card-custom h-100">
                <h4>Dịch vụ tư vấn</h4>
                <p>Đội ngũ chuyên gia giàu kinh nghiệm tư vấn chọn rượu phù hợp với sở thích và bữa tiệc của bạn.</p>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card-custom h-100">
                <h4>Trải nghiệm sang trọng</h4>
                <p>Tạo nên những khoảnh khắc thưởng thức rượu vang đáng nhớ, từ phong cách đóng gói đến dịch vụ tận
                    tâm.</p>
            </div>
        </div>
    </section>

    <section class="policies-section mb-5">
        <h3 class="text-center mb-4" style="color: #8c3333; font-size: 28px;">Chính Sách Của Chúng Tôi</h3>
        <p class="text-center mb-4" style="font-size: 18px; color: #5a4a42; max-width: 800px; margin: 0 auto;">Chúng tôi
            cam kết mang đến trải nghiệm mua sắm an toàn, minh bạch và đáng tin cậy cho mọi khách hàng</p>
        <div class="row g-4">
            <div class="col-md-6 col-lg-3">
                <div class="card-custom h-100 text-center">
                    <div class="mb-3">
                        <i class="fas fa-shield-alt" style="font-size: 48px; color: #c7a17a;"></i>
                    </div>
                    <h4>Chính Sách Bảo Mật</h4>
                    <p>Thông tin cá nhân của quý khách được bảo vệ tuyệt đối với công nghệ mã hóa SSL 256-bit và tuân
                        thủ GDPR. Chúng tôi cam kết không chia sẻ dữ liệu với bên thứ ba.</p>
                </div>
            </div>
            <div class="col-md-6 col-lg-3">
                <div class="card-custom h-100 text-center">
                    <div class="mb-3">
                        <i class="fas fa-undo-alt" style="font-size: 48px; color: #c7a17a;"></i>
                    </div>
                    <h4>Chính Sách Đổi Trả</h4>
                    <p>Đổi trả miễn phí trong 30 ngày với sản phẩm nguyên seal. Hỗ trợ tư vấn chọn sản phẩm thay thế phù
                        hợp. Quy trình đơn giản, nhanh chóng.</p>
                </div>
            </div>
            <div class="col-md-6 col-lg-3">
                <div class="card-custom h-100 text-center">
                    <div class="mb-3">
                        <i class="fas fa-truck" style="font-size: 48px; color: #c7a17a;"></i>
                    </div>
                    <h4>Chính Sách Vận Chuyển</h4>
                    <p>Giao hàng siêu tốc 2-4 giờ nội thành, 1-2 ngày toàn quốc. Đóng gói chuyên nghiệp với vật liệu
                        cách nhiệt, đảm bảo rượu vang luôn ở điều kiện tối ưu.</p>
                </div>
            </div>
            <div class="col-md-6 col-lg-3">
                <div class="card-custom h-100 text-center">
                    <div class="mb-3">
                        <i class="fas fa-credit-card" style="font-size: 48px; color: #c7a17a;"></i>
                    </div>
                    <h4>Chính Sách Thanh Toán</h4>
                    <p>Đa dạng phương thức: COD, chuyển khoản, thẻ tín dụng, ví điện tử. Bảo mật 100% với công nghệ
                        tokenization. Hoàn tiền tức thì nếu có vấn đề.</p>
                </div>
            </div>
        </div>

        <div class="row g-4 mt-3">
            <div class="col-md-6 col-lg-3">
                <div class="card-custom h-100 text-center">
                    <div class="mb-3">
                        <i class="fas fa-award" style="font-size: 48px; color: #c7a17a;"></i>
                    </div>
                    <h4>Chất Lượng Đảm Bảo</h4>
                    <p>Tất cả sản phẩm đều có nguồn gốc rõ ràng, được nhập khẩu chính hãng từ các nhà sản xuất uy tín.
                        Kiểm định chất lượng nghiêm ngặt trước khi xuất bán.</p>
                </div>
            </div>
            <div class="col-md-6 col-lg-3">
                <div class="card-custom h-100 text-center">
                    <div class="mb-3">
                        <i class="fas fa-headset" style="font-size: 48px; color: #c7a17a;"></i>
                    </div>
                    <h4>Hỗ Trợ Khách Hàng</h4>
                    <p>Đội ngũ chuyên gia tư vấn 24/7 qua hotline, chat, email. Hỗ trợ kỹ thuật sử dụng sản phẩm và giải
                        đáp mọi thắc mắc chuyên môn.</p>
                </div>
            </div>
            <div class="col-md-6 col-lg-3">
                <div class="card-custom h-100 text-center">
                    <div class="mb-3">
                        <i class="fas fa-handshake" style="font-size: 48px; color: #c7a17a;"></i>
                    </div>
                    <h4>Cam Kết Uy Tín</h4>
                    <p>Hoàn tiền 200% nếu phát hiện hàng giả, hàng nhái. Bảo hành trọn đời với các sản phẩm cao cấp. Xây
                        dựng lòng tin lâu dài với khách hàng.</p>
                </div>
            </div>
            <div class="col-md-6 col-lg-3">
                <div class="card-custom h-100 text-center">
                    <div class="mb-3">
                        <i class="fas fa-leaf" style="font-size: 48px; color: #c7a17a;"></i>
                    </div>
                    <h4>Phát Triển Bền Vững</h4>
                    <p>Cam kết bảo vệ môi trường với bao bì thân thiện, quy trình sản xuất xanh. Hỗ trợ cộng đồng và
                        phát triển ngành rượu vang Việt Nam.</p>
                </div>
            </div>
        </div>
    </section>
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
                    <li><a href="">Trang chủ</a></li>
                    <li><a href="">Giới thiệu</a></li>
                    <li><a href="">Dịch vụ</a></li>
                    <li><a href="">Liên hệ</a></li>
                    <li><a href="">Chính sách</a></li>
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
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
