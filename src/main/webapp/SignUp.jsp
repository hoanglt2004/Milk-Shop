<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Ký Tài Khoản</title>
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

        .signup-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            width: 100%;
            max-width: 800px;
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

        .signup-header {
            background: linear-gradient(135deg, #da1919, #c41e3a);
            color: white;
            padding: 30px;
            text-align: center;
        }

        .signup-header h1 {
            font-size: 2rem;
            margin-bottom: 10px;
            font-weight: 600;
        }

        .signup-header p {
            opacity: 0.9;
            font-size: 1.1rem;
        }

        .signup-form {
            padding: 40px;
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-bottom: 20px;
        }

        .form-group {
            position: relative;
        }

        .form-group.full-width {
            grid-column: 1 / -1;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: 500;
            font-size: 0.95rem;
        }

        .form-group input,
        .form-group select {
            width: 100%;
            padding: 15px 20px;
            border: 2px solid #e1e5e9;
            border-radius: 12px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: #f8f9fa;
        }

        .form-group input:focus,
        .form-group select:focus {
            outline: none;
            border-color: #da1919;
            background: white;
            box-shadow: 0 0 0 3px rgba(218, 25, 25, 0.1);
        }

        .required {
            color: #da1919;
        }

        .error-message {
            color: #da1919;
            font-size: 0.875rem;
            margin-top: 5px;
            display: none;
        }

        .signup-btn {
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
            margin-top: 20px;
        }

        .signup-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(218, 25, 25, 0.3);
        }

        .login-link {
            text-align: center;
            margin-top: 25px;
            padding-top: 25px;
            border-top: 1px solid #e1e5e9;
        }

        .login-link a {
            color: #da1919;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .login-link a:hover {
            color: #c41e3a;
            text-decoration: underline;
        }

        .alert {
            padding: 15px 20px;
            margin-bottom: 20px;
            border-radius: 8px;
            font-weight: 500;
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

        @media (max-width: 768px) {
            .form-row {
                grid-template-columns: 1fr;
                gap: 15px;
            }
            
            .signup-container {
                margin: 10px;
            }
            
            .signup-form {
                padding: 30px 20px;
            }
            
            .signup-header {
                padding: 25px 20px;
            }
            
            .signup-header h1 {
                font-size: 1.75rem;
            }
        }
    </style>
</head>
<body>
    <div class="signup-container">
        <div class="signup-header">
            <h1><i class="fas fa-user-plus"></i> Đăng Ký Tài Khoản</h1>
            <p>Tạo tài khoản mới để mua sắm cùng chúng tôi</p>
            <a href="home" style="color: white; text-decoration: none; opacity: 0.8; font-size: 0.9rem; margin-top: 10px; display: inline-block;">
                <i class="fas fa-home"></i> Về trang chủ
            </a>
        </div>
        
        <div class="signup-form">
            <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
            <% if (errorMessage != null) { %>
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-triangle"></i> <%= errorMessage %>
                </div>
            <% } %>
            
            <% String successMessage = (String) request.getAttribute("successMessage"); %>
            <% if (successMessage != null) { %>
                <div class="alert alert-success">
                    <i class="fas fa-check-circle"></i> <%= successMessage %>
                </div>
            <% } %>

            <form action="signup" method="post" id="signupForm">
                <!-- Thông tin tài khoản -->
                <h3 style="color: #da1919; margin-bottom: 20px; border-bottom: 2px solid #da1919; padding-bottom: 10px;">
                    <i class="fas fa-key"></i> Thông tin tài khoản
                </h3>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="username">Tên đăng nhập <span class="required">*</span></label>
                        <input type="text" id="username" name="username" required>
                        <div class="error-message" id="username-error"></div>
                    </div>
                    <div class="form-group">
                        <label for="email">Email <span class="required">*</span></label>
                        <input type="email" id="email" name="email" required>
                        <div class="error-message" id="email-error"></div>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="password">Mật khẩu <span class="required">*</span></label>
                        <input type="password" id="password" name="password" required>
                        <div class="error-message" id="password-error"></div>
                    </div>
                    <div class="form-group">
                        <label for="confirmPassword">Xác nhận mật khẩu <span class="required">*</span></label>
                        <input type="password" id="confirmPassword" name="confirmPassword" required>
                        <div class="error-message" id="confirm-password-error"></div>
                    </div>
                </div>

                <!-- Thông tin cá nhân -->
                <h3 style="color: #da1919; margin: 30px 0 20px 0; border-bottom: 2px solid #da1919; padding-bottom: 10px;">
                    <i class="fas fa-user"></i> Thông tin cá nhân
                </h3>

                <div class="form-group full-width">
                    <label for="fullName">Họ và tên <span class="required">*</span></label>
                    <input type="text" id="fullName" name="fullName" required>
                    <div class="error-message" id="fullName-error"></div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="phone">Số điện thoại <span class="required">*</span></label>
                        <input type="tel" id="phone" name="phone" required>
                        <div class="error-message" id="phone-error"></div>
                    </div>
                    <div class="form-group">
                        <label for="province">Tỉnh/Thành phố <span class="required">*</span></label>
                        <select id="province" name="province" required>
                            <option value="">-- Chọn tỉnh/thành phố --</option>
                            <option value="Hà Nội">Hà Nội</option>
                            <option value="TP. Hồ Chí Minh">TP. Hồ Chí Minh</option>
                            <option value="Hải Phòng">Hải Phòng</option>
                            <option value="Đà Nẵng">Đà Nẵng</option>
                            <option value="Cần Thơ">Cần Thơ</option>
                            <option value="An Giang">An Giang</option>
                            <option value="Bà Rịa - Vũng Tàu">Bà Rịa - Vũng Tàu</option>
                            <option value="Bạc Liêu">Bạc Liêu</option>
                            <option value="Bắc Giang">Bắc Giang</option>
                            <option value="Bắc Kạn">Bắc Kạn</option>
                            <option value="Bắc Ninh">Bắc Ninh</option>
                            <option value="Bến Tre">Bến Tre</option>
                            <option value="Bình Dương">Bình Dương</option>
                            <option value="Bình Định">Bình Định</option>
                            <option value="Bình Phước">Bình Phước</option>
                            <option value="Bình Thuận">Bình Thuận</option>
                            <option value="Cà Mau">Cà Mau</option>
                            <option value="Cao Bằng">Cao Bằng</option>
                            <option value="Đắk Lắk">Đắk Lắk</option>
                            <option value="Đắk Nông">Đắk Nông</option>
                            <option value="Điện Biên">Điện Biên</option>
                            <option value="Đồng Nai">Đồng Nai</option>
                            <option value="Đồng Tháp">Đồng Tháp</option>
                            <option value="Gia Lai">Gia Lai</option>
                            <option value="Hà Giang">Hà Giang</option>
                            <option value="Hà Nam">Hà Nam</option>
                            <option value="Hà Tĩnh">Hà Tĩnh</option>
                            <option value="Hải Dương">Hải Dương</option>
                            <option value="Hậu Giang">Hậu Giang</option>
                            <option value="Hòa Bình">Hòa Bình</option>
                            <option value="Hưng Yên">Hưng Yên</option>
                            <option value="Khánh Hòa">Khánh Hòa</option>
                            <option value="Kiên Giang">Kiên Giang</option>
                            <option value="Kon Tum">Kon Tum</option>
                            <option value="Lai Châu">Lai Châu</option>
                            <option value="Lâm Đồng">Lâm Đồng</option>
                            <option value="Lạng Sơn">Lạng Sơn</option>
                            <option value="Lào Cai">Lào Cai</option>
                            <option value="Long An">Long An</option>
                            <option value="Nam Định">Nam Định</option>
                            <option value="Nghệ An">Nghệ An</option>
                            <option value="Ninh Bình">Ninh Bình</option>
                            <option value="Ninh Thuận">Ninh Thuận</option>
                            <option value="Phú Thọ">Phú Thọ</option>
                            <option value="Phú Yên">Phú Yên</option>
                            <option value="Quảng Bình">Quảng Bình</option>
                            <option value="Quảng Nam">Quảng Nam</option>
                            <option value="Quảng Ngãi">Quảng Ngãi</option>
                            <option value="Quảng Ninh">Quảng Ninh</option>
                            <option value="Quảng Trị">Quảng Trị</option>
                            <option value="Sóc Trăng">Sóc Trăng</option>
                            <option value="Sơn La">Sơn La</option>
                            <option value="Tây Ninh">Tây Ninh</option>
                            <option value="Thái Bình">Thái Bình</option>
                            <option value="Thái Nguyên">Thái Nguyên</option>
                            <option value="Thanh Hóa">Thanh Hóa</option>
                            <option value="Thừa Thiên Huế">Thừa Thiên Huế</option>
                            <option value="Tiền Giang">Tiền Giang</option>
                            <option value="Trà Vinh">Trà Vinh</option>
                            <option value="Tuyên Quang">Tuyên Quang</option>
                            <option value="Vĩnh Long">Vĩnh Long</option>
                            <option value="Vĩnh Phúc">Vĩnh Phúc</option>
                            <option value="Yên Bái">Yên Bái</option>
                        </select>
                        <div class="error-message" id="province-error"></div>
                    </div>
                </div>

                <div class="form-group full-width">
                    <label for="address">Địa chỉ <span class="required">*</span></label>
                    <input type="text" id="address" name="address" placeholder="Số nhà, tên đường, phường/xã, quận/huyện" required>
                    <div class="error-message" id="address-error"></div>
                </div>

                <button type="submit" class="signup-btn">
                    <i class="fas fa-user-plus"></i> Đăng Ký Tài Khoản
                </button>
            </form>

            <div class="login-link">
                <p>Đã có tài khoản? <a href="login"><i class="fas fa-sign-in-alt"></i> Đăng nhập ngay</a></p>
            </div>
        </div>
    </div>

    <script>
        document.getElementById('signupForm').addEventListener('submit', function(e) {
            // Reset error messages
            const errorElements = document.querySelectorAll('.error-message');
            errorElements.forEach(el => el.style.display = 'none');

            let isValid = true;

            // Validate username
            const username = document.getElementById('username').value.trim();
            if (username.length < 3 || username.length > 20) {
                document.getElementById('username-error').textContent = 'Tên đăng nhập phải từ 3-20 ký tự';
                document.getElementById('username-error').style.display = 'block';
                isValid = false;
            } else if (!/^[a-zA-Z0-9_]+$/.test(username)) {
                document.getElementById('username-error').textContent = 'Tên đăng nhập chỉ được chứa chữ cái, số và dấu gạch dưới';
                document.getElementById('username-error').style.display = 'block';
                isValid = false;
            }

            // Validate email
            const email = document.getElementById('email').value.trim();
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(email)) {
                document.getElementById('email-error').textContent = 'Email không hợp lệ';
                document.getElementById('email-error').style.display = 'block';
                isValid = false;
            }

            // Validate password
            const password = document.getElementById('password').value;
            if (password.length < 6) {
                document.getElementById('password-error').textContent = 'Mật khẩu phải có ít nhất 6 ký tự';
                document.getElementById('password-error').style.display = 'block';
                isValid = false;
            }

            // Validate confirm password
            const confirmPassword = document.getElementById('confirmPassword').value;
            if (password !== confirmPassword) {
                document.getElementById('confirm-password-error').textContent = 'Mật khẩu xác nhận không khớp';
                document.getElementById('confirm-password-error').style.display = 'block';
                isValid = false;
            }

            // Validate full name
            const fullName = document.getElementById('fullName').value.trim();
            if (fullName.length < 2) {
                document.getElementById('fullName-error').textContent = 'Họ và tên phải có ít nhất 2 ký tự';
                document.getElementById('fullName-error').style.display = 'block';
                isValid = false;
            }

            // Validate phone
            const phone = document.getElementById('phone').value.trim();
            const phoneRegex = /^[0-9]{10,11}$/;
            if (!phoneRegex.test(phone)) {
                document.getElementById('phone-error').textContent = 'Số điện thoại phải có 10-11 chữ số';
                document.getElementById('phone-error').style.display = 'block';
                isValid = false;
            }

            // Validate province
            const province = document.getElementById('province').value;
            if (!province) {
                document.getElementById('province-error').textContent = 'Vui lòng chọn tỉnh/thành phố';
                document.getElementById('province-error').style.display = 'block';
                isValid = false;
            }

            // Validate address
            const address = document.getElementById('address').value.trim();
            if (address.length < 5) {
                document.getElementById('address-error').textContent = 'Địa chỉ phải có ít nhất 5 ký tự';
                document.getElementById('address-error').style.display = 'block';
                isValid = false;
            }

            if (!isValid) {
                e.preventDefault();
            }
        });
    </script>
</body>
</html> 