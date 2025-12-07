<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giỏ hàng</title>

    <link rel="stylesheet" href="css/cart_style.css">
</head>
<body>

<header>
    <div class="header-top">
        <div class="container">
            <div class="header-logo">
                <a href="index.jsp" class="logo">LOGO</a>
            </div>

            <div class="header-right">
                <a href="#" aria-label="Search">
                    <i class="fas fa-search"></i>
                </a>
                <a href="infoUsers/user_sidebar.jsp" aria-label="Account">
                    <i class="fas fa-user"></i>
                </a>
                <a href="Cart.html" class="cart-link" aria-label="Cart">
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
                    <li><a href="index.jsp" class="active">Trang Chủ</a></li>
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
                    <li><a href="blog.jsp">Blog</a></li>
                    <li><a href="about_us.jsp">About Us</a></li>
                </ul>
            </nav>
        </div>
    </div>
</header>

<main>
    <div class="cart-container container">

        <h1 class="cart-title">Giỏ hàng</h1>

        <div class="cart-grid-container">

            <div class="cart-items-column">
                <table class="cart-table">
                    <thead>
                    <tr>
                        <th><input type="checkbox" id="select-all"></th>
                        <th colspan="2">Sản phẩm</th>
                        <th>Giá</th>
                        <th>Số lượng</th>
                        <th>Tạm tính</th>
                        <th></th>
                    </tr>
                    </thead>

                    <tbody>

                    <tr class="cart-item-row">
                        <td><input type="checkbox" class="select-product"></td>
                        <td class="cart-product-image">
                            <a href="Detail.jsp">
                                <img src="img/SKU__VD_0845-17.jpg" alt="Luce Brunello Di Montalcino">
                            </a>
                        </td>
                        <td class="cart-product-name">
                            <a href="Detail.jsp">Rượu Vang Đỏ Luce Brunello Di Montalcino 2017</a>
                        </td>
                        <td class="cart-product-price">5.989.500₫</td>
                        <td class="cart-product-quantity">
                            <div class="quantity-selector">
                                <button class="quantity-btn">-</button>
                                <input type="number" value="1" min="1">
                                <button class="quantity-btn">+</button>
                            </div>
                        </td>
                        <td class="cart-product-subtotal">5.989.500₫</td>
                        <td class="cart-product-remove">
                            <a href="#" class="remove-item-btn" aria-label="Xóa sản phẩm">
                                <i class="fa-solid fa-trash-can"></i>
                            </a>
                        </td>
                    </tr>

                    <tr class="cart-item-row">
                        <td><input type="checkbox" class="select-product"></td>
                        <td class="cart-product-image">
                            <a href="#">
                                <img src="img/SKU__VD_1170.png" alt="Dufouleur Monopole">
                            </a>
                        </td>
                        <td class="cart-product-name">
                            <a href="#">Rượu vang hồng Dufouleur Monopole</a>
                        </td>
                        <td class="cart-product-price">351.000₫</td>
                        <td class="cart-product-quantity">
                            <div class="quantity-selector">
                                <button class="quantity-btn">-</button>
                                <input type="number" value="2" min="1">
                                <button class="quantity-btn">+</button>
                            </div>
                        </td>
                        <td class="cart-product-subtotal">702.000₫</td>
                        <td class="cart-product-remove">
                            <a href="#" class="remove-item-btn" aria-label="Xóa sản phẩm">
                                <i class="fa-solid fa-trash-can"></i>
                            </a>
                        </td>
                    </tr>

                    </tbody>
                </table>
                <div class="cart-actions">
                    <a href="store.jsp" class="btn btn-secondary">Tiếp tục xem sản phẩm</a>
                    <button class="btn btn-danger" id="delete-selected">Xóa sản phẩm đã chọn</button>
                </div>
            </div>

            <div class="cart-summary-column">
                <div class="summary-box">
                    <h3 class="summary-title">Tổng cộng</h3>

                    <div class="summary-row">
                        <span>Tạm tính</span>
                        <strong>6.691.500₫</strong>
                    </div>

                    <div class="summary-row">
                        <span>Giao hàng</span>
                        <strong>Miễn phí</strong>
                    </div>

                    <div class="summary-total">
                        <span>Tổng</span>
                        <strong>6.691.500₫</strong>
                    </div>

                    <a href="payment.jsp" class="btn btn-checkout">Tiến hành thanh toán</a>
                </div>
            </div>

        </div>
    </div>
</main>

<footer class="site-footer">
    <div class="container">
        <div class="footer-grid">
            <div class="footer-column">
                <h4 class="footer-heading">Về Chúng Tôi</h4>
                <p class="footer-text">Mô tả ngắn gọn về dự án của bạn...</p>
                <div class="footer-socials">
                    <a href="#" class="social-link" aria-label="Facebook"><i class="fa-brands fa-facebook-f"></i></a>
                    <a href="#" class="social-link" aria-label="Instagram"><i class="fa-brands fa-instagram"></i></a>
                    <a href="#" class="social-link" aria-label="Twitter"><i class="fa-brands fa-x-twitter"></i></a>
                </div>
            </div>
            <div class="footer-column">
                <h4 class="footer-heading">Liên Kết Nhanh</h4>
                <ul class="footer-links">
                    <li><a href="">Trang chủ</a></li>
                    <li><a href="">Giới thiệu</a></li>
                </ul>
            </div>
            <div class="footer-column">
                <h4 class="footer-heading">Liên Hệ</h4>
                <ul class="footer-contact">
                    <li><strong>Địa chỉ:</strong> Khu Phố 6, P. Linh Trung, Q. Thủ Đức, TP.HCM</li>
                </ul>
            </div>
        </div>
        <div class="footer-bottom">
            <p>&copy; 2025 Khoa Công Nghệ Thông Tin.</p>
        </div>
    </div>
</footer>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        const selectAllCheckbox = document.getElementById('select-all');
        const productCheckboxes = document.querySelectorAll('.select-product');
        const deleteSelectedButton = document.getElementById('delete-selected');

        selectAllCheckbox.addEventListener('change', function () {
            productCheckboxes.forEach(checkbox => {
                checkbox.checked = selectAllCheckbox.checked;
            });
        });

        productCheckboxes.forEach(checkbox => {
            checkbox.addEventListener('change', function () {
                const allChecked = Array.from(productCheckboxes).every(cb => cb.checked);
                const someChecked = Array.from(productCheckboxes).some(cb => cb.checked);
                selectAllCheckbox.checked = allChecked;
                selectAllCheckbox.indeterminate = someChecked && !allChecked;
            });
        });

        deleteSelectedButton.addEventListener('click', function () {
            const selectedRows = [];
            productCheckboxes.forEach(checkbox => {
                if (checkbox.checked) {
                    selectedRows.push(checkbox.closest('tr'));
                }
            });

            if (selectedRows.length > 0) {
                if (confirm('Bạn có chắc chắn muốn xóa ' + selectedRows.length + ' sản phẩm đã chọn?')) {
                    selectAllCheckbox.checked = false;
                    selectAllCheckbox.indeterminate = false;
                    alert('Đã xóa ' + selectedRows.length + ' sản phẩm.');
                }
            } else {
                alert('Vui lòng chọn ít nhất một sản phẩm để xóa.');
            }
        });
    });
</script>
</body>
