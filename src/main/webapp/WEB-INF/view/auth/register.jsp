<%@include file="../include/head.jsp"%>
<%@page contentType="text/html" pageEncoding="utf-8" %>


<html>
    <head>
        <title></title>
    </head>
    <body>
        <div class="container">
            <div class="row justify-content-center" >
                <div class="col-md-6">
                    <div class="form-container card card-body">
                        <c:if test="${not empty error}">
                            <p style="color: red">${error}</p>
                        </c:if>
                        <c:if test="${not empty success}">
                            <p style="color: green">${success}</p>
                        </c:if>
                        <h2>Đăng kí</h2>
                        <form action="" method="post">
                            <div class="form-group">
                                <label for="name">Tên*</label>
                                <input class="form-control m-2" type="text" id="name" name="name" placeholder="Nhập tên">
                            </div>
                            <div class="form-group">
                                <label for="email">Email*</label>
                                <input class="form-control m-2" type="text" id="email" name="email" placeholder="Nhập email">
                            </div>
                            <div class="form-group">
                                <label for="address">Địa chỉ*</label>
                                <input class="form-control m-2" type="text" id="address" name="address" placeholder="Nhập địa chỉ">
                            </div>
                            <div class="form-group">
                                <label for="tel">Số điện thoại*</label>
                                <input class="form-control m-2" type="text" id="tel" name="tel" placeholder="Nhập số điện thoại">
                            </div>
                            <div class="form-group">
                                <label for="birthday">Ngày sinh*</label>
                                <input class="form-control m-2" type="date" id="birthday" name="birthday" placeholder="Nhập tên">
                            </div>
                            <div class="form-group">
                                <label for="password">Mật khẩu*</label>
                                <input class="form-control m-2" type="password" id="password" name="password" placeholder="Nhập Mật khẩu">
                            </div>
                            <div class="form-group">
                                <label for="re_password">Nhập lại mật khẩu*</label>
                                <input class="form-control m-2" type="password" id="re_password" name="re_password" placeholder="Nhập lại mật khẩu">
                            </div>
                            <div class="d-grid gap-2 mt-2 mb-2">
                                <button type="submit" class="btn" style="background-color: forestgreen; color: white">Đăng kí</button>
                            </div>
                            <a href="${pageContext.request.contextPath}/login">
                                <p class="text-center">Đã có tài khoản? Đăng nhập ngay.</p>
                            </a>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>


<%@include file="../include/foot.jsp"%>