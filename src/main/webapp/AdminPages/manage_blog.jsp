<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <title>Blog Manage</title>
                <meta name="viewport" content="width=device-width, initial-scale=1">
                <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
                <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
                <script src="../popup.js"></script>
                <link rel="stylesheet" type="text/css"
                    href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css">
                <link rel="stylesheet"
                    href="${pageContext.request.contextPath}/AdminPages/admin_css/manager_blog_style.css">
            </head>

            <body>
                <div class="dashboard-container">
                    <nav class="dashboard-sidebar">
                        <ul class="sidebar-items">
                            <div class="group-avatar">
                                <%@ include file="/AdminPages/components/avatar.jsp" %>
                                <%@ include file="/AdminPages/components/notify_icon.jsp" %>
                            </div>
                            <c:set var="activePage" value="blog" scope="request" />
                            <%@ include file="/AdminPages/components/sidebar_items_component.jsp" %>
                        </ul>
                        <div class="text">━ Được update tới 2025 ━</div>
                    </nav>
                    <div class="dashboard-content">
                        <main class="dashboard-main-content">
                            <div class="button-group">
                                <h2>Quản lí Blog và Tin tức</h2>
                                <div class="func-group">
                                    <button class="button del" id="deleteAll-modal-btn">
                                        <ion-icon name="trash-outline"></ion-icon>
                                        Xoá (Đã chọn)
                                    </button>
                                    <button class="button" id="fetch-news-btn" style="background-color: #4CAF50;">
                                        <ion-icon name="refresh-outline"></ion-icon>
                                        Lấy Tin Tức
                                    </button>
                                    <button class="button add" id="open-modal-btn">
                                        <ion-icon name="add-outline" class="type-needCss"></ion-icon>
                                        Thêm Bài
                                    </button>
                                </div>
                            </div>
                            <form action="${pageContext.request.contextPath}/admin/bulk-delete-blog" method="post"
                                id="bulk-delete-form">
                                <div class="table-container">
                                    <table id="account-table-main" class="account-table">
                                        <thead>
                                            <tr class="sample">
                                                <th class="col-tick">Chọn</th>
                                                <th class="col-id">ID</th>
                                                <th class="col-title">Tiêu đề</th>
                                                <th class="col-author">Tác giả</th>
                                                <th class="col-date">Ngày đăng</th>
                                                <th class="col-status">Trạng thái</th>
                                                <th class="col-action">Hành động</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${blogs}" var="blog">
                                                <tr class="blogs">
                                                    <td class="cell-tick"><input type="checkbox" class="row-checkbox"
                                                            name="blogIds" value="${blog.id}" /></td>
                                                    <td class="cell-id">${blog.id}</td>
                                                    <td class="cell-title">${blog.title}</td>
                                                    <td class="cell-author">Admin</td>
                                                    <td class="cell-date">${blog.cardDate}</td>
                                                    <td class="cell-status">${blog.display ? 'Hiện' : 'Ẩn'}</td>
                                                    <td class="cell-action">
                                                        <form
                                                            action="${pageContext.request.contextPath}/admin/delete-blog?id=${blog.id}"
                                                            method="post" style="display: inline;"
                                                            onsubmit="return confirm('Bạn có chắc chắn muốn xóa bài viết này không?')">
                                                            <button type="submit" class="delete btn">Xoá</button>
                                                        </form>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </form>
                        </main>
                    </div>
                </div>

                <div class="modal-overlay" id="add-blog-modal">
                    <div class="modal-content approve-modal"
                        style="max-width: 90%; max-height: 90vh; overflow-y: auto;">
                        <h2>Duyệt Bài Viết</h2>
                        <div id="news-message"
                            style="padding: 15px; margin-bottom: 15px; border-radius: 4px; display: none;"></div>
                        <div id="news-table-container">
                            <table class="approve-table" style="width: 100%; border-collapse: collapse;">
                                <thead>
                                    <tr style="background-color: #f5f5f5;">
                                        <th
                                            style="padding: 10px; text-align: center; border: 1px solid #ddd; width: 50px;">
                                            Chọn
                                        </th>
                                        <th style="padding: 10px; text-align: left; border: 1px solid #ddd;">Tiêu đề
                                        </th>
                                        <th
                                            style="padding: 10px; text-align: left; border: 1px solid #ddd; width: 200px;">
                                            Nguồn
                                        </th>
                                    </tr>
                                </thead>
                                <tbody id="news-table-body">
                                    <tr>
                                        <td colspan="3" style="padding: 40px; text-align: center; color: #999;">
                                            <ion-icon name="newspaper-outline"
                                                style="font-size: 48px; display: block; margin: 0 auto 10px;"></ion-icon>
                                            Nhấn "Lấy Tin Tức" để tải bài viết mới
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="group-button-action section" style="margin-top: 20px;">
                            <button type="button" class="cancel element-button" id="close-modal-btn">Đóng</button>
                            <button type="button" class="fix-btn element-button" id="approve-selected-btn"
                                style="display: none;">Thêm mới
                            </button>
                        </div>
                    </div>
                </div>


                <div class="modal-overlay-deleteAll" id="deleteAll-blog-modal">
                    <div class="modal-content-deleteAll">
                        <div class="group-text-deleteAll">
                            <p class="p-deleteAll1">Bạn có chắc chắn muốn xoá toàn bộ dữ liệu của các ô được chọn?
                            </p>
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
                <div class="modal-overlay-edit_information" id="edit_information-blog-modal">
                    <div class="modal-content-edit_information">
                        <h2>Sửa trạng thái bài viết</h2>
                        <form action="${pageContext.request.contextPath}/admin/update-blog" method="post">
                            <input type="hidden" id="edit-id" name="id">
                            <input type="hidden" id="edit-title" name="title">
                            <input type="hidden" id="edit-content" name="content">
                            <input type="hidden" id="edit-image" name="image">
                            <input type="hidden" id="edit-category" name="category">
                            <div class="edit-information-account">
                                <div class="status-section">
                                    <label for="edit-status">Trạng thái</label>
                                    <select id="edit-status" name="status" required
                                        style="width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 4px; font-size: 16px;">
                                        <option value="Hiện">Hiện</option>
                                        <option value="Ẩn">Ẩn</option>
                                    </select>
                                </div>
                            </div>
                            <div class="group-button-action section">
                                <button type="button" class="cancel element-button" id="close-modal-btn7">Huỷ
                                </button>
                                <button type="submit" class="fix-btn element-button">Lưu thay đổi</button>
                            </div>
                        </form>
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

                    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
                    <link rel="stylesheet" href="https://cdn.datatables.net/2.3.4/css/dataTables.dataTables.css" />
                    <script src="https://cdn.datatables.net/2.3.4/js/dataTables.js"></script>
                    <script src="../popup.js"></script>
                    <script>
                        document.addEventListener("DOMContentLoaded", function () {
                            setupModal('add-blog-modal', 'open-modal-btn', 'close-modal-btn');
                            setupModal('excel-blog-modal', 'excel-modal-btn', 'close-modal-btn5');
                            setupModal('deleteAll-blog-modal', 'deleteAll-modal-btn', 'close-modal-btn6');
                            setupModal('edit_information-blog-modal', 'edit-modal-btn', 'close-modal-btn7');
                            setupModal('notification-account-modal', 'notification-modal-btn', 'close-modal-btn8');
                            setupModal('avatar-account-modal', 'avatar-modal-btn', 'close-modal-btn9');

                            document.getElementById('deleteAll-modal-btn').addEventListener('click', function (e) {
                                e.preventDefault();
                                const checkboxes = document.querySelectorAll('.row-checkbox:checked');

                                if (checkboxes.length === 0) {
                                    alert('Vui lòng chọn ít nhất một bài viết để xóa');
                                    return;
                                }

                                if (confirm(`Bạn có chắc chắn muốn xóa ${checkboxes.length} bài viết đã chọn?`)) {
                                    document.getElementById('bulk-delete-form').submit();
                                }
                            });

                            $(document).ready(function () {
                                $('#account-table-main').DataTable({
                                    language: {
                                        url: 'https://cdn.datatables.net/plug-ins/2.3.5/i18n/vi.json',
                                    },
                                });

                                $('#account-table-main').on('click', '.edit-blog-btn', function () {
                                    const blogId = $(this).data('blog-id');
                                    console.log('Edit button clicked for blog ID:', blogId);
                                    openEditModal(blogId);
                                });
                            });
                        });

                        function confirmDelete(id) {
                            if (confirm('Bạn có chắc chắn muốn xóa bài viết này không?')) {
                                fetch('${pageContext.request.contextPath}/admin/delete-blog?id=' + id, {
                                    method: 'POST'
                                }).then(response => {
                                    if (response.ok) {
                                        window.location.reload();
                                    } else {
                                        alert('Có lỗi xảy ra khi xóa bài viết');
                                    }
                                });
                            }
                        }

                        function openEditModal(id) {
                            console.log('Opening edit modal for blog ID:', id);
                            fetch('${pageContext.request.contextPath}/admin/get-blog?id=' + id)
                                .then(response => {
                                    console.log('Response status:', response.status);
                                    if (!response.ok) {
                                        throw new Error('HTTP error! status: ' + response.status);
                                    }
                                    return response.json();
                                })
                                .then(data => {
                                    console.log('Blog data received:', data);
                                    document.getElementById('edit-id').value = data.id;
                                    document.getElementById('edit-title').value = data.title;
                                    document.getElementById('edit-content').value = data.content;
                                    document.getElementById('edit-image').value = data.blogImage || '';
                                    document.getElementById('edit-category').value = data.category || 'Tin tức';
                                    document.getElementById('edit-status').value = data.display ? 'Hiện' : 'Ẩn';

                                    console.log('Opening modal...');
                                    document.getElementById('edit_information-blog-modal').classList.add('active');
                                })
                                .catch(error => {
                                    console.error('Error fetching blog data:', error);
                                    alert('Không thể tải thông tin bài viết: ' + error.message);
                                });
                        }

                        document.getElementById('close-modal-btn7').addEventListener('click', function () {
                            document.getElementById('edit_information-blog-modal').classList.remove('active');
                        });

                        let fetchedNewsData = [];
                        document.getElementById('fetch-news-btn').addEventListener('click', function () {
                            document.getElementById('add-blog-modal').classList.add('active');

                            const tbody = document.getElementById('news-table-body');
                            const messageDiv = document.getElementById('news-message');
                            tbody.innerHTML = '<tr><td colspan="3" style="padding: 40px; text-align: center;"><ion-icon name="hourglass-outline" style="font-size: 48px; display: block; margin: 0 auto 10px;"></ion-icon>Đang tải tin tức...</td></tr>';

                            fetch('${pageContext.request.contextPath}/fetch-news')
                                .then(response => response.json())
                                .then(data => {
                                    if (data.success) {
                                        fetchedNewsData = data.news;
                                        messageDiv.style.display = 'block';
                                        messageDiv.style.backgroundColor = '#d4edda';
                                        messageDiv.style.color = '#155724';
                                        messageDiv.textContent = data.message;

                                        tbody.innerHTML = '';
                                        data.news.forEach((article, index) => {
                                            console.log('Article:', article); // Debug log
                                            const row = document.createElement('tr');
                                            row.style.borderBottom = '1px solid #ddd';

                                            const title = article.title || article.Title || 'Không có tiêu đề';
                                            const source = article.source_id || article.source_name || article.source || 'Không rõ';

                                            row.innerHTML = `
                                            <td style="padding: 10px; text-align: center; border: 1px solid #ddd;">
                                                <input type="checkbox" class="news-checkbox" data-index="${index}">
                                            </td>
                                            <td style="padding: 10px; border: 1px solid #ddd;">${title}</td>
                                            <td style="padding: 10px; border: 1px solid #ddd;">${source}</td>
                                        `;
                                            tbody.appendChild(row);
                                        });

                                        document.getElementById('approve-selected-btn').style.display = 'inline-block';
                                    } else {
                                        messageDiv.style.display = 'block';
                                        messageDiv.style.backgroundColor = '#f8d7da';
                                        messageDiv.style.color = '#721c24';
                                        messageDiv.textContent = data.message;
                                        tbody.innerHTML = '<tr><td colspan="3" style="padding: 40px; text-align: center; color: #999;">Không có tin tức mới</td></tr>';
                                        document.getElementById('approve-selected-btn').style.display = 'none';
                                    }
                                })
                                .catch(error => {
                                    messageDiv.style.display = 'block';
                                    messageDiv.style.backgroundColor = '#f8d7da';
                                    messageDiv.style.color = '#721c24';
                                    messageDiv.textContent = 'Lỗi khi tải tin tức: ' + error;
                                    tbody.innerHTML = '<tr><td colspan="3" style="padding: 40px; text-align: center; color: #d32f2f;">Có lỗi xảy ra</td></tr>';
                                });
                        });

                        document.getElementById('approve-news-form').addEventListener('submit', function (e) {
                            e.preventDefault();

                            const checkboxes = document.querySelectorAll('.news-checkbox:checked');
                            if (checkboxes.length === 0) {
                                alert('Vui lòng chọn ít nhất một bài viết');
                                return false;
                            }

                            const selectedNews = [];
                            checkboxes.forEach(cb => {
                                const index = parseInt(cb.dataset.index);
                                selectedNews.push(fetchedNewsData[index]);
                            });

                            const input = document.createElement('input');
                            input.type = 'hidden';
                            input.name = 'newsData';
                            input.value = JSON.stringify(selectedNews);
                            this.appendChild(input);

                            this.submit();
                        });
                    </script>

            </body>

            </html>