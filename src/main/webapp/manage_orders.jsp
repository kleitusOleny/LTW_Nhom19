<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Orders Manage</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            font-family: Mulish, sans-serif, serif;
        }

        .dashboard-container {
            display: grid;
            min-height: 100vh;
            grid-template-columns: 250px 1fr
        }

        .dashboard-sidebar {
            background-color: #21232d;
            position: relative;
        }

        .dashboard-content {
            background-color: #f4f7fa;
        }

        .sidebar-items {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 10px;
            list-style-type: none;
            position: fixed;
            top: 20px;
            height: 100vh;
            overflow-y: auto;
            width: 250px;
        }

        .group-avatar .user-avatar {
            border-radius: 100%;
            width: 120px;
            height: 120px;
            object-fit: cover;
            display: block;
            cursor: pointer;
            border: 3px solid transparent;
            transition: 0.2s;
        }

        .group-avatar {
            position: relative;
            width: 120px;
            height: 120px;
            margin-bottom: 15px;
        }

        .user-avatar:hover {
            border-color: #6341ff;
        }

        .icon-header {
            color: white;
            font-size: 24px;
            cursor: pointer;
            position: absolute;
            bottom: -5px;
            right: 5px;
            margin-left: 0;
            background-color: #3a3a3a;
            border-radius: 50%;
            padding: 6px;
            border: 2px solid #1f1f1f;
            line-height: 1;
            transition: 0.3s ease;
        }

        .icon-header:hover {
            color: #020202;
            transform: scale(1.1);
            background-color: #f8f8f8;
        }

        .a-with-icon {
            text-decoration: none;
            color: rgba(255, 255, 255, 0.8);
            display: flex;
            gap: 12px;
            font-size: 16px;
            font-weight: bold;
            padding: 12px 20px;
            border-radius: 8px;
            align-items: center;
            width: 200px;
            transition: background-color 0.3s ease, color 0.3s ease;
            border: 1px solid transparent;
        }

        .a-with-icon.selected, .a-with-icon:hover {
            border-color: #6341ff;
            background-color: #343746;
            color: #ffffff;
        }

        .a-with-icon ion-icon {
            font-size: 20px;
            flex-shrink: 0;
        }

        .text {
            color: #decdcd;
            font-size: 12px;
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            text-align: center;
            padding-bottom: 5px;
            box-sizing: border-box;
        }

        .dashboard-main-content {
            padding: 10px;
            background-color: #f4f7fa;
            flex-grow: 1;
        }

        .modal-content-avatar {
            position: relative;
            display: flex;
            flex-direction: column;
            align-items: center;
            width: 250px;
            padding: 20px 20px 20px 10px;
            gap: 8px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
            transition: transform 0.2s ease, opacity 0.2s ease;
        }

        .btn-menu-item {
            display: flex;
            align-items: center;
            gap: 5px;
            justify-content: center;
            width: 90%;
            padding: 10px;
            background: transparent;
            border: 1px solid #ccc;
            border-radius: 8px;
            text-align: left;
            font-size: 15px;
            color: #333;
            cursor: pointer;
        }

        .btn-menu-item:hover {
            border-color: #6341ff;
            transform: scale(1.02);
        }

        .modal-close2 {
            position: absolute;
            top: 1px;
            right: 0px;
            background: transparent;
            border: none;
            cursor: pointer;
            color: #666;
            font-size: 20px;
            padding: 4px;
            line-height: 1;
            border-radius: 50%;
            transition: background-color 0.2s ease, color 0.2s ease;
        }

        .modal-close2:hover {
            color: #111;
            background-color: #f0f0f0;
        }

        .btn-menu-item ion-icon {
            font-size: 18px;
            color: #555;
            flex-shrink: 0;
        }

        .modal-overlay-notification, .modal-overlay-avatar {
            position: fixed;
            top: 0;
            left: 0;
            width: 100vw;
            height: 100vh;
            z-index: 1000;
            display: flex;
            justify-content: flex-start;
            align-items: flex-start;
            padding-left: 250px;
            opacity: 0;
            visibility: hidden;
            transition: opacity 0.3s ease, visibility 0.3s ease;
        }

        .modal-content-notification {
            width: 400px;
            max-height: 80vh;
            overflow-y: auto;
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, .15);
            display: flex;
            flex-direction: column;
            box-sizing: border-box;
            padding: 20px;
            transition: transform 0.2s ease, opacity 0.2s ease;
        }

        .modal-overlay-notification.show, .modal-overlay-avatar.show {
            opacity: 1;
            visibility: visible;
        }

        .group-notification {
            display: flex;
            flex-direction: row;
        }

        .modal-close {
            width: 36px;
            height: 36px;
            border: 0;
            background: transparent;
            border-radius: 8px;
            cursor: pointer;
            transform: translateY(-10px)
        }

        .modal-close:hover {
            background: #f2f2f2;
        }

        .modal-close:focus-visible {
            outline: 2px solid #3b82f6;
            outline-offset: 2px;
        }

        .modal-close ion-icon {
            font-size: 22px;
            color: #333;
            pointer-events: none;
        }

        .notification-title {
            font-size: 1.25rem;
            font-weight: 600;
            color: #333;
            margin: 0 0 15px 0;
            padding-bottom: 10px;
            border-bottom: 1px solid #eee;
            width: 100%;
        }

        .notification-empty-state {
            flex-grow: 1;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            width: 100%;
            color: #888;
            padding: 30px 0;
        }

        .notification-empty-state ion-icon {
            font-size: 48px;
            margin-bottom: 15px;
        }

        .notification-empty-state p {
            font-size: 1rem;
            text-align: center;
            margin: 0;
        }

        /* ------*/
        .table-container {
            margin-top: 10px;
            width: 100%;
            overflow-x: auto;
        }

        .order-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
            font-size: 0.9em;
            background-color: white;
            color: #333;
        }

        .order-table th,
        .order-table td {
            border: 1px solid #ddd;
            text-align: left;
            vertical-align: middle;
        }

        .order-table th {
            padding: 10px 14px;
        }

        .order-table td {
            padding: 5px 5px;
        }

        .cell-tick input {
            margin-left: 20px;
        }

        .order-table thead .sample {
            background-color: #f4f4f4;
            color: #333;
            font-weight: bold;
        }

        .order-table tbody tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        .order-table tbody tr:hover {
            background-color: #f1f1f1;
        }

        .order-table .col-tick {
            width: 1%;
        }

        .order-table .col-id {
            width: 10%;
        }

        .order-table .col-customer {
            width: 20%;
        }

        .order-table .col-date {
            width: 15%;
        }

        .order-table .col-total {
            width: 15%;
        }

        .order-table .col-status {
            width: 15%;
        }

        .order-table .col-action {
            width: 10%;
        }

        .cell-action .btn {
            border-radius: 5px;
            height: 30px;
            cursor: pointer;
            border: solid 2px #ccc;
        }

        .cell-action .delete, .cell-action .view {
            width: 50px;
        }

        .cell-action .btn:hover {
            border-color: #6341ff;
            transform: scale(1.02);
            transition: transform 0.2s ease;
        }

        /* ---*/
        .button-group {
            display: flex;
            flex-direction: row;
            justify-content: space-between;
            gap: 8px;
            box-sizing: border-box;
            width: 100%;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
            padding: 15px;
            border-radius: 10px;
        }

        .button-group .button {
            padding: 10px 20px;
            border-radius: 10px;
            border: none;
            cursor: pointer;
            font-size: 14px;
        }

        .func-group {
            display: flex;
            flex-direction: row;
        }

        .button-group .del:hover {
            background-color: #bb2c3b;
        }

        .add, .excel, .del {
            margin-left: 10px;
            color: #fff;
            transition: 0.2s;
            display: flex;
            align-items: center;
            height: 42px;
            gap: 5px;
            font-weight: bold;
        }

        .button-group .add:hover {
            background-color: #0663dc;
        }

        .del {
            margin-left: 0;
            background-color: #dc3545;
        }

        .add {
            background-color: #0872fa;
        }

        .excel {
            background-color: #108814;
        }

        .type-needCss {
            font-size: 20px;
        }

        .button-group .excel:hover {
            background-color: #0c670f;
        }

        .modal-overlay,
        .modal-overlay-excel,
        .modal-overlay-deleteAll,
        .modal-overlay-edit_information {
            position: fixed;
            top: 0;
            left: 0;
            width: 100vw;
            height: 100vh;

            z-index: 1000;
            opacity: 0;
            visibility: hidden;
            transition: opacity 0.3s ease, visibility 0.3s ease;
        }

        /* Phần trượt popup */
        .modal-overlay-excel {
            display: flex;
            justify-content: center;
            align-items: flex-start;
            padding-top: 5vh;

            background-color: rgba(0, 0, 0, 0.3);
            opacity: 0;
            visibility: hidden;
        }

        /* Phần fadein popup */
        .modal-overlay,
        .modal-overlay-deleteAll,
        .modal-overlay-edit_information {
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: rgba(0, 0, 0, 0.6);
        }

        .modal-overlay.show,
        .modal-overlay-excel.show,
        .modal-overlay-deleteAll.show,
        .modal-overlay-edit_information.show {
            opacity: 1;
            visibility: visible;
        }

        .modal-content,
        .modal-content-deleteAll,
        .modal-content-edit_information {
            background-color: white;
            border-radius: 12px;
            gap: 25px;
            padding: 2.5rem 3rem;
            width: 25rem;
        }

        .modal-content-deleteAll {
            display: flex;
            flex-direction: column;
            padding: 30px 40px;
            gap: 20px;
        }

        .modal-content-excel {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 15px;
            width: 250px;
            padding: 20px;
            background-color: white;
            border-radius: 12px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.15);
            border: 1px solid #eee;
            transform: translateY(-50px);
            transition: transform 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
        }

        .modal-overlay-excel.show .modal-content-excel {
            transform: translateY(-25px);
        }

        .modal-content-refresh p, .modal-overlay-excel p {
            font-size: 1.1rem;
            color: #333;
        }

        .modal-content-deleteAll p {
            font-size: 1.2rem;
            text-align: center;
            color: red;
        }

        .sort-option label {
            cursor: pointer;
        }

        #add-form {
            display: flex;
            flex-direction: column;
            gap: 10px;
            width: 100%;
        }

        .customer-input, .date-input, .total-input, .status-input {
            display: flex;
            flex-direction: column;
            gap: 5px;
            width: 90%;
        }

        .customer-input label, .date-input label, .total-input label, .status-input label, .text-filter-group label, .edit-information-order label {
            font-weight: bold;
            font-size: 1rem;
            color: #555;
            width: 200px;
            margin-top: 5px;
        }

        .customer-input input, .date-input input, .total-input input, .status-input select, #text-filter, .edit-information-order input {
            font-size: 1rem;
            border-radius: 8px;
            border: 2px solid #ccc;
            transition: border-color 0.2s ease, box-shadow 0.2s ease;
        }

        .customer-input input, .date-input input, .total-input input, .status-input select {
            padding: 12px 15px;
        }

        .edit-information-order input {
            padding: 6px 6px;
        }

        .customer-input input, .date-input input, .total-input input {
            width: 100%;
        }

        .status-input select {
            width: 100%;
        }

        .customer-input input:focus, .date-input input:focus, .total-input input:focus, .status-input select:focus, #text-filter:focus, .edit-information-order input:focus {
            border-color: #6341ff;
            outline: none;
        }

        .label-with-icon {
            display: flex;
            gap: 3px;
        }

        .group-button-action {
            display: flex;
            flex-direction: row;
            justify-content: center;
            gap: 15px;
        }

        .group-button-action.section {
            margin-top: 10px;
        }

        .element-button, .deleteAll-button {
            width: 100px;
            padding: 14px 0;
            font-size: 1rem;
            font-weight: bold;
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.2s ease;
        }

        .cancel {
            width: 70px;
        }

        .deleteAll-button {
            width: 150px;
        }

        .add-btn, .fix-btn {
            background: #08c249;
        }

        .add-btn:hover, .fix-btn:hover {
            background: #06a13d;
        }

        .deleteAll-button {
            background: #e80f0f;
        }

        .cancel, .delete-all .element-button {
            background: #9daab4;
        }

        .cancel:hover, .delete-all .element-button:hover {
            background: #8e96a4;
        }

        .deleteAll-button:hover {
            background: #c70d0d;
        }

        .edit-information-order {
            display: flex;
            flex-direction: column;
        }

        .edit-information-order div:not(.active-section):not(:first-child) {
            display: flex;
            flex-direction: column;
            margin-bottom: 5px;
        }

        .edit-information-order .customer-section {
            margin-top: 5px;
        }

        .edit-information-order .active-section {
            margin-top: 10px;
        }

        #statusSelect {
            border-radius: 5px;
        }

        .edit-information-order .create_order-section {
            margin-bottom: 10px;
        }

        .modal-content-edit_information h2 {
            color: #555;
            margin-bottom: 10px;
        }

        .group-text-deleteAll {
            display: flex;
            flex-direction: column;
            gap: 5px;
        }

        .group-text-deleteAll .p-deleteAll1 {
            font-size: 1.1rem;
            width: 100%;
        }

        .group-text-deleteAll .icon-warning {
            font-size: 16px;
        }

        .group-text-deleteAll .p-deleteAll2 {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 5px;
            font-size: 1rem;
            font-weight: bold;
        }

        /* datatable css only */
        .dt-search .dt-input {
            border: 2px solid transparent;
            border-radius: 10px;
            outline: none;
        }

        .dt-search .dt-input:focus {
            border-color: #6341ff;
        }

        /* Order Detail Modal Styles */
        #orderDetailModal .modal-content {
            width: 90%;
            max-width: 900px;
            max-height: 90vh;
            overflow-y: auto;
            position: relative;
        }

        #orderDetailModal h2 {
            color: #8c3333;
            margin-bottom: 20px;
            font-size: 26px;
        }

        #orderDetailModal .section {
            margin-bottom: 30px;
        }

        #orderDetailModal .section h3 {
            font-size: 20px;
            color: #8c3333;
            margin-bottom: 15px;
            border-bottom: 1px solid #eee;
            padding-bottom: 10px;
        }

        #orderDetailModal .section.info p {
            margin: 10px 0;
        }

        #orderDetailModal table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }

        #orderDetailModal table th,
        #orderDetailModal table td {
            border: 1px solid #eee;
            padding: 10px;
            text-align: left;
        }

        #orderDetailModal table th {
            background: #f8f8f8;
        }

        #orderDetailModal .product-img {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 5px;
        }

        #orderDetailModal .status {
            display: inline-block;
            padding: 5px 12px;
            border-radius: 5px;
            color: white;
            font-weight: bold;
            text-transform: capitalize;
            background: #28a745;
        }

        #orderDetailModal .tracking-bar {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
            position: relative;
        }

        #orderDetailModal .tracking-bar::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 0;
            right: 0;
            height: 4px;
            background-color: #e0e0e0;
            transform: translateY(-50%);
            z-index: 1;
        }

        #orderDetailModal .tracking-progress {
            position: absolute;
            top: 50%;
            left: 0;
            height: 4px;
            background-color: #8c3333;
            transform: translateY(-50%);
            z-index: 2;
            width: 100%;
        }

        #orderDetailModal .tracking-step {
            position: relative;
            z-index: 3;
            text-align: center;
        }

        #orderDetailModal .step-dot {
            width: 20px;
            height: 20px;
            background: #8c3333;
            border-radius: 50%;
            margin: 0 auto 8px;
            border: 3px solid #fff;
        }

        #orderDetailModal .step-label {
            font-size: 14px;
            color: #666;
        }

        /* Close button positioned outside modal */
        #orderDetailModal .modal-close-outside {
            position: absolute;
            top: -15px;
            right: -15px;
            width: 36px;
            height: 36px;
            background: #fff;
            border: 2px solid #ccc;
            border-radius: 50%;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 1001;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
        }

        #orderDetailModal .modal-close-outside:hover {
            background: #f0f0f0;
            border-color: #999;
        }

        #orderDetailModal .modal-close-outside ion-icon {
            font-size: 20px;
            color: #666;
        }
    </style>
