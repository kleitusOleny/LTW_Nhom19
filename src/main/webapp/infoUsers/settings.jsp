<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<link rel="stylesheet" href="../css/setting_style.css">

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
