<%@include file="../include/head.jsp"%>
<%@page contentType="text/html" pageEncoding="utf-8" %>
<div class="container-fluid">
    <div class="row justify-content-center">
        <div class="col-md-12">
            <div class="form-container card card-body">
                <h1>Tất cả đơn thuê</h1>
                <table class="table table-bordered table-striped mt-2" id="mytable">
                    <thead>
                        <tr>
                            <th>STT</th>
                            <th>Tên người giúp việc</th>
                            <th>Trạng thái</th>
                            <th>Ngày làm đơn</th>
                            <th>Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="item" items="${borrows}">
                            <tr>
                                <td>${item.getId()}</td>
                                <td>
                                    ${item.getBook_name()}
                                </td>
                                <td>${item.getStatus() == 0 ? "<p class='text-info'>Chờ xác nhận</p>" : (item.getStatus() == 1 ? "<p class='text-success'>Đã xác nhận</p>" : "<p class='text-danger'>Đã Huỷ</p>")}</td>
                                <td>${item.getCreated_at()}</td>
                                <td><button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#feedbackModal">
                                        Đánh giá
                                    </button>
                                </td>
                            </tr>
                            <!-- Modal Feedback -->
                        <div class="modal fade" id="feedbackModal" tabindex="-1" role="dialog" aria-labelledby="feedbackModalLabel" aria-hidden="true">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="feedbackModalLabel">Đánh giá</h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                                    <form method="post" action="${pageContext.request.contextPath}/feedbacks">
                                        <div class="modal-body">
                                            <div class="form-group">
                                                <label for="starRating">Star Rating:</label>
                                                <select class="form-control text-warning" id="starRating" required name="starRating">
                                                    <option value="1" class="text-warning">&#9733;</option> <!-- Hình ngôi sao Unicode -->
                                                    <option value="2" class="text-warning">&#9733;&#9733;</option> <!-- Hai hình ngôi sao -->
                                                    <option value="3" class="text-warning">&#9733;&#9733;&#9733;</option> <!-- Ba hình ngôi sao -->
                                                    <option value="4" class="text-warning">&#9733;&#9733;&#9733;&#9733;</option> <!-- Bốn hình ngôi sao -->
                                                    <option value="5" class="text-warning">&#9733;&#9733;&#9733;&#9733;&#9733;</option> <!-- Năm hình ngôi sao -->
                                                </select>
                                            </div>
                                            <div class="form-group">
                                                <label for="message">Feedback Message:</label>
                                                <textarea class="form-control" id="message" name="message" required rows="4"></textarea>
                                            </div>
                                            <input type="hidden" name="hkId" value="${item.getBook_id()}">
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
                                            <button type="submit" class="btn btn-primary">Gửi Feedback</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>

                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<%@include file="../include/foot.jsp"%>
<script>
    const table = $('#mytable').DataTable({
        "order": []
    });
</script>