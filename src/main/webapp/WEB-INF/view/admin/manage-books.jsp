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
          <button type="button" class="btn btn-primary m-2" style="width: 250px" data-bs-toggle="modal" data-bs-target="#addBook">Thêm mới người giúp việc</button>
          <h1>Tất cả người giúp việc</h1>
          <table class="table table-bordered table-striped mt-2" id="mytable">
            <thead>
            <tr>
              <th class="col-md-1">Họ và tên</th>
              <th class="col-md-3">Mô tả</th>
              <th class="col-md-3">Hình ảnh</th>
              <th class="col-md-1">Quê quán</th>
              <th class="col-md-1">Ngày sinh</th>
              <th class="col-md-1">Kinh nghiệm</th>
              <th class="col-md-1">Khả dụng</th>
              <th class="col-md-1">Thao tác</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="item" items="${books}">
              <tr>
                <td class="col-md-1">${item.getTitle()}</td>
                <td class="col-md-3">${item.getDescription()}</td>
                <td class="col-md-3">
                  <a href="${pageContext.request.contextPath}/${item.getImage()}">
                    <img src="${pageContext.request.contextPath}/${item.getImage()}" alt="" style="max-width: 100%;max-height: 100% ;object-fit: cover;">
                  </a>
                </td>
                <td class="col-md-1">${item.getAuthor()}</td>
                <td class="col-md-1">${item.getGenre()}</td>
                <td class="col-md-1">
                  <a href="${pageContext.request.contextPath}/admin/views-borrowing-of?book_id=${item.getId()}" >
                    ${item.getQuantity()}
                    
                  </a>
                </td>
                <td class="col-md-1">${item.isAvailable() ? "có" : "không"}</td>
                <td class="col-md-1">
                  <a href="${pageContext.request.contextPath}/admin/edit-book?book_id=${item.getId()}"><button  style="width: 100%; background-color: forestgreen; color: white" >Chỉnh sửa</button></a>
                </td>
              </tr>
            </c:forEach>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>


<div class="modal fade modal" id="addBook" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <div class="col-md-12">
          <div class="form-container card card-body">
            <h1>Thêm mới người giúp việc</h1>
            <form action="" method="post" enctype="multipart/form-data">
              <div class="form-group">
                <label for="title">Tên</label>
                <input required type="text" class="form-control" name="title" id="title">
              </div>
              <div class="form-group">
                <label for="description">Mô tả</label>
                <textarea class="form-control" name="description" id="description" rows="7"></textarea>
              </div>
              <div class="form-group">
                <label for="author">Quê quán</label>
                <input required type="text" class="form-control" name="author" id="author">
              </div>
              <div class="form-group">
                <label for="genre">Ngày sinh (dd/mm/yyyy)</label>
                <input required type="date" class="form-control" name="genre" id="genre">
              </div>
              <div class="form-group">
                <label for="quantity">Số năm kinh nghiệm</label>
                <input required type="number" min="0" class="form-control" name="quantity" id="quantity">
              </div>
              <div class="form-group">
                <label for="available">Khả dụng</label>
                <select class="form-control" name="available" id="available">
                  <option value="true">có</option>
                  <option value="false">không</option>
                </select>
              </div>
              <div class="form-group">
                <label for="image">Ảnh</label>
                <input required type="file" class="form-control" name="image" id="image">
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
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
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
  const table = $('#mytable').DataTable( {
    "order": [],
  } );
</script>