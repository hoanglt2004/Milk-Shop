<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <div class="sidebar">
            <div class="logo-details">
                <i class='bx bxl-c-plus-plus'></i>
                <span class="logo_name">Quản lý bán sữa</span>
            </div>
            <ul class="nav-links">
                <li>
                    <a href="home" class="<c:if test=" ${param.page=='home' }">active</c:if>">
                        <i class='bx bx-grid-alt'></i>
                        <span class="links_name">Trang chủ</span>
                    </a>
                </li>
                <li>
                    <a href="product" class="<c:if test=" ${param.page=='product' }">active</c:if>">
                        <i class='bx bx-box'></i>
                        <span class="links_name">Sản phẩm</span>
                    </a>
                </li>
                <li>
                    <a href="category" class="<c:if test=" ${param.page=='category' }">active</c:if>">
                        <i class='bx bx-list-ul'></i>
                        <span class="links_name">Danh mục</span>
                    </a>
                </li>
                <li>
                    <a href="warehouse" class="<c:if test=" ${param.page=='warehouse' }">active</c:if>">
                        <i class='bx bx-store'></i>
                        <span class="links_name">Kho hàng</span>
                    </a>
                </li>
                <li>
                    <a href="discount" class="<c:if test=" ${param.page=='discount' }">active</c:if>">
                        <i class='bx bx-discount'></i>
                        <span class="links_name">Khuyến mãi</span>
                    </a>
                </li>
                <li>
                    <a href="customer" class="<c:if test=" ${param.page=='customer' }">active</c:if>">
                        <i class='bx bx-user'></i>
                        <span class="links_name">Khách hàng</span>
                    </a>
                </li>
                <li>
                    <a href="invoice" class="<c:if test=" ${param.page=='invoice' }">active</c:if>">
                        <i class='bx bx-receipt'></i>
                        <span class="links_name">Hóa đơn</span>
                    </a>
                </li>
                <li>
                    <a href="statistic" class="<c:if test=" ${param.page=='statistic' }">active</c:if>">
                        <i class='bx bx-bar-chart-alt-2'></i>
                        <span class="links_name">Thống kê</span>
                    </a>
                </li>
                <li class="log_out">
                    <a href="logout">
                        <i class='bx bx-log-out'></i>
                        <span class="links_name">Đăng xuất</span>
                    </a>
                </li>
            </ul>
        </div>