</head>
<body>
<div class="dashboard-container">
    <nav class="dashboard-sidebar">
        <ul class="sidebar-items">
            <div class="group-avatar">
                <img src="assets/avatar.jpg" class="user-avatar" id="avatar-modal-btn"/>
                <ion-icon name="notifications-outline" class="icon-header" id="notification-modal-btn"></ion-icon>
            </div>
            <li><a href="admin_dashboard.html" class="a-with-icon">
                <ion-icon name="home-outline"></ion-icon>
                Trang Chủ</a></li>
            <li><a href="manage_product.html" class="a-with-icon">
                <ion-icon name="bag-remove-outline"></ion-icon>
                Quản Lí Sản Phẩm</a></li>
            <li><a href="manage_accounts.html" class="a-with-icon">
                <ion-icon name="people-outline"></ion-icon>
                Quản Lí Tài Khoản Khách</a></li>
            <li><a href="manage_orders.html" class="a-with-icon selected">
                <ion-icon name="cart"></ion-icon>
                Quản Lí Đơn Hàng</a></li>
            <li><a href="manage_banner.html" class="a-with-icon">
                <ion-icon name="albums-outline"></ion-icon>
                Quản Lí Banner</a></li>
            <li><a href="manage_blog.jsp" class="a-with-icon">
                <ion-icon name="reader-outline"></ion-icon>
                Quản Lí Blog và Tin Tức</a></li>
            <li><a href="manage_promotions.jsp" class="a-with-icon">
                <ion-icon name="ticket-outline"></ion-icon>
                Quản Lí Mã Giảm Giá và Khuyến Mãi</a></li>
            <li><a href="charts.html" class="a-with-icon">
                <ion-icon name="stats-chart-outline"></ion-icon>
                Thống Kê</a></li>
        </ul>
        <div class="text">━ Được update tới 2025 ━</div>
    </nav>
    <div class="dashboard-content">
        <main class="dashboard-main-content">
            <div class="button-group">
                <h2>Quản lí đơn hàng</h2>
                <div class="func-group">
                    <button class="button del" id="deleteAll-modal-btn">
                        <ion-icon name="trash-outline"></ion-icon>
                        Xoá (Đã chọn)
                    </button>
                    <button class="button add" id="open-modal-btn">
                        <ion-icon name="add-outline" class="type-needCss"></ion-icon>
                        Thêm
                    </button>
                    <button class="button excel" id="excel-modal-btn">
                        <ion-icon name="cloud-download-outline"></ion-icon>
                        Xuất ra Excel
                    </button>
                </div>
            </div>
            <div class="table-container">
                <table id="order-table-main" class="order-table">
                    <thead>
                    <tr class="sample">
                        <th class="col-tick">Chọn</th>
                        <th class="col-id">ID Đơn Hàng</th>
                        <th class="col-customer">Khách Hàng</th>
                        <th class="col-date">Ngày Đặt</th>
                        <th class="col-total">Tổng Tiền</th>
                        <th class="col-status">Trạng Thái</th>
                        <th class="col-action">Hành Động</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr class="orders">
                        <td class="cell-tick"><input type="checkbox" class="row-checkbox"/></td>
                        <td class="cell-id">DH001</td>
                        <td class="cell-customer">Nguyễn Văn A</td>
                        <td class="cell-date">06/10/2024</td>
                        <td class="cell-total">1.500.000đ</td>
                        <td class="cell-status">Đang xử lý</td>
                        <td class="cell-action">
                            <button class="view btn" id="view-modal-btn">Xem</button>
                            <button class="delete btn">Xoá</button>
                        </td>
                    </tr>
                    <tr class="orders">
                        <td class="cell-tick"><input type="checkbox" class="row-checkbox"/></td>
                        <td class="cell-id">DH002</td>
                        <td class="cell-customer">Trần Thị B</td>
                        <td class="cell-date">03/08/2019</td>
                        <td class="cell-total">2.300.000đ</td>
                        <td class="cell-status">Đã giao</td>
                        <td class="cell-action">
                            <button class="view btn" id="view-modal-btn2">Xem</button>
                            <button class="delete btn">Xoá</button>
                        </td>
                    </tr>
                    <tr class="orders">
                        <td class="cell-tick"><input type="checkbox" class="row-checkbox"/></td>
                        <td class="cell-id">DH003</td>
                        <td class="cell-customer">Lê Văn C</td>
                        <td class="cell-date">15/08/2019</td>
                        <td class="cell-total">850.000đ</td>
                        <td class="cell-status">Đã hủy</td>
                        <td class="cell-action">
                            <button class="view btn" id="view-modal-btn3">Xem</button>
                            <button class="delete btn">Xoá</button>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </main>
    </div>
