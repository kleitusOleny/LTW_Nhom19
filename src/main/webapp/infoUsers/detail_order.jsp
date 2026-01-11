<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Chi tiết đơn hàng</title>
                <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
                <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
                <%-- <link rel="stylesheet" href="../css/store_style.css">--%>
                    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/detail_order_style.css">
            </head>
            <%@ include file="../components/header.jsp" %>

                <body>

                    <div class="order-detail">
                        <h1>Chi tiết đơn hàng #${order.id}</h1>

                        <div class="section info">
                            <h2>Thông tin khách hàng</h2>
                            <p><strong>Họ và tên:</strong> ${shippingAddress.fullName}</p>
                            <p><strong>Email:</strong> ${sessionScope.user.email}</p>
                            <p><strong>Điện thoại:</strong> ${shippingAddress.phoneNumber}</p>
                            <p><strong>Địa chỉ:</strong> ${shippingAddress.addressLine}, ${shippingAddress.ward},
                                ${shippingAddress.city}</p>
                            <p><strong>Ghi chú:</strong> ${order.note}</p>
                            <p><strong>Hình thức thanh toán:</strong> ${payment.payStrategy}</p>
                        </div>

                        <div class="section">
                            <h2>Sản phẩm</h2>
                            <table>
                                <thead>
                                    <tr>
                                        <th>Hình ảnh</th>
                                        <th>Sản phẩm</th>
                                        <th>Số lượng</th>
                                        <th>Đơn giá</th>
                                        <th>Tổng</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${order.items}" var="item">
                                        <c:set var="product" value="${productMap[item.productId]}" />
                                        <tr>
                                            <td><img class="product-img" src="${product.imageUrl}"
                                                    alt="${product.productName}"></td>
                                            <td>${product.productName}</td>
                                            <td>${item.quantity}</td>
                                            <td>
                                                <fmt:setLocale value="vi_VN" />
                                                <fmt:formatNumber value="${item.unitPrice}" type="currency"
                                                    currencySymbol="₫" maxFractionDigits="0" />
                                            </td>
                                            <td>
                                                <fmt:formatNumber value="${item.quantity * item.unitPrice}"
                                                    type="currency" currencySymbol="₫" maxFractionDigits="0" />
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                                <tfoot>
                                    <tr>
                                        <th colspan="4" style="text-align:right">Tổng cộng:</th>
                                        <th>
                                            <fmt:setLocale value="vi_VN" />
                                            <fmt:formatNumber value="${order.totalPrice}" type="currency"
                                                currencySymbol="₫" maxFractionDigits="0" />
                                        </th>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>

                        <div class="section">
                            <h2>Trạng thái đơn hàng</h2>
                            <span class="status completed">${shipOrder != null ? shipOrder.status : (payment.status ==
                                'Failed' ? 'Thanh toán thất bại' : 'Đang xử lý')}</span>

                            <div class="tracking-bar">
                                <c:set var="progressWidth" value="0%" />
                                <c:choose>
                                    <c:when test="${shipOrder.status == 'Đang giao hàng'}">
                                        <c:set var="progressWidth" value="50%" />
                                    </c:when>
                                    <c:when test="${shipOrder.status == 'Giao hàng thành công'}">
                                        <c:set var="progressWidth" value="100%" />
                                    </c:when>
                                </c:choose>
                                <div class="tracking-progress" style="width: ${progressWidth};"></div>

                                <div
                                    class="tracking-step ${shipOrder.status == 'Chuẩn bị đơn hàng' || shipOrder.status == 'Đang giao hàng' || shipOrder.status == 'Giao hàng thành công' ? 'active' : ''}">
                                    <div class="step-dot"></div>
                                    <div class="step-label">Đang xử lý</div>
                                </div>
                                <div
                                    class="tracking-step ${shipOrder.status == 'Đang giao hàng' || shipOrder.status == 'Giao hàng thành công' ? 'active' : ''}">
                                    <div class="step-dot"></div>
                                    <div class="step-label">Đang giao</div>
                                </div>
                                <div
                                    class="tracking-step ${shipOrder.status == 'Giao hàng thành công' ? 'active' : ''}">
                                    <div class="step-dot"></div>
                                    <div class="step-label">Đã giao</div>
                                </div>
                            </div>
                        </div>

                        <div class="actions">
                            <button class="btn" onclick="location.href='${pageContext.request.contextPath}/store'">Mua
                                lại</button>
                            <button class="btn" id="exportPDF">In hóa đơn</button>
                        </div>
                    </div>
                    <%@ include file="../components/footer.jsp" %>
                        <script>
                            document.getElementById("exportPDF").addEventListener("click", function () {

                                const element = document.querySelector(".order-detail");

                                const sections = document.querySelectorAll(".order-detail .section");
                                const actions = document.querySelector(".order-detail .actions");

                                let removedSection = null;
                                if (sections[2]) {
                                    removedSection = sections[2];
                                    removedSection.style.display = "none";
                                }

                                let removedActions = null;
                                if (actions) {
                                    removedActions = actions;
                                    removedActions.style.display = "none";
                                }

                                const opt = {
                                    margin: 10,
                                    filename: 'don-hang.pdf',
                                    image: { type: 'jpeg', quality: 0.98 },
                                    html2canvas: { scale: 2, scrollY: 0 },
                                    jsPDF: { unit: 'mm', format: 'a4', orientation: 'portrait' }
                                };

                                html2pdf().from(element).set(opt).save()
                                    .then(() => {
                                        if (removedSection) removedSection.style.display = "";
                                        if (removedActions) removedActions.style.display = "";
                                    });

                            });


                        </script>

                        <script
                            src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"></script>
                </body>

            </html>