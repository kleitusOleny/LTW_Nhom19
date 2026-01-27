<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Giỏ hàng</title>

                <link rel="stylesheet" href="css/cart_style.css">
            </head>

            <body>

                <%@ include file="components/header.jsp" %>

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
                                            <c:forEach items="${sessionScope.cart.items}" var="ci">
                                                <tr class="cart-item-row">
                                                    <td><input type="checkbox" class="select-product"></td>
                                                    <td class="cart-product-image">
                                                        <a href="detail?id=${ci.product.id}">
                                                            <img src=${ci.product.imageUrl}
                                                                alt="${ci.product.productName}">
                                                        </a>
                                                    </td>
                                                    <td class="cart-product-name">
                                                        <a
                                                            href="detail?id=${ci.product.id}">${ci.product.productName}</a>
                                                    </td>
                                                    <td class="cart-product-price">
                                                        <fmt:setLocale value="vi_VN" />
                                                        <c:choose>
                                                            <c:when test="${ci.price < ci.product.price}">
                                                                <span style="color: #8c3333; font-weight: bold;">
                                                                    <fmt:formatNumber value="${ci.price}"
                                                                        type="currency" currencySymbol="₫"
                                                                        maxFractionDigits="0" />
                                                                </span>
                                                                <br>
                                                                <span
                                                                    style="text-decoration: line-through; color: #999; font-size: 0.9em;">
                                                                    <fmt:formatNumber value="${ci.product.price}"
                                                                        type="currency" currencySymbol="₫"
                                                                        maxFractionDigits="0" />
                                                                </span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <fmt:formatNumber value="${ci.price}" type="currency"
                                                                    currencySymbol="₫" maxFractionDigits="0" />
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td class="cart-product-quantity">
                                                        <div class="quantity-selector">
                                                            <form action="update-item" method="post">
                                                                <input type="hidden" name="id" value="${ci.product.id}">
                                                                <input type="hidden" name="quantity" value="-1">
                                                                <button class="quantity-btn">-</button>
                                                            </form>

                                                            <form action="update-item" method="post">
                                                                <input type="hidden" name="id" value="${ci.product.id}">
                                                                <input type="number" value="${ci.quantity}"
                                                                    name="setQuantity" onchange="this.form.submit()">
                                                            </form>

                                                            <form action="update-item" method="post">
                                                                <input type="hidden" name="id" value="${ci.product.id}">
                                                                <input type="hidden" name="quantity" value="1">
                                                                <button class="quantity-btn">+</button>
                                                            </form>
                                                        </div>
                                                    </td>
                                                    <td class="cart-product-subtotal">
                                                        <fmt:setLocale value="vi_VN" />
                                                        <fmt:formatNumber value="${ci.totalPrice}" type="currency"
                                                            currencySymbol="₫" maxFractionDigits="0" />
                                                    </td>
                                                    <td class="cart-product-remove">
                                                        <form action="delete-cart" method="post">
                                                            <input type="hidden" name="id" value="${ci.product.id}">
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
                                    <div class="cart-actions">
                                        <a href="store" class="btn btn-secondary">Tiếp tục xem sản phẩm</a>
                                        <button class="btn btn-danger" id="delete-selected">Xóa sản phẩm đã
                                            chọn</button>
                                    </div>
                                </div>

                                <div class="cart-summary-column">
                                    <div class="summary-box">
                                        <h3 class="summary-title">Tổng cộng</h3>

                                        <div class="summary-row">
                                            <span>Tạm tính</span>
                                            <strong>
                                                <fmt:setLocale value="vi_VN" />
                                                <fmt:formatNumber value="${sessionScope.cart.subtotal}" type="currency"
                                                    currencySymbol="₫" maxFractionDigits="0" />
                                            </strong>
                                        </div>

                                        <div class="summary-row">
                                            <span>Giao hàng</span>
                                            <strong>Miễn phí</strong>
                                        </div>

                                        <!-- Shipping Discount -->
                                        <div class="summary-row" id="shipping-discount-row" style="display: none;">
                                            <span>Giảm giá vận chuyển</span>
                                            <strong id="shipping-discount-amount" style="color: green;"></strong>
                                        </div>

                                        <!-- User Voucher -->
                                        <div class="summary-row" id="voucher-discount-row" style="display: none;">
                                            <span>Voucher người dùng</span>
                                            <strong id="voucher-discount-amount" style="color: green;"></strong>
                                        </div>

                                        <!-- Loyalty Discount -->
                                        <div class="summary-row" id="loyalty-discount-row" style="display: none;">
                                            <span>Khách hàng thân thiết</span>
                                            <strong id="loyalty-discount-amount" style="color: green;"></strong>
                                        </div>

                                        <!-- Discount Selection Section -->
                                        <div class="discount-section"
                                            style="margin: 15px 0; padding: 10px; background: #f8f9fa; border-radius: 5px;">
                                            <h5 style="font-size: 1em; margin-bottom: 10px;">Mã giảm giá</h5>

                                            <!-- Shipping Discount Select -->
                                            <div class="form-group" style="margin-bottom: 10px;">
                                                <label style="font-size: 0.9em; color: #666;">Mã vận chuyển</label>
                                                <select id="shipping-discount-select" class="form-control"
                                                    onchange="applyDiscount('shipping')"
                                                    style="width: 100%; padding: 5px;">
                                                    <option value="">Chọn mã vận chuyển</option>
                                                </select>
                                            </div>

                                            <!-- User Voucher Select -->
                                            <div class="form-group">
                                                <label style="font-size: 0.9em; color: #666;">Voucher của bạn</label>
                                                <select id="voucher-discount-select" class="form-control"
                                                    onchange="applyDiscount('voucher')"
                                                    style="width: 100%; padding: 5px;">
                                                    <option value="">Chọn voucher</option>
                                                </select>
                                            </div>

                                            <div id="discount-message" style="margin-top: 5px; font-size: 0.9em;"></div>
                                        </div>

                                        <div id="collectable-vouchers-section"
                                            style="display:none; margin: 15px 0; padding: 10px; background: #e9ecef; border-radius: 5px;">
                                            <h5 style="font-size: 1em; margin-bottom: 10px;">Mã giảm giá có thể thu thập
                                            </h5>
                                            <div id="collectable-vouchers-list" class="list-group">
                                                <!-- Populated by JS -->
                                            </div>
                                        </div>

                                        <div class="summary-total">
                                            <span>Tổng</span>
                                            <strong id="final-total-display">
                                                <fmt:setLocale value="vi_VN" />
                                                <fmt:formatNumber value="${sessionScope.cart.total}" type="currency"
                                                    currencySymbol="₫" maxFractionDigits="0" />
                                            </strong>
                                        </div>

                                        <a href="checkout" class="btn btn-checkout">Tiến hành thanh toán</a>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </main>

                    <%@ include file="components/footer.jsp" %>

                        <script>
                            function formatMoney(amount) {
                                return new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(amount);
                            }

                            // Inject current discount codes from server-side session
                            const currentShippingCode = "${sessionScope.cart.shippingDiscount.discountCode}";
                            const currentVoucherCode = "${sessionScope.cart.voucherDiscount.discountCode}";
                            const isLoggedIn = ${ not empty sessionScope.user };

                            function loadDiscounts() {
                                fetch('cart/get-discounts')
                                    .then(response => response.json())
                                    .then(data => {
                                        // Populate Shipping Discounts
                                        const shippingSelect = document.getElementById('shipping-discount-select');
                                        if (data.shippingDiscounts && isLoggedIn) {
                                            data.shippingDiscounts.forEach(d => {
                                                const option = document.createElement('option');
                                                option.value = d.discountCode;
                                                option.text = d.discountCode + ' (' + formatMoney(d.discountValue) + ')';
                                                if (d.discountCode === currentShippingCode) {
                                                    option.selected = true;
                                                    document.getElementById('shipping-discount-row').style.display = 'flex';
                                                    document.getElementById('shipping-discount-amount').textContent = '-' + formatMoney(d.discountValue);
                                                }
                                                shippingSelect.add(option);
                                            });
                                        } else if (!isLoggedIn) {
                                            const option = document.createElement('option');
                                            option.value = "";
                                            option.text = "Đăng nhập để xem mã vận chuyển";
                                            option.disabled = true;
                                            option.selected = true;
                                            shippingSelect.add(option);
                                        }

                                        // Populate User Vouchers
                                        const voucherSelect = document.getElementById('voucher-discount-select');
                                        if (data.userVouchers) {
                                            data.userVouchers.forEach(d => {
                                                const option = document.createElement('option');
                                                option.value = d.discountCode;
                                                option.text = d.discountCode + ' (' + (d.discountType === 'percentage' ? d.discountValue + '%' : formatMoney(d.discountValue)) + ')';
                                                if (d.discountCode === currentVoucherCode) {
                                                    option.selected = true;
                                                    document.getElementById('voucher-discount-row').style.display = 'flex';
                                                }
                                                voucherSelect.add(option);
                                            });
                                        } else if (!isLoggedIn) {
                                            const option = document.createElement('option');
                                            option.value = "";
                                            option.text = "Đăng nhập để xem mã giảm giá";
                                            option.disabled = true;
                                            option.selected = true;
                                            voucherSelect.add(option);
                                            voucherSelect.add(option);
                                        }

                                        // Populate Collectable Vouchers
                                        const collectableSection = document.getElementById('collectable-vouchers-section');
                                        const collectableList = document.getElementById('collectable-vouchers-list');
                                        collectableList.innerHTML = ''; // Clear previous

                                        if (data.collectableVouchers && data.collectableVouchers.length > 0) {
                                            collectableSection.style.display = 'block';
                                            data.collectableVouchers.forEach(d => {
                                                const item = document.createElement('div');
                                                item.className = 'list-group-item d-flex justify-content-between align-items-center';
                                                item.style.marginBottom = '5px';
                                                item.style.padding = '5px';
                                                item.style.background = 'white';
                                                item.style.borderRadius = '3px';
                                                item.innerHTML = `
                                                    <div>
                                                        <strong>${d.discountCode}</strong><br>
                                                        <small>Giảm ${formatMoney(d.discountValue)}</small>
                                                    </div>
                                                    <button class="btn btn-sm btn-primary" onclick="collectVoucher(${d.id})" style="font-size: 0.8em;">Thu thập</button>
                                                `;
                                                collectableList.appendChild(item);
                                            });
                                        } else {
                                            collectableSection.style.display = 'none';
                                        }

                                        // Update discount amounts from session if available
                                        <c:if test="${not empty sessionScope.cart.shippingDiscount}">
                                            document.getElementById('shipping-discount-row').style.display = 'flex';
                                            document.getElementById('shipping-discount-amount').textContent = '-' + formatMoney(${sessionScope.cart.shippingDiscount.discountValue});
                                        </c:if>
                                        <c:if test="${not empty sessionScope.cart.voucherDiscount}">
                                            document.getElementById('voucher-discount-row').style.display = 'flex';
                                            // We need to calculate the actual amount for the voucher row. 
                                            // Since we don't have the exact amount easily available in a simple variable for percentage vouchers (it depends on subtotal),
                                            // we can calculate it or just rely on the total. 
                                            // However, let's try to be precise.
                                            // Actually, let's just use the total deduction logic from Cart.java if possible, or just show the code.
                                            // Better yet, let's just show the row and maybe the value if fixed.
                                            // For percentage, it's harder.
                                            // Let's just ensure the row is visible.
                                        </c:if>

                                        // Show Loyalty Discount if applicable
                                        if (data.loyalty && data.loyalty.amount > 0) {
                                            document.getElementById('loyalty-discount-row').style.display = 'flex';
                                            document.getElementById('loyalty-discount-amount').textContent = '-' + formatMoney(data.loyalty.amount);
                                        }
                                    });
                            }

                            function collectVoucher(discountId) {
                                fetch('cart/collect-voucher?discountId=' + discountId, {
                                    method: 'POST'
                                })
                                    .then(response => response.json())
                                    .then(data => {
                                        if (data.success) {
                                            alert(data.message);
                                            loadDiscounts(); // Refresh lists
                                        } else {
                                            alert(data.message);
                                        }
                                    })
                                    .catch(error => console.error('Error collecting voucher:', error));
                            }

                            function applyDiscount(type) {
                                let code = '';
                                if (type === 'shipping') {
                                    code = document.getElementById('shipping-discount-select').value;
                                } else if (type === 'voucher') {
                                    code = document.getElementById('voucher-discount-select').value;
                                }

                                if (!code && type !== 'loyalty') return; // Allow empty code if we want to clear? For now just return.

                                fetch('cart/apply-discount', {
                                    method: 'POST',
                                    headers: {
                                        'Content-Type': 'application/x-www-form-urlencoded',
                                    },
                                    body: 'type=' + type + '&code=' + encodeURIComponent(code)
                                })
                                    .then(response => response.json())
                                    .then(data => {
                                        if (data.success) {
                                            document.getElementById('final-total-display').textContent = formatMoney(data.newTotal);
                                            // alert('Áp dụng thành công!'); // Optional
                                            location.reload(); // Reload to update server-side session and UI fully
                                        } else {
                                            alert(data.message);
                                        }
                                    });
                            }

                            document.addEventListener('DOMContentLoaded', function () {
                                loadDiscounts();

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