            </div>
            <div class="group-button-action delete-all">
                <button type="button" class="element-button" id="close-modal-btn6">Huỷ</button>
                <button type="submit" class="deleteAll-button">Xoá Tất Cả</button>
            </div>
        </div>
    </div>
</div>

<div class="modal-overlay" id="apply-discount-modal">
    <div class="modal-content">
        <div class="modal-header-custom">
            <h2>
                <ion-icon name="pricetag-outline"></ion-icon>
                Áp dụng mã giảm giá
            </h2>
            <button class="modal-close" id="close-apply-modal-btn">
                <ion-icon name="close-outline"></ion-icon>
            </button>
        </div>
        <form id="applyDiscountForm" class="apply-form">
            <label for="discountSelect" class="form-label-custom">Chọn mã giảm giá</label>
            <select id="discountSelect" class="custom-select" required>
                <option value="">-- Chọn mã giảm giá --</option>
                <c:forEach items="${discounts}" var="discount">
                    <option value="${discount.id}">
                        ${discount.discountCode} -
                        <fmt:formatNumber value="${discount.discountValue}" type="number" maxFractionDigits="0" />
                        <c:choose>
                            <c:when test="${discount.discountType == 'PERCENT' || discount.discountType == 'percent'}">%</c:when>
                            <c:otherwise>đ</c:otherwise>
                        </c:choose>
                    </option>
                </c:forEach>
            </select>

            <label class="form-label-custom">Chọn kiểu áp dụng</label>
            <div class="apply-type-group">
                <label class="radio-pill">
                    <input type="radio" name="applyType" value="CATEGORY" checked>
                    <span>Category</span>
                </label>
                <label class="radio-pill">
                    <input type="radio" name="applyType" value="PRODUCT">
                    <span>Product</span>
                </label>
                <label class="radio-pill">
                    <input type="radio" name="applyType" value="MANUFACTURER">
                    <span>Manufacturer</span>
                </label>
            </div>

            <div class="apply-lists">
                <div class="apply-section" data-apply="CATEGORY">
                    <p class="section-title">Danh mục</p>
                    <c:if test="${empty categories}">
                        <div class="empty-note">Chưa có danh mục khả dụng.</div>
                    </c:if>
                    <c:forEach items="${categories}" var="cat">
                        <label class="checkbox-row">
                            <input type="checkbox" name="categoryIds" value="${cat.id}">
                            <span>${cat.categoryName}</span>
                        </label>
                    </c:forEach>
                </div>
                <div class="apply-section d-none" data-apply="PRODUCT">
                    <p class="section-title">Sản phẩm</p>
                    <c:if test="${empty products}">
                        <div class="empty-note">Chưa có sản phẩm khả dụng.</div>
                    </c:if>
                    <c:forEach items="${products}" var="p">
                        <label class="checkbox-row">
                            <input type="checkbox" name="productIds" value="${p.id}">
                            <span>${p.productName} (Mã: ${p.id})</span>
                        </label>
                    </c:forEach>
                </div>
                <div class="apply-section d-none" data-apply="MANUFACTURER">
                    <p class="section-title">Nhà sản xuất</p>
                    <c:if test="${empty manufacturers}">
                        <div class="empty-note">Chưa có nhà sản xuất khả dụng.</div>
                    </c:if>
                    <c:forEach items="${manufacturers}" var="manu">
                        <label class="checkbox-row">
                            <input type="checkbox" name="manufacturerIds" value="${manu.id}">
                            <span>${manu.manufacturerName}</span>
                        </label>
                    </c:forEach>
                </div>
            </div>

            <div id="applyAlert" class="alert-box d-none"></div>

            <div class="group-button-action section">
                <button type="button" class="cancel element-button" id="cancel-apply-btn">Huỷ</button>
                <button type="button" class="fix-btn element-button" id="applyDiscountBtn">Lưu</button>
            </div>
        </form>
    </div>
</div>

