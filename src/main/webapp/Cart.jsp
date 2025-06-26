<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Giỏ Hàng - Shopping Cart</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <style>
            .btnSub, .btnAdd {
                background: #da1919;
                color: white;
                border: none;
                padding: 5px 10px;
                border-radius: 3px;
                margin: 0 5px;
                cursor: pointer;
                transition: background 0.3s;
            }
            .btnSub:hover, .btnAdd:hover {
                background: #c41e3a;
            }
            .stock-warning {
                animation: blink 1s infinite;
            }
            @keyframes blink {
                50% { opacity: 0.5; }
            }
            .cart-quantity {
                font-weight: bold;
                color: #da1919;
                margin: 0 10px;
            }
            .low-stock-row {
                background-color: #fff3cd !important;
            }
            .out-of-stock-row {
                background-color: #f8d7da !important;
            }
        </style>
    </head>

    <body onload="loadTotalMoney()">
        <jsp:include page="Menu.jsp"></jsp:include>
        
        <!-- Guest User Notification -->
        <c:if test="${isGuest}">
            <div class="container mt-3">
                <div class="alert alert-warning alert-dismissible fade show" role="alert">
                    <i class="fas fa-info-circle mr-2"></i>
                    <strong>Lưu ý:</strong> Bạn đang xem giỏ hàng ở chế độ khách. 
                    <a href="login" class="alert-link">Đăng nhập</a> để lưu giỏ hàng và tiếp tục mua sắm.
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
            </div>
        </c:if>
        
        <div class="shopping-cart">
            <div class="px-4 px-lg-0">

                <div class="pb-5">
                    <div class="container">
                        <div class="row">
                            <div class="col-lg-12 p-5 bg-white rounded shadow-sm mb-5">

                                <!-- Shopping cart table -->
                                <div class="table-responsive">
                                    <table class="table">
                                        <thead>
                                        <c:if test="${error!=null }">
                     <div class="alert alert-danger" role="alert">
							 ${error}
					</div>
					</c:if>
					<c:if test="${mess!=null }">
                    <div class="alert alert-success" role="alert">
					  	${mess}
					</div>
					</c:if>
                                            <tr>
                                                <th scope="col" class="border-0 bg-light">
                                                    <div class="p-2 px-3 text-uppercase">Sản Phẩm</div>
                                                </th>
                                                <th scope="col" class="border-0 bg-light">
                                                    <div class="py-2 text-uppercase">Đơn Giá</div>
                                                </th>
                                                 <th scope="col" class="border-0 bg-light">
                                                    <div class="py-2 text-uppercase">Delivery</div>
                                                </th>
                                                <th scope="col" class="border-0 bg-light">
                                                    <div class="py-2 text-uppercase">Số Lượng</div>
                                                </th>
                                                <th scope="col" class="border-0 bg-light">
                                                    <div class="py-2 text-uppercase">Tồn Kho</div>
                                                </th>
                                                <th scope="col" class="border-0 bg-light">
                                                    <div class="py-2 text-uppercase">Xóa</div>
                                                </th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${listCart}" var="o">
                                         <c:forEach items="${listProduct}" var="p">
                                            <c:if test="${o.productID == p.id}">
                                            <c:set var="rowClass" value="" />
                                            <c:forEach items="${listProductStock}" var="ps">
                                                <c:if test="${ps.productID == p.id}">
                                                    <c:choose>
                                                        <c:when test="${ps.totalRemaining <= 0}">
                                                            <c:set var="rowClass" value="out-of-stock-row" />
                                                        </c:when>
                                                        <c:when test="${ps.totalRemaining < o.amount}">
                                                            <c:set var="rowClass" value="out-of-stock-row" />
                                                        </c:when>
                                                        <c:when test="${ps.totalRemaining <= 5}">
                                                            <c:set var="rowClass" value="low-stock-row" />
                                                        </c:when>
                                                    </c:choose>
                                                </c:if>
                                            </c:forEach>
                                            <tr class="${rowClass}">
                                                <th scope="row">
                                                    <div class="p-2">
                                                    
                                                        <img src="${p.image}" alt="" width="70" class="img-fluid rounded shadow-sm">
                                                      
                                                        <div class="ml-3 d-inline-block align-middle">
                                                            <h5 class="mb-0"> <a href="#" class="text-dark d-inline-block">${p.name}</a></h5><span class="text-muted font-weight-normal font-italic"></span>
                                                        </div>
                                                    </div>
                                                </th>
                                                <td class="align-middle">
                                                    <strong>
                                                        <fmt:formatNumber value="${p.price}" pattern="#,###" var="cartPrice"/>
                                                        ${fn:replace(cartPrice, ',', '.')} VNĐ
                                                    </strong>
                                                </td>
                                                <td class="align-middle"><strong>${p.delivery}</strong></td>
                                                <td class="align-middle">
                                                    <a href="subAmountCart?productID=${o.productID}&amount=${o.amount}"><button class="btnSub">-</button></a> 
                                                    <span class="cart-quantity">${o.amount}</span>
                                                    <a href="addAmountCart?productID=${o.productID}&amount=${o.amount}"><button class="btnAdd">+</button></a>
                                                </td>
                                                <td class="align-middle">
                                                    <c:set var="stockFound" value="false" />
                                                    <c:forEach items="${listProductStock}" var="ps">
                                                        <c:if test="${ps.productID == p.id && !stockFound}">
                                                            <c:set var="stockFound" value="true" />
                                                            <c:choose>
                                                                <c:when test="${ps.totalRemaining <= 0}">
                                                                    <span class="badge badge-danger">Hết hàng</span>
                                                                </c:when>
                                                                <c:when test="${ps.totalRemaining <= 5}">
                                                                    <span class="badge badge-warning">${ps.totalRemaining} (Sắp hết)</span>
                                                                </c:when>
                                                                <c:when test="${ps.totalRemaining < o.amount}">
                                                                    <span class="badge badge-danger">${ps.totalRemaining} (Không đủ)</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="badge badge-success">${ps.totalRemaining}</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </c:if>
                                                    </c:forEach>
                                                    <c:if test="${!stockFound}">
                                                        <span class="badge badge-secondary">Chưa nhập kho</span>
                                                    </c:if>
                                                </td>
                                                <td class="align-middle"><a href="deleteCart?productID=${o.productID }" class="text-dark">
                                                        <button type="button" class="btn btn-danger">Delete</button>
                                                    </a>
                                                </td>
                                            </tr> 
                                             </c:if>
                                           </c:forEach>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                                <!-- End -->
                            </div>
                        </div>

                        <div class="row py-5 p-4 bg-white rounded shadow-sm">
                           
                            <div class="col-lg-6">
                                <div class="bg-light rounded-pill px-4 py-3 text-uppercase font-weight-bold">Thành tiền</div>
    
                                <div class="p-4">
                                    <ul class="list-unstyled mb-4" id="contentTotalMoney">
                                       <!--  <li class="d-flex justify-content-between py-3 border-bottom"><strong class="text-muted">Tổng tiền hàng</strong><strong>100 $</strong></li>
                                        <li class="d-flex justify-content-between py-3 border-bottom"><strong class="text-muted">Phí vận chuyển</strong><strong>Free ship</strong></li>
                                        <li class="d-flex justify-content-between py-3 border-bottom"><strong class="text-muted">VAT</strong><strong>10 $</strong></li>
                                        <li class="d-flex justify-content-between py-3 border-bottom"><strong class="text-muted">Tổng thanh toán</strong>
                                            <h5 class="font-weight-bold">110 $</h5>
                                        </li> -->
                                    </ul><a href="order" class="btn btn-dark rounded-pill py-2 btn-block text-white">Thanh Toán</a>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
        </div>
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script>
                        function loadTotalMoney(){
                        	 $.ajax({
                                 url: "/WebsiteBanSua/totalMoneyCart",
                                 type: "get",
                                 success: function (responseData) {
                                     document.getElementById("contentTotalMoney").innerHTML = responseData;
                                 }
                             });
                        }
                        
                        // Gọi hàm loadTotalMoney khi trang được tải
                        $(document).ready(function() {
                            loadTotalMoney();
                        });
                        
                        // Gọi lại loadTotalMoney sau mỗi thao tác với giỏ hàng
                        function updateCart() {
                            loadTotalMoney();
                        }
                        
                        // Thêm hàm để kiểm tra và cập nhật giỏ hàng sau khi đăng nhập
                        function checkAndUpdateCart() {
                            loadTotalMoney();
                        }
                        
                        // Gọi hàm kiểm tra khi trang được tải
                        window.onload = function() {
                            checkAndUpdateCart();
                        };
                        </script>
    </body>

</html>
