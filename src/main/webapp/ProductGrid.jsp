<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<style>
.product-title {
    min-height: 48px;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
    text-overflow: ellipsis;
    margin-bottom: 8px;
}

.product-title a {
    color: #333;
    text-decoration: none;
}

.product-title a:hover {
    color: #da1919;
}

.product-description {
    min-height: 24px;
    margin-bottom: 8px;
    text-align: center;
}

.product-rating {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 5px;
    margin-bottom: 16px;
}

.product-price {
    text-align: left;
}

.price-value {
    font-weight: bold;
    color: #da1919;
    font-size: 1.1rem;
    margin: 0;
}

.original-price {
    text-decoration: line-through;
    color: #6c757d;
    font-size: 0.9rem;
    margin-bottom: 4px;
}
</style>

<c:forEach items="${listP}" var="o">
    <!-- Grid column -->
    <div class="col-md-4 mb-4">
        <!-- Card -->
        <div class="card h-100 product-card d-flex flex-column">
            <div class="bg-image hover-overlay ripple product-image-container" data-mdb-ripple-color="light">
                <img class="img-fluid w-100 product-image" src="${o.image}" alt="${o.name}">
                <a href="detail?pid=${o.id}">
                    <div class="mask" style="background-color: rgba(251, 251, 251, 0.15);"></div>
                </a>
                <c:if test="${o.discountPercent > 0}">
                    <div class="product-badge sale-badge">-${o.discountPercent}%</div>
                </c:if>
            </div>
            <div class="card-body text-center d-flex flex-column">
                <h5 class="card-title product-title">
                    <a href="detail?pid=${o.id}" class="text-dark product-name">${o.name}</a>
                </h5>
                <p class="text-muted mb-2">${o.brand}</p>
                <div class="product-rating">
                    <div class="stars text-warning">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                    </div>
                    <span class="rating-text">(5.0)</span>
                </div>
                <div class="mt-auto">
                    <div class="d-flex justify-content-between align-items-center">
                        <div class="product-price">
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
                        <a href="detail?pid=${o.id}" class="btn btn-primary btn-rounded btn-sm">
                            <i class="fas fa-eye me-2"></i>Xem
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</c:forEach> 