<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  <%@page contentType="text/html" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <title>Quản Lý Nhà Cung Cấp</title>
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
      <link href="css/admin-simple.css" rel="stylesheet" type="text/css" />
    </head>

    <body>
      <div class="container-fluid">
        <div class="row">
          <jsp:include page="LeftAdmin.jsp" />
          <main class="main-content">
            <div class="container pt-4">
              <section class="mb-4">
                <div class="card">
                  <div class="card-header py-3 row">
                    <div class="col-sm-6">
                      <h5 class="mb-0 text-left"><strong>Quản lý nhà cung cấp</strong></h5>
                    </div>
                    <div class="col-sm-6 text-right">
                      <button class="btn btn-success me-2" onclick="openModal('addEmployeeModal')">
                        <i class="fas fa-plus"></i> Thêm NCC
                      </button>
                      <form action="xuatExcelSupplierControl" method="get" style="display:inline-block">
                        <button type="submit" class="btn btn-primary">
                          <i class="fas fa-file-excel"></i> Xuất Excel
                        </button>
                      </form>
                    </div>
                  </div>

                  <div class="card-body">
                    <c:if test="${error != null}">
                      <div class="alert alert-danger">
                        ${error}
                        <button type="button" class="close"
                          onclick="this.parentElement.style.display='none'">&times;</button>
                      </div>
                    </c:if>
                    <c:if test="${mess != null}">
                      <div class="alert alert-success">
                        ${mess}
                        <button type="button" class="close"
                          onclick="this.parentElement.style.display='none'">&times;</button>
                      </div>
                    </c:if>

                    <div class="table-responsive">
                      <table class="table table-hover">
                        <thead>
                          <tr>
                            <th>ID</th>
                            <th>Tên nhà cung cấp</th>
                            <th>Số điện thoại</th>
                            <th>Email</th>
                            <th>Địa chỉ</th>
                            <th>Phân phối cho</th>
                            <th>Thao tác</th>
                          </tr>
                        </thead>
                        <tbody>
                          <c:forEach items="${listAllSupplier}" var="o">
                            <tr>
                              <td>${o.idSupplier}</td>
                              <td>${o.nameSupplier}</td>
                              <td>${o.phoneSupplier}</td>
                              <td>${o.emailSupplier}</td>
                              <td>${o.addressSupplier}</td>
                              <td>
                                <c:forEach items="${listAllCategory}" var="t">
                                  <c:if test="${o.cateID == t.cid}">
                                    ${t.cname}
                                  </c:if>
                                </c:forEach>
                              </td>
                              <td>
                                <a href="deleteSupplier?id=${o.idSupplier}"
                                  onclick="return confirm('Bạn có chắc chắn muốn xóa nhà cung cấp này?')"
                                  class="btn btn-danger btn-action">
                                  <i class="fas fa-trash"></i>
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
      </div>

      <!-- Add Supplier Modal -->
      <div id="addEmployeeModal" class="modal">
        <div class="modal-dialog">
          <div class="modal-content">
            <form action="addSupplier" method="post">
              <div class="modal-header">
                <h4 class="modal-title">Thêm nhà cung cấp</h4>
                <button type="button" class="close" onclick="closeModal('addEmployeeModal')">&times;</button>
              </div>
              <div class="modal-body">
                <div class="form-group">
                  <label>Tên nhà cung cấp</label>
                  <input name="nameSupplier" type="text" class="form-control" required>
                </div>
                <div class="form-group">
                  <label>Số điện thoại</label>
                  <input name="phoneSupplier" type="text" class="form-control" required>
                </div>
                <div class="form-group">
                  <label>Email</label>
                  <input name="emailSupplier" type="email" class="form-control" required>
                </div>
                <div class="form-group">
                  <label>Địa chỉ</label>
                  <input name="addressSupplier" type="text" class="form-control" required>
                </div>
                <div class="form-group">
                  <label>Danh mục cung cấp</label>
                  <select name="cateID" class="form-control" required>
                    <option value="">-- Chọn danh mục --</option>
                    <c:forEach items="${listAllCategory}" var="c">
                      <option value="${c.cid}">${c.cname}</option>
                    </c:forEach>
                  </select>
                </div>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-secondary" onclick="closeModal('addEmployeeModal')">Hủy</button>
                <button type="submit" class="btn btn-success">Thêm</button>
              </div>
            </form>
          </div>
        </div>
      </div>

      <script>
        // Modal functions
        function openModal(modalId) {
          document.getElementById(modalId).classList.add('show');
        }

        function closeModal(modalId) {
          document.getElementById(modalId).classList.remove('show');
        }

        // Close modal when clicking outside
        window.onclick = function (event) {
          if (event.target.classList.contains('modal')) {
            event.target.classList.remove('show');
          }
        }
      </script>
    </body>

    </html>