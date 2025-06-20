<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>Home Page</title>
            <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet"
                id="bootstrap-css">
            <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
            <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
            <!------ Include the above in your HEAD tag ------>
            <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet"
                integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN"
                crossorigin="anonymous">
            <link href="css/style.css" rel="stylesheet" type="text/css" />
            <link href="css/categories.css" rel="stylesheet" type="text/css" />
            <link href="css/product-cards.css" rel="stylesheet" type="text/css" />

            <!-- Font Awesome -->
            <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.11.2/css/all.css" />
            <!-- Google Fonts Roboto -->
            <link rel="stylesheet"
                href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" />
            <!-- MDB -->
            <link rel="stylesheet" href="css/mdb.min.css" />
            <!-- Custom styles -->
            <link rel="stylesheet" href="css/style.css" />

            <!-- Roboto Font -->
            <link rel="stylesheet"
                href="https://fonts.googleapis.com/css?family=Roboto:100,300,400,500,700&display=swap">
            Font Awesome
            <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.11.2/css/all.css">
            Bootstrap core CSS
            <link rel="stylesheet" href="https://mdbootstrap.com/previews/ecommerce-demo/css/bootstrap.min.css">
            Material Design Bootstrap
            <link rel="stylesheet" href="https://mdbootstrap.com/previews/ecommerce-demo/css/mdb-pro.min.css">
            Material Design Bootstrap Ecommerce
            <link rel="stylesheet" href="https://mdbootstrap.com/previews/ecommerce-demo/css/mdb.ecommerce.min.css">
            <!-- Your custom styles (optional) -->
            <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

            <style>
                /* Carousel styling */
                #introCarousel,
                .carousel-inner,
                .carousel-item,
                .carousel-item.active {
                    height: 70vh;
                }

                .carousel-item:nth-child(1) {
                    background-image: url('https://bizweb.dktcdn.net/100/416/540/themes/839121/assets/slide-img1.jpg?1747989040103');
                    background-repeat: no-repeat;
                    background-size: 100% 100%;
                    background-position: center center;
                }

                .carousel-item:nth-child(2) {
                    background-image: url('https://bizweb.dktcdn.net/100/416/540/themes/839121/assets/slide-img3.jpg?1747989040103');
                    background-repeat: no-repeat;
                    background-size: 100% 100%;
                    background-position: center center;
                }

                .carousel-item:nth-child(3) {
                    background-image: url('https://bizweb.dktcdn.net/100/416/540/themes/839121/assets/slide-img5.jpg?1747989040103');
                    background-repeat: no-repeat;
                    background-size: 100% 100%;
                    background-position: center center;
                }

                /* Height for devices larger than 576px */
                @media (min-width: 992px) {
                    #introCarousel {
                        margin-top: -58.59px;
                    }
                }

                .navbar .nav-link {
                    color: #fff !important;
                }
            </style>

        </head>

        <body class="skin-light" onload="loadAmountCart()">
            <jsp:include page="Menu.jsp"></jsp:include>



            <!-- Carousel wrapper -->
            <div id="introCarousel" class="carousel slide carousel-fade shadow-2-strong" data-mdb-ride="carousel"
                style="margin-top:35px;">
                <!-- Indicators -->
                <ol class="carousel-indicators">
                    <li data-mdb-target="#introCarousel" data-mdb-slide-to="0" class="active"></li>
                    <li data-mdb-target="#introCarousel" data-mdb-slide-to="1"></li>
                    <li data-mdb-target="#introCarousel" data-mdb-slide-to="2"></li>
                </ol>

                <!-- Inner -->
                <div class="carousel-inner">
                    <!-- Single item -->
                    <div class="carousel-item active">

                    </div>

                    <!-- Single item -->
                    <div class="carousel-item">

                    </div>

                    <!-- Single item -->
                    <div class="carousel-item">

                    </div>
                </div>
                <!-- Inner -->

                <!-- Controls -->
                <a class="carousel-control-prev" href="#introCarousel" role="button" data-mdb-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="sr-only">Previous</span>
                </a>
                <a class="carousel-control-next" href="#introCarousel" role="button" data-mdb-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="sr-only">Next</span>
                </a>
            </div>
            <!-- Carousel wrapper -->



            <div class="card-group" style="margin-top:50px;">
                <div class="card" style="border-style: none;">
                    <img style="height:55px; width:64px; margin: auto;"
                        src="https://fptshop.com.vn/img/icons/policy1.svg?w=128&q=75">
                    <div class="card-body">
                        <h5 class="card-title" style="text-align:center">GIAO HÀNG TOÀN QUỐC</h5>
                        <p class="card-text" style="text-align:center">Vận chuyển khắp Việt Nam</p>
                    </div>
                </div>
                <div class="card" style="border-style: none;">
                    <img class="card-img-top" style="height:55px; width:64px; margin: auto;"
                        src="https://fptshop.com.vn/img/icons/policy3.svg?w=128&q=75" alt="Card image cap">
                    <div class="card-body">
                        <h5 class="card-title" style="text-align:center">THANH TOÁN KHI NHẬN HÀNG</h5>
                        <p class="card-text" style="text-align:center">Nhận hàng tại nhà rồi thanh toán</p>
                    </div>
                </div>
                <div class="card" style="border-style: none;">
                    <img class="card-img-top" style="height:55px; width:64px; margin: auto;"
                        src="https://fptshop.com.vn/img/icons/policy2.svg?w=128&q=75" alt="Card image cap">
                    <div class="card-body">
                        <h5 class="card-title" style="text-align:center">BẢO HÀNH DÀI HẠN</h5>
                        <p class="card-text" style="text-align:center">Bảo hàng lên đến 60 ngày</p>
                    </div>
                </div>
                <div class="card" style="border-style: none;">
                    <img class="card-img-top" style="height:55px; width:64px; margin: auto;"
                        src="https://fptshop.com.vn/img/icons/policy4.svg?w=128&q=75" alt="Card image cap">
                    <div class="card-body">
                        <h5 class="card-title" style="text-align:center">ĐỔI HÀNG DỄ DÀNG</h5>
                        <p class="card-text" style="text-align:center">Đổi hàng thoải mái trong 30 ngày</p>
                    </div>
                </div>
            </div>

            <!-- Categories Section -->
            <div class="container" style="margin-top: 40px;">
                <div class="row">
                    <div class="col-12 text-center mb-4">
                        <h2 class="categories-title">DANH MỤC SẢN PHẨM</h2>
                        <p class="categories-subtitle">Chọn danh mục để khám phá các sản phẩm tuyệt vời</p>
                    </div>
                </div>
                <div class="row justify-content-center">
                    <c:forEach items="${listCC}" var="category">
                        <div class="col-lg-4 col-md-6 col-sm-12 mb-4">
                            <div class="category-card card h-100" onclick="goToShopCategory(${category.cid})">
                                <div class="card-body text-center p-4">
                                    <div class="category-icon mb-3">
                                        <c:choose>
                                            <c:when test="${category.cname == 'Sữa bột'}">
                                                <i class="fas fa-baby fa-3x category-milk-powder"></i>
                                            </c:when>
                                            <c:when test="${category.cname == 'Sữa tươi'}">
                                                <i class="fas fa-glass-whiskey fa-3x category-fresh-milk"></i>
                                            </c:when>
                                            <c:when test="${category.cname == 'Sữa chua'}">
                                                <i class="fas fa-ice-cream fa-3x category-yogurt"></i>
                                            </c:when>
                                            <c:otherwise>
                                                <i class="fas fa-shopping-basket fa-3x category-default"></i>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <h4 class="card-title font-weight-bold mb-2">${category.cname}</h4>
                                    <p class="card-text text-muted">
                                        <c:choose>
                                            <c:when test="${category.cname == 'Sữa bột'}">
                                                Dinh dưỡng hoàn hảo cho bé yêu
                                            </c:when>
                                            <c:when test="${category.cname == 'Sữa tươi'}">
                                                Tươi ngon, giàu vitamin và khoáng chất
                                            </c:when>
                                            <c:when test="${category.cname == 'Sữa chua'}">
                                                Probiotics tốt cho hệ tiêu hóa
                                            </c:when>
                                            <c:otherwise>
                                                Sản phẩm chất lượng cao
                                            </c:otherwise>
                                        </c:choose>
                                    </p>
                                    <div class="category-arrow">
                                        <i class="fas fa-arrow-right text-primary"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>

            <div class="container">

                <!-- Latest Products Section -->
                <div class="row" style="margin-top: 50px;">
                    <div class="col-12">
                        <div class="section-header">
                            <h1 class="section-title" id="moiNhat">SẢN PHẨM MỚI NHẤT</h1>
                            <p class="section-subtitle">Khám phá những sản phẩm sữa mới nhất và chất lượng nhất</p>
                        </div>
                        <div id="contentMoiNhat" class="row">
                            <c:forEach items="${list8Last}" var="o">
                                <div class="col-12 col-md-6 col-lg-3 product-card-container">
                                    <div class="product-card">
                                        <div class="product-image-container">
                                            <img class="product-image" src="${o.image}" alt="${o.name}">
                                            <div class="product-badge">Mới</div>
                                            <div class="quick-view-overlay">
                                                <button class="quick-view-btn" onclick="window.location.href='detail?pid=${o.id}'">
                                                    <i class="fas fa-eye mr-2"></i>Xem chi tiết
                                                </button>
                                            </div>
                                        </div>
                                        <div class="product-card-body">
                                            <h4 class="product-title">
                                                <a href="detail?pid=${o.id}" title="View Product">${o.name}</a>
                                            </h4>
                                            <p class="product-description">${o.title}</p>
                                            <div class="product-rating">
                                                <div class="stars">
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                </div>
                                                <span class="rating-text">(5.0)</span>
                                            </div>
                                            <div class="product-price-section">
                                                <a href="detail?pid=${o.id}" class="product-price">
                                                    <fmt:formatNumber value="${o.price}" pattern="#,###" var="vndPrice"/>
                                                    ${fn:replace(vndPrice, ',', '.')} VNĐ
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>


                <!-- Milk Powder Section -->
                <div class="row" style="margin-top: 50px;">
                    <div class="col-12">
                        <div class="section-header">
                            <h1 class="section-title" id="nike">SỮA BỘT MỚI NHẤT</h1>
                            <p class="section-subtitle">Dinh dưỡng hoàn hảo cho sự phát triển của bé yêu</p>
                        </div>
                        <div id="contentNike" class="row">
                            <c:forEach items="${list4NikeLast}" var="o">
                                <div class="productNike col-12 col-md-6 col-lg-3 product-card-container">
                                    <div class="product-card">
                                        <div class="product-image-container">
                                            <img class="product-image" src="${o.image}" alt="${o.name}">
                                            <div class="product-badge">Hot</div>
                                            <div class="quick-view-overlay">
                                                <button class="quick-view-btn" onclick="window.location.href='detail?pid=${o.id}'">
                                                    <i class="fas fa-eye mr-2"></i>Xem chi tiết
                                                </button>
                                            </div>
                                        </div>
                                        <div class="product-card-body">
                                            <h4 class="product-title">
                                                <a href="detail?pid=${o.id}" title="View Product">${o.name}</a>
                                            </h4>
                                            <p class="product-description">${o.title}</p>
                                            <div class="product-rating">
                                                <div class="stars">
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                </div>
                                                <span class="rating-text">(5.0)</span>
                                            </div>
                                            <div class="product-price-section">
                                                <a href="detail?pid=${o.id}" class="product-price">
                                                    <fmt:formatNumber value="${o.price}" pattern="#,###" var="vndPrice"/>
                                                    ${fn:replace(vndPrice, ',', '.')} VNĐ
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        <div class="load-more-container">
                            <button onclick="loadMoreNike()" class="load-more-btn">
                                <i class="fas fa-plus-circle mr-2"></i>Xem thêm sản phẩm
                            </button>
                        </div>
                    </div>
                </div>


                <!-- Fresh Milk Section -->
                <div class="row" style="margin-top: 50px; margin-bottom: 50px;">
                    <div class="col-12">
                        <div class="section-header">
                            <h1 class="section-title" id="adidas">SỮA TƯƠI MỚI NHẤT</h1>
                            <p class="section-subtitle">Tươi ngon tự nhiên, giàu vitamin và khoáng chất thiết yếu</p>
                        </div>
                        <div id="contentAdidas" class="row">
                            <c:forEach items="${list4AdidasLast}" var="o">
                                <div class="productAdidas col-12 col-md-6 col-lg-3 product-card-container">
                                    <div class="product-card">
                                        <div class="product-image-container">
                                            <img class="product-image" src="${o.image}" alt="${o.name}">
                                            <div class="product-badge">Sale</div>
                                            <div class="quick-view-overlay">
                                                <button class="quick-view-btn" onclick="window.location.href='detail?pid=${o.id}'">
                                                    <i class="fas fa-eye mr-2"></i>Xem chi tiết
                                                </button>
                                            </div>
                                        </div>
                                        <div class="product-card-body">
                                            <h4 class="product-title">
                                                <a href="detail?pid=${o.id}" title="View Product">${o.name}</a>
                                            </h4>
                                            <p class="product-description">${o.title}</p>
                                            <div class="product-rating">
                                                <div class="stars">
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                </div>
                                                <span class="rating-text">(5.0)</span>
                                            </div>
                                            <div class="product-price-section">
                                                <a href="detail?pid=${o.id}" class="product-price">
                                                    <fmt:formatNumber value="${o.price}" pattern="#,###" var="vndPrice"/>
                                                    ${fn:replace(vndPrice, ',', '.')} VNĐ
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        <div class="load-more-container">
                            <button onclick="loadMoreAdidas()" class="load-more-btn">
                                <i class="fas fa-plus-circle mr-2"></i>Xem thêm sản phẩm
                            </button>
                        </div>
                    </div>
                </div>

            </div>
            </div>

            <jsp:include page="Footer.jsp"></jsp:include>
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
            <script>

                function loadMore() {
                    var amount = document.getElementsByClassName("product").length;
                    $.ajax({
                        url: "/WebsiteBanSua/load",
                        type: "get", //send it through get method
                        data: {
                            exits: amount
                        },
                        success: function (data) {
                            var row = document.getElementById("content");
                            row.innerHTML += data;
                        },
                        error: function (xhr) {
                            //Do Something to handle error
                        }
                    });
                }
                function loadMoreNike() {
                    var amountNike = document.getElementsByClassName("productNike").length;
                    $.ajax({
                        url: "/WebsiteBanSua/loadNike",
                        type: "get", //send it through get method
                        data: {
                            exitsNike: amountNike
                        },
                        success: function (dataNike) {
                            document.getElementById("contentNike").innerHTML += dataNike;
                            
                            // Re-initialize product cards for newly loaded content
                            if (typeof initializeProductCards === 'function') {
                                initializeProductCards();
                            }
                        },
                        error: function (xhr) {
                            //Do Something to handle error
                        }
                    });
                }
                function loadMoreAdidas() {
                    var amountAdidas = document.getElementsByClassName("productAdidas").length;
                    $.ajax({
                        url: "/WebsiteBanSua/loadAdidas",
                        type: "get", //send it through get method
                        data: {
                            exitsAdidas: amountAdidas
                        },
                        success: function (dataAdidas) {
                            document.getElementById("contentAdidas").innerHTML += dataAdidas;
                            
                            // Re-initialize product cards for newly loaded content
                            if (typeof initializeProductCards === 'function') {
                                initializeProductCards();
                            }
                        },
                        error: function (xhr) {
                            //Do Something to handle error
                        }
                    });
                }
                function searchByName(param) {
                    var txtSearch = param.value;
                    $.ajax({
                        url: "/WebsiteBanSua/searchAjax",
                        type: "get", //send it through get method
                        data: {
                            txt: txtSearch
                        },
                        success: function (data) {
                            var row = document.getElementById("content");
                            row.innerHTML = data;
                        },
                        error: function (xhr) {
                            //Do Something to handle error
                        }
                    });
                }
                function load(cateid) {
                    $.ajax({
                        url: "/WebsiteBanSua/category",
                        type: "get", //send it through get method
                        data: {
                            cid: cateid
                        },
                        success: function (responseData) {
                            document.getElementById("content").innerHTML = responseData;
                        }
                    });
                }
                

                function loadAmountCart() {
                    $.ajax({
                        url: "/WebsiteBanSua/loadAllAmountCart",
                        type: "get", //send it through get method
                        data: {

                        },
                        success: function (responseData) {
                            document.getElementById("amountCart").innerHTML = responseData;
                        }
                    });
                }

                function goToShopCategory(categoryId) {
                    // Redirect to shop page with category filter
                    window.location.href = "shop?cid=" + categoryId;
                }         
            </script>


            <!-- MDB -->
            <script type="text/javascript" src="js/mdb.min.js"></script>
            <!-- Custom scripts -->
            <script type="text/javascript" src="js/script.js"></script>
            <!-- Product Cards Enhancement -->
            <script type="text/javascript" src="js/product-cards.js"></script>

            <!-- SCRIPTS -->
            <!-- JQuery -->
            <script src="https://mdbootstrap.com/previews/ecommerce-demo/js/jquery-3.4.1.min.js"></script>
            <!-- Bootstrap tooltips -->
            <script type="text/javascript"
                src="https://mdbootstrap.com/previews/ecommerce-demo/js/popper.min.js"></script>
            <!-- Bootstrap core JavaScript -->
            <script type="text/javascript"
                src="https://mdbootstrap.com/previews/ecommerce-demo/js/bootstrap.js"></script>
            <!-- MDB core JavaScript -->
            <script type="text/javascript" src="https://mdbootstrap.com/previews/ecommerce-demo/js/mdb.min.js"></script>
            <!-- MDB Ecommerce JavaScript -->
            <script type="text/javascript"
                src="https://mdbootstrap.com/previews/ecommerce-demo/js/mdb.ecommerce.min.js"></script>
        </body>

        </html>