<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang Thanh Toán</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"
          integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A=="
          crossorigin="anonymous" referrerpolicy="no-referrer" async/>
    <link rel="stylesheet" href="css/store_style.css">
    <link rel="stylesheet" href="css/payment_style.css">
</head>

<body>
<%@ include file="components/header.jsp" %>

<main class="container">
    <div class="cart-details">
        <table>
            <thead>
            <tr>
                <th>SẢN PHẨM</th>
                <th>GIÁ</th>
                <th>SỐ LƯỢNG</th>
                <th>TỔNG</th>
                <th></th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>
                    <img src="https://via.placeholder.com/50" alt="Wine Bottle"> Rượu Vang Đỏ
                </td>
                <td>1.500.000 VND</td>
                <td>
                    <div class="quantity">
                        1
                    </div>
                </td>
                <td>1.500.000 VND</td>
                <td class="last">
                    <button class="delete-btn"><i class="fa-solid fa-trash"></i></button>
                </td>
            </tr>

            </tbody>
        </table>
    </div>
    <dialog id="pageDialog">
        <button id="closeDialog" aria-label="Đóng">&times;</button>
        <iframe src="infoUsers/addresses.jsp"></iframe>
    </dialog>
    <div class="payment-form">
        <div class="billing-details">
            <div class="billing-header">
                <h2>THÔNG TIN THANH TOÁN</h2>
                <button class="btn-edit-info">Thay đổi thông tin</button>
            </div>
            <div id="user-info">
                <p><strong>Họ và tên:</strong> <span id="display-fullname">Nguyễn Văn A</span></p>
                <p><strong>Địa chỉ giao hàng:</strong> <span id="display-address">123 Đường ABC, Phường XYZ, Quận 1,
                            TP. Hồ Chí Minh</span></p>
                <p><strong>Số điện thoại:</strong> <span id="display-phone">0987654321</span></p>
                <p><strong>Địa chỉ email:</strong> <span id="display-email">nguyenvan@example.com</span></p>
            </div>
            <h2>THÔNG TIN BỔ SUNG</h2>
            <p>
                <label for="notes">Ghi chú về đơn hàng, ví dụ: thời gian hay chỉ dẫn địa điểm giao hàng chi tiết
                    hơn.</label>
                <textarea id="notes" name="notes"></textarea>
            </p>
            <div class="cart-actions">
                <a href="store.jsp" class="continue-shopping"> TIẾP TỤC
                    XEM SẢN PHẨM</a>
            </div>
        </div>
        <div class="order-summary">
            <h2>ĐƠN HÀNG CỦA BẠN</h2>
            <div class="coupon-code">
                <input type="text" id="coupon" name="coupon" placeholder="Mã khuyến mãi">
                <button type="button" class="button">Áp dụng</button>
            </div>
            <table>
                <tbody>
                <tr>
                    <th>SẢN PHẨM</th>
                    <td>Rượu Vang Đỏ × 1</td>
                </tr>
                <tr>
                    <th>Số lượng</th>
                    <td>1</td>
                </tr>
                <tr>
                    <th>Tổng phụ</th>
                    <td>1.500.000 VND</td>
                </tr>
                <tr>
                    <th>Khuyến mãi</th>
                    <td>- 0 VND</td>
                </tr>
                <tr>
                    <th>Tổng</th>
                    <td><strong>1.500.000 VND</strong></td>
                </tr>
                </tbody>
            </table>
            <div class="payment-methods">
                <h3>Phương thức thanh toán</h3>
                <div class="selected-payment-display">
                    <span id="selected-payment-text">Thanh toán khi nhận hàng</span>
                    <i class="fas fa-chevron-down"></i>
                </div>
                <div class="payment-options-list">
                    <div class="payment-option" data-value="cod">
                        <input type="radio" id="cod" name="payment_method" value="cod" checked>
                        <label for="cod">
                            <div class="payment-icon">
                                <i class="fas fa-money-bill-wave"></i>
                            </div>
                            <div class="payment-info">
                                <div class="payment-name">Thanh toán khi nhận hàng</div>
                                <div class="payment-desc">Thanh toán trực tiếp khi nhận hàng</div>
                            </div>
                        </label>
                    </div>
                    <div class="payment-option" data-value="ewallet">
                        <input type="radio" id="ewallet" name="payment_method" value="ewallet">
                        <label for="ewallet">
                            <div class="payment-icon">
                                <i class="fas fa-mobile-alt"></i>
                            </div>
                            <div class="payment-info">
                                <div class="payment-name">Ví điện tử</div>
                                <div class="payment-desc">VNPay</div>
                            </div>
                        </label>
                    </div>
                </div>
            </div>
            <div class="age-verification">
                <input type="checkbox" id="age-verify" name="age-verify" required>
                <label for="age-verify">Tôi xác nhận tôi đã đủ tuổi hợp pháp để mua rượu.</label>
            </div>
            <div class="group-button">
                <button type="button" class="button-cancel" onclick="window.history.back()">HỦY</button>
                <button type="submit" class="button" id="place-order-btn">ĐẶT HÀNG</button>
            </div>
        </div>
    </div>
    <div id="success-modal" class="modal">
        <div class="modal-content success-modal-content">
            <div class="success-icon">
                <i class="fas fa-check-circle"></i>
            </div>
            <h2>Đặt hàng thành công!</h2>
            <p>Cảm ơn bạn đã mua hàng. Chúng tôi sẽ xử lý đơn hàng của bạn sớm nhất có thể.</p>
            <div class="order-details-summary">
                <h3>Chi tiết đơn hàng</h3>
                <p><strong>Mã đơn hàng:</strong> <span id="order-id">#123456</span></p>
                <p><strong>Ngày đặt:</strong> <span id="order-date">11/08/2025</span></p>
                <p><strong>Tổng cộng:</strong> <span id="order-total">1.500.000 VND</span></p>
                <p><strong>Phương thức thanh toán:</strong> <span>Thanh toán khi nhận hàng</span></p>
            </div>
            <button id="back-to-home" class="button"><a href="index.jsp">Quay về trang chủ </a></button>
        </div>
    </div>
