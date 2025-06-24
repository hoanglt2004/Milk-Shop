<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  <%@page contentType="text/html" pageEncoding="UTF-8" %>

    <style>
      /* CSS cho LeftAdmin.jsp - Flexbox Layout */
      .admin-layout {
        display: flex;
        min-height: 100vh;
        width: 100%;
      }

      .sidebar {
        flex: 0 0 250px;
        background: #ffffff;
        border-right: 1px solid #e0e0e0;
        box-shadow: 2px 0 10px rgba(0, 0, 0, 0.1);
        overflow-y: auto;
        position: relative;
        z-index: 1000;
        font-family: Arial, sans-serif;
      }

      .main-content {
        flex: 1;
        min-height: 100vh;
        padding: 20px;
        background-color: #f8f9fa;
        overflow-x: auto;
      }

      .sidebar-header {
        display: flex;
        padding: 20px 15px;
        border-bottom: 1px solid #e0e0e0;
        background: #fff;
        text-align: center;
        justify-content: space-around;
        position: sticky;
        top: 0;
        z-index: 10;
      }

      .btn-home,
      .btn-logout {
        display: inline-block;
        padding: 8px 12px;
        margin: 5px;
        border: none;
        border-radius: 4px;
        text-decoration: none;
        font-size: 13px;
        cursor: pointer;
        color: white;
        font-weight: 500;
        transition: all 0.3s ease;
      }

      .btn-home {
        background-color: #007bff;
      }

      .btn-home:hover {
        background-color: #0056b3;
        color: white;
        text-decoration: none;
      }

      .btn-logout {
        background-color: #dc3545;
      }

      .btn-logout:hover {
        background-color: #c82333;
        color: white;
        text-decoration: none;
      }

      .sidebar-menu {
        padding: 0;
        margin: 0;
      }

      .menu-item {
        display: block !important;
        padding: 15px 20px !important;
        color: #555 !important;
        text-decoration: none !important;
        border: none !important;
        background: none !important;
        width: 100% !important;
        text-align: left !important;
        cursor: pointer !important;
        font-size: 14px !important;
        border-bottom: 1px solid #f0f0f0 !important;
        position: relative !important;
        transition: all 0.3s ease !important;
        box-sizing: border-box !important;
      }

      .menu-item:hover {
        background-color: #f8f9fa !important;
        color: #007bff !important;
        text-decoration: none !important;
      }

      .menu-item:active,
      .menu-item:focus {
        outline: none !important;
        background-color: #e3f2fd !important;
        color: #0056b3 !important;
      }

      .sidebar .menu-item.active,
      .sidebar-menu .menu-item.active {
        background-color: #007bff !important;
        color: white !important;
        font-weight: 600 !important;
        border-left: 4px solid #0056b3 !important;
      }

      .sidebar .menu-item.active:hover,
      .sidebar-menu .menu-item.active:hover {
        background-color: #0056b3 !important;
        color: white !important;
      }

      .sidebar .menu-item.active i,
      .sidebar-menu .menu-item.active i {
        color: white !important;
      }

      .menu-item i {
        width: 20px !important;
        margin-right: 10px !important;
        text-align: center !important;
        font-size: 14px !important;
      }

      .menu-item span {
        font-size: 14px !important;
      }

      /* Responsive */
      @media (max-width: 768px) {
        .admin-layout {
          flex-direction: column;
        }

        .sidebar {
          flex: none;
          width: 100%;
          height: auto;
          max-height: 60vh;
          position: relative;
        }

        .main-content {
          flex: 1;
          padding: 10px;
        }
      }

      @media (max-width: 576px) {
        .main-content {
          padding: 5px;
        }
      }

      /* Scrollbar */
      .sidebar::-webkit-scrollbar {
        width: 6px;
      }

      .sidebar::-webkit-scrollbar-track {
        background: #f1f1f1;
      }

      .sidebar::-webkit-scrollbar-thumb {
        background: #c1c1c1;
        border-radius: 3px;
      }

      .sidebar::-webkit-scrollbar-thumb:hover {
        background: #a8a8a8;
      }
    </style>

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