<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Quản Lí Sản Phẩm</title>
    <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
    <script src="../popup.js"></script>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/manage_product_style.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/2.0.8/css/dataTables.dataTables.css"/>
</head>
<body>
<div class="dashboard-container">
    <nav class="dashboard-sidebar">
        <ul class="sidebar-items">
            <div class="group-avatar">
                <img src="../assets/avatar.jpg" class="user-avatar" id="avatar-modal-btn"/>
                <ion-icon name="notifications-outline" class="icon-header" id="notification-modal-btn"></ion-icon>
            </div>
            <li><a href="admin_dashboard.jsp" class="a-with-icon">
                <ion-icon name="home-outline"></ion-icon>
                Trang Chủ</a></li>
            <li><a href="manage_product.jsp" class="a-with-icon selected">
                <ion-icon name="bag-remove"></ion-icon>
                Quản Lí Sản Phẩm</a></li>
            <li><a href="manage_accounts.jsp" class="a-with-icon">
                <ion-icon name="people-outline"></ion-icon>
                Quản Lí Tài Khoản Khách</a></li>
            <li><a href="manage_orders.jsp" class="a-with-icon">
                <ion-icon name="cart-outline"></ion-icon>
                Quản Lí Đơn Hàng</a></li>
            <li><a href="manage_banner.jsp" class="a-with-icon">
                <ion-icon name="albums-outline"></ion-icon>
                Quản Lí Banner</a></li>
            <li><a href="manage_blog.jsp" class="a-with-icon">
                <ion-icon name="reader-outline"></ion-icon>
                Quản Lí Blog và Tin Tức</a></li>
            <li><a href="manage_promotions.jsp" class="a-with-icon">
                <ion-icon name="ticket-outline"></ion-icon>
                Quản Lí Mã Giảm Giá và Khuyến Mãi</a></li>
            <li><a href="charts.jsp" class="a-with-icon">
                <ion-icon name="stats-chart-outline"></ion-icon>
                Thống Kê</a></li>
        </ul>
        <div class="text">━ Được update tới 2025 ━</div>
    </nav>
    <div class="dashboard-content">
        <main class="dashboard-main-content">
            <div class="main-header">
                <h1>Quản Lí Sản Phẩm</h1>
                <div class="header-actions">
                    <button class="btn btn-danger" id="delete-selected-btn">
                        <ion-icon name="trash-outline"></ion-icon>
                        Xóa (Đã chọn)
                    </button>
                    <label for="excel-file-input" class="btn btn-secondary">
                        <ion-icon name="cloud-upload-outline"></ion-icon>
                        Nhập từ Excel
                        <input type="file" id="excel-file-input" accept=".xlsx, .xls" class="hidden-file-input">
                    </label>

                    <button class="btn btn-primary" id="add-product-btn">
                        <ion-icon name="add-outline"></ion-icon>
                        Thêm Sản Phẩm
                    </button>
                </div>
            </div>
            <div class="filter-card">
                <div class="filter-left">
                    <div class="filter-item">
                        <span class="label-text">Trạng thái kho</span>
                        <div class="select-wrapper">
                            <ion-icon name="layers-outline" class="field-icon"></ion-icon>
                            <select id="filter-stock" class="form-control">
                                <option value="">Tất cả trạng thái</option>
                                <option value="instock">Còn hàng</option>
                                <option value="outstock">Hết hàng</option>
                            </select>
                            <ion-icon name="chevron-down-outline" class="arrow-icon"></ion-icon>
                        </div>
                    </div>

                    <div class="filter-item">
                        <span class="label-text">Khoảng giá</span>
                        <div class="price-group">
                            <div class="input-wrapper">
                                <span class="currency">₫</span>
                                <input type="number" id="min-price" placeholder="Từ..." class="form-control price-input">
                            </div>
                            <span class="divider">-</span>
                            <div class="input-wrapper">
                                <span class="currency">₫</span>
                                <input type="number" id="max-price" placeholder="Đến..." class="form-control price-input">
                            </div>
                        </div>
                    </div>

                    <div class="filter-item item-bottom">
                        <button id="btn-reset-filter" class="btn-reset" title="Đặt lại">
                            <ion-icon name="refresh-outline"></ion-icon>
                        </button>
                    </div>
                </div>

                <div class="filter-right">
                    <div class="search-wrapper">
                        <ion-icon name="search-outline" class="search-icon"></ion-icon>
                        <input type="text" id="custom-search-input" placeholder="Tìm tên sản phẩm, mã SKU..." class="search-input">
                    </div>
                </div>
            </div>

            <div class="table-container">
                <table id="product-datatable" class="product-table">
                    <thead>
                    <tr class="sample">
                        <th class="col-tick"><input type="checkbox" id="select-all-checkbox"></th>
                        <th class="col-product">Sản phẩm</th>
                        <th class="col-sku">SKU</th>
                        <th class="col-price">Giá</th>
                        <th class="col-stock">Tồn Kho</th>
                        <th class="col-action">Hành động</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${product}" var="p">
                        <tr>
                            <td class="cell-tick"><input type="checkbox" class="row-checkbox"></td>
                            <td>
                                <div class="product-cell">
                                    <img src="${p.imageUrl}" alt="Product Image">
                                    <span>${p.productName}</span>
                                </div>
                            </td>
                            <td>${p.id}</td>
                            <td><fmt:setLocale value="vi_VN"/>
                                <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="₫"
                                                  maxFractionDigits="0"/>
                            </td>
                            <td class="center-align"><span class="stock-status in-stock">${p.quantity}</span></td>
                            <td>
                                <div class="cell-action">
                                    <button class="edit btn" id="edit-product-btn-1">Sửa</button>
                                    <button class="delete btn" id="delete-product-btn-1">Xoá</button>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>

                    </tbody>
                </table>
            </div>

        </main>
    </div>
