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
                <h1>Tất cả đơn thuê</h1>
                <table ${pageContext.request.getParameter("borrow_id") != null ? "hidden" : ""} class="table table-bordered table-striped mt-2" id="mytable">
                    <thead class="thead-dark">
                        <tr>
                            <th>STT</th>
                            <th>Tên người thuê</th>
                            <th>Tên người giúp việc</th>
                            <th>Trạng thái</th>
                            <th>Ngày làm đơn</th>
                            <th>Loại dịch vụ</th>
                            <th>Địa chỉ</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="item" items="${borrows}" varStatus="loop">
                            <tr>
                                <td>${borrows.size() - loop.index}</td>
                                <td>${item.getUsername()}</td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/admin/edit-book?book_id=${item.getBook_id()}" class="text-decoration-none">${item.getBookname()}</a>
                                </td>
                                <td>
                                    <span class="badge ${item.getStatus() == 0 ? 'bg-info' : (item.getStatus() == 1 ? 'bg-success' : 'bg-danger')}">
                                        ${item.getStatus() == 0 ? 'Chờ xác nhận' : (item.getStatus() == 1 ? 'Đã xác nhận' : 'Đã Hủy')}
                                    </span>
                                </td>
                                <td>${item.getCreate_at()}</td>
                                <td>${item.getServiceType()}</td>
                                <td>${item.getUseraddress()}</td>
                                <td>
                                    <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#exampleModal" data-bs-whatever="${item.getId()}|${item.getUsername()}|${item.getBookname()}|${item.getStatus()}|${item.getBook_id()}|${item.getStartdate()}|${item.getEnddate()}|${item.getBooktypeid()}|${item.getUseraddress()}|${item.getServiceType()}">Xác nhận / Hủy</button>
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
            <form action="manage-borrow-books" method="post">

                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel"></h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    <input type="hidden" id="borrow_id" name="borrow_id">
                    <input type="hidden" id="book_id" name="book_id">
                </div>

                <div class="modal-body">
                    <div class="form-group">
                        <h3>Start date</h3>
                        <input type="date" readonly="true" id="startdate"/><br/>
                        <h3>End date</h3>
                        <input type="date" readonly="true" id="enddate"/><br/>
                        <h3>Payments</h3>
                        <input type="text" readonly="true" id="paymentstatus"/><br/>
                        
<!--                        <h3>Work address</h3>
                        <p type="text" readonly="true" id="useraddress "/><br/>-->
                        <div/>
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
    const table = $('#mytable').DataTable({
        "order": [],
    });
    var borrow_id = "${pageContext.request.getParameter("borrow_id")}"
    borrow_id = borrow_id.slice(0, -1)
    if (borrow_id !== "") {
        borrow_id = borrow_id.replace(/-/g, '|')
        table.column(0).search(borrow_id, true, false).draw()
        $('#mytable').removeAttr('hidden');
    }
    const exampleModal = document.getElementById('exampleModal');
    exampleModal.addEventListener('show.bs.modal', function (event) {
        const button = event.relatedTarget;
        const data = button.getAttribute('data-bs-whatever');
        console.log(data)
        var booktype = data.split("|")[7]
        console.log('dong117' + data.split("|")[7])
        console.log('dong118' + data.split("|")[8])
        if (booktype == "1") {
            booktype = "Part-time"
        } else {
            booktype = "Fulltime"
        }


        document.getElementById("exampleModalLabel").innerText = "Đơn thuê: " + data.split("|")[1] + " thuê nhân viên có tên: " + data.split("|")[2] + " " + booktype;
        document.getElementById("borrow_id").value = data.split("|")[0]
        document.getElementById("book_id").value = data.split("|")[4]
        document.getElementById("startdate").value = data.split("|")[5]
        document.getElementById("enddate").value = data.split("|")[6]
        document.getElementById("useraddress").value = data.split("|")[8]

//        console.log(data.split("|")[8])

        //console.log('kkkk'+data.split("|")[7])
//        document.getElementById("ward").value = data.split("|")[8]
//        document.getElementById("district").value = data.split("|")[9]
//        document.getElementById("province").value = data.split("|")[10]

        console.log('data', );
        if (data.split("|")[3] === "-1") {
            document.getElementById("-1").selected = true;
            document.getElementById("-1").disabled = true;
        } else if (data.split("|")[3] === "0") {
            document.getElementById("0").selected = true;
            document.getElementById("0").disabled = true;
        } else {
            document.getElementById("1").selected = true;
            document.getElementById("1").disabled = true;
        }
    })
    //api address

</script>