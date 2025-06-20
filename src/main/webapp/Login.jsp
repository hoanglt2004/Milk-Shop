<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Nhập</title>
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

        .login-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            width: 100%;
            max-width: 450px;
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

        .login-header {
            background: linear-gradient(135deg, #da1919, #c41e3a);
            color: white;
            padding: 40px 30px;
            text-align: center;
        }

        .login-header h1 {
            font-size: 2rem;
            margin-bottom: 10px;
            font-weight: 600;
        }

        .login-header p {
            opacity: 0.9;
            font-size: 1rem;
        }

        .login-form {
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

        .form-check {
            display: flex;
            align-items: center;
            margin-bottom: 25px;
        }

        .form-check input[type="checkbox"] {
            width: auto;
            margin-right: 10px;
            transform: scale(1.2);
            accent-color: #da1919;
        }

        .form-check label {
            color: #666;
            font-size: 0.9rem;
            cursor: pointer;
        }

        .login-btn {
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

        .login-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(218, 25, 25, 0.3);
        }

        .signup-link {
            text-align: center;
            padding-top: 20px;
            border-top: 1px solid #e1e5e9;
        }

        .signup-link a {
            color: #da1919;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
            display: inline-block;
            padding: 10px 20px;
            border: 2px solid #da1919;
            border-radius: 8px;
        }

        .signup-link a:hover {
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

        .forgot-password {
            text-align: center;
            margin-top: 15px;
        }

        .forgot-password a {
            color: #666;
            text-decoration: none;
            font-size: 0.9rem;
            transition: color 0.3s ease;
        }

        .forgot-password a:hover {
            color: #da1919;
            text-decoration: underline;
        }

        /* Welcome animation for success message */
        .welcome-message {
            background: linear-gradient(135deg, #d1e7dd, #badbcc);
            border-left: 4px solid #0f5132;
            animation: pulse 2s ease-in-out;
        }

        @keyframes pulse {
            0%, 100% {
                transform: scale(1);
            }
            50% {
                transform: scale(1.02);
            }
        }

        @media (max-width: 768px) {
            .login-container {
                margin: 10px;
                max-width: 90%;
            }
            
            .login-form {
                padding: 30px 20px;
            }
            
            .login-header {
                padding: 30px 20px;
            }
            
            .login-header h1 {
                font-size: 1.75rem;
            }
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-header">
            <h1><i class="fas fa-sign-in-alt"></i> Đăng Nhập</h1>
            <p>Chào mừng bạn quay trở lại!</p>
            <a href="home" style="color: white; text-decoration: none; opacity: 0.8; font-size: 0.9rem; margin-top: 10px; display: inline-block;">
                <i class="fas fa-home"></i> Về trang chủ
            </a>
        </div>
        
        <div class="login-form">
            <!-- Hiển thị thông báo từ session -->
            <c:if test="${not empty sessionScope.successMessage}">
                <div class="alert alert-success welcome-message">
                    <i class="fas fa-check-circle"></i> ${sessionScope.successMessage}
                </div>
                <!-- Xóa thông báo khỏi session sau khi hiển thị -->
                <c:remove var="successMessage" scope="session"/>
            </c:if>
            
            <!-- Hiển thị thông báo lỗi -->
            <c:if test="${not empty error}">
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-triangle"></i> ${error}
                </div>
            </c:if>
            
            <!-- Hiển thị thông báo thành công khác -->
            <c:if test="${not empty mess}">
                <div class="alert alert-success">
                    <i class="fas fa-check-circle"></i> ${mess}
                </div>
            </c:if>

            <form action="login" method="post" id="loginForm">
                <div class="form-group">
                    <label for="username">Tên đăng nhập</label>
                    <input type="text" id="username" name="user" value="${username}" 
                           placeholder="Nhập tên đăng nhập" required autofocus>
                </div>

                <div class="form-group">
                    <label for="password">Mật khẩu</label>
                    <input type="password" id="password" name="pass" value="${password}" 
                           placeholder="Nhập mật khẩu" required>
                </div>

                <div class="form-check">
                    <input type="checkbox" id="remember" name="remember" value="1">
                    <label for="remember">Ghi nhớ đăng nhập</label>
                </div>

                <button type="submit" class="login-btn">
                    <i class="fas fa-sign-in-alt"></i> Đăng Nhập
                </button>
            </form>

            <div class="forgot-password">
                <a href="forgotPassword">
                    <i class="fas fa-key"></i> Quên mật khẩu?
                </a>
            </div>

            <div class="signup-link">
                <p>Chưa có tài khoản? 
                    <a href="signup">
                        <i class="fas fa-user-plus"></i> Đăng ký ngay
                    </a>
                </p>
            </div>
        </div>
    </div>

    <script>
        // Enhanced form validation
        document.getElementById('loginForm').addEventListener('submit', function(e) {
            const username = document.getElementById('username').value.trim();
            const password = document.getElementById('password').value;
            
            if (username.length < 3) {
                e.preventDefault();
                alert('Tên đăng nhập phải có ít nhất 3 ký tự!');
                return;
            }
            
            if (password.length < 6) {
                e.preventDefault();
                alert('Mật khẩu phải có ít nhất 6 ký tự!');
                return;
            }
        });

        // Auto-hide success message after 5 seconds
        const successAlert = document.querySelector('.alert-success');
        if (successAlert) {
            setTimeout(() => {
                successAlert.style.opacity = '0';
                successAlert.style.transform = 'translateY(-20px)';
                setTimeout(() => {
                    successAlert.style.display = 'none';
                }, 300);
            }, 5000);
        }

                 // Add loading state to login button
         const loginForm = document.getElementById('loginForm');
         const loginBtn = document.querySelector('.login-btn');
         
         loginForm.addEventListener('submit', function() {
             loginBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Đang đăng nhập...';
             loginBtn.disabled = true;
         });
     </script>
</body>
</html>