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
  <title>Detail Product</title>
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
  <link rel="stylesheet" href="css/product-cards.css"/>
  <meta http-equiv="x-ua-compatible" content="ie=edge">

  <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet"
    id="bootstrap-css">
  <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
  <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

  <style>
    .gallery-wrap .img-big-wrap img {
      height: 450px;
      width: auto;
      display: inline-block;
      cursor: zoom-in;
    }


    .gallery-wrap .img-small-wrap .item-gallery {
      width: 60px;
      height: 60px;
      border: 1px solid #ddd;
      margin: 7px 2px;
      display: inline-block;
      overflow: hidden;
    }

    .gallery-wrap .img-small-wrap {
      text-align: center;
    }

    .gallery-wrap .img-small-wrap img {
      max-width: 100%;
      max-height: 100%;
      object-fit: cover;
      border-radius: 4px;
      cursor: zoom-in;
    }

    .img-big-wrap img {
      width: 100% !important;
      height: auto !important;
    }

    /* New Product Gallery Styles */
    .product-gallery-container {
        border-radius: 15px;
        padding: 15px;
        background-color: #fff;
    }

    .main-image-wrapper {
        text-align: center;
        margin-bottom: 15px;
        height: 450px;
        display: flex;
        align-items: center;
        justify-content: center;
        overflow: hidden;
        border-radius: 10px;
        /* background-color: #f9f9f9; */
         border: 1px solid #eee;
    }

    .main-image-display {
        max-width: 100%;
        max-height: 100%;
        width: auto;
        height: 100%;
        object-fit: contain;
        transition: transform 0.3s ease;
    }

    .thumbnail-list {
        display: flex;
        justify-content: center;
        gap: 10px;
        flex-wrap: wrap;
    }

    .thumbnail-item {
        width: 80px;
        height: 80px;
        border: 2px solid #eee;
        border-radius: 10px;
        cursor: pointer;
        overflow: hidden;
        transition: all 0.3s ease;
    }

    .thumbnail-item:hover {
        border-color: #c41e3a;
        transform: scale(1.05);
    }

    .thumbnail-item.active {
        border-color: #da1919;
        box-shadow: 0 0 10px rgba(218, 25, 25, 0.4);
    }

    .thumbnail-img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        border-radius: 8px;
    }

    /* Breadcrumb Styles */
    .breadcrumb-container {
        background-color: #f8f9fa;
        border-radius: 8px;
    }
    .breadcrumb {
        background-color: transparent;
        padding: .75rem 1rem;
        margin-bottom: 0;
    }
    .breadcrumb-item a {
        color: #da1919;
        font-weight: 500;
        transition: color 0.3s ease;
    }
    .breadcrumb-item a:hover {
        color: #c41e3a;
        text-decoration: none;
    }
    .breadcrumb-item.active {
        color: #6c757d;
    }
    .breadcrumb-item+.breadcrumb-item::before {
        color: #6c757d;
    }
  </style>
</head>

