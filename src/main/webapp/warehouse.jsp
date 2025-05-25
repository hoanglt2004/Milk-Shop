<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>Quản lý kho</title>
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
                            <h1 class="h2">Quản lý kho</h1>
                            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addWarehouseModal">
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
                                <select class="form-select" id="productFilter">
                                    <option value="">Tất cả sản phẩm</option>
                                    <c:forEach items="${productList}" var="product">
                                        <option value="${product.productID}">${product.productName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <!-- Warehouse Table -->
                        <div class="table-responsive">
                            <table class="table table-striped table-hover">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Sản phẩm</th>
                                        <th>Số lượng nhập</th>
                                        <th>Ngày nhập</th>
                                        <th>Số lượng còn lại</th>
                                        <th>Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${warehouseList}" var="warehouse">
                                        <tr>
                                            <td>${warehouse.warehouseID}</td>
                                            <td>${warehouse.product.productName}</td>
                                            <td>${warehouse.quantity}</td>
                                            <td>${warehouse.importDate}</td>
                                            <td>${warehouse.remainingQuantity}</td>
                                            <td>
                                                <button class="btn btn-sm btn-info"
                                                    onclick="editWarehouse(${warehouse.warehouseID})">
                                                    <i class="fas fa-edit"></i>
                                                </button>
                                                <button class="btn btn-sm btn-danger"
                                                    onclick="deleteWarehouse(${warehouse.warehouseID})">
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

            <!-- Add Warehouse Modal -->
            <div class="modal fade" id="addWarehouseModal" tabindex="-1">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Thêm mới kho</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <form id="addWarehouseForm">
                                <div class="mb-3">
                                    <label class="form-label">Sản phẩm</label>
                                    <select class="form-select" name="productID" required>
                                        <c:forEach items="${productList}" var="product">
                                            <option value="${product.productID}">${product.productName}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Số lượng nhập</label>
                                    <input type="number" class="form-control" name="quantity" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Ngày nhập</label>
                                    <input type="date" class="form-control" name="importDate" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Số lượng còn lại</label>
                                    <input type="number" class="form-control" name="remainingQuantity" required>
                                </div>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                            <button type="button" class="btn btn-primary" onclick="submitAddWarehouse()">Thêm
                                mới</button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Edit Warehouse Modal -->
            <div class="modal fade" id="editWarehouseModal" tabindex="-1">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Chỉnh sửa kho</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <form id="editWarehouseForm">
                                <input type="hidden" name="warehouseID">
                                <div class="mb-3">
                                    <label class="form-label">Sản phẩm</label>
                                    <select class="form-select" name="productID" required>
                                        <c:forEach items="${productList}" var="product">
                                            <option value="${product.productID}">${product.productName}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Số lượng nhập</label>
                                    <input type="number" class="form-control" name="quantity" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Ngày nhập</label>
                                    <input type="date" class="form-control" name="importDate" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Số lượng còn lại</label>
                                    <input type="number" class="form-control" name="remainingQuantity" required>
                                </div>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                            <button type="button" class="btn btn-primary" onclick="submitEditWarehouse()">Cập
                                nhật</button>
                        </div>
                    </div>
                </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
            <script>
                // Add your JavaScript functions here
                function editWarehouse(id) {
                    // Fetch warehouse data and populate edit form
                    $.get('warehouse?action=edit&id=' + id, function (data) {
                        $('#editWarehouseForm [name=warehouseID]').val(data.warehouseID);
                        $('#editWarehouseForm [name=productID]').val(data.productID);
                        $('#editWarehouseForm [name=quantity]').val(data.quantity);
                        $('#editWarehouseForm [name=importDate]').val(data.importDate);
                        $('#editWarehouseForm [name=remainingQuantity]').val(data.remainingQuantity);
                        $('#editWarehouseModal').modal('show');
                    });
                }

                function deleteWarehouse(id) {
                    if (confirm('Bạn có chắc chắn muốn xóa?')) {
                        $.post('warehouse?action=delete&id=' + id, function () {
                            location.reload();
                        });
                    }
                }

                function submitAddWarehouse() {
                    $.post('warehouse?action=add', $('#addWarehouseForm').serialize(), function () {
                        location.reload();
                    });
                }

                function submitEditWarehouse() {
                    $.post('warehouse?action=update', $('#editWarehouseForm').serialize(), function () {
                        location.reload();
                    });
                }

                // Search and filter functionality
                $('#searchButton').click(function () {
                    var searchText = $('#searchInput').val();
                    // Implement search logic
                });

                $('#productFilter').change(function () {
                    var productId = $(this).val();
                    // Implement filter logic
                });
            </script>
        </body>

        </html>