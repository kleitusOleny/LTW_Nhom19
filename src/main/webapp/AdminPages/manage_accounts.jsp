<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <title>Quản Lí Tài Khoản Khách</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/AdminPages/admin_css/manage_accounts.css">
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
</head>
<body>
<div class="dashboard-container">
    <nav class="dashboard-sidebar">
        <ul class="sidebar-items">
            <div class="group-avatar">
                <%@ include file="/AdminPages/components/avatar.jsp" %>
                <%@ include file="/AdminPages/components/notify_icon.jsp" %>
            </div>
            <c:set var="activePage" value="account" scope="request" />
            <%@ include file="/AdminPages/components/sidebar_items_component.jsp" %>
        </ul>
        <div class="text">━ Được update tới 2025 ━</div>
    </nav>
    <div class="dashboard-content">
        <main class="dashboard-main-content">
            <div class="button-group">
                <div class="group-text-welcome">
                    <h2>Quản lí tài khoản</h2>
                    <p>Với các records được đánh dấu đỏ, nghĩa là đã khoá tài khoản</p>
                </div>
                <div class="func-group">
                    <button class="button del" id="deleteAll-modal-btn">
                        <ion-icon name="trash-outline"></ion-icon>
                        Khoá (Đã Chọn)
                    </button>
                    <button class="button unlockAll" id="unlock-modal-btn">
                        <ion-icon name="checkmark-outline"></ion-icon>
                        Mở (Đã Chọn)
                    </button>
                    <button class="button add" id="open-modal-btn">
                        <ion-icon name="add-outline" class="type-needCss"></ion-icon>
                        Thêm
                    </button>
