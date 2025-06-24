<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
        <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
            <%@page contentType="text/html" pageEncoding="UTF-8" %>
                <!DOCTYPE html>
                <html>

                <head>
                    <meta charset="UTF-8">
                    <title>Quản Lý Danh Mục - Admin</title>
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
                                <section class="mb-4">
                                    <div class="card">
                                        <div class="card-header">
                                            <div class="row">
                                                <div class="col-sm-6">
                                                    <h5 class="mb-0"><strong>Quản lý danh mục sản phẩm</strong></h5>
                                                </div>
                                                <div class="col-sm-6 text-right">
                                                    <a href="#addCategoryModal" class="btn btn-success"
                                                        data-toggle="modal">
                                                        <i class="fa fa-plus"></i> Thêm Danh Mục
                                                    </a>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="card-body">
                                            <c:if test="${error!=null }">
                                                <div class="alert alert-danger" role="alert">${error}</div>
                                            </c:if>
                                            <c:if test="${success!=null }">
                                                <div class="alert alert-success" role="alert">${success}</div>
                                            </c:if>

                                            <!-- Search Box -->
                                            <div class="mb-3">
                                                <input type="text" id="searchInput" class="form-control"
                                                    placeholder="Tìm kiếm danh mục...">
                                            </div>

                                            <!-- Table -->
                                            <div class="table-responsive">
                                                <table class="table table-hover">
                                                    <thead>
                                                        <tr>
                                                            <th scope="col">ID</th>
                                                            <th scope="col">Tên danh mục</th>
                                                            <th scope="col">Thao tác</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:forEach items="${listCategories}" var="c">
                                                            <tr>
                                                                <td>${c.cid}</td>
                                                                <td>${c.cname}</td>
                                                                <td>
                                                                    <button class="btn btn-warning btn-action"
                                                                        onclick="editCategory('${c.cid}')">
                                                                        <i class="fa fa-edit"></i>
                                                                    </button>
                                                                    <button class="btn btn-danger btn-action"
                                                                        onclick="deleteCategory('${c.cid}')">
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

                    <!-- Add Category Modal -->
                    <div class="modal fade" id="addCategoryModal" tabindex="-1" role="dialog">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <form action="addCategory" method="post">
                                    <div class="modal-header">
                                        <h5 class="modal-title">Thêm Danh Mục Mới</h5>
                                        <button type="button" class="close" data-dismiss="modal">
                                            <span>&times;</span>
                                        </button>
                                    </div>
                                    <div class="modal-body">
                                        <div class="form-group">
                                            <label>Tên danh mục:</label>
                                            <input type="text" name="cname" class="form-control" required>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary"
                                            data-dismiss="modal">Hủy</button>
                                        <button type="submit" class="btn btn-success">Thêm</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>

                    <!-- Edit Category Modal -->
                    <div class="modal fade" id="editCategoryModal" tabindex="-1" role="dialog">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <form action="editCategory" method="post">
                                    <div class="modal-header">
                                        <h5 class="modal-title">Chỉnh Sửa Danh Mục</h5>
                                        <button type="button" class="close" data-dismiss="modal">
                                            <span>&times;</span>
                                        </button>
                                    </div>
                                    <div class="modal-body">
                                        <input type="hidden" id="editCategoryId" name="categoryId">
                                        <div class="form-group">
                                            <label>Tên danh mục:</label>
                                            <input type="text" id="editCategoryName" name="categoryName"
                                                class="form-control" required>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary"
                                            data-dismiss="modal">Hủy</button>
                                        <button type="submit" class="btn btn-primary">Cập Nhật</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>

                    <!-- JavaScript đơn giản -->
                    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>

                    <script>
                        function editCategory(cid) {
                            fetch('getCategory?id=' + cid)
                                .then(response => response.json())
                                .then(data => {
                                    document.getElementById('editCategoryId').value = data.cid;
                                    document.getElementById('editCategoryName').value = data.cname;
                                    $('#editCategoryModal').modal('show');
                                })
                                .catch(error => {
                                    alert('Có lỗi xảy ra khi lấy thông tin danh mục');
                                    console.error('Error:', error);
                                });
                        }

                        function deleteCategory(cid) {
                            if (confirm('Bạn có chắc chắn muốn xóa danh mục này?')) {
                                window.location.href = 'deleteCategory?id=' + cid;
                            }
                        }

                        // Search functionality
                        document.getElementById('searchInput').addEventListener('keyup', function () {
                            const searchText = this.value.toLowerCase();
                            const tableRows = document.querySelectorAll('tbody tr');
                            tableRows.forEach(row => {
                                const text = row.textContent.toLowerCase();
                                row.style.display = text.includes(searchText) ? '' : 'none';
                            });
                        });
                    </script>
                </body>

                </html>