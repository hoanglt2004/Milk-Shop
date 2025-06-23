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

                    <!-- ONLY ADMIN CSS -->
                    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"
                        rel="stylesheet">
                    <link href="css/admin-simple.css" rel="stylesheet" type="text/css" />

                </head>

                <body class="admin-page">
                    <div class="container-fluid">
                        <div class="row">
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
                    </div>

                    <!-- Chart.js -->
                    <script src="https://cdn.jsdelivr.net/npm/chart.js@3.9.1/dist/chart.min.js"></script>

                    <!-- Custom JavaScript -->
                    <script>
                        // Function to format VND currency
                        function formatVND(value) {
                            return new Intl.NumberFormat('vi-VN').format(value) + ' VNĐ';
                        }

                        // Weekly Revenue Pie Chart
                        const weeklyCtx = document.getElementById('weeklyChart').getContext('2d');
                        const weeklyChart = new Chart(weeklyCtx, {
                            type: 'pie',
                            data: {
                                labels: ["Chủ nhật", "Thứ 7", "Thứ 6", "Thứ 5", "Thứ 4", "Thứ 3", "Thứ 2"],
                                datasets: [{
                                    data: [${ totalMoney1 }, ${ totalMoney7 }, ${ totalMoney6 }, ${ totalMoney5 }, ${ totalMoney4 }, ${ totalMoney3 }, ${ totalMoney2 }],
                                    backgroundColor: [
                                        "#FF6384", "#36A2EB", "#FFCE56", "#4BC0C0",
                                        "#9966FF", "#FF9F40", "#FF6384"
                                    ],
                                    borderWidth: 2,
                                    borderColor: "#fff"
                                }]
                            },
                            options: {
                                responsive: true,
                                maintainAspectRatio: true,
                                aspectRatio: 1,
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
                                                return context.label + ': ' + formatVND(context.parsed);
                                            }
                                        }
                                    }
                                }
                            }
                        });

                        // Monthly Revenue Bar Chart
                        const monthlyCtx = document.getElementById('monthlyChart').getContext('2d');
                        const monthlyChart = new Chart(monthlyCtx, {
                            type: 'bar',
                            data: {
                                labels: ["T1", "T2", "T3", "T4", "T5", "T6", "T7", "T8", "T9", "T10", "T11", "T12"],
                                datasets: [{
                                    label: 'Doanh thu (VNĐ)',
                                    data: [${ totalMoneyMonth1 }, ${ totalMoneyMonth2 }, ${ totalMoneyMonth3 }, ${ totalMoneyMonth4 }, ${ totalMoneyMonth5 }, ${ totalMoneyMonth6 }, ${ totalMoneyMonth7 }, ${ totalMoneyMonth8 }, ${ totalMoneyMonth9 }, ${ totalMoneyMonth10 }, ${ totalMoneyMonth11 }, ${ totalMoneyMonth12 }],
                                    backgroundColor: 'rgba(54, 162, 235, 0.2)',
                                    borderColor: 'rgba(54, 162, 235, 1)',
                                    borderWidth: 1
                                }]
                            },
                            options: {
                                responsive: true,
                                maintainAspectRatio: true,
                                aspectRatio: 1,
                                scales: {
                                    y: {
                                        beginAtZero: true,
                                        ticks: {
                                            callback: function (value) {
                                                return formatVND(value);
                                            }
                                        }
                                    }
                                },
                                plugins: {
                                    legend: {
                                        display: false
                                    },
                                    tooltip: {
                                        callbacks: {
                                            label: function (context) {
                                                return 'Doanh thu: ' + formatVND(context.parsed.y);
                                            }
                                        }
                                    }
                                }
                            }
                        });

                        // Auto refresh every 30 seconds
                        setTimeout(function () {
                            location.reload();
                        }, 30000);
                    </script>
                </body>

                </html>