<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quên Mật Khẩu</title>
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
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .forgot-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            width: 100%;
            max-width: 500px;
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

        .forgot-header {
            background: linear-gradient(135deg, #da1919, #c41e3a);
            color: white;
            padding: 40px 30px;
            text-align: center;
        }

        .forgot-header h1 {
            font-size: 2rem;
            margin-bottom: 10px;
            font-weight: 600;
        }

        .forgot-header p {
            opacity: 0.9;
            font-size: 1rem;
            line-height: 1.5;
        }

        .forgot-form {
            padding: 40px 30px;
        }

        .form-group {
            position: relative;
            margin-bottom: 25px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: 500;
            font-size: 0.95rem;
        }

        .form-group input {
            width: 100%;
            padding: 15px 20px;
            border: 2px solid #e1e5e9;
            border-radius: 12px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: #f8f9fa;
        }

        .form-group input:focus {
            outline: none;
            border-color: #da1919;
            background: white;
            box-shadow: 0 0 0 3px rgba(218, 25, 25, 0.1);
        }

        .forgot-btn {
            width: 100%;
            padding: 16px;
            background: linear-gradient(135deg, #da1919, #c41e3a);
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-bottom: 20px;
        }

        .forgot-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(218, 25, 25, 0.3);
        }

        .forgot-btn:disabled {
            opacity: 0.6;
            cursor: not-allowed;
            transform: none;
        }

        .back-link {
            text-align: center;
            padding-top: 20px;
            border-top: 1px solid #e1e5e9;
        }

        .back-link a {
            color: #da1919;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
            display: inline-block;
            padding: 10px 20px;
            border: 2px solid #da1919;
            border-radius: 8px;
        }

        .back-link a:hover {
            background: #da1919;
            color: white;
            text-decoration: none;
            transform: translateY(-1px);
        }

        .alert {
            padding: 15px 20px;
            margin-bottom: 20px;
            border-radius: 8px;
            font-weight: 500;
            animation: fadeIn 0.5s ease;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .alert-danger {
            background-color: #f8d7da;
            border: 1px solid #f5c2c7;
            color: #842029;
        }

        .alert-success {
            background-color: #d1e7dd;
            border: 1px solid #badbcc;
            color: #0f5132;
        }

        .info-box {
            background: #f8f9fa;
            border: 2px solid #e9ecef;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 25px;
            border-left: 4px solid #da1919;
        }

        .info-box h4 {
            color: #da1919;
            margin-bottom: 10px;
            font-size: 1.1rem;
        }

        .info-box ul {
            color: #666;
            margin-left: 20px;
            line-height: 1.6;
        }

        .info-box ul li {
            margin-bottom: 5px;
        }

        .input-icon {
            position: relative;
        }

        .input-icon i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #666;
            z-index: 1;
        }

        .input-icon input {
            padding-left: 45px;
        }

        @media (max-width: 768px) {
            .forgot-container {
                margin: 10px;
                max-width: 90%;
            }
            
            .forgot-form {
                padding: 30px 20px;
            }
            
            .forgot-header {
                padding: 30px 20px;
            }
            
            .forgot-header h1 {
                font-size: 1.75rem;
            }
        }

        /* Loading animation */
        .loading {
            display: inline-block;
            width: 20px;
            height: 20px;
            border: 3px solid rgba(255,255,255,.3);
            border-radius: 50%;
            border-top-color: #fff;
            animation: spin 1s ease-in-out infinite;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }
    </style>
</head>
<body>
    <div class="forgot-container">
        <div class="forgot-header">
            <h1><i class="fas fa-key"></i> Quên Mật Khẩu</h1>
            <p>Nhập thông tin để khôi phục mật khẩu của bạn</p>
            <a href="home" style="color: white; text-decoration: none; opacity: 0.8; font-size: 0.9rem; margin-top: 10px; display: inline-block;">
                <i class="fas fa-home"></i> Về trang chủ
            </a>
        </div>
        
        <div class="forgot-form">
            <!-- Hiển thị thông báo lỗi -->
            <c:if test="${not empty error}">
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-triangle"></i> ${error}
                </div>
            </c:if>
            
            <!-- Hiển thị thông báo thành công -->
            <c:if test="${not empty mess}">
                <div class="alert alert-success">
                    <i class="fas fa-check-circle"></i> ${mess}
                </div>
            </c:if>

            <div class="info-box">
                <h4><i class="fas fa-info-circle"></i> Hướng dẫn khôi phục</h4>
                <ul>
                    <li>Nhập chính xác tên đăng nhập và email đã đăng ký</li>
                    <li>Mật khẩu mới sẽ được gửi qua email</li>
                    <li>Kiểm tra cả hộp thư đến và thư spam</li>
                    <li>Đổi mật khẩu ngay sau khi đăng nhập thành công</li>
                </ul>
            </div>

            <form action="forgotPassword" method="post" id="forgotPasswordForm">
                <div class="form-group">
                    <label for="username">
                        <i class="fas fa-user"></i> Tên đăng nhập <span style="color: #da1919;">*</span>
                    </label>
                    <div class="input-icon">
                        <i class="fas fa-user"></i>
                        <input type="text" id="username" name="username" 
                               placeholder="Nhập tên đăng nhập của bạn" 
                               value="${param.username}" required autofocus>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="email">
                        <i class="fas fa-envelope"></i> Email <span style="color: #da1919;">*</span>
                    </label>
                    <div class="input-icon">
                        <i class="fas fa-envelope"></i>
                        <input type="email" id="email" name="email" 
                               placeholder="Nhập email đã đăng ký" 
                               value="${param.email}" required>
                    </div>
                </div>
                
                <button type="submit" class="forgot-btn" id="submitBtn">
                    <i class="fas fa-paper-plane"></i> Gửi Yêu Cầu Khôi Phục
                </button>
            </form>

            <div class="back-link">
                <a href="login">
                    <i class="fas fa-arrow-left"></i> Quay lại đăng nhập
                </a>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const form = document.getElementById('forgotPasswordForm');
            const submitBtn = document.getElementById('submitBtn');
            const usernameInput = document.getElementById('username');
            const emailInput = document.getElementById('email');

            // Enhanced form validation
            form.addEventListener('submit', function(e) {
                const username = usernameInput.value.trim();
                const email = emailInput.value.trim();
                
                // Basic validation
                if (!username) {
                    e.preventDefault();
                    showError('Vui lòng nhập tên đăng nhập!');
                    usernameInput.focus();
                    return false;
                }
                
                if (username.length < 3) {
                    e.preventDefault();
                    showError('Tên đăng nhập phải có ít nhất 3 ký tự!');
                    usernameInput.focus();
                    return false;
                }
                
                if (!email) {
                    e.preventDefault();
                    showError('Vui lòng nhập địa chỉ email!');
                    emailInput.focus();
                    return false;
                }
                
                // Email validation
                const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (!emailRegex.test(email)) {
                    e.preventDefault();
                    showError('Vui lòng nhập địa chỉ email hợp lệ!');
                    emailInput.focus();
                    return false;
                }

                // Show loading state
                submitBtn.innerHTML = '<span class="loading"></span> Đang xử lý...';
                submitBtn.disabled = true;
            });

            // Auto-hide alerts after 7 seconds
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(alert => {
                setTimeout(() => {
                    alert.style.opacity = '0';
                    alert.style.transform = 'translateY(-20px)';
                    setTimeout(() => {
                        alert.style.display = 'none';
                    }, 300);
                }, 7000);
            });

            // Real-time input validation
            usernameInput.addEventListener('input', function() {
                validateUsername();
            });

            emailInput.addEventListener('input', function() {
                validateEmail();
            });

            function validateUsername() {
                const username = usernameInput.value.trim();
                if (username.length > 0 && username.length < 3) {
                    usernameInput.style.borderColor = '#dc3545';
                } else {
                    usernameInput.style.borderColor = '#e1e5e9';
                }
            }

            function validateEmail() {
                const email = emailInput.value.trim();
                const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (email.length > 0 && !emailRegex.test(email)) {
                    emailInput.style.borderColor = '#dc3545';
                } else {
                    emailInput.style.borderColor = '#e1e5e9';
                }
            }

            function showError(message) {
                // Remove existing error alerts
                const existingErrors = document.querySelectorAll('.alert-danger');
                existingErrors.forEach(error => error.remove());

                // Create new error alert
                const errorDiv = document.createElement('div');
                errorDiv.className = 'alert alert-danger';
                errorDiv.innerHTML = '<i class="fas fa-exclamation-triangle"></i> ' + message;
                
                // Insert at the beginning of form
                const form = document.querySelector('.forgot-form');
                form.insertBefore(errorDiv, form.firstChild);

                // Auto-hide after 5 seconds
                setTimeout(() => {
                    errorDiv.style.opacity = '0';
                    errorDiv.style.transform = 'translateY(-20px)';
                    setTimeout(() => {
                        errorDiv.remove();
                    }, 300);
                }, 5000);
            }
        });
    </script>
</body>
</html>