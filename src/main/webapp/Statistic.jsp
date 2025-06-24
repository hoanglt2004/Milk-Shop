<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
      <%@page contentType="text/html" pageEncoding="UTF-8" %>

        <!DOCTYPE html>
        <html>

        <head>
          <meta charset="UTF-8">
          <title>Admin Dashboard</title>
          <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
                <!-- Statistics Cards -->
                <section class="mb-4">
                  <div class="row">
                    <div class="col-md-6 mb-4">
                      <div class="card">
                        <div class="card-body">
                          <div class="d-flex justify-content-between p-2">
                            <div class="d-flex">
                              <div class="align-self-center me-4">
                                <i class="fas fa-box text-primary fa-3x"></i>
                              </div>
                              <div>
                                <h4>Tổng Sản Phẩm</h4>
                                <p class="mb-0">Số lượng sản phẩm trong hệ thống</p>
                              </div>
                            </div>
                            <div class="align-self-center">
                              <h2 class="mb-0 text-primary">${allProduct}</h2>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>

                    <div class="col-md-6 mb-4">
                      <div class="card">
                        <div class="card-body">
                          <div class="d-flex justify-content-between p-2">
                            <div class="d-flex">
                              <div class="align-self-center me-4">
                                <i class="fas fa-comments text-warning fa-3x"></i>
                              </div>
                              <div>
                                <h4>Tổng Đánh Giá</h4>
                                <p class="mb-0">Số lượng đánh giá từ khách hàng</p>
                              </div>
                            </div>
                            <div class="align-self-center">
                              <h2 class="mb-0 text-warning">${allReview}</h2>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>

                  <div class="row">
                    <div class="col-md-6 mb-4">
                      <div class="card">
                        <div class="card-body">
                          <div class="d-flex justify-content-between p-2">
                            <div class="d-flex">
                              <div class="align-self-center me-4">
                                <i class="fas fa-money-bill-wave text-success fa-3x"></i>
                              </div>
                              <div>
                                <h4>Doanh Thu Thực Tế</h4>
                                <p class="mb-0">Chỉ từ đơn hàng đã hoàn thành</p>
                              </div>
                            </div>
                            <div class="align-self-center">
                              <h2 class="mb-0 text-success">
                                <fmt:formatNumber value="${totalMoney}" pattern="#,###" var="totalSales" />
                                ${fn:replace(totalSales, ',', '.')} VNĐ
                              </h2>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>

                    <div class="col-md-6 mb-4">
                      <div class="card">
                        <div class="card-body">
                          <div class="d-flex justify-content-between p-2">
                            <div class="d-flex">
                              <div class="align-self-center me-4">
                                <i class="fas fa-check-circle text-info fa-3x"></i>
                              </div>
                              <div>
                                <h4>Đơn Hàng Hoàn Thành</h4>
                                <p class="mb-0">Đã giao thành công</p>
                              </div>
                            </div>
                            <div class="align-self-center">
                              <h2 class="mb-0 text-info">${totalCompletedOrder}</h2>
                            </div>
                          </div>
                          <div class="mt-3 text-center">
                            <small class="text-muted">
                              Tổng đơn hàng: ${totalOrder} |
                              Tỷ lệ hoàn thành:
                              <c:choose>
                                <c:when test="${totalOrder > 0}">
                                  <fmt:formatNumber value="${(totalCompletedOrder * 100) / totalOrder}"
                                    pattern="##.#" />%
                                </c:when>
                                <c:otherwise>0%</c:otherwise>
                              </c:choose>
                            </small>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </section>
              </div>
            </main>
          </div>

          <!-- JavaScript -->
          <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
          <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>