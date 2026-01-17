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
    <script src="<%= request.getContextPath() %>/popup.js"></script>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/manage_product_style.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/2.0.8/css/dataTables.dataTables.css"/>
</head>
<body>
<div class="dashboard-container">
    <nav class="dashboard-sidebar">
        <ul class="sidebar-items">
            <div class="group-avatar">
                <img src="<%= request.getContextPath() %>/assets/avatar.jpg" class="user-avatar" id="avatar-modal-btn"/>
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

                    <button class="btn btn-primary add-product-btn">
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

                    <div class="filter-item">
                        <span class="label-text">Nhà sản xuất</span>
                        <div class="select-wrapper">
                            <ion-icon name="business-outline" class="field-icon"></ion-icon>
                            <select id="filter-manufacturer" class="form-control">
                                <option value="">Tất cả</option>
                                <c:forEach items="${manufacturers}" var="m">
                                    <option value="${m.manufacturerName}">${m.manufacturerName}</option>
                                </c:forEach>
                            </select>
                            <ion-icon name="chevron-down-outline" class="arrow-icon"></ion-icon>
                        </div>
                    </div>

                    <div class="filter-item">
                        <span class="label-text">Ngày tạo</span>
                        <div class="price-group">
                            <div class="input-wrapper">
                                <input type="date" id="min-date" class="form-control" placeholder="Từ ngày">
                            </div>
                            <span class="divider">-</span>
                            <div class="input-wrapper">
                                <input type="date" id="max-date" class="form-control" placeholder="Đến ngày">
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
                        <th class="col-manufacturer" hidden="hidden">Nhà SX</th>
<%--                        <th class="col-date">Ngày tạo</th>--%>
                        <th class="col-price">Giá</th>
                        <th class="col-stock">Tồn Kho</th>
                        <th class="col-action">Hành động</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${products}" var="p">
                        <tr>
                            <td class="cell-tick"><input type="checkbox" class="row-checkbox"></td>
                            <td>
                                <div class="product-cell">
                                    <img src="${p.imageUrl}" alt="Product Image">
                                    <span>${p.productName}</span>
                                </div>
                            </td>
                            <td>${p.id}</td>

                            <td hidden="hidden">${p.manufacturerId}</td>
<%--                            <td><fmt:formatDate value="${p.getCreateAt()}" pattern="yyyy-MM-dd"/></td>--%>

                            <td><fmt:setLocale value="vi_VN"/>
                                <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                            </td>
                            <td class="center-align"><span class="stock-status in-stock">${p.quantity}</span></td>
                            <td>
                                <div class="cell-action">
                                    <button class="edit btn edit-button">Sửa</button>
                                    <button class="delete btn delete-button">Xoá</button>
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
<div class="modal-overlay-form product-form-modal">
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
                <label for="tag-typing">Thẻ (tag) - Nhập và nhấn Enter hoặc phẩy</label>

                <div class="tag-container" id="tag-wrapper">
                    <input type="text" id="tag-typing" placeholder="Nhập tag..." class="tag-input-typing">
                </div>

                <input type="hidden" id="prod-tag" name="tags" value="">
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
                <button type="button" class="btn btn-secondary cancel-form-btn">Hủy Bỏ</button>
                <button type="submit" class="btn btn-primary">Lưu Sản Phẩm</button>
            </div>
        </form>
    </div>
</div>

