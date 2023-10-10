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
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<%@include file="../include/foot.jsp"%>
<script>
    const table = $('#mytable').DataTable( {
        "order": [],
    } );
</script>