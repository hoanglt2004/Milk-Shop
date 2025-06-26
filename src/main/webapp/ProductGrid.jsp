<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<style>
/* Product Badge Styling */
.product-badge {
    position: absolute;
    padding: 6px 12px;
    font-size: 0.85rem;
    font-weight: 600;
    letter-spacing: 0.5px;
    border-radius: 4px;
    z-index: 2;
    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
}

.sale-badge {
    top: 10px;
    left: 10px;
    background: linear-gradient(45deg, #ff6b6b, #c41e3a);
    color: white;
}

/* Hover effect for badges */
.product-card:hover .product-badge {
    transform: translateY(-2px);
    box-shadow: 0 4px 8px rgba(0,0,0,0.15);
    transition: all 0.3s ease;
}

/* Responsive adjustments for badges */
@media (max-width: 768px) {
    .product-badge {
        padding: 4px 8px;
        font-size: 0.75rem;
    }
}

/* Product Card Enhanced Styling */
.product-card {
    border: none;
    border-radius: 15px;
    overflow: hidden;
    transition: all 0.3s ease;
    background: white;
    box-shadow: 0 2px 15px rgba(0, 0, 0, 0.1);
    height: 100%;
}

.product-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 5px 20px rgba(196, 30, 58, 0.15);
}

.product-image-container {
    position: relative;
    padding-top: 100%;
    overflow: hidden;
    background: #f8f9fa;
}

.product-image {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: transform 0.5s ease;
}

.product-card:hover .product-image {
    transform: scale(1.05);
}

.product-card-body {
    padding: 1.5rem;
    display: flex;
    flex-direction: column;
    gap: 0.75rem;
}

.product-title {
    font-size: 1rem;
    font-weight: 600;
    line-height: 1.4;
    height: 2.8em;
    overflow: hidden;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    margin: 0;
}

.product-title a {
    color: #333;
    text-decoration: none;
    transition: color 0.3s ease;
}

.product-title a:hover {
    color: #c41e3a;
}

.product-brand {
    font-size: 0.9rem;
    color: #6c757d;
    margin: 0;
}

.product-rating {
    display: flex;
    align-items: center;
    gap: 0.5rem;
}

.stars {
    color: #ffc107;
    display: flex;
    gap: 2px;
}

.rating-text {
    color: #6c757d;
    font-size: 0.85rem;
}

.product-price {
    padding: 0.75rem 0;
    border-top: 1px solid #eee;
    border-bottom: 1px solid #eee;
    margin: 0.5rem 0;
    min-height: 80px;
    display: flex;
    flex-direction: column;
    justify-content: center;
}

.original-price {
    text-decoration: line-through;
    color: #6c757d;
    font-size: 0.9rem;
    margin: 0;
    order: 2;
    margin-top: 4px;
}

.sale-price {
    color: #c41e3a;
    font-weight: 700;
    font-size: 1.25rem;
    margin: 0;
    order: 1;
}

.btn-cart {
    width: 100%;
    padding: 0.8rem;
    color: white;
    background-color: #c41e3a;
    border: none;
    border-radius: 8px;
    transition: all 0.3s ease;
    font-weight: 500;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 0.5rem;
    margin-top: auto;
    cursor: pointer;
}

.btn-cart:hover {
    background-color: #a01830;
    transform: translateY(-2px);
    box-shadow: 0 4px 8px rgba(196, 30, 58, 0.2);
}

.btn-cart:active {
    transform: translateY(0);
}

.btn-cart.loading {
    opacity: 0.7;
    cursor: not-allowed;
}

.btn-cart.loading:after {
    content: "";
    width: 16px;
    height: 16px;
    border: 2px solid #ffffff;
    border-top: 2px solid transparent;
    border-radius: 50%;
    animation: spin 0.8s linear infinite;
    margin-left: 8px;
}

@keyframes spin {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(360deg); }
}

.btn-cart i {
    font-size: 1.1rem;
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
            <div class="card-body product-card-body">
                <h5 class="product-title">
                    <a href="detail?pid=${o.id}" title="View Product">${o.name}</a>
                </h5>
                <p class="product-brand">${o.brand}</p>
                <div class="product-rating">
                    <div class="stars">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                    </div>
                    <span class="rating-text">(5.0)</span>
                </div>
                <div class="product-price">
                    <c:choose>
                        <c:when test="${o.discountPercent > 0}">
                            <p class="sale-price">
                                <fmt:formatNumber value="${o.salePrice}" pattern="#,##0' VNĐ'" />
                            </p>
                            <p class="original-price">
                                <fmt:formatNumber value="${o.price}" pattern="#,##0' VNĐ'" />
                            </p>
                        </c:when>
                        <c:otherwise>
                            <p class="sale-price">
                                <fmt:formatNumber value="${o.price}" pattern="#,##0' VNĐ'" />
                            </p>
                        </c:otherwise>
                    </c:choose>
                </div>
                <button onclick="addToCart(${o.id}, this)" class="btn-cart">
                    <i class="fas fa-shopping-cart"></i>
                    Thêm vào giỏ
                </button>
            </div>
        </div>
    </div>
</c:forEach> 