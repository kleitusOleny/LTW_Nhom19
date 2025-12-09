<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<link rel="stylesheet" href="../css/favorites_style.css">

<div class="favorites-container">
    <h2 data-lang-key="favorites">Danh sách yêu thích</h2>
    <div class="favorites-list">
        <div class="product-card">
            <div class="product-image">
                <a href="#">
                    <img src="../img/SKU__VD_1170.png" alt="Rượu vang hồng Dufouleur Monopole">
                </a>
            </div>
            <div class="product-info">
                <h3 class="product-name"><a href="#">Rượu vang hồng Dufouleur Monopole</a></h3>
                <div class="product-extra-details">
                    <ul>
                        <li><strong>Xuất xứ:</strong> Pháp</li>
                        <li><strong>Loại:</strong> Vang Hồng</li>
                    </ul>
                </div>
                <p class="product-producer">Nhà sản xuất: Maison Dufouleur...</p>
                <div class="product-rating">
                    <i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i
                        class="fa-regular fa-star"></i><i class="fa-regular fa-star"></i>
                </div>
                <p class="product-price">351.000₫</p>
                <button class="remove-favorite-btn">Bỏ yêu thích</button>
            </div>
        </div>
        <div class="product-card">
            <div class="product-image">
                <a href="#">
                    <img src="../img/SKU__VD_1170.png" alt="Rượu vang hồng Dufouleur Monopole">
                </a>
            </div>
            <div class="product-info">
                <h3 class="product-name"><a href="#">Rượu vang hồng Dufouleur Monopole</a></h3>
                <div class="product-extra-details">
                    <ul>
                        <li><strong>Xuất xứ:</strong> Pháp</li>
                        <li><strong>Loại:</strong> Vang Hồng</li>
                    </ul>
                </div>
                <p class="product-producer">Nhà sản xuất: Maison Dufouleur...</p>
                <div class="product-rating">
                    <i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i
                        class="fa-regular fa-star"></i><i class="fa-regular fa-star"></i>
                </div>
                <p class="product-price">351.000₫</p>
                <button class="remove-favorite-btn">Bỏ yêu thích</button>
            </div>
        </div>
        <div class="product-card">
            <div class="product-image">
                <a href="#">
                    <img src="../img/SKU__VD_1170.png" alt="Rượu vang hồng Dufouleur Monopole">
                </a>
            </div>
            <div class="product-info">
                <h3 class="product-name"><a href="#">Rượu vang hồng Dufouleur Monopole</a></h3>
                <div class="product-extra-details">
                    <ul>
                        <li><strong>Xuất xứ:</strong> Pháp</li>
                        <li><strong>Loại:</strong> Vang Hồng</li>
                    </ul>
                </div>
                <p class="product-producer">Nhà sản xuất: Maison Dufouleur...</p>
                <div class="product-rating">
                    <i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i
                        class="fa-regular fa-star"></i><i class="fa-regular fa-star"></i>
                </div>
                <p class="product-price">351.000₫</p>
                <button class="remove-favorite-btn">Bỏ yêu thích</button>
            </div>
        </div>
        <div class="product-card">
            <div class="product-image">
                <a href="#">
                    <img src="../img/SKU__VD_1170.png" alt="Rượu vang hồng Dufouleur Monopole">
                </a>
            </div>
            <div class="product-info">
                <h3 class="product-name"><a href="#">Rượu vang hồng Dufouleur Monopole</a></h3>
                <div class="product-extra-details">
                    <ul>
                        <li><strong>Xuất xứ:</strong> Pháp</li>
                        <li><strong>Loại:</strong> Vang Hồng</li>
                    </ul>
                </div>
                <p class="product-producer">Nhà sản xuất: Maison Dufouleur...</p>
                <div class="product-rating">
                    <i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i
                        class="fa-regular fa-star"></i><i class="fa-regular fa-star"></i>
                </div>
                <p class="product-price">351.000₫</p>
                <button class="remove-favorite-btn">Bỏ yêu thích</button>
            </div>
        </div>
        <div class="product-card">
            <div class="product-image">
                <a href="#">
                    <img src="../img/SKU__VD_1170.png" alt="Rượu vang hồng Dufouleur Monopole">
                </a>
            </div>
            <div class="product-info">
                <h3 class="product-name"><a href="#">Rượu vang hồng Dufouleur Monopole</a></h3>
                <div class="product-extra-details">
                    <ul>
                        <li><strong>Xuất xứ:</strong> Pháp</li>
                        <li><strong>Loại:</strong> Vang Hồng</li>
                    </ul>
                </div>
                <p class="product-producer">Nhà sản xuất: Maison Dufouleur...</p>
                <div class="product-rating">
                    <i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i
                        class="fa-regular fa-star"></i><i class="fa-regular fa-star"></i>
                </div>
                <p class="product-price">351.000₫</p>
                <button class="remove-favorite-btn">Bỏ yêu thích</button>
            </div>
        </div>

    </div>
</div>
<script>
    const container = document.querySelector(".favorites-container .favorites-list");
    container.addEventListener("wheel", function (e) {
        const scrollTop = container.scrollTop;
        const scrollHeight = container.scrollHeight;
        const offsetHeight = container.offsetHeight;
        const delta = e.deltaY;

        if (
            (delta > 0 && scrollTop + offsetHeight >= scrollHeight) ||
            (delta < 0 && scrollTop <= 0)
        ) {
            e.preventDefault();
        }
    }, {passive: false});
</script>
