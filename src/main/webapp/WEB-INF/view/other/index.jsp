<%@include file="../include/head.jsp"%> <%@page contentType="text/html"
                                                pageEncoding="utf-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <!-- Required meta tags always come first -->
        <meta charset="utf-8" />
        <meta
            name="viewport"
            content="width=device-width, initial-scale=1, shrink-to-fit=no"
            />
        <meta http-equiv="x-ua-compatible" content="ie=edge" />
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="css/Bootstrap/bootstrap.min.css" />
        <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"
            />
        <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-social/5.1.1/bootstrap-social.min.css"
            />

        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <!-- Bootstrap icons-->
        <link href="css/bootstrap/font_bootstrap-icon.css" rel="stylesheet" />
        <link href="css/bootstrap/font-awesome.min.css" rel="stylesheet" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link rel="stylesheet" href="css/mystyle.css" />
    </head>
    
        <div class="container">
            <h1>CleanHouse - 
                "Giải pháp giúp việc đơn giản, dễ dàng - để bạn tập trung vào những khoảnh khắc quý báu trong cuộc sống!"</h1>


            <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
                <c:forEach var="item" items="${books}">
                    <div class="col">
                        <div class="card shadow-sm">
                            <img src="${pageContext.request.contextPath}/${item.getImage()}" alt="" width="100%" height="200px" style="object-fit: contain">
                            <div class="card-body">
                                <p title="${item.getDescription()}" class="card-text" style="height: 150px; overflow: hidden; text-overflow: ellipsis; max-width: 100%">
                                    <span class="fw-bold">
                                        Họ và tên :
                                    </span>
                                    <span>
                                        ${item.getTitle()}
                                    </span>
                                    <br>
                                    <span class="fw-bold">
                                        Quê quán :
                                    </span>
                                    <span>
                                        ${item.getAuthor()}
                                    </span>
                                    <br>
                                    <span class="fw-bold">
                                        Ngày sinh:
                                    </span>
                                    <span>
                                        ${item.getGenre()}
                                    </span>
                                    <br>
                                    <span class="fw-bold">
                                        Mô tả :
                                    </span>
                                    <span>
                                        ${item.getDescription()}
                                    </span>
                                    <br>
                                </p>
                                <div class="d-flex justify-content-between align-items-center">
                                    <div class="btn-group mr-1">
                                        <form action="${pageContext.request.contextPath}/user/borrow-book" method="post">
                                            <input type="hidden" name="book_id" value="${item.getId()}">
                                            <button style="width: 100%;color: white" type="submit" class="btn btn-success">Đặt thuê</button>
                                        </form>
                                    </div>
                                    <div class="btn-group ml-1">
                                        <form action="${pageContext.request.contextPath}/view-book-detail?book_id=${item.getId()}">
                                            <input type="hidden" name="book_id" value="${item.getId()}">
                                            <button style="width: 100%;color: white" type="submit" class="btn btn-info ml-1">Xem chi tiết</button>
                                        </form>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>


    </body>
</html>
<%@include file="../include/foot.jsp"%>