</div>

<div class="modal-overlay" id="add-order-modal">
    <div class="modal-content">
        <form id="add-form">
            <div class="customer-input">
                <label for="customer" class="label-with-icon">
                    <ion-icon name="person-outline"></ion-icon>
                    Khách Hàng</label>
                <input type="text" name="customer" placeholder="Nhập tên khách hàng" required>
            </div>
            <div class="date-input">
                <label for="date" class="label-with-icon">
                    <ion-icon name="calendar-outline"></ion-icon>
                    Ngày Đặt</label>
                <input type="date" name="date" required>
            </div>
            <div class="total-input">
                <label for="total" class="label-with-icon">
                    <ion-icon name="cash-outline"></ion-icon>
                    Tổng Tiền</label>
                <input type="text" name="total" placeholder="Nhập tổng tiền" required>
            </div>
            <div class="status-input">
                <label for="status" class="label-with-icon">
                    <ion-icon name="checkmark-circle-outline"></ion-icon>
                    Trạng Thái</label>
                <select id="status" name="status" required>
                    <option value="processing">Đang xử lý</option>
                    <option value="delivered">Đã giao</option>
                    <option value="cancelled">Đã hủy</option>
                </select>
            </div>
            <div class="group-button-action section">
                <button type="button" class="cancel element-button" id="close-modal-btn">Huỷ</button>
                <button type="submit" class="add-btn element-button">Thêm</button>
            </div>
        </form>
    </div>
