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
    <c:if test="${not empty sessionScope.errorMessage}">
        <div class="alert alert-danger"
             style="color: red; background-color: #f8d7da; border-color: #f5c6cb; padding: 10px; margin-bottom: 15px; border-radius: 5px;">
                ${sessionScope.errorMessage}
        </div>
        <c:remove var="errorMessage" scope="session"/>
    </c:if>
    <div class="cart-details">
        <table>
            <thead>
            <tr>
                <th>HÌNH ẢNH</th>
                <th>SẢN PHẨM</th>
                <th>GIÁ</th>
                <th>SỐ LƯỢNG</th>
                <th>TỔNG</th>
                <th></th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${requestScope.order.items}" var="oi">
                <c:set var="product" value="${requestScope.productMap[oi.productId]}"/>
                <tr class="cart-item-row">
                    <td class="cart-product-image">
                        <a><img src=${product.imageUrl} alt="${product.productName}"></a>
                    </td>
                    <td class="cart-product-name">
                        <a>${product.productName}</a>
                    </td>
                    <td class="cart-product-price">
                        <fmt:setLocale value="vi_VN"/>
                        <fmt:formatNumber value="${oi.unitPrice}" type="currency" currencySymbol="₫"
                                          maxFractionDigits="0"/>
                    </td>
                    <td class="cart-product-quantity">
                        <div class="quantity-selector">${oi.quantity}</div>
                    </td>
                    <td class="cart-product-subtotal">
                        <fmt:setLocale value="vi_VN"/>
                        <fmt:formatNumber value="${oi.quantity * oi.unitPrice}" type="currency"
                                          currencySymbol="₫" maxFractionDigits="0"/>
                    </td>
                    <td class="cart-product-remove">
                        <form action="delete-cart" method="post">
                            <input type="hidden" name="id" value="${product.id}">
                            <input type="hidden" name="redirect" value="checkout">
                            <input type="hidden" name="cartType" value="${sessionScope.checkoutType}">
                            <button class="remove-item-btn" aria-label="Xóa sản phẩm"
                                    style="border: 0; background: white">
                                <i class="fa-solid fa-trash-can"></i>
                            </button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
    <dialog id="pageDialog">
        <button id="closeDialog" aria-label="Đóng">&times;</button>
        <iframe src="${pageContext.request.contextPath}/address?view=popup"
                style="width: 100%; height: 100%; border: none;"></iframe>
    </dialog>
    <form id="checkoutForm" class="payment-form" action="" method="post">
        <input type="hidden" name="totalBill" value="${requestScope.order.totalPrice}">
        <div class="billing-details">
            <div class="billing-header">
                <h2>THÔNG TIN THANH TOÁN</h2>
                <button type="button" class="btn-edit-info">Thay đổi thông tin</button>
            </div>
            <div id="user-info">
                <p><strong>Họ và tên:</strong> <span
                        id="display-fullname">${shippingAddress.fullName}</span></p>
                <p><strong>Địa chỉ giao hàng:</strong> <span
                        id="display-address">${shippingAddress.addressLine}, ${shippingAddress.ward},
                    ${shippingAddress.city}</span></p>
                <p><strong>Số điện thoại:</strong> <span
                        id="display-phone">${shippingAddress.phoneNumber}</span></p>
                <p><strong>Địa chỉ email:</strong> <span
                        id="display-email">${sessionScope.user.email}</span></p>
            </div>
            <h2>THÔNG TIN BỔ SUNG</h2>
            <p>
                <label for="notes">Ghi chú về đơn hàng, ví dụ: thời gian hay chỉ dẫn địa điểm giao hàng
                    chi
                    tiết hơn.</label>
                <textarea id="notes" name="notes"></textarea>
            </p>
            <div class="cart-actions">
                <a href="${pageContext.request.contextPath}/store" class="continue-shopping"> TIẾP TỤC
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
                    <th>Số lượng</th>
                    <td>${requestScope.order.items.size()}</td>
                </tr>
                <tr>
                    <th>Tổng phụ</th>
                    <td>
                        <fmt:formatNumber value="${requestScope.order.totalPrice}" type="currency"
                                          currencySymbol="₫" maxFractionDigits="0"/>
                    </td>
                </tr>
                <tr>
                    <th>Khuyến mãi</th>
                    <td>-
                        <fmt:formatNumber value="0" type="currency" currencySymbol="₫"
                                          maxFractionDigits="0"/>
                    </td>
                </tr>
                <tr>
                    <th>Tổng</th>
                    <td><strong>
                        <fmt:formatNumber value="${requestScope.order.totalPrice}" type="currency"
                                          currencySymbol="₫" maxFractionDigits="0"/>
                    </strong></td>
                </tr>
                </tbody>
            </table>
            <div class="payment-methods">
                <h3>Phương thức thanh toán</h3>
                <div class="selected-payment-display">
                    <span id="selected-payment-text">Chọn phương thức thanh toán</span>
                    <i class="fas fa-chevron-down"></i>
                </div>
                <div class="payment-options-list">
                    <div class="payment-option" data-value="cod">
                        <input type="radio" id="cod" name="payment_method" value="cod">
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
                <button type="button" class="button" id="place-order-btn">ĐẶT HÀNG</button>
            </div>
        </div>
    </form>
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
            if (!ageVerifyCheckbox.checked) {
                document.querySelector('.age-verification').classList.add('error');
                alert("Bạn phải xác nhận đủ tuổi để đặt hàng.");
                return;
            }
            document.querySelector('.age-verification').classList.remove('error');

            const selectedPayment = document.querySelector('input[name="payment_method"]:checked');

            if (!selectedPayment) {
                alert("Vui lòng chọn phương thức thanh toán.");
                return;
            }

            const form = document.getElementById('checkoutForm');
            form.action = "${pageContext.request.contextPath}/checkout";
            form.submit();
        });
    });
</script>
<script>
    const dialog = document.getElementById("pageDialog");
    const openBtn = document.querySelector(".btn-edit-info");
    const closeBtn = document.getElementById("closeDialog");
    openBtn.addEventListener("click", (e) => {
        e.preventDefault();
        dialog.showModal();
    });
    closeBtn.addEventListener("click", () => {
        dialog.close();
        window.location.reload(); // Reload to reflect changes
    });

    window.addEventListener('message', function (event) {
        if (event.data.type === 'SELECT_ADDRESS') {
            const data = event.data.data;
            document.getElementById('display-fullname').textContent = data.fullName;
            document.getElementById('display-phone').textContent = data.phone;
            document.getElementById('display-address').textContent = data.address;
            dialog.close();
        }
    });
</script>
</body>