<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
      <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <!DOCTYPE html>
        <html>

        <head>
          <meta charset="UTF-8">
          <title>Quản Lý Hóa Đơn - Admin</title>
          <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

          <!-- ONLY ADMIN CSS -->
          <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
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
                  <section class="mb-4">
                    <div class="card">
                      <div class="card-header">
                        <div class="row">
                          <div class="col-sm-6">
                            <h5 class="mb-0"><strong>Quản Lý Hóa Đơn</strong></h5>
                          </div>
                          <div class="col-sm-6 text-right">
                            <input type="text" id="searchInput" class="form-control" placeholder="Tìm kiếm hóa đơn..."
                              style="width: 300px; display: inline-block;">
                          </div>
                        </div>
                      </div>

                      <div class="card-body">
                        <!-- Invoices Table -->
                        <div class="table-responsive">
                          <table class="table table-hover">
                            <thead>
                              <tr>
                                <th>ID</th>
                                <th>Mã hóa đơn</th>
                                <th>Khách hàng</th>
                                <th>Ngày đặt</th>
                                <th>Tổng tiền</th>
                                <th>Trạng thái</th>
                                <th>Thao tác</th>
                              </tr>
                            </thead>
                            <tbody>
                              <c:forEach items="${listI}" var="invoice">
                                <tr>
                                  <td>${invoice.maHD}</td>
                                  <td>${invoice.maHD}</td>
                                  <td>${invoice.accountID}</td>
                                  <td>
                                    <fmt:formatDate value="${invoice.ngayXuat}" pattern="dd/MM/yyyy" />
                                  </td>
                                  <td>
                                    <fmt:formatNumber value="${invoice.tongGia}" pattern="#,###" var="totalPrice" />
                                    ${fn:replace(totalPrice, ',', '.')} VNĐ
                                  </td>
                                  <td>
                                    <span class="text-success">
                                      <i class="fa fa-check-circle"></i> Hoàn thành
                                    </span>
                                  </td>
                                  <td>
                                    <button class="btn btn-info btn-action"
                                      onclick="showInvoiceDetail('${invoice.maHD}')">
                                      <i class="fa fa-eye"></i>
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
          </div>

          <!-- Invoice Detail Modal -->
          <div class="modal" id="invoiceDetailModal">
            <div class="modal-dialog" style="max-width: 700px;">
              <div class="modal-content">
                <div class="modal-header">
                  <h5 class="modal-title">Chi Tiết Hóa Đơn</h5>
                  <button type="button" class="close" onclick="hideModal('invoiceDetailModal')">
                    <span>&times;</span>
                  </button>
                </div>
                <div class="modal-body" id="invoiceDetailContent">
                  <!-- Content will be loaded here -->
                </div>
                <div class="modal-footer">
                  <button type="button" class="btn btn-secondary"
                    onclick="hideModal('invoiceDetailModal')">Đóng</button>
                </div>
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

            // Show invoice detail
            function showInvoiceDetail(invoiceId) {
              document.getElementById('invoiceDetailContent').innerHTML =
                '<p>Đang tải chi tiết hóa đơn ' + invoiceId + '...</p>';
              showModal('invoiceDetailModal');
            }
          </script>
        </body>

        </html>