</div>
<div class="modal-overlay-excel" id="excel-order-modal">
    <div class="modal-content-excel">
        <p>Thành công xuất ra file Excel</p>
        <button class="modal-close2" id="close-modal-btn5">
            <ion-icon name="close-outline"></ion-icon>
        </button>
    </div>
</div>
<div class="modal-overlay-deleteAll" id="deleteAll-order-modal">
    <div class="modal-content-deleteAll">
        <div class="group-text-deleteAll">
            <p class="p-deleteAll1">Bạn có chắc chắn muốn xoá toàn bộ dữ liệu của các ô được chọn?</p>
            <p class="p-deleteAll2">
                <ion-icon name="warning-outline" class="icon-warning"></ion-icon>
                Hành động này sẽ không thể hoàn tác
            </p>
        </div>
        <div class="group-button-action delete-all">
            <button type="button" class="element-button" id="close-modal-btn6">Huỷ</button>
            <button type="submit" class="deleteAll-button">Xoá Tất Cả</button>
        </div>
    </div>
</div>
<div class="modal-overlay-edit_information" id="edit_information-order-modal">
    <div class="modal-content-edit_information">
        <h2>Bảng thông tin đơn hàng</h2>
        <div class="edit-information-order">
            <div class="orderId-section">
                <label for="id">ID Đơn Hàng:</label>
                <input type="text" id="id" name="id" value="DH001" placeholder="ID hiện không có">
            </div>
            <div class="customer-section">
                <label for="customer">Khách Hàng</label>
                <input type="text" id="customer" name="customer" value="Nguyễn Văn A" placeholder="Chưa có khách hàng"
                       required>
            </div>
            <div class="date-section">
                <label for="date">Ngày Đặt</label>
                <input type="date" id="date" name="date" value="2024-10-06" required>
            </div>
            <div class="total-section">
                <label for="total">Tổng Tiền</label>
                <input type="text" id="total" name="total" value="1.500.000đ" placeholder="Chưa có tổng tiền" required>
            </div>
            <div class="status-section">
                <label for="statusSelect">Trạng Thái:</label>
                <select id="statusSelect" required>
                    <option value="processing">Đang xử lý</option>
                    <option value="delivered">Đã giao</option>
                    <option value="cancelled">Đã hủy</option>
                </select>
            </div>
        </div>
        <div class="group-button-action section">
            <button type="button" class="cancel element-button" id="close-modal-btn7">Huỷ</button>
            <button type="submit" class="fix-btn element-button">Sửa</button>
        </div>
    </div>
