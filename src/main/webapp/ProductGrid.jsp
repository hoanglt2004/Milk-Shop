<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:forEach items="${listP}" var="o">
    <!-- Grid column -->
    <div class="col-md-4 mb-4">
        <!-- Card -->
        <div class="card h-100 product-card">
            <div class="bg-image hover-overlay ripple product-image-container" data-mdb-ripple-color="light">
                <img class="img-fluid w-100 product-image" src="${o.image}" alt="${o.name}">
                <a href="detail?pid=${o.id}">
                    <div class="mask" style="background-color: rgba(251, 251, 251, 0.15);"></div>
                </a>
                <c:if test="${o.discountPercent > 0}">
                    <div class="product-badge sale-badge">-${o.discountPercent}%</div>
                </c:if>
            </div>
            <div class="card-body product-card-body">
                <h5 class="card-title product-title">
                    <a href="detail?pid=${o.id}" title="View Product">${o.name}</a>
                </h5>
                <p class="text-muted product-description">${o.brand}</p>
                <div class="product-rating">
                    <div class="stars text-warning">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star-half-alt"></i>
                    </div>
                    <span class="rating-text">(4.5)</span>
                </div>
                <div class="product-price-section" style="display: flex; flex-direction: column; align-items: center; justify-content: center; min-height: 80px; gap: 5px; margin-top: 10px;">
                    <c:choose>
                        <c:when test="${o.discountPercent > 0}">
                            <p class="text-muted mb-0" style="text-decoration: line-through;">
                                <fmt:formatNumber value="${o.price}" pattern="#,##0' VNĐ'" />
                            </p>
                            <h6 class="mb-0 font-weight-bold text-danger">
                                <fmt:formatNumber value="${o.salePrice}" pattern="#,##0' VNĐ'" />
                            </h6>
                        </c:when>
                        <c:otherwise>
                            <h6 class="mb-0 font-weight-bold text-danger">
                                <fmt:formatNumber value="${o.price}" pattern="#,##0' VNĐ'" />
                            </h6>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="d-flex justify-content-center mt-3">
                    <a href="detail?pid=${o.id}" class="btn btn-primary btn-rounded btn-sm"><i class="fas fa-eye me-2"></i>Xem</a>
                </div>
            </div>
        </div>
        <!-- Card -->
    </div>
    <!-- Grid column -->
</c:forEach> 