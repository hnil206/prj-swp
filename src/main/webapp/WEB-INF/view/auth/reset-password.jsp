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
        <h2>Lấy lại mật khẩu</h2>
        <form action="" method="post">
          <div class="form-group">
            <label for="password">Nhập mật khẩu</label>
            <input class="form-control m-2" type="password" id="password" name="password" placeholder="Nhập mật khẩu">
          </div>
          <div class="form-group">
            <label for="re_password">Nhập lại mật khẩu</label>
            <input class="form-control m-2" type="password" id="re_password" name="re_password" placeholder="Nhập lại mật khẩu">
          </div>
          <div class="d-grid gap-2 mt-2 mb-2">
            <button type="submit" class="btn btn-primary">Đặt mật khẩu</button>
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
