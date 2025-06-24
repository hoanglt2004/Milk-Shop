<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>Test Admin CSS</title>
            <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

            <!-- Bootstrap CSS -->
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" rel="stylesheet">

            <!-- Font Awesome -->
            <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">

            <!-- CSS Admin custom (kết hợp với Bootstrap) -->
            <link
                href="${pageContext.request.contextPath}/css/admin-bootstrap.css?v=<%= System.currentTimeMillis() / 1000 %>"
                rel="stylesheet" type="text/css" />

        </head>

        <body class="admin-page">
            <!-- Sidebar -->
            <jsp:include page="LeftAdmin.jsp" />

            <!-- Main Content -->
            <main class="main-content">
                <div class="container-fluid pt-4">
                    <section class="mb-4">
                        <h1>Test CSS Admin Panel</h1>
                        <p>Đây là trang test để kiểm tra sidebar và CSS của admin panel.</p>

                        <!-- Test Cards -->
                        <div class="row">
                            <div class="col-md-6 mb-4">
                                <div class="card">
                                    <div class="card-body">
                                        <h5>Bootstrap Card Test</h5>
                                        <p>Card này được style bởi Bootstrap + admin-bootstrap.css</p>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-6 mb-4">
                                <div class="stats-card text-center bg-primary">
                                    <i class="fas fa-users fa-3x mb-3"></i>
                                    <h2>1,234</h2>
                                    <h4>Custom Stats Card</h4>
                                    <p>Stats card với gradient background</p>
                                </div>
                            </div>
                        </div>

                        <!-- Test Table -->
                        <div class="card">
                            <div class="card-header">
                                <h5 class="mb-0">Test Table</h5>
                            </div>
                            <div class="card-body">
                                <table class="table table-hover">
                                    <thead>
                                        <tr>
                                            <th>Column 1</th>
                                            <th>Column 2</th>
                                            <th>Column 3</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>Row 1, Cell 1</td>
                                            <td>Row 1, Cell 2</td>
                                            <td>Row 1, Cell 3</td>
                                        </tr>
                                        <tr>
                                            <td>Row 2, Cell 1</td>
                                            <td>Row 2, Cell 2</td>
                                            <td>Row 2, Cell 3</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </section>
                </div>
            </main>

            <!-- JavaScript -->
            <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>