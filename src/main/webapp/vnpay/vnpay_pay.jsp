<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
        <meta name="description" content="">
        <meta name="author" content="">
        <title>Tạo mới đơn hàng</title>
        <!-- Bootstrap core CSS -->
        <link href="../vnpay/assets/bootstrap.min.css" rel="stylesheet" />
        <!-- Custom styles for this template -->
        <link href="../vnpay/assets/jumbotron-narrow.css" rel="stylesheet">
    </head>

    <body>

        <div class="container">
            <div class="header clearfix">

                <h3 class="text-muted">VNPAY DEMO</h3>
            </div>
            <h3>Tạo mới đơn hàng</h3>
            <div class="table-responsive">
                <form action="<%= request.getContextPath()%>/vnpayajax" id="frmCreateOrder" method="post">
                    <div class="form-group">
                        <label for="amount">Số tiền</label>
                        <input class="form-control" data-val="true" data-val-number="The field Amount must be a number."
                            data-val-required="The Amount field is required." id="amount" max="100000000" min="1"
                            name="amount" type="number" value="10000" />
                    </div>
                    <h4>Chọn phương thức thanh toán</h4>
                    <div class="form-group">
                        <h5>Cách 1: Chuyển hướng sang Cổng VNPAY chọn phương thức thanh toán</h5>
                        <input type="radio" id="bankCode" name="bankCode" value="">
                        <label for="bankCode">Cổng thanh toán VNPAYQR</label><br>

                        <h5>Cách 2: Tách phương thức tại site của đơn vị kết nối</h5>
                        <input type="radio" id="bank1" name="bankCode" value="" checked>
                        <label for="bank1">VNPAY</label><br>

                        <input type="radio" id="bank2" name="bankCode" value="VNPAYQR">
                        <label for="bank2">VNPAYQR</label><br>

                        <input type="radio" id="bank3" name="bankCode" value="VNBANK">
                        <label for="bank3">ATM</label><br>

                        <input type="radio" id="bank4" name="bankCode" value="INTCARD">
                        <label for="bank4">Thẻ quốc tế</label><br>


                    </div>
                    <div class="form-group">
                        <h5>Chọn ngôn ngữ giao diện thanh toán:</h5>
                        <input type="radio" checked id="language" name="language" value="vn">
                        <label for="language">Tiếng việt</label><br>
                        <input type="radio" id="language2" name="language" value="en">
                        <label for="language2">Tiếng anh</label><br>

                    </div>
                    <button type="submit" class="btn btn-default">Thanh toán</button>
                </form>
            </div>
            <p>
                &nbsp;
            </p>
            <footer class="footer">
                <p>&copy; VNPAY 2020</p>
            </footer>
        </div>

        <link href="https://pay.vnpay.vn/lib/vnpay/vnpay.css" rel="stylesheet" />
        <script src="https://pay.vnpay.vn/lib/vnpay/vnpay.min.js"></script>
        <script src="https://code.jquery.com/jquery-1.11.3.min.js"></script>
        <script type="text/javascript">
            $(document).ready(function () {
                console.log("jQuery loaded successfully");

                $("#frmCreateOrder").submit(function (e) {
                    e.preventDefault();
                    console.log("Form submitted");

                    var $submitBtn = $(this).find('button[type="submit"]');
                    $submitBtn.prop('disabled', true).text('Đang xử lý...');

                    var postData = $("#frmCreateOrder").serialize();
                    var submitUrl = $("#frmCreateOrder").attr("action");

                    console.log("AJAX URL:", submitUrl);
                    console.log("AJAX data:", postData);

                    $.ajax({
                        type: "POST",
                        url: submitUrl,
                        data: postData,
                        dataType: 'JSON',
                        success: function (x) {
                            console.log("AJAX success response:", x);
                            if (x.code === '00') {
                                console.log("Payment URL:", x.data);
                                if (window.vnpay) {
                                    vnpay.open({ width: 768, height: 600, url: x.data });
                                } else {
                                    location.href = x.data;
                                }
                            } else {
                                console.error("Payment error:", x.message);
                                alert("Lỗi: " + x.message);
                                $submitBtn.prop('disabled', false).text('Thanh toán');
                            }
                        },
                        error: function (xhr, status, error) {
                            console.error("AJAX error - Status:", status);
                            console.error("AJAX error - Error:", error);
                            console.error("AJAX error - Response:", xhr.responseText);

                            var errorMsg = "Có lỗi xảy ra khi kết nối đến server.";

                            try {
                                var response = JSON.parse(xhr.responseText);
                                if (response.message) {
                                    errorMsg = response.message;
                                }
                            } catch (e) {
                                errorMsg += " Chi tiết: " + xhr.responseText;
                            }

                            alert(errorMsg);
                            $submitBtn.prop('disabled', false).text('Thanh toán');
                        }
                    });

                    return false;
                });
            });
        </script>
    </body>

    </html>