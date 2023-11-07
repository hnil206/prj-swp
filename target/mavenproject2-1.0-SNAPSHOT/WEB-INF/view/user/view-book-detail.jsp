<%@include file="../include/head.jsp"%>
<%@page contentType="text/html" pageEncoding="utf-8" %>
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="form-container card card-body">
                <h1>Thông tin người giúp việc</h1>
                <form action="" method="post" enctype="multipart/form-data">
                    <div class="form-group">
                        <label for="title">Họ và tên</label>
                        <input readonly required type="text" class="form-control" name="title" id="title" value="${book.getTitle()}">
                    </div>
                    <div class="form-group">
                        <label for="description">Mô tả</label>
                        <textarea readonly class="form-control" name="description" id="description" rows="7">${book.getDescription()}</textarea>
                    </div>
                    <div class="form-group">
                        <label for="author">Quê quán</label>
                        <input readonly required type="text" class="form-control" name="author" id="author" value="${book.getAuthor()}">
                    </div>
                    <div class="form-group">
                        <label for="genre">Ngày sinh (dd/mm/yyyy)</label>

                        <input readonly required type="text" class="form-control" name="genre" id="genre" value="${book.getGenre()}">
                    </div>
                    <div class="form-group">
                        <label for="quantity">Số năm kinh nghiệm</label>
                        <input readonly required type="number" min="0" class="form-control" name="quantity" id="quantity" value="${book.getQuantity()}">
                    </div>
                    <div class="form-group">
                        <label for="available">Khả dụng</label>
                        <select readonly="" class="form-control" name="available" id="available">
                            <option ${book.isAvailable() ? "selected" : ""} value="true">có</option>
                            <option ${!book.isAvailable() ? "selected" : ""} value="false">không</option>
                        </select>
                    </div>
                </form>
            </div>
        </div>
        <div class="col-md-6">
            <div class="form-container card card-body">
                <div class="form-group">
                    <label>Hình ảnh của người giúp việc hiện tại</label>
                    <a href="${pageContext.request.contextPath}/${book.getImage()}">
                        <img src="${pageContext.request.contextPath}/${book.getImage()}" alt="" style="width: 100%">
                    </a>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <c:forEach var="feedback" items="${listFb}">
                <div class="media border p-3">
<img src="${pageContext.request.contextPath}/${feedback.getUserOfFeedback().getAvatar()}" alt="${feedback.getUserOfFeedback().getName()}" class="mr-3 mt-3 rounded-circle" style="width:60px;">
                    <div class="media-body">
                        <h4>${feedback.getUserOfFeedback().getName()} <small><i>Posted on ${feedback.getCreateAt()}</i></small></h4>
                        <p>${feedback.getMessage()}</p>
                        <h5 class="text-warning">
                            <c:forEach begin="1" end="${feedback.getStar()}" >
                                &#9733; <!-- Ký tự ngôi sao Unicode -->
                            </c:forEach>                          
                        </h5>
                    </div>
                </div>
            </c:forEach>
        </div>

    </div>
</div>
<%@include file="../include/foot.jsp"%>
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