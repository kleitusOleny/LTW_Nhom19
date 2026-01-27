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
                        <tr class="cart-item-row" id="row-${ci.product.id}">
                            <td><input type="checkbox" class="select-product" value="${ci.product.id}"></td>
                            <td class="cart-product-image">
                                <a href="detail?id=${ci.product.id}">
                                    <img src="${ci.product.imageUrl}" alt="${ci.product.productName}">
                                </a>
                            </td>
                            <td class="cart-product-name">
                                <a href="detail?id=${ci.product.id}">${ci.product.productName}</a>
                            </td>
                            <td class="cart-product-price">
                                <fmt:setLocale value="vi_VN"/>
                                <fmt:formatNumber value="${ci.product.price}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                            </td>
                            <td class="cart-product-quantity">
                                <div class="quantity-selector">
                                    <button type="button" class="quantity-btn" onclick="updateQuantity('${ci.product.id}', -1)">-</button>

                                    <input type="number"
                                           id="qty-${ci.product.id}"
                                           value="${ci.quantity}"
                                           onchange="updateQuantity('${ci.product.id}', 0, this.value)">

                                    <button type="button" class="quantity-btn" onclick="updateQuantity('${ci.product.id}', 1)">+</button>
                                </div>
                            </td>
                            <td class="cart-product-subtotal" id="subtotal-${ci.product.id}"
                                data-value="${ci.quantity * ci.product.price}"> <fmt:setLocale value="vi_VN"/>
                                <fmt:formatNumber value="${ci.quantity * ci.product.price}"
                                                  type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                            </td>
                            <td class="cart-product-remove">
                                <button class="remove-item-btn" aria-label="Xóa sản phẩm"
                                        style="border: 0; background: white"
                                        onclick="removeItem('${ci.product.id}')">
                                    <i class="fa-solid fa-trash-can"></i>
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
                <div class="cart-actions">
                    <a href="store" class="btn btn-secondary">Tiếp tục xem sản phẩm</a>
                    <button class="btn btn-danger" id="delete-selected">Xóa sản phẩm đã chọn</button>
                </div>
            </div>

            <div class="cart-summary-column">
                <div class="summary-box">
                    <h3 class="summary-title">Tổng cộng</h3>

                    <div class="summary-row">
                        <span>Tạm tính</span>
                        <strong>
                            <fmt:setLocale value="vi_VN"/>
                            <fmt:formatNumber value="${sessionScope.cart.total}" type="currency" currencySymbol="₫"
                                              maxFractionDigits="0"/>
                        </strong>
                    </div>

                    <div class="summary-row">
                        <span>Giao hàng</span>
                        <strong>Miễn phí</strong>
                    </div>

                    <div class="summary-total">
                        <span>Tổng</span>
                        <strong id="cart-total-display">
                            <fmt:setLocale value="vi_VN"/>
                            <fmt:formatNumber value="${sessionScope.cart.total}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
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
    // --- 1. CÁC HÀM XỬ LÝ TOÀN CỤC (GLOBAL FUNCTIONS) ---

    // Hàm format tiền tệ VNĐ
    const formatCurrency = (amount) => {
        const number = parseFloat(amount);
        if (isNaN(number)) return '0 ₫';
        return new Intl.NumberFormat('vi-VN', {
            style: 'currency',
            currency: 'VND'
        }).format(number).replace('₫', '').trim() + ' ₫';
    };

    // Hàm tính tổng tiền dựa trên các checkbox đang được chọn
    function updateSelectedTotal() {
        let total = 0;
        const checkedBoxes = document.querySelectorAll('.select-product:checked');

        checkedBoxes.forEach(checkbox => {
            const id = checkbox.value;
            const subtotalElement = document.getElementById('subtotal-' + id);

            // Lấy giá trị gốc từ data-value
            if (subtotalElement) {
                const value = parseFloat(subtotalElement.getAttribute('data-value'));
                if (!isNaN(value)) {
                    total += value;
                }
            }
        });

        // Hiển thị tổng tiền mới
        document.getElementById('cart-total-display').innerText = formatCurrency(total);
    }

    // Hàm cập nhật số lượng (AJAX)
    function updateQuantity(id, delta, setValue = null) {
        const input = document.getElementById('qty-' + id);
        let currentQty = parseInt(input.value);
        let newQty = currentQty;

        const params = new URLSearchParams();
        params.append('id', id);

        if (setValue !== null) {
            newQty = parseInt(setValue);
            if (isNaN(newQty) || newQty < 1) newQty = 1;
            params.append('setQuantity', newQty);
        } else {
            if (delta === -1 && currentQty <= 1) return;
            params.append('quantity', delta);
        }

        fetch('update-item', {
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'},
            body: params
        })
            .then(response => response.json())
            .then(data => {
                // Cập nhật input
                input.value = data.quantity;

                // Cập nhật text hiển thị thành tiền của item
                const subtotalEl = document.getElementById('subtotal-' + id);
                subtotalEl.innerText = formatCurrency(data.subtotal);

                // Cập nhật giá trị thô để tính toán
                subtotalEl.setAttribute('data-value', data.subtotal);

                updateSelectedTotal();
            })
            .catch(error => console.error('Error:', error));
    }

    // Hàm xóa 1 sản phẩm (AJAX)
    function removeItem(id) {
        if (!confirm('Bạn có chắc chắn muốn xóa sản phẩm này?')) return;

        const params = new URLSearchParams();
        params.append('id', id);
        params.append('ajax', 'true');

        fetch('delete-cart', {
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            body: params
        })
            .then(response => response.json())
            .then(data => {
                const row = document.getElementById('row-' + id);
                if (row) row.remove();

                // Tính lại tổng ngay lập tức
                updateSelectedTotal();

                // Nếu hết sản phẩm thì reload
                if (document.querySelectorAll('.cart-item-row').length === 0) {
                    location.reload();
                }
            })
            .catch(error => console.error('Error:', error));
    }

    // --- 2. LOGIC KHỞI TẠO KHI LOAD TRANG ---
    document.addEventListener('DOMContentLoaded', function () {
        const selectAllCheckbox = document.getElementById('select-all');
        const productCheckboxes = document.querySelectorAll('.select-product');
        const deleteSelectedButton = document.getElementById('delete-selected');

        // Logic "Chọn tất cả"
        if (selectAllCheckbox) {
            selectAllCheckbox.addEventListener('change', function () {
                productCheckboxes.forEach(checkbox => {
                    checkbox.checked = selectAllCheckbox.checked;
                });
                updateSelectedTotal(); // Cập nhật tổng tiền khi bấm Select All
            });
        }

        // Logic cho từng checkbox con
        productCheckboxes.forEach(checkbox => {
            checkbox.addEventListener('change', function () {
                const allChecked = Array.from(productCheckboxes).every(cb => cb.checked);
                const someChecked = Array.from(productCheckboxes).some(cb => cb.checked);

                if (selectAllCheckbox) {
                    selectAllCheckbox.checked = allChecked;
                    selectAllCheckbox.indeterminate = someChecked && !allChecked;
                }

                updateSelectedTotal(); // Cập nhật tổng tiền khi bấm checkbox lẻ
            });
        });

        // Logic nút "Xóa đã chọn"
        if (deleteSelectedButton) {
            deleteSelectedButton.addEventListener('click', function () {
                const selectedCheckboxes = document.querySelectorAll('.select-product:checked');

                if (selectedCheckboxes.length === 0) {
                    alert('Vui lòng chọn ít nhất một sản phẩm để xóa.');
                    return;
                }

                if (!confirm('Bạn có chắc chắn muốn xóa ' + selectedCheckboxes.length + ' sản phẩm đã chọn?')) {
                    return;
                }

                // Gom ID thành chuỗi: "101,102,103"
                const listIds = Array.from(selectedCheckboxes).map(cb => cb.value).join(',');

                const params = new URLSearchParams();
                params.append('listId', listIds);
                params.append('ajax', 'true');

                fetch('delete-cart', {
                    method: 'POST',
                    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                    body: params
                })
                    .then(response => response.json())
                    .then(data => {
                        // Xóa các dòng khỏi bảng
                        selectedCheckboxes.forEach(checkbox => {
                            const row = checkbox.closest('tr');
                            if (row) row.remove();
                        });

                        // Reset nút chọn tất cả
                        if (selectAllCheckbox) {
                            selectAllCheckbox.checked = false;
                            selectAllCheckbox.indeterminate = false;
                        }

                        // Tính lại tổng
                        updateSelectedTotal();

                        if (document.querySelectorAll('.cart-item-row').length === 0) {
                            location.reload();
                        } else {
                            alert('Đã xóa thành công.');
                        }
                    })
                    .catch(error => console.error('Error:', error));
            });
        }

        updateSelectedTotal();
    });
</script>
</body>
