<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!-- notify.jsp -->
<ul class="header__navbar-list">
    <li class="header__navbar-item header__navbar-item--has-notify">
        <a href="" class="header__navbar-item-link"><i
                class="header__navbar-icon fa-solid fa-bell"></i>Thông báo</a>
        <div class="header__notify">
            <header class="header__notify-header">
                <h3>Thông báo mới nhận</h3>
            </header>
            <ul class="header__notify-list">             
                <c:forEach items="${sessionScope.user.notifications}" var="notify">
            <li class="header__notify-item .header__notify-item--viewed">                     
                  <a href="admin/manage-borrow-books?nid=${notify.notificationID}" class="header__notify-link" style="text-decoration: none">
                        <img src="book_img/bell.png" class="header__notify-img" />
                <div class="header__notify-info">
                    <span class="header__notify-name">${notify.title}</span>
                    <span class="header__notify-description" style="color: orange">${notify.getCreateAt()}</span>
                    <span class="header__notify-description">
                        ${notify.message}
                    </span>
                </div>
            </li>
        </c:forEach>
            </ul>
            <footer class="header__notify-footer">
                <a href="" class="header__notify-footer-btn">Xem tất cả</a>
            </footer>
        </div>
    </li>
    <!--  -->
    <!--  -->
    <li class="header__navbar-item">
        <a href="" class="header__navbar-item-link"><i
                class="header__navbar-icon fa-regular fa-circle-question"></i>Trợ giúp</a>
    </li>
    <!-- notify.jsp -->