<div class="modal-overlay-form delete-confirm-modal" style="--modal-width: 450px;">
    <div class="modal-content-form">
        <button class="modal-close-form close-delete-btn">
            <ion-icon name="close-outline"></ion-icon>
        </button>
        <h2 class="modal-confirm-title">
            <ion-icon name="warning-outline"></ion-icon>
            Xác nhận xóa
        </h2>
        <p class="modal-confirm-text">Bạn có chắc chắn muốn xóa sản phẩm này không? Hành động này không thể hoàn
            tác.</p>
        <div class="form-actions">
            <button type="button" class="btn btn-secondary cancel-delete-btn">Hủy Bỏ</button>
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
        setupModal(
            '.product-form-modal',
            '.add-product-btn',
            '.modal-close-form, .cancel-form-btn'
        );

        setupModal(
            '.delete-confirm-modal',
            '.delete-button', // Áp dụng cho tất cả nút có class "delete" và "btn"
            '.close-delete-btn, .cancel-delete-btn'
        );

        // --- LOGIC XỬ LÝ TAGS INPUT ---

        const tagWrapper = $('#tag-wrapper');
        const tagInput = $('#tag-typing');
        const hiddenInput = $('#prod-tag');

        let tags = [];

        function renderTags() {
            tagWrapper.find('.tag-item').remove();

            tags.forEach((tagText, index) => {
                let $tagDiv = $('<div>', {
                    class: 'tag-item'
                });

                let $spanText = $('<span>', {
                    class: 'text-content',
                    text: tagText
                });

                let $removeBtn = $('<span>', {
                    class: 'remove-tag',
                    html: '&times;',
                    'data-index': index
                });

                $tagDiv.append($spanText).append($removeBtn);

                tagInput.before($tagDiv);
            });

            hiddenInput.val(tags.join(', '));

            console.log("Current Tags:", tags);
        }

        function addTag(text) {
            let cleanText = text.replace(/,/g, '').trim();
            if (cleanText && !tags.includes(cleanText)) {
                tags.push(cleanText);
                renderTags();
            }

            tagInput.val('');
            tagInput.focus();
        }

        tagInput.on('keydown', function(e) {
            if (e.key === 'Enter' || e.key === ',') {
                e.preventDefault();
                addTag($(this).val());
            }

            if (e.key === 'Backspace' && $(this).val() === '' && tags.length > 0) {
                tags.pop();
                renderTags();
            }
        });

        tagWrapper.on('click', '.remove-tag', function() {
            const index = $(this).data('index');
            tags.splice(index, 1);
            renderTags();
        });

        tagWrapper.on('click', function() {
            tagInput.focus();
        });


        $('#product-datatable tbody').on('click', '.edit.btn', function () {
            let currentTagsString = "";

            if(currentTagsString){
                tags = currentTagsString.split(',').map(t => t.trim());
            } else {
                tags = [];
            }
            renderTags();

        });

        $('#add-product-btn').on('click', function () {
            tags = [];
            renderTags();
        });
    });

    document.addEventListener("DOMContentLoaded", function () {

        $(document).ready(function () {
            // 1. Cấu hình Custom Filter cho Giá (Price Range)
            $.fn.dataTable.ext.search.push(
                function (settings, data, dataIndex) {
                    var selectedManu = $('#filter-manufacturer').val().trim();
                    var itemManu = data[3] || ""; // Index 3 là cột Nhà SX mới thêm

                    if (selectedManu === "") return true;
                    if (itemManu === selectedManu) return true;
                    return false;
                }
            );

            // 2. Cấu hình Custom Filter cho Ngày tạo (Cột index 4: yyyy-MM-dd)
            $.fn.dataTable.ext.search.push(
                function (settings, data, dataIndex) {
                    var minDate = $('#min-date').val();
                    var maxDate = $('#max-date').val();
                    var dateStr = data[4] || ""; // Index 4 là cột Ngày tạo

                    if (!minDate && !maxDate) return true;

                    // Chuyển đổi sang đối tượng Date để so sánh
                    var itemDate = new Date(dateStr);
                    var min = minDate ? new Date(minDate) : null;
                    var max = maxDate ? new Date(maxDate) : null;

                    // Logic so sánh ngày
                    if (
                        (!min && !max) ||
                        (!min && itemDate <= max) ||
                        (min <= itemDate && !max) ||
                        (min <= itemDate && itemDate <= max)
                    ) {
                        return true;
                    }
                    return false;
                }
            );

            // Cập nhật lại chỉ số cột cho Lọc Giá và Stock vì ta đã thêm 2 cột mới
            // Giá: Index cũ 3 -> Mới 5
            // Stock: Index cũ 4 -> Mới 6

            // ... (Sửa lại index trong các hàm filter cũ của bạn từ data[3]->data[5] và data[4]->data[6]) ...

            // Khởi tạo DataTable (Cập nhật columnDefs cho các cột mới)
            var table = $('#product-datatable').DataTable({
                "paging": true,
                "pageLength": 10,
                "lengthMenu": [5, 10, 25, 50],
                "columnDefs": [
                    {"orderable": false, "targets": [0, 7]}, // Cột 0 (Check) và 7 (Action) không sort
                    {"searchable": false, "targets": [0, 7]}
                ],
                // ... (Các cấu hình language khác giữ nguyên) ...
            });

            // Bắt sự kiện thay đổi bộ lọc mới
            $('#filter-manufacturer, #min-date, #max-date').on('change', function () {
                table.draw();
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
                table.search('').draw();
            });
        });
    });
</script>
</body>
</html>