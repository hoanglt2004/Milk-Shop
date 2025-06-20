<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Quản Lý Khuyến Mãi</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Varela+Round">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link href="css/manager.css" rel="stylesheet" type="text/css"/>
    <style>
        /* Add any specific styles for this page here */
    </style>
</head>
<body>
    <c:set var="currentPage" value="quanLyKhuyenMai" />
    <div class="container-fluid">
        <div class="row">
            <jsp:include page="LeftAdmin.jsp"/>
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 main-content">
                <div class="container pt-4">
                    <section class="mb-4">
                        <div class="card">
                            <div class="card-header py-3 row">
                                <div class="col-sm-6">
                                    <h5 class="mb-0 text-left"><strong>Quản Lý Khuyến Mãi</strong></h5>
                                </div>
                                <div class="col-sm-6 text-right">
                                    <a href="#addDiscountModal" class="btn btn-success" data-toggle="modal"><i class="fa fa-plus"></i></a>
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
                                            <th>Phần trăm giảm</th>
                                            <th>Ngày bắt đầu</th>
                                            <th>Ngày kết thúc</th>
                                            <th>Trạng thái</th>
                                            <th>Thao tác</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${listD}" var="d">
                                            <tr>
                                                <td>${d.discountID}</td>
                                                <td>${d.product != null ? d.product.name : 'No Product'}</td>
                                                <td>${d.percentOff}%</td>
                                                <td>${d.startDate}</td>
                                                <td>${d.endDate}</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${d.active == true}">Active</c:when>
                                                        <c:otherwise>Inactive</c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <a href="#editDiscountModal" class="btn btn-warning btn-action edit" data-toggle="modal"
                                                       data-id="${d.discountID}"
                                                       data-productid="${d.productID}"
                                                       data-percentoff="${d.percentOff}"
                                                       data-startdate="${d.startDate}"
                                                       data-enddate="${d.endDate}"
                                                       data-isactive="${d.active}">
                                                        <i class="fa fa-edit"></i>
                                                    </a>
                                                    <a href="#deleteDiscountModal" class="btn btn-danger btn-action delete" data-toggle="modal" data-id="${d.discountID}"><i class="fa fa-trash"></i></a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </section>
                </div>
            </main>
        </div>
    </div>

    <!-- Add Discount Modal HTML -->
    <div id="addDiscountModal" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <form action="quanLyKhuyenMai" method="POST">
                    <input type="hidden" name="action" value="add">
                    <div class="modal-header">
                        <h4 class="modal-title">Thêm khuyến mãi</h4>
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label>Sản phẩm</label>
                            <select name="productID" class="form-control" required>
                                <option value="">-- Chọn sản phẩm --</option>
                                <c:forEach items="${listP}" var="p">
                                    <option value="${p.id}">${p.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Phần trăm giảm</label>
                            <input type="number" name="percentOff" class="form-control" required min="1" max="100">
                        </div>
                        <div class="form-group">
                            <label>Ngày bắt đầu</label>
                            <input type="date" name="startDate" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label>Ngày kết thúc</label>
                            <input type="date" name="endDate" class="form-control" required>
                        </div>
                         <div class="form-group">
                            <label>Trạng thái</label>
                            <select name="isActive" class="form-control">
                                <option value="true">Active</option>
                                <option value="false">Inactive</option>
                            </select>
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

    <!-- Edit Discount Modal HTML -->
    <div id="editDiscountModal" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <form action="quanLyKhuyenMai" method="POST">
                    <input type="hidden" name="action" value="edit">
                    <input type="hidden" name="discountID" id="editDiscountID">
                    <div class="modal-header">
                        <h4 class="modal-title">Sửa khuyến mãi</h4>
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label>Sản phẩm</label>
                             <select name="productID" id="editProductID" class="form-control" required>
                                <c:forEach items="${listP}" var="p">
                                    <option value="${p.id}">${p.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                         <div class="form-group">
                            <label>Phần trăm giảm</label>
                            <input type="number" name="percentOff" id="editPercentOff" class="form-control" required min="1" max="100">
                        </div>
                        <div class="form-group">
                            <label>Ngày bắt đầu</label>
                            <input type="date" name="startDate" id="editStartDate" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label>Ngày kết thúc</label>
                            <input type="date" name="endDate" id="editEndDate" class="form-control" required>
                        </div>
                         <div class="form-group">
                            <label>Trạng thái</label>
                             <select name="isActive" id="editIsActive" class="form-control">
                                <option value="true">Active</option>
                                <option value="false">Inactive</option>
                            </select>
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

    <!-- Delete Discount Modal HTML -->
    <div id="deleteDiscountModal" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <form action="quanLyKhuyenMai" method="POST">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="discountID" id="deleteDiscountID">
                    <div class="modal-header">
                        <h4 class="modal-title">Xóa khuyến mãi</h4>
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    </div>
                    <div class="modal-body">
                        <p>Bạn có chắc chắn muốn xóa khuyến mãi này?</p>
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
                var percentOff = $(this).data('percentoff');
                var startDate = $(this).data('startdate');
                var endDate = $(this).data('enddate');
                var isActive = $(this).data('isactive');

                $('#editDiscountID').val(id);
                $('#editProductID').val(productID);
                $('#editPercentOff').val(percentOff);
                $('#editStartDate').val(startDate);
                $('#editEndDate').val(endDate);
                 $('#editIsActive').val(isActive.toString()); // Set dropdown value
            });

            // Populate delete modal field when delete button is clicked
            $('.delete').on('click', function() {
                var id = $(this).data('id');
                $('#deleteDiscountID').val(id);
            });

            // No additional scripts needed for simple dropdown
        });
    </script>
</body>
</html>