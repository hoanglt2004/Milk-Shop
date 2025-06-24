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
          <!-- Roboto Font -->
          <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:100,300,400,500,700&display=swap">
          <!-- Font Awesome -->
          <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.11.2/css/all.css">
          <!-- Bootstrap core CSS -->
          <link rel="stylesheet" href="https://mdbootstrap.com/previews/ecommerce-demo/css/bootstrap.min.css">
          <!-- Material Design Bootstrap -->
          <link rel="stylesheet" href="https://mdbootstrap.com/previews/ecommerce-demo/css/mdb-pro.min.css">
          <!-- Material Design Bootstrap Ecommerce -->
          <link rel="stylesheet" href="https://mdbootstrap.com/previews/ecommerce-demo/css/mdb.ecommerce.min.css">
          <!-- Your custom styles (optional) -->

          <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet"
            id="bootstrap-css">
          <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
          <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
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
          </style>
        </head>

        <body class="skin-light">
          <jsp:include page="Menu.jsp"></jsp:include>

          <div class="jumbotron color-grey-light mt-70">
            <div class="d-flex align-items-center h-100">
              <div class="container text-center py-5">
                <h3 class="mb-0"></h3>
              </div>
            </div>
          </div>

          <!--Main Navigation-->

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

                    <p>
                      <span class="mr-1"><strong>
                          <fmt:formatNumber value="${detail.price}" pattern="#,###" var="currentPrice" />
                          ${fn:replace(currentPrice, ',', '.')} VNĐ
                        </strong></span>
                    </p>


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
                           <p class="product-description">${o.title}</p>
                           <div class="product-price-section">
                              <a href="detail?pid=${o.id}" class="product-price">
                                  <fmt:formatNumber value="${o.price}" pattern="#,###" var="relatedCurrentPrice" />
                                  ${fn:replace(relatedCurrentPrice, ',', '.')} VNĐ
                              </a>
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