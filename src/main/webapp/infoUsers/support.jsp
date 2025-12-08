<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<link rel="stylesheet" href="../css/support_style.css">

<div class="support-card">
    <h2 data-lang-key="supportTitle">Hỗ trợ & Tư vấn Rượu Vang</h2>
    <p class="support-intro" data-lang-key="supportIntroWine">
        Bạn có câu hỏi về các dòng rượu vang, cần tư vấn chọn quà, hay muốn biết thêm về cách bảo quản? Đội ngũ chuyên
        gia của chúng tôi luôn sẵn sàng hỗ trợ.
    </p>

    <div class="support-form">
        <form>
            <div class="form-group">
                <label for="name" data-lang-key="yourName">Tên của bạn</label>
                <input type="text" id="name" name="name" required>
            </div>
            <div class="form-group">
                <label for="email" data-lang-key="yourEmail">Email của bạn</label>
                <input type="email" id="email" name="email" required>
            </div>
            <div class="form-group">
                <label for="subject" data-lang-key="subject">Chủ đề</label>
                <input type="text" id="subject" name="subject" required>
            </div>
            <div class="form-group">
                <label for="message" data-lang-key="message">Nội dung</label>
                <textarea id="message" name="message" rows="5" required></textarea>
            </div>
            <button type="submit" class="btn" data-lang-key="submit">Gửi yêu cầu</button>
        </form>
    </div>

    <div class="faq">
        <h3 data-lang-key="faq">Các câu hỏi thường gặp</h3>
        <div class="faq-item">
            <h4 data-lang-key="faq1TitleWine">Làm sao để bảo quản rượu vang đúng cách?</h4>
            <p data-lang-key="faq1AnswerWine">Rượu vang nên được bảo quản ở nơi tối, mát mẻ, nhiệt độ ổn định khoảng
                12-18°C. Đặt chai nằm ngang để nút bần luôn ẩm, tránh không khí lọt vào.</p>
        </div>
        <div class="faq-item">
            <h4 data-lang-key="faq2TitleWine">Nên chọn loại rượu nào cho bữa tiệc hải sản?</h4>
            <p data-lang-key="faq2AnswerWine">Với hải sản, vang trắng là lựa chọn tuyệt vời. Sauvignon Blanc với hương
                vị tươi mát hoặc Chardonnay không qua ủ thùng gỗ sẽ làm nổi bật vị ngon của món ăn.</p>
        </div>
        <div class="faq-item">
            <h4 data-lang-key="faq3TitleWine">Decanter rượu vang trong bao lâu là hợp lý?</h4>
            <p data-lang-key="faq3AnswerWine">Thời gian decanter phụ thuộc vào độ tuổi và loại rượu. Vang trẻ và đậm cần
                khoảng 1-2 giờ, trong khi vang cũ chỉ cần 30 phút để "thở" và loại bỏ cặn.</p>
        </div>
    </div>
</div>
