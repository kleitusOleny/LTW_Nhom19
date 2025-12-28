<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Main Menu</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"
          integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/index_style.css">
</head>

<body>
<header class="site-header">
    <div class="header-top">
        <div class="container">
            <div class="header-logo">
                <a href="home" class="logo">LOGO</a>
            </div>

            <div class="header-center">
                <form class="search-form" action="#" method="get">
                    <input type="text" name="search" placeholder="Tìm kiếm sản phẩm...">
                    <button type="submit" aria-label="Search">
                        <i class="fas fa-search"></i>
                    </button>
                </form>
            </div>

            <div class="header-right">
                <a href="<%= request.getContextPath() %>/infoUsers/user_sidebar.jsp" aria-label="Account">
                    ${sessionScope.get("user").fullName}
                </a>
                <a href="<%= request.getContextPath() %>/infoUsers/user_sidebar.jsp" aria-label="Account">

                    <i class="fas fa-user"></i>
                </a>
                <a href="my-cart" class="cart-link" aria-label="Cart">
                    <i class="fa-solid fa-cart-shopping"></i>
                    <span class="cart-count">${sessionScope.cart.totalQuantity}</span>
                </a>
            </div>
        </div>
    </div>

    <div class="header-nav-bar">
        <div class="container">
            <nav class="header-nav">
              <c:set var="uri" value="${pageContext.request.requestURI}"/>
              <c:set var="current" value="${requestScope.curHeader}" />
                <ul>
                    <li>
                        <a href="home" class=${current.equals("home") ? "active" : ''}>Trang Chủ</a>
                    </li>

                    <%-- 3. RƯỢU VANG (Cửa hàng): Active khi ở 'store', 'filter' (lọc) hoặc 'detail' (chi tiết) --%>
                    <li class="has-dropdown">
                        <a href="store" class="${current.equals("store") ? "active" : ''}">
                            Rượu Vang
                            <i class="fa-solid fa-caret-down"></i>
                        </a>
                        <div class="mega-menu">
                            <div class="mega-menu-grid">
                                <div class="mega-menu-column">
                                    <h4 class="mega-menu-title">Theo Loại Vang</h4>
                                    <ul class="mega-menu-list">
                                        <li><a href="store" class="mega-menu-link">Rượu Vang Đỏ</a></li>
                                        <li><a href="store" class="mega-menu-link">Rượu Vang Trắng</a></li>
                                        <li><a href="store" class="mega-menu-link">Rượu Vang Hồng</a></li>
                                        <li><a href="store" class="mega-menu-link">Sâm Panh / Vang Nổ</a></li>
                                        <li><a href="store" class="mega-menu-link">Rượu Vang Ngọt</a></li>
                                        <li><a href="store" class="mega-menu-link">Cognac & Rượu Mạnh</a></li>
                                    </ul>
                                </div>

                                <div class="mega-menu-column">
                                    <h4 class="mega-menu-title">Nhãn Hàng Nổi Bật</h4>
                                    <ul class="mega-menu-list">
                                        <li><a href="store" class="mega-menu-link">CHÂTEAU CORBIN</a></li>
                                        <li><a href="store" class="mega-menu-link">TENUTA LUCE</a></li>
                                        <li><a href="store" class="mega-menu-link">MAISON LOUIS LATOUR</a></li>
                                        <li><a href="store" class="mega-menu-link">Domaine Faiveley</a></li>
                                        <li><a href="store" class="mega-menu-link">BODEGAS MUGA</a></li>
                                        <li><a href="store" class="mega-menu-link">CHAMPAGNE RUINART</a></li>
                                    </ul>
                                </div>

                                <div class="mega-menu-column">
                                    <h4 class="mega-menu-title">Theo Tag</h4>
                                    <ul class="mega-menu-list">
                                        <li><a href="#" class="mega-menu-link">Giá Đặc Biệt (gcc)</a></li>
                                        <li><a href="#" class="mega-menu-link">Bộ Sưu Tập Giá Tốt</a></li>
                                        <li><a href="#" class="mega-menu-link">Vang Hồng Giá Tốt</a></li>
                                        <li><a href="#" class="mega-menu-link">Bộ Sưu Tập</a></li>
                                    </ul>
                                </div>

                                <div class="mega-menu-column">
                                    <h4 class="mega-menu-title">Theo Vùng Nổi Bật</h4>
                                    <ul class="mega-menu-list">
                                        <li><a href="#" class="mega-menu-link">Bordeaux (Pháp)</a></li>
                                        <li><a href="#" class="mega-menu-link">Tuscany (Ý)</a></li>
                                        <li><a href="#" class="mega-menu-link">Napa Valley (Mỹ)</a></li>
                                        <li><a href="#" class="mega-menu-link">Champagne (Pháp)</a></li>
                                        <li><a href="#" class="mega-menu-link">Rioja (Tây Ban Nha)</a></li>
                                        <li><a href="#" class="mega-menu-link">Marlborough (New Zealand)</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </li>

                    <%-- 4. BLOG: Active khi link chứa 'blog.jsp' --%>
                    <li>
                        <a href="<%= request.getContextPath() %>/blog.jsp"
                           class="${fn:contains(uri, 'blog.jsp') ? 'active' : ''}">Blog</a>
                    </li>

                    <%-- 5. ABOUT US: Active khi link chứa 'about_us.jsp' --%>
                    <li>
                        <a href="<%= request.getContextPath() %>/about_us.jsp"
                           class="${fn:contains(uri, 'about_us.jsp') ? 'active' : ''}">About Us</a>
                    </li>
                </ul>
            </nav>
        </div>
    </div>
</header>