<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- Nút Home và Logout góc phải trên cùng, đặt ngoài sidebar -->
<div style="position: fixed; top: 20px; right: 40px; z-index: 2000;">
    <a href="home" class="btn btn-primary btn-sm shadow" style="margin-right: 10px;">
        <i class="fa fa-home"></i> Home
    </a>
    <a href="logout" class="btn btn-danger btn-sm shadow">
        <i class="fa fa-sign-out-alt"></i> Logout
    </a>
</div>
<!-- Sidebar -->
<nav id="sidebarMenu" class="collapse d-lg-block sidebar collapse bg-white" style="padding: 0px;">
    <div class="position-sticky">
      <div class="list-group list-group-flush mx-3 mt-4">
        <a href="admin" class="list-group-item list-group-item-action py-2 ripple" aria-current="true">
          <i class="fas fa-tachometer-alt fa-fw me-3"></i><span>Main dashboard</span>
        </a>
        <a href="doanhThuTheoThu" class="list-group-item list-group-item-action py-2 ripple">
          <i class="fas fa-chart-pie fa-fw me-3"></i><span>Danh thu thứ</span>
        </a>
         <a href="doanhThuTheoThang" class="list-group-item list-group-item-action py-2 ripple">
          <i class="fas fa-chart-bar fa-fw me-3"></i><span>Doanh thu tháng</span>
        </a>
        <a href="hoaDon" class="list-group-item list-group-item-action py-2 ripple"><i class="fas fa-file-invoice-dollar fa-fw me-3"></i><span>Hóa Đơn</span></a>
       
         <a href="managerAccount" class="list-group-item list-group-item-action py-2 ripple">
          <i class="fas fa-user-circle fa-fw me-3"></i><span>Quản lý tài khoản</span>
        </a>
        <a href="manager" class="list-group-item list-group-item-action py-2 ripple">
          <i class="fas fa-shoe-prints fa-fw me-3"></i><span>Quản lý sản phẩm</span>
        </a>
        <a href="quanLyDanhMuc" class="list-group-item list-group-item-action py-2 ripple">
          <i class="fas fa-list fa-fw me-3"></i><span>Quản lý danh mục</span>
        </a>
        <a href="top10" class="list-group-item list-group-item-action py-2 ripple">
          <i class="fas fa-shoe-prints fa-fw me-3"></i><span>Top 10 sản phẩm</span>
        </a>
        <a href="top5khachhang" class="list-group-item list-group-item-action py-2 ripple">
          <i class="fas fa-user-circle fa-fw me-3"></i><span>Top 5 khách hàng</span>
        </a>
         <a href="managerSupplier" class="list-group-item list-group-item-action py-2 ripple">
          <i class="fas fa-parachute-box fa-fw me-3"></i><span>Quản lý nhà cung cấp</span>
        </a>
      </div>
    </div>
  </nav>
  <!-- Sidebar -->