</div>

<div class="modal-overlay-notification" id="notification-account-modal">
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
<div class="modal-overlay-avatar" id="avatar-account-modal">
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
<div class="modal-overlay-form" id="product-form-modal">
    <div class="modal-content-form">
        <button class="modal-close-form" id="close-form-btn">
            <ion-icon name="close-outline"></ion-icon>
        </button>
        <h2>Thêm Sản Phẩm Mới</h2>

        <form action="#">
            <div class="form-group">
                <label for="prod-id">ID (Khóa chính / SKU)</label>
                <input type="text" id="prod-id" value="SKU: VD/0998-18">
            </div>
            <div class="form-group">
                <label for="prod-name">Tên sản phẩm</label>
                <input type="text" id="prod-name" value="Rượu vang đỏ Château La Vieille Cure...">
            </div>

            <div class="form-grid">
                <div class="form-group">
                    <label for="prod-type">Loại rượu (typealcohol)</label>
                    <input type="text" id="prod-type" value="Rượu Vang Đỏ">
                </div>
                <div class="form-group">
                    <label for="prod-origin">Xuất xứ (origin)</label>
                    <input type="text" id="prod-origin" value="Pháp">
                </div>
                <div class="form-group">
                    <label for="prod-manufacturer">Nhà sản xuất (manufacturer)</label>
                    <input type="text" id="prod-manufacturer" value="Château La Vieille Cure">
                </div>
                <div class="form-group">
                    <label for="prod-price">Giá (price)</label>
                    <input type="number" id="prod-price" value="1573000">
                </div>
                <div class="form-group">
                    <label for="prod-capacity">Dung tích (capacity)</label>
                    <input type="text" id="prod-capacity" value="750ML">
                </div>
                <div class="form-group">
                    <label for="prod-alcohol">Nồng độ (alcohol)</label>
                    <input type="text" id="prod-alcohol" value="15.0">
                </div>
                <div class="form-group">
                    <label for="prod-stock">Số lượng tồn kho</label>
                    <input type="number" id="prod-stock" value="150">
                </div>
            </div>

            <div class="form-group">
                <label for="prod-category">Danh mục (category)</label>
                <input type="text" id="prod-category" value="Bordeaux, Fronsac, Rượu Vang Nhập Khẩu...">
            </div>

            <div class="form-group">
                <label for="prod-tag">Thẻ (tag)</label>
                <input type="text" id="prod-tag" value="">
            </div>

            <div class="form-group">
                <label for="prod-image">Hình ảnh sản phẩm</label>
                <div class="file-upload-wrapper">
                    <input type="file" id="prod-image" class="file-upload-input" accept="image/png, image/jpeg">
                    <label for="prod-image" class="file-upload-label">
                        <ion-icon name="cloud-upload-outline"></ion-icon>
                        <span>Nhấn để tải ảnh lên</span>
                    </label>
                </div>
            </div>
            <div class="form-group">
                <label for="prod-detail">Mô tả chi tiết (detail)</label>
                <textarea id="prod-detail" rows="6"></textarea>
            </div>

            <div class="form-actions">
                <button type="button" class="btn btn-secondary" id="cancel-form-btn">Hủy Bỏ</button>
                <button type="submit" class="btn btn-primary">Lưu Sản Phẩm</button>
            </div>
        </form>
    </div>