<%--                    <button class="button excel" id="excel-modal-btn">--%>
<%--                        <ion-icon name="cloud-download-outline"></ion-icon>--%>
<%--                        Xuất ra Excel--%>
<%--                    </button>--%>
                </div>
            </div>
            <div class="table-container">
                <table id="account-table-main" class="account-table">
                    <thead>
                    <tr class="sample">
                        <th class="col-tick">Chọn</th>
                        <th class="col-id">ID Tài Khoản</th>
                        <th class="col-email">Email</th>
                        <th class="col-administrator">Admin</th>
                        <th class="col-phone">Số Liên Lạc</th>
                        <th class="col-fullname">Họ và Tên</th>
                        <th class="col-create">Ngày tạo</th>
                        <th class="col-action">Hành Động</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="user" items="${listAccount}">
                        <tr class="accounts ${user.active != 1 ? 'locked' : ''}">
                            <td class="cell-tick"><input type="checkbox" class="row-checkbox" value="${user.id}"/></td>
                            <td class="cell-id">${user.id}</td>
                            <td class="cell-email">${user.email}</td>
                            <td class="cell-administrator">${user.administrator}</td>
                            <td class="cell-phone">${user.phoneNumber}</td>
                            <td class="cell-fullname">${user.fullName}</td>
                            <td class="cell-create">${user.createdAt}</td>
                            <td class="cell-action">
                                <button class="edit btn edit-btn-trigger" data-target="modal-edit-${user.id}">Sửa</button>
                                <c:choose>
                                    <c:when test="${user.active == 1}">
                                        <%-- Đang hoạt động --%>
                                        <button class="lock btn" onclick="toggleUserStatus(${user.id}, 'block')">Khoá</button>
                                    </c:when>
                                    <c:otherwise>
                                        <%-- Đang bị khoá --%>
                                        <button class="unlock btn" onclick="toggleUserStatus(${user.id}, 'unlock')">Mở</button>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>

                        <div class="modal-overlay-edit_information" id="modal-edit-${user.id}">
                            <div class="modal-content-edit_information">
                                <h2>Bảng thông tin</h2>
                                <form action="${pageContext.request.contextPath}/account-manager/edit" method="POST">
                                <div class="edit-information-account">
                                    <div class="userId-section">
                                        <label for="id">ID:</label>
                                        <input type="text" id="id" name="id" value="${user.id}" placeholder="ID hiện không có" readonly>
                                    </div>
                                    <div class="email-section">
                                        <label for="email">Email</label>
                                        <input type="text" id="email" name="email" value="${user.email}" placeholder="Chưa có Email"
                                               required>
                                    </div>
                                    <div class="newPassword-section">
                                        <label for="newPass">Mật khẩu mới (nếu có)</label>
                                        <input type="text" id="password_" name="password_" placeholder="Nhập mật khẩu mới nếu muốn thay đổi">
                                    </div>
                                    <div class="fullname-section">
                                        <label for="fullname">Tên Đầy Đủ</label>
                                        <input type="text" id="fullname" name="fullname" value="${user.fullName}" placeholder="Chưa có tên"
                                               required>
                                    </div>
                                    <div class="birth-section">
                                        <label for="birth">Thời Gian Sinh</label>
                                        <input type="date" name="birth" value="<fmt:formatDate value='${user.birthDay}' pattern='yyyy-MM-dd' />" required>
                                    </div>
                                    <div class="username-section">
                                        <label for="username_">Tên Đăng Nhập</label>
                                        <input type="text" id="username_" name="username_" value="${user.username}" placeholder="Chưa có tên đăng nhập">
                                    </div>
                                    <div class="phone-section">
                                        <label for="phone-number">Số Điện Thoại</label>
                                        <input type="tel" id="phone-number" name="phone-number" value="${user.phoneNumber}"
                                               placeholder="Chưa có số điện thoại" required>
                                    </div>
                                    <div class="active-section">
                                        <label for="activeSelect">Đang hoạt động:</label>
                                        <select id="activeSelect" name="activeSelect" required>
                                            <option value="1" ${user.active == 1 ? 'selected' : ''}>Có</option>
                                            <option value="0" ${user.active == 0 ? 'selected' : ''}>Không</option>
                                        </select>
                                    </div>
                                    <div class="administrator-section">
                                        <label for="administratorSelect">Là Quản Trị Viên:</label>
                                        <select id="administratorSelect" name="administratorSelect" required>
                                            <option value="1" ${user.administrator == 1 ? 'selected' : ''}>Có</option>
                                            <option value="0" ${user.administrator == 0 ? 'selected' : ''}>Không</option>
                                        </select>
                                    </div>
                                    <div class="create_account-section">
                                        <label for="create-account">Ngày tạo</label>
                                        <input type="date" value="<fmt:formatDate value='${user.createdAt}' pattern="yyyy-MM-dd" />" disabled>
                                    </div>
                                </div>
                                    <div class="error-message">
                                        <c:if test="${editingId == user.id and not empty errorList}">
                                            <ul class="error-list-summary">
                                                <c:forEach var="msg" items="${errorList}">
                                                    <li><ion-icon name="alert-circle-outline"></ion-icon> ${msg}</li>
                                                </c:forEach>
                                            </ul>
                                        </c:if>
                                    </div>
                                <div class="group-button-action section">
                                    <button type="button" class="cancel element-button close-edit-modal" id="close-modal-btn7">Huỷ</button>
                                    <button type="submit" class="fix-btn element-button">Sửa</button>
                                </div>
                                </form>
                            </div>
                        </div>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </main>
    </div>
</div>

