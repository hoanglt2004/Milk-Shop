<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="WEB-INF/bootstrap-template.jsp" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Lịch sử mua hàng - Milk Shop</title>
    <!-- Custom CSS -->
    <link rel="stylesheet" href="css/style.css"/>

    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Roboto', Arial, sans-serif;
        }

        .profile-container {
            min-height: 100vh;
            padding-top: 100px;
        }

        .profile-sidebar {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 0;
            margin-bottom: 30px;
        }

        .sidebar-header {
            background: linear-gradient(135deg, #da1919 0%, #c41e3a 100%);
            color: white;
            padding: 20px;
            border-radius: 10px 10px 0 0;
            text-align: center;
        }

        .sidebar-header h4 {
            margin: 0;
            font-weight: 500;
        }

        .sidebar-menu {
            padding: 0;
        }

        .sidebar-menu .menu-item {
            display: block;
            padding: 15px 20px;
            color: #333;
            text-decoration: none;
            border-bottom: 1px solid #eee;
            transition: all 0.3s ease;
        }

        .sidebar-menu .menu-item:hover {
            background-color: #f8f9fa;
            color: #da1919;
            text-decoration: none;
        }

        .sidebar-menu .menu-item.active {
            background-color: #da1919;
            color: white;
        }

        .sidebar-menu .menu-item.active:hover {
            background-color: #c41e3a;
            color: white;
        }

        .sidebar-menu .menu-item:last-child {
            border-bottom: none;
            border-radius: 0 0 10px 10px;
        }

        .sidebar-menu .menu-item i {
            margin-right: 10px;
            width: 20px;
        }

        .main-content {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            min-height: 600px;
        }

        .content-header {
            background: linear-gradient(135deg, #da1919 0%, #c41e3a 100%);
            color: white;
            padding: 20px 30px;
            border-radius: 10px 10px 0 0;
            margin-bottom: 0;
        }

        .content-header h3 {
            margin: 0;
            font-weight: 500;
        }

        .content-body {
            padding: 30px;
        }

        .stats-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: white;
            border: 1px solid #e1e5e9;
            border-radius: 12px;
            padding: 20px;
            text-align: center;
            transition: all 0.3s ease;
        }

        .stat-card:hover {
            box-shadow: 0 4px 15px rgba(218, 25, 25, 0.1);
            transform: translateY(-2px);
        }

        .stat-card .icon {
            font-size: 2rem;
            color: #da1919;
            margin-bottom: 10px;
        }

        .stat-card .value {
            font-size: 1.5rem;
            font-weight: 600;
            color: #333;
            margin-bottom: 5px;
        }

        .stat-card .label {
            color: #666;
            font-size: 0.9rem;
        }

        .filter-section {
            background: #f8f9fa;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 30px;
        }

        .filter-row {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            align-items: end;
        }

        .filter-group label {
            font-weight: 500;
            color: #333;
            margin-bottom: 5px;
            display: block;
        }

        .filter-group select,
        .filter-group input {
            width: 100%;
            padding: 10px 12px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 14px;
        }

        .filter-group select:focus,
        .filter-group input:focus {
            border-color: #da1919;
            outline: none;
            box-shadow: 0 0 0 2px rgba(218, 25, 25, 0.1);
        }

        .btn-filter {
            background: linear-gradient(135deg, #da1919 0%, #c41e3a 100%);
            color: white;
            border: none;
            border-radius: 6px;
            padding: 10px 20px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-filter:hover {
            background: linear-gradient(135deg, #c41e3a 0%, #a91729 100%);
            transform: translateY(-1px);
        }

        .order-card {
            background: white;
            border: 1px solid #e1e5e9;
            border-radius: 12px;
            margin-bottom: 20px;
            overflow: hidden;
            transition: all 0.3s ease;
        }

        .order-card:hover {
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        .order-header {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            padding: 15px 20px;
            border-bottom: 1px solid #e1e5e9;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .order-id {
            font-weight: 600;
            color: #da1919;
            font-size: 1.1rem;
        }

        .order-date {
            color: #666;
            font-size: 0.9rem;
        }

        .order-body {
            padding: 20px;
        }

        .order-info {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 20px;
            margin-bottom: 20px;
        }

        .info-item {
            text-align: center;
        }

        .info-label {
            color: #666;
            font-size: 0.85rem;
            margin-bottom: 5px;
        }

        .info-value {
            font-weight: 600;
            color: #333;
        }

        .status-badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 500;
            text-transform: uppercase;
        }

        .status-pending {
            background: #fff3cd;
            color: #856404;
        }

        .status-processing {
            background: #cce5ff;
            color: #004085;
        }

        .status-completed {
            background: #d4edda;
            color: #155724;
        }

        .status-cancelled {
            background: #f8d7da;
            color: #721c24;
        }

        .order-actions {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }

        .btn-action {
            padding: 8px 15px;
            border: none;
            border-radius: 6px;
            font-size: 0.85rem;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }

        .btn-view {
            background: #007bff;
            color: white;
        }

        .btn-view:hover {
            background: #0056b3;
            color: white;
        }

        .btn-cancel {
            background: #dc3545;
            color: white;
        }

        .btn-cancel:hover {
            background: #b02a37;
            color: white;
        }

        .btn-reorder {
            background: #28a745;
            color: white;
        }

        .btn-reorder:hover {
            background: #1e7e34;
            color: white;
        }

        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #666;
        }

        .empty-state i {
            font-size: 4rem;
            color: #ddd;
            margin-bottom: 20px;
        }

        .empty-state h4 {
            margin-bottom: 10px;
            color: #333;
        }

        .modal {
            z-index: 1050;
        }

        .modal-header {
            background: linear-gradient(135deg, #da1919 0%, #c41e3a 100%);
            color: white;
            border-bottom: none;
        }

        .modal-header .close {
            color: white;
            opacity: 0.8;
        }

        .modal-header .close:hover {
            opacity: 1;
        }

        @media (max-width: 768px) {
            .profile-container {
                padding-top: 20px;
            }

            .content-body {
                padding: 20px;
            }

            .content-header {
                padding: 15px 20px;
            }

            .order-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 10px;
            }

            .filter-row {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>

<body onload="loadAmountCart()">
    <!-- Kiểm tra session -->
    <c:if test="${empty sessionScope.acc}">
        <script>
            alert('Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại.');
            window.location.href = 'Login.jsp';
        </script>
    </c:if>

    <jsp:include page="Menu.jsp"></jsp:include>

    <div class="profile-container">
        <div class="container-fluid">
            <div class="row">
                <!-- Sidebar -->
                <div class="col-lg-3 col-md-4">
                    <div class="profile-sidebar">
                        <div class="sidebar-header">
                            <h4><i class="fas fa-user-circle mr-2"></i>Tài khoản của tôi</h4>
                        </div>
                        <div class="sidebar-menu">
                            <a href="editProfile" class="menu-item">
                                <i class="fas fa-user-edit"></i>
                                Thông tin tài khoản
                            </a>
                            <a href="orderHistory" class="menu-item active">
                                <i class="fas fa-history"></i>
                                Lịch sử mua hàng
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Main Content -->
                <div class="col-lg-9 col-md-8">
                    <div class="main-content">
                        <div class="content-header">
                            <h3><i class="fas fa-history mr-3"></i>Lịch sử mua hàng</h3>
                        </div>

                        <div class="content-body">
                            <!-- Thông báo -->
                            <c:if test="${not empty mess}">
                                <div class="alert alert-success" role="alert">
                                    <i class="fas fa-check-circle mr-2"></i>${mess}
                                </div>
                            </c:if>
                            <c:if test="${not empty error}">
                                <div class="alert alert-danger" role="alert">
                                    <i class="fas fa-exclamation-circle mr-2"></i>${error}
                                </div>
                            </c:if>

                            <!-- Statistics Cards -->
                            <div class="stats-cards">
                                <div class="stat-card">
                                    <div class="icon">
                                        <i class="fas fa-shopping-bag"></i>
                                    </div>
                                    <div class="value">${totalOrders}</div>
                                    <div class="label">Tổng đơn hàng</div>
                                </div>
                                <div class="stat-card">
                                    <div class="icon">
                                        <i class="fas fa-check-circle"></i>
                                    </div>
                                    <div class="value">${completedOrders}</div>
                                    <div class="label">Đã hoàn thành</div>
                                </div>
                                <div class="stat-card">
                                    <div class="icon">
                                        <i class="fas fa-coins"></i>
                                    </div>
                                    <div class="value">
                                        <fmt:formatNumber value="${totalSpent}" pattern="#,###"
                                            var="formattedTotal" />
                                        ${fn:replace(formattedTotal, ',', '.')} VNĐ
                                    </div>
                                    <div class="label">Tổng chi tiêu</div>
                                </div>
                            </div>

                            <!-- Filter Section -->
                            <div class="filter-section">
                                <form method="get" action="orderHistory">
                                    <div class="filter-row">
                                        <div class="filter-group">
                                            <label>Trạng thái</label>
                                            <select name="status">
                                                <option value="all" ${statusFilter=='all' ? 'selected'
                                                    : '' }>Tất cả</option>
                                                <option value="Chờ xác nhận"
                                                    ${statusFilter=='Chờ xác nhận' ? 'selected' : '' }>
                                                    Chờ xác nhận</option>
                                                <option value="Đang giao" ${statusFilter=='Đang giao'
                                                    ? 'selected' : '' }>Đang giao</option>
                                                <option value="Hoàn thành" ${statusFilter=='Hoàn thành'
                                                    ? 'selected' : '' }>Hoàn thành</option>
                                                <option value="Đã hủy" ${statusFilter=='Đã hủy'
                                                    ? 'selected' : '' }>Đã hủy</option>
                                            </select>
                                        </div>
                                        <div class="filter-group">
                                            <label>Thời gian</label>
                                            <select name="time">
                                                <option value="" ${empty timeFilter ? 'selected' : '' }>
                                                    Tất cả</option>
                                                <option value="30days" ${timeFilter=='30days'
                                                    ? 'selected' : '' }>30 ngày qua</option>
                                                <option value="3months" ${timeFilter=='3months'
                                                    ? 'selected' : '' }>3 tháng qua</option>
                                                <option value="6months" ${timeFilter=='6months'
                                                    ? 'selected' : '' }>6 tháng qua</option>
                                                <option value="1year" ${timeFilter=='1year' ? 'selected'
                                                    : '' }>1 năm qua</option>
                                            </select>
                                        </div>
                                        <div class="filter-group">
                                            <label>Tìm kiếm</label>
                                            <input type="text" name="search"
                                                placeholder="Mã đơn hàng..." value="${searchKeyword}">
                                        </div>
                                        <div class="filter-group">
                                            <button type="submit" class="btn-filter">
                                                <i class="fas fa-search mr-1"></i>Lọc
                                            </button>
                                        </div>
                                    </div>
                                </form>
                            </div>

                            <!-- Orders List -->
                            <c:choose>
                                <c:when test="${not empty invoiceList}">
                                    <c:forEach var="invoice" items="${invoiceList}">
                                        <div class="order-card">
                                            <div class="order-header">
                                                <div>
                                                    <div class="order-id">Đơn hàng #${invoice.maHD}
                                                    </div>
                                                    <div class="order-date">
                                                        <fmt:formatDate value="${invoice.ngayXuat}"
                                                            pattern="dd/MM/yyyy HH:mm" />
                                                    </div>
                                                </div>
                                                <div>
                                                    <c:choose>
                                                        <c:when
                                                            test="${invoice.status == 'Chờ xác nhận'}">
                                                            <span
                                                                class="status-badge status-pending">${invoice.status}</span>
                                                        </c:when>
                                                        <c:when test="${invoice.status == 'Đang giao'}">
                                                            <span
                                                                class="status-badge status-processing">${invoice.status}</span>
                                                        </c:when>
                                                        <c:when
                                                            test="${invoice.status == 'Hoàn thành'}">
                                                            <span
                                                                class="status-badge status-completed">${invoice.status}</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span
                                                                class="status-badge status-cancelled">${invoice.status}</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>

                                            <div class="order-body">
                                                <div class="order-info">
                                                    <div class="info-item">
                                                        <div class="info-label">Tổng tiền</div>
                                                        <div class="info-value">
                                                            <fmt:formatNumber value="${invoice.tongGia}"
                                                                pattern="#,###" var="orderTotal" />
                                                            ${fn:replace(orderTotal, ',', '.')} VNĐ
                                                        </div>
                                                    </div>
                                                    <c:if test="${not empty invoice.deliveryDate}">
                                                        <div class="info-item">
                                                            <div class="info-label">Ngày giao</div>
                                                            <div class="info-value">
                                                                <fmt:formatDate
                                                                    value="${invoice.deliveryDate}"
                                                                    pattern="dd/MM/yyyy" />
                                                            </div>
                                                        </div>
                                                    </c:if>
                                                </div>

                                                <div class="order-actions">
                                                    <button class="btn-action btn-view"
                                                        onclick="viewOrderDetail(${invoice.maHD})">
                                                        <i class="fas fa-eye"></i>Xem chi tiết
                                                    </button>
                                                    <c:if test="${invoice.status == 'Hoàn thành'}">
                                                        <a href="#" class="btn-action btn-reorder">
                                                            <i class="fas fa-redo"></i>Mua lại
                                                        </a>
                                                    </c:if>
                                                    <c:if test="${invoice.status == 'Chờ xác nhận'}">
                                                        <button class="btn-action btn-cancel"
                                                            onclick="cancelOrder(${invoice.maHD})">
                                                            <i class="fas fa-times"></i>Hủy đơn
                                                        </button>
                                                    </c:if>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <div class="empty-state">
                                        <i class="fas fa-shopping-bag"></i>
                                        <h4>Chưa có đơn hàng nào</h4>
                                        <p>Bạn chưa có đơn hàng nào. Hãy bắt đầu mua sắm ngay!</p>
                                        <a href="home" class="btn btn-primary mt-3">
                                            <i class="fas fa-shopping-cart mr-2"></i>Mua sắm ngay
                                        </a>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Order Detail Modal -->
    <div class="modal fade" id="orderDetailModal" tabindex="-1" role="dialog">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><i class="fas fa-receipt mr-2"></i>Chi tiết đơn hàng</h5>
                    <button type="button" class="close" data-dismiss="modal">
                        <span>&times;</span>
                    </button>
                </div>
                <div class="modal-body" id="orderDetailContent">
                    <!-- Content will be loaded here -->
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script>
        function loadAmountCart() {
            $.ajax({
                url: "/WebsiteBanSua/loadAllAmountCart",
                type: "get",
                success: function (responseData) {
                    document.getElementById("amountCart").innerHTML = responseData;
                }
            });
        }

        function viewOrderDetail(orderId) {
            // Show loading
            $('#orderDetailContent').html('<div class="text-center"><i class="fas fa-spinner fa-spin"></i> Đang tải...</div>');
            $('#orderDetailModal').modal('show');

            // Load order details
            $.ajax({
                url: 'orderDetail',
                type: 'GET',
                data: { orderId: orderId },
                success: function (response) {
                    $('#orderDetailContent').html(response);
                },
                error: function () {
                    $('#orderDetailContent').html('<div class="alert alert-danger">Có lỗi khi tải chi tiết đơn hàng.</div>');
                }
            });
        }

        function cancelOrder(orderId) {
            if (confirm('Bạn có chắc muốn hủy đơn hàng này?')) {
                $.ajax({
                    url: 'orderHistory',
                    type: 'POST',
                    data: {
                        action: 'cancelOrder',
                        invoiceId: orderId
                    },
                    success: function () {
                        location.reload();
                    },
                    error: function () {
                        alert('Có lỗi khi hủy đơn hàng. Vui lòng thử lại.');
                    }
                });
            }
        }

        // Auto-hide alerts after 5 seconds
        setTimeout(function () {
            $('.alert').fadeOut('slow');
        }, 5000);

        // Sidebar menu active state
        document.addEventListener('DOMContentLoaded', function () {
            const currentPath = window.location.pathname;
            const menuItems = document.querySelectorAll('.sidebar-menu .menu-item');

            menuItems.forEach(function (item) {
                item.classList.remove('active');
                if (currentPath.includes('orderHistory') && item.getAttribute('href') === 'orderHistory') {
                    item.classList.add('active');
                } else if (currentPath.includes('editProfile') && item.getAttribute('href') === 'editProfile') {
                    item.classList.add('active');
                }
            });
        });
    </script>
</body>

</html>