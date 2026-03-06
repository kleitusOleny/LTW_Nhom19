<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <title>Hóa đơn #${info.id}</title>
            <style>
                body {
                    font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;
                    font-size: 14px;
                    line-height: 1.6;
                    color: #333;
                    padding: 40px;
                    max-width: 800px;
                    margin: 0 auto;
                }

                .header {
                    text-align: center;
                    margin-bottom: 40px;
                    border-bottom: 2px solid #eee;
                    padding-bottom: 20px;
                }

                .header h1 {
                    color: #a94442;
                    margin: 0;
                    text-transform: uppercase;
                }

                .info-section {
                    margin-bottom: 30px;
                    display: flex;
                    justify-content: space-between;
                }

                .info-col {
                    width: 48%;
                }

                .info-col h3 {
                    border-bottom: 1px solid #ddd;
                    padding-bottom: 5px;
                    margin-top: 0;
                    color: #555;
                }

                .info-row {
                    margin-bottom: 5px;
                }

                .info-label {
                    font-weight: bold;
                    display: inline-block;
                    width: 120px;
                }

                table {
                    width: 100%;
                    border-collapse: collapse;
                    margin-bottom: 30px;
                }

                th,
                td {
                    border: 1px solid #ddd;
                    padding: 10px;
                    text-align: left;
                }

                th {
                    background-color: #f5f5f5;
                    font-weight: bold;
                }

                .total-section {
                    text-align: right;
                    font-size: 18px;
                    font-weight: bold;
                    margin-top: 20px;
                }

                .footer {
                    margin-top: 50px;
                    text-align: center;
                    font-size: 12px;
                    color: #777;
                    border-top: 1px solid #eee;
                    padding-top: 20px;
                }

                @media print {
                    body {
                        padding: 0;
                    }

                    .no-print {
                        display: none;
                    }
                }
            </style>
        </head>

        <body onload="window.print()">

            <div class="header">
                <h1>Hóa Đơn Bán Hàng</h1>
                <p>Mã đơn hàng: #DH${info.id}</p>
                <p>Ngày đặt: ${info.create_at}</p>
            </div>

            <div class="info-section">
                <div class="info-col">
                    <h3>Thông tin khách hàng</h3>
                    <div class="info-row"><span class="info-label">Họ tên:</span> ${info.full_name}</div>
                    <div class="info-row"><span class="info-label">Email:</span> ${info.email}</div>
                    <div class="info-row"><span class="info-label">Điện thoại:</span> ${info.phone_number}</div>
                    <div class="info-row"><span class="info-label">Địa chỉ:</span>
                        ${info.specific_address}, ${info.ward}, ${info.district}, ${info.province_city}
                    </div>
                </div>
                <div class="info-col">
                    <h3>Thông tin đơn hàng</h3>
                    <div class="info-row"><span class="info-label">Trạng thái:</span> ${info.ship_status}</div>
                    <div class="info-row"><span class="info-label">Thanh toán:</span> ${info.pay_strategy}</div>
                    <div class="info-row"><span class="info-label">Ghi chú:</span> ${info.note}</div>
                </div>
            </div>

            <h3>Chi tiết sản phẩm</h3>
            <table>
                <thead>
                    <tr>
                        <th>STT</th>
                        <th>Sản phẩm</th>
                        <th>Số lượng</th>
                        <th>Đơn giá</th>
                        <th>Thành tiền</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${items}" var="item" varStatus="status">
                        <tr>
                            <td style="text-align: center;">${status.index + 1}</td>
                            <td>${item.product_name}</td>
                            <td style="text-align: center;">${item.quantity}</td>
                            <td style="text-align: right;">${item.formattedPrice}</td>
                            <td style="text-align: right;">${item.formattedTotal}</td>
                        </tr>
                    </c:forEach>
                </tbody>
                <tfoot>
                    <tr>
                        <td colspan="4" style="text-align: right; font-weight: bold;">Tổng cộng:</td>
                        <td style="text-align: right; font-weight: bold;">${info.formattedTotal}</td>
                    </tr>
                </tfoot>
            </table>

            <div class="footer">
                <p>Cảm ơn quý khách đã mua hàng!</p>
                <p>Website: www.ltwnhom19.com | Hotline: 1900 1234</p>
            </div>

        </body>

        </html>