<body class="skin-light">
  <jsp:include page="Menu.jsp"></jsp:include>

  <div class="container breadcrumb-container my-4">
      <nav aria-label="breadcrumb">
          <ol class="breadcrumb">
              <li class="breadcrumb-item"><a href="home">Home</a></li>
              <c:forEach items="${listC}" var="c">
                  <c:if test="${detail.cateID == c.cid}">
                      <li class="breadcrumb-item"><a href="shop?cid=${c.cid}">${c.cname}</a></li>
                  </c:if>
              </c:forEach>
              <li class="breadcrumb-item active" aria-current="page">${detail.name}</li>
          </ol>
      </nav>
  </div>

  <!--Main layout-->
  <main>
    <div class="container">

      <!--Section: Block Content-->
      <section class="mb-5">

        <div class="row">
          <div class="col-md-6 mb-4 mb-md-0">
             <div class="product-gallery-container">
                <div class="main-image-wrapper">
                    <img id="mainProductImage" src="${detail.image}" alt="${detail.name}" class="main-image-display">
                </div>
                <div class="thumbnail-list">
                    <div class="thumbnail-item active">
                        <img src="${detail.image}" alt="Thumbnail 1" class="thumbnail-img" onclick="changeMainImage(this)">
                    </div>
                    <div class="thumbnail-item">
                        <img src="${detail.image2}" alt="Thumbnail 2" class="thumbnail-img" onclick="changeMainImage(this)">
                    </div>
                    <div class="thumbnail-item">
                        <img src="${detail.image3}" alt="Thumbnail 3" class="thumbnail-img" onclick="changeMainImage(this)">
                    </div>
                    <c:if test="${not empty detail.image4}">
                    <div class="thumbnail-item">
                        <img src="${detail.image4}" alt="Thumbnail 4" class="thumbnail-img" onclick="changeMainImage(this)">
                    </div>
                    </c:if>
                </div>
            </div>
          </div>
          <div class="col-md-6">

            <h5>${detail.name}</h5>
            
            <div class="product-price-section mb-2">
              <c:choose>
                  <c:when test="${detail.discountPercent > 0}">
                      <span class="h4 font-weight-bold text-danger sale-price">
                          <fmt:formatNumber value="${detail.salePrice}" pattern="#,##0" /> VNĐ
                      </span>
                      <span class="text-muted original-price ml-2">
                          <del><fmt:formatNumber value="${detail.price}" pattern="#,##0" /> VNĐ</del>
                      </span>
                      <span class="badge bg-danger text-white ml-2" style="background-color: #c41e3a !important; font-size: 0.9rem; vertical-align: middle;">-${detail.discountPercent}%</span>
                  </c:when>
                  <c:otherwise>
                      <span class="h4 font-weight-bold">
                          <fmt:formatNumber value="${detail.price}" pattern="#,##0" /> VNĐ
                      </span>
                  </c:otherwise>
              </c:choose>
            </div>

            <p class="pt-1"><strong>Thương hiệu:</strong> ${detail.brand}</p>
            <div class="table-responsive">
              <table class="table table-sm table-borderless mb-0">
                <tbody>
                  <tr>
                    <th class="pl-0 w-25" scope="row"><strong>Delivery</strong></th>
                    <td>${detail.delivery }</td>
                  </tr>
                </tbody>
              </table>
            </div>
            <hr>

            <form action="addCart?pid=${detail.id }" method="post">
              <div class="table-responsive mb-2">
                <table class="table table-sm table-borderless">
                  <tbody>
                    <tr>
                      <td class="pl-0 pb-0 w-25">
                        Quantity
                        <c:if test="${remainingQuantity > 0}">
                          <span class="text-success">(<span id="stock-available">${remainingQuantity}</span> sản
                            phẩm có sẵn)</span>
                        </c:if>
                        <c:if test="${remainingQuantity == 0}">
                          <span class="text-danger">(Hết hàng)</span>
                        </c:if>
                      </td>
                    </tr>
                    <tr>
                      <td class="pl-0">
                        <div class="mt-1">
                          <div class="def-number-input number-input safari_only mb-0"
                            style="display: flex; align-items: center;">
                            <button type="button"
                              onclick="this.parentNode.querySelector('input[type=number]').stepDown(); checkQuantity();"
                              class="minus"></button>
                            <input class="quantity" min="0" name="quantity" value="1" type="number"
                              onchange="checkQuantity();" oninput="checkQuantity();">
                            <button type="button"
                              onclick="this.parentNode.querySelector('input[type=number]').stepUp(); checkQuantity();"
                              class="plus"></button>
                          </div>
                          <div id="quantity-warning"
                            style="color: red; font-size: 0.9em; margin-top: 5px; display: none;">
                            Số lượng vượt quá số lượng còn lại trong kho!
                          </div>
                        </div>
                      </td>
                    </tr>
                  </tbody>
                </table>
              </div>
              <div class="mt-1">
                <button type="submit" class="btn btn-primary btn-md mr-1 mb-2">Buy now</button>
                <button type="submit" class="btn btn-light btn-md mr-1 mb-2"><i
                    class="fas fa-shopping-cart pr-2"></i>Add to
                  cart</button>
              </div>
            </form>

          </div>
        </div>

      </section>
      <!--Section: Block Content-->

      <!-- Classic tabs -->
      <div class="classic-tabs">

        <ul class="nav tabs-primary nav-justified" id="advancedTab" role="tablist">
          <li class="nav-item">
            <a class="nav-link active show" id="description-tab" data-toggle="tab" href="#description"
              role="tab" aria-controls="description" aria-selected="true">Description</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" id="reviews-tab" data-toggle="tab" href="#reviews" role="tab"
              aria-controls="reviews" aria-selected="false">Reviews (${countAllReview })</a>
          </li>
        </ul>
        <div class="tab-content" id="advancedTabContent">
          <div class="tab-pane fade show active" id="description" role="tabpanel"
            aria-labelledby="description-tab">
            <p class="pt-1">${detail.description}</p>
          </div>
          <div class="tab-pane fade" id="reviews" role="tabpanel" aria-labelledby="reviews-tab">
            <h5><span>${countAllReview }</span> review for <span>${detail.name }</span></h5>

            <h5 class="mt-4">Add a review</h5>
            <p></p>

            <div>
              <!-- Your review -->
              <div class="md-form md-outline">
                <textarea id="form76" class="md-textarea form-control pr-6" rows="4"></textarea>
                <label for="form76">Your review</label>
              </div>
              <div class="text-right pb-2">
                <button type="button" class="btn btn-primary" onclick="addReview('${detail.id}')">Add a
                  review</button>
              </div>
            </div>



            <c:forEach items="${listAllReview}" var="r">

              <div class="media mt-3 mb-4">
                <img class="d-flex mr-3 z-depth-1"
                  src="https://mdbootstrap.com/img/Photos/Others/placeholder1.jpg" width="62"
                  alt="Generic placeholder image">
                <div class="media-body">
                  <div class="d-flex justify-content-between">
                    <p class="mt-1 mb-2">
                      <c:forEach items="${listAllAcount}" var="a">
                        <c:if test="${r.accountID == a.id }">
                          <strong>${a.user } </strong>
                        </c:if>
                      </c:forEach>
                      <span>– </span><span>${r.dateReview }</span>
                    </p>
                  </div>
                  <p class="mb-0">${r.contentReview }</p>
                </div>
              </div>
              <hr>

            </c:forEach>


          </div>



        </div>

      </div>
      <!-- Classic tabs -->

      <hr>

      <!--Section: Block Content-->
      <section class="text-center">

        <h4 class="text-center my-5"><strong>Related products</strong></h4>

        <!-- Grid row -->
        <div class="row">

          <c:forEach items="${listRelatedProduct}" var="o">
            <!-- Grid column -->
            <div class="col-md-6 col-lg-3 mb-5 product-card-container">

              <!-- Card -->
              <div class="product-card h-100">

                <div class="product-image-container">
                  <img class="product-image" src="${o.image }" alt="${o.name}">
                  <a href="detail?pid=${o.id}">
                      <div class="quick-view-overlay">
                          <button class="quick-view-btn" onclick="window.location.href='detail?pid=${o.id}'; event.preventDefault();">
                              <i class="fas fa-eye mr-2"></i>Xem chi tiết
                          </button>
                      </div>
                  </a>
                </div>

                <div class="product-card-body">
                  <h4 class="product-title">
                      <a href="detail?pid=${o.id}" title="View Product">${o.name}</a>
                  </h4>
                   <p class="product-description">${o.brand}</p>
                   <div class="product-price-section" style="display: flex; flex-direction: column; align-items: center; gap: 4px;">
                      <c:choose>
                        <c:when test="${o.discountPercent > 0}">
                            <div class="original-price-wrapper">
                                <span class="product-price original-price" style="color: rgba(255, 255, 255, 0.75); font-size: 0.9em; text-decoration: line-through;">
                                    <fmt:formatNumber value="${o.price}" pattern="#,##0" /> VNĐ
                                </span>
                            </div>
                            <div class="sale-price-wrapper">
                                <span class="product-price sale-price" style="color: white; font-weight: bold; font-size: 1.1em;">
                                    <fmt:formatNumber value="${o.salePrice}" pattern="#,##0" /> VNĐ
                                </span>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="price-wrapper">
                                <span class="product-price" style="color: white; font-weight: bold; font-size: 1.1em;">
                                  <fmt:formatNumber value="${o.price}" pattern="#,###"/> VNĐ
                                </span>
                            </div>
                        </c:otherwise>
                    </c:choose>
                  </div>
                </div>

              </div>
              <!-- Card -->

            </div>
            <!-- Grid column -->
          </c:forEach>

        </div>
        <!-- Grid row -->

      </section>
      <!--Section: Block Content-->

    </div>
  </main>
  <!--Main layout-->




  <jsp:include page="Footer.jsp"></jsp:include>
  <script>
    window.addEventListener("load", function loadAmountCart() {
      $.ajax({
        url: "/WebsiteBanSua/loadAllAmountCart",
        type: "get", //send it through get method
        data: {

        },
        success: function (responseData) {
          document.getElementById("amountCart").innerHTML = responseData;
        }
      });
    }, false);

    function addReview(pID) {
      var cntReview = document.getElementById("form76").value;
      $.ajax({
        url: "/WebsiteBanSua/addReview",
        type: "get", //send it through get method
        data: {
          productID: pID,
          contentReview: cntReview
        },
        success: function (data) {
          var row = document.getElementById("reviews");
          row.innerHTML += data;
        },
        error: function (xhr) {
          //Do Something to handle error
        }
      });
    }

    function changeMainImage(thumbnailElement) {
        // Get the source of the clicked thumbnail
        const newImageSrc = thumbnailElement.src;

        // Set the main image source
        document.getElementById('mainProductImage').src = newImageSrc;

        // Update the active state for thumbnails
        document.querySelectorAll('.thumbnail-item').forEach(item => {
            item.classList.remove('active');
        });
        thumbnailElement.parentElement.classList.add('active');
    }

    function checkQuantity() {
      var maxQty = parseInt(document.getElementById("stock-available") ? document.getElementById("stock-available").textContent : "0");
      var currentQty = parseInt(document.querySelector("input[name='quantity']").value);
      var warningElement = document.getElementById("quantity-warning");
      var buyButtons = document.querySelectorAll("button[type='submit']");

      if (currentQty > maxQty && maxQty > 0) {
        warningElement.style.display = "block";
        // Disable các nút mua hàng
        buyButtons.forEach(function (button) {
          button.disabled = true;
        });
      } else {
        warningElement.style.display = "none";
        // Enable các nút mua hàng
        buyButtons.forEach(function (button) {
          button.disabled = false;
        });
      }
    }

    // Kiểm tra khi trang được tải
    document.addEventListener("DOMContentLoaded", function () {
      checkQuantity();
    });
  </script>
  <!-- SCRIPTS -->
  <!-- JQuery -->
  <script src="../../../js/jquery-3.4.1.min.js"></script>
  <!-- Bootstrap tooltips -->
  <script type="text/javascript"
    src="https://mdbootstrap.com/previews/ecommerce-demo/js/popper.min.js"></script>
  <!-- Bootstrap core JavaScript -->
  <script type="text/javascript" src="https://mdbootstrap.com/previews/ecommerce-demo/js/bootstrap.js"></script>
  <!-- MDB core JavaScript -->
  <script type="text/javascript" src="https://mdbootstrap.com/previews/ecommerce-demo/js/mdb.min.js"></script>
  <!-- MDB Ecommerce JavaScript -->
  <script type="text/javascript"
    src="https://mdbootstrap.com/previews/ecommerce-demo/js/mdb.ecommerce.min.js"></script>
  <script>
    $(document).ready(function () {
      // MDB Lightbox Init
      $(function () {
        $("#mdb-lightbox-ui").load("../../../mdb-addons/mdb-lightbox-ui.html");
      });
    });
  </script>
</body>

</html>