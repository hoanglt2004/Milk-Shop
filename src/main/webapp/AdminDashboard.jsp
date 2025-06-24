<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
        <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
            <%@page contentType="text/html" pageEncoding="UTF-8" %>
                <!DOCTYPE html>
                <html>

                <head>
                    <meta charset="UTF-8">
                    <title>Dashboard - Admin</title>
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

                                <!-- Statistics Cards -->
                                <div class="row mb-5">
                                    <div class="col-lg-3 col-md-6 mb-4">
                                        <div class="stats-card text-center">
                                            <i class="fas fa-users fa-3x text-primary mb-3"></i>
                                            <h2 class="text-primary">${totalAccount}</h2>
                                            <h4>Tổng Tài Khoản</h4>
                                            <p class="text-muted">Khách hàng đã đăng ký</p>
                                        </div>
                                    </div>
                                    <div class="col-lg-3 col-md-6 mb-4">
                                        <div class="stats-card text-center">
                                            <i class="fas fa-box fa-3x text-success mb-3"></i>
                                            <h2 class="text-success">${totalProduct}</h2>
                                            <h4>Tổng Sản Phẩm</h4>
                                            <p class="text-muted">Sản phẩm trong kho</p>
                                        </div>
                                    </div>
                                    <div class="col-lg-3 col-md-6 mb-4">
                                        <div class="stats-card text-center">
                                            <i class="fas fa-shopping-cart fa-3x text-warning mb-3"></i>
                                            <h2 class="text-warning">${totalOrder}</h2>
                                            <h4>Tổng Đơn Hàng</h4>
                                            <p class="text-muted">Đơn hàng đã bán</p>
                                        </div>
                                    </div>
                                    <div class="col-lg-3 col-md-6 mb-4">
                                        <div class="stats-card text-center">
                                            <i class="fas fa-coins fa-3x text-danger mb-3"></i>
                                            <h2 class="text-danger">
                                                <fmt:formatNumber value="${totalMoney}" pattern="#,###"
                                                    var="formattedTotal" />
                                                ${fn:replace(formattedTotal, ',', '.')}
                                            </h2>
                                            <h4>Tổng Doanh Thu</h4>
                                            <p class="text-muted"><strong>VNĐ</strong></p>
                                        </div>
                                    </div>
                                </div>

                                <!-- Charts Row - Cân đối lại kích thước -->
                                <div class="row">
                                    <!-- Weekly Revenue Chart -->
                                    <div class="col-lg-6 mb-4">
                                        <div class="card h-100">
                                            <div class="card-header">
                                                <h5 class="mb-0"><strong><i class="fas fa-chart-pie"></i> Doanh Thu
                                                        Theo Thứ (VNĐ)</strong></h5>
                                            </div>
                                            <div class="card-body d-flex align-items-center justify-content-center">
                                                <canvas id="weeklyChart"
                                                    style="max-height: 500px; width: 100%;"></canvas>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Monthly Revenue Chart -->
                                    <div class="col-lg-6 mb-4">
                                        <div class="card h-100">
                                            <div class="card-header">
                                                <h5 class="mb-0"><strong><i class="fas fa-chart-bar"></i> Doanh Thu
                                                        Theo Tháng (VNĐ)</strong></h5>
                                            </div>
                                            <div class="card-body d-flex align-items-center justify-content-center">
                                                <canvas id="monthlyChart"
                                                    style="max-height: 500px; width: 100%;"></canvas>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </main>
                    </div>

                    <!-- JavaScript -->
                    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>

                    <!-- Chart.js for charts -->
                    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

                    <script>
                        // Weekly Revenue Chart
                        const weeklyCtx = document.getElementById('weeklyChart').getContext('2d');
                        const weeklyChart = new Chart(weeklyCtx, {
                            type: 'pie',
                            data: {
                                labels: ['Thứ 2', 'Thứ 3', 'Thứ 4', 'Thứ 5', 'Thứ 6', 'Thứ 7', 'Chủ Nhật'],
                                datasets: [{
                                    data: [
                                        ${ totalMoney1 }, ${ totalMoney2 }, ${ totalMoney3 }, ${ totalMoney4 },
                                        ${ totalMoney5 }, ${ totalMoney6 }, ${ totalMoney7 }
                                    ],
                                    backgroundColor: [
                                        '#FF6384', '#36A2EB', '#FFCE56', '#4BC0C0',
                                        '#9966FF', '#FF9F40', '#FF6384'
                                    ],
                                    borderWidth: 2,
                                    borderColor: '#fff'
                                }]
                            },
                            options: {
                                responsive: true,
                                maintainAspectRatio: false,
                                plugins: {
                                    legend: {
                                        position: 'bottom',
                                        labels: {
                                            padding: 20,
                                            usePointStyle: true
                                        }
                                    },
                                    tooltip: {
                                        callbacks: {
                                            label: function (context) {
                                                return context.label + ': ' +
                                                    new Intl.NumberFormat('vi-VN').format(context.parsed) + ' VNĐ';
                                            }
                                        }
                                    }
                                }
                            }
                        });

                        // Monthly Revenue Chart
                        const monthlyCtx = document.getElementById('monthlyChart').getContext('2d');
                        const monthlyChart = new Chart(monthlyCtx, {
                            type: 'bar',
                            data: {
                                labels: [
                                    'Tháng 1', 'Tháng 2', 'Tháng 3', 'Tháng 4', 'Tháng 5', 'Tháng 6',
                                    'Tháng 7', 'Tháng 8', 'Tháng 9', 'Tháng 10', 'Tháng 11', 'Tháng 12'
                                ],
                                datasets: [{
                                    label: 'Doanh Thu (VNĐ)',
                                    data: [
                                        ${ totalMoneyMonth1 }, ${ totalMoneyMonth2 }, ${ totalMoneyMonth3 }, ${ totalMoneyMonth4 },
                                        ${ totalMoneyMonth5 }, ${ totalMoneyMonth6 }, ${ totalMoneyMonth7 }, ${ totalMoneyMonth8 },
                                        ${ totalMoneyMonth9 }, ${ totalMoneyMonth10 }, ${ totalMoneyMonth11 }, ${ totalMoneyMonth12 }
                                    ],
                                    backgroundColor: 'rgba(54, 162, 235, 0.8)',
                                    borderColor: 'rgba(54, 162, 235, 1)',
                                    borderWidth: 2,
                                    borderRadius: 5
                                }]
                            },
                            options: {
                                responsive: true,
                                maintainAspectRatio: false,
                                plugins: {
                                    legend: {
                                        display: false
                                    },
                                    tooltip: {
                                        callbacks: {
                                            label: function (context) {
                                                return 'Doanh thu: ' +
                                                    new Intl.NumberFormat('vi-VN').format(context.parsed.y) + ' VNĐ';
                                            }
                                        }
                                    }
                                },
                                scales: {
                                    y: {
                                        beginAtZero: true,
                                        ticks: {
                                            callback: function (value) {
                                                return new Intl.NumberFormat('vi-VN', {
                                                    notation: 'compact',
                                                    compactDisplay: 'short'
                                                }).format(value) + ' VNĐ';
                                            }
                                        }
                                    },
                                    x: {
                                        grid: {
                                            display: false
                                        }
                                    }
                                }
                            }
                        });
                    </script>
                </body>

                </html>