<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
        <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
            <%@page contentType="text/html" pageEncoding="UTF-8" %>
                <!DOCTYPE html>
                <html>

                <head>
                    <meta charset="UTF-8">
                    <title>Báo Cáo Thống Kê - Admin</title>
                    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

                    <!-- Bootstrap CSS -->
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css"
                        rel="stylesheet">

                    <!-- Font Awesome -->
                    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"
                        rel="stylesheet">

                    <!-- CSS Admin simple (không xung đột) -->
                    <link
                        href="${pageContext.request.contextPath}/css/admin-simple.css?v=<%= System.currentTimeMillis() / 1000 %>"
                        rel="stylesheet" type="text/css" />

                </head>

                <body class="admin-page">
                    <div class="admin-layout">
                        <!-- Sidebar -->
                        <jsp:include page="LeftAdmin.jsp" />

                        <!-- Main Content -->
                        <main class="main-content">
                            <div class="container-fluid pt-4">

                                <!-- Page Header -->
                                <div class="row mb-4">
                                    <div class="col-lg-12">
                                        <div class="card">
                                            <div class="card-header">
                                                <h5 class="mb-0"><strong><i class="fas fa-chart-line"></i> Báo Cáo
                                                        Thống Kê</strong></h5>
                                            </div>
                                            <div class="card-body">
                                                <p class="text-muted">Xem báo cáo chi tiết về sản phẩm bán chạy và
                                                    khách hàng VIP của cửa hàng.</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Top 10 Products Section -->
                                <div class="row mb-4">
                                    <div class="col-lg-12">
                                        <div class="card">
                                            <div class="card-header">
                                                <div class="row">
                                                    <div class="col-sm-6">
                                                        <h5 class="mb-0"><strong><i class="fas fa-trophy"></i> Top
                                                                10 Sản Phẩm Bán Chạy</strong></h5>
                                                    </div>
                                                    <div class="col-sm-6 text-right">
                                                        <form action="xuatExcelTop10ProductControl" method="get"
                                                            style="display: inline-block;">
                                                            <button type="submit" class="btn btn-success">
                                                                <i class="fa fa-file-excel"></i> Xuất Excel
                                                            </button>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="card-body">
                                                <c:if test="${mess != null}">
                                                    <div class="alert alert-success" role="alert">${mess}</div>
                                                </c:if>

                                                <!-- Search Box -->
                                                <div class="mb-3">
                                                    <input type="text" id="searchProducts" class="form-control"
                                                        placeholder="Tìm kiếm sản phẩm...">
                                                </div>

                                                <!-- Products Table -->
                                                <div class="table-responsive">
                                                    <table class="table table-hover">
                                                        <thead>
                                                            <tr>
                                                                <th>Xếp hạng</th>
                                                                <th>ID</th>
                                                                <th>Tên sản phẩm</th>
                                                                <th>Hình ảnh</th>
                                                                <th>Giá (VNĐ)</th>
                                                                <th>Số lượng đã bán</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody id="productsTableBody">
                                                            <c:set var="rank" value="1" />
                                                            <c:forEach items="${listTop10Product}" var="topProduct">
                                                                <c:forEach items="${listAllProduct}" var="product">
                                                                    <c:if test="${topProduct.productID == product.id}">
                                                                        <tr>
                                                                            <td>
                                                                                <c:choose>
                                                                                    <c:when test="${rank == 1}">
                                                                                        <span class="text-warning"><i
                                                                                                class="fas fa-medal"></i>
                                                                                            #${rank}</span>
                                                                                    </c:when>
                                                                                    <c:when test="${rank == 2}">
                                                                                        <span class="text-secondary"><i
                                                                                                class="fas fa-medal"></i>
                                                                                            #${rank}</span>
                                                                                    </c:when>
                                                                                    <c:when test="${rank == 3}">
                                                                                        <span class="text-info"><i
                                                                                                class="fas fa-medal"></i>
                                                                                            #${rank}</span>
                                                                                    </c:when>
                                                                                    <c:otherwise>
                                                                                        <span
                                                                                            class="text-muted">#${rank}</span>
                                                                                    </c:otherwise>
                                                                                </c:choose>
                                                                            </td>
                                                                            <td>${product.id}</td>
                                                                            <td>${product.name}</td>
                                                                            <td>
                                                                                <img src="${product.image}"
                                                                                    alt="${product.name}"
                                                                                    style="width: 50px; height: 50px; object-fit: cover; border-radius: 4px;">
                                                                            </td>
                                                                            <td>
                                                                                <fmt:formatNumber
                                                                                    value="${product.price}"
                                                                                    pattern="#,###"
                                                                                    var="productPrice" />
                                                                                ${fn:replace(productPrice, ',',
                                                                                '.')} VNĐ
                                                                            </td>
                                                                            <td>
                                                                                <span
                                                                                    class="text-success font-weight-bold">${topProduct.soLuongDaBan}</span>
                                                                            </td>
                                                                        </tr>
                                                                        <c:set var="rank" value="${rank + 1}" />
                                                                    </c:if>
                                                                </c:forEach>
                                                            </c:forEach>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Top 5 Customers Section -->
                                <div class="row mb-4">
                                    <div class="col-lg-12">
                                        <div class="card">
                                            <div class="card-header">
                                                <div class="row">
                                                    <div class="col-sm-6">
                                                        <h5 class="mb-0"><strong><i class="fas fa-users"></i> Top 5
                                                                Khách Hàng VIP</strong></h5>
                                                    </div>
                                                    <div class="col-sm-6 text-right">
                                                        <form action="xuatExcelTop5CustomerControl" method="get"
                                                            style="display: inline-block;">
                                                            <button type="submit" class="btn btn-success">
                                                                <i class="fa fa-file-excel"></i> Xuất Excel
                                                            </button>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="card-body">
                                                <!-- Search Box -->
                                                <div class="mb-3">
                                                    <input type="text" id="searchCustomers" class="form-control"
                                                        placeholder="Tìm kiếm khách hàng...">
                                                </div>

                                                <!-- Customers Table -->
                                                <div class="table-responsive">
                                                    <table class="table table-hover">
                                                        <thead>
                                                            <tr>
                                                                <th>Xếp hạng</th>
                                                                <th>ID</th>
                                                                <th>Tên đăng nhập</th>
                                                                <th>Email</th>
                                                                <th>Tổng chi tiêu (VNĐ)</th>
                                                                <th>Hạng khách hàng</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody id="customersTableBody">
                                                            <c:set var="customerRank" value="1" />
                                                            <c:forEach items="${listTop5KhachHang}" var="topCustomer">
                                                                <c:forEach items="${listAllAccount}" var="account">
                                                                    <c:if
                                                                        test="${topCustomer.userID == account.id && topCustomer.tongChiTieu != 0.0}">
                                                                        <tr>
                                                                            <td>
                                                                                <c:choose>
                                                                                    <c:when test="${customerRank == 1}">
                                                                                        <span class="text-warning"><i
                                                                                                class="fas fa-crown"></i>
                                                                                            #${customerRank}</span>
                                                                                    </c:when>
                                                                                    <c:when test="${customerRank == 2}">
                                                                                        <span class="text-secondary"><i
                                                                                                class="fas fa-crown"></i>
                                                                                            #${customerRank}</span>
                                                                                    </c:when>
                                                                                    <c:when test="${customerRank == 3}">
                                                                                        <span class="text-info"><i
                                                                                                class="fas fa-crown"></i>
                                                                                            #${customerRank}</span>
                                                                                    </c:when>
                                                                                    <c:otherwise>
                                                                                        <span
                                                                                            class="text-muted">#${customerRank}</span>
                                                                                    </c:otherwise>
                                                                                </c:choose>
                                                                            </td>
                                                                            <td>${account.id}</td>
                                                                            <td>${account.user}</td>
                                                                            <td>${account.email}</td>
                                                                            <td>
                                                                                <fmt:formatNumber
                                                                                    value="${topCustomer.tongChiTieu}"
                                                                                    pattern="#,###"
                                                                                    var="customerTotal" />
                                                                                <span
                                                                                    class="text-success font-weight-bold">${fn:replace(customerTotal,
                                                                                    ',', '.')} VNĐ</span>
                                                                            </td>
                                                                            <td>
                                                                                <c:choose>
                                                                                    <c:when
                                                                                        test="${topCustomer.tongChiTieu >= 10000000}">
                                                                                        <span class="badge"
                                                                                            style="background-color: #FFD700; color: #000;"><i
                                                                                                class="fas fa-star"></i>
                                                                                            Diamond</span>
                                                                                    </c:when>
                                                                                    <c:when
                                                                                        test="${topCustomer.tongChiTieu >= 5000000}">
                                                                                        <span class="badge"
                                                                                            style="background-color: #C0C0C0; color: #000;"><i
                                                                                                class="fas fa-star"></i>
                                                                                            Platinum</span>
                                                                                    </c:when>
                                                                                    <c:when
                                                                                        test="${topCustomer.tongChiTieu >= 2000000}">
                                                                                        <span class="badge"
                                                                                            style="background-color: #FFD700; color: #000;"><i
                                                                                                class="fas fa-star"></i>
                                                                                            Gold</span>
                                                                                    </c:when>
                                                                                    <c:when
                                                                                        test="${topCustomer.tongChiTieu >= 1000000}">
                                                                                        <span class="badge"
                                                                                            style="background-color: #C0C0C0; color: #000;"><i
                                                                                                class="fas fa-star"></i>
                                                                                            Silver</span>
                                                                                    </c:when>
                                                                                    <c:otherwise>
                                                                                        <span class="badge"
                                                                                            style="background-color: #CD7F32; color: #fff;"><i
                                                                                                class="fas fa-star"></i>
                                                                                            Bronze</span>
                                                                                    </c:otherwise>
                                                                                </c:choose>
                                                                            </td>
                                                                        </tr>
                                                                        <c:set var="customerRank"
                                                                            value="${customerRank + 1}" />
                                                                    </c:if>
                                                                </c:forEach>
                                                            </c:forEach>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </main>
                    </div>

                    <!-- Minimal JavaScript -->
                    <script>
                        // Search functionality for products
                        document.getElementById('searchProducts').addEventListener('keyup', function () {
                            const searchText = this.value.toLowerCase();
                            const tableRows = document.querySelectorAll('#productsTableBody tr');
                            tableRows.forEach(row => {
                                const text = row.textContent.toLowerCase();
                                row.style.display = text.includes(searchText) ? '' : 'none';
                            });
                        });

                        // Search functionality for customers
                        document.getElementById('searchCustomers').addEventListener('keyup', function () {
                            const searchText = this.value.toLowerCase();
                            const tableRows = document.querySelectorAll('#customersTableBody tr');
                            tableRows.forEach(row => {
                                const text = row.textContent.toLowerCase();
                                row.style.display = text.includes(searchText) ? '' : 'none';
                            });
                        });
                    </script>
                </body>

                </html>