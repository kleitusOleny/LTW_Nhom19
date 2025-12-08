<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<link rel="stylesheet" href="../css/address_style.css">
<div id="address-card">
    <h2 data-lang-key="address">Địa chỉ của tôi</h2>

    <div class="address-list">
        <div class="address-card">
            <div class="address-card-details">
                <p class="name">Nguyễn Văn A <span class="default-badge">Mặc định</span></p>
                <p class="phone">(+84) 987 654 321</p>
                <p class="address">123 Đường ABC, Phường XYZ, Quận 1, Thành phố Hồ Chí Minh</p>
            </div>
            <div class="address-card-actions">
                <button class="btn set-default-btn">Đặt làm mặc định</button>
                <button class="btn edit-btn"><i class="fa-solid fa-pen-to-square"></i></button>
                <button class="btn delete-btn"><i class="fa-solid fa-trash"></i></button>
            </div>
        </div>
    </div>

    <button class="add-address-btn" id="addAddressBtn"><i class="fa-solid fa-plus"></i> Thêm địa chỉ mới</button>
</div>

<div id="addressModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3 data-lang-key="newAddress">Địa chỉ mới</h3>
            <span class="close-btn">&times;</span>
        </div>
        <form id="addressForm">
            <div class="form-group">
                <label for="fullName" data-lang-key="fullName">Họ và tên</label>
                <input type="text" id="fullName" name="fullName" required>
            </div>
            <div class="form-group">
                <label for="phone" data-lang-key="phone">Số điện thoại</label>
                <input type="tel" id="phone" name="phone" required>
            </div>
            <div class="form-group">
                <label for="city" data-lang-key="city">Tỉnh/Thành phố</label>
                <select id="city" name="city" required>
                    <option value="">Chọn Tỉnh/TP</option>
                </select>
            </div>
            <div class="form-group">
                <label for="ward" data-lang-key="ward">Phường/Xã</label>
                <select id="ward" name="ward" required>
                    <option value="">Chọn Phường/Xã</option>
                </select>
            </div>
            <div class="form-group">
                <label for="addressDetail" data-lang-key="addressDetail">Địa chỉ chi tiết</label>
                <input type="text" id="addressDetail" name="addressDetail" required>
            </div>
            <div class="modal-footer">
                <button type="submit" class="add-address-btn" data-lang-key="save">Lưu</button>
            </div>
        </form>
    </div>
</div>


<script>
    (function () {
        const modal = document.getElementById('addressModal');
        if (!modal || modal.dataset.initialized) return;
        modal.dataset.initialized = true;

        const addAddressBtn = document.getElementById('addAddressBtn');
        const closeModalBtn = document.getElementsByClassName('close-btn')[0];
        const addressForm = document.getElementById('addressForm');
        const addressList = document.querySelector('.address-list');
        const modalTitle = modal.querySelector('.modal-header h3');
        let editingCard = null;

        const openModal = () => modal.style.display = 'block';
        const closeModal = () => {
            modal.style.display = 'none';
            addressForm.reset();
            editingCard = null;
            modalTitle.textContent = 'Địa chỉ mới';
        };

        addAddressBtn.onclick = openModal;
        closeModalBtn.onclick = closeModal;
        window.onclick = (event) => {
            if (event.target == modal) {
                closeModal();
            }
        };

        function refreshCardClickEvents() {
            const cards = document.querySelectorAll(".address-card");

            cards.forEach(card => {
                card.addEventListener("click", function (event) {
                    if (event.target.closest("button")) return;

                    cards.forEach(c => c.classList.remove("selected"));

                    card.classList.add("selected");
                });
            });
        }

        refreshCardClickEvents();

        addressForm.addEventListener('submit', function (e) {
            e.preventDefault();
            const name = this.elements.fullName.value;
            const phone = this.elements.phone.value;
            const address = this.elements.addressDetail.value;


            if (editingCard) {
                editingCard.querySelector('.name').textContent = name;
                editingCard.querySelector('.phone').textContent = phone;
                editingCard.querySelector('.address').textContent = address;
                alert("Chỉnh sửa thành công")
            } else {
                alert("tạo thành công")
            }

            closeModal();
        });

        addressList.addEventListener('click', function (e) {
            const target = e.target.closest('button');
            if (!target) return;

            const card = target.closest('.address-card');

            if (target.classList.contains('delete-btn')) {
                if (confirm('Bạn có chắc chắn muốn xóa địa chỉ này?')) {
                    alert("xóa thành công");
                }
            }

            if (target.classList.contains('edit-btn')) {
                editingCard = card;
                const name = card.querySelector('.name').textContent.replace(/ <span.*<\/span>/, '');
                const phone = card.querySelector('.phone').textContent;
                const address = card.querySelector('.address').textContent;

                addressForm.elements.fullName.value = name;
                addressForm.elements.phone.value = phone;
                addressForm.elements.addressDetail.value = address;

                modalTitle.textContent = 'Chỉnh sửa địa chỉ';
                openModal();
            }

        });

    })();
</script>