</div>
<div class="modal-overlay-edit_information" id="edit_information-order-modal-2">
    <div class="modal-content-edit_information">
        <h2>Bảng thông tin đơn hàng</h2>
        <div class="edit-information-order">
            <div class="orderId-section">
                <label>ID Đơn Hàng:</label>
                <input type="text" name="id" value="DH002" readonly>
            </div>
            <div class="customer-section">
                <label>Khách Hàng</label>
                <input type="text" name="customer" value="Trần Thị B">
            </div>
            <div class="date-section">
                <label>Ngày Đặt</label>
                <input type="date" name="date" value="2019-08-03">
            </div>
            <div class="total-section">
                <label>Tổng Tiền</label>
                <input type="text" name="total" value="2.300.000đ">
            </div>
            <div class="status-section">
                <label>Trạng Thái:</label>
                <select>
                    <option value="delivered" selected>Đã giao</option>
                    <option value="processing">Đang xử lý</option>
                    <option value="cancelled">Đã hủy</option>
                </select>
            </div>
        </div>
        <div class="group-button-action section">
            <button type="button" class="cancel element-button" id="close-modal-btn-2">Huỷ</button>
            <button type="submit" class="fix-btn element-button">Sửa</button>
        </div>
    </div>
</div>
<div class="modal-overlay-edit_information" id="edit_information-order-modal-3">
    <div class="modal-content-edit_information">
        <h2>Bảng thông tin đơn hàng</h2>
        <div class="edit-information-order">
            <div class="orderId-section">
                <label>ID Đơn Hàng:</label>
                <input type="text" name="id" value="DH003" readonly>
            </div>
            <div class="customer-section">
                <label>Khách Hàng</label>
                <input type="text" name="customer" value="Lê Văn C">
            </div>
            <div class="date-section">
                <label>Ngày Đặt</label>
                <input type="date" name="date" value="2019-08-15">
            </div>
            <div class="total-section">
                <label>Tổng Tiền</label>
                <input type="text" name="total" value="850.000đ">
            </div>
            <div class="status-section">
                <label>Trạng Thái:</label>
                <select>
                    <option value="cancelled" selected>Đã hủy</option>
                    <option value="processing">Đang xử lý</option>
                    <option value="delivered">Đã giao</option>
                </select>
            </div>
        </div>
        <div class="group-button-action section">
            <button type="button" class="cancel element-button" id="close-modal-btn-3">Huỷ</button>
            <button type="submit" class="fix-btn element-button">Sửa</button>
        </div>
    </div>
