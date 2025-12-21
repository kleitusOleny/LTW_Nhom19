<%@page import="java.net.URLEncoder"%>
<%@page import="java.nio.charset.StandardCharsets"%>
<%@page import="vn.hcmuaf.nlu.fit.ltw_nhom19.Config"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="">
        <title>Kết quả thanh toán</title>
        <link href="../vnpay/assets/bootstrap.min.css" rel="stylesheet"/>
        <link href="../vnpay/assets/jumbotron-narrow.css" rel="stylesheet">      
        <script src="https://code.jquery.com/jquery-1.11.3.min.js"></script>
    </head>
    <body>
        <%
            Map fields = new HashMap();
            for (Enumeration params = request.getParameterNames(); params.hasMoreElements();) {
                String fieldName = URLEncoder.encode((String) params.nextElement(), StandardCharsets.US_ASCII.toString());
                String fieldValue = URLEncoder.encode(request.getParameter(fieldName), StandardCharsets.US_ASCII.toString());
                if ((fieldValue != null) && (fieldValue.length() > 0)) {
                    fields.put(fieldName, fieldValue);
                }
            }

            String vnp_SecureHash = request.getParameter("vnp_SecureHash");
            if (fields.containsKey("vnp_SecureHashType")) {
                fields.remove("vnp_SecureHashType");
            }
            if (fields.containsKey("vnp_SecureHash")) {
                fields.remove("vnp_SecureHash");
            }
            String signValue = Config.hashAllFields(fields);
            
            String vnp_TxnRef = request.getParameter("vnp_TxnRef");
            String vnp_Amount = request.getParameter("vnp_Amount");
            String vnp_OrderInfo = request.getParameter("vnp_OrderInfo");
            String vnp_ResponseCode = request.getParameter("vnp_ResponseCode");
            String vnp_TransactionNo = request.getParameter("vnp_TransactionNo");
            String vnp_BankCode = request.getParameter("vnp_BankCode");
            String vnp_PayDate = request.getParameter("vnp_PayDate");
            
            boolean checkSignature = signValue.equals(vnp_SecureHash);
        %>
        
        <div class="container">
            <div class="header clearfix">
                <h3 class="text-muted">KẾT QUẢ THANH TOÁN</h3>
            </div>
            <div class="table-responsive">
                <div class="form-group">
                    <label>Mã giao dịch thanh toán:</label>
                    <label><%=vnp_TxnRef%></label>
                </div>    
                <div class="form-group">
                    <label>Số tiền:</label>
                    <label><%=String.format("%,d", Long.parseLong(vnp_Amount) / 100)%> VND</label>
                </div>  
                <div class="form-group">
                    <label>Mô tả giao dịch:</label>
                    <label><%=vnp_OrderInfo%></label>
                </div> 
                <div class="form-group">
                    <label>Mã giao dịch tại VNPAY:</label>
                    <label><%=vnp_TransactionNo%></label>
                </div> 
                <div class="form-group">
                    <label>Mã ngân hàng:</label>
                    <label><%=vnp_BankCode%></label>
                </div> 
                <div class="form-group">
                    <label>Thời gian thanh toán:</label>
                    <label><%=vnp_PayDate%></label>
                </div> 
                <div class="form-group">
                    <label>Tình trạng giao dịch:</label>
                    <%
                        if (checkSignature) {
                            if ("00".equals(vnp_ResponseCode)) {
                    %>
                    <label style="color: green; font-weight: bold;">✓ Giao dịch thành công</label>
                    <%
                            } else {
                    %>
                    <label style="color: red; font-weight: bold;">✗ Giao dịch thất bại</label>
                    <br>
                    <label>Mã lỗi: <%=vnp_ResponseCode%></label>
                    <%
                            }
                        } else {
                    %>
                    <label style="color: red; font-weight: bold;">✗ Chữ ký không hợp lệ</label>
                    <%
                        }
                    %>
                </div> 
                
                <div class="form-group">
                    <a href="<%= request.getContextPath()%>/vnpay/vnpay_pay.jsp" class="btn btn-primary">Thực hiện giao dịch mới</a>
                    <a href="<%= request.getContextPath()%>/" class="btn btn-default">Về trang chủ</a>
                </div>
            </div>
            <p>&nbsp;</p>
            <footer class="footer">
                <p>&copy; VNPAY 2020</p>
            </footer>
        </div>  
        
        <script>
            console.log("Transaction Result:");
            console.log("TxnRef:", "<%=vnp_TxnRef%>");
            console.log("Amount:", "<%=vnp_Amount%>");
            console.log("ResponseCode:", "<%=vnp_ResponseCode%>");
            console.log("Signature Valid:", <%=checkSignature%>);
        </script>
    </body>
</html>
