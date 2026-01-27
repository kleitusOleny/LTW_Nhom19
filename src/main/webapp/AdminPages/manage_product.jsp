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
                    <button class="btn btn-danger remove-product-btn" data-target="delete-product">
                        <ion-icon name="trash-outline"></ion-icon>
                        Xóa (Đã chọn)
                    </button>
                    <label for="excel-file-input" class="btn btn-secondary">
                        <ion-icon name="cloud-upload-outline"></ion-icon>
                        Nhập từ Excel
                        <input type="file" id="excel-file-input" accept=".xlsx, .xls" class="hidden-file-input">
                    </label>

                    <button class="btn btn-primary add-product-btn" data-target="modal-san-pham">
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
                        <th class="col-date">Ngày tạo</th>
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
                            <td><fmt:formatDate value="${p.getCreateAt()}" pattern="yyyy-MM-dd"/></td>

                            <td><fmt:setLocale value="vi_VN"/>
                                <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                            </td>
                            <td class="center-align"><span class="stock-status ${p.quantity > 0 ? 'in-stock' : 'out-of-stock'}">
                                    ${p.quantity > 0 ? p.quantity : '0'}
                            </span></td>
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

        <form id="add-product-form" action="add-product" method="POST" enctype="multipart/form-data">
            <div class="form-group">
                <label for="prod-type">Loại rượu</label>
                <select id="prod-type" name="type" class="form-control">
                    <option value="">-- Chọn loại rượu --</option>
                    <c:forEach items="${types}" var="t">
                        <option value="${t.id}">${t.typeName}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="form-group">
                <label for="prod-origin">Xuất xứ</label>
                <input type="text" id="prod-origin" name="origin" placeholder="Ví dụ: Pháp">
            </div>

            <div class="form-group">
                <label for="prod-manufacturer">Nhà sản xuất</label>
                <select id="prod-manufacturer" name="manufacturer" class="form-control">
                    <option value="">-- Chọn nhà sản xuất --</option>
                    <c:forEach items="${manufacturers}" var="m">
                        <option value="${m.id}">${m.manufacturerName}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="form-group">
                <label for="prod-price">Giá</label>
                <input type="number" id="prod-price" name="price" placeholder="Nhập giá bán">
            </div>
            <div class="form-group">
                <label for="prod-capacity">Dung tích</label>
                <input type="text" id="prod-capacity" name="capacity" placeholder="Ví dụ: 750ML">
            </div>
            <div class="form-group">
                <label for="prod-alcohol">Nồng độ</label>
                <input type="text" id="prod-alcohol" name="alcohol" placeholder="Ví dụ: 15.0">
            </div>
            <div class="form-group">
                <label for="prod-stock">Số lượng tồn kho</label>
                <input type="number" id="prod-stock" name="stock" value="0">
            </div>

            <div class="form-group">
                <label for="prod-category">Danh mục</label>
                <select id="prod-category" name="category" class="form-control">
                    <option value="">-- Chọn danh mục --</option>
                    <c:forEach items="${categories}" var="c">
                        <option value="${c.id}">${c.categoryName}</option>
                    </c:forEach>
                </select>
            </div>

            <input type="hidden" id="prod-tag" name="tags" value="">

            <div class="form-group">
                <label for="prod-image">Hình ảnh sản phẩm</label>
                <div class="file-upload-wrapper">
                    <input type="file" id="prod-image" name="image" class="file-upload-input" accept="image/png, image/jpeg">
                </div>
            </div>
            <div class="form-group">
                <label for="prod-detail">Mô tả chi tiết</label>
                <textarea id="prod-detail" name="detail" rows="6"></textarea>
            </div>

            <div class="form-actions">
                <button type="button" class="btn btn-secondary cancel-form-btn">Hủy Bỏ</button>
                <button type="submit" class="btn btn-primary">Lưu Sản Phẩm</button>
            </div>
        </form>
    </div>
</div>

<div class="modal-overlay-form delete-confirm-modal" id="delete-product" style="--modal-width: 450px;">
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
        <a href="${pageContext.request.contextPath}/home" class="btn-menu-item">
            <ion-icon name="person-circle-outline"></ion-icon>
            <span>Trở về trang người dùng</span>
        </a>
        <a href="${pageContext.request.contextPath}/logout" class="btn-menu-item">
            <ion-icon name="log-out-outline"></ion-icon>
            <span>Đăng xuất tài khoản</span>
        </a>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"
        integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script src="https://cdn.datatables.net/2.0.8/js/dataTables.js"></script>

<script>
    document.addEventListener("DOMContentLoaded", function () {
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


        $.fn.dataTable.ext.search.push(
            function (settings, data, dataIndex) {
                // 1. Lấy giá trị từ các ô input
                var minPrice      = parseInt($('#min-price').val(), 10);
                var maxPrice      = parseInt($('#max-price').val(), 10);
                var stockStatus   = $('#filter-stock').val();
                var selectedManu  = $('#filter-manufacturer').val().trim();
                var minDate       = $('#min-date').val();
                var maxDate       = $('#max-date').val();

                // 2. Lấy dữ liệu từ dòng hiện tại trong bảng (Lưu ý chỉ số cột)
                var manuData      = data[3] || ""; // Cột 3: Nhà sản xuất
                var dateData      = data[4] || ""; // Cột 4: Ngày tạo
                var priceData     = data[5] || "0"; // Cột 5: Giá
                var stockData     = parseInt(data[6]) || 0; // Cột 6: Tồn kho

                // --- LOGIC LỌC GIÁ ---
                var priceVal = parseFloat(priceData.replace(/[^\d]/g, ''));
                if (
                    (!isNaN(minPrice) && priceVal < minPrice) ||
                    (!isNaN(maxPrice) && priceVal > maxPrice)
                ) {
                    return false;
                }

                // --- LOGIC LỌC TỒN KHO ---
                if (stockStatus === "instock" && stockData <= 0) return false;
                if (stockStatus === "outstock" && stockData > 0) return false;

                // --- LOGIC LỌC NHÀ SẢN XUẤT ---
                if (selectedManu !== "" && manuData !== selectedManu) {
                    return false;
                }

                // --- LOGIC LỌC NGÀY TẠO ---
                if (minDate || maxDate) {
                    var itemDate = new Date(dateData);
                    var minD = minDate ? new Date(minDate) : null;
                    var maxD = maxDate ? new Date(maxDate) : null;

                    if (minD && itemDate < minD) return false;
                    if (maxD && itemDate > maxD) return false;
                }

                return true;
            }
        );

        // KHỞI TẠO DATATABLE
        var table = $('#product-datatable').DataTable({
            "paging": true,
            "pageLength": 10,
            "lengthMenu": [5, 10, 25, 50],
            "columnDefs": [
                {"orderable": false, "targets": [0, 7]},
                {"searchable": false, "targets": [0, 7]}
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
            "dom": '<"top"l>rt<"bottom"ip><"clear">'
        });

        $('#custom-search-input').on('keyup', function () {
            table.search(this.value).draw();
        });

        $('#min-price, #max-price, #filter-stock, #filter-manufacturer, #min-date, #max-date').on('keyup change', function () {
            table.draw();
        });

        $('#btn-reset-filter').on('click', function () {
            $('#min-price').val('');
            $('#max-price').val('');
            $('#filter-stock').val('');
            $('#filter-manufacturer').val('');
            $('#min-date').val('');
            $('#max-date').val('');

            table.search('').draw();
        });
    });
</script>
</body>
</html>