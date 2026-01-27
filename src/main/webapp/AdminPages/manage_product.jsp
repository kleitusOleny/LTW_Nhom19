<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
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
<style>
    /* Style cho thanh bộ lọc */
    .filter-bar {
        display: flex;
        gap: 15px;
        background: #fff;
        padding: 15px 20px;
        border-radius: 10px;
        margin-bottom: 20px;
        box-shadow: 0 2px 6px rgba(0,0,0,0.02);
        align-items: center;
        flex-wrap: wrap;
        border: 1px solid #eee;
    }

    .filter-item {
        display: flex;
        flex-direction: column;
        gap: 5px;
    }

    .filter-item label {
        font-size: 13px;
        font-weight: 600;
        color: #555;
    }

    .filter-input {
        padding: 8px 12px;
        border: 1px solid #ddd;
        border-radius: 6px;
        font-size: 14px;
        outline: none;
        height: 38px;
        box-sizing: border-box;
    }

    .filter-input:focus {
        border-color: #6341ff;
    }

    /* Nút Reset */
    .btn-reset {
        height: 38px;
        margin-top: 23px; /* Căn thẳng hàng với input */
        padding: 0 15px;
        background: #f1f3f5;
        color: #333;
        border: 1px solid #ddd;
        border-radius: 6px;
        cursor: pointer;
        font-weight: 600;
        transition: 0.2s;
    }

    .btn-reset:hover {
        background: #e9ecef;
        border-color: #ced4da;
    }
</style>
<body>
<div class="dashboard-container">

    <nav class="dashboard-sidebar">
        <ul class="sidebar-items">
            <div class="group-avatar">
                <%@ include file="/AdminPages/components/avatar.jsp" %>
                <%@ include file="/AdminPages/components/notify_icon.jsp" %>
            </div>
            <c:set var="activePage" value="product" scope="request" />
            <%@ include file="/AdminPages/components/sidebar_items_component.jsp" %>
        </ul>
        <div class="text">━ Được update tới 2025 ━</div>
    </nav>
    <div class="dashboard-content">
        <main class="dashboard-main-content">
            <div class="main-header">
                <h1>Quản Lí Sản Phẩm</h1>
                <div class="header-actions">
                    <button class="btn btn-danger remove-product-btn">
                        <ion-icon name="trash-outline"></ion-icon>
                        Xóa (Đã chọn)
                    </button>
                    <button class="btn btn-primary add-product-btn" id="btn-open-add">
                        <ion-icon name="add-outline"></ion-icon>
                        Thêm Sản Phẩm
                    </button>
                </div>
            </div>



            <div class="filter-bar">
                <div class="filter-item">
                    <label>Nhà sản xuất</label>
                    <select id="filter-manufacturer" class="filter-input" style="min-width: 180px;">
                        <option value="">-- Tất cả --</option>
                        <c:forEach items="${manufacturers}" var="m">
                            <option value="${m.manufacturerName}">${m.manufacturerName}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="filter-item">
                    <label>Giá từ</label>
                    <input type="number" id="min-price" class="filter-input" placeholder="0" style="width: 120px;">
                </div>
                <div class="filter-item">
                    <label>Đến</label>
                    <input type="number" id="max-price" class="filter-input" placeholder="Tối đa" style="width: 120px;">
                </div>

                <button type="button" class="btn-reset" id="btn-reset-filter">
                    <ion-icon name="refresh-outline" style="font-size: 16px; vertical-align: middle;"></ion-icon> Xóa lọc
                </button>

                <div class="filter-item" style="margin-left: auto;">
                    <label>Tìm kiếm chung</label>
                    <div class="search-wrapper" style="position: relative;">
                        <ion-icon name="search-outline" style="position: absolute; left: 10px; top: 50%; transform: translateY(-50%); color: #888;"></ion-icon>
                        <input type="text" id="custom-search-input" class="filter-input" placeholder="Tên SP, Mã..." style="padding-left: 30px; width: 250px;">
                    </div>
                </div>
            </div>

            <div class="table-container">
                <table id="product-datatable" class="product-table">
                    <thead>
                    <tr class="sample">
                        <th class="col-tick"><input type="checkbox" id="select-all-checkbox"></th>
                        <th class="col-product">Sản phẩm</th>
                        <th class="col-sku">Mã SP</th>
                        <th class="col-manufacturer">Nhà SX</th>
                        <th class="col-price">Giá</th>
                        <th class="col-stock">Tồn Kho</th>
                        <th class="col-action">Hành động</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${products}" var="p">
                        <tr>
                            <td class="cell-tick"><input type="checkbox" class="row-checkbox" value="${p.id}"></td>
                            <td>
                                <div class="product-cell">
                                    <img src="${empty p.imageUrl ? 'assets/no-image.png' : pageContext.request.contextPath.concat('/').concat(p.imageUrl)}"
                                         alt="Img" onerror="this.src='<%= request.getContextPath() %>/assets/no-image.png'">
                                    <span>${p.productName}</span>
                                </div>
                            </td>
                            <td class="center-align">${p.id}</td>
                            <td class="center-align">${p.manufacturerId}</td>
                            <td class="center-align">
                                <fmt:setLocale value="vi_VN"/>
                                <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                            </td>
                            <td class="center-align">
                                <span class="stock-status ${p.quantity > 0 ? 'in-stock' : 'out-of-stock'}">
                                        ${p.quantity > 0 ? p.quantity : 'Hết hàng'}
                                </span>
                            </td>
                            <td>
                                <div class="cell-action">
                                    <button type="button" class="edit btn edit-product-btn"
                                            data-id="${p.id}"
                                            data-name="${p.productName}"
                                            data-type-text="${p.typeId}"
                                            data-cat-text="${p.categoryId}"
                                            data-manu-text="${p.manufacturerId}"
                                            data-origin="${p.origin}"
                                            data-price="${p.price}"
                                            data-stock="${p.quantity}"
                                            data-capacity="${p.capacity}"
                                            data-alcohol="${p.alcohol}"
                                            data-detail="${p.detail}"
                                            data-img="${p.imageUrl}">
                                        Sửa
                                    </button>

                                    <form action="product-manager" method="POST" style="margin:0;">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="id" value="${p.id}">
                                        <button type="submit" class="delete btn" onclick="return confirm('Xóa sản phẩm này?');">Xoá</button>
                                    </form>
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

