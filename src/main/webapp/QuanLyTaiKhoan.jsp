<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
      <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <!DOCTYPE html>
        <html>

        <head>
          <meta charset="UTF-8">
          <title>Quản Lý Tài Khoản - Admin</title>
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
                    <div class="card-header py-3 row">
                      <div class="col-sm-6">
                        <h5 class="mb-0 text-left"><strong>Quản lý tài khoản</strong></h5>
                      </div>
                      <div class="col-sm-6 text-right">
                        <button class="btn btn-success me-2" onclick="openModal('addEmployeeModal')">
                          <i class="fas fa-plus"></i> Thêm Tài Khoản
                        </button>
                        <form action="xuatExcelAccountControl" method="get" style="display:inline-block">
                          <button type="submit" class="btn btn-primary">
                            <i class="fas fa-file-excel"></i> Xuất Excel
                          </button>
                        </form>
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
                        <input type="text" id="searchInput" class="form-control" placeholder="Tìm kiếm tài khoản...">
                      </div>

                      <!-- Accounts Table -->
                      <div class="table-responsive">
                        <table class="table table-hover">
                          <thead>
                            <tr>
                              <th>ID</th>
                              <th>Tên đăng nhập</th>
                              <th>Mật khẩu</th>
                              <th>Phân quyền</th>
                              <th>Email</th>
                              <th>Thao tác</th>
                            </tr>
                          </thead>
                          <tbody>
                            <c:forEach items="${listA}" var="account">
                              <tr>
                                <td>${account.id}</td>
                                <td>${account.user}</td>
                                <td>
                                  <span style="font-family: monospace;">****</span>
                                </td>
                                <td>
                                  <c:choose>
                                    <c:when test="${account.isAdmin == 1}">
                                      <span class="text-danger"><i class="fa fa-user-shield"></i> Admin</span>
                                    </c:when>
                                    <c:otherwise>
                                      <span class="text-primary"><i class="fa fa-user"></i> Khách hàng</span>
                                    </c:otherwise>
                                  </c:choose>
                                </td>
                                <td>${account.email}</td>
                                <td>
                                  <a href="deleteAccount?id=${account.id}" class="btn btn-danger btn-action"
                                    onclick="return confirm('Bạn có chắc chắn muốn xóa tài khoản này?')">
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

          <!-- Add Account Modal -->
          <div class="modal" id="addEmployeeModal">
            <div class="modal-dialog">
              <div class="modal-content">
                <form action="addAccount" method="post">
                  <div class="modal-header">
                    <h4 class="modal-title">Thêm tài khoản</h4>
                    <button type="button" class="close" onclick="closeModal('addEmployeeModal')">&times;</button>
                  </div>
                  <div class="modal-body">
                    <div class="form-group">
                      <label>Tên đăng nhập</label>
                      <input name="user" type="text" class="form-control" required>
                    </div>
                    <div class="form-group">
                      <label>Mật khẩu</label>
                      <input name="pass" type="password" class="form-control" required>
                    </div>
                    <div class="form-group">
                      <label>Phân quyền</label>
                      <select name="isAdmin" class="form-control" required>
                        <option value="">-- Chọn quyền --</option>
                        <option value="0">Khách hàng</option>
                        <option value="1">Admin</option>
                      </select>
                    </div>
                    <div class="form-group">
                      <label>Email</label>
                      <input name="email" type="email" class="form-control" required>
                    </div>
                  </div>
                  <div class="modal-footer">
                    <button type="button" class="btn btn-secondary"
                      onclick="closeModal('addEmployeeModal')">Hủy</button>
                    <button type="submit" class="btn btn-success">Thêm</button>
                  </div>
                </form>
              </div>
            </div>
          </div>

          <!-- Simple JavaScript -->
          <script>
            // Modal functions
            function openModal(modalId) {
              console.log('Opening modal:', modalId);
              const modal = document.getElementById(modalId);
              if (modal) {
                modal.classList.add('show');
                modal.style.display = 'block';
                console.log('Modal opened successfully');
              } else {
                console.error('Modal not found:', modalId);
              }
            }

            function closeModal(modalId) {
              console.log('Closing modal:', modalId);
              const modal = document.getElementById(modalId);
              if (modal) {
                modal.classList.remove('show');
                modal.style.display = 'none';
                console.log('Modal closed successfully');
              } else {
                console.error('Modal not found:', modalId);
              }
            }

            // Close modal when clicking outside
            window.onclick = function (event) {
              if (event.target.classList.contains('modal')) {
                event.target.classList.remove('show');
                event.target.style.display = 'none';
              }
            }

            // Close modal when pressing Escape key
            document.addEventListener('keydown', function (event) {
              if (event.key === 'Escape') {
                const modals = document.querySelectorAll('.modal.show');
                modals.forEach(modal => {
                  modal.classList.remove('show');
                  modal.style.display = 'none';
                });
              }
            });

            // Simple search functionality
            document.getElementById('searchInput').addEventListener('keyup', function () {
              const searchText = this.value.toLowerCase();
              const tableRows = document.querySelectorAll('tbody tr');
              tableRows.forEach(row => {
                const text = row.textContent.toLowerCase();
                row.style.display = text.includes(searchText) ? '' : 'none';
              });
            });

            // Debug: Check if modal exists on page load
            document.addEventListener('DOMContentLoaded', function () {
              const modal = document.getElementById('addEmployeeModal');
              if (modal) {
                console.log('Modal found on page load');
              } else {
                console.error('Modal not found on page load');
              }
            });
          </script>
        </body>

        </html>