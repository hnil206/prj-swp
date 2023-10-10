<%@include file="../include/head.jsp"%>
<%@page contentType="text/html" pageEncoding="utf-8" %>
<div class="container-fluid">
  <div class="row justify-content-center">
    <div class="col-md-6">
      <div class="form-container card card-body">
        <h1>Cập nhật người dùng</h1>
        <form action="" method="post">
          <input type="hidden" name="id" value="${user1.getId()}">
          <div class="form-group">
            <label for="name">Tên</label>
            <input class="form-control m-2" type="text" id="name" name="name" value="${user1.getName()}">
          </div>
          <div class="form-group">
            <label for="email">Email</label>
            <input class="form-control m-2" type="text" id="email" name="email" value="${user1.getEmail()}">
          </div>
          <div class="form-group">
            <label for="address">Địa chỉ</label>
            <input class="form-control m-2" type="text" id="address" name="address" value="${user1.getAddress()}">
          </div>
          <div class="form-group">
            <label for="tel">Số điện thoại</label>
            <input class="form-control m-2" type="text" id="tel" name="tel" value="${user1.getTel()}">
          </div>
          <div class="form-group">
            <label for="birthday">Ngày sinh</label>
            <input class="form-control m-2" type="date" id="birthday" name="birthday" value="${user1.getBirthday()}">
          </div>
          <div class="form-group">
            <label for="password">Mật khẩu</label>
            <input class="form-control m-2" type="password" id="password" name="password" >
          </div>
          <div class="form-group">
            <label for="admin">Admin</label>
            <select class="form-control m-2" name="admin" id="admin">
              <option value="true" ${user1.isAdmin() ? "selected" : ""}>có</option>
              <option value="false" ${!user1.isAdmin() ? "selected" : ""}>không</option>
            </select>
          </div>
          <button style="width: 100%; color: white" class="btn-success btn mt-2">Cập nhật</button>
        </form>
      </div>
    </div>
    <div class="col-md-6">
      <img src="${pageContext.request.contextPath}/${user1.getAvatar()}" alt="">
    </div>
  </div>
</div>
<%@include file="../include/foot.jsp"%>
