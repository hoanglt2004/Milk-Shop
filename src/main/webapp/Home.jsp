<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
        <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
            <%@page contentType="text/html" pageEncoding="UTF-8" %>
                <!DOCTYPE html>
                <html>

                <head>
                    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
                    <title>Home Page</title>
                    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

                    <!-- Font Awesome -->
                    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
                    <!-- Google Fonts Roboto -->
                    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap" />
                    <!-- MDB -->
                    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/7.2.0/mdb.min.css" />

                    <!-- Custom styles -->
                    <link href="css/style.css" rel="stylesheet" type="text/css" />
                    <link href="css/categories.css" rel="stylesheet" type="text/css" />
                    <link href="css/product-cards.css" rel="stylesheet" type="text/css" />
                    
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

                        /* Product Badge Styling */
                        .product-badge {
                            position: absolute;
                            padding: 6px 12px;
                            font-size: 0.85rem;
                            font-weight: 600;
                            letter-spacing: 0.5px;
                            border-radius: 4px;
                            z-index: 2;
                            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
                        }

                        .sale-badge {
                            top: 10px;
                            left: 10px;
                            background: linear-gradient(45deg, #ff6b6b, #c41e3a);
                            color: white;
                        }

                        .new-badge {
                            top: 10px;
                            right: 10px;
                            background: linear-gradient(45deg, #20bf6b, #0b8a45);
                            color: white;
                            animation: badgePulse 2s infinite;
                        }

                        @keyframes badgePulse {
                            0% {
                                transform: scale(1);
                            }
                            50% {
                                transform: scale(1.05);
                            }
                            100% {
                                transform: scale(1);
                            }
                        }

                        /* Hover effect for badges */
                        .product-card:hover .product-badge {
                            transform: translateY(-2px);
                            box-shadow: 0 4px 8px rgba(0,0,0,0.15);
                            transition: all 0.3s ease;
                        }

                        /* Responsive adjustments for badges */
                        @media (max-width: 768px) {
                            .product-badge {
                                padding: 4px 8px;
                                font-size: 0.75rem;
                            }
                        }

                        /* Product Card Enhanced Styling */
                        .product-card {
                            border: none;
                            border-radius: 15px;
                            overflow: hidden;
                            transition: all 0.3s ease;
                            background: white;
                            box-shadow: 0 2px 15px rgba(0, 0, 0, 0.1);
                            height: 100%;
                        }

                        .product-card:hover {
                            transform: translateY(-5px);
                            box-shadow: 0 5px 20px rgba(196, 30, 58, 0.15);
                        }

                        .product-image-container {
                            position: relative;
                            padding-top: 100%;
                            overflow: hidden;
                            background: #f8f9fa;
                        }

                        .product-image {
                            position: absolute;
                            top: 0;
                            left: 0;
                            width: 100%;
                            height: 100%;
                            object-fit: cover;
                            transition: transform 0.5s ease;
                        }

                        .product-card:hover .product-image {
                            transform: scale(1.05);
                        }

                        .product-card-body {
                            padding: 1.5rem;
                            display: flex;
                            flex-direction: column;
                            gap: 0.75rem;
                        }

                        .product-title {
                            font-size: 1rem;
                            font-weight: 600;
                            line-height: 1.4;
                            height: 2.8em;
                            overflow: hidden;
                            display: -webkit-box;
                            -webkit-line-clamp: 2;
                            -webkit-box-orient: vertical;
                            margin: 0;
                        }

                        .product-title a {
                            color: #333;
                            text-decoration: none;
                            transition: color 0.3s ease;
                        }

                        .product-title a:hover {
                            color: #c41e3a;
                        }

                        .product-brand {
                            font-size: 0.9rem;
                            color: #6c757d;
                            margin: 0;
                        }

                        .product-rating {
                            display: flex;
                            align-items: center;
                            gap: 0.5rem;
                        }

                        .stars {
                            color: #ffc107;
                            display: flex;
                            gap: 2px;
                        }

                        .rating-text {
                            color: #6c757d;
                            font-size: 0.85rem;
                        }

                        .product-price {
                            padding: 0.75rem 0;
                            border-top: 1px solid #eee;
                            border-bottom: 1px solid #eee;
                            margin: 0.5rem 0;
                            min-height: 80px;
                            display: flex;
                            flex-direction: column;
                            justify-content: center;
                        }

                        .original-price {
                            text-decoration: line-through;
                            color: #6c757d;
                            font-size: 0.9rem;
                            margin: 0;
                            order: 2;
                            margin-top: 4px;
                        }

                        .sale-price {
                            color: #c41e3a;
                            font-weight: 700;
                            font-size: 1.25rem;
                            margin: 0;
                            order: 1;
                        }

                        .btn-cart {
                            width: 100%;
                            padding: 0.8rem;
                            color: white;
                            background-color: #c41e3a;
                            border: none;
                            border-radius: 8px;
                            transition: all 0.3s ease;
                            font-weight: 500;
                            display: flex;
                            align-items: center;
                            justify-content: center;
                            gap: 0.5rem;
                            margin-top: auto;
                            cursor: pointer;
                        }

                        .btn-cart:hover {
                            background-color: #a01830;
                            transform: translateY(-2px);
                            box-shadow: 0 4px 8px rgba(196, 30, 58, 0.2);
                        }

                        .btn-cart:active {
                            transform: translateY(0);
                        }

                        .btn-cart i {
                            font-size: 1.1rem;
                        }

                        .btn-cart.loading {
                            opacity: 0.7;
                            cursor: not-allowed;
                        }

                        .btn-cart.loading:after {
                            content: "";
                            width: 16px;
                            height: 16px;
                            border: 2px solid #ffffff;
                            border-top: 2px solid transparent;
                            border-radius: 50%;
                            animation: spin 0.8s linear infinite;
                            margin-left: 8px;
                        }

                        @keyframes spin {
                            0% { transform: rotate(0deg); }
                            100% { transform: rotate(360deg); }
                        }

                        /* Toast Notification */
                        .toast-container {
                            position: fixed;
                            bottom: 20px;
                            right: 20px;
                            z-index: 1000;
                        }

                        .toast {
                            background: white;
                            color: #333;
                            padding: 15px 25px;
                            border-radius: 8px;
                            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
                            margin-top: 10px;
                            display: flex;
                            align-items: center;
                            animation: slideIn 0.3s ease;
                        }

                        .toast.success {
                            border-left: 4px solid #28a745;
                        }

                        .toast.error {
                            border-left: 4px solid #dc3545;
                        }

                        @keyframes slideIn {
                            from {
                                transform: translateX(100%);
                                opacity: 0;
                            }
                            to {
                                transform: translateX(0);
                                opacity: 1;
                            }
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
                                        <div class="col-12 col-md-6 col-lg-3 mb-4">
                                            <div class="card h-100 product-card d-flex flex-column">
                                                <div class="bg-image hover-overlay ripple product-image-container" data-mdb-ripple-color="light">
                                                    <img class="img-fluid w-100 product-image" src="${o.image}" alt="${o.name}">
                                                    <a href="detail?pid=${o.id}">
                                                        <div class="mask" style="background-color: rgba(251, 251, 251, 0.15);"></div>
                                                    </a>
                                                    <c:if test="${o.discountPercent > 0}">
                                                        <div class="product-badge sale-badge">-${o.discountPercent}%
                                                        </div>
                                                    </c:if>
                                                    <div class="product-badge new-badge">Mới</div>
                                                </div>

                                                <div class="card-body product-card-body">
                                                    <h5 class="product-title">
                                                        <a href="detail?pid=${o.id}" title="View Product">${o.name}</a>
                                                    </h5>
                                                    <p class="product-brand">${o.brand}</p>
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
                                                    <div class="product-price">
                                                        <c:choose>
                                                            <c:when test="${o.discountPercent > 0}">
                                                                <p class="sale-price">
                                                                    <fmt:formatNumber value="${o.salePrice}"
                                                                        pattern="#,##0' VNĐ'" />
                                                                </p>
                                                                <p class="original-price">
                                                                    <fmt:formatNumber value="${o.price}"
                                                                        pattern="#,##0' VNĐ'" />
                                                                </p>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <p class="sale-price">
                                                                    <fmt:formatNumber value="${o.price}"
                                                                        pattern="#,##0' VNĐ'" />
                                                                </p>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                    <button onclick="addToCart(${o.id}, this)" class="btn-cart">
                                                        <i class="fas fa-shopping-cart"></i>
                                                        Thêm vào giỏ
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Toast Notification Container -->
                    <div class="toast-container"></div>

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

                        function addToCart(productId, button) {
                            // Prevent multiple clicks
                            if (button.disabled) {
                                return;
                            }

                            // Disable button and show loading state
                            button.disabled = true;
                            button.classList.add('loading');

                            $.ajax({
                                url: "/WebsiteBanSua/addCart",
                                type: "post",
                                data: {
                                    pid: productId,
                                    quantity: 1
                                },
                                success: function(response) {
                                    // Update cart count
                                    loadAmountCart();
                                    
                                    // Show success toast
                                    showToast('success', 'Đã thêm sản phẩm vào giỏ hàng!');
                                },
                                error: function(xhr) {
                                    // Show error toast
                                    showToast('error', 'Có lỗi xảy ra. Vui lòng thử lại!');
                                },
                                complete: function() {
                                    // Always reset button state after request completes
                                    setTimeout(() => {
                                        button.disabled = false;
                                        button.classList.remove('loading');
                                    }, 500);
                                }
                            });
                        }

                        function showToast(type, message) {
                            // Remove existing toasts
                            const existingToasts = document.querySelectorAll('.toast');
                            existingToasts.forEach(toast => toast.remove());

                            // Create and show new toast
                            const toastContainer = document.querySelector('.toast-container');
                            if (!toastContainer) return;

                            const toast = document.createElement('div');
                            toast.className = `toast ${type}`;
                            toast.innerHTML = message;
                            
                            toastContainer.appendChild(toast);
                            
                            // Auto remove toast after 3 seconds
                            setTimeout(() => {
                                toast.style.opacity = '0';
                                setTimeout(() => {
                                    toast.remove();
                                }, 300);
                            }, 3000);
                        }
                    </script>

                    <!-- jQuery -->
                    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
                    <!-- Bootstrap core JavaScript -->
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>
                    <!-- MDB -->
                    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/7.2.0/mdb.min.js"></script>
                    <!-- Custom scripts -->
                    <script type="text/javascript" src="js/script.js"></script>
                    <!-- Product Cards Enhancement -->
                    <script type="text/javascript" src="js/product-cards.js"></script>

                </body>

                </html>