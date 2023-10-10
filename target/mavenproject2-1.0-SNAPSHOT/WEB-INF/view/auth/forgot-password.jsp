<%@include file="../include/head.jsp"%>
<%@page contentType="text/html" pageEncoding="utf-8" %>
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="form-container card card-body">
                <c:if test="${not empty error}">
                    <p style="color: red">${error}</p>
                </c:if>
                <c:if test="${not empty success}">
                    <p style="color: green">${success}</p>
                </c:if>
                <h2>Quên mật khẩu</h2>
                <form action="" method="post">
                    <div class="form-group">
                        <label for="email">Email</label>
                        <input class="form-control m-2" type="text" id="email" name="email" placeholder="Nhập email">
                    </div>
                    <div class="form-group">
                        <label for="tel">Số điện thoại</label>
                        <input class="form-control m-2" type="text" id="tel" name="tel" placeholder="Nhập số điện thoại">
                    </div>
                    <div class="d-grid gap-2 mt-2 mb-2">
                        <button type="submit" class="btn btn-primary">Lấy lại mật khẩu</button>
                    </div>
                    <a href="${pageContext.request.contextPath}/login">
                        <p class="text-center">Đã có tài khoản? Đăng nhập ngay.</p>
                    </a>
                </form>
            </div>
        </div>
    </div>
</div>
<%@include file="../include/foot.jsp"%>
