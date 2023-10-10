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
                <c:if test="${not empty warning}">
                    <div class="alert alert-warning">
                            ${warning}
                    </div>
                </c:if>
                <h1>Tất đơn mượn sách</h1>
                <table ${pageContext.request.getParameter("borrow_id") != null ? "hidden" : ""} class="table table-bordered table-striped mt-2" id="mytable">
                    <thead>
                    <tr>
                        <th>STT</th>
                        <th>Tên người thuê</th>
                        <th>Tên người giúp việc</th>
                        <th>Trạng thái</th>
                        <th>Ngày làm đơn</th>
                        <th>Action</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="item" items="${borrows}">
                        <tr>
                            <td>${item.getId()}</td>
                            <td>${item.getUsername()}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/admin/edit-book?book_id=${item.getId()}">
                                        ${item.getBook_name()}
                                </a>
                            </td>
                            <td>${item.getStatus() == 0 ? "<p class='text-info'>Chờ xác nhận</p>" : (item.getStatus() == 1 ? "<p class='text-success'>Đã xác nhận</p>" : "<p class='text-danger'>Đã Huỷ</p>")}</td>
                            <td>${item.getCreated_at()}</td>
                            <td>
                                <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#exampleModal" data-bs-whatever="${item.getId()}|${item.getUsername()}|${item.getBook_name()}|${item.getStatus()}|${item.getBook_id()}">Xác nhận / Hủy</button>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="" method="post">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel"></h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                <input type="hidden" id="borrow_id" name="borrow_id">
                <input type="hidden" id="book_id" name="book_id">
            </div>
            <div class="modal-body">
                    <div class="form-group">
                        <label for="status">Thay đổi trạng thái</label>
                        <select class="form-control" name="status" id="status">
                            <option id="-1" value="-1">Huỷ</option>
                            <option id="0" value="0">Chờ xác nhận</option>
                            <option id="1" value="1">Xác nhận</option>
                        </select>
                    </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button type="submit" class="btn btn-primary">Send message</button>
            </div>
            </form>

        </div>
    </div>
</div>
<%@include file="../include/foot.jsp"%>
<script>
    const table = $('#mytable').DataTable( {
        "order": [],
    } );
    var borrow_id = "${pageContext.request.getParameter("borrow_id")}"
    borrow_id = borrow_id.slice(0,-1)
    if (borrow_id !== ""){
        borrow_id = borrow_id.replace(/-/g, '|')
        table.column(0).search(borrow_id, true, false).draw()
        $('#mytable').removeAttr('hidden');
    }
    const exampleModal = document.getElementById('exampleModal');
    exampleModal.addEventListener('show.bs.modal', function (event) {
        const button = event.relatedTarget;
        const data = button.getAttribute('data-bs-whatever');
        document.getElementById("exampleModalLabel").innerText = "đơn thuê: " + data.split("|")[1] + " thuê nhân viên có tên: " + data.split("|")[2]
        document.getElementById("borrow_id").value = data.split("|")[0]
        document.getElementById("book_id").value = data.split("|")[4]
        if (data.split("|")[3] === "-1"){
            document.getElementById("-1").selected = true;
            document.getElementById("-1").disabled = true;
        } else if (data.split("|")[3] === "0"){
            document.getElementById("0").selected = true;
            document.getElementById("0").disabled = true;
        } else {
            document.getElementById("1").selected = true;
            document.getElementById("1").disabled = true;
        }
    })
</script>