<%@include file="../include/head.jsp"%>
<%@page contentType="text/html" pageEncoding="utf-8" %>
<div class="container-fluid">
  <div class="row justify-content-center">
    <div class="col-md-12">
      <div class="form-container card card-body">
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
        <h1>Tất cả người dùng</h1>
        <table class="table table-bordered table-striped mt-2" id="mytable">
          <thead>
          <tr>
            <th class="col-md-1">#</th>
            <th class="col-md-1">Tên</th>
            <th class="col-md-2">Email</th>
            <th class="col-md-1">Địa chỉ</th>
            <th class="col-md-1">Số điện thoại</th>
            <th class="col-md-1">Ngày Sinh</th>
            <th class="col-md-1">Admin</th>
            <th class="col-md-2">Ảnh đại diện</th>
            <th class="col-md-2">Thao tác</th>
          </tr>
          </thead>
          <tbody>
          <c:forEach var="item" items="${users}">
            <tr>
              <td class="col-md-1">${item.getId()}</td>
              <td class="col-md-1">${item.getName()}</td>
              <td class="col-md-2">${item.getEmail()}</td>
              <td class="col-md-1">${item.getAddress()}</td>
              <td class="col-md-1">${item.getTel()}</td>
              <td class="col-md-1">${item.getBirthday()}</td>
              <td class="col-md-2">${item.isAdmin() ? "có" : "không"}</td>
              <td class="col-md-2">
                <img src="${pageContext.request.contextPath}/${item.getAvatar()}" alt="" style="max-width: 200px; max-height: 200px; object-fit: cover">
              </td>
              <td class="col-md-3">
                <a href="${pageContext.request.contextPath}/admin/update-users?user_id=${item.getId()}">
                  <button class="btn btn-success" style="width: 100%">Cập nhật</button>
                </a>
              </td>

            </tr>
          </c:forEach>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</div>
<%@include file="../include/foot.jsp"%>
