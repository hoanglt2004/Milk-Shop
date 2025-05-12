<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quản lý danh mục sản phẩm</title>
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
        <link href="css/manager.css" rel="stylesheet" type="text/css"/>
        <style>
            body { margin: 0; padding: 0; }
            .main-content { padding: 32px 24px 24px 24px; width: 100%; }
            .card { box-shadow: 0 2px 4px rgba(0,0,0,0.1); border-radius: 8px; }
            .card-header { background: #f8f9fa; border-bottom: 1px solid #dee2e6; }
            .btn-action { width: 36px; height: 36px; display: inline-flex; align-items: center; justify-content: center; padding: 0; margin: 0 2px; border-radius: 6px; font-size: 18px; transition: none !important; box-shadow: none !important; }
            .btn-action:active, .btn-action:focus { outline: none; box-shadow: none !important; transform: none !important; }
            .btn-warning.btn-action, .btn-danger.btn-action { background-color: inherit; }
            .btn-warning.btn-action { background-color: #ffc107; color: #212529; border: none; }
            .btn-warning.btn-action:hover { background-color: #e0a800; color: #fff; }
            .btn-danger.btn-action { background-color: #ff4d4f; color: #fff; border: none; }
            .btn-danger.btn-action:hover { background-color: #d32f2f; color: #fff; }
            .search-box { width: 300px; }
            .sidebar { min-height: 100vh; background: #f8f9fa; border-right: 1px solid #dee2e6; }
            main.col-md-9, main.col-lg-10 { margin-top: 0 !important; }
        </style>
    </head>
    <body>
        <div class="container-fluid">
            <div class="row">
                <!-- Menu Admin bên trái -->
                <jsp:include page="LeftAdmin.jsp"/>
                <!-- Nội dung chính bên phải -->
                <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 main-content">
                    <div class="container pt-4">
                        <section class="mb-4">
                            <div class="card">
                                <div class="card-header py-3 row">
                                    <div class="col-sm-6">
                                        <h5 class="mb-0 text-left"><strong>Quản lý danh mục sản phẩm</strong></h5>
                                    </div>
                                    <div class="col-sm-6 text-right">
                                        <a href="#addCategoryModal" class="btn btn-success" data-toggle="modal"><i class="fa fa-plus"></i></a>
                                    </div>
                                </div>
                                <c:if test="${error!=null }">
                                    <div class="alert alert-danger m-3" role="alert">${error}</div>
                                </c:if>
                                <c:if test="${success!=null }">
                                    <div class="alert alert-success m-3" role="alert">${success}</div>
                                </c:if>
                                <div class="card-body">
                                    <div class="d-flex justify-content-between align-items-center mb-3">
                                        <div class="input-group search-box">
                                            <input type="text" class="form-control" placeholder="Tìm kiếm..." id="searchInput">
                                            <div class="input-group-append">
                                                <button class="btn btn-outline-secondary" type="button"><i class="fa fa-search"></i></button>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="table-responsive">
                                        <table class="table table-hover text-nowrap">
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
                                                            <button class="btn btn-warning btn-action" onclick="editCategory('${c.cid}')"><i class="fa fa-edit"></i></button>
                                                            <button class="btn btn-danger btn-action" onclick="deleteCategory('${c.cid}')"><i class="fa fa-trash"></i></button>
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

        <!-- Modal thêm danh mục -->
        <div id="addCategoryModal" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form action="addCategory" method="post">
                        <div class="modal-header">
                            <h4 class="modal-title">Thêm danh mục mới</h4>
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <label>Tên danh mục</label>
                                <input name="cname" type="text" class="form-control" required>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
                            <input type="submit" class="btn btn-success" value="Add">
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Modal sửa danh mục -->
        <div id="editCategoryModal" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form action="editCategory" method="post">
                        <div class="modal-header">
                            <h4 class="modal-title">Sửa danh mục</h4>
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>
                        <div class="modal-body">
                            <input type="hidden" id="editCategoryId" name="cid">
                            <div class="form-group">
                                <label for="editCategoryName" class="form-label">Tên danh mục</label>
                                <input type="text" class="form-control" id="editCategoryName" name="cname" required>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
                            <input type="submit" class="btn btn-primary" value="Lưu thay đổi">
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
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
            document.getElementById('searchInput').addEventListener('keyup', function() {
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