</div>
<div class="modal-overlay-form" id="delete-confirm-modal" style="--modal-width: 450px;">
    <div class="modal-content-form">
        <button class="modal-close-form" id="close-delete-btn">
            <ion-icon name="close-outline"></ion-icon>
        </button>
        <h2 class="modal-confirm-title">
            <ion-icon name="warning-outline"></ion-icon>
            Xác nhận xóa
        </h2>
        <p class="modal-confirm-text">Bạn có chắc chắn muốn xóa sản phẩm này không? Hành động này không thể hoàn
            tác.</p>
        <div class="form-actions">
            <button type="button" class="btn btn-secondary" id="cancel-delete-btn">Hủy Bỏ</button>
            <button type="button" class="btn btn-danger" id="ac-delete-btn">Xác Nhận Xóa</button>
        </div>
    </div>
</div>
<div class="modal-overlay-avatar" id="avatar-account-modal">
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

<script src="https://code.jquery.com/jquery-3.7.1.min.js"
        integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script src="https://cdn.datatables.net/2.0.8/js/dataTables.js"></script>

<script>
    document.addEventListener("DOMContentLoaded", function () {

        $(document).ready(function () {
            // 1. Cấu hình Custom Filter cho Giá (Price Range)
            $.fn.dataTable.ext.search.push(
                function (settings, data, dataIndex) {
                    var min = parseInt($('#min-price').val(), 10);
                    var max = parseInt($('#max-price').val(), 10);

                    // Lấy dữ liệu cột Giá (Cột index 3), loại bỏ ký tự không phải số (đ, dấu chấm, phẩy)
                    var priceStr = data[3] || "0";
                    var price = parseFloat(priceStr.replace(/[\D\s\._\-]+/g, ""));

                    if ((isNaN(min) && isNaN(max)) ||
                        (isNaN(min) && price <= max) ||
                        (min <= price && isNaN(max)) ||
                        (min <= price && price <= max)) {
                        return true;
                    }
                    return false;
                }
            );

            // 2. Cấu hình Custom Filter cho Tồn kho (Stock)
            $.fn.dataTable.ext.search.push(
                function (settings, data, dataIndex) {
                    var stockStatus = $('#filter-stock').val();
                    // Lấy dữ liệu cột Stock (Cột index 4)
                    var stockVal = parseInt(data[4]) || 0;

                    if (stockStatus === "") return true; // Chọn tất cả
                    if (stockStatus === "instock" && stockVal > 0) return true;
                    if (stockStatus === "outstock" && stockVal <= 0) return true;

                    return false;
                }
            );

            // 3. Khởi tạo DataTable
            var table = $('#product-datatable').DataTable({
                "paging": true,       // Bật phân trang (Mặc định là true, khai báo rõ ràng)
                "pageLength": 10,     // Số dòng mỗi trang
                "lengthMenu": [5, 10, 25, 50], // Tùy chọn số dòng hiển thị
                "columnDefs": [
                    {"orderable": false, "targets": [0, 5]},
                    {"searchable": false, "targets": [0, 5]}
                ],
                "language": {
                    "url": 'https://cdn.datatables.net/plug-ins/2.0.8/i18n/vi.json',
                    "paginate": {
                        "first": "<ion-icon name='play-skip-back-outline'></ion-icon>",
                        "last": "<ion-icon name='play-skip-forward-outline'></ion-icon>",
                        "next": "<ion-icon name='chevron-forward-outline'></ion-icon>",
                        "previous": "<ion-icon name='chevron-back-outline'></ion-icon>"
                    }
                },
                // Dom option để sắp xếp lại vị trí các thành phần (nếu cần)
                // l: length changing input control, f: filtering input, r: processing, t: table, i: info, p: pagination
                "dom": '<"top"l>rt<"bottom"ip><"clear">'
            });

            // 4. Bắt sự kiện khi nhập liệu vào bộ lọc -> Vẽ lại bảng
            $('#min-price, #max-price, #filter-stock').on('keyup change', function () {
                table.draw();
            });

            // 5. Nút Reset bộ lọc
            $('#btn-reset-filter').on('click', function () {
                $('#min-price').val('');
                $('#max-price').val('');
                $('#filter-stock').val('');
                table.search('').draw(); // Xóa cả ô tìm kiếm nhanh
            });
        });
    });
</script>
</body>
</html>