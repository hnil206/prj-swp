<%@include file="../include/head.jsp"%>
<%@page contentType="text/html" pageEncoding="utf-8" %>
<div class="container">
    <c:if test="${not empty success}">
        <div class="alert alert-success">
            ${success}
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger">
            ${error}
        </div>
    </c:if>
    <c:if test="${not empty warning}">
        <div class="alert alert-warning">
            ${warning}
        </div>
    </c:if>
    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-4 g-4">
        <c:forEach var="item" items="${books}">
            <div class="col">
                <div class="card shadow-sm">
                    <img src="${pageContext.request.contextPath}/${item.getImage()}" alt="" width="100%" height="200px" style="object-fit: contain">
                    <div class="card-body">
                        <p title="${item.getDescription()}" class="card-text" style="height: 150px; overflow: hidden; text-overflow: ellipsis; max-width: 100%">
                            <span class="fw-bold">
                                Họ và tên :
                            </span>
                            <span>
                                ${item.getTitle()}
                            </span>
                            <br>
                            <span class="fw-bold">
                                Quê Quán :
                            </span>
                            <span>
                                ${item.getAuthor()}
                            </span>
                            <br>
                            <span class="fw-bold">
                                Ngày sinh :
                            </span>
                            <span>
                                ${item.getGenre()}
                            </span>
                            <br>
                            <span class="fw-bold">
                                Mô tả :
                            </span>
                            <span>
                                ${item.getDescription()}
                            </span>
                            <br>
                        </p>
                        <div class="d-flex justify-content-between align-items-center">
                            <div class="btn-group mr-1">

                                <input type="hidden" name="book_id" value="${item.getId()}">
                                <button style="width: 100%;color: white" onclick="insert('${item.getId()}')" class="btn btn-success mr-1" data-bs-toggle="modal" data-bs-target="#userForm">Đặt thuê</button>

                            </div>
                            <div class="btn-group ml-1">
                                <form action="${pageContext.request.contextPath}/view-book-detail?book_id=${item.getId()}">
                                    <input type="hidden" name="book_id" value="${item.getId()}">
                                    <button style="width: 100%;color: white" type="submit" class="btn btn-info ml-1">Xem chi tiết</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
        <section class="dashboard">
            <div class="dash-content">
                <div class="modal fade" id="userForm">
                    <div class="modal-dialog modal-dialog-centered modal-lg">
                        <div class="modal-content">

                            <div class="modal-header">
                                <h4 class="modal-title">Fill the Form</h4>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>

                            <div class="modal-body">

                                <form action="${pageContext.request.contextPath}/insertborrow" method="get" id="myForm">
                                    <input type="hidden" name="bookid" id="bookid"/>
                                    <table>
                                        <tr>
                                            <td><label for="name">Start date</label></td>
                                            <td><input type="date" name="startdate" id="startdate" required></td>
                                        </tr>
                                        <tr>
                                            <td><label for="name">End date</label></td>
                                            <td><input type="date" name="enddate" id="enndate" required></td>
                                        </tr>
                                        <tr>
                                            <td>Address</td>
                                            <td>
                                                <div class="mb-3">
                                                    <div class="form-group">
                                                        <label for="province">Tỉnh/Thành phố:</label><br>
                                                        <select id="province" name="province" class="form-control"></select><br>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="district">Quận/Huyện:</label><br>
                                                        <select id="district" name="district" class="form-control"></select><br>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="ward">Phường/Xã:</label><br>
                                                        <select id="ward" name="ward" class="form-control"></select><br>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="ward">Địa chỉ cụ thể</label><br>
                                                        <input type="adress" name="address" id="useraddress" required>
                                                        
                                                        
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                        <script>
                                            document.addEventListener('DOMContentLoaded', function () {
                                                var provinceSelect = document.getElementById('province');
                                                var districtSelect = document.getElementById('district');
                                                var wardSelect = document.getElementById('ward');

                                                fetch('https://provinces.open-api.vn/api/?depth=3')
                                                        .then(response => response.json())
                                                        .then(data => {
                                                            var daNang = data.find(province => province.codename === 'thanh_pho_da_nang');
                                                            if (daNang) {
                                                                var option = document.createElement('option');
                                                                option.text = daNang.name;
                                                                option.value = daNang.name; // Sử dụng tên thay vì mã số
                                                                provinceSelect.add(option);

                                                                daNang.districts.forEach(district => {
                                                                    var option = document.createElement('option');
                                                                    option.text = district.name;
                                                                    option.value = district.name; // Sử dụng tên thay vì mã số
                                                                    districtSelect.add(option);
                                                                });
                                                            }
                                                        });

                                                districtSelect.addEventListener('change', function () {
                                                    fetch(`https://provinces.open-api.vn/api/?depth=3`)
                                                            .then(response => response.json())
                                                            .then(data => {
                                                                wardSelect.options.length = 0;
                                                                var daNang = data.find(province => province.codename === 'thanh_pho_da_nang');
                                                                if (daNang) {
                                                                    var wards = daNang.districts.find(district => district.name == this.value).wards;
                                                                    wards.forEach(ward => {
                                                                        var option = document.createElement('option');
                                                                        option.text = ward.name;
                                                                        option.value = ward.name; // Sử dụng tên thay vì mã số
                                                                        wardSelect.add(option);
                                                                    });
                                                                }
                                                            });
                                                });
                                            });

                                        </script>
                                        <script>
                                            function updatePaymentOption() {
                                                var bookType = document.getElementById("booktype").value;
                                                var paymentOption = document.getElementById("paymentOption");
                                                if (bookType == "1") {
                                                    paymentOption.innerHTML = '<input type="radio" id="html" name="thanhtoan" value="ngay"><label for="html">Thanh toán theo ngày</label><br><input type="radio" id="css" name="thanhtoan" value="gio"><label for="css">Thanh toán theo giờ</label><br>';
                                                } else if (bookType == "2") {
                                                    paymentOption.innerHTML = '<input type="radio" id="html" name="thanhtoan" value="theothang"><label for="html">Thanh toán theo tháng</label><br>';
                                                }
                                            }
                                        </script>


                                        <tr>
                                            <td>Book type</td>
                                            <td>
                                                <select id="booktype" name="booktype" onchange="updatePaymentOption()">
                                                    <option value="2">Fulltime</option>
                                                    <option selected value="1">Parttime</option>
                                                </select>
                                            </td>
                                        </tr>


                                        <tr>
                                            <td>Thanh toan</td>
                                            <td id="paymentOption">
                                                <!-- Payment options will be inserted here by the JavaScript function -->
                                            </td>
                                        </tr>
                                        <script>updatePaymentOption();</script>
                                    </table>




                                </form>
                            </div>

                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                <button type="submit" form="myForm" class="btn btn-primary submit">Submit</button>
                            </div>
                        </div>
                    </div>
                </div>
                <div/>
                <section/>
            </div>
    </div>
    <%@include file="../include/foot.jsp"%>