<div class="modal-overlay-edit_information" id="edit_information-promotion-modal">
    <div class="modal-content-edit_information">
        <h2>Sửa khuyến mãi</h2>
        <form action="${pageContext.request.contextPath}/admin/update-promotion" method="post">
            <input type="hidden" id="edit-id" name="id" value="${discountEdit.id}">
            <div class="edit-information-promotion">
                <div class="code-section">
                    <label for="code_edit">Mã Giảm Giá</label>
                    <input type="text" id="code_edit" name="code_edit"
                           value="${discountEdit.discountCode}" required>
                </div>
                <div class="type-section">
                    <label for="type_edit">Loại</label>
                    <select id="type_edit" name="type_edit" required>
                        <option value="Phần trăm" ${discountEdit.discountType=='Phần trăm' ? 'selected'
                                : '' }>Phần trăm</option>
                        <option value="Số tiền cố định" ${discountEdit.discountType=='Số tiền cố định'
                                ? 'selected' : '' }>Số tiền cố định</option>
                        <option value="Miễn phí vận chuyển"
                                ${discountEdit.discountType=='Miễn phí vận chuyển' ? 'selected' : '' }>Miễn
                            phí vận chuyển</option>
                    </select>
                </div>
                <div class="value-section">
                    <label for="value_edit">Giá Trị</label>
                    <input type="text" id="value_edit" name="value_edit"
                           value="${discountEdit.discountValue}" required>
                </div>
                <div class="quantity-section">
                    <label for="quantity_edit">Số Lượng</label>
                    <input type="number" id="quantity_edit" name="quantity_edit"
                           value="${discountEdit.quantity}" required>
                </div>
                <div class="apply-type-section">
                    <label for="apply_type_edit">Loại Áp Dụng</label>
                    <select id="apply_type_edit" name="apply_type_edit" required>
                        <option value="order" ${discountEdit.applyType=='order' ? 'selected' : '' }>Đơn
                            hàng</option>
                        <option value="shipping" ${discountEdit.applyType=='shipping' ? 'selected' : ''
                                }>Vận chuyển</option>
                    </select>
                </div>
                <div class="start-section">
                    <label for="start_edit">Ngày Bắt Đầu</label>
                    <fmt:formatDate value="${discountEdit.discountFrom}" pattern="yyyy-MM-dd"
                                    var="formattedFrom"/>
                    <input type="date" id="start_edit" name="start_edit" value="${formattedFrom}"
                           required>
                </div>
                <div class="end-section">
                    <label for="end_edit">Ngày Kết Thúc</label>
                    <fmt:formatDate value="${discountEdit.discountTo}" pattern="yyyy-MM-dd"
                                    var="formattedTo"/>
                    <input type="date" id="end_edit" name="end_edit" value="${formattedTo}" required>
                </div>
                <div class="status-section">
                    <label for="status_edit">Trạng Thái</label>
                    <select id="status_edit" name="status_edit" required>
                        <option value="Hoạt động" ${discountEdit.active ? 'selected' : '' }>Hoạt động
                        </option>
                        <option value="Không hoạt động" ${!discountEdit.active ? 'selected' : '' }>Không
                            hoạt động</option>
                    </select>
                </div>
            </div>
            <div class="group-button-action section">
                <button type="button" class="cancel element-button" id="close-modal-btn7">Huỷ</button>
                <button type="submit" class="fix-btn element-button">Lưu thay đổi</button>
            </div>
        </form>
    </div>
</div>

<div class="modal-overlay-notification" id="notification-promotion-modal">
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

<div class="modal-overlay-avatar" id="avatar-promotion-modal">
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
<script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
<script>
    $(document).ready(function () {
        $('#promotion-table-main').DataTable({
            language: {
                url: 'https://cdn.datatables.net/plug-ins/1.11.5/i18n/Vietnamese.json',
            },
        });
    });

    function confirmDelete(id) {
        if (confirm('Bạn có chắc chắn muốn xóa khuyến mãi này không?')) {
            fetch('${pageContext.request.contextPath}/admin/delete-promotion?id=' + id, {
                method: 'POST'
            }).then(response => {
                if (response.ok) {
                    window.location.reload();
                } else {
                    alert('Có lỗi xảy ra khi xóa khuyến mãi');
                }
            });
        }
    }

    <c:if test="${not empty discountEdit}">
        $(document).ready(function() {
            document.getElementById('edit_information-promotion-modal').classList.add('show');
        });
    </c:if>

    function openEditModal(id) {
        // This function is now replaced by location.href in the button
        location.href = '${pageContext.request.contextPath}/admin/get-promotion?id=' + id;
    }

    // Close modal logic
    document.getElementById('close-modal-btn7').addEventListener('click', function () {
        document.getElementById('edit_information-promotion-modal').classList.remove('show');
        // Optional: Clear URL parameter or redirect back to main list to avoid re-opening on refresh
        location.href = '${pageContext.request.contextPath}/admin/manage-promotions';
    });
    document.getElementById('type').addEventListener('change', function () {
        const type = this.value;
        const valueInput = document.getElementById('value');
        const unitLabel = document.getElementById('value-unit');

        if (type === 'Phần trăm') {
            valueInput.placeholder = 'Nhập số phần trăm (VD: 10)';
            unitLabel.textContent = '%';
        } else if (type === 'Số tiền cố định') {
            valueInput.placeholder = 'Nhập số tiền (VD: 50000)';
            unitLabel.textContent = 'đ';
        } else {
            valueInput.placeholder = 'Nhập giá trị';
            unitLabel.textContent = '';
        }
    });
                        });
                    </c:if>

                    function openEditModal(id) {
                        // This function is now replaced by location.href in the button
                        location.href = '${pageContext.request.contextPath}/admin/get-promotion?id=' + id;
                    }

                    // Close modal logic
                    document.getElementById('close-modal-btn7').addEventListener('click', function () {
                        document.getElementById('edit_information-promotion-modal').classList.remove('show');
                        // Optional: Clear URL parameter or redirect back to main list to avoid re-opening on refresh
                        location.href = '${pageContext.request.contextPath}/admin/manage-promotions';
                    });
                    document.getElementById('type').addEventListener('change', function () {
                        const type = this.value;
                        const valueInput = document.getElementById('value');
                        const unitLabel = document.getElementById('value-unit');

                        if (type === 'Phần trăm') {
                            valueInput.placeholder = 'Nhập số phần trăm (VD: 10)';
                            unitLabel.textContent = '%';
                        } else if (type === 'Số tiền cố định') {
                            valueInput.placeholder = 'Nhập số tiền (VD: 50000)';
                            unitLabel.textContent = 'đ';
                        } else {
                            valueInput.placeholder = 'Nhập giá trị';
                            unitLabel.textContent = '';
                        }
                    });

                    // Trigger once on load
                    document.getElementById('type').dispatchEvent(new Event('change'));

                    <c:if test="${not empty errorMessage}">
                        alert('${errorMessage}');
                    </c:if>
                </script>
            </body>

            </html>