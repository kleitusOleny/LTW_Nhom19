<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <title>Orders Manage</title>
                <link rel="stylesheet"
                    href="${pageContext.request.contextPath}/AdminPages/admin_css/manage_promotion_style.css">
                <style>
                    .status-delivered {
                        color: #28a745;
                        /* Green */
                        font-weight: bold;
                    }

                    .status-shipping {
                        color: #28a745;
                        /* Green */
                        font-weight: bold;
                    }

                    .status-preparing {
                        color: #fd7e14;
                        /* Orange */
                        font-weight: bold;
                    }

                    .status-cancelled {
                        color: #dc3545;
                        /* Red */
                        font-weight: bold;
                    }

                    .status-processing {
                        color: #6c757d;
                        /* Grey */
                        font-weight: bold;
                    }
                </style>
            </head>

            <body>
                <div class="dashboard-container">
                    <nav class="dashboard-sidebar">
                        <ul class="sidebar-items">
                            <div class="group-avatar">
                                <%@ include file="/AdminPages/components/avatar.jsp" %>
                                    <%@ include file="/AdminPages/components/notify_icon.jsp" %>
                            </div>
                            <c:set var="activePage" value="order" scope="request" />
                            <%@ include file="/AdminPages/components/sidebar_items_component.jsp" %>
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
                                    <button class="button add"
                                        onclick="window.location.href='${pageContext.request.contextPath}/admin/create-order'">
                                        <ion-icon name="add-outline" class="type-needCss"></ion-icon>
                                        Tạo đơn mới
                                    </button>
                                </div>
                            </div>

                            <c:if test="${not empty successMessage}">
                                <div class="alert alert-success"
                                    style="background: #d4edda; color: #155724; padding: 12px 20px; border-radius: 8px; margin-bottom: 15px; display: flex; align-items: center; gap: 10px;">
                                    <ion-icon name="checkmark-circle-outline"></ion-icon>
                                    ${successMessage}
                                </div>
                            </c:if>
                            <c:if test="${not empty errorMessage}">
                                <div class="alert alert-error"
                                    style="background: #f8d7da; color: #721c24; padding: 12px 20px; border-radius: 8px; margin-bottom: 15px; display: flex; align-items: center; gap: 10px;">
                                    <ion-icon name="alert-circle-outline"></ion-icon>
                                    ${errorMessage}
                                </div>
                            </c:if>

                            <div class="table-container">
                                <table id="order-table-main" class="promotion-table">
                                    <thead>
                                        <tr class="sample">
                                            <th class="col-tick">Chọn</th>
                                            <th class="col-id">ID Đơn Hàng</th>
                                            <th class="col-customer">Khách Hàng</th>
                                            <th class="col-date">Ngày Đặt</th>
                                            <th class="col-total">Tổng Tiền</th>
                                            <th class="col-payment">Thanh Toán</th>
                                            <th class="col-status">Trạng Thái</th>
                                            <th class="col-action">Hành Động</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${orders}" var="o">
                                            <tr class="promotions" id="order-row-${o.id}">
                                                <td class="cell-tick"><input type="checkbox" class="row-checkbox"
                                                        value="${o.id}" /></td>
                                                <td class="cell-id">DH${o.id}</td>
                                                <td class="cell-customer">${o.customerName}</td>
                                                <td class="cell-date">${o.formattedDate}</td>
                                                <td class="cell-total">${o.formattedTotal}</td>
                                                <td class="cell-payment">${o.payStrategy != null ? o.payStrategy : 'Chưa
                                                    TT'}</td>
                                                <td class="cell-status">
                                                    <span class="${o.statusClass}">${o.statusText}</span>
                                                </td>
                                                <td class="cell-action">
                                                    <button class="view btn"
                                                        onclick="openViewModal(${o.id})">Xem</button>
                                                    <button class="delete btn"
                                                        onclick="confirmDelete(${o.id})">Xoá</button>
                                                </td>
                                            </tr>
                                        </c:forEach>
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
                                <label for="customerEmail" class="label-with-icon">
                                    <ion-icon name="mail-outline"></ion-icon>
                                    Email Khách Hàng</label>
                                <input type="email" name="customerEmail" placeholder="Nhập email khách hàng" required>
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

                <div class="modal-overlay" id="orderDetailModal">
                    <div class="modal-content"
                        style="width: 900px; max-width: 95vw; padding: 0; border-radius: 4px; overflow: hidden; font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;">
                        <div class="modal-header"
                            style="padding: 20px 30px; background-color: #fff; border-bottom: none; display: flex; justify-content: space-between; align-items: center;">
                            <h2 id="modal-order-id"
                                style="color: #a94442; font-size: 24px; margin: 0; font-weight: bold;">Chi tiết đơn hàng
                                #<span id="order-detail-id-display">${orderInfo.id}</span></h2>
                            <span class="close-modal-btn" id="closeOrderDetailModal"
                                style="font-size: 30px; cursor: pointer; color: #aaa; line-height: 20px;">&times;</span>
                        </div>

                        <div class="modal-body"
                            style="padding: 0 30px 30px 30px; max-height: 80vh; overflow-y: auto; background-color: #fff;">

                            <!-- Customer Info -->
                            <div class="section info" style="margin-bottom: 30px;">
                                <h3
                                    style="color: #a94442; font-size: 16px; margin-bottom: 15px; font-weight: bold; text-transform: uppercase;">
                                    Thông tin khách hàng</h3>
                                <div style="font-size: 14px; color: #333; line-height: 1.6;">
                                    <div style="margin-bottom: 8px;"><strong
                                            style="display: inline-block; width: 180px;">Họ và tên:</strong> <span
                                            id="modal-customer-name">${orderInfo.full_name}</span></div>
                                    <div style="margin-bottom: 8px;"><strong
                                            style="display: inline-block; width: 180px;">Email:</strong> <span
                                            id="modal-customer-email">${orderInfo.email}</span></div>
                                    <div style="margin-bottom: 8px;"><strong
                                            style="display: inline-block; width: 180px;">Điện thoại:</strong> <span
                                            id="modal-customer-phone">${orderInfo.phone_number}</span></div>
                                    <div style="margin-bottom: 8px;"><strong
                                            style="display: inline-block; width: 180px;">Địa chỉ:</strong> <span
                                            id="modal-customer-address">${orderInfo.specific_address},
                                            ${orderInfo.ward}, ${orderInfo.city}</span></div>
                                    <div style="margin-bottom: 8px;"><strong
                                            style="display: inline-block; width: 180px;">Ghi chú:</strong> <span
                                            id="modal-note">${orderInfo.note}</span></div>
                                    <div style="margin-bottom: 8px;"><strong
                                            style="display: inline-block; width: 180px;">Hình thức thanh toán:</strong>
                                        <span id="modal-payment">${orderInfo.pay_strategy}</span>
                                    </div>
                                </div>
                            </div>

                            <!-- Products -->
                            <div class="section" style="margin-bottom: 30px;">
                                <h3
                                    style="color: #a94442; font-size: 16px; margin-bottom: 15px; font-weight: bold; text-transform: uppercase;">
                                    Sản phẩm</h3>
                                <table
                                    style="width: 100%; border-collapse: collapse; font-size: 14px; border: 1px solid #eee;">
                                    <thead>
                                        <tr style="background-color: #f5f5f5; text-align: left;">
                                            <th
                                                style="padding: 12px 15px; border-bottom: 1px solid #ddd; font-weight: bold; color: #333;">
                                                Hình ảnh</th>
                                            <th
                                                style="padding: 12px 15px; border-bottom: 1px solid #ddd; font-weight: bold; color: #333;">
                                                Sản phẩm</th>
                                            <th
                                                style="padding: 12px 15px; border-bottom: 1px solid #ddd; font-weight: bold; color: #333;">
                                                Số lượng</th>
                                            <th
                                                style="padding: 12px 15px; border-bottom: 1px solid #ddd; font-weight: bold; color: #333;">
                                                Đơn giá</th>
                                            <th
                                                style="padding: 12px 15px; border-bottom: 1px solid #ddd; font-weight: bold; color: #333;">
                                                Tổng</th>
                                        </tr>
                                    </thead>
                                    <tbody id="modal-items-body">
                                        <c:if test="${not empty orderItems}">
                                            <c:forEach items="${orderItems}" var="item">
                                                <tr>
                                                    <td style="padding: 10px; border-bottom: 1px solid #eee;">
                                                        <img src="${pageContext.request.contextPath}/${item.url_img}"
                                                            alt="${item.product_name}"
                                                            style="width:60px;height:110px;object-fit:cover;border-radius:4px;">
                                                    </td>
                                                    <td style="padding: 10px; border-bottom: 1px solid #eee;">
                                                        ${item.product_name}</td>
                                                    <td style="padding: 10px; border-bottom: 1px solid #eee;">
                                                        ${item.quantity}</td>
                                                    <td style="padding: 10px; border-bottom: 1px solid #eee;">
                                                        <fmt:formatNumber value="${item.unit_price}" type="currency"
                                                            currencySymbol="₫" />
                                                    </td>
                                                    <td style="padding: 10px; border-bottom: 1px solid #eee;">
                                                        <fmt:formatNumber value="${item.quantity * item.unit_price}"
                                                            type="currency" currencySymbol="₫" />
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:if>
                                    </tbody>
                                    <tfoot>
                                        <tr>
                                            <td colspan="4"
                                                style="text-align:right; padding: 15px 15px; font-weight: bold; color: #333; border-top: 1px solid #eee;">
                                                Tổng cộng:</td>
                                            <td id="modal-total-price"
                                                style="padding: 15px 15px; font-weight: bold; color: #333; border-top: 1px solid #eee;">
                                                <fmt:formatNumber value="${orderInfo.total_price}" type="currency"
                                                    currencySymbol="₫" />
                                            </td>
                                        </tr>
                                    </tfoot>
                                </table>
                            </div>

                            <!-- Order Status & Progress -->
                            <div class="section">
                                <h3
                                    style="color: #a94442; font-size: 16px; margin-bottom: 15px; font-weight: bold; text-transform: uppercase;">
                                    Trạng thái đơn hàng</h3>

                                <!-- Status Badge -->
                                <div style="margin-bottom: 20px;">
                                    <span id="modal-status-badge"
                                        style="background-color: #28a745; color: white; padding: 5px 10px; border-radius: 4px; font-weight: bold; font-size: 12px; text-transform: uppercase;">Đang
                                        Xử Lý</span>
                                </div>

                                <!-- Progress Bar -->
                                <div class="progress-track"
                                    style="margin-bottom: 40px; position: relative; height: 5px; background-color: #eee; margin-top: 30px; border-radius: 5px;">
                                    <div id="progress-bar-fill"
                                        style="height: 100%; background-color: #28a745; width: 0%; border-radius: 5px; transition: width 0.3s;">
                                    </div>

                                    <div
                                        style="position: absolute; top: -10px; left: 0; width: 100%; display: flex; justify-content: space-between;">
                                        <div class="step-dot" id="dot-processing"
                                            style="width: 25px; height: 25px; background-color: #ddd; border-radius: 50%; display: flex; align-items: center; justify-content: center; color: white; font-size: 12px; position: relative;">
                                            <span
                                                style="position: absolute; bottom: -25px; color: #999; font-size: 12px; white-space: nowrap;">Đang
                                                xử lý</span>
                                        </div>
                                        <div class="step-dot" id="dot-shipping"
                                            style="width: 25px; height: 25px; background-color: #ddd; border-radius: 50%; display: flex; align-items: center; justify-content: center; color: white; font-size: 12px; position: relative;">
                                            <span
                                                style="position: absolute; bottom: -25px; color: #999; font-size: 12px; white-space: nowrap;">Đang
                                                giao</span>
                                        </div>
                                        <div class="step-dot" id="dot-delivered"
                                            style="width: 25px; height: 25px; background-color: #ddd; border-radius: 50%; display: flex; align-items: center; justify-content: center; color: white; font-size: 12px; position: relative;">
                                            <span
                                                style="position: absolute; bottom: -25px; color: #999; font-size: 12px; white-space: nowrap;">Đã
                                                giao</span>
                                        </div>
                                    </div>
                                </div>

                                <!-- Actions (Update Status & Print) -->
                                <div
                                    style="display: flex; justify-content: flex-end; align-items: center; gap: 10px; border-top: 1px solid #eee; padding-top: 20px;">
                                    <form id="update-order-form"
                                        action="<%=request.getContextPath()%>/admin/update-order" method="post"
                                        style="display: flex; align-items: center; gap: 10px; margin: 0;">
                                        <input type="hidden" id="update-order-id" name="id">
                                        <select name="statusSelect" id="modal-status-select"
                                            style="padding: 8px 15px; border-radius: 4px; border: 1px solid #ddd; background-color: #eee; color: #333; cursor: pointer; font-weight: bold; margin-right: 10px;">
                                            <option value="Chuẩn bị đơn hàng">Chuẩn bị đơn hàng</option>
                                            <option value="Đang xử lý">Đang xử lý</option>
                                            <option value="Đang giao hàng">Đang giao hàng</option>
                                            <option value="Giao hàng thành công">Giao hàng thành công</option>
                                            <option value="Đã giao">Đã giao</option>
                                            <option value="Đã hủy">Đã hủy</option>
                                            <option value="Thanh toán thất bại">Thanh toán thất bại</option>
                                        </select>
                                        <button type="submit" class="fix-btn element-button"
                                            style="padding: -2px 25px; background-color: #a94442; color: white; border: none; border-radius: 4px; cursor: pointer; font-weight: bold; font-size: 13px; text-transform: uppercase; box-shadow: none;">
                                            Cập nhật
                                        </button>
                                    </form>
                                    <button type="button"
                                        onclick="window.open('${pageContext.request.contextPath}/admin/print-invoice?id=' + document.getElementById('update-order-id').value, '_blank')"
                                        style="padding: 10px 25px; background-color: #a94442; color: white; border: none; border-radius: 4px; cursor: pointer; font-weight: bold; font-size: 13px; text-transform: uppercase;">
                                        In hóa đơn
                                    </button>
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
                <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
                <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
                <link href="https://fonts.googleapis.com/css2?family=Philosopher&display=swap" rel="stylesheet">
                <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
                <link rel="stylesheet" href="https://cdn.datatables.net/2.3.4/css/dataTables.dataTables.css" />
                <script src="https://cdn.datatables.net/2.3.4/js/dataTables.js"></script>
                <script src="../popup.js"></script>
                <script>
                    // Initialize DataTable
                    $(document).ready(function () {
                        $('#order-table-main').DataTable({
                            language: {
                                url: 'https://cdn.datatables.net/plug-ins/2.3.5/i18n/vi.json',
                            },
                        });
                    });

                    // Run Pop-up function
                    document.addEventListener("DOMContentLoaded", function () {
                        setupModal('add-order-modal', 'open-modal-btn', 'close-modal-btn');
                        setupModal('excel-order-modal', 'excel-modal-btn', 'close-modal-btn5');
                        setupModal('deleteAll-order-modal', 'deleteAll-modal-btn', 'close-modal-btn6');
                        setupModal('notification-order-modal', 'notification-modal-btn', 'close-modal-btn8');
                        setupModal('avatar-order-modal', 'avatar-modal-btn', 'close-modal-btn9');

                        const orderDetailModal = document.getElementById('orderDetailModal');
                        const closeOrderDetailBtn = document.getElementById('closeOrderDetailModal');

                        if (closeOrderDetailBtn && orderDetailModal) {
                            closeOrderDetailBtn.addEventListener('click', () => {
                                orderDetailModal.classList.remove('show');
                            });
                        }

                        if (orderDetailModal) {
                            orderDetailModal.addEventListener('click', (e) => {
                                if (e.target === orderDetailModal) {
                                    orderDetailModal.classList.remove('show');
                                }
                            });
                        }

                        document.addEventListener('keydown', (event) => {
                            if (event.key === 'Escape' && orderDetailModal && orderDetailModal.classList.contains('show')) {
                                orderDetailModal.classList.remove('show');
                            }
                        });

                        // Add Order AJAX
                        $('#add-form').submit(function (e) {
                            e.preventDefault();
                            var formData = $(this).serialize();
                            fetch('${pageContext.request.contextPath}/admin/add-order', {
                                method: 'POST',
                                headers: {
                                    'Content-Type': 'application/x-www-form-urlencoded',
                                },
                                body: formData
                            }).then(response => response.json())
                                .then(data => {
                                    if (data.success) {
                                        alert(data.message);
                                        window.location.reload();
                                    } else {
                                        alert(data.message);
                                    }
                                }).catch(error => {
                                    console.error('Error:', error);
                                    alert('Lỗi kết nối tới server.');
                                });
                        });



                        // Bulk Delete Logic
                        $('.deleteAll-button').click(function (e) {
                            e.preventDefault();
                            var ids = [];
                            // Access DataTable instance safely
                            var table = $('#order-table-main').DataTable();
                            table.$('input.row-checkbox:checked').each(function () {
                                ids.push($(this).val());
                            });

                            if (ids.length === 0) {
                                alert("Vui lòng chọn ít nhất một đơn hàng!");
                                document.getElementById('deleteAll-order-modal').classList.remove('show');
                                return;
                            }

                            fetch('${pageContext.request.contextPath}/admin/delete-order', {
                                method: 'POST',
                                headers: {
                                    'Content-Type': 'application/x-www-form-urlencoded',
                                },
                                body: 'ids=' + ids.join(',')
                            }).then(response => response.json())
                                .then(data => {
                                    if (data.success) {
                                        alert(data.message);
                                        window.location.reload();
                                    } else {
                                        alert(data.message);
                                    }
                                }).catch(error => {
                                    console.error('Error:', error);
                                    alert("Lỗi kết nối tới server.");
                                });
                        });
                    });

                    function confirmDelete(id) {
                        if (confirm('Bạn có chắc chắn muốn xóa đơn hàng này?')) {
                            // Call delete API
                            fetch('${pageContext.request.contextPath}/admin/delete-order', {
                                method: 'POST',
                                headers: {
                                    'Content-Type': 'application/x-www-form-urlencoded',
                                },
                                body: 'ids=' + id
                            }).then(response => response.json())
                                .then(data => {
                                    if (data.success) {
                                        alert(data.message);
                                        window.location.reload();
                                    } else {
                                        alert(data.message);
                                    }
                                }).catch(error => {
                                    console.error('Error:', error);
                                    alert("Lỗi kết nối tới server.");
                                });
                        }
                    }

                    function openViewModal(id) {
                        location.href = '${pageContext.request.contextPath}/admin/get-order?id=' + id;
                    }
                </script>

                <c:if test="${not empty orderInfo}">
                    <script>
                        $(document).ready(function () {
                            const updateOrderIdInput = document.getElementById('update-order-id');
                            if (updateOrderIdInput) {
                                updateOrderIdInput.value = '${orderInfo.id}';
                            }

                            const status = '${orderInfo.ship_status}' || 'Đang xử lý';
                            const statusSelect = document.getElementById('modal-status-select');
                            if (statusSelect) {
                                const matchedOption = Array.from(statusSelect.options).find(option => option.value === status);
                                if (matchedOption) {
                                    statusSelect.value = status;
                                }
                            }

                            const badge = document.getElementById('modal-status-badge');
                            const progressBar = document.getElementById('progress-bar-fill');
                            const dots = {
                                processing: document.getElementById('dot-processing'),
                                shipping: document.getElementById('dot-shipping'),
                                delivered: document.getElementById('dot-delivered')
                            };

                            const highlightDot = (dot, color) => {
                                if (!dot) return;
                                dot.style.backgroundColor = color;
                                dot.style.color = '#fff';
                            };

                            Object.values(dots).forEach(dot => {
                                if (!dot) return;
                                dot.style.backgroundColor = '#ddd';
                                dot.style.color = '#fff';
                            });

                            badge.textContent = status;
                            badge.style.color = 'white';
                            progressBar.style.width = '0%';

                            if (status === 'Chuẩn bị đơn hàng') {
                                badge.style.backgroundColor = '#fd7e14';
                                progressBar.style.width = '10%';
                                highlightDot(dots.processing, '#fd7e14');
                            } else if (status === 'Đang xử lý') {
                                badge.style.backgroundColor = '#6c757d';
                                progressBar.style.width = '30%';
                                highlightDot(dots.processing, '#6c757d');
                            } else if (status === 'Đang giao hàng') {
                                badge.style.backgroundColor = '#28a745';
                                progressBar.style.width = '70%';
                                highlightDot(dots.processing, '#28a745');
                                highlightDot(dots.shipping, '#28a745');
                            } else if (status === 'Giao hàng thành công' || status === 'Đã giao') {
                                badge.style.backgroundColor = '#28a745';
                                progressBar.style.width = '100%';
                                highlightDot(dots.processing, '#28a745');
                                highlightDot(dots.shipping, '#28a745');
                                highlightDot(dots.delivered, '#28a745');
                            } else if (status === 'Đã hủy' || status === 'Thanh toán thất bại') {
                                badge.style.backgroundColor = '#dc3545';
                            } else {
                                badge.style.backgroundColor = '#6c757d';
                            }

                            const modal = document.getElementById('orderDetailModal');
                            if (modal) {
                                modal.classList.add('show');
                            }
                        });
                    </script>
                </c:if>
            </body>

            </html>