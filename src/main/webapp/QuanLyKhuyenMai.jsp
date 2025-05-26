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
    <jsp:include page="LeftAdmin.jsp" />

    <div class="container-xl">
        <div class="table-responsive">
            <div class="table-wrapper">
                <div class="table-title">
                    <div class="row">
                        <div class="col-sm-6">
                            <h2>Quản Lý <b>Khuyến Mãi</b></h2>
                        </div>
                        <div class="col-sm-6">
                            <a href="#addDiscountModal" class="btn btn-success" data-toggle="modal"><i class="material-icons">&#xE147;</i> <span>Thêm mới khuyến mãi</span></a>
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
                            <th>Phần trăm giảm</th>
                            <th>Ngày bắt đầu</th>
                            <th>Ngày kết thúc</th>
                            <th>Trạng thái</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${listD}" var="d">
                            <tr>
                                <td>${d.discountID}</td>
                                <td>${d.product.name}</td>
                                <td>${d.percentOff}%</td>
                                <td><fmt:formatDate value="${d.startDate}" pattern="yyyy-MM-dd" /></td>
                                <td><fmt:formatDate value="${d.endDate}" pattern="yyyy-MM-dd" /></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${d.isActive}">Active</c:when>
                                        <c:otherwise>Inactive</c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <a href="#editDiscountModal" class="edit" data-toggle="modal"
                                       data-id="${d.discountID}"
                                       data-productid="${d.productID}"
                                       data-percentoff="${d.percentOff}"
                                       data-startdate="<fmt:formatDate value="${d.startDate}" pattern="yyyy-MM-dd" />"
                                       data-enddate="<fmt:formatDate value="${d.endDate}" pattern="yyyy-MM-dd" />"
                                       data-isactive="${d.isActive}">
                                        <i class="material-icons" data-toggle="tooltip" title="Edit">&#xE254;</i>
                                    </a>
                                    <a href="#deleteDiscountModal" class="delete" data-toggle="modal" data-id="${d.discountID}"><i class="material-icons" data-toggle="tooltip" title="Delete">&#xE872;</i></a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <%-- Pagination can be added here later if needed --%>
            </div>
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
                                ></c:forEach>
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
        });
    </script>
</body>
</html>