</main>

<%@ include file="components/footer.jsp" %>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        const ageVerifyCheckbox = document.getElementById('age-verify');
        const placeOrderBtn = document.getElementById('place-order-btn');
        const successModal = document.getElementById('success-modal');
        const selectedPaymentDisplay = document.querySelector('.selected-payment-display');
        const paymentOptionsList = document.querySelector('.payment-options-list');
        const paymentOptions = document.querySelectorAll('.payment-option');

        const paymentNames = {
            'cod': 'Thanh toán khi nhận hàng',
            'bank_transfer': 'Chuyển khoản ngân hàng',
            'ewallet': 'Ví điện tử',
            'card': 'Thẻ tín dụng/ghi nợ'
        };

        ageVerifyCheckbox.addEventListener('change', function () {
            placeOrderBtn.disabled = !this.checked;
        });

        selectedPaymentDisplay.addEventListener('click', function () {
            const chevron = this.querySelector('i');
            paymentOptionsList.classList.toggle('show');

            if (paymentOptionsList.classList.contains('show')) {
                chevron.style.transform = 'rotate(180deg)';
            } else {
                chevron.style.transform = 'rotate(0deg)';
            }
        });

        paymentOptions.forEach(option => {
            option.addEventListener('click', function () {
                const value = this.getAttribute('data-value');
                const radio = this.querySelector('input[type="radio"]');
                radio.checked = true;
                document.getElementById('selected-payment-text').textContent = paymentNames[value];
                paymentOptions.forEach(opt => opt.classList.remove('selected'));
                this.classList.add('selected');
                paymentOptionsList.classList.remove('show');
                selectedPaymentDisplay.querySelector('i').style.transform = 'rotate(0deg)';
            });
        });

        placeOrderBtn.addEventListener('click', function (e) {
            e.preventDefault();
            if (!ageVerifyCheckbox.checked) {
                document.querySelector('.age-verification').classList.add('error');
                alert("Bạn phải xác nhận đủ tuổi để đặt hàng.");
                return;
            }
            document.querySelector('.age-verification').classList.remove('error');

            const selectedPayment = document.querySelector('input[name="payment_method"]:checked');
            let paymentText = 'Thanh toán khi nhận hàng';
            if (selectedPayment) {
                paymentText = paymentNames[selectedPayment.value];
            }
            document.querySelector('.order-details-summary p:nth-child(4) span').textContent = paymentText;

            successModal.style.display = "block";
        });

    });
</script>
<script>
    const dialog = document.getElementById("pageDialog");
    const openBtn = document.querySelector(".btn-edit-info");
    const closeBtn = document.getElementById("closeDialog");
    openBtn.addEventListener("click", () => dialog.showModal());
    closeBtn.addEventListener("click", () => dialog.close());
</script>
</body>
