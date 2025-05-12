<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Khôi phục mật khẩu - Shoes Family</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css">
    <link href="css/login.css" rel="stylesheet" type="text/css" />
    <style>
        .form-container {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
            padding: 30px;
            margin-top: 50px;
        }
        .form-title {
            color: #333;
            margin-bottom: 30px;
            text-align: center;
        }
        .form-group label {
            font-weight: 500;
            color: #555;
        }
        .form-control {
            border-radius: 5px;
            padding: 12px;
            border: 1px solid #ddd;
        }
        .form-control:focus {
            border-color: #80bdff;
            box-shadow: 0 0 0 0.2rem rgba(0,123,255,.25);
        }
        .btn-retrieve {
            background-color: #28a745;
            border: none;
            padding: 12px;
            font-weight: 500;
            margin-top: 20px;
        }
        .btn-retrieve:hover {
            background-color: #218838;
        }
        .alert {
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .back-to-login {
            text-align: center;
            margin-top: 20px;
        }
        .back-to-login a {
            color: #007bff;
            text-decoration: none;
        }
        .back-to-login a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <jsp:include page="Menu.jsp"></jsp:include>
    
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="form-container">
                    <h2 class="form-title">Khôi phục mật khẩu</h2>
                    
                    <c:if test="${error != null}">
                        <div class="alert alert-danger" role="alert">
                            <i class="fas fa-exclamation-circle"></i> ${error}
                        </div>
                    </c:if>
                    
                    <c:if test="${mess != null}">
                        <div class="alert alert-success" role="alert">
                            <i class="fas fa-check-circle"></i> ${mess}
                        </div>
                    </c:if>
                    
                    <form action="forgotPassword" method="post" id="forgotPasswordForm">
                        <div class="form-group">
                            <label for="username">
                                <i class="fas fa-user"></i> Tên đăng nhập
                            </label>
                            <input type="text" class="form-control" id="username" name="username" 
                                   placeholder="Nhập tên đăng nhập của bạn" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="email">
                                <i class="fas fa-envelope"></i> Email
                            </label>
                            <input type="email" class="form-control" id="email" name="email" 
                                   placeholder="Nhập email đã đăng ký" required>
                        </div>
                        
                        <button type="submit" class="btn btn-success btn-block btn-retrieve">
                            <i class="fas fa-key"></i> Khôi phục mật khẩu
                        </button>
                    </form>
                    
                    <div class="back-to-login">
                        <a href="login">
                            <i class="fas fa-arrow-left"></i> Quay lại trang đăng nhập
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
    <script>
        $(document).ready(function() {
            // Form validation
            $('#forgotPasswordForm').on('submit', function(e) {
                var email = $('#email').val();
                var username = $('#username').val();
                
                if (!email || !username) {
                    e.preventDefault();
                    alert('Vui lòng điền đầy đủ thông tin!');
                    return false;
                }
                
                // Basic email validation
                var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (!emailRegex.test(email)) {
                    e.preventDefault();
                    alert('Vui lòng nhập địa chỉ email hợp lệ!');
                    return false;
                }
            });
        });
    </script>
</body>
</html>