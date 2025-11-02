const translations = {
    en: {
        userInfo: "User Information",
        address: "Address",
        viewHistory: "View History",
        myOrders: "My Orders",
        reviewHistory: "Review History",
        settings: "Settings",
        support: "Support",
        logout: "Logout",
        userInfoPage: "This is the user information page.",
        addressPage: "This is the address management page.",
        viewHistoryPage: "This is the viewed products history page.",
        orderDetails: "Order Details",
        thankYou: "Thank you for your purchase!",
        shippingAddress: "Shipping Address",
        shippingInfo: "Shipping Information",
        orderDate: "Order Date",
        deliveryDate: "Delivery Date",
        paymentMethod: "Payment Method",
        itemReceived: "Item Received",
        buyAgain: "Buy Again",
        reviewHistoryPage: "This is the product review history page.",
        settingsPage: "This is the account settings page.",
        supportPage: "This is the customer support page.",
        language: "English",
    },
    vi: {
        userInfo: "Thông tin người dùng",
        address: "Địa chỉ",
        viewHistory: "Lịch sử đã xem",
        myOrders: "Đơn hàng của tôi",
        reviewHistory: "Lịch sử đánh giá",
        settings: "Cài đặt",
        support: "Hỗ trợ",
        logout: "Đăng xuất",
        userInfoPage: "Đây là trang thông tin người dùng.",
        addressPage: "Đây là trang quản lý địa chỉ.",
        viewHistoryPage: "Đây là trang lịch sử các sản phẩm đã xem.",
        orderDetails: "Chi tiết đơn hàng",
        thankYou: "Cảm ơn quý khách đã tham gia mua sắm!",
        shippingAddress: "Địa chỉ nhận hàng",
        shippingInfo: "Thông tin vận chuyển",
        orderDate: "Ngày tạo đơn hàng",
        deliveryDate: "Ngày giao",
        paymentMethod: "Phương thức thanh toán",
        itemReceived: "Đã nhận được hàng",
        buyAgain: "Mua lại",
        reviewHistoryPage: "Đây là trang lịch sử đánh giá sản phẩm.",
        settingsPage: "Đây là trang cài đặt tài khoản.",
        supportPage: "Đây là trang hỗ trợ khách hàng.",
        language: "VietNamese"
    }
};

function changeLanguage(lang) {
    document.querySelectorAll("[data-lang-key]").forEach(element => {
        const key = element.getAttribute("data-lang-key");
        if (translations[lang] && translations[lang][key]) {
            element.innerHTML = translations[lang][key];
        }
    })
}