</div>

<div class="modal-overlay" id="orderDetailModal">
    <button class="modal-close-outside" id="closeModal">
        <ion-icon name="close-outline"></ion-icon>
    </button>
    <div class="modal-content">
        <h2>Chi Tiết Đơn Hàng #DH001</h2>

        <div class="section info">
            <h3>Thông tin khách hàng</h3>
            <p><strong>Họ và tên:</strong> Nguyễn Văn A</p>
            <p><strong>Email:</strong> nguyenvan@example.com</p>
            <p><strong>Điện thoại:</strong> 0987654321</p>
            <p><strong>Địa chỉ:</strong> 123 Đường ABC, Quận 1, TP.HCM</p>
            <p><strong>Hình thức thanh toán:</strong> Thanh toán khi nhận hàng</p>
        </div>

        <div class="section">
            <h3>Sản phẩm</h3>
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
                <tr>
                    <td><img class="product-img" src="img/SKU__VD_0926-22.png" alt="Rượu vang đỏ"></td>
                    <td>Rượu vang đỏ cao cấp</td>
                    <td>2</td>
                    <td>1.200.000₫</td>
                    <td>2.400.000₫</td>
                </tr>
                <tr>
                    <td><img class="product-img" src="img/SKU__VD_0926-22.png" alt="Whisky cao cấp"></td>
                    <td>Whisky cao cấp</td>
                    <td>1</td>
                    <td>1.500.000₫</td>
                    <td>1.500.000₫</td>
                </tr>
                </tbody>
                <tfoot>
                <tr>
                    <th colspan="4" style="text-align:right;">Tổng cộng:</th>
                    <th>3.900.000₫</th>
                </tr>
                </tfoot>
            </table>
        </div>

        <div class="section">
            <h3>Trạng thái đơn hàng</h3>
            <span class="status completed">Hoàn thành</span>

            <div class="tracking-bar">
                <div class="tracking-progress" style="width: 100%;"></div>
                <div class="tracking-step active">
                    <div class="step-dot"></div>
                    <div class="step-label">Đang xử lý</div>
                </div>
                <div class="tracking-step active">
                    <div class="step-dot"></div>
                    <div class="step-label">Đang giao</div>
                </div>
                <div class="tracking-step active">
                    <div class="step-dot"></div>
                    <div class="step-label">Đã giao</div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal-overlay-notification" id="notification-order-modal">
    <div class="modal-content-notification">
        <div class="group-notification">
            <h2 class="notification-title">Thông báo</h2>
            <button class="modal-close" id="close-modal-btn8">
                <ion-icon name="close-outline"></ion-icon>
            </button>
        </div>
        <div class="notification-empty-state">
            <ion-icon name="notifications-off-outline"></ion-icon>
            <p>Hiện tại chưa có thông báo mới</p>
        </div>
    </div>