<%@ include file="/AdminPages/components/notify_modal.jsp" %>
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
<div class="modal-overlay-form product-form-modal" id="modal-san-pham">
    <div class="modal-content-form">
        <button class="modal-close-form" id="close-form-btn">
            <ion-icon name="close-outline"></ion-icon>
        </button>
        <h2>Thêm Sản Phẩm Mới</h2>

        <form id="add-product-form" action="product-manager" method="POST" enctype="multipart/form-data">
            <input type="hidden" id="form-action" name="action" value="add">
            <input type="hidden" id="prod-id" name="id" value="">
            <input type="hidden" id="prod-old-image" name="oldImage" value="">

            <div class="form-group">
                <label>Tên sản phẩm</label>
                <input type="text" id="p-name" name="name" required placeholder="Nhập tên sản phẩm...">
            </div>

            <div class="form-grid">
                <div class="form-group">
                    <label>Loại rượu</label>
                    <select id="p-type" name="type" class="form-control" required>
                        <option value="">-- Chọn loại --</option>
                        <c:forEach items="${types}" var="t">
                            <option value="${t.id}">${t.typeName}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label>Danh mục</label>
                    <select id="p-category" name="category" class="form-control" required>
                        <option value="">-- Chọn danh mục --</option>
                        <c:forEach items="${categories}" var="c">
                            <option value="${c.id}">${c.categoryName}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <div class="form-grid">
                <div class="form-group">
                    <label>Nhà sản xuất</label>
                    <select id="p-manufacturer" name="manufacturer" class="form-control" required>
                        <option value="">-- Chọn NSX --</option>
                        <c:forEach items="${manufacturers}" var="m">
                            <option value="${m.id}">${m.manufacturerName}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label>Xuất xứ</label>
                    <input type="text" id="p-origin" name="origin" placeholder="VD: Pháp">
                </div>
            </div>

            <div class="form-grid">
                <div class="form-group">
                    <label>Giá bán (VNĐ)</label>
                    <input type="text" id="p-price" name="price" required>
                </div>
                <div class="form-group">
                    <label>Số lượng tồn</label>
                    <input type="number" id="p-stock" name="stock" value="10" required>
                </div>
            </div>

            <div class="form-grid">
                <div class="form-group">
                    <label>Dung tích</label>
                    <input type="text" id="p-capacity" name="capacity" placeholder="VD: 750ml">
                </div>
                <div class="form-group">
                    <label>Nồng độ (%)</label>
                    <input type="text" id="p-alcohol" name="alcohol" placeholder="VD: 14.5">
                </div>
            </div>

            <div class="form-group">
                <label>Hình ảnh</label>
                <div class="file-upload-wrapper">
                    <input type="file" id="p-image" name="image" class="file-upload-input" accept="image/*">
                    <div class="file-upload-label">
                        <ion-icon name="cloud-upload-outline"></ion-icon>
                        <span id="file-label-text">Nhấn để chọn ảnh đại diện</span>
                    </div>
                </div>
            </div>

            <div class="form-group">
                <label>Mô tả chi tiết</label>
                <textarea id="p-detail" name="detail" rows="3"></textarea>
            </div>

            <div class="form-actions">
                <button type="button" class="btn btn-secondary" id="cancel-form-btn">Hủy Bỏ</button>
                <button type="submit" class="btn btn-primary" id="btn-submit-form">Lưu Sản Phẩm</button>
            </div>
        </form>
    </div>
