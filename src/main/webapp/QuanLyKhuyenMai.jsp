<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
        <%@page contentType="text/html" pageEncoding="UTF-8" %>
            <!DOCTYPE html>
            <html>

            <head>
                <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
                <title>Quản Lý Khuyến Mãi</title>
                <link rel="stylesheet"
                    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
                <link href="css/admin-simple.css" rel="stylesheet" type="text/css" />
            </head>

            <body>
                <c:set var="currentPage" value="quanLyKhuyenMai" />
                <div class="container-fluid">
                    <div class="row">
                        <jsp:include page="LeftAdmin.jsp" />
                        <main class="main-content">
                            <div class="container pt-4">
                                <section class="mb-4">
                                    <div class="card">
                                        <div class="card-header py-3 row">
                                            <div class="col-sm-6">
                                                <h5 class="mb-0 text-left"><strong>Quản Lý Khuyến Mãi</strong></h5>
                                            </div>
                                            <div class="col-sm-6 text-right">
                                                <button class="btn btn-success" onclick="openModal('addDiscountModal')">
                                                    <i class="fa fa-plus"></i> Thêm Khuyến Mãi
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
                                                                <td>${d.product != null ? d.product.name : 'No Product'}
                                                                </td>
                                                                <td>${d.percentOff}%</td>
                                                                <td>${d.startDate}</td>
                                                                <td>${d.endDate}</td>
                                                                <td>
                                                                    <span
                                                                        class="badge ${d.active ? 'badge-success' : 'badge-secondary'}">
                                                                        ${d.active ? 'Active' : 'Inactive'}
                                                                    </span>
                                                                </td>
                                                                <td>
                                                                    <button class="btn btn-warning btn-action"
                                                                        onclick="editDiscount('${d.discountID}', '${d.productID}', '${d.percentOff}', '${d.startDate}', '${d.endDate}', '${d.active}')">
                                                                        <i class="fa fa-edit"></i>
                                                                    </button>
                                                                    <button class="btn btn-danger btn-action"
                                                                        onclick="deleteDiscount('${d.discountID}')">
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
                            </div>
                        </main>
                    </div>
                </div>

                <!-- Add Discount Modal -->
                <div id="addDiscountModal" class="modal">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <form action="quanLyKhuyenMai" method="POST">
                                <input type="hidden" name="action" value="add">
                                <div class="modal-header">
                                    <h4 class="modal-title">Thêm khuyến mãi</h4>
                                    <button type="button" class="close"
                                        onclick="closeModal('addDiscountModal')">&times;</button>
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
                                        <input type="number" name="percentOff" class="form-control" required min="1"
                                            max="100">
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
                                    <button type="button" class="btn btn-secondary"
                                        onclick="closeModal('addDiscountModal')">Hủy</button>
                                    <button type="submit" class="btn btn-success">Thêm</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <!-- Edit Discount Modal -->
                <div id="editDiscountModal" class="modal">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <form action="quanLyKhuyenMai" method="POST">
                                <input type="hidden" name="action" value="edit">
                                <input type="hidden" name="discountID" id="editDiscountID">
                                <div class="modal-header">
                                    <h4 class="modal-title">Sửa khuyến mãi</h4>
                                    <button type="button" class="close"
                                        onclick="closeModal('editDiscountModal')">&times;</button>
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
                                        <input type="number" name="percentOff" id="editPercentOff" class="form-control"
                                            required min="1" max="100">
                                    </div>
                                    <div class="form-group">
                                        <label>Ngày bắt đầu</label>
                                        <input type="date" name="startDate" id="editStartDate" class="form-control"
                                            required>
                                    </div>
                                    <div class="form-group">
                                        <label>Ngày kết thúc</label>
                                        <input type="date" name="endDate" id="editEndDate" class="form-control"
                                            required>
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
                                    <button type="button" class="btn btn-secondary"
                                        onclick="closeModal('editDiscountModal')">Hủy</button>
                                    <button type="submit" class="btn btn-info">Lưu</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <!-- Delete Discount Modal -->
                <div id="deleteDiscountModal" class="modal">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <form action="quanLyKhuyenMai" method="POST">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="discountID" id="deleteDiscountID">
                                <div class="modal-header">
                                    <h4 class="modal-title">Xóa khuyến mãi</h4>
                                    <button type="button" class="close"
                                        onclick="closeModal('deleteDiscountModal')">&times;</button>
                                </div>
                                <div class="modal-body">
                                    <p>Bạn có chắc chắn muốn xóa khuyến mãi này?</p>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary"
                                        onclick="closeModal('deleteDiscountModal')">Hủy</button>
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

                    function editDiscount(id, productId, percentOff, startDate, endDate, isActive) {
                        document.getElementById('editDiscountID').value = id;
                        document.getElementById('editProductID').value = productId;
                        document.getElementById('editPercentOff').value = percentOff;
                        document.getElementById('editStartDate').value = startDate;
                        document.getElementById('editEndDate').value = endDate;
                        document.getElementById('editIsActive').value = isActive;
                        openModal('editDiscountModal');
                    }

                    function deleteDiscount(id) {
                        document.getElementById('deleteDiscountID').value = id;
                        openModal('deleteDiscountModal');
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