<div class="modal-overlay" id="add-account-modal">
    <div class="modal-content">
        <form id="add-form" action="${pageContext.request.contextPath}/account-manager/add" method="POST">
            <div class="username-input">
                <label for="username" class="label-with-icon">
                    <ion-icon name="person-outline"></ion-icon>
                    Tài Khoản</label>
                <input type="text" id="username" name="email" placeholder="Nhập Email"
                       value="${param.email}"
                       class="${not empty emailError ? 'input-error' : ''}" required>
                <span class="error-msg">${emailError}</span>
                <span class="error-msg">${emailError2}</span>
            </div>
            <div class="password-input">
                <label for="password" class="label-with-icon">
                    <ion-icon name="lock-closed-outline"></ion-icon>
                    Mật Khẩu</label>
                <input type="text" id="password" name="password" placeholder="Nhập mật khẩu"
                       class="${not empty passwordError ? 'input-error' : ''}" required>
                <span class="error-msg">${passwordError}</span>
            </div>
            <div class="group-button-action section">
                <button type="button" class="cancel element-button" id="close-modal-btn">Huỷ</button>
                <button type="submit" class="add-btn element-button">Thêm</button>
            </div>
        </form>
    </div>
</div>
<div class="modal-overlay-excel" id="excel-account-modal">
    <div class="modal-content-excel">
        <p>Thành công xuất ra file Excel</p>
        <button class="modal-close2" id="close-modal-btn5">
            <ion-icon name="close-outline"></ion-icon>
        </button>
    </div>
</div>
<div class="modal-overlay-deleteAll" id="deleteAll-account-modal">
    <div class="modal-content-deleteAll">
        <div class="group-text-deleteAll">
            <p class="p-deleteAll1">Bạn có chắc chắn muốn khoá toàn bộ tài khoản của các ô được chọn?</p>
            <p class="p-deleteAll2">
                <ion-icon name="warning-outline" class="icon-warning"></ion-icon>
                Có thể hoàn tác hành động này
            </p>
        </div>
        <div class="group-button-action delete-all">
            <button type="button" class="element-button" id="close-modal-btn6">Huỷ</button>
            <button type="submit" class="deleteAll-button">Khoá Tất Cả</button>
        </div>
    </div>
</div>
<div class="modal-overlay-unlockAll" id="unlock-account-btn">
    <div class="modal-content-unlockAll">
        <div class="group-text-unlockAll">
            <p class="p-deleteAll1">Bạn có chắc chắn muốn mở khoá toàn bộ tài khoản của các ô được chọn?</p>
            <p class="p-deleteAll2">
                <ion-icon name="warning-outline" class="icon-warning"></ion-icon>
                Có thể hoàn tác hành động này
            </p>
        </div>
        <div class="group-button-action delete-all">
            <button type="button" class="element-button" id="close-modal-btn7">Huỷ</button>
            <button type="submit" class="unlockAll-button">Mở Khoá Tất Cả</button>
        </div>
    </div>
</div>
<%@ include file="/AdminPages/components/notify_modal.jsp" %>
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
<c:if test="${errorSource == 'edit_account' and not empty editingId}">
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            const modal = document.getElementById('modal-edit-${editingId}');
            if (modal) modal.classList.add('show');
        });
    </script>
</c:if>
<c:if test="${errorSource == 'add_account'}">
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            const modal = document.getElementById('add-account-modal');
            if (modal) modal.classList.add('show');
        });
    </script>
</c:if>
<script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
<link href="https://fonts.googleapis.com/css2?family=Philosopher&display=swap" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="https://cdn.datatables.net/2.3.4/css/dataTables.dataTables.css"/>
<script src="https://cdn.datatables.net/2.3.4/js/dataTables.js"></script>
<script src="${pageContext.request.contextPath}/popup.js"></script>
<script src="${pageContext.request.contextPath}/preventspace.js"></script>
<style>
    .error-msg {
        color: red;
        font-size: 0.85em;
        font-style: italic;
        margin-top: -5px;
        display: block;
    }
    input.input-error {
        border: 1px solid red;
    }

    .error-message {
        margin-top: 15px;
        width: 100%;
    }
    .error-list-summary {
        background-color: #fff2f2;
        border-left: 4px solid #d8000c;
        padding: 10px 15px;
        margin: 0;
        list-style: none;
        border-radius: 4px;
    }
    .error-list-summary li {
        color: #d8000c;
        font-size: 0.9em;
        display: flex;
        align-items: center;
        gap: 8px;
        margin-bottom: 5px;
    }
    .error-list-summary li:last-child {
        margin-bottom: 0;
    }
