<%@include file="../include/head.jsp"%>
<%@page contentType="text/html" pageEncoding="utf-8" %>
<div class="container">
    <c:if test="${not empty success}">
        <div class="alert alert-success">
            ${success}
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger">
                ${error}
        </div>
    </c:if>
    <c:if test="${not empty warning}">
        <div class="alert alert-warning">
                ${warning}
        </div>
    </c:if>
    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-4 g-4">
        <c:forEach var="item" items="${books}">
        <div class="col">
            <div class="card shadow-sm">
                <img src="${pageContext.request.contextPath}/${item.getImage()}" alt="" width="100%" height="350px" style="object-fit: contain">
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
                            Quê Quán :
                        </span>
                        <span>
                                ${item.getAuthor()}
                        </span>
                        <br>
                        <span class="fw-bold">
                            Ngày sinh :
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
                                <button style="width: 100%;color: white" type="submit" class="btn btn-success mr-1">Đặt thuê</button>
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
<%@include file="../include/foot.jsp"%>