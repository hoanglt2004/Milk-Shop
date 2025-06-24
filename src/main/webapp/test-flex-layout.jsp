<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>Test Flexbox Layout Admin</title>
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" rel="stylesheet">

        <!-- Font Awesome -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">

        <!-- CSS Admin simple -->
        <link href="${pageContext.request.contextPath}/css/admin-simple.css" rel="stylesheet" type="text/css" />

        <style>
            .test-card {
                background: white;
                border-radius: 8px;
                padding: 20px;
                margin-bottom: 20px;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            }

            .color-box {
                width: 100px;
                height: 100px;
                margin: 10px;
                display: inline-block;
                border-radius: 8px;
                text-align: center;
                line-height: 100px;
                color: white;
                font-weight: bold;
            }

            .blue {
                background: #007bff;
            }

            .green {
                background: #28a745;
            }

            .red {
                background: #dc3545;
            }

            .yellow {
                background: #ffc107;
                color: #212529;
            }
        </style>
    </head>

    <body class="admin-page">
        <div class="admin-layout">
            <!-- Include Sidebar -->
            <jsp:include page="LeftAdmin.jsp" />

            <!-- Test Content -->
            <main class="main-content">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-12">
                            <div class="test-card">
                                <h2><i class="fas fa-check-circle text-success"></i> Test Flexbox Layout</h2>
                                <p>Trang này test layout flexbox mới cho admin panel.</p>

                                <h4>Kiểm tra layout:</h4>
                                <ul>
                                    <li>✅ Sidebar và content có nằm ngang hàng không?</li>
                                    <li>✅ Sidebar có width cố định 250px không?</li>
                                    <li>✅ Content có chiếm phần còn lại không?</li>
                                    <li>✅ Không có overlap giữa sidebar và content?</li>
                                    <li>✅ Responsive có hoạt động không?</li>
                                </ul>

                                <h4>Test Cards:</h4>
                                <div class="row">
                                    <div class="col-md-3">
                                        <div class="card text-center">
                                            <div class="card-body">
                                                <i class="fas fa-users fa-3x text-primary mb-3"></i>
                                                <h5>Users</h5>
                                                <p class="text-muted">1,234</p>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="card text-center">
                                            <div class="card-body">
                                                <i class="fas fa-box fa-3x text-success mb-3"></i>
                                                <h5>Products</h5>
                                                <p class="text-muted">567</p>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="card text-center">
                                            <div class="card-body">
                                                <i class="fas fa-shopping-cart fa-3x text-warning mb-3"></i>
                                                <h5>Orders</h5>
                                                <p class="text-muted">890</p>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="card text-center">
                                            <div class="card-body">
                                                <i class="fas fa-coins fa-3x text-danger mb-3"></i>
                                                <h5>Revenue</h5>
                                                <p class="text-muted">$12,345</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <h4>Color Test:</h4>
                                <div class="color-box blue">Blue</div>
                                <div class="color-box green">Green</div>
                                <div class="color-box red">Red</div>
                                <div class="color-box yellow">Yellow</div>

                                <div class="alert alert-success mt-4">
                                    <strong>Success!</strong> Nếu bạn thấy layout này hoạt động đúng, thì flexbox layout
                                    đã thành công!
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>

    </body>

    </html>