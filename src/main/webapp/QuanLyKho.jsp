<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
        <%@page contentType="text/html" pageEncoding="UTF-8" %>
            <!DOCTYPE html>
            <html>

            <head>
                <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
                <title>Quản Lý Kho</title>
                <link rel="stylesheet"
                    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
                <link href="css/admin-simple.css" rel="stylesheet" type="text/css" />
                <style>
                    .badge-success {
                        background-color: #28a745;
                    }

                    .badge-warning {
                        background-color: #ffc107;
                        color: #212529;
                    }

                    .badge-danger {
                        background-color: #dc3545;
                    }

                    .badge {
                        padding: 4px 8px;
                        border-radius: 4px;
                        font-size: 12px;
                        color: white;
                    }

                    /* Cảnh báo countdown */
                    .countdown-badge {
                        animation: pulse 2s infinite;
                        font-weight: bold;
                    }

                    @keyframes pulse {
                        0% {
                            transform: scale(1);
                        }

                        50% {
                            transform: scale(1.1);
                        }

                        100% {
                            transform: scale(1);
                        }
                    }

                    .table-danger {
                        background-color: rgba(248, 215, 218, 0.5) !important;
                    }

                    .table-warning {
                        background-color: rgba(255, 243, 205, 0.5) !important;
                    }

                    .bg-warning {
                        background-color: #fff3cd !important;
                        color: #856404;
                    }

                    .border-warning {
                        border-color: #ffc107 !important;
                    }
                </style>
            </head>

            <body>
                <c:set var="currentPage" value="quanLyKho" />
                <div class="container-fluid">
                    <div class="row">
                        <jsp:include page="LeftAdmin.jsp" />
                        <main class="main-content">
                            <div class="container pt-4">
                                <section class="mb-4">
                                    <div class="card">
                                        <div class="card-header py-3 row">
                                            <div class="col-sm-6">
                                                <h5 class="mb-0 text-left"><strong>Quản Lý Kho</strong></h5>
                                            </div>
                                            <div class="col-sm-6 text-right">
                                                <button class="btn btn-success"
                                                    onclick="openModal('addWarehouseModal')">
                                                    <i class="fa fa-plus"></i> Nhập Kho Mới
                                                </button>
                                            </div>
                                        </div>
                                        <div class="card-body">
                                            <c:if test="${sessionScope.errorMessage != null}">
                                                <div class="alert alert-danger">
                                                    ${sessionScope.errorMessage}
                                                    <button type="button" class="close"
                                                        onclick="this.parentElement.style.display='none'">&times;</button>
                                                </div>
                                                <c:remove var="errorMessage" scope="session" />
                                            </c:if>
                                            <c:if test="${sessionScope.successMessage != null}">
                                                <div class="alert alert-success">
                                                    ${sessionScope.successMessage}
                                                    <button type="button" class="close"
                                                        onclick="this.parentElement.style.display='none'">&times;</button>
                                                </div>
                                                <c:remove var="successMessage" scope="session" />
                                            </c:if>

                                            <div class="table-responsive">
                                                <table class="table table-hover">
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
                                                                <td>
                                                                    <fmt:formatDate value="${e.importDate}"
                                                                        pattern="yyyy-MM-dd HH:mm" />
                                                                </td>
                                                                <td>${e.remainingQuantity}</td>
                                                                <td>
                                                                    <button class="btn btn-warning btn-action"
                                                                        onclick="editWarehouse('${e.warehouseID}', '${e.productID}', '${e.quantity}', '<fmt:formatDate value='${e.importDate}' pattern='yyyy-MM-dd\'T\'HH:mm' />', '${e.remainingQuantity}')">
                                                                        <i class="fa fa-edit"></i>
                                                                    </button>
                                                                    <button class="btn btn-danger btn-action"
                                                                        onclick="deleteWarehouse('${e.warehouseID}')">
                                                                        <i class="fa fa-trash"></i>
                                                                    </button>
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </section>

                                <!-- Cảnh báo cho Admin -->
                                <section class="mb-4">
                                    <div class="card border-warning">
                                        <div class="card-header bg-warning">
                                            <h5 class="mb-0"><strong><i class="fas fa-exclamation-triangle"></i> Cảnh
                                                    Báo Tồn Kho</strong></h5>
                                            <small class="text-muted">Sản phẩm có số lượng ≤ 5 hoặc sắp bị xóa khỏi hệ
                                                thống</small>
                                        </div>
                                        <div class="card-body p-0">
                                            <div class="table-responsive">
                                                <table class="table table-hover mb-0">
                                                    <thead class="thead-light">
                                                        <tr>
                                                            <th>ID</th>
                                                            <th>Tên sản phẩm</th>
                                                            <th>Số lượng tồn kho</th>
                                                            <th>Thời gian còn lại</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:choose>
                                                            <c:when test="${empty listWarning}">
                                                                <tr>
                                                                    <td colspan="4" class="text-center text-success">
                                                                        <i class="fas fa-check-circle"></i> Không có sản
                                                                        phẩm nào cần cảnh báo!
                                                                    </td>
                                                                </tr>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <c:forEach items="${listWarning}" var="warning">
                                                                    <tr
                                                                        class="${warning.totalRemaining == 0 ? 'table-danger' : 'table-warning'}">
                                                                        <td>${warning.productID}</td>
                                                                        <td>${warning.productName}</td>
                                                                        <td>
                                                                            <c:choose>
                                                                                <c:when
                                                                                    test="${warning.totalRemaining == 0}">
                                                                                    <span class="badge badge-danger">
                                                                                        <i class="fas fa-times"></i> HẾT
                                                                                        HÀNG
                                                                                    </span>
                                                                                </c:when>
                                                                                <c:when
                                                                                    test="${warning.totalRemaining <= 2}">
                                                                                    <span class="badge badge-danger">
                                                                                        <i
                                                                                            class="fas fa-exclamation"></i>
                                                                                        ${warning.totalRemaining}
                                                                                    </span>
                                                                                </c:when>
                                                                                <c:otherwise>
                                                                                    <span class="badge badge-warning">
                                                                                        <i class="fas fa-warning"></i>
                                                                                        ${warning.totalRemaining}
                                                                                    </span>
                                                                                </c:otherwise>
                                                                            </c:choose>
                                                                        </td>
                                                                        <td>
                                                                            <c:choose>
                                                                                <c:when
                                                                                    test="${warning.totalRemaining == 0}">
                                                                                    <c:choose>
                                                                                        <c:when
                                                                                            test="${warning.daysRemaining > 0}">
                                                                                            <span
                                                                                                class="badge badge-danger countdown-badge">
                                                                                                <i
                                                                                                    class="fas fa-clock"></i>
                                                                                                ${warning.daysRemaining}
                                                                                                ngày
                                                                                            </span>
                                                                                            <small
                                                                                                class="d-block text-muted">Sẽ
                                                                                                tự động xóa</small>
                                                                                        </c:when>
                                                                                        <c:otherwise>
                                                                                            <span
                                                                                                class="badge badge-dark">
                                                                                                <i
                                                                                                    class="fas fa-trash"></i>
                                                                                                SẼ XÓA
                                                                                            </span>
                                                                                        </c:otherwise>
                                                                                    </c:choose>
                                                                                </c:when>
                                                                                <c:otherwise>
                                                                                    <span class="text-info">
                                                                                        <i
                                                                                            class="fas fa-info-circle"></i>
                                                                                        Cần nhập thêm
                                                                                    </span>
                                                                                </c:otherwise>
                                                                            </c:choose>
                                                                        </td>
                                                                    </tr>
                                                                </c:forEach>
                                                            </c:otherwise>
                                                        </c:choose>
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
                <div id="addWarehouseModal" class="modal">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <form action="quanLyKho" method="POST">
                                <input type="hidden" name="action" value="add">
                                <div class="modal-header">
                                    <h4 class="modal-title">Nhập kho mới</h4>
                                    <button type="button" class="close"
                                        onclick="closeModal('addWarehouseModal')">&times;</button>
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
                                        <label>Số lượng nhập</label>
                                        <input type="number" name="quantity" class="form-control" required min="1">
                                    </div>
                                    <div class="form-group">
                                        <label>Ngày nhập</label>
                                        <input type="datetime-local" name="importDate" class="form-control" required>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary"
                                        onclick="closeModal('addWarehouseModal')">Hủy</button>
                                    <button type="submit" class="btn btn-success">Thêm</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <!-- Modal sửa kho -->
                <div id="editWarehouseModal" class="modal">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <form action="quanLyKho" method="POST">
                                <input type="hidden" name="action" value="edit">
                                <input type="hidden" name="warehouseID" id="editWarehouseID">
                                <div class="modal-header">
                                    <h4 class="modal-title">Sửa thông tin nhập kho</h4>
                                    <button type="button" class="close"
                                        onclick="closeModal('editWarehouseModal')">&times;</button>
                                </div>
                                <div class="modal-body">
                                    <div class="form-group">
                                        <label>Sản phẩm</label>
                                        <select name="productID" id="editWarehouseProductID" class="form-control"
                                            required>
                                            <c:forEach items="${listP}" var="p">
                                                <option value="${p.id}">${p.name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label>Số lượng nhập</label>
                                        <input type="number" name="quantity" id="editWarehouseQuantity"
                                            class="form-control" required min="0">
                                    </div>
                                    <div class="form-group">
                                        <label>Ngày nhập</label>
                                        <input type="datetime-local" name="importDate" id="editWarehouseImportDate"
                                            class="form-control" required>
                                    </div>
                                    <div class="form-group">
                                        <label>Số lượng còn</label>
                                        <input type="number" name="remainingQuantity"
                                            id="editWarehouseRemainingQuantity" class="form-control" required min="0">
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary"
                                        onclick="closeModal('editWarehouseModal')">Hủy</button>
                                    <button type="submit" class="btn btn-info">Lưu</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <!-- Modal xóa kho -->
                <div id="deleteWarehouseModal" class="modal">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <form action="quanLyKho" method="POST">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="warehouseID" id="deleteWarehouseID">
                                <div class="modal-header">
                                    <h4 class="modal-title">Xóa thông tin kho</h4>
                                    <button type="button" class="close"
                                        onclick="closeModal('deleteWarehouseModal')">&times;</button>
                                </div>
                                <div class="modal-body">
                                    <p>Bạn có chắc chắn muốn xóa thông tin kho này?</p>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary"
                                        onclick="closeModal('deleteWarehouseModal')">Hủy</button>
                                    <button type="submit" class="btn btn-danger">Xóa</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <script>
                    // Modal functions
                    function openModal(modalId) {
                        document.getElementById(modalId).classList.add('show');
                    }

                    function closeModal(modalId) {
                        document.getElementById(modalId).classList.remove('show');
                    }

                    function editWarehouse(id, productId, quantity, importDate, remainingQuantity) {
                        document.getElementById('editWarehouseID').value = id;
                        document.getElementById('editWarehouseProductID').value = productId;
                        document.getElementById('editWarehouseQuantity').value = quantity;
                        document.getElementById('editWarehouseImportDate').value = importDate;
                        document.getElementById('editWarehouseRemainingQuantity').value = remainingQuantity;
                        openModal('editWarehouseModal');
                    }

                    function deleteWarehouse(id) {
                        document.getElementById('deleteWarehouseID').value = id;
                        openModal('deleteWarehouseModal');
                    }

                    // Close modal when clicking outside
                    window.onclick = function (event) {
                        if (event.target.classList.contains('modal')) {
                            event.target.classList.remove('show');
                        }
                    }
                </script>
            </body>

            </html>