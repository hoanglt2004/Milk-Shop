<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thông Tin Cá Nhân</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #da1919, #c41e3a);
            min-height: 100vh;
            padding: 20px;
        }

        .profile-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            max-width: 800px;
            margin: 0 auto;
            animation: slideUp 0.6s ease;
        }

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .profile-header {
            background: linear-gradient(135deg, #da1919, #c41e3a);
            color: white;
            padding: 30px;
            text-align: center;
        }

        .profile-header h1 {
            font-size: 2rem;
            margin-bottom: 10px;
            font-weight: 600;
        }

        .profile-header p {
            opacity: 0.9;
            font-size: 1.1rem;
        }

        .profile-content {
            padding: 40px;
        }

        .info-section {
            margin-bottom: 30px;
        }

        .section-title {
            color: #da1919;
            font-size: 1.25rem;
            font-weight: 600;
            margin-bottom: 20px;
            border-bottom: 2px solid #da1919;
            padding-bottom: 10px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .info-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .info-item {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 12px;
            border-left: 4px solid #da1919;
        }

        .info-item.full-width {
            grid-column: 1 / -1;
        }

        .info-label {
            font-weight: 600;
            color: #333;
            margin-bottom: 8px;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .info-value {
            color: #666;
            font-size: 1.1rem;
        }

        .btn-container {
            text-align: center;
            margin-top: 30px;
            padding-top: 30px;
            border-top: 1px solid #e1e5e9;
        }

        .btn {
            padding: 12px 30px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
            display: inline-block;
            margin: 0 10px;
        }

        .btn-primary {
            background: linear-gradient(135deg, #da1919, #c41e3a);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(218, 25, 25, 0.3);
            color: white;
            text-decoration: none;
        }

        .btn-secondary {
            background: #6c757d;
            color: white;
        }

        .btn-secondary:hover {
            background: #5a6268;
            transform: translateY(-2px);
            color: white;
            text-decoration: none;
        }

        .alert {
            padding: 15px 20px;
            margin-bottom: 20px;
            border-radius: 8px;
            font-weight: 500;
        }

        .alert-success {
            background-color: #d1e7dd;
            border: 1px solid #badbcc;
            color: #0f5132;
        }

        .no-info {
            text-align: center;
            padding: 20px;
            color: #666;
            font-style: italic;
        }

        @media (max-width: 768px) {
            .info-grid {
                grid-template-columns: 1fr;
                gap: 15px;
            }
            
            .profile-container {
                margin: 10px;
            }
            
            .profile-content {
                padding: 30px 20px;
            }
            
            .profile-header {
                padding: 25px 20px;
            }
            
            .profile-header h1 {
                font-size: 1.75rem;
            }
        }
    </style>
</head>
<body>
    <div class="profile-container">
        <div class="profile-header">
            <h1><i class="fas fa-user-circle"></i> Thông Tin Cá Nhân</h1>
            <p>Xem và quản lý thông tin tài khoản của bạn</p>
        </div>
        
        <div class="profile-content">
            <c:if test="${not empty successMessage}">
                <div class="alert alert-success">
                    <i class="fas fa-check-circle"></i> ${successMessage}
                </div>
            </c:if>

            <!-- Thông tin tài khoản -->
            <div class="info-section">
                <h2 class="section-title">
                    <i class="fas fa-key"></i> Thông Tin Tài Khoản
                </h2>
                
                <div class="info-grid">
                    <div class="info-item">
                        <div class="info-label">Tên đăng nhập</div>
                        <div class="info-value">
                            <c:choose>
                                <c:when test="${not empty account.user}">
                                    ${account.user}
                                </c:when>
                                <c:otherwise>
                                    ${sessionScope.acc.user}
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">Email</div>
                        <div class="info-value">
                            <c:choose>
                                <c:when test="${not empty account.email}">
                                    ${account.email}
                                </c:when>
                                <c:otherwise>
                                    ${sessionScope.acc.email}
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Thông tin cá nhân -->
            <div class="info-section">
                <h2 class="section-title">
                    <i class="fas fa-user"></i> Thông Tin Cá Nhân
                </h2>
                
                <c:choose>
                    <c:when test="${not empty account.fullName || not empty account.phone || not empty account.address || not empty account.province}">
                        <div class="info-grid">
                            <c:if test="${not empty account.fullName}">
                                <div class="info-item">
                                    <div class="info-label">Họ và tên</div>
                                    <div class="info-value">${account.fullName}</div>
                                </div>
                            </c:if>
                            <c:if test="${not empty account.phone}">
                                <div class="info-item">
                                    <div class="info-label">Số điện thoại</div>
                                    <div class="info-value">${account.phone}</div>
                                </div>
                            </c:if>
                            <c:if test="${not empty account.province}">
                                <div class="info-item">
                                    <div class="info-label">Tỉnh/Thành phố</div>
                                    <div class="info-value">${account.province}</div>
                                </div>
                            </c:if>
                            <c:if test="${not empty account.address}">
                                <div class="info-item full-width">
                                    <div class="info-label">Địa chỉ</div>
                                    <div class="info-value">${account.address}</div>
                                </div>
                            </c:if>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="no-info">
                            <i class="fas fa-info-circle"></i>
                            Thông tin cá nhân chưa được cập nhật. Đây có thể là tài khoản được tạo trước khi hệ thống yêu cầu thông tin chi tiết.
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="btn-container">
                <a href="home" class="btn btn-primary">
                    <i class="fas fa-home"></i> Về Trang Chủ
                </a>
                <a href="logout" class="btn btn-secondary">
                    <i class="fas fa-sign-out-alt"></i> Đăng Xuất
                </a>
            </div>
        </div>
    </div>
</body>
</html> 