</div>
<div class="modal-overlay-avatar" id="avatar-order-modal">
    <div class="modal-content-avatar">
        <button class="modal-close2" id="close-modal-btn9">
            <ion-icon name="close-outline"></ion-icon>
        </button>
        <button class="btn-menu-item">
            <ion-icon name="person-circle-outline"></ion-icon>
            <span>Trở về trang người dùng</span>
        </button>
        <button class="btn-menu-item">
            <ion-icon name="log-out-outline"></ion-icon>
            <span>Đăng xuất tài khoản</span>
        </button>
    </div>
</div>
<script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
<link href="https://fonts.googleapis.com/css2?family=Philosopher&display=swap" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="https://cdn.datatables.net/2.3.4/css/dataTables.dataTables.css"/>
<script src="https://cdn.datatables.net/2.3.4/js/dataTables.js"></script>
<script src="popup.js"></script>
<script>
    // Run Pop-up function
    document.addEventListener("DOMContentLoaded", function () {
        setupModal('add-order-modal', 'open-modal-btn', 'close-modal-btn');
        setupModal('excel-order-modal', 'excel-modal-btn', 'close-modal-btn5');
        setupModal('deleteAll-order-modal', 'deleteAll-modal-btn', 'close-modal-btn6');
        setupModal('notification-order-modal', 'notification-modal-btn', 'close-modal-btn8');
        setupModal('avatar-order-modal', 'avatar-modal-btn', 'close-modal-btn9');

        // Setup view buttons for order details
        const viewButtons = document.querySelectorAll('.view.btn');
        const orderDetailModal = document.getElementById('orderDetailModal');
        const closeModal = document.getElementById('closeModal');

        viewButtons.forEach(btn => {
            btn.addEventListener('click', () => {
                orderDetailModal.classList.add('show');
            });
        });

        closeModal.addEventListener('click', () => {
            orderDetailModal.classList.remove('show');
        });

        orderDetailModal.addEventListener('click', (e) => {
            if (e.target === orderDetailModal) {
                orderDetailModal.classList.remove('show');
            }
        });

        $(document).ready(function () {
            $('#order-table-main').DataTable({
                language: {
                    url: 'https://cdn.datatables.net/plug-ins/2.3.5/i18n/vi.json',
                },
            });
        });
    });
</script>
</body>
</html>
