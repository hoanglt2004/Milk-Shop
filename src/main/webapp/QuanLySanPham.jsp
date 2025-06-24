<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
      <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <!DOCTYPE html>
        <html>

        <head>
          <meta charset="UTF-8">
          <title>Quản Lý Sản Phẩm - Admin</title>
          <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

          <!-- Bootstrap CSS -->
          <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" rel="stylesheet">

          <!-- Font Awesome -->
          <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">

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
                          <h5 class="mb-0"><strong>Quản Lý Sản Phẩm</strong></h5>
                        </div>
                        <div class="col-sm-6 text-right">
                          <button onclick="showModal('addProductModal')" class="btn btn-success">
                            <i class="fa fa-plus"></i> Thêm Sản Phẩm
                          </button>
                          <form action="xuatExcelProductControl" method="get"
                            style="display: inline-block; margin-left: 10px;">
                            <button type="submit" class="btn btn-primary">
                              <i class="fa fa-file-excel"></i> Xuất Excel
                            </button>
                          </form>
                        </div>
                      </div>
                    </div>

                    <div class="card-body">
                      <c:if test="${error != null}">
                        <div class="alert alert-danger" role="alert">${error}</div>
                      </c:if>
                      <c:if test="${mess != null}">
                        <div class="alert alert-success" role="alert">${mess}</div>
                      </c:if>

                      <!-- Search Box -->
                      <div class="mb-3">
                        <input type="text" id="searchInput" class="form-control" placeholder="Tìm kiếm sản phẩm...">
                      </div>

                      <!-- Products Table -->
                      <div class="table-responsive">
                        <table class="table table-hover">
                          <thead>
                            <tr>
                              <th>ID</th>
                              <th>Tên sản phẩm</th>
                              <th>Hình ảnh</th>
                              <th>Giá (VNĐ)</th>
                              <th>Thao tác</th>
                            </tr>
                          </thead>
                          <tbody>
                            <c:forEach items="${listP}" var="product">
                              <tr>
                                <td>${product.id}</td>
                                <td>${product.name}</td>
                                <td>
                                  <img src="${product.image}" alt="${product.name}"
                                    style="width: 50px; height: 50px; object-fit: cover; border-radius: 4px;">
                                </td>
                                <td>
                                  <fmt:formatNumber value="${product.price}" pattern="#,###" var="productPrice" />
                                  ${fn:replace(productPrice, ',', '.')} VNĐ
                                </td>
                                <td>
                                  <a href="loadProduct?pid=${product.id}" class="btn btn-warning btn-action">
                                    <i class="fa fa-edit"></i>
                                  </a>
                                  <a href="delete?pid=${product.id}" class="btn btn-danger btn-action"
                                    onclick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm này?')">
                                    <i class="fa fa-trash"></i>
                                  </a>
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

          <!-- Add Product Modal -->
          <div class="modal" id="addProductModal">
            <div class="modal-dialog">
              <div class="modal-content">
                <form action="add" method="post">
                  <div class="modal-header">
                    <h5 class="modal-title">Thêm Sản Phẩm Mới</h5>
                    <button type="button" class="close" onclick="hideModal('addProductModal')">
                      <span>&times;</span>
                    </button>
                  </div>
                  <div class="modal-body">
                    <div class="form-group">
                      <label>Tên sản phẩm:</label>
                      <input type="text" name="name" class="form-control" required>
                    </div>
                    <div class="form-group">
                      <label>Hình ảnh (URL):</label>
                      <input type="text" name="image" class="form-control" required>
                    </div>
                    <div class="form-group">
                      <label>Giá:</label>
                      <input type="number" name="price" class="form-control" required>
                    </div>
                    <div class="form-group">
                      <label>Thương hiệu:</label>
                      <input type="text" name="title" class="form-control" required>
                    </div>
                    <div class="form-group">
                      <label>Mô tả:</label>
                      <textarea name="description" class="form-control" rows="3" required></textarea>
                    </div>
                    <div class="form-group">
                      <label>Danh mục:</label>
                      <select name="category" class="form-control" required>
                        <option value="">Chọn danh mục</option>
                        <c:forEach items="${listCC}" var="category">
                          <option value="${category.cid}">${category.cname}</option>
                        </c:forEach>
                      </select>
                    </div>
                  </div>
                  <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" onclick="hideModal('addProductModal')">Hủy</button>
                    <button type="submit" class="btn btn-success">Thêm Sản Phẩm</button>
                  </div>
                </form>
              </div>
            </div>
          </div>

          <!-- Minimal JavaScript -->
          <script>
            // Modal functionality
            function showModal(modalId) {
              document.getElementById(modalId).classList.add('show');
            }

            function hideModal(modalId) {
              document.getElementById(modalId).classList.remove('show');
            }

            // Close modal when clicking outside
            window.onclick = function (event) {
              if (event.target.classList.contains('modal')) {
                event.target.classList.remove('show');
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