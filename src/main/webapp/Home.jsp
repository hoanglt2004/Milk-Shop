<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ include file="WEB-INF/bootstrap-template.jsp" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Home Page</title>
    <!-- Bootstrap 4.6.0 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome 5.15.4 -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <!-- Google Fonts Roboto -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    <!-- MDBootstrap (nếu cần) -->
    <link rel="stylesheet" href="css/mdb.min.css"/>
    <!-- Custom CSS -->
    <link rel="stylesheet" href="css/style.css"/>
    <link rel="stylesheet" href="css/categories.css"/>
    <link rel="stylesheet" href="css/product-cards.css"/>

    <style>
        /* Carousel styling */
        .carousel-container {
            width: 80%;
            margin: 20px auto;
            position: relative;
            overflow: hidden;
            border-radius: 15px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        }

        #introCarousel,
        .carousel-inner,
        .carousel-item,
        .carousel-item.active {
            height: 60vh;
        }

        .carousel-item:nth-child(1) {
            background-image: url('https://bizweb.dktcdn.net/100/416/540/themes/839121/assets/slide-img1.jpg?1747989040103');
            background-repeat: no-repeat;
            background-size: cover;
            background-position: center center;
        }

        .carousel-item:nth-child(2) {
            background-image: url('https://bizweb.dktcdn.net/100/416/540/themes/839121/assets/slide-img3.jpg?1747989040103');
            background-repeat: no-repeat;
            background-size: cover;
            background-position: center center;
        }

        .carousel-item:nth-child(3) {
            background-image: url('https://bizweb.dktcdn.net/100/416/540/themes/839121/assets/slide-img5.jpg?1747989040103');
            background-repeat: no-repeat;
            background-size: cover;
            background-position: center center;
        }

        .carousel-indicators {
            bottom: 20px;
        }

        .carousel-indicators li {
            width: 10px;
            height: 10px;
            border-radius: 50%;
            margin: 0 6px;
            background-color: rgba(255, 255, 255, 0.5);
            transition: all 0.3s ease;
        }

        .carousel-indicators .active {
            width: 12px;
            height: 12px;
            background-color: white;
        }

        .carousel-control-prev,
        .carousel-control-next {
            width: 5%;
            opacity: 0;
            transition: all 0.3s ease;
        }

        .carousel-container:hover .carousel-control-prev,
        .carousel-container:hover .carousel-control-next {
            opacity: 0.8;
        }

        .carousel-control-prev-icon,
        .carousel-control-next-icon {
            background-color: rgba(0, 0, 0, 0.5);
            padding: 20px;
            border-radius: 50%;
        }

        /* Height for devices larger than 576px */
        @media (min-width: 992px) {
            #introCarousel {
                margin-top: 0;
            }
        }

        @media (max-width: 768px) {
            .carousel-container {
                width: 95%;
            }

            #introCarousel,
            .carousel-inner,
            .carousel-item,
            .carousel-item.active {
                height: 40vh;
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
    <div class="carousel-container">
        <div id="introCarousel" class="carousel slide carousel-fade shadow-2-strong"
            data-mdb-ride="carousel">
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
                    <div class="category-card card h-100" onclick="goToShopCategory('${category.cid}')">
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
                    <p class="section-subtitle">Khám phá những sản phẩm sữa mới nhất và chất lượng nhất
                    </p>
                </div>
                <div id="contentMoiNhat" class="row">
                    <c:forEach items="${list8Last}" var="o">
                        <div class="col-12 col-md-6 col-lg-3 product-card-container">
                            <div class="product-card">
                                <div class="product-image-container">
                                    <img class="product-image" src="${o.image}" alt="${o.name}">
                                    <c:if test="${o.discountPercent > 0}">
                                        <div class="product-badge sale-badge">-${o.discountPercent}%
                                        </div>
                                    </c:if>
                                    <div class="product-badge new-badge">Mới</div>
                                    <div class="quick-view-overlay">
                                        <button class="quick-view-btn"
                                            onclick="window.location.href='detail?pid=${o.id}'">
                                            <i class="fas fa-eye mr-2"></i>Xem chi tiết
                                        </button>
                                    </div>
                                </div>
                                <div class="product-card-body">
                                    <h4 class="product-title">
                                        <a href="detail?pid=${o.id}" title="View Product">${o.name}</a>
                                    </h4>
                                    <p class="product-description">${o.brand}</p>
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
                                    <div class="product-price-section"
                                        style="display: flex; flex-direction: column; align-items: center; justify-content: center; min-height: 80px; gap: 5px; margin-top: 10px;">
                                        <c:choose>
                                            <c:when test="${o.discountPercent > 0}">
                                                <div class="price-pill"
                                                    style="background-color: #c41e3a; color: white; padding: 4px 15px; border-radius: 20px; font-size: 0.9em; text-decoration: line-through; opacity: 0.9;">
                                                    <fmt:formatNumber value="${o.price}"
                                                        pattern="#,##0' VNĐ'" />
                                                </div>
                                                <div class="price-pill"
                                                    style="background-color: #c41e3a; color: white; padding: 6px 20px; border-radius: 20px; font-size: 1.1em; font-weight: bold;">
                                                    <fmt:formatNumber value="${o.salePrice}"
                                                        pattern="#,##0' VNĐ'" />
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <!-- Placeholder to align prices -->
                                                <div
                                                    style="padding: 4px 15px; font-size: 0.9em; visibility: hidden;">
                                                    &nbsp;</div>
                                                <div class="price-pill"
                                                    style="background-color: #c41e3a; color: white; padding: 6px 20px; border-radius: 20px; font-size: 1.1em; font-weight: bold;">
                                                    <fmt:formatNumber value="${o.price}"
                                                        pattern="#,##0' VNĐ'" />
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
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
    <script type="text/javascript"
        src="https://mdbootstrap.com/previews/ecommerce-demo/js/mdb.min.js"></script>
    <!-- MDB Ecommerce JavaScript -->
    <script type="text/javascript"
        src="https://mdbootstrap.com/previews/ecommerce-demo/js/mdb.ecommerce.min.js"></script>
</body>

</html>