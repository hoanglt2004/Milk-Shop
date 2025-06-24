<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>Test Sidebar Admin</title>
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" rel="stylesheet">

        <!-- Font Awesome -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">

        <!-- CSS Admin simple -->
        <link href="${pageContext.request.contextPath}/css/admin-simple.css" rel="stylesheet" type="text/css" />

        <style>
            body {
                margin: 0;
                padding: 0;
                font-family: Arial, sans-serif;
            }

            .test-content {
                margin-left: 250px;
                padding: 20px;
                background-color: #f8f9fa;
                min-height: 100vh;
            }

            .test-card {
                background: white;
                border-radius: 8px;
                padding: 20px;
                margin-bottom: 20px;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
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
                                <h2>Test Sidebar Admin</h2>
                                <p>Trang này để test xem sidebar có hiển thị đúng không.</p>
                                <p>Nếu bạn thấy sidebar bên trái với các menu items, thì CSS đã hoạt động đúng.</p>
                                
                                <h4>Kiểm tra:</h4>
                                <ul>
                                    <li>Sidebar có hiển thị bên trái không?</li>
                                    <li>Các menu items có style đúng không?</li>
                                    <li>Hover effects có hoạt động không?</li>
                                    <li>Responsive có hoạt động không? (thử resize browser)</li>
                                </ul>
                                
                                <div class="alert alert-info">
                                    <strong>Lưu ý:</strong> Sidebar này được include từ file LeftAdmin.jsp và sử dụng CSS từ admin-simple.css
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