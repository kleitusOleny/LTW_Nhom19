<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="vi">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Trang Thanh Toán</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"
            integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A=="
            crossorigin="anonymous" referrerpolicy="no-referrer" async />
        <link rel="stylesheet" href="css/store_style.css">
        <link rel="stylesheet" href="css/payment_style.css?v=3">
    </head>

    <body>
        <%@ include file="components/header.jsp" %>

            <main class="container">
                <c:if test="${not empty sessionScope.errorMessage}">
                    <div class="alert alert-danger"
                        style="color: red; background-color: #f8d7da; border-color: #f5c6cb; padding: 10px; margin-bottom: 15px; border-radius: 5px;">
                        ${sessionScope.errorMessage}
                    </div>
                    <c:remove var="errorMessage" scope="session" />
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
                                <c:set var="product" value="${requestScope.productMap[oi.productId]}" />
                                <tr class="cart-item-row">
                                    <td class="cart-product-image">
                                        <a><img src=${product.imageUrl} alt="${product.productName}"></a>
                                    </td>
                                    <td class="cart-product-name">
                                        <a>${product.productName}</a>
                                    </td>
                                    <td class="cart-product-price">
                                        <fmt:setLocale value="vi_VN" />
                                        <fmt:formatNumber value="${oi.unitPrice}" type="currency" currencySymbol="₫"
                                            maxFractionDigits="0" />
                                    </td>
                                    <td class="cart-product-quantity">
                                        <div class="quantity-selector">${oi.quantity}</div>
                                    </td>
                                    <td class="cart-product-subtotal">
                                        <fmt:setLocale value="vi_VN" />
                                        <fmt:formatNumber value="${oi.quantity * oi.unitPrice}" type="currency"
                                            currencySymbol="₫" maxFractionDigits="0" />
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
                            <c:choose>
                                <c:when test="${not empty shippingAddress}">
                                    <p><strong>Họ và tên:</strong> <span
                                            id="display-fullname">${shippingAddress.fullName}</span></p>
                                    <p><strong>Địa chỉ giao hàng:</strong> <span
                                            id="display-address">${shippingAddress.addressLine},
                                            ${shippingAddress.ward},
                                            ${shippingAddress.city}</span></p>
                                    <p><strong>Số điện thoại:</strong> <span
                                            id="display-phone">${shippingAddress.phoneNumber}</span></p>
                                    <p><strong>Địa chỉ email:</strong> <span
                                            id="display-email">${sessionScope.user.email}</span></p>
                                </c:when>
                                <c:otherwise>
                                    <div
                                        style="padding: 20px; background-color: #fff3cd; border: 1px solid #ffc107; border-radius: 5px; margin-bottom: 15px;">
                                        <p style="color: #856404; margin: 0 0 10px 0;"><strong><i
                                                    class="fas fa-exclamation-triangle"></i> Bạn chưa có địa chỉ giao
                                                hàng</strong></p>
                                        <p style="color: #856404; margin: 0 0 10px 0;">Vui lòng thêm địa chỉ để tiếp tục
                                            đặt hàng.</p>
                                    </div>
                                </c:otherwise>
                            </c:choose>
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
                        <div class="discount-section">
                            <div class="discount-toggle" id="discount-toggle-btn">
                                <h3><i class="fas fa-tags" style="margin-right: 10px; color: #8c3333;"></i>Mã giảm giá
                                </h3>
                                <i class="fas fa-chevron-down"></i>
                            </div>

                            <div class="discount-content" id="discount-content-area">
                                <!-- Shipping Discount -->
                                <div class="discount-group">
                                    <label for="shipping-discount-select"><i class="fas fa-truck"
                                            style="margin-right: 5px; color: #555;"></i> Mã vận chuyển</label>
                                    <c:choose>
                                        <c:when test="${not empty shippingDiscounts}">
                                            <select id="shipping-discount-select" class="discount-select">
                                                <option value="">-- Chọn mã vận chuyển --</option>
                                                <c:forEach items="${shippingDiscounts}" var="d">
                                                    <option value="${d.discountCode}"
                                                        ${currentCart.shippingDiscount.discountCode==d.discountCode
                                                        ? 'selected' : '' }>
                                                        ${d.discountCode} - Giảm
                                                        <fmt:formatNumber value="${d.discountValue}" type="currency"
                                                            currencySymbol="₫" maxFractionDigits="0" />
                                                    </option>
                                                </c:forEach>
                                            </select>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="no-discount-msg">Không có mã vận chuyển khả dụng</div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <!-- Voucher Discount -->
                                <div class="discount-group">
                                    <label for="voucher-discount-select"><i class="fas fa-ticket-alt"
                                            style="margin-right: 5px; color: #555;"></i> Voucher của bạn</label>
                                    <c:choose>
                                        <c:when test="${not empty userVouchers}">
                                            <select id="voucher-discount-select" class="discount-select">
                                                <option value="">-- Chọn voucher --</option>
                                                <c:forEach items="${userVouchers}" var="d">
                                                    <option value="${d.discountCode}"
                                                        ${currentCart.voucherDiscount.discountCode==d.discountCode
                                                        ? 'selected' : '' }>
                                                        ${d.discountCode} - Giảm
                                                        <c:choose>
                                                            <c:when
                                                                test="${fn:toUpperCase(d.discountType) == 'PERCENT'}">
                                                                <fmt:formatNumber value="${d.discountValue}"
                                                                    type="number" maxFractionDigits="0" />%
                                                            </c:when>
                                                            <c:otherwise>
                                                                <fmt:formatNumber value="${d.discountValue}"
                                                                    type="currency" currencySymbol="₫"
                                                                    maxFractionDigits="0" />
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </option>
                                                </c:forEach>
                                            </select>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="no-discount-msg">Bạn chưa có voucher nào</div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <!-- Loyalty Discount -->
                                <div class="discount-group">
                                    <label><i class="fas fa-crown" style="margin-right: 5px; color: #c8a165;"></i> Khách
                                        hàng thân thiết</label>
                                    <div id="loyalty-discount-display"
                                        class="${currentCart.loyaltyDiscountAmount > 0 ? '' : 'inactive'}">
                                        <c:if test="${currentCart.loyaltyDiscountAmount > 0}">
                                            <div style="display: flex; align-items: center;">
                                                <i class="fas fa-check-circle"
                                                    style="margin-right: 8px; font-size: 18px;"></i>
                                                <div>
                                                    <div>Đã áp dụng ưu đãi thành viên</div>
                                                    <div style="font-size: 13px; font-weight: normal;">Giảm
                                                        <fmt:formatNumber value="${currentCart.loyaltyDiscountAmount}"
                                                            type="currency" currencySymbol="₫" maxFractionDigits="0" />
                                                    </div>
                                                </div>
                                            </div>
                                        </c:if>
                                        <c:if test="${currentCart.loyaltyDiscountAmount <= 0}">
                                            <div style="display: flex; align-items: center;">
                                                <i class="fas fa-info-circle"
                                                    style="margin-right: 8px; font-size: 18px;"></i>
                                                <div>Chưa đủ điều kiện áp dụng</div>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
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
                                            currencySymbol="₫" maxFractionDigits="0" />
                                    </td>
                                </tr>
                                <tr>
                                    <th>Khuyến mãi</th>
                                    <td>-
                                        <fmt:formatNumber value="${requestScope.discountAmount}" type="currency"
                                            currencySymbol="₫" maxFractionDigits="0" />
                                    </td>
                                </tr>
                                <tr>
                                    <th>Tổng</th>
                                    <td><strong>
                                            <fmt:formatNumber value="${requestScope.order.totalPrice}" type="currency"
                                                currencySymbol="₫" maxFractionDigits="0" />
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

                        const savedPaymentMethod = sessionStorage.getItem('selectedPaymentMethod');
                        if (savedPaymentMethod) {
                            const option = document.querySelector(`.payment-option[data-value="${savedPaymentMethod}"]`);
                            if (option) {
                                const radio = option.querySelector('input[type="radio"]');
                                radio.checked = true;
                                document.getElementById('selected-payment-text').textContent = paymentNames[savedPaymentMethod];
                                paymentOptions.forEach(opt => opt.classList.remove('selected'));
                                option.classList.add('selected');
                            }
                        }

                        // Discount Handling
                        const shippingSelect = document.getElementById('shipping-discount-select');
                        const voucherSelect = document.getElementById('voucher-discount-select');
                        const discountToggleBtn = document.getElementById('discount-toggle-btn');
                        const discountContentArea = document.getElementById('discount-content-area');

                        if (discountToggleBtn) {
                            discountToggleBtn.addEventListener('click', function () {
                                this.classList.toggle('active');
                                discountContentArea.classList.toggle('show');
                            });
                        }

                        function applyDiscount(type, code) {
                            fetch('${pageContext.request.contextPath}/cart/apply-discount', {
                                method: 'POST',
                                headers: {
                                    'Content-Type': 'application/x-www-form-urlencoded',
                                },
                                body: 'type=' + type + '&code=' + code
                            })
                                .then(response => response.json())
                                .then(data => {
                                    if (data.success) {
                                        window.location.reload();
                                    } else {
                                        alert(data.message);
                                        window.location.reload();
                                    }
                                })
                                .catch(error => {
                                    console.error('Error:', error);
                                    alert('Có lỗi xảy ra khi áp dụng mã giảm giá');
                                });
                        }

                        if (shippingSelect) {
                            shippingSelect.addEventListener('change', function () {
                                applyDiscount('shipping', this.value);
                            });
                        }

                        if (voucherSelect) {
                            voucherSelect.addEventListener('change', function () {
                                applyDiscount('voucher', this.value);
                            });
                        }


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

                                // Save to sessionStorage
                                sessionStorage.setItem('selectedPaymentMethod', value);
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
                            form.action = "${pageContext.request.contextPath}/checkout";
                            // Clear sessionStorage on successful submit (optional, but good practice)
                            sessionStorage.removeItem('selectedPaymentMethod');
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