</style>
<script>
    // Run Pop-up function
    document.addEventListener("DOMContentLoaded", function () {
        setupModal('add-account-modal', 'open-modal-btn', 'close-modal-btn');
        setupModal('excel-account-modal', 'excel-modal-btn', 'close-modal-btn5');
        setupModal('deleteAll-account-modal', 'deleteAll-modal-btn', 'close-modal-btn6');
        setupModal('unlock-account-btn', 'unlock-modal-btn', 'close-modal-btn7');
        setupModal('avatar-account-modal', 'avatar-modal-btn', 'close-modal-btn9');
        setupModal('notification-account-modal', 'notification-modal-btn', 'close-modal-btn8');
        setupDynamicModals('edit-btn-trigger', 'close-edit-modal');

        $(document).ready(function () {
            $('#account-table-main').DataTable({
                language: {
                    url: 'https://cdn.datatables.net/plug-ins/2.3.5/i18n/vi.json',
                },
            });
        });
    });
</script>
<script>
    $(document).ready(function () {
        // Hàm dùng chung để lấy ID và gửi AJAX
        // status: true (Khoá), false (Mở khoá)
        // modalId: ID của modal đang mở để đóng lại nếu người dùng chưa chọn gì
        function handleBulkAction(e, status, modalId) {
            e.preventDefault();

            var ids = [];
            var table = $('#account-table-main').DataTable();

            // Lấy tất cả các checkbox đã tick
            table.$('input.row-checkbox:checked').each(function () {
                ids.push($(this).val());
            });

            if (ids.length === 0) {
                alert("Vui lòng chọn ít nhất một tài khoản!");
                // Đóng modal tương ứng
                if(document.getElementById(modalId)) {
                    document.getElementById(modalId).classList.remove('show');
                }
                return;
            }

            // Gửi danh sách ID và status về Server
            $.ajax({
                url: '${pageContext.request.contextPath}/account-manager/lock-multiple',
                type: 'POST',
                data: {
                    ids: ids.join(','),
                    status: status
                },
                success: function (response) {
                    var actionText = status ? "Khoá" : "Mở khoá";
                    alert("Đã " + actionText + " các tài khoản đã chọn thành công!");
                    location.reload();
                },
                error: function (xhr, status, error) {
                    console.error(error);
                    alert("Có lỗi xảy ra khi xử lý.");
                }
            });
        }

        // Xử lý nút khoá tất cả (status = true)
        $('.deleteAll-button').click(function (e) {
            handleBulkAction(e, true, 'deleteAll-account-modal');
        });

        // Xử lý nút mở khoá tất cả (status = false)
        $('.unlockAll-button').click(function (e) {
            handleBulkAction(e, false, 'unlock-account-btn');
        });
    });
</script>
<script>
    const listFields = ['#username, #password, #email, #password_, #birth, #username_, #phone-number'];
    preventspace(listFields)

    function toggleUserStatus(userId, currentAction) {
        // Tạo tin nhắn xác nhận tuỳ theo hành động
        let message = (currentAction === 'block')
            ? "Bạn có chắc chắn muốn KHOÁ tài khoản này không?"
            : "Bạn có chắc chắn muốn MỞ KHOÁ tài khoản này không?";

        if (confirm(message)) {
            // Gọi xuống Servlet
            fetch('${pageContext.request.contextPath}/account-manager/toggle-status', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'id=' + userId
            })
                .then(response => {
                    if (response.ok) {
                        // Nếu thành công, load lại trang để cập nhật giao diện
                        location.reload();
                    } else {
                        alert("Có lỗi xảy ra, vui lòng thử lại!");
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert("Lỗi kết nối tới server.");
                });
        }
    }
</script>
</body>

</html>