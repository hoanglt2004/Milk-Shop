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
    <jsp:include page="LeftAdmin.jsp" />

    <div class="container-xl">
        <div class="table-responsive">
            <div class="table-wrapper">
                <div class="table-title">
                    <div class="row">
                        <div class="col-sm-6">
                            <h2>Quản Lý <b>Kho</b></h2>
                        </div>
                        <div class="col-sm-6">
                            <a href="#addWarehouseModal" class="btn btn-success" data-toggle="modal"><i class="material-icons">&#xE147;</i> <span>Nhập kho mới</span></a>
                        </div>
                    </div>
                </div>

                 <c:if test="${requestScope.errorMessage != null}">
                    <div class="alert alert-danger" role="alert">
                        ${requestScope.errorMessage}
                    </div>
                </c:if>
                 <c:if test="${requestScope.successMessage != null}">
                    <div class="alert alert-success" role="alert">
                        ${requestScope.successMessage}
                    </div>
                </c:if>

                <table class="table table-striped table-hover">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Sản phẩm</th>
                            <th>Số lượng nhập</th>
                            <th>Ngày nhập</th>
                            <th>Số lượng tồn</th>
                            <th>Actions</th>
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
                                     <a href="#editWarehouseModal" class="edit" data-toggle="modal"
                                       data-id="${e.warehouseID}"
                                       data-productid="${e.productID}"
                                       data-quantity="${e.quantity}"
                                       data-importdate="<fmt:formatDate value="${e.importDate}" pattern="yyyy-MM-dd'T'HH:mm" />"
                                       data-remainingquantity="${e.remainingQuantity}">
                                        <i class="material-icons" data-toggle="tooltip" title="Edit">&#xE254;</i>
                                    </a>
                                    <a href="#deleteWarehouseModal" class="delete" data-toggle="modal" data-id="${e.warehouseID}"><i class="material-icons" data-toggle="tooltip" title="Delete">&#xE872;</i></a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <%-- Pagination can be added here later if needed --%>
            </div>
        </div>

        <%-- Product Stock Overview --%>
        <div class="table-responsive product-stock-table">
             <div class="table-wrapper">
                  <div class="table-title">
                    <div class="row">
                        <div class="col-sm-12">
                            <h3>Tổng Tồn Kho Theo Sản Phẩm</b></h3>
                        </div>
                    </div>
                </div>
                <table class="table table-striped table-hover">
                    <thead>
                        <tr>
                            <th>Sản phẩm ID</th>
                            <th>Tên sản phẩm</th>
                            <th>Tổng số lượng tồn</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${listPS}" var="ps">
                            <tr>
                                <td>${ps.productID}</td>
                                <td>${ps.productName}</td>
                                <td>${ps.totalRemaining}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
             </div>
        </div>
    </div>

    <!-- Add Warehouse Modal HTML -->
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
                                ></c:forEach>
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

    <!-- Edit Warehouse Modal HTML -->
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
                                ></c:forEach>
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

    <!-- Delete Warehouse Modal HTML -->
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