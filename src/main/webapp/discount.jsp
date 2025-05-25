<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>Quản lý khuyến mãi</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
            <link rel="stylesheet" href="css/style.css">
        </head>

        <body>
            <div class="container-fluid">
                <div class="row">
                    <!-- Sidebar -->
                    <jsp:include page="sidebar.jsp"></jsp:include>

                    <!-- Main Content -->
                    <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                        <div
                            class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                            <h1 class="h2">Quản lý khuyến mãi</h1>
                            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addDiscountModal">
                                <i class="fas fa-plus"></i> Thêm mới
                            </button>
                        </div>

                        <!-- Search and Filter -->
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <div class="input-group">
                                    <input type="text" class="form-control" placeholder="Tìm kiếm..." id="searchInput">
                                    <button class="btn btn-outline-secondary" type="button" id="searchButton">
                                        <i class="fas fa-search"></i>
                                    </button>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <select class="form-select" id="statusFilter">
                                    <option value="">Tất cả trạng thái</option>
                                    <option value="active">Đang hoạt động</option>
                                    <option value="inactive">Không hoạt động</option>
                                </select>
                            </div>
                        </div>

                        <!-- Discount Table -->
                        <div class="table-responsive">
                            <table class="table table-striped table-hover">
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
                                    <c:forEach items="${discountList}" var="discount">
                                        <tr>
                                            <td>${discount.discountID}</td>
                                            <td>${discount.product.productName}</td>
                                            <td>${discount.percentOff}%</td>
                                            <td>${discount.startDate}</td>
                                            <td>${discount.endDate}</td>
                                            <td>
                                                <span class="badge ${discount.active ? 'bg-success' : 'bg-danger'}">
                                                    ${discount.active ? 'Đang hoạt động' : 'Không hoạt động'}
                                                </span>
                                            </td>
                                            <td>
                                                <button class="btn btn-sm btn-info"
                                                    onclick="editDiscount(${discount.discountID})">
                                                    <i class="fas fa-edit"></i>
                                                </button>
                                                <button class="btn btn-sm btn-danger"
                                                    onclick="deleteDiscount(${discount.discountID})">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </main>
                </div>
            </div>

            <!-- Add Discount Modal -->
            <div class="modal fade" id="addDiscountModal" tabindex="-1">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Thêm mới khuyến mãi</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <form id="addDiscountForm">
                                <div class="mb-3">
                                    <label class="form-label">Sản phẩm</label>
                                    <select class="form-select" name="productID" required>
                                        <c:forEach items="${productList}" var="product">
                                            <option value="${product.productID}">${product.productName}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Phần trăm giảm</label>
                                    <input type="number" class="form-control" name="percentOff" min="0" max="100"
                                        required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Ngày bắt đầu</label>
                                    <input type="date" class="form-control" name="startDate" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Ngày kết thúc</label>
                                    <input type="date" class="form-control" name="endDate" required>
                                </div>
                                <div class="mb-3">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" name="isActive" checked>
                                        <label class="form-check-label">Kích hoạt khuyến mãi</label>
                                    </div>
                                </div>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                            <button type="button" class="btn btn-primary" onclick="submitAddDiscount()">Thêm
                                mới</button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Edit Discount Modal -->
            <div class="modal fade" id="editDiscountModal" tabindex="-1">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Chỉnh sửa khuyến mãi</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <form id="editDiscountForm">
                                <input type="hidden" name="discountID">
                                <div class="mb-3">
                                    <label class="form-label">Sản phẩm</label>
                                    <select class="form-select" name="productID" required>
                                        <c:forEach items="${productList}" var="product">
                                            <option value="${product.productID}">${product.productName}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Phần trăm giảm</label>
                                    <input type="number" class="form-control" name="percentOff" min="0" max="100"
                                        required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Ngày bắt đầu</label>
                                    <input type="date" class="form-control" name="startDate" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Ngày kết thúc</label>
                                    <input type="date" class="form-control" name="endDate" required>
                                </div>
                                <div class="mb-3">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" name="isActive">
                                        <label class="form-check-label">Kích hoạt khuyến mãi</label>
                                    </div>
                                </div>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                            <button type="button" class="btn btn-primary" onclick="submitEditDiscount()">Cập
                                nhật</button>
                        </div>
                    </div>
                </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
            <script>
                function editDiscount(id) {
                    $.get('discount?action=edit&id=' + id, function (data) {
                        $('#editDiscountForm [name=discountID]').val(data.discountID);
                        $('#editDiscountForm [name=productID]').val(data.productID);
                        $('#editDiscountForm [name=percentOff]').val(data.percentOff);
                        $('#editDiscountForm [name=startDate]').val(data.startDate);
                        $('#editDiscountForm [name=endDate]').val(data.endDate);
                        $('#editDiscountForm [name=isActive]').prop('checked', data.isActive);
                        $('#editDiscountModal').modal('show');
                    });
                }

                function deleteDiscount(id) {
                    if (confirm('Bạn có chắc chắn muốn xóa?')) {
                        $.post('discount?action=delete&id=' + id, function () {
                            location.reload();
                        });
                    }
                }

                function submitAddDiscount() {
                    $.post('discount?action=add', $('#addDiscountForm').serialize(), function () {
                        location.reload();
                    });
                }

                function submitEditDiscount() {
                    $.post('discount?action=update', $('#editDiscountForm').serialize(), function () {
                        location.reload();
                    });
                }

                // Search and filter functionality
                $('#searchButton').click(function () {
                    var searchText = $('#searchInput').val();
                    // Implement search logic
                });

                $('#statusFilter').change(function () {
                    var status = $(this).val();
                    // Implement filter logic
                });
            </script>
        </body>

        </html>