<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <title>Quản Lý Đánh Giá</title>
                <link rel="stylesheet"
                    href="${pageContext.request.contextPath}/AdminPages/admin_css/manage_reviews_style.css">
            </head>

            <body>
                <div class="dashboard-container">
                    <nav class="dashboard-sidebar">
                        <ul class="sidebar-items">
                            <div class="group-avatar">
                                <%@ include file="/AdminPages/components/avatar.jsp" %>
                                    <%@ include file="/AdminPages/components/notify_icon.jsp" %>
                            </div>
                            <c:set var="activePage" value="review" scope="request" />
                            <%@ include file="/AdminPages/components/sidebar_items_component.jsp" %>
                        </ul>
                        <div class="text">━ Được update tới 2025 ━</div>
                    </nav>
                    <div class="dashboard-content">
                        <main class="dashboard-main-content">
                            <div class="button-group">
                                <h2>Quản lí đánh giá sản phẩm</h2>
                                <div class="stats-group">
                                    <div class="stat-item">
                                        <ion-icon name="chatbubbles-outline"></ion-icon>
                                        <span>Tổng: <strong>${totalReviews}</strong> đánh giá</span>
                                    </div>
                                    <div class="stat-item">
                                        <ion-icon name="star"></ion-icon>
                                        <span>TB: <strong>${avgRating}</strong> sao</span>
                                    </div>
                                </div>
                                <div class="func-group">
                                    <button class="button del" id="deleteAll-modal-btn">
                                        <ion-icon name="trash-outline"></ion-icon>
                                        Xoá (Đã Chọn)
                                    </button>
                                </div>
                            </div>
                            <div class="table-container">
                                <table id="review-table-main" class="review-table">
                                    <thead>
                                        <tr class="sample">
                                            <th class="col-tick">Chọn</th>
                                            <th class="col-id">ID</th>
                                            <th class="col-user">Người Dùng</th>
                                            <th class="col-product">Sản Phẩm</th>
                                            <th class="col-star">Số Sao</th>
                                            <th class="col-content">Nội Dung Đánh Giá</th>
                                            <th class="col-date">Thời Gian</th>
                                            <th class="col-status">Trạng Thái</th>
                                            <th class="col-action">Hành Động</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${reviews}" var="r">
                                            <tr class="reviews">
                                                <td class="cell-tick"><input type="checkbox" class="row-checkbox"
                                                        value="${r.id}" /></td>
                                                <td class="cell-id">${r.id}</td>
                                                <td class="cell-user">
                                                    <div class="user-info">
                                                        <span class="user-name">${r.userName}</span>
                                                        <span class="user-email">${r.userEmail}</span>
                                                    </div>
                                                </td>
                                                <td class="cell-product">${r.productName}</td>
                                                <td class="cell-star">
                                                    <div class="star-display">
                                                        <c:forEach begin="1" end="5" var="i">
                                                            <c:choose>
                                                                <c:when test="${i <= r.star}">
                                                                    <ion-icon name="star"
                                                                        class="star-filled"></ion-icon>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <ion-icon name="star-outline"
                                                                        class="star-empty"></ion-icon>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </c:forEach>
                                                        <span class="star-number">(${r.star})</span>
                                                    </div>
                                                </td>
                                                <td class="cell-content">
                                                    <div class="content-preview" title="${r.content}">
                                                        ${r.content}
                                                    </div>
                                                </td>
                                                <td class="cell-date">
                                                    <fmt:parseDate value="${r.createAt}" pattern="yyyy-MM-dd'T'HH:mm"
                                                        var="parsedDate" type="both" />
                                                    <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy HH:mm" />
                                                </td>
                                                <td class="cell-status">
                                                    <c:choose>
                                                        <c:when test="${r.deleted}">
                                                            <span class="status-deleted">Đã xóa</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="status-active">Hiển thị</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td class="cell-action">
                                                    <button class="view btn"
                                                        onclick="viewReview(${r.id}, '${r.userName}', '${r.productName}', ${r.star}, '${r.content}')">
                                                        <ion-icon name="eye-outline"></ion-icon>
                                                    </button>
                                                    <button class="edit btn"
                                                        onclick="location.href='${pageContext.request.contextPath}/admin/get-review?id=${r.id}'">
                                                        <ion-icon name="create-outline"></ion-icon>
                                                    </button>
                                                    <c:choose>
                                                        <c:when test="${r.deleted}">
                                                            <button class="restore btn"
                                                                onclick="confirmRestore(${r.id})">
                                                                <ion-icon name="refresh-outline"></ion-icon>
                                                            </button>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <button class="delete btn" onclick="confirmDelete(${r.id})">
                                                                <ion-icon name="trash-outline"></ion-icon>
                                                            </button>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </main>
                    </div>
                </div>

                <!-- Modal Xem Chi Tiết -->
                <div class="modal-overlay" id="view-review-modal">
                    <div class="modal-content">
                        <h2>Chi tiết đánh giá</h2>
                        <div class="review-detail">
                            <div class="detail-row">
                                <label>Người dùng:</label>
                                <span id="view-user-name"></span>
                            </div>
                            <div class="detail-row">
                                <label>Sản phẩm:</label>
                                <span id="view-product-name"></span>
                            </div>
                            <div class="detail-row">
                                <label>Số sao:</label>
                                <span id="view-star"></span>
                            </div>
                            <div class="detail-row full-width">
                                <label>Nội dung:</label>
                                <p id="view-content" class="content-full"></p>
                            </div>
                        </div>
                        <div class="group-button-action section">
                            <button type="button" class="cancel element-button" id="close-view-modal-btn">Đóng</button>
                        </div>
                    </div>
                </div>

                <!-- Modal Xác nhận xóa nhiều -->
                <div class="modal-overlay-deleteAll" id="deleteAll-review-modal">
                    <div class="modal-content-deleteAll">
                        <div class="group-text-deleteAll">
                            <p class="p-deleteAll1">Bạn có chắc chắn muốn xoá toàn bộ đánh giá đã chọn?</p>
                            <p class="p-deleteAll2">
                                <ion-icon name="warning-outline" class="icon-warning"></ion-icon>
                                Hành động này sẽ không thể hoàn tác
                            </p>
                        </div>
                        <div class="group-button-action delete-all">
                            <button type="button" class="element-button" id="close-modal-btn6">Huỷ</button>
                            <button type="submit" class="deleteAll-button" onclick="deleteSelectedReviews()">Xoá Tất
                                Cả</button>
                        </div>
                    </div>
                </div>

                <!-- Modal Sửa Đánh Giá -->
                <div class="modal-overlay-edit_information" id="edit_information-review-modal">
                    <div class="modal-content-edit_information">
                        <h2>Sửa đánh giá</h2>
                        <form action="${pageContext.request.contextPath}/admin/update-review" method="post">
                            <input type="hidden" id="edit-id" name="id" value="${reviewEdit.id}">
                            <div class="edit-information-review">
                                <div class="info-section readonly">
                                    <label>Người dùng:</label>
                                    <span>${reviewEdit.userName}</span>
                                </div>
                                <div class="info-section readonly">
                                    <label>Sản phẩm:</label>
                                    <span>${reviewEdit.productName}</span>
                                </div>
                                <div class="star-section">
                                    <label for="star_edit">Số Sao</label>
                                    <select id="star_edit" name="star" required>
                                        <option value="1" ${reviewEdit.star==1 ? 'selected' : '' }>1 sao</option>
                                        <option value="2" ${reviewEdit.star==2 ? 'selected' : '' }>2 sao</option>
                                        <option value="3" ${reviewEdit.star==3 ? 'selected' : '' }>3 sao</option>
                                        <option value="4" ${reviewEdit.star==4 ? 'selected' : '' }>4 sao</option>
                                        <option value="5" ${reviewEdit.star==5 ? 'selected' : '' }>5 sao</option>
                                    </select>
                                </div>
                                <div class="content-section">
                                    <label for="content_edit">Nội dung đánh giá</label>
                                    <textarea id="content_edit" name="content" rows="5"
                                        required>${reviewEdit.content}</textarea>
                                </div>
                            </div>
                            <div class="group-button-action section">
                                <button type="button" class="cancel element-button" id="close-modal-btn7">Huỷ</button>
                                <button type="submit" class="fix-btn element-button">Lưu thay đổi</button>
                            </div>
                        </form>
                    </div>
                </div>



                <!-- Modal Notification -->
                <div class="modal-overlay-notification" id="notification-review-modal">
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

                <!-- Modal Avatar -->
                <div class="modal-overlay-avatar" id="avatar-review-modal">
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
                    // Run Pop-up function
                    document.addEventListener("DOMContentLoaded", function () {
                        setupModal('view-review-modal', null, 'close-view-modal-btn');
                        setupModal('excel-review-modal', 'excel-modal-btn', 'close-modal-btn5');
                        setupModal('deleteAll-review-modal', 'deleteAll-modal-btn', 'close-modal-btn6');
                        setupModal('edit_information-review-modal', 'edit-modal-btn', 'close-modal-btn7');
                        setupModal('notification-review-modal', 'notification-modal-btn', 'close-modal-btn8');
                        setupModal('avatar-review-modal', 'avatar-modal-btn', 'close-modal-btn9');

                        $(document).ready(function () {
                            $('#review-table-main').DataTable({
                                language: {
                                    url: 'https://cdn.datatables.net/plug-ins/2.3.5/i18n/vi.json',
                                },
                                order: [[6, 'desc']], // Sắp xếp theo thời gian mới nhất
                            });
                        });
                    });

                    function viewReview(id, userName, productName, star, content) {
                        document.getElementById('view-user-name').textContent = userName;
                        document.getElementById('view-product-name').textContent = productName;

                        // Generate star display
                        let starHtml = '';
                        for (let i = 1; i <= 5; i++) {
                            if (i <= star) {
                                starHtml += '<ion-icon name="star" class="star-filled"></ion-icon>';
                            } else {
                                starHtml += '<ion-icon name="star-outline" class="star-empty"></ion-icon>';
                            }
                        }
                        starHtml += ' (' + star + ')';
                        document.getElementById('view-star').innerHTML = starHtml;

                        document.getElementById('view-content').textContent = content;
                        document.getElementById('view-review-modal').classList.add('show');
                    }

                    function confirmDelete(id) {
                        if (confirm('Bạn có chắc chắn muốn xóa đánh giá này không?')) {
                            fetch('${pageContext.request.contextPath}/admin/delete-review?id=' + id, {
                                method: 'POST'
                            }).then(response => {
                                if (response.ok) {
                                    window.location.reload();
                                } else {
                                    alert('Có lỗi xảy ra khi xóa đánh giá');
                                }
                            });
                        }
                    }

                    function confirmRestore(id) {
                        if (confirm('Bạn có chắc chắn muốn khôi phục đánh giá này không?')) {
                            fetch('${pageContext.request.contextPath}/admin/restore-review?id=' + id, {
                                method: 'POST'
                            }).then(response => {
                                if (response.ok) {
                                    window.location.reload();
                                } else {
                                    alert('Có lỗi xảy ra khi khôi phục đánh giá');
                                }
                            });
                        }
                    }

                    function deleteSelectedReviews() {
                        const checkboxes = document.querySelectorAll('.row-checkbox:checked');
                        if (checkboxes.length === 0) {
                            alert('Vui lòng chọn ít nhất một đánh giá để xóa');
                            return;
                        }

                        const ids = Array.from(checkboxes).map(cb => cb.value);

                        Promise.all(ids.map(id =>
                            fetch('${pageContext.request.contextPath}/admin/delete-review?id=' + id, {
                                method: 'POST'
                            })
                        )).then(() => {
                            window.location.reload();
                        }).catch(() => {
                            alert('Có lỗi xảy ra khi xóa đánh giá');
                        });
                    }

                    <c:if test="${not empty reviewEdit}">
                        $(document).ready(function() {
                            document.getElementById('edit_information-review-modal').classList.add('show');
            });
                    </c:if>

                    // Close modal logic
                    document.getElementById('close-modal-btn7').addEventListener('click', function () {
                        document.getElementById('edit_information-review-modal').classList.remove('show');
                        location.href = '${pageContext.request.contextPath}/admin/manage-reviews';
                    });

        <c:if test="${not empty errorMessage}">
            alert('${errorMessage}');
        </c:if>

        <c:if test="${not empty successMessage}">
            // Có thể hiển thị toast notification thay vì alert
            console.log('${successMessage}');
        </c:if>
                </script>
            </body>

            </html>