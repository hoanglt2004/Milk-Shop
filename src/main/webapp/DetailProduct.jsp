<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
      <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <!DOCTYPE html>
        <html>

        <head>
          <meta charset="utf-8">
          <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
          <meta http-equiv="x-ua-compatible" content="ie=edge">
          <title>Detail Product</title>
          
          <!-- Font Awesome -->
          <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
          <!-- Google Fonts Roboto -->
          <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap" />
          <!-- MDB -->
          <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/7.2.0/mdb.min.css" />
          
          <!-- Custom styles -->
          <link href="css/style.css" rel="stylesheet" type="text/css" />
          <link href="css/product-cards.css" rel="stylesheet" type="text/css"/>

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

            /* Product Form Styles */
            .product-form {
                padding: 20px 0;
            }

            .quantity-label {
                font-weight: 500;
                color: #333;
                font-size: 1rem;
            }

            .quantity-control {
                margin: 15px 0;
            }

            /* Quantity Input Styles */
            .def-number-input {
                border: 1px solid #e0e0e0;
                border-radius: 8px;
                overflow: hidden;
                width: fit-content;
                background: #fff;
            }

            .def-number-input .quantity {
                width: 80px;
                min-width: 80px;
                border: none;
                text-align: center;
                font-size: 1rem;
                padding: 8px;
                color: #333;
                -moz-appearance: textfield;
            }

            .def-number-input .quantity::-webkit-outer-spin-button,
            .def-number-input .quantity::-webkit-inner-spin-button {
                -webkit-appearance: none;
                margin: 0;
            }

            .quantity-btn {
                width: 40px;
                height: 40px;
                background-color: #f8f9fa;
                border: none;
                color: #333;
                font-size: 1.2rem;
                cursor: pointer;
                transition: background-color 0.2s;
            }

            .quantity-btn:hover {
                background-color: #e9ecef;
            }

            .quantity-btn.minus::before {
                content: "-";
            }

            .quantity-btn.plus::before {
                content: "+";
            }

            /* Action Buttons */
            .action-buttons {
                display: flex;
                gap: 15px;
                flex-wrap: wrap;
            }

            .buy-now-btn {
                min-width: 160px;
                background-color: #c41e3a;
                border: none;
                text-transform: uppercase;
                font-weight: 500;
                letter-spacing: 0.5px;
                transition: all 0.3s ease;
            }

            .buy-now-btn:hover {
                background-color: #a01830;
                transform: translateY(-2px);
                box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            }

            .add-to-cart-btn {
                min-width: 160px;
                background-color: #fff;
                border: 2px solid #c41e3a;
                color: #c41e3a;
                text-transform: uppercase;
                font-weight: 500;
                letter-spacing: 0.5px;
                transition: all 0.3s ease;
            }

            .add-to-cart-btn:hover {
                background-color: #f8f9fa;
                color: #a01830;
                border-color: #a01830;
                transform: translateY(-2px);
                box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            }

            /* Responsive adjustments */
            @media (max-width: 576px) {
                .action-buttons {
                    flex-direction: column;
                }
                
                .buy-now-btn,
                .add-to-cart-btn {
                    width: 100%;
                }
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

                    <form id="productForm" class="product-form">
                      <div class="table-responsive mb-2">
                        <table class="table table-sm table-borderless">
                          <tbody>
                            <tr>
                              <td class="pl-0 pb-0 w-25">
                                <label class="quantity-label">
                                  Quantity
                                  <c:if test="${remainingQuantity > 0}">
                                    <span class="text-success">(<span id="stock-available">${remainingQuantity}</span> sản
                                      phẩm có sẵn)</span>
                                  </c:if>
                                  <c:if test="${remainingQuantity == 0}">
                                    <span class="text-danger">(Hết hàng)</span>
                                  </c:if>
                                </label>
                              </td>
                            </tr>
                            <tr>
                              <td class="pl-0">
                                <div class="quantity-control mt-1">
                                  <div class="def-number-input number-input safari_only"
                                    style="display: flex; align-items: center;">
                                    <button type="button"
                                      onclick="this.parentNode.querySelector('input[type=number]').stepDown(); checkQuantity();"
                                      class="minus quantity-btn"></button>
                                    <input class="quantity" min="0" name="quantity" value="1" type="number"
                                      onchange="checkQuantity();" oninput="checkQuantity();">
                                    <button type="button"
                                      onclick="this.parentNode.querySelector('input[type=number]').stepUp(); checkQuantity();"
                                      class="plus quantity-btn"></button>
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
                      <div class="action-buttons mt-3">
                        <button type="button" class="btn btn-primary btn-lg buy-now-btn" onclick="addToCartAndRedirect('buy')">
                          <i class="fas fa-bolt me-2"></i>Mua ngay
                        </button>
                        <button type="button" class="btn btn-light btn-lg add-to-cart-btn" onclick="addToCartAndRedirect('cart')">
                          <i class="fas fa-shopping-cart me-2"></i>Thêm vào giỏ
                        </button>
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
                    <div class="col-md-6 col-lg-3 mb-4">
                      <div class="card h-100 product-card d-flex flex-column">
                        <div class="bg-image hover-overlay ripple product-image-container" data-mdb-ripple-color="light">
                          <img class="img-fluid w-100 product-image" src="${o.image}" alt="${o.name}">
                          <a href="detail?pid=${o.id}">
                            <div class="mask" style="background-color: rgba(251, 251, 251, 0.15);"></div>
                          </a>
                          <c:if test="${o.discountPercent > 0}">
                            <div class="product-badge sale-badge">-${o.discountPercent}%</div>
                          </c:if>
                        </div>

                        <div class="card-body product-card-body d-flex flex-column">
                          <div class="flex-grow-1">
                            <h5 class="card-title product-title" style="min-height: 48px;">
                              <a href="detail?pid=${o.id}" title="View Product">${o.name}</a>
                            </h5>
                            <p class="text-muted product-description" style="min-height: 24px;">${o.brand}</p>
                            <div class="product-rating">
                              <div class="stars text-warning">
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                              </div>
                              <span class="rating-text">(5.0)</span>
                            </div>
                          </div>

                          <div class="mt-auto">
                            <div class="d-flex justify-content-between align-items-center">
                              <div class="product-price">
                                <c:choose>
                                  <c:when test="${o.discountPercent > 0}">
                                    <p class="text-muted mb-0" style="text-decoration: line-through;">
                                      <fmt:formatNumber value="${o.price}" pattern="#,##0' VNĐ'" />
                                    </p>
                                    <h6 class="mb-0 font-weight-bold text-danger">
                                      <fmt:formatNumber value="${o.salePrice}" pattern="#,##0' VNĐ'" />
                                    </h6>
                                  </c:when>
                                  <c:otherwise>
                                    <h6 class="mb-0 font-weight-bold text-danger">
                                      <fmt:formatNumber value="${o.price}" pattern="#,##0' VNĐ'" />
                                    </h6>
                                  </c:otherwise>
                                </c:choose>
                              </div>
                              <a href="detail?pid=${o.id}" class="btn btn-primary btn-rounded btn-sm">
                                <i class="fas fa-eye me-2"></i>Xem
                              </a>
                            </div>
                          </div>
                        </div>
                      </div>
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
          
          <!-- jQuery -->
          <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
          
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

            function addToCartAndRedirect(action) {
              console.log('addToCartAndRedirect called with action:', action);
              
              // Prevent multiple clicks
              const buttons = document.querySelectorAll('.buy-now-btn, .add-to-cart-btn');
              buttons.forEach(button => button.disabled = true);
              
              // Get quantity
              const quantity = document.querySelector('input[name="quantity"]').value;
              console.log('Quantity:', quantity, 'Product ID:', '${detail.id}');
              
              // Add to cart via AJAX
              $.ajax({
                url: "/WebsiteBanSua/addCart",
                type: "post",
                data: {
                  pid: '${detail.id}',
                  quantity: quantity
                },
                success: function(response) {
                  console.log('Cart added successfully:', response);
                  
                  // Try to parse as JSON first, if it fails, treat as plain text
                  let success = true;
                  try {
                    const jsonResponse = JSON.parse(response);
                    success = jsonResponse.success;
                    console.log('Parsed JSON response:', jsonResponse);
                  } catch (e) {
                    // If not JSON, assume success
                    success = true;
                    console.log('Response is not JSON, treating as success');
                  }
                  
                  if (success) {
                    console.log('Updating cart count...');
                    // Update cart count first with a small delay
                    setTimeout(function() {
                      loadAmountCart();
                    }, 100);
                    
                    // Redirect to cart page after a short delay
                    console.log('Redirecting to cart page...');
                    setTimeout(function() {
                      window.location.href = "/WebsiteBanSua/managerCart";
                    }, 300);
                  } else {
                    alert('Có lỗi xảy ra khi thêm vào giỏ hàng. Vui lòng thử lại!');
                    buttons.forEach(button => button.disabled = false);
                  }
                },
                error: function(xhr, status, error) {
                  console.error('Error adding to cart:', xhr, status, error);
                  alert('Có lỗi xảy ra khi thêm vào giỏ hàng. Vui lòng thử lại!');
                  
                  // Re-enable buttons on error
                  buttons.forEach(button => button.disabled = false);
                }
              });
            }

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
              var buyButtons = document.querySelectorAll('.buy-now-btn, .add-to-cart-btn');

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
          <!-- MDB -->
          <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/7.2.0/mdb.min.js"></script>
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