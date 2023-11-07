<%@include file="../include/head.jsp"%> <%@page contentType="text/html" pageEncoding="utf-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <!-- Required meta tags always come first -->
        <meta charset="utf-8" />
        <meta
            name="viewport"
            content="width=device-width, initial-scale=1, shrink-to-fit=no"
            />
        <meta http-equiv="x-ua-compatible" content="ie=edge" />
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="css/Bootstrap/bootstrap.min.css" />
        <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"
            />
        <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-social/5.1.1/bootstrap-social.min.css"
            />

        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <!-- Bootstrap icons-->
        <link href="css/bootstrap/font_bootstrap-icon.css" rel="stylesheet" />
        <link href="css/bootstrap/font-awesome.min.css" rel="stylesheet" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link rel="stylesheet" href="css/mystyle.css" />
        <style>
            .fot {
                margin-top: 100px;
            }
            .custom-title {
                font-family: 'Arial', sans-serif;
                font-size: 3rem;
                font-weight: bold;
                color: #ff6600;
                text-align: center;
                text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.2);
                margin-bottom: 20px;
            }

            @media (max-width: 768px) {
                .custom-title {
                    font-size: 2rem;
                }
            }
        </style>
    </head>
    <div class="container">
        <div id="carouselExampleCaptions" class="carousel slide" data-mdb-ride="carousel">
            <div class="carousel-indicators">
                <button
                    type="button"
                    data-mdb-target="#carouselExampleCaptions"
                    data-mdb-slide-to="0"
                    class="active"
                    aria-current="true"
                    aria-label="Slide 1"
                    ></button>
                <button
                    type="button"
                    data-mdb-target="#carouselExampleCaptions"
                    data-mdb-slide-to="1"
                    aria-label="Slide 2"
                    ></button>
                <button
                    type="button"
                    data-mdb-target="#carouselExampleCaptions"
                    data-mdb-slide-to="2"
                    aria-label="Slide 3"
                    ></button>
            </div>
            <div class="carousel-inner" >
                <div class="carousel-item active">
                    <img src="https://images.pexels.com/photos/6195277/pexels-photo-6195277.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1" class="d-block w-100" alt="Wild Landscape"/>
                    <div class="carousel-caption d-none d-md-block">
                        <h5>First slide label</h5>
                        <p>Nulla vitae elit libero, a pharetra augue mollis interdum.</p>
                    </div>
                </div>
                <div class="carousel-item">
                    <img src="https://mdbcdn.b-cdn.net/img/new/slides/042.webp" class="d-block w-100" alt="Camera"/>
                    <div class="carousel-caption d-none d-md-block">
                        <h5>Second slide label</h5>
                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
                    </div>
                </div>
                <div class="carousel-item">
                    <img src="https://mdbcdn.b-cdn.net/img/new/slides/043.webp" class="d-block w-100" alt="Exotic Fruits"/>
                    <div class="carousel-caption d-none d-md-block">
                        <h5>Third slide label</h5>
                        <p>Praesent commodo cursus magna, vel scelerisque nisl consectetur.</p>
                    </div>
                </div>
            </div>
            <button class="carousel-control-prev" type="button" data-mdb-target="#carouselExampleCaptions" data-mdb-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-mdb-target="#carouselExampleCaptions" data-mdb-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
            </button>
        </div>
    </div>

    <div class="container">
        <h1 class="custom-title">CleanHouse - 
            "Giải pháp giúp việc đơn giản, dễ dàng - để bạn tập trung vào những khoảnh khắc quý báu trong cuộc sống!"</h1>


        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
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
                                    Quê quán :
                                </span>
                                <span>
                                    ${item.getAuthor()}
                                </span>
                                <br>
                                <span class="fw-bold">
                                    Ngày sinh:
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
                                    <form action="${pageContext.request.contextPath}/user/borrow-book" method="post">
                                        <input type="hidden" name="book_id" value="${item.getId()}">
                                        <button style="width: 100%;color: white" type="submit" class="btn btn-success">Đặt thuê</button>
                                    </form>
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
        </div>
    </div>
    <div class="fot">
        <!-- Footer -->
        <footer
            class="text-center text-lg-start text-dark"
            style="background-color: #ECEFF1"
            >
            <!-- Section: Social media -->
            <section
                class="d-flex justify-content-between p-4 text-white"
                style="background-color: #21D192"
                >
                <!-- Left -->
                <div class="me-5">
                    <span>Get connected with us on social networks:</span>
                </div>
                <!-- Left -->

                <!-- Right -->
                <div>
                    <a href="https://www.facebook.com/" class="text-white me-4">
                        <i class="fab fa-facebook-f"></i>
                    </a>
                    <a href="https://twitter.com/i/flow/login" class="text-white me-4">
                        <i class="fab fa-twitter"></i>
                    </a>
                    <a href="https://mail.google.com/" class="text-white me-4">
                        <i class="fab fa-google"></i>
                    </a>
                    <a href="https://www.instagram.com/" class="text-white me-4">
                        <i class="fab fa-instagram"></i>
                    </a>
                    <a href="" class="text-white me-4">
                        <i class="fab fa-linkedin"></i>
                    </a>
                    <a href="" class="text-white me-4">
                        <i class="fab fa-github"></i>
                    </a>
                </div>
                <!-- Right -->
            </section>
            <!-- Section: Social media -->

            <!-- Section: Links  -->
            <section class="">
                <div class="container text-center text-md-start mt-5">
                    <!-- Grid row -->
                    <div class="row mt-3">
                        <!-- Grid column -->
                        <div class="col-md-3 col-lg-4 col-xl-3 mx-auto mb-4">
                            <!-- Content -->
                            <h3 class="text-uppercase fw-bold">CleanHouse</h3>
                            <hr
                                class="mb-4 mt-0 d-inline-block mx-auto"
                                style="width: 60px; background-color: #7c4dff; height: 2px"
                                />
                            <p>

                                Sự hài lòng của quý khách là niềm vinh dự của chúng tôi
                            </p>
                        </div>
                        <!-- Grid column -->

                        <!-- Grid column -->
                        <div class="col-md-2 col-lg-2 col-xl-2 mx-auto mb-4">
                            <!-- Links -->
                            <h6 class="text-uppercase fw-bold">Products</h6>
                            <hr
                                class="mb-4 mt-0 d-inline-block mx-auto"
                                style="width: 60px; background-color: #7c4dff; height: 2px"
                                />
                            <p>
                                <a href="#!" class="text-dark">MDBootstrap</a>
                            </p>
                            <p>
                                <a href="#!" class="text-dark">MDWordPress</a>
                            </p>
                            <p>
                                <a href="#!" class="text-dark">BrandFlow</a>
                            </p>
                            <p>
                                <a href="#!" class="text-dark">Bootstrap Angular</a>
                            </p>
                        </div>
                        <!-- Grid column -->

                        <!-- Grid column -->
                        <div class="col-md-3 col-lg-2 col-xl-2 mx-auto mb-4">
                            <!-- Links -->
                            <h6 class="text-uppercase fw-bold">Useful links</h6>
                            <hr
                                class="mb-4 mt-0 d-inline-block mx-auto"
                                style="width: 60px; background-color: #7c4dff; height: 2px"
                                />
                            <p>
                                <a href="#!" class="text-dark">Your Account</a>
                            </p>
                            <p>
                                <a href="#!" class="text-dark">Become an Affiliate</a>
                            </p>
                            <p>
                                <a href="#!" class="text-dark">Shipping Rates</a>
                            </p>
                            <p>
                                <a href="#!" class="text-dark">Help</a>
                            </p>
                        </div>
                        <!-- Grid column -->

                        <!-- Grid column -->
                        <div class="col-md-4 col-lg-3 col-xl-3 mx-auto mb-md-0 mb-4">
                            <!-- Links -->
                            <h6 class="text-uppercase fw-bold">Contact</h6>
                            <hr
                                class="mb-4 mt-0 d-inline-block mx-auto"
                                style="width: 60px; background-color: #7c4dff; height: 2px"
                                />
                            <p><i class="fas fa-home mr-3"></i> New York, NY 10012, US</p>
                            <p><i class="fas fa-envelope mr-3"></i> info@example.com</p>
                            <p><i class="fas fa-phone mr-3"></i> + 01 234 567 88</p>
                            <p><i class="fas fa-print mr-3"></i> + 01 234 567 89</p>
                        </div>
                        <!-- Grid column -->
                    </div>
                    <!-- Grid row -->
                </div>
            </section>
            <!-- Section: Links  -->

            <!-- Copyright -->
            <div
                class="text-center p-3"
                style="background-color: rgba(0, 0, 0, 0.2)"
                >
                © 2020 Copyright:
                <a class="text-dark" href="https://mdbootstrap.com/"
                   >MDBootstrap.com</a
                >
            </div>
            <!-- Copyright -->
        </footer>
        <!-- Footer -->
    </div>

</body>
</html>
<%@include file="../include/foot.jsp"%>
