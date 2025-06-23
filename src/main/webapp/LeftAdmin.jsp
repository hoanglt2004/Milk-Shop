<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  <%@page contentType="text/html" pageEncoding="UTF-8" %>

    <!-- Sidebar Admin -->
    <nav class="sidebar">
      <!-- Header với nút Home và Logout -->
      <div class="sidebar-header">
        <a href="home" class="btn-home">
          <i class="fa fa-home"></i> Trang Chủ
        </a>
        <a href="logout" class="btn-logout">
          <i class="fa fa-sign-out-alt"></i> Đăng Xuất
        </a>
      </div>

      <!-- Menu điều hướng -->
      <div class="sidebar-menu">
        <a href="admin" class="menu-item" data-page="admin">
          <i class="fas fa-tachometer-alt"></i>
          <span>Dashboard Tổng Quan</span>
        </a>

        <a href="adminReports" class="menu-item" data-page="adminReports">
          <i class="fas fa-chart-line"></i>
          <span>Báo Cáo & Thống Kê</span>
        </a>

        <a href="hoaDon" class="menu-item" data-page="hoaDon">
          <i class="fas fa-file-invoice-dollar"></i>
          <span>Quản Lý Hóa Đơn</span>
        </a>

        <a href="managerAccount" class="menu-item" data-page="managerAccount">
          <i class="fas fa-user-circle"></i>
          <span>Quản Lý Tài Khoản</span>
        </a>

        <a href="manager" class="menu-item" data-page="manager">
          <i class="fas fa-box"></i>
          <span>Quản Lý Sản Phẩm</span>
        </a>

        <a href="quanLyDanhMuc" class="menu-item" data-page="quanLyDanhMuc">
          <i class="fas fa-list"></i>
          <span>Quản Lý Danh Mục</span>
        </a>

        <a href="managerSupplier" class="menu-item" data-page="managerSupplier">
          <i class="fas fa-truck"></i>
          <span>Quản Lý Nhà Cung Cấp</span>
        </a>

        <a href="quanLyKhuyenMai" class="menu-item" data-page="quanLyKhuyenMai">
          <i class="fas fa-tags"></i>
          <span>Quản Lý Khuyến Mãi</span>
        </a>

        <a href="quanLyKho" class="menu-item" data-page="quanLyKho">
          <i class="fas fa-warehouse"></i>
          <span>Quản Lý Kho</span>
        </a>
      </div>
    </nav>

    <script>
      document.addEventListener('DOMContentLoaded', function () {
        // Delay để đảm bảo trang đã load hoàn toàn
        setTimeout(function () {
          // Lấy URL hiện tại
          var currentPath = window.location.pathname;
          var currentPageParam = new URLSearchParams(window.location.search).get('page');

          console.log('Current path:', currentPath); // Debug
          console.log('Page param:', currentPageParam); // Debug

          // Xóa active class từ tất cả menu items
          var menuItems = document.querySelectorAll('.menu-item');
          menuItems.forEach(function (item) {
            item.classList.remove('active');
          });

          // Tìm trang hiện tại
          var currentPage = null;

          // Kiểm tra theo URL path và servlet patterns
          if (currentPath.includes('admin') && !currentPath.includes('adminReports')) {
            currentPage = 'admin';
          } else if (currentPath.includes('adminReports') || currentPath.includes('AdminReports')) {
            currentPage = 'adminReports';
          } else if (currentPath.includes('hoaDon') || currentPath.includes('HoaDon')) {
            currentPage = 'hoaDon';
          } else if (currentPath.includes('managerAccount') || currentPath.includes('ManagerAccount')) {
            currentPage = 'managerAccount';
          } else if (currentPath.includes('manager') && !currentPath.includes('managerAccount') && !currentPath.includes('managerSupplier')) {
            currentPage = 'manager';
          } else if (currentPath.includes('quanLyDanhMuc') || currentPath.includes('QuanLyDanhMuc')) {
            currentPage = 'quanLyDanhMuc';
          } else if (currentPath.includes('managerSupplier') || currentPath.includes('ManagerSupplier') || currentPath.includes('NhaPhanPhoi')) {
            currentPage = 'managerSupplier';
          } else if (currentPath.includes('quanLyKhuyenMai') || currentPath.includes('QuanLyKhuyenMai')) {
            currentPage = 'quanLyKhuyenMai';
          } else if (currentPath.includes('quanLyKho') || currentPath.includes('QuanLyKho')) {
            currentPage = 'quanLyKho';
          }

          // Kiểm tra theo servlet control names
          if (!currentPage) {
            if (currentPath.includes('StatisticControl')) {
              currentPage = 'admin';
            } else if (currentPath.includes('AdminReportsControl')) {
              currentPage = 'adminReports';
            } else if (currentPath.includes('HoaDonControl')) {
              currentPage = 'hoaDon';
            } else if (currentPath.includes('ManagerAccountControl')) {
              currentPage = 'managerAccount';
            } else if (currentPath.includes('ManagerControl') && !currentPath.includes('ManagerAccount') && !currentPath.includes('ManagerSupplier')) {
              currentPage = 'manager';
            } else if (currentPath.includes('QuanLyDanhMucServlet')) {
              currentPage = 'quanLyDanhMuc';
            } else if (currentPath.includes('ManagerSupplierControl')) {
              currentPage = 'managerSupplier';
            } else if (currentPath.includes('QuanLyKhuyenMaiControl')) {
              currentPage = 'quanLyKhuyenMai';
            } else if (currentPath.includes('QuanLyKhoControl')) {
              currentPage = 'quanLyKho';
            }
          }

          // Nếu có param page trong URL (ưu tiên cao nhất)
          if (currentPageParam) {
            currentPage = currentPageParam;
          }

          console.log('Detected page:', currentPage); // Debug

          // Set active class với hiệu ứng mượt mà
          if (currentPage) {
            var activeMenuItem = document.querySelector('.menu-item[data-page="' + currentPage + '"]');
            if (activeMenuItem) {
              // Thêm class active với delay nhỏ để có hiệu ứng mượt mà
              setTimeout(function () {
                activeMenuItem.classList.add('active');
              }, 50);
              console.log('Set active for:', currentPage); // Debug
            }
          }
        }, 100);
      });
    </script>