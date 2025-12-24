<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lỗi</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/error/error_style.css">
</head>
<body>
<%@ include file="../components/header.jsp" %>

<div class="error-container">
    <div id="error-code" class="error-code">403</div>
    <h1 id="error-title">Không có quyền truy cập</h1>
    <p id="error-message">Bạn không có quyền truy cập vào trang này.</p>
    <p class="support-info">Nếu sự cố vẫn tiếp diễn, vui lòng liên hệ bộ phận hỗ trợ qua số: <strong>1900 8888</strong>
    </p>
    <a href="<%=request.getContextPath()%>/index.jsp" class="home-button">Quay lại trang chủ</a>
</div>

<%@ include file="../components/footer.jsp" %>
</body>
</html>
