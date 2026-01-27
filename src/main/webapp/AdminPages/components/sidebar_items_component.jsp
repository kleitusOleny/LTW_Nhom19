<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<li><a href="${pageContext.request.contextPath}/dashboard" class="a-with-icon ${activePage == 'dashboard' ? 'selected' : ''}">
    <ion-icon name=${activePage == 'dashboard' ? 'home' : 'home-outline'}></ion-icon>
    Trang Chủ</a></li>
<li><a href="${pageContext.request.contextPath}/product-manager" class="a-with-icon ${activePage == 'product' ? 'selected' : ''}">
    <ion-icon name=${activePage == 'product' ? 'bag-remove' : 'bag-remove-outline'}></ion-icon>
    Quản Lí Sản Phẩm</a></li>
<li><a href="${pageContext.request.contextPath}/account-manager" class="a-with-icon ${activePage == 'account' ? 'selected' : ''}">
    <ion-icon name=${activePage == 'account' ? 'people' : 'people-outline'}></ion-icon>
    Quản Lí Tài Khoản</a></li>
<li><a href="${pageContext.request.contextPath}/manage-orders" class="a-with-icon ${activePage == 'order' ? 'selected' : ''}">
    <ion-icon name=${activePage == 'order' ? 'cart' : 'cart-outline'}></ion-icon>
    Quản Lí Đơn Hàng</a></li>
<li><a href="${pageContext.request.contextPath}/banner-manager" class="a-with-icon ${activePage == 'banner' ? 'selected' : ''}">
    <ion-icon name=${activePage == 'banner' ? 'albums' : 'albums-outline'}></ion-icon>
    Quản Lí Banner</a></li>
<li><a href="${pageContext.request.contextPath}/manage-blog" class="a-with-icon ${activePage == 'blog' ? 'selected' : ''}">
    <ion-icon name=${activePage == 'blog' ? 'reader' : 'reader-outline'}></ion-icon>
    Quản Lí Blog và Tin Tức</a></li>
<li><a href="${pageContext.request.contextPath}/manage-promotions" class="a-with-icon ${activePage == 'promotion' ? 'selected' : ''}">
    <ion-icon name="ticket-outline"></ion-icon>
    Quản Lí Mã Giảm Giá và Khuyến Mãi</a></li>
<%--<li><a href="charts.jsp" class="a-with-icon">--%>
<%--    <ion-icon name="stats-chart-outline"></ion-icon>--%>
<%--    Thống Kê</a></li>--%>
