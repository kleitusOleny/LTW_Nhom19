<%-- notification_component.jsp --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<div class="modal-overlay-notification" id="notification-account-modal">
    <div class="modal-content-notification">
        <div class="group-notification">
            <h2 class="notification-title">Thông báo</h2>
            <button class="modal-close" id="close-modal-btn8">
                <ion-icon name="close-outline"></ion-icon>
            </button>
        </div>
        <c:choose>
            <%-- Nếu có feedback trong danh sách chờ --%>
            <c:when test="${not empty pendingList and pendingList.size() > 0}">
                <div class="notification-active-state">
                    <ion-icon name="mail-unread-outline" style="font-size: 48px; color: #ff4757;"></ion-icon>
                    <p>Bạn có <strong>${pendingList.size()}</strong> feedback mới</p>
                    <p style="font-size: 12px; color: #888;">Hãy kiểm tra "Danh sách cần làm" để xử lý.</p>
                </div>
            </c:when>
            <%-- Nếu không có feedback nào --%>
            <c:otherwise>
                <div class="notification-empty-state">
                    <ion-icon name="notifications-off-outline"></ion-icon>
                    <p>Hiện tại chưa có thông báo mới</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>