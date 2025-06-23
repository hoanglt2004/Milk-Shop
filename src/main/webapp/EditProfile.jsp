<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Thông tin cá nhân - Milk Shop</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.11.2/css/all.css">
    <!-- Custom styles -->
    <link rel="stylesheet" href="css/style.css">
    
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Roboto', Arial, sans-serif;
        }
        
        .profile-container {
            min-height: 100vh;
            padding-top: 100px;
        }
        
        .profile-sidebar {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            padding: 0;
            margin-bottom: 30px;
        }
        
        .sidebar-header {
            background: linear-gradient(135deg, #da1919 0%, #c41e3a 100%);
            color: white;
            padding: 20px;
            border-radius: 10px 10px 0 0;
            text-align: center;
        }
        
        .sidebar-header h4 {
            margin: 0;
            font-weight: 500;
        }
        
        .sidebar-menu {
            padding: 0;
        }
        
        .sidebar-menu .menu-item {
            display: block;
            padding: 15px 20px;
            color: #333;
            text-decoration: none;
            border-bottom: 1px solid #eee;
            transition: all 0.3s ease;
        }
        
        .sidebar-menu .menu-item:hover {
            background-color: #f8f9fa;
            color: #da1919;
            text-decoration: none;
        }
        
        .sidebar-menu .menu-item.active {
            background-color: #da1919;
            color: white;
        }
        
        .sidebar-menu .menu-item.active:hover {
            background-color: #c41e3a;
            color: white;
        }
        
        .sidebar-menu .menu-item:last-child {
            border-bottom: none;
            border-radius: 0 0 10px 10px;
        }
        
        .sidebar-menu .menu-item i {
            margin-right: 10px;
            width: 20px;
        }
        
        .main-content {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            min-height: 600px;
        }
        
        .content-header {
            background: linear-gradient(135deg, #da1919 0%, #c41e3a 100%);
            color: white;
            padding: 20px 30px;
            border-radius: 10px 10px 0 0;
            margin-bottom: 0;
        }
        
        .content-header h3 {
            margin: 0;
            font-weight: 500;
        }
        
        .content-body {
            padding: 30px;
        }
        
        .form-group {
            margin-bottom: 25px;
        }
        
        .form-group label {
            font-weight: 500;
            color: #333;
            margin-bottom: 8px;
            display: block;
        }
        
        .form-group label i {
            color: #da1919;
        }
        
        .form-control {
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 12px 15px;
            font-size: 14px;
            transition: all 0.3s ease;
        }
        
        .form-control:focus {
            border-color: #da1919;
            box-shadow: 0 0 0 0.2rem rgba(218, 25, 25, 0.25);
        }
        
        .btn-update {
            background: linear-gradient(135deg, #da1919 0%, #c41e3a 100%);
            border: none;
            border-radius: 8px;
            padding: 15px 40px;
            font-weight: 500;
            color: white;
            transition: all 0.3s ease;
            width: 100%;
            margin-bottom: 15px;
        }
        
        .btn-update:hover {
            background: linear-gradient(135deg, #c41e3a 0%, #a91729 100%);
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(218, 25, 25, 0.3);
            color: white;
        }
        
        .btn-cancel {
            background: #6c757d;
            border: none;
            border-radius: 8px;
            padding: 15px 40px;
            font-weight: 500;
            color: white;
            transition: all 0.3s ease;
            width: 100%;
        }
        
        .btn-cancel:hover {
            background: #5a6268;
            transform: translateY(-2px);
            color: white;
        }
        
        .button-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            margin-top: 30px;
            max-width: 300px;
            margin-left: auto;
            margin-right: auto;
        }
        
        .alert {
            border-radius: 8px;
            border: none;
            margin-bottom: 25px;
        }
        
        .alert-success {
            background: #d4edda;
            color: #155724;
            border-left: 4px solid #28a745;
        }
        
        .alert-danger {
            background: #f8d7da;
            color: #721c24;
            border-left: 4px solid #dc3545;
        }
        
        .input-icon {
            position: relative;
        }
        
        .input-icon i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #da1919;
            z-index: 2;
        }
        
        .input-icon .form-control {
            padding-left: 45px;
        }
        
        @media (max-width: 768px) {
            .profile-container {
                padding-top: 20px;
            }
            
            .content-body {
                padding: 20px;
            }
            
            .content-header {
                padding: 15px 20px;
            }
        }
    </style>
</head>

<body onload="loadAmountCart()">
    <!-- Kiểm tra session -->
    <c:if test="${empty sessionScope.acc}">
        <script>
            alert('Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại.');
            window.location.href = 'Login.jsp';
        </script>
    </c:if>
    
    <jsp:include page="Menu.jsp"></jsp:include>
    
    <div class="profile-container">
        <div class="container-fluid">
            <div class="row">
                <!-- Sidebar -->
                <div class="col-lg-3 col-md-4">
                    <div class="profile-sidebar">
                        <div class="sidebar-header">
                            <h4><i class="fas fa-user-circle mr-2"></i>Tài khoản của tôi</h4>
                        </div>
                        <div class="sidebar-menu">
                            <a href="editProfile" class="menu-item active">
                                <i class="fas fa-user-edit"></i>
                                Thông tin tài khoản
                            </a>
                            <a href="orderHistory" class="menu-item">
                                <i class="fas fa-history"></i>
                                Lịch sử mua hàng
                            </a>
                        </div>
                    </div>
                </div>
                
                <!-- Main Content -->
                <div class="col-lg-9 col-md-8">
                    <div class="main-content">
                        <div class="content-header">
                            <h3><i class="fas fa-user-edit mr-3"></i>Thông tin tài khoản</h3>
                        </div>
                        
                        <div class="content-body">
                            <!-- Thông báo -->
                            <c:if test="${not empty mess}">
                                <div class="alert alert-success" role="alert">
                                    <i class="fas fa-check-circle mr-2"></i>${mess}
                                </div>
                            </c:if>
                            <c:if test="${not empty error}">
                                <div class="alert alert-danger" role="alert">
                                    <i class="fas fa-exclamation-circle mr-2"></i>${error}
                                </div>
                            </c:if>
                            
                            <form action="editProfile" method="post" accept-charset="UTF-8">
                                <!-- Hidden username field -->
                                <input type="hidden" name="username" value="${fullAccount != null ? fullAccount.user : sessionScope.acc.user}">
                                
                                <div class="row">
                                    <!-- Password -->
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="password"><i class="fas fa-lock mr-2"></i>Mật khẩu</label>
                                            <div class="input-icon">
                                                <i class="fas fa-lock"></i>
                                                <input type="password" id="password" name="password" class="form-control" 
                                                       value="${fullAccount != null ? fullAccount.pass : sessionScope.acc.pass}" required>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <!-- Full Name -->
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="fullName"><i class="fas fa-id-card mr-2"></i>Họ và tên</label>
                                            <div class="input-icon">
                                                <i class="fas fa-id-card"></i>
                                                <input type="text" id="fullName" name="fullName" class="form-control" 
                                                       value="${fullAccount != null ? fullAccount.fullName : ''}" placeholder="Nhập họ và tên đầy đủ">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="row">
                                    <!-- Phone -->
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="phone"><i class="fas fa-phone mr-2"></i>Số điện thoại</label>
                                            <div class="input-icon">
                                                <i class="fas fa-phone"></i>
                                                <input type="text" id="phone" name="phone" class="form-control" 
                                                       value="${fullAccount != null ? fullAccount.phone : ''}" placeholder="Nhập số điện thoại">
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <!-- Email -->
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="email"><i class="fas fa-envelope mr-2"></i>Email</label>
                                            <div class="input-icon">
                                                <i class="fas fa-envelope"></i>
                                                <input type="email" id="email" name="email" class="form-control" 
                                                       value="${fullAccount != null ? fullAccount.email : sessionScope.acc.email}" required placeholder="Nhập địa chỉ email">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Address -->
                                <div class="form-group">
                                    <label for="address"><i class="fas fa-map-marker-alt mr-2"></i>Địa chỉ</label>
                                    <div class="input-icon">
                                        <i class="fas fa-map-marker-alt"></i>
                                        <input type="text" id="address" name="address" class="form-control" 
                                               value="${fullAccount != null ? fullAccount.address : ''}" placeholder="Nhập địa chỉ chi tiết">
                                    </div>
                                </div>
                                
                                <!-- Province -->
                                <div class="form-group">
                                    <label for="province"><i class="fas fa-map mr-2"></i>Tỉnh/Thành phố</label>
                                    <div class="input-icon">
                                        <i class="fas fa-map"></i>
                                        <select id="province" name="province" class="form-control">
                                            <option value="">Chọn tỉnh/thành phố</option>
                                            <option value="Hà Nội" ${fullAccount != null && fullAccount.province == 'Hà Nội' ? 'selected' : ''}>Hà Nội</option>
                                            <option value="TP Hồ Chí Minh" ${fullAccount != null && fullAccount.province == 'TP Hồ Chí Minh' ? 'selected' : ''}>TP Hồ Chí Minh</option>
                                            <option value="Đà Nẵng" ${fullAccount != null && fullAccount.province == 'Đà Nẵng' ? 'selected' : ''}>Đà Nẵng</option>
                                            <option value="Hải Phòng" ${fullAccount != null && fullAccount.province == 'Hải Phòng' ? 'selected' : ''}>Hải Phòng</option>
                                            <option value="Cần Thơ" ${fullAccount != null && fullAccount.province == 'Cần Thơ' ? 'selected' : ''}>Cần Thơ</option>
                                            <option value="An Giang" ${fullAccount != null && fullAccount.province == 'An Giang' ? 'selected' : ''}>An Giang</option>
                                            <option value="Bà Rịa - Vũng Tàu" ${fullAccount != null && fullAccount.province == 'Bà Rịa - Vũng Tàu' ? 'selected' : ''}>Bà Rịa - Vũng Tàu</option>
                                            <option value="Bắc Giang" ${fullAccount != null && fullAccount.province == 'Bắc Giang' ? 'selected' : ''}>Bắc Giang</option>
                                            <option value="Bắc Kạn" ${fullAccount != null && fullAccount.province == 'Bắc Kạn' ? 'selected' : ''}>Bắc Kạn</option>
                                            <option value="Bạc Liêu" ${fullAccount != null && fullAccount.province == 'Bạc Liêu' ? 'selected' : ''}>Bạc Liêu</option>
                                            <option value="Bắc Ninh" ${fullAccount != null && fullAccount.province == 'Bắc Ninh' ? 'selected' : ''}>Bắc Ninh</option>
                                            <option value="Bến Tre" ${fullAccount != null && fullAccount.province == 'Bến Tre' ? 'selected' : ''}>Bến Tre</option>
                                            <option value="Bình Định" ${fullAccount != null && fullAccount.province == 'Bình Định' ? 'selected' : ''}>Bình Định</option>
                                            <option value="Bình Dương" ${fullAccount != null && fullAccount.province == 'Bình Dương' ? 'selected' : ''}>Bình Dương</option>
                                            <option value="Bình Phước" ${fullAccount != null && fullAccount.province == 'Bình Phước' ? 'selected' : ''}>Bình Phước</option>
                                            <option value="Bình Thuận" ${fullAccount != null && fullAccount.province == 'Bình Thuận' ? 'selected' : ''}>Bình Thuận</option>
                                            <option value="Cà Mau" ${fullAccount != null && fullAccount.province == 'Cà Mau' ? 'selected' : ''}>Cà Mau</option>
                                            <option value="Cao Bằng" ${fullAccount != null && fullAccount.province == 'Cao Bằng' ? 'selected' : ''}>Cao Bằng</option>
                                            <option value="Đắk Lắk" ${fullAccount != null && fullAccount.province == 'Đắk Lắk' ? 'selected' : ''}>Đắk Lắk</option>
                                            <option value="Đắk Nông" ${fullAccount != null && fullAccount.province == 'Đắk Nông' ? 'selected' : ''}>Đắk Nông</option>
                                            <option value="Điện Biên" ${fullAccount != null && fullAccount.province == 'Điện Biên' ? 'selected' : ''}>Điện Biên</option>
                                            <option value="Đồng Nai" ${fullAccount != null && fullAccount.province == 'Đồng Nai' ? 'selected' : ''}>Đồng Nai</option>
                                            <option value="Đồng Tháp" ${fullAccount != null && fullAccount.province == 'Đồng Tháp' ? 'selected' : ''}>Đồng Tháp</option>
                                            <option value="Gia Lai" ${fullAccount != null && fullAccount.province == 'Gia Lai' ? 'selected' : ''}>Gia Lai</option>
                                            <option value="Hà Giang" ${fullAccount != null && fullAccount.province == 'Hà Giang' ? 'selected' : ''}>Hà Giang</option>
                                            <option value="Hà Nam" ${fullAccount != null && fullAccount.province == 'Hà Nam' ? 'selected' : ''}>Hà Nam</option>
                                            <option value="Hà Tĩnh" ${fullAccount != null && fullAccount.province == 'Hà Tĩnh' ? 'selected' : ''}>Hà Tĩnh</option>
                                            <option value="Hải Dương" ${fullAccount != null && fullAccount.province == 'Hải Dương' ? 'selected' : ''}>Hải Dương</option>
                                            <option value="Hậu Giang" ${fullAccount != null && fullAccount.province == 'Hậu Giang' ? 'selected' : ''}>Hậu Giang</option>
                                            <option value="Hòa Bình" ${fullAccount != null && fullAccount.province == 'Hòa Bình' ? 'selected' : ''}>Hòa Bình</option>
                                            <option value="Hưng Yên" ${fullAccount != null && fullAccount.province == 'Hưng Yên' ? 'selected' : ''}>Hưng Yên</option>
                                            <option value="Khánh Hòa" ${fullAccount != null && fullAccount.province == 'Khánh Hòa' ? 'selected' : ''}>Khánh Hòa</option>
                                            <option value="Kiên Giang" ${fullAccount != null && fullAccount.province == 'Kiên Giang' ? 'selected' : ''}>Kiên Giang</option>
                                            <option value="Kon Tum" ${fullAccount != null && fullAccount.province == 'Kon Tum' ? 'selected' : ''}>Kon Tum</option>
                                            <option value="Lai Châu" ${fullAccount != null && fullAccount.province == 'Lai Châu' ? 'selected' : ''}>Lai Châu</option>
                                            <option value="Lâm Đồng" ${fullAccount != null && fullAccount.province == 'Lâm Đồng' ? 'selected' : ''}>Lâm Đồng</option>
                                            <option value="Lạng Sơn" ${fullAccount != null && fullAccount.province == 'Lạng Sơn' ? 'selected' : ''}>Lạng Sơn</option>
                                            <option value="Lào Cai" ${fullAccount != null && fullAccount.province == 'Lào Cai' ? 'selected' : ''}>Lào Cai</option>
                                            <option value="Long An" ${fullAccount != null && fullAccount.province == 'Long An' ? 'selected' : ''}>Long An</option>
                                            <option value="Nam Định" ${fullAccount != null && fullAccount.province == 'Nam Định' ? 'selected' : ''}>Nam Định</option>
                                            <option value="Nghệ An" ${fullAccount != null && fullAccount.province == 'Nghệ An' ? 'selected' : ''}>Nghệ An</option>
                                            <option value="Ninh Bình" ${fullAccount != null && fullAccount.province == 'Ninh Bình' ? 'selected' : ''}>Ninh Bình</option>
                                            <option value="Ninh Thuận" ${fullAccount != null && fullAccount.province == 'Ninh Thuận' ? 'selected' : ''}>Ninh Thuận</option>
                                            <option value="Phú Thọ" ${fullAccount != null && fullAccount.province == 'Phú Thọ' ? 'selected' : ''}>Phú Thọ</option>
                                            <option value="Phú Yên" ${fullAccount != null && fullAccount.province == 'Phú Yên' ? 'selected' : ''}>Phú Yên</option>
                                            <option value="Quảng Bình" ${fullAccount != null && fullAccount.province == 'Quảng Bình' ? 'selected' : ''}>Quảng Bình</option>
                                            <option value="Quảng Nam" ${fullAccount != null && fullAccount.province == 'Quảng Nam' ? 'selected' : ''}>Quảng Nam</option>
                                            <option value="Quảng Ngãi" ${fullAccount != null && fullAccount.province == 'Quảng Ngãi' ? 'selected' : ''}>Quảng Ngãi</option>
                                            <option value="Quảng Ninh" ${fullAccount != null && fullAccount.province == 'Quảng Ninh' ? 'selected' : ''}>Quảng Ninh</option>
                                            <option value="Quảng Trị" ${fullAccount != null && fullAccount.province == 'Quảng Trị' ? 'selected' : ''}>Quảng Trị</option>
                                            <option value="Sóc Trăng" ${fullAccount != null && fullAccount.province == 'Sóc Trăng' ? 'selected' : ''}>Sóc Trăng</option>
                                            <option value="Sơn La" ${fullAccount != null && fullAccount.province == 'Sơn La' ? 'selected' : ''}>Sơn La</option>
                                            <option value="Tây Ninh" ${fullAccount != null && fullAccount.province == 'Tây Ninh' ? 'selected' : ''}>Tây Ninh</option>
                                            <option value="Thái Bình" ${fullAccount != null && fullAccount.province == 'Thái Bình' ? 'selected' : ''}>Thái Bình</option>
                                            <option value="Thái Nguyên" ${fullAccount != null && fullAccount.province == 'Thái Nguyên' ? 'selected' : ''}>Thái Nguyên</option>
                                            <option value="Thanh Hóa" ${fullAccount != null && fullAccount.province == 'Thanh Hóa' ? 'selected' : ''}>Thanh Hóa</option>
                                            <option value="Thừa Thiên Huế" ${fullAccount != null && fullAccount.province == 'Thừa Thiên Huế' ? 'selected' : ''}>Thừa Thiên Huế</option>
                                            <option value="Tiền Giang" ${fullAccount != null && fullAccount.province == 'Tiền Giang' ? 'selected' : ''}>Tiền Giang</option>
                                            <option value="Trà Vinh" ${fullAccount != null && fullAccount.province == 'Trà Vinh' ? 'selected' : ''}>Trà Vinh</option>
                                            <option value="Tuyên Quang" ${fullAccount != null && fullAccount.province == 'Tuyên Quang' ? 'selected' : ''}>Tuyên Quang</option>
                                            <option value="Vĩnh Long" ${fullAccount != null && fullAccount.province == 'Vĩnh Long' ? 'selected' : ''}>Vĩnh Long</option>
                                            <option value="Vĩnh Phúc" ${fullAccount != null && fullAccount.province == 'Vĩnh Phúc' ? 'selected' : ''}>Vĩnh Phúc</option>
                                            <option value="Yên Bái" ${fullAccount != null && fullAccount.province == 'Yên Bái' ? 'selected' : ''}>Yên Bái</option>
                                        </select>
                                    </div>
                                </div>
                                
                                <div class="button-container">
                                    <button type="submit" class="btn btn-update">
                                        <i class="fas fa-save mr-2"></i>Cập nhật thông tin
                                    </button>
                                    <a href="home" class="btn btn-cancel">
                                        <i class="fas fa-times mr-2"></i>Hủy bỏ
                                    </a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
    <script>
        function loadAmountCart() {
            $.ajax({
                url: "/WebsiteBanSua/loadAllAmountCart",
                type: "get",
                success: function (responseData) {
                    document.getElementById("amountCart").innerHTML = responseData;
                }
            });
        }
        
        // Form validation
        document.querySelector('form').addEventListener('submit', function(e) {
            const password = document.getElementById('password').value.trim();
            const email = document.getElementById('email').value.trim();
            
            if (!password || !email) {
                e.preventDefault();
                alert('Vui lòng điền đầy đủ thông tin bắt buộc (Mật khẩu, Email)');
                return false;
            }
            
            // Email validation
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(email)) {
                e.preventDefault();
                alert('Vui lòng nhập địa chỉ email hợp lệ');
                return false;
            }
            
            // Phone validation
            const phone = document.getElementById('phone').value.trim();
            if (phone && !/^[0-9+\-\s()]+$/.test(phone)) {
                e.preventDefault();
                alert('Số điện thoại không hợp lệ');
                return false;
            }
        });
        
        // Auto-hide alerts after 5 seconds
        setTimeout(function() {
            $('.alert').fadeOut('slow');
        }, 5000);
        
        // Sidebar menu active state
        document.addEventListener('DOMContentLoaded', function() {
            const currentPath = window.location.pathname;
            const menuItems = document.querySelectorAll('.sidebar-menu .menu-item');
            
            menuItems.forEach(function(item) {
                item.classList.remove('active');
                if (currentPath.includes('editProfile') && item.getAttribute('href') === 'editProfile') {
                    item.classList.add('active');
                } else if (currentPath.includes('orderHistory') && item.getAttribute('href') === 'orderHistory') {
                    item.classList.add('active');
                }
            });
        });
    </script>
</body>
</html>