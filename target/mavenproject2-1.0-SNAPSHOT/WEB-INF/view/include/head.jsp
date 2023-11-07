<%@ page import="Model.User" %>
<%@page contentType="text/html" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.css"/>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        
        <script type="text/javascript">

            function insert(id) {
                const myElement = document.getElementById("bookid");
                myElement.value = id;
            }

        </script>

    </head>
    <% User user = (User) session.getAttribute("user");%>
    <header class="p-3 mb-3 border-bottom" style="background-color: #2b542c">
        <div class="container">
            <div class="d-flex  align-items-center justify-content-center justify-content-lg-start">
                <a href="/" class="d-flex align-items-center mb-2 mb-lg-0 text-dark text-decoration-none">
                    <svg class="bi me-2" width="40" height="32" role="img" aria-label="Bootstrap"><use xlink:href="#bootstrap"></use></svg>
                </a>

                <ul class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0" ">
                    <li><a  href="${pageContext.request.contextPath}" class="nav-link px-2 link-<%=request.getRequestURI().endsWith("index.jsp") ? "danger" : "primary"%>" style=" color: white;
                            text-shadow: 1px 1px 2px black, 0 0 25px blue, 0 0 5px darkblue;">Trang chủ</a></li>
                        <% if (user != null && user.isAdmin()) {%>
                    <li><a href="${pageContext.request.contextPath}/admin/manage-books" class="nav-link px-2 link-<%=request.getRequestURI().endsWith("manage-books.jsp") ? "danger" : "primary"%>" style=" color: white;
                           text-shadow: 1px 1px 2px black, 0 0 25px blue, 0 0 5px darkblue;">Quản lý Housekeeper</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/manage-borrow-books" class="nav-link px-2 link-<%=request.getRequestURI().endsWith("manage-borrows.jsp") ? "danger" : "primary"%>" style=" color: white;
                           text-shadow: 1px 1px 2px black, 0 0 25px blue, 0 0 5px darkblue;">Duyệt đơn</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/manage-users" class="nav-link px-2 link-<%=request.getRequestURI().endsWith("manage-users.jsp") || request.getRequestURI().endsWith("update-user.jsp") ? "danger" : "primary"%>" style=" color: white;
                           text-shadow: 1px 1px 2px black, 0 0 25px blue, 0 0 5px darkblue;">Quản lý người dùng</a></li>
                        <% } %>
                        <% if (user != null) {%>
                    <li><a href="${pageContext.request.contextPath}/user/your-borrows" class="nav-link px-2 link-<%=request.getRequestURI().endsWith("your-borrow.jsp") ? "danger" : "primary"%>" style=" color: white;
                           text-shadow: 1px 1px 2px black, 0 0 25px blue, 0 0 5px darkblue;">Đơn book</a></li>
                        <% }%>
                    <li><a href="${pageContext.request.contextPath}/view-all-books" class="nav-link px-2 link-<%=request.getRequestURI().endsWith("search-books.jsp") ? "danger" : "primary"%>" style=" color: white;
                           text-shadow: 1px 1px 2px black, 0 0 25px blue, 0 0 5px darkblue;">Danh sách</a></li>
                    <li><a href="${pageContext.request.contextPath}/NotificationServlet" class="nav-link px-2 link-<%=request.getRequestURI().endsWith("notify.jsp") ? "danger" : "primary"%>" style=" color: white;
                           text-shadow: 1px 1px 2px black, 0 0 25px blue, 0 0 5px darkblue;">Thông báo</a>
                        <header class="header__notify-header">
                        </header>
                        <ul class="header__notify-list">             
                            <c:forEach items="${sessionScope.user.notifications}" var="notify">
                                <li class="header__notify-item .header__notify-item--viewed">                     
                                    <a href="notifyservlet?nid=${notify.notificationID}" class="header__notify-link" style="text-decoration: none">
                                        <img src="book_img/bell.png" class="header__notify-img" />
                                    </a>
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
                    </li>
                </ul>
                <% if (user == null) {%>
                <div class="col-md-3 text-end">
                    <a href="${pageContext.request.contextPath}/login">
                        <button type="button" class="btn btn-outline-primary me-2" style=" color: white;
                                text-shadow: 1px 1px 2px black, 0 0 25px blue, 0 0 5px darkblue;">Login</button>
                    </a>
                    <a href="${pageContext.request.contextPath}/register">
                        <button type="button" class="btn btn-outline-primary" style=" color: white;
                                text-shadow: 1px 1px 2px black, 0 0 25px blue, 0 0 5px darkblue;">Sign-up</button>
                    </a>
                </div>
                <% } else {%>
                <% if (user.isAdmin()) {%>
                <div class="row col-4 text-end">
                    <div class="col-md-10" style="color: white;
                         text-shadow: 1px 1px 2px black, 0 0 25px blue, 0 0 5px darkblue">
                        <p class="text-end">Admin <%=user.name%></p>
                    </div>
                    <div class="col-md-2">
                        <div class="dropdown text-start">
                            <a href="#" class="d-block link-primary text-decoration-none dropdown-toggle" id="dropdownUser1" data-bs-toggle="dropdown" aria-expanded="false">
                                <img src="${pageContext.request.contextPath}/<%=user.avatar%>" alt="mdo" width="32" height="32" class="rounded-circle">
                            </a>
                            <ul class="dropdown-menu text-small" aria-labelledby="dropdownUser1" style="">
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/profile">Profile</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout">Logout</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <% } else {%>
                <div class="row col-4 text-end">
                    <div class="col-md-10">
                        <p class="text-end" style="color: white;
                           text-shadow: 1px 1px 2px black, 0 0 25px blue, 0 0 5px darkblue">Hello <%=user.name%></p>
                    </div>
                    <div class="col-md-2">
                        <div class="dropdown text-start">
                            <a href="#" class="d-block link-primary text-decoration-none dropdown-toggle" id="dropdownUser2" data-bs-toggle="dropdown" aria-expanded="false">
                                <img src="${pageContext.request.contextPath}/<%=user.avatar%>" alt="mdo" width="32" height="32" class="rounded-circle">
                            </a>
                            <ul class="dropdown-menu text-small" aria-labelledby="dropdownUser2" style="">
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/profile">Profile</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout">Log out</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <% } %>
                <% }%>

            </div>
        </div>
    </header>
    <body>