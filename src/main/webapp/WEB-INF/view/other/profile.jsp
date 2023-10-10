<%@include file="../include/head.jsp" %>
<%@page contentType="text/html" pageEncoding="utf-8" %>
<div class="container">
    <div class="row justify-content-center">
        <div class="row">
            <div class="col-md-6">
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
                    <h2>Chỉnh sửa thông tin cá nhân</h2>
                    <form action="" method="post">
                        <div class="form-group">
                            <label for="email">Email</label>
                            <input class="form-control" type="text" id="email" disabled value="${user.getEmail()}">
                        </div>
                        <div class="form-group mt-2">
                            <label for="tel">Số điện thoại</label>
                            <input class="form-control" type="text" id="tel" disabled value="${user.getTel()}">
                        </div>
                        <div class="form-group mt-2">
                            <label for="name">Tên</label>
                            <input class="form-control" type="text" id="name" name="name" value="${user.getName()}">
                        </div>
                        <div class="form-group mt-2">
                            <label for="current_password">Mật khẩu hiện tại</label>
                            <input autocomplete="off" type="password" class="form-control" id="current_password" name="current_password"
                                   placeholder="Mật khẩu hiện tại">
                        </div>
                        <div class="form-group mt-2">
                            <label for="new_password">Mật khẩu mới</label>
                            <input type="password" class="form-control" id="new_password" name="new_password"
                                   placeholder="Mật khẩu mới">
                        </div>
                        <div class="form-group mt-2">
                            <label for="re_password">Nhập lại mật khẩu mới</label>
                            <input type="password" class="form-control" id="re_password" name="re_password"
                                   placeholder="Nhập lại mật khẩu mới">
                        </div>
                        <div class="d-grid gap-2 mt-2 mb-2">
                            <button type="submit" class="btn btn-primary">Cập nhật</button>
                        </div>
                    </form>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-container card card-body">
                    <form action="${pageContext.request.contextPath}/user/update-avatar" method="post"
                          enctype="multipart/form-data">
                        <div class="form-group">
                            <label for="image">Ảnh đại diện</label>
                            <input required type="file" class="form-control" name="image" id="image">
                        </div>
                        <div class="preview-container">
                            <h5>Preview:</h5>
                            <img style="width: 100%;" id="previewImage" class="img-fluid">
                        </div>
                        <div class="d-grid gap-2 mt-2 mb-2">
                            <button type="submit" class="btn btn-primary">Cập nhật</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<%@include file="../include/foot.jsp" %>
<script>
    document.getElementById('image').addEventListener('change', function (e) {
        var file = e.target.files[0];
        var reader = new FileReader();

        reader.onload = function (e) {
            document.getElementById('previewImage').setAttribute('src', e.target.result);
        }

        reader.readAsDataURL(file);
    });
</script>