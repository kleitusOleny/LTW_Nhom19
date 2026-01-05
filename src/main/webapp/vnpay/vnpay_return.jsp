<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Kết quả thanh toán</title>
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
                <link rel="stylesheet" href="../css/store_style.css">
                <link rel="stylesheet" href="../css/payment_style.css">
                <style>
                    .result-container {
                        max-width: 600px;
                        margin: 50px auto;
                        padding: 30px;
                        background: #fff;
                        border-radius: 8px;
                        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                        text-align: center;
                    }

                    .result-icon {
                        font-size: 60px;
                        margin-bottom: 20px;
                    }

                    .success-icon {
                        color: #28a745;
                    }

                    .error-icon {
                        color: #dc3545;
                    }

                    .result-title {
                        font-size: 24px;
                        margin-bottom: 10px;
                        color: #333;
                    }

                    .result-message {
                        color: #666;
                        margin-bottom: 30px;
                    }

                    .transaction-details {
                        text-align: left;
                        background: #f8f9fa;
                        padding: 20px;
                        border-radius: 6px;
                        margin-bottom: 30px;
                    }

                    .detail-row {
                        display: flex;
                        justify-content: space-between;
                        margin-bottom: 10px;
                        padding-bottom: 10px;
                        border-bottom: 1px solid #eee;
                    }

                    .detail-row:last-child {
                        border-bottom: none;
                        margin-bottom: 0;
                        padding-bottom: 0;
                    }

                    .detail-label {
                        font-weight: 600;
                        color: #555;
                    }

                    .detail-value {
                        color: #333;
                    }

                    .action-buttons {
                        display: flex;
                        gap: 15px;
                        justify-content: center;
                    }

                    .btn {
                        padding: 10px 20px;
                        border-radius: 4px;
                        text-decoration: none;
                        font-weight: 600;
                        transition: all 0.3s;
                    }

                    .btn-primary {
                        background: #007bff;
                        color: white;
                    }

                    .btn-secondary {
                        background: #6c757d;
                        color: white;
                    }

                    .btn:hover {
                        opacity: 0.9;
                    }
                </style>
            </head>

            <body>
                <%@ include file="../components/header.jsp" %>

                    <main class="container">
                        <div class="result-container">
                            <c:set var="amount"
                                value="${requestScope.amount != null ? requestScope.amount : param.vnp_Amount / 100}" />
                            <c:set var="orderInfo"
                                value="${requestScope.orderInfo != null ? requestScope.orderInfo : param.vnp_OrderInfo}" />
                            <c:set var="payDate"
                                value="${requestScope.payDate != null ? requestScope.payDate : param.vnp_PayDate}" />

                            <c:choose>
                                <c:when test="${requestScope.transResult}">
                                    <div class="result-icon success-icon">
                                        <i class="fas fa-check-circle"></i>
                                    </div>
                                    <c:choose>
                                        <c:when test="${requestScope.paymentCode == 'COD'}">
                                            <h1 class="result-title">Đặt hàng thành công!</h1>
                                            <p class="result-message">Cảm ơn bạn đã mua hàng. Đơn hàng của bạn đã được
                                                ghi nhận và sẽ được thanh toán khi nhận hàng.</p>
                                        </c:when>
                                        <c:otherwise>
                                            <h1 class="result-title">Thanh toán thành công!</h1>
                                            <p class="result-message">Cảm ơn bạn đã mua hàng. Đơn hàng của bạn đã được
                                                thanh toán thành công qua VNPay.</p>
                                        </c:otherwise>
                                    </c:choose>
                                </c:when>
                                <c:otherwise>
                                    <div class="result-icon error-icon">
                                        <i class="fas fa-times-circle"></i>
                                    </div>
                                    <h1 class="result-title">Thanh toán thất bại</h1>
                                    <p class="result-message">Giao dịch không thành công. Vui lòng kiểm tra lại thông
                                        tin hoặc thử lại sau.</p>
                                </c:otherwise>
                            </c:choose>

                            <div class="transaction-details">
                                <div class="detail-row">
                                    <span class="detail-label">Mã đơn hàng:</span>
                                    <span class="detail-value">#${requestScope.orderId}</span>
                                </div>
                                <div class="detail-row">
                                    <span class="detail-label">Mã giao dịch:</span>
                                    <span class="detail-value">${requestScope.paymentCode}</span>
                                </div>
                                <div class="detail-row">
                                    <span class="detail-label">Số tiền:</span>
                                    <span class="detail-value">
                                        <fmt:setLocale value="vi_VN" />
                                        <fmt:formatNumber value="${amount}" type="currency" currencySymbol="₫"
                                            maxFractionDigits="0" />
                                    </span>
                                </div>
                                <div class="detail-row">
                                    <span class="detail-label">Nội dung:</span>
                                    <span class="detail-value">${orderInfo}</span>
                                </div>
                                <div class="detail-row">
                                    <span class="detail-label">Thời gian:</span>
                                    <span class="detail-value">${payDate}</span>
                                </div>
                            </div>

                            <div class="action-buttons">
                                <a href="${pageContext.request.contextPath}/store" class="btn btn-secondary">Tiếp tục
                                    mua sắm</a>
                                <a href="${pageContext.request.contextPath}/order-detail?id=${requestScope.orderId}"
                                    class="btn btn-primary">Xem đơn
                                    hàng</a>
                            </div>
                        </div>
                    </main>

                    <%@ include file="../components/footer.jsp" %>
            </body>

            </html>