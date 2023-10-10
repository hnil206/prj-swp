<%@include file="../include/head.jsp"%>
<%@page contentType="text/html" pageEncoding="utf-8" %>
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="form-container card card-body">
                <h1>Cập nhật thông tin người giúp việc</h1>
                <form action="" method="post" enctype="multipart/form-data">
                    <div class="form-group">
                        <label for="title">Họ và tên</label>
                        <input required type="text" class="form-control" name="title" id="title" value="${book.getTitle()}">
                    </div>
                    <div class="form-group">
                        <label for="description">Mô tả</label>
                        <textarea class="form-control" name="description" id="description" rows="7">${book.getDescription()}</textarea>
                    </div>
                    <div class="form-group">
                        <label for="author">Quê quán</label>
                        <input required type="text" class="form-control" name="author" id="author" value="${book.getAuthor()}">
                    </div>
                    <div class="form-group">
                        <label for="genre">Ngày sinh (dd/mm/yyyy)</label>
                        <input required type="text" class="form-control" name="genre" id="genre" value="${book.getGenre()}">
                    </div>
                    <div class="form-group">
                        <label for="quantity">Số năm kinh nghiệm</label>
                        <input required type="number" min="0" class="form-control" name="quantity" id="quantity" value="${book.getQuantity()}">
                    </div>
                    <div class="form-group">
                        <label for="available">Khả dụng</label>
                        <select class="form-control" name="available" id="available">
                            <option ${book.isAvailable() ? "selected" : ""} value="true">có</option>
                            <option ${!book.isAvailable() ? "selected" : ""} value="false">không</option>
                        </select>
                    </div>
                    <input type="hidden" name="current_image" value="${book.getImage()}">
                    <div class="form-group">
                        <label for="image">Ảnh</label>
                        <input type="file" class="form-control" name="image" id="image">
                    </div>
                    <div class="preview-container">
                        <h5>Preview:</h5>
                        <img style="width: 100%;" id="previewImage" class="img-fluid">
                    </div>
                    <div class="d-grid gap-2 mt-2 mb-2">
                        <button type="submit" class="btn btn-primary">Tạo mới</button>
                    </div>
                </form>
            </div>
        </div>
        <div class="col-md-6">
            <div class="form-container card card-body">
                <div class="form-group">
                    <label><h1 style="color: red">Hình ảnh của người giúp việc</h1></label>
                    <a href="${pageContext.request.contextPath}/${book.getImage()}">
                        <img src="${pageContext.request.contextPath}/${book.getImage()}" alt="" style="width: 100%">
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>
<%@include file="../include/foot.jsp"%>
<script>
    document.getElementById('image').addEventListener('change', function(e) {
        var file = e.target.files[0];
        var reader = new FileReader();

        reader.onload = function(e) {
            document.getElementById('previewImage').setAttribute('src', e.target.result);
        }
        reader.readAsDataURL(file);
    });
</script>