<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<footer class="site-footer">
  <div class="container">
    <div class="footer-grid">
      <div class="footer-column">
        <h4 class="footer-heading">Về Chúng Tôi</h4>
        <p class="footer-text">
          Mô tả ngắn gọn về dự án của bạn.
          Nội dung này giúp người dùng hiểu rõ hơn về mục đích của bạn.
        </p>
        <div class="footer-socials">
          <a href="#" class="social-link" aria-label="Facebook">
            <i class="fa-brands fa-facebook-f"></i>
          </a>
          <a href="#" class="social-link" aria-label="Instagram">
            <i class="fa-brands fa-instagram"></i>
          </a>
          <a href="#" class="social-link" aria-label="Twitter">
            <i class="fa-brands fa-x-twitter"></i>
          </a>
        </div>
      </div>

      <div class="footer-column">
        <h4 class="footer-heading">Liên Kết Nhanh</h4>
        <ul class="footer-links">
          <li><a href="">Trang chủ</a></li>
          <li><a href="">Giới thiệu</a></li>
          <li><a href="">Dịch vụ</a></li>
          <li><a href="">Liên hệ</a></li>
          <li><a href="">Chính sách</a></li>
        </ul>
      </div>

      <div class="footer-column">
        <h4 class="footer-heading">Liên Hệ</h4>
        <ul class="footer-contact">
          <li><strong>Địa chỉ:</strong> Khu Phố 6, P. Linh Trung, Q. Thủ Đức, TP.HCM</li>
          <li><strong>Email:</strong> Olenydev@gmail.com</li>
          <li><strong>Điện thoại:</strong> (+84) 1234 5678</li>
        </ul>
      </div>

    </div>
    <div class="footer-bottom">
      <p>&copy; 2025 Khoa Công Nghệ Thông Tin.</p>
    </div>

  </div>
</footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
<script>
  document.addEventListener("DOMContentLoaded", function () {
    const wishlistBtns = document.querySelectorAll('.wishlist-btn');

    wishlistBtns.forEach(btn => {
      btn.addEventListener('click', function (e) {
        e.preventDefault(); // Ngăn chặn click vào thẻ a bao quanh (nếu có)

        // Toggle class active
        this.classList.toggle('active');

        // Đổi icon từ rỗng (fa-regular) sang đặc (fa-solid) và ngược lại
        const icon = this.querySelector('i');
        if (this.classList.contains('active')) {
          icon.classList.remove('fa-regular');
          icon.classList.add('fa-solid');
        } else {
          icon.classList.remove('fa-solid');
          icon.classList.add('fa-regular');
        }
      });
    });
  });
</script>
</body>
</html>