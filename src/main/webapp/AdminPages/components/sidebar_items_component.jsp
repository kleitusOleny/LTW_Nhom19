<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

        <li><a href="${pageContext.request.contextPath}/dashboard"
                        class="a-with-icon ${activePage == 'dashboard' ? 'selected' : ''}">
                        <ion-icon name=${activePage=='dashboard' ? 'home' : 'home-outline' }></ion-icon>
                        Trang Chủ</a></li>
        <li><a href="${pageContext.request.contextPath}/product-manager"
                        class="a-with-icon ${activePage == 'product' ? 'selected' : ''}">
                        <ion-icon name=${activePage=='product' ? 'bag-remove' : 'bag-remove-outline' }></ion-icon>
                        Quản Lí Sản Phẩm</a></li>
        <li><a href="${pageContext.request.contextPath}/category-manager"
                        class="a-with-icon ${activePage == 'category' ? 'selected' : ''}">
                        <ion-icon name=${activePage=='category' ? 'list' : 'list-outline' }></ion-icon>
                        Quản Lí Danh Mục</a></li>

        <li><a href="${pageContext.request.contextPath}/manage-manufacturer"
                        class="a-with-icon ${activePage == 'manufacturer' ? 'selected' : ''}">
                        <ion-icon name=${activePage=='manufacturer' ? 'business' : 'business-outline' }></ion-icon>
                        Quản Lí Nhà Sản Xuất</a></li>
        <li><a href="${pageContext.request.contextPath}/account-manager"
                        class="a-with-icon ${activePage == 'account' ? 'selected' : ''}">
                        <ion-icon name=${activePage=='account' ? 'people' : 'people-outline' }></ion-icon>
                        Quản Lí Tài Khoản</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/manage-orders"
                        class="a-with-icon ${activePage == 'order' ? 'selected' : ''}">
                        <ion-icon name=${activePage=='order' ? 'cart' : 'cart-outline' }></ion-icon>
                        Quản Lí Đơn Hàng</a></li>
        <li><a href="${pageContext.request.contextPath}/banner-manager"
                        class="a-with-icon ${activePage == 'banner' ? 'selected' : ''}">
                        <ion-icon name=${activePage=='banner' ? 'albums' : 'albums-outline' }></ion-icon>
                        Quản Lí Banner</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/manage-blog"
                        class="a-with-icon ${activePage == 'blog' ? 'selected' : ''}">
                        <ion-icon name=${activePage=='blog' ? 'reader' : 'reader-outline' }></ion-icon>
                        Quản Lí Blog và Tin Tức</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/manage-promotions"
                        class="a-with-icon ${activePage == 'promotion' ? 'selected' : ''}">
                        <ion-icon name="ticket-outline"></ion-icon>
                        Quản Lí Mã Giảm Giá và Khuyến Mãi</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/manage-reviews"
                        class="a-with-icon ${activePage == 'review' ? 'selected' : ''}">
                        <ion-icon name=${activePage=='review' ? 'star' : 'star-outline' }></ion-icon>
                        Quản Lí Đánh Giá</a></li>