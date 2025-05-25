<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>Quản lý khách hàng</title>
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
                            <h1 class="h2">Quản lý khách hàng</h1>
                            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addCustomerModal">
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
                                <select class="form-select" id="genderFilter">
                                    <option value="">Tất cả giới tính</option>
                                    <option value="Nam">Nam</option>
                                    <option value="Nữ">Nữ</option>
                                    <option value="Khác">Khác</option>
                                </select>
                            </div>
                        </div>

                        <!-- Customer Table -->
                        <div class="table-responsive">
                            <table class="table table-striped table-hover">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Họ tên</th>
                                        <th>Email</th>
                                        <th>Số điện thoại</th>
                                        <th>Địa chỉ</th>
                                        <th>Ngày sinh</th>
                                        <th>Giới tính</th>
                                        <th>Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${customerList}" var="customer">
                                        <tr>
                                            <td>${customer.customerID}</td>
                                            <td>${customer.fullName}</td>
                                            <td>${customer.email}</td>
                                            <td>${customer.phone}</td>
                                            <td>${customer.address}</td>
                                            <td>${customer.dateOfBirth}</td>
                                            <td>${customer.gender}</td>
                                            <td>
                                                <button class="btn btn-sm btn-info"
                                                    onclick="editCustomer(${customer.customerID})">
                                                    <i class="fas fa-edit"></i>
                                                </button>
                                                <button class="btn btn-sm btn-danger"
                                                    onclick="deleteCustomer(${customer.customerID})">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                                <button class="btn btn-sm btn-success"
                                                    onclick="viewOrders(${customer.customerID})">
                                                    <i class="fas fa-shopping-cart"></i>
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

            <!-- Add Customer Modal -->
            <div class="modal fade" id="addCustomerModal" tabindex="-1">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Thêm mới khách hàng</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <form id="addCustomerForm">
                                <div class="mb-3">
                                    <label class="form-label">Họ tên</label>
                                    <input type="text" class="form-control" name="fullName" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Email</label>
                                    <input type="email" class="form-control" name="email" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Số điện thoại</label>
                                    <input type="tel" class="form-control" name="phone" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Địa chỉ</label>
                                    <textarea class="form-control" name="address" required></textarea>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Ngày sinh</label>
                                    <input type="date" class="form-control" name="dateOfBirth" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Giới tính</label>
                                    <select class="form-select" name="gender" required>
                                        <option value="Nam">Nam</option>
                                        <option value="Nữ">Nữ</option>
                                        <option value="Khác">Khác</option>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Tài khoản</label>
                                    <select class="form-select" name="accountID" required>
                                        <c:forEach items="${accountList}" var="account">
                                            <option value="${account.accountID}">${account.username}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                            <button type="button" class="btn btn-primary" onclick="submitAddCustomer()">Thêm
                                mới</button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Edit Customer Modal -->
            <div class="modal fade" id="editCustomerModal" tabindex="-1">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Chỉnh sửa khách hàng</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <form id="editCustomerForm">
                                <input type="hidden" name="customerID">
                                <div class="mb-3">
                                    <label class="form-label">Họ tên</label>
                                    <input type="text" class="form-control" name="fullName" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Email</label>
                                    <input type="email" class="form-control" name="email" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Số điện thoại</label>
                                    <input type="tel" class="form-control" name="phone" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Địa chỉ</label>
                                    <textarea class="form-control" name="address" required></textarea>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Ngày sinh</label>
                                    <input type="date" class="form-control" name="dateOfBirth" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Giới tính</label>
                                    <select class="form-select" name="gender" required>
                                        <option value="Nam">Nam</option>
                                        <option value="Nữ">Nữ</option>
                                        <option value="Khác">Khác</option>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Tài khoản</label>
                                    <select class="form-select" name="accountID" required>
                                        <c:forEach items="${accountList}" var="account">
                                            <option value="${account.accountID}">${account.username}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                            <button type="button" class="btn btn-primary" onclick="submitEditCustomer()">Cập
                                nhật</button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- View Orders Modal -->
            <div class="modal fade" id="viewOrdersModal" tabindex="-1">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Lịch sử đơn hàng</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th>Mã đơn hàng</th>
                                            <th>Ngày đặt</th>
                                            <th>Tổng tiền</th>
                                            <th>Trạng thái</th>
                                            <th>Thao tác</th>
                                        </tr>
                                    </thead>
                                    <tbody id="ordersTableBody">
                                        <!-- Orders will be loaded here -->
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
            <script>
                function editCustomer(id) {
                    $.get('customer?action=edit&id=' + id, function (data) {
                        $('#editCustomerForm [name=customerID]').val(data.customerID);
                        $('#editCustomerForm [name=fullName]').val(data.fullName);
                        $('#editCustomerForm [name=email]').val(data.email);
                        $('#editCustomerForm [name=phone]').val(data.phone);
                        $('#editCustomerForm [name=address]').val(data.address);
                        $('#editCustomerForm [name=dateOfBirth]').val(data.dateOfBirth);
                        $('#editCustomerForm [name=gender]').val(data.gender);
                        $('#editCustomerForm [name=accountID]').val(data.accountID);
                        $('#editCustomerModal').modal('show');
                    });
                }

                function deleteCustomer(id) {
                    if (confirm('Bạn có chắc chắn muốn xóa?')) {
                        $.post('customer?action=delete&id=' + id, function () {
                            location.reload();
                        });
                    }
                }

                function submitAddCustomer() {
                    $.post('customer?action=add', $('#addCustomerForm').serialize(), function () {
                        location.reload();
                    });
                }

                function submitEditCustomer() {
                    $.post('customer?action=update', $('#editCustomerForm').serialize(), function () {
                        location.reload();
                    });
                }

                function viewOrders(customerId) {
                    $.get('customer?action=orders&id=' + customerId, function (data) {
                        var html = '';
                        data.forEach(function (order) {
                            html += '<tr>';
                            html += '<td>' + order.invoiceID + '</td>';
                            html += '<td>' + order.date + '</td>';
                            html += '<td>' + order.totalMoney + '</td>';
                            html += '<td>' + order.status + '</td>';
                            html += '<td>';
                            html += '<button class="btn btn-sm btn-info" onclick="viewOrderDetails(' + order.invoiceID + ')">';
                            html += '<i class="fas fa-eye"></i>';
                            html += '</button>';
                            html += '</td>';
                            html += '</tr>';
                        });
                        $('#ordersTableBody').html(html);
                        $('#viewOrdersModal').modal('show');
                    });
                }

                function viewOrderDetails(orderId) {
                    // Implement order details view
                }

                // Search and filter functionality
                $('#searchButton').click(function () {
                    var searchText = $('#searchInput').val();
                    // Implement search logic
                });

                $('#genderFilter').change(function () {
                    var gender = $(this).val();
                    // Implement filter logic
                });
            </script>
        </body>

        </html>