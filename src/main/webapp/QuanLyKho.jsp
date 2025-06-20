<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Quản Lý Kho</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Varela+Round">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link href="css/manager.css" rel="stylesheet" type="text/css"/>
    <style>
        /* Add any specific styles for this page here */
        .product-stock-table {
             margin-top: 30px;
        }
         .product-stock-table h3 {
             margin-bottom: 15px;
         }
    </style>
</head>
<body>
    <c:set var="currentPage" value="quanLyKho" />
    <div class="container-fluid">
        <div class="row">
            <jsp:include page="LeftAdmin.jsp"/>
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 main-content">
                <div class="container pt-4">
                    <section class="mb-4">
                        <div class="card">
                            <div class="card-header py-3 row">
                                <div class="col-sm-6">
                                    <h5 class="mb-0 text-left"><strong>Quản Lý Kho</strong></h5>
                                </div>
                                <div class="col-sm-6 text-right">
                                    <a href="#addWarehouseModal" class="btn btn-success" data-toggle="modal"><i class="fa fa-plus"></i></a>
                                </div>
                            </div>
                            <div class="card-body">
                                <c:if test="${sessionScope.errorMessage != null}">
                                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                        ${sessionScope.errorMessage}
                                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                                    <c:remove var="errorMessage" scope="session"/>
                                </c:if>
                                <c:if test="${sessionScope.successMessage != null}">
                                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                                        ${sessionScope.successMessage}
                                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                                    <c:remove var="successMessage" scope="session"/>
                                </c:if>
                                <table class="table table-hover text-nowrap">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Sản phẩm</th>
                                            <th>Số lượng nhập</th>
                                            <th>Ngày nhập</th>
                                            <th>Số lượng còn</th>
                                            <th>Thao tác</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${listE}" var="e">
                                            <tr>
                                                <td>${e.warehouseID}</td>
                                                <td>${e.product.name}</td>
                                                <td>${e.quantity}</td>
                                                <td><fmt:formatDate value="${e.importDate}" pattern="yyyy-MM-dd HH:mm" /></td>
                                                <td>${e.remainingQuantity}</td>
                                                <td>
                                                    <a href="#editWarehouseModal" class="btn btn-warning btn-action edit" data-toggle="modal"
                                                       data-id="${e.warehouseID}"
                                                       data-productid="${e.productID}"
                                                       data-quantity="${e.quantity}"
                                                       data-importdate="<fmt:formatDate value='${e.importDate}' pattern='yyyy-MM-dd\'T\'HH:mm' />"
                                                       data-remainingquantity="${e.remainingQuantity}">
                                                        <i class="fa fa-edit"></i>
                                                    </a>
                                                    <a href="#deleteWarehouseModal" class="btn btn-danger btn-action delete" data-toggle="modal" data-id="${e.warehouseID}"><i class="fa fa-trash"></i></a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </section>
                    
                    <!-- Tổng tồn kho theo sản phẩm -->
                    <section class="mb-4">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="mb-0"><strong>Tổng tồn kho theo sản phẩm</strong></h5>
                            </div>
                            <div class="card-body p-0">
                                <div class="table-responsive">
                                    <table class="table table-hover text-nowrap mb-0">
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Tên sản phẩm</th>
                                                <th>Tổng số lượng tồn</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${listPS}" var="ps">
                                                <tr>
                                                    <td>${ps.productID}</td>
                                                    <td>${ps.productName}</td>
                                                    <td>
                                                        <span class="badge ${ps.totalRemaining == 0 ? 'badge-danger' : ps.totalRemaining < 10 ? 'badge-warning' : 'badge-success'}">
                                                            ${ps.totalRemaining}
                                                        </span>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </section>
                </div>
            </main>
        </div>
    </div>

    <!-- Modal thêm kho mới -->
    <div id="addWarehouseModal" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <form action="quanLyKho" method="POST">
                    <input type="hidden" name="action" value="add">
                    <div class="modal-header">
                        <h4 class="modal-title">Nhập kho mới</h4>
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label>Sản phẩm</label>
                            <select name="productID" class="form-control" required>
                                <c:forEach items="${listP}" var="p">
                                    <option value="${p.id}">${p.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Số lượng nhập</label>
                            <input type="number" name="quantity" class="form-control" required min="1">
                        </div>
                        <div class="form-group">
                            <label>Ngày nhập</label>
                            <input type="datetime-local" name="importDate" class="form-control" required>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <input type="button" class="btn btn-default" data-dismiss="modal" value="Hủy">
                        <input type="submit" class="btn btn-success" value="Thêm">
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Modal sửa kho (có thể bổ sung tương tự modal thêm) -->
    <div id="editWarehouseModal" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <form action="quanLyKho" method="POST">
                    <input type="hidden" name="action" value="edit">
                     <input type="hidden" name="warehouseID" id="editWarehouseID">
                    <div class="modal-header">
                        <h4 class="modal-title">Sửa thông tin nhập kho</h4>
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    </div>
                    <div class="modal-body">
                         <div class="form-group">
                            <label>Sản phẩm</label>
                             <select name="productID" id="editWarehouseProductID" class="form-control" required>
                                <c:forEach items="${listP}" var="p">
                                    <option value="${p.id}">${p.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Số lượng nhập</label>
                            <input type="number" name="quantity" id="editWarehouseQuantity" class="form-control" required min="0">
                        </div>
                        <div class="form-group">
                            <label>Ngày nhập</label>
                            <input type="datetime-local" name="importDate" id="editWarehouseImportDate" class="form-control" required>
                        </div>
                         <div class="form-group">
                            <label>Số lượng tồn</label>
                            <input type="number" name="remainingQuantity" id="editWarehouseRemainingQuantity" class="form-control" required min="0">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <input type="button" class="btn btn-default" data-dismiss="modal" value="Hủy">
                        <input type="submit" class="btn btn-info" value="Lưu">
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Modal xóa kho (có thể bổ sung tương tự modal thêm) -->
    <div id="deleteWarehouseModal" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <form action="quanLyKho" method="POST">
                     <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="warehouseID" id="deleteWarehouseID">
                    <div class="modal-header">
                        <h4 class="modal-title">Xóa thông tin nhập kho</h4>
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    </div>
                    <div class="modal-body">
                        <p>Bạn có chắc chắn muốn xóa thông tin nhập kho này?</p>
                        <p class="text-warning"><small>Hành động này không thể hoàn tác.</small></p>
                    </div>
                    <div class="modal-footer">
                        <input type="button" class="btn btn-default" data-dismiss="modal" value="Hủy">
                        <input type="submit" class="btn btn-danger" value="Xóa">
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
    <script>
        $(document).ready(function(){
            // Activate tooltip
            $('[data-toggle="tooltip"]').tooltip();

            // Populate edit modal fields when edit button is clicked
            $('.edit').on('click', function() {
                var id = $(this).data('id');
                 var productID = $(this).data('productid');
                var quantity = $(this).data('quantity');
                var importDate = $(this).data('importdate');
                 var remainingQuantity = $(this).data('remainingquantity');

                $('#editWarehouseID').val(id);
                 $('#editWarehouseProductID').val(productID);
                $('#editWarehouseQuantity').val(quantity);
                $('#editWarehouseImportDate').val(importDate);
                 $('#editWarehouseRemainingQuantity').val(remainingQuantity);
            });

            // Populate delete modal field when delete button is clicked
            $('.delete').on('click', function() {
                var id = $(this).data('id');
                $('#deleteWarehouseID').val(id);
            });
        });
    </script>
</body>
</html>