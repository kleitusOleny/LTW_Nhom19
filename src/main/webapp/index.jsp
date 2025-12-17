<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Main Menu</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"
          integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
    <link rel="stylesheet" href="css/index_style.css">
</head>
<body>
<%@ include file="components/header.jsp" %>
<main>
    <section class="hero-section p-0">
        <div id="heroCarousel" class="carousel slide carousel-fade" data-bs-ride="carousel" data-bs-interval="5000">

            <div class="carousel-indicators">
                <button type="button" data-bs-target="#heroCarousel" data-bs-slide-to="0" class="active"
                        aria-current="true" aria-label="Slide 1"></button>
                <button type="button" data-bs-target="#heroCarousel" data-bs-slide-to="1" aria-label="Slide 2"></button>
                <button type="button" data-bs-target="#heroCarousel" data-bs-slide-to="2" aria-label="Slide 3"></button>
                <button type="button" data-bs-target="#heroCarousel" data-bs-slide-to="3" aria-label="Slide 4"></button>
            </div>

            <div class="carousel-inner">

                <div class="carousel-item active">
                    <div class="hero-overlay"></div>
                    <img src="assets/main_banner.jpg" class="d-block w-100" alt="Banner 1">
                    <div class="carousel-caption d-none d-md-block hero-content">
                        <h1 class="hero-title">Bộ Sưu Tập Vang Thượng Hạng</h1>
                        <p class="hero-subtitle">Khám phá hương vị tinh tế từ những vườn nho nổi tiếng nhất thế
                            giới.</p>
                        <a href="store.jsp" class="btn btn-primary hero-btn">Xem Ngay</a>
                    </div>
                </div>

                <div class="carousel-item">
                    <div class="hero-overlay"></div>
                    <img src="assets/banner-vang-bordeaux.jpg" class="d-block w-100" alt="Banner 2">
                    <div class="carousel-caption d-none d-md-block hero-content">
                        <h1 class="hero-title">Hương Vị Mùa Hè Tươi Mát</h1>
                        <p class="hero-subtitle">Tuyển tập những chai vang trắng và vang hồng xuất sắc nhất cho mùa
                            hè.</p>
                        <a href="store.jsp" class="btn btn-primary hero-btn">Khám Phá</a>
                    </div>
                </div>

                <div class="carousel-item">
                    <div class="hero-overlay"></div>
                    <img src="assets/banner-vang-bourgogne.jpg" class="d-block w-100" alt="Banner 3">
                    <div class="carousel-caption d-none d-md-block hero-content">
                        <h1 class="hero-title">Quà Tặng Doanh Nghiệp</h1>
                        <p class="hero-subtitle">Giải pháp quà tặng sang trọng, đẳng cấp dành cho đối tác và khách
                            hàng.</p>
                        <a href="store.jsp" class="btn btn-primary hero-btn">Liên Hệ</a>
                    </div>
                </div>

                <div class="carousel-item">
                    <div class="hero-overlay"></div>
                    <img src="assets/banner-vang-bordeaux.jpg" class="d-block w-100" alt="Banner 4">
                    <div class="carousel-caption d-none d-md-block hero-content">
                        <h1 class="hero-title">Hương Vị Mùa Hè Tươi Mát</h1>
                        <p class="hero-subtitle">Tuyển tập những chai vang trắng và vang hồng xuất sắc nhất cho mùa
                            hè.</p>
                        <a href="store.jsp" class="btn btn-primary hero-btn">Khám Phá</a>
                    </div>
                </div>
            </div>

            <button class="carousel-control-prev" type="button" data-bs-target="#heroCarousel" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#heroCarousel" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
            </button>
        </div>
    </section>

    <section class="featured-products container">

        <h2 class="section-title">Sản Phẩm Nổi Bật</h2>
        <p class="section-subtitle">Những chai vang được yêu thích và đánh giá cao nhất</p>

        <div class="product-grid">

            <div class="product-card">
                <div class="product-image">
                    <a href="Detail.jsp">
                        <img src="img/SKU__VD_0834-14-1.5L.jpg"
                             alt="Rượu Vang Đỏ Sandrone Barolo Le Vigne – 1.5L 2014">
                    </a>
                    <button class="wishlist-btn" aria-label="Thêm vào yêu thích">
                        <i class="fa-regular fa-heart"></i>
                    </button>
                </div>
                <div class="product-info">
                    <h3 class="product-name"><a href="#">Rượu Vang Đỏ Sandrone Barolo Le Vigne – 1.5L 2014</a></h3>
                    <div class="product-extra-details">
                        <ul>
                            <li><strong>Xuất xứ:</strong> Ý</li>
                            <li><strong>Loại:</strong> Rượu Vang Đỏ</li>
                            <li><strong>Nồng độ:</strong> 14.5%</li>
                        </ul>
                    </div>
                    <p class="product-producer">Nhà sản xuất: LUCIANO SANDRONE</p>
                    <div class="product-rating">
                        <i class="fa-solid fa-star"></i>
                        <i class="fa-solid fa-star"></i>
                        <i class="fa-solid fa-star"></i>
                        <i class="fa-solid fa-star"></i>
                        <i class="fa-regular fa-star"></i>
                    </div>
                    <p class="product-price">13.486.000₫</p>
                    <a href="#" class="add-to-cart-btn">Thêm vào giỏ</a>
                </div>
            </div>

            <div class="product-card">
                <div class="product-image">
                    <a href="#">
                        <img src="img/SKU__VD_0845-17.jpg" alt="Rượu Vang Đỏ Luce Brunello Di Montalcino 2017">
                    </a>
                    <button class="wishlist-btn" aria-label="Thêm vào yêu thích">
                        <i class="fa-regular fa-heart"></i>
                    </button>
                </div>
                <div class="product-info">
                    <h3 class="product-name"><a href="#">Rượu Vang Đỏ Luce Brunello Di Montalcino 2017</a></h3>
                    <div class="product-extra-details">
                        <ul>
                            <li><strong>Xuất xứ:</strong> Ý</li>
                            <li><strong>Loại:</strong> Rượu Vang Đỏ</li>
                            <li><strong>Nồng độ:</strong> 15.0%</li>
                        </ul>
                    </div>
                    <p class="product-producer">Nhà sản xuất: TENUTA LUCE</p>
                    <div class="product-rating">
                        <i class="fa-solid fa-star"></i>
                        <i class="fa-solid fa-star"></i>
                        <i class="fa-solid fa-star"></i>
                        <i class="fa-solid fa-star"></i>
                        <i class="fa-solid fa-star"></i>
                    </div>
                    <p class="product-price">5.989.500₫</p>
                    <a href="#" class="add-to-cart-btn">Thêm vào giỏ</a>
                </div>
            </div>

            <div class="product-card">
                <div class="product-image">
                    <a href="#">
                        <img src="img/SKU__VD_0883-09-3L.jpg"
                             alt="Rượu Vang Đỏ Muga Prado Enea Gran Reserva 2009 3 Lít">
                    </a>
                    <button class="wishlist-btn" aria-label="Thêm vào yêu thích">
                        <i class="fa-regular fa-heart"></i>
                    </button>
                </div>
                <div class="product-info">
                    <h3 class="product-name">
                        <a href="#">Rượu Vang Đỏ Muga Prado Enea Gran Reserva 2009 3 Lít</a>
                    </h3>
                    <div class="product-extra-details">
                        <ul>
                            <li><strong>Xuất xứ:</strong> Tây Ban Nha</li>
                            <li><strong>Loại:</strong> Rượu Vang Đỏ</li>
                            <li><strong>Nồng độ:</strong> 14.5%</li>
                        </ul>
                    </div>
                    <p class="product-producer">Nhà sản xuất: BODEGAS MUGA</p>
                    <div class="product-rating">
                        <i class="fa-solid fa-star"></i>
                        <i class="fa-solid fa-star"></i>
                        <i class="fa-solid fa-star"></i>
                        <i class="fa-solid fa-star"></i>
                        <i class="fa-regular fa-star"></i>
                    </div>
                    <p class="product-price">9.460.000₫</p>
                    <a href="#" class="add-to-cart-btn">Thêm vào giỏ</a>
                </div>
            </div>

            <div class="product-card">
                <div class="product-image">
                    <a href="#">
                        <img src="img/SKU__VD_0883-14.jpg" alt="Rượu Vang Đỏ Muga Prado Enea Gran Reserva 2014">
                    </a>
                    <button class="wishlist-btn" aria-label="Thêm vào yêu thích">
                        <i class="fa-regular fa-heart"></i>
                    </button>
                </div>
                <div class="product-info">
                    <h3 class="product-name"><a href="#">Rượu Vang Đỏ Muga Prado Enea Gran Reserva 2014</a></h3>
                    <div class="product-extra-details">
                        <ul>
                            <li><strong>Xuất xứ:</strong> Tây Ban Nha</li>
                            <li><strong>Loại:</strong> Rượu Vang Đỏ</li>
                            <li><strong>Nồng độ:</strong> 14.5%</li>
                        </ul>
                    </div>
                    <p class="product-producer">Nhà sản xuất: BODEGAS MUGA</p>
                    <div class="product-rating">
                        <i class="fa-solid fa-star"></i>
                        <i class="fa-solid fa-star"></i>
                        <i class="fa-solid fa-star"></i>
                        <i class="fa-solid fa-star"></i>
                        <i class="fa-regular fa-star"></i>
                    </div>
                    <p class="product-price">2.783.000₫</p>
                    <a href="#" class="add-to-cart-btn">Thêm vào giỏ</a>
                </div>
            </div>

        </div>
    </section>
    <section class="featured-brands">
        <div class="container">

            <h2 class="section-title">Thương Hiệu Nổi Bật</h2>
            <p class="section-subtitle">Những nhà sản xuất danh tiếng hàng đầu</p>

            <div class="brands-grid">

                <a href="store.jsp" class="brand-logo-box">
                    <img src="img/Alfred-gratien-80.jpg" alt="Thương hiệu 1">
                </a>

                <a href="#" class="brand-logo-box">
                    <img src="img/Billecart-Salmon-80.jpg" alt="Thương hiệu 2">
                </a>

                <a href="#" class="brand-logo-box">
                    <img src="img/Cantenac-Brown-80.jpg" alt="Thương hiệu 3">
                </a>

                <a href="#" class="brand-logo-box">
                    <img src="img/Chateau-de-Meursault-80.jpg" alt="Thương hiệu 4">
                </a>

                <a href="#" class="brand-logo-box">
                    <img src="img/Freixenet-80.jpg" alt="Thương hiệu 5">
                </a>

                <a href="#" class="brand-logo-box">
                    <img src="img/Louis-latour-80.jpg" alt="Thương hiệu 6">
                </a>

            </div>
        </div>
    </section>

    <section class="blog-section">
        <div class="container">

            <h2 class="section-title">Cẩm Nang Rượu Vang</h2>
            <p class="section-subtitle">Khám phá kiến thức và nghệ thuật thưởng thức rượu vang</p>

            <div class="blog-grid">

                <article class="blog-card">
                    <div class="blog-image">
                        <a href="blog_detail.jsp">
                            <img src="img/ruou.jpg" alt="Xu hướng rượu vang 2025">
                        </a>
                        <span class="blog-date">Dec 12, 2025</span>
                    </div>
                    <div class="blog-content">
                        <h3 class="blog-title"><a href="blog_detail.jsp">Xu hướng rượu vang 2025: nhẹ, tươi và
                            terroir</a></h3>
                        <p class="blog-excerpt">Năm 2025 đánh dấu sự lên ngôi của rượu vang nhẹ và chú trọng terroir —
                            những chai dễ uống, thích hợp pairing với ẩm thực hàng ngày.</p>
                        <a href="blog_detail.jsp" class="read-more-btn">Xem thêm <i
                                class="fa-solid fa-arrow-right"></i></a>
                    </div>
                </article>

                <article class="blog-card">
                    <div class="blog-image">
                        <a href="blog_detail.jsp">
                            <img src="img/ruou2.jpg" alt="Đánh giá Cabernet Sauvignon Chile 2018">
                        </a>
                        <span class="blog-date">Nov 10, 2025</span>
                    </div>
                    <div class="blog-content">
                        <h3 class="blog-title"><a href="blog_detail.jsp">Đánh giá Cabernet Sauvignon Chile 2018</a>
                        </h3>
                        <p class="blog-excerpt">Mạnh mẽ, tannin mịn, phù hợp với thịt đỏ nướng. Điểm: 88/100.</p>
                        <a href="blog_detail.jsp" class="read-more-btn">Xem thêm <i
                                class="fa-solid fa-arrow-right"></i></a>
                    </div>
                </article>

                <article class="blog-card">
                    <div class="blog-image">
                        <a href="blog_detail.jsp">
                            <img src="img/ruou.jpg" alt="Cách chọn vang cho người mới">
                        </a>
                        <span class="blog-date">Oct 05, 2025</span>
                    </div>
                    <div class="blog-content">
                        <h3 class="blog-title"><a href="blog_detail.jsp">Cách chọn vang cho người mới</a></h3>
                        <p class="blog-excerpt">Bạn mới tập uống vang? Hướng dẫn chọn vang theo phong cách: ngọt, khô,
                            nhẹ, đậm.</p>
                        <a href="blog_detail.jsp" class="read-more-btn">Xem thêm <i
                                class="fa-solid fa-arrow-right"></i></a>
                    </div>
                </article>

                <article class="blog-card">
                    <div class="blog-image">
                        <a href="blog_detail.jsp">
                            <img src="img/ruou.jpg" alt="Xu hướng rượu vang 2025">
                        </a>
                        <span class="blog-date">Dec 12, 2025</span>
                    </div>
                    <div class="blog-content">
                        <h3 class="blog-title"><a href="blog_detail.jsp">Xu hướng rượu vang 2025: nhẹ, tươi và
                            terroir</a></h3>
                        <p class="blog-excerpt">Năm 2025 đánh dấu sự lên ngôi của rượu vang nhẹ và chú trọng terroir —
                            những chai dễ uống, thích hợp pairing với ẩm thực hàng ngày.</p>
                        <a href="blog_detail.jsp" class="read-more-btn">Xem thêm <i
                                class="fa-solid fa-arrow-right"></i></a>
                    </div>
                </article>

                <article class="blog-card">
                    <div class="blog-image">
                        <a href="blog_detail.jsp">
                            <img src="img/ruou2.jpg" alt="Đánh giá Cabernet Sauvignon Chile 2018">
                        </a>
                        <span class="blog-date">Nov 10, 2025</span>
                    </div>
                    <div class="blog-content">
                        <h3 class="blog-title"><a href="blog_detail.jsp">Đánh giá Cabernet Sauvignon Chile 2018</a>
                        </h3>
                        <p class="blog-excerpt">Mạnh mẽ, tannin mịn, phù hợp với thịt đỏ nướng. Điểm: 88/100.</p>
                        <a href="blog_detail.jsp" class="read-more-btn">Xem thêm <i
                                class="fa-solid fa-arrow-right"></i></a>
                    </div>
                </article>

                <article class="blog-card">
                    <div class="blog-image">
                        <a href="blog_detail.jsp">
                            <img src="img/ruou.jpg" alt="Cách chọn vang cho người mới">
                        </a>
                        <span class="blog-date">Oct 05, 2025</span>
                    </div>
                    <div class="blog-content">
                        <h3 class="blog-title"><a href="blog_detail.jsp">Cách chọn vang cho người mới</a></h3>
                        <p class="blog-excerpt">Bạn mới tập uống vang? Hướng dẫn chọn vang theo phong cách: ngọt, khô,
                            nhẹ, đậm.</p>
                        <a href="blog_detail.jsp" class="read-more-btn">Xem thêm <i
                                class="fa-solid fa-arrow-right"></i></a>
                    </div>
                </article>

            </div>
        </div>
    </section>

    <section class="service-commitment-section">
        <div class="container">
            <div class="service-grid">

                <div class="service-item">
                    <i class="fa-solid fa-truck-fast"></i>
                    <h4>Giao Hàng Nhanh</h4>
                    <p>Giao hàng hỏa tốc 2H tại TP.HCM</p>
                </div>

                <div class="service-item">
                    <i class="fa-solid fa-shield-halved"></i>
                    <h4>100% Chính Hãng</h4>
                    <p>Cam kết sản phẩm nhập khẩu chính ngạch</p>
                </div>

                <div class="service-item">
                    <i class="fa-solid fa-comments"></i>
                    <h4>Tư Vấn Chuyên Nghiệp</h4>
                    <p>Đội ngũ am hiểu, hỗ trợ 24/7</p>
                </div>

                <div class="service-item">
                    <i class="fa-solid fa-box-open"></i>
                    <h4>Đóng Gói An Toàn</h4>
                    <p>Bảo vệ sản phẩm cẩn thận, an toàn</p>
                </div>

            </div>
        </div>
    </section>
</main>
<%@ include file="components/footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        const wishlistBtns = document.querySelectorAll('.wishlist-btn');

        wishlistBtns.forEach(btn => {
            btn.addEventListener('click', function (e) {
                e.preventDefault(); // Ngăn chặn click vào thẻ a bao quanh (nếu có)

                // Toggle class active
                this.classList.toggle('active');

                // Đổi icon từ rỗng (fa-regular) sang đặc (fa-solid) và ngược lại
                const icon = this.querySelector('i');
                if (this.classList.contains('active')) {
                    icon.classList.remove('fa-regular');
                    icon.classList.add('fa-solid');
                } else {
                    icon.classList.remove('fa-solid');
                    icon.classList.add('fa-regular');
                }
            });
        });
    });
</script>
</body>
</html>