</div>

<div class="modal-overlay-notification" id="notification-account-modal">
    <div class="modal-content-notification">
        <div class="group-notification">
            <h2 class="notification-title">Thông báo</h2>
            <button class="modal-close" id="close-modal-btn8"><ion-icon name="close-outline"></ion-icon></button>
        </div>
        <div class="notification-empty-state"><ion-icon name="notifications-off-outline"></ion-icon><p>Chưa có thông báo</p></div>
    </div>
</div>
<div class="modal-overlay-avatar" id="avatar-account-modal">
    <div class="modal-content-avatar">
        <button class="modal-close2" id="close-modal-btn9"><ion-icon name="close-outline"></ion-icon></button>
        <a href="${pageContext.request.contextPath}/home" class="btn-menu-item"><ion-icon name="person-circle-outline"></ion-icon><span>Trang người dùng</span></a>
        <a href="${pageContext.request.contextPath}/logout" class="btn-menu-item"><ion-icon name="log-out-outline"></ion-icon><span>Đăng xuất</span></a>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.datatables.net/2.0.8/js/dataTables.js"></script>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        // Setup Modal phụ
        setupDynamicModals('avatar-modal-btn', 'close-modal-btn9');
        setupDynamicModals('add-product-btn', 'modal-close-form')

        setupDynamicModals('remove-product-btn','cancel-delete-btn')
        setupModal(
            '.delete-confirm-modal',
            '.delete-button',
            '.close-delete-btn, .cancel-delete-btn'
        );
        setupModal('avatar-account-modal', 'avatar-modal-btn', 'close-modal-btn9');
        setupModal('notification-account-modal', 'notification-modal-btn', 'close-modal-btn8');

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

        $('#add-product-form').on('submit', function (e) {
            e.preventDefault();

            let formData = new FormData(this);

            $.ajax({
                url: 'add-product',
                type: 'POST',
                data: formData,
                processData: false,
                contentType: false,
                success: function (response) {
                    alert('Thêm sản phẩm thành công!');
                    location.reload(); // Hoặc cập nhật lại DataTable
                },
                error: function (xhr) {
                    alert('Có lỗi xảy ra: ' + xhr.responseText);
                }
            });
        });
    });

    document.addEventListener("DOMContentLoaded", function () {


        // 1. Cấu hình DataTable
        var table = $('#product-datatable').DataTable({
            "paging": true,
            "pageLength": 10,
            "language": { "url": 'https://cdn.datatables.net/plug-ins/2.0.8/i18n/vi.json' },
            "columnDefs": [
                {"orderable": false, "targets": [0, 6]},
                {"searchable": false, "targets": [0, 6]}
            ],
            "dom": '<"top"l>rt<"bottom"ip><"clear">'
        });

        // Search
        $('#custom-search-input').on('keyup', function () { table.search(this.value).draw(); });

        // 2. LOGIC CHỌN ALL
        $('#select-all-checkbox').on('change', function() {
            $('.row-checkbox').prop('checked', this.checked);
        });

        // 3. LOGIC XÓA NHIỀU (Dùng AJAX để không cần sửa Backend)
        $('.remove-product-btn').on('click', function() {
            var selectedIds = [];
            $('.row-checkbox:checked').each(function() {
                selectedIds.push($(this).val());
            });

            if (selectedIds.length === 0) {
                alert("Vui lòng chọn ít nhất một sản phẩm!");
                return;
            }

            if (confirm("Bạn muốn xóa " + selectedIds.length + " sản phẩm đã chọn?")) {
                // Gửi request xóa từng cái một
                let promises = selectedIds.map(id => {
                    return fetch('product-manager?action=delete&id=' + id, { method: 'POST' });
                });

                Promise.all(promises).then(() => {
                    alert("Đã xóa thành công!");
                    location.reload();
                }).catch(err => {
                    console.error(err);
                    alert("Có lỗi xảy ra khi xóa!");
                });
            }
        });

        // 4. LOGIC MODAL & EDIT
        const modal = document.getElementById('modal-san-pham');
        const openBtn = document.getElementById('btn-open-add');
        const closeBtn = document.getElementById('close-form-btn');
        const cancelBtn = document.getElementById('cancel-form-btn');

        function toggleModal(show) {
            if (show) modal.classList.add('show'); else modal.classList.remove('show');
        }
        if(closeBtn) closeBtn.addEventListener('click', () => toggleModal(false));
        if(cancelBtn) cancelBtn.addEventListener('click', () => toggleModal(false));

        // Nút Thêm
        if(openBtn) openBtn.addEventListener('click', () => {
            $('#add-product-form')[0].reset();
            $('#form-action').val('add');
            $('#prod-id').val('');
            $('#prod-old-image').val('');
            $('#file-label-text').text('Nhấn để chọn ảnh đại diện');

            $('.modal-content-form h2').text('Thêm Sản Phẩm Mới');
            $('#btn-submit-form').text('Lưu Sản Phẩm');
            toggleModal(true);
        });

        // Nút Sửa (Dùng Event Delegation)
        $('#product-datatable').on('click', '.edit-product-btn', function() {
            var btn = $(this);

            // Đổ dữ liệu text bình thường
            $('#prod-id').val(btn.data('id'));
            $('#p-name').val(btn.data('name'));
            $('#p-origin').val(btn.data('origin'));
            $('#p-price').val(btn.data('price'));
            $('#p-stock').val(btn.data('stock'));
            $('#p-capacity').val(btn.data('capacity'));
            $('#p-alcohol').val(btn.data('alcohol'));
            $('#p-detail').val(btn.data('detail'));
            $('#prod-old-image').val(btn.data('img'));

            // XỬ LÝ DROPDOWN THÔNG MINH (Tìm option theo Tên)
            setSelectedByText('#p-type', btn.data('type-text'));
            setSelectedByText('#p-category', btn.data('cat-text'));
            setSelectedByText('#p-manufacturer', btn.data('manu-text'));

            $('#form-action').val('edit');
            $('.modal-content-form h2').text('Cập Nhật Sản Phẩm');
            $('#btn-submit-form').text('Lưu Thay Đổi');
            toggleModal(true);
        });

        // Hàm phụ trợ: Chọn option dựa vào Text thay vì Value
        function setSelectedByText(selectId, textToFind) {
            $(selectId + ' option').each(function() {
                if ($(this).text().trim() === textToFind) {
                    $(this).prop('selected', true);
                    return false; // break loop
                }
            });
        }

        $.fn.dataTable.ext.search.push(
            function(settings, data, dataIndex) {
                // Lấy giá trị min, max từ input
                var min = parseInt($('#min-price').val(), 10);
                var max = parseInt($('#max-price').val(), 10);

                // Lấy giá tiền từ cột thứ 5 (index 4) - Cột Giá
                // data[4] là chuỗi dạng "1.500.000 ₫" -> Cần xóa dấu chấm và chữ đ
                var priceStr = data[4] || "0";
                var price = parseFloat(priceStr.replace(/[^0-9]/g, '')); // Chỉ giữ lại số

                if ( ( isNaN( min ) && isNaN( max ) ) ||
                    ( isNaN( min ) && price <= max ) ||
                    ( min <= price   && isNaN( max ) ) ||
                    ( min <= price   && price <= max ) )
                {
                    return true; // Hiển thị dòng này
                }
                return false; // Ẩn dòng này
            }
        );

// 2. Sự kiện khi thay đổi Giá (vẽ lại bảng)
        $('#min-price, #max-price').on('keyup change', function() {
            table.draw();
        });

// 3. Sự kiện khi chọn Nhà sản xuất
        $('#filter-manufacturer').on('change', function() {
            // Cột Nhà SX là cột thứ 4 (index 3).
            // Dùng regex chính xác để tránh tìm "Vin" ra "Vina" (nếu cần)
            // Ở đây ta dùng smart search mặc định của DataTables
            table.column(3).search(this.value).draw();
        });

// 4. Sự kiện nút Reset
        $('#btn-reset-filter').on('click', function() {
            $('#min-price').val('');
            $('#max-price').val('');
            $('#filter-manufacturer').val('');
            $('#custom-search-input').val('');

            // Xóa hết bộ lọc của DataTables
            table.search('');
            table.columns().search('');
            table.draw();
        });
    });
</script>
</body>
</html>