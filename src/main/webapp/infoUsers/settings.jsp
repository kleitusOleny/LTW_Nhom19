<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<style>
    @import url('https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap');

    .settings-container {
        font-family: 'Roboto', sans-serif;
        background: #fff;
        border-radius: 8px;
        padding: 30px;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
        border: 1px solid #eee;
    }

    .settings-container h2 {
        margin-bottom: 25px;
        font-size: 26px;
        color: #8c3333;
        font-family: Roboto, serif;
        border-bottom: 1px solid #eee;
        padding-bottom: 15px;
    }

    .setting-section {
        margin-bottom: 35px;
        border-bottom: 1px solid #f5f5f5;
        padding-bottom: 25px;
    }

    .setting-section:last-child {
        border-bottom: none;
        margin-bottom: 0;
        padding-bottom: 10px;
    }

    .setting-section h3 {
        font-size: 20px;
        color: #333;
        margin-bottom: 20px;
        font-weight: 700;
    }

    .setting-option {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 12px 0;
        border-bottom: 1px solid #f9f9f9;
    }

    .setting-option:last-child {
        border-bottom: none;
    }

    .setting-option label {
        font-size: 16px;
        color: #555;
    }

    .setting-option .description {
        font-size: 14px;
        color: #777;
    }

    .btn-link {
        color: #8c3333;
        cursor: pointer;
        font-weight: 700;
        text-decoration: none;
    }

    .btn-link:hover {
        text-decoration: underline;
    }

    .toggle-switch {
        position: relative;
        display: inline-block;
        width: 50px;
        height: 28px;
    }

    .toggle-switch input {
        opacity: 0;
        width: 0;
        height: 0;
    }

    .slider {
        position: absolute;
        cursor: pointer;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background-color: #ccc;
        transition: .4s;
        border-radius: 28px;
    }

    .slider:before {
        position: absolute;
        content: "";
        height: 20px;
        width: 20px;
        left: 4px;
        bottom: 4px;
        background-color: white;
        transition: .4s;
        border-radius: 50%;
    }

    input:checked + .slider {
        background-color: #8c3333;
    }

    input:checked + .slider:before {
        transform: translateX(22px);
    }

    .styled-select {
        padding: 8px 12px;
        border-radius: 5px;
        border: 1px solid #ccc;
        font-size: 16px;
        background-color: #fff;
    }
</style>

<div class="settings-container">
    <h2 data-lang-key="settings">Cài đặt</h2>
    <div class="setting-section">
        <h3><i class="fa-solid fa-bell"></i> Thông báo</h3>
        <div class="setting-option">
            <div>
                <label for="promo-notifications">Ưu đãi & khuyến mãi</label>
                <div class="description">Nhận thông tin về các chương trình giảm giá và sản phẩm đặc biệt.</div>
            </div>
            <div class="toggle-switch">
                <input type="checkbox" id="promo-notifications" checked>
                <span class="slider"></span>
            </div>
        </div>
        <div class="setting-option">
            <div>
                <label for="order-notifications">Trạng thái đơn hàng</label>
                <div class="description">Cập nhật về quá trình xử lý và giao hàng.</div>
            </div>
            <div class="toggle-switch">
                <input type="checkbox" id="order-notifications" checked>
                <span class="slider"></span>
            </div>
        </div>
        <div class="setting-option">
            <div>
                <label for="news-notifications">Tin tức rượu vang mới</label>
                <div class="description">Khám phá các sản phẩm mới và tin tức từ chuyên gia.</div>
            </div>
            <div class="toggle-switch">
                <input type="checkbox" id="news-notifications">
                <span class="slider"></span>
            </div>
        </div>
    </div>

    <div class="setting-section">
        <h3><i class="fa-solid fa-credit-card"></i> Phương thức thanh toán</h3>
        <div class="setting-option">
            <label>Quản lý thanh toán</label>
            <a href="#" class="btn-link">Quản lý</a>
        </div>
    </div>

    <div class="setting-section">
        <h3><i class="fa-solid fa-lock"></i> Bảo mật & quyền riêng tư</h3>
        <div class="setting-option">
            <label>Xác thực 2 bước (2FA)</label>
            <span class="btn-link">Kích hoạt</span>
        </div>
        <div class="setting-option">
            <label>Quản lý phiên đăng nhập</label>
            <a href="#" class="btn-link">Xem</a>
        </div>
        <div class="setting-option">
            <label>Xóa tài khoản</label>
            <a href="#" class="btn-link" style="color: #dc3545;">Yêu cầu</a>
        </div>
    </div>

    <div class="setting-section">
        <h3><i class="fa-solid fa-palette"></i> Giao diện & trải nghiệm</h3>
        <div class="setting-option">
            <label>Chế độ tối (Dark mode)</label>
            <div class="toggle-switch">
                <input type="checkbox" id="dark-mode">
                <span class="slider"></span>
            </div>
        </div>
        <div class="setting-option">
            <label for="language-select">Ngôn ngữ</label>
            <select id="language-select" class="styled-select">
                <option value="vi">Tiếng Việt</option>
                <option value="en">English</option>
            </select>
        </div>
        <div class="setting-option">
            <label for="currency-select">Đơn vị tiền tệ</label>
            <select id="currency-select" class="styled-select">
                <option value="vnd">VNĐ</option>
                <option value="usd">USD</option>
            </select>
        </div>
    </div>
</div>
