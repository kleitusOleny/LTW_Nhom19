<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<c:choose>
    <c:when test="${not empty pendingList and pendingList.size() > 0}">
        <ion-icon name="notifications" class="icon-header active-notify" id="notification-modal-btn"></ion-icon>
    </c:when>
    <c:otherwise>
        <ion-icon name="notifications-outline" class="icon-header" id="notification-modal-btn"></ion-icon>
    </c:otherwise>
</c:choose>
