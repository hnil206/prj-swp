<%@include file="../include/head.jsp"%>
<%@page contentType="text/html" pageEncoding="utf-8" %>
<div class="container">
  <div class="row justify-content-center">
    <div class="col-md-6">
      <div class="form-container">
        <c:if test="${not empty error}">
          <div class="alert alert-danger">
              ${error}
          </div>
        </c:if>
        <c:if test="${not empty success}">
          <div class="alert alert-success">
              ${success}
          </div>
        </c:if>
        <c:if test="${not empty login_mess}">
          <div class="alert alert-warning">
              ${login_mess}
          </div>
        </c:if>
        <h2>Đăng nhập</h2>
        <form action="" method="post">
          <div class="form-group">
            <label for="loginEmail">Nhập email</label>
            <input type="email" name="email" class="form-control" id="loginEmail" placeholder="Email">
          </div>
          <div class="form-group">
            <label for="loginPassword">Nhập mật khẩu</label>
            <input autocomplete="off" type="password" name="password" class="form-control" id="loginPassword" placeholder="Password">
          </div>
          <div class="d-grid gap-2 mt-2 mb-2">
            <button type="submit" class="btn btn-primary " style="background-color: forestgreen; color: white">Đăng nhập</button>
          </div>
          <a href="${pageContext.request.contextPath}/forgot-password">
            <p class="text-center">Quên mật khẩu?</p>
          </a>
        </form>
      </div>
    </div>
  </div>
</div>
<%@include file="../include/foot.jsp"%>

