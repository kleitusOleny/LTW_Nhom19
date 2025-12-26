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
                                <img src=${ci.product.imageUrl} alt="${ci.product.productName}">
                            </a>
                        </td>
                        <td class="cart-product-name">
                            <a href="detail?id=${ci.product.id}">${ci.product.productName}</a>
                        </td>
                        <td class="cart-product-price">
                            <fmt:setLocale value="vi_VN"/>
                            <fmt:formatNumber value="${ci.product.price}" type="currency" currencySymbol="₫"
                                              maxFractionDigits="0"/>
                        </td>
                        <td class="cart-product-quantity">
                            <div class="quantity-selector">
                                <button class="quantity-btn">-</button>
                                <input type="number" value=${ci.quantity} min="1">
                                <button class="quantity-btn">+</button>
                            </div>
                        </td>
                        <td class="cart-product-subtotal">
                            <fmt:setLocale value="vi_VN"/>
                            <fmt:formatNumber value="${ci.quantity * ci.product.price}" type="currency" currencySymbol="₫"
                                              maxFractionDigits="0"/>
                        </td>
                        <td class="cart-product-remove">
                            <a href="#" class="remove-item-btn" aria-label="Xóa sản phẩm">
                                <i class="fa-solid fa-trash-can"></i>
                            </a>
                        </td>
                    </tr>
                    </c:forEach>
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

<%@ include file="components/footer.jsp" %>

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
