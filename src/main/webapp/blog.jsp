<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="vi">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Blog Rượu Vang & Đồ Uống Cao Cấp</title>
    <link rel="stylesheet" href="css/blog_style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"
          integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>

</head>
<body>
<%@include file="components/header.jsp"%>
<div class="container">
    <div class="toolbar">
        <div class="search">
            <input id="q" type="search" placeholder="Tìm bài viết... (tiêu đề, thẻ, mô tả)">
        </div>
        <div class="filters" id="filters">
            <button class="chip active" data-filter="all">Tất cả</button>
            <button class="chip" data-filter="news">Tin tức</button>
            <button class="chip" data-filter="guide">Hướng dẫn</button>
            <button class="chip" data-filter="review">Đánh giá</button>
            <button class="chip" data-filter="pairing">Pairing</button>
        </div>
    </div>

    <section class="featured">
        <article class="card" data-category="news" data-tags="xu-huong,vang" data-title="Xu hướng rượu vang 2025">
            <div class="media" style="background-image:url('img/ruou.jpg')" aria-hidden="true"></div>
            <div class="body">
                <div class="meta">Dec 12, 2025 · Tin tức</div>
                <h2 class="title">Xu hướng rượu vang 2025: nhẹ, tươi và terroir</h2>
                <p class="excerpt">Năm 2025 đánh dấu sự lên ngôi của rượu vang nhẹ và chú trọng terroir — những chai dễ
                    uống, thích hợp pairing với ẩm thực hàng ngày.</p>
                <div class="tags"><span class="tag">xu-huong</span><span class="tag">vang</span></div>
            </div>
        </article>
    </section>

    <section style="margin-top:18px">
        <div class="grid" id="posts">
            <article class="card" data-category="review" data-tags="cabernet,review"
                     data-title="Đánh giá Cabernet Sauvignon Chile 2018">
                <div class="media" style="background-image:url('img/ruou2.jpg')"></div>
                <div class="body">
                    <div class="meta">Nov 10, 2025 · Đánh giá</div>
                    <h3 class="title">Đánh giá Cabernet Sauvignon Chile 2018</h3>
                    <p class="excerpt">Mạnh mẽ, tannin mịn, phù hợp với thịt đỏ nướng. Điểm: 88/100.</p>
                    <div class="tags"><span class="tag">cabernet</span><span class="tag">review</span></div>
                    <a class="readmore" href="blog_detail.jsp">Đọc tiếp</a>
                </div>
            </article>

            <article class="card" data-category="guide" data-tags="mua-hang,huong-dan"
                     data-title="Cách chọn vang cho người mới">
                <div class="media" style="background-image:url('img/ruou.jpg')"></div>
                <div class="body">
                    <div class="meta">Oct 05, 2025 · Hướng dẫn</div>
                    <h3 class="title">Cách chọn vang cho người mới</h3>
                    <p class="excerpt">Bạn mới tập uống vang? Hướng dẫn chọn vang theo phong cách: ngọt, khô, nhẹ,
                        đậm.</p>
                    <div class="tags"><span class="tag">mua-hang</span><span class="tag">huong-dan</span></div>
                    <a class="readmore" href="blog_detail.jsp">Đọc tiếp</a>
                </div>
            </article>

            <article class="card" data-category="pairing" data-tags="cheese,pairing"
                     data-title="Pairing vang với phô mai Pháp">
                <div class="media" style="background-image:url('img/ruou2.jpg')"></div>
                <div class="body">
                    <div class="meta">Sep 12, 2025 · Pairing</div>
                    <h3 class="title">Pairing vang với phô mai Pháp</h3>
                    <p class="excerpt">Các loại phô mai mềm phù hợp với Pinot Noir, phô mai cứng hợp với Cabernet.</p>
                    <div class="tags"><span class="tag">cheese</span><span class="tag">pairing</span></div>
                    <a class="readmore" href="blog_detail.jsp">Đọc tiếp</a>
                </div>
            </article>

            <article class="card" data-category="news" data-tags="su-kien,shop"
                     data-title="Mở cửa hàng rượu mới tại Hà Nội">
                <div class="media" style="background-image:url('img/ruou.jpg')"></div>
                <div class="body">
                    <div class="meta">Aug 20, 2025 · Tin tức</div>
                    <h3 class="title">Mở cửa hàng rượu mới tại Hà Nội</h3>
                    <p class="excerpt">Cửa hàng flagship của chúng tôi khai trương với bộ sưu tập vang nhập khẩu đặc
                        sắc.</p>
                    <div class="tags"><span class="tag">su-kien</span><span class="tag">shop</span></div>
                    <a class="readmore" href="blog_detail.jsp">Đọc tiếp</a>
                </div>
            </article>

        </div>
    </section>
</div>
<%@include file="components/footer.jsp"%>>
<script>
    (function () {
        const q = document.getElementById('q');
        const chips = Array.from(document.querySelectorAll('.chip'));
        const posts = Array.from(document.querySelectorAll('#posts > article'));
        const yearEl = document.getElementById('year');
        yearEl.textContent = new Date().getFullYear();

        function normalize(s) {
            return (s || '').toString().toLowerCase();
        }

        function applyFilter() {
            const term = normalize(q.value);
            const active = chips.find(c => c.classList.contains('active'))?.dataset.filter || 'all';

            posts.forEach(post => {
                const title = normalize(post.dataset.title);
                const category = normalize(post.dataset.category);
                const tags = normalize(post.dataset.tags);

                const matchCategory = (active === 'all') || (category === active);
                const matchTerm = !term || title.includes(term) || tags.includes(term) || post.querySelector('.excerpt').textContent.toLowerCase().includes(term);

                post.style.display = (matchCategory && matchTerm) ? '' : 'none';
            });
        }

        q.addEventListener('input', applyFilter);

        chips.forEach(c => c.addEventListener('click', () => {
            chips.forEach(x => x.classList.remove('active'));
            c.classList.add('active');
            applyFilter();
        }));

        q.addEventListener('keydown', e => {
            if (e.key === 'Enter') {
                const first = posts.find(p => p.style.display !== 'none');
                if (first) first.querySelector('.readmore').focus();
            }
        });

        applyFilter();
    })();
</script>
</body>
</html>
