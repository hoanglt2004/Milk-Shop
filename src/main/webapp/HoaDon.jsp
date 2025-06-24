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
                          <h5 class="mb-0"><strong>Danh Sách Hóa Đơn</strong></h5>
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
                              <th>Ngày giao</th>
                              <th>Tổng tiền</th>
                              <th>Trạng thái</th>
                            </tr>
                          </thead>
                          <tbody>
                            <c:forEach items="${listAllInvoice}" var="invoice">
                              <tr>
                                <td>${invoice.maHD}</td>
                                <td>HD${invoice.maHD}</td>
                                <td>
                                  <c:forEach items="${listAllAccount}" var="account">
                                    <c:if test="${account.id == invoice.accountID}">
                                      ${account.user}
                                    </c:if>
                                  </c:forEach>
                                </td>
                                <td>
                                  <fmt:formatDate value="${invoice.ngayXuat}" pattern="dd/MM/yyyy HH:mm" />
                                </td>
                                <td>
                                  <c:choose>
                                    <c:when test="${invoice.deliveryDate != null}">
                                      <fmt:formatDate value="${invoice.deliveryDate}" pattern="dd/MM/yyyy HH:mm" />
                                    </c:when>
                                    <c:otherwise>
                                      <span class="text-muted">Chưa giao</span>
                                    </c:otherwise>
                                  </c:choose>
                                </td>
                                <td>
                                  <fmt:formatNumber value="${invoice.tongGia}" pattern="#,###" var="totalPrice" />
                                  ${fn:replace(totalPrice, ',', '.')} VNĐ
                                </td>
                                <td>
                                  <select class="form-control status-select" data-invoice-id="${invoice.maHD}"
                                    style="width: auto; display: inline-block;">
                                    <option value="Chờ xác nhận" ${invoice.status=='Chờ xác nhận' ? 'selected' : '' }>
                                      Chờ xác nhận
                                    </option>
                                    <option value="Đang giao" ${invoice.status=='Đang giao' ? 'selected' : '' }>
                                      Đang giao
                                    </option>
                                    <option value="Hoàn thành" ${invoice.status=='Hoàn thành' ? 'selected' : '' }>
                                      Hoàn thành
                                    </option>
                                  </select>
                                </td>
                              </tr>
                            </c:forEach>
                            <c:if test="${empty listAllInvoice}">
                              <tr>
                                <td colspan="7" class="text-center text-muted">
                                  <i class="fa fa-info-circle"></i> Chưa có hóa đơn nào
                                </td>
                              </tr>
                            </c:if>
                          </tbody>
                        </table>
                      </div>
                    </div>
                  </div>
                </section>
              </div>
            </main>
          </div>

          <!-- Minimal JavaScript -->
          <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
          <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>
          <script>
            // Search functionality
            document.getElementById('searchInput').addEventListener('keyup', function () {
              const searchText = this.value.toLowerCase();
              const tableRows = document.querySelectorAll('tbody tr');
              tableRows.forEach(row => {
                const text = row.textContent.toLowerCase();
                row.style.display = text.includes(searchText) ? '' : 'none';
              });
            });

            // Status update functionality
            document.querySelectorAll('.status-select').forEach(select => {
              select.addEventListener('change', function () {
                const invoiceId = this.getAttribute('data-invoice-id');
                const newStatus = this.value;
                const originalValue = this.querySelector('option[selected]').value;

                // Disable select while processing
                this.disabled = true;

                fetch('updateInvoiceStatus', {
                  method: 'POST',
                  headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                  },
                  body: 'maHD=' + invoiceId + '&status=' + encodeURIComponent(newStatus)
                })
                  .then(response => response.json())
                  .then(data => {
                    if (data.success) {
                      // Update delivery date column if status is "Hoàn thành"
                      if (newStatus === 'Hoàn thành') {
                        const row = this.closest('tr');
                        const deliveryCell = row.children[4]; // Index 4 is delivery date column
                        const now = new Date();
                        const dateStr = now.toLocaleDateString('vi-VN') + ' ' +
                          now.toLocaleTimeString('vi-VN', { hour: '2-digit', minute: '2-digit' });
                        deliveryCell.innerHTML = dateStr;
                      }

                      // Show success message
                      alert('Cập nhật trạng thái thành công!');
                    } else {
                      // Revert to original value on error
                      this.value = originalValue;
                      alert('Lỗi: ' + data.message);
                    }
                  })
                  .catch(error => {
                    // Revert to original value on error
                    this.value = originalValue;
                    alert('Lỗi kết nối: ' + error.message);
                  })
                  .finally(() => {
                    // Re-enable select
                    this.disabled = false;
                  });
              });
            });
          </script>
        </body>

        </html>