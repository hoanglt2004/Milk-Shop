<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <% 
            String requestURI = request.getRequestURI();
            String contextPath = request.getContextPath();
            String currentPage = requestURI.substring(contextPath.length());

            boolean isHomePage = "/home".equals(currentPage) || "/Home.jsp".equals(currentPage) || "/".equals(currentPage);
            boolean isShopPage = "/shop".equals(currentPage);
            boolean isLoginPage = "/login".equals(currentPage);
            boolean isForgotPasswordPage = "/forgotPassword".equals(currentPage);
            boolean isEditProfilePage = "/editProfile".equals(currentPage);
        %>

            <style>
                :root {
                    --primary-color: #d32f2f; /* A slightly deeper red */
                    --primary-hover-color: #b71c1c; /* Darker red for hover */
                    --navbar-text-color: #ffffff;
                    --navbar-link-hover-bg: rgba(255, 255, 255, 0.15);
                    --search-bg: rgba(255, 255, 255, 0.9);
                    --cart-btn-bg: #ffffff;
                    --cart-btn-text: var(--primary-color);
                }

                .navbar {
                    background-color: var(--primary-color) !important;
                    padding: 1rem 0;
                    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                    transition: all 0.3s ease;
                }

                .navbar-brand {
                    font-size: 1.8rem;
                    font-weight: 700;
                    color: var(--navbar-text-color) !important;
                    letter-spacing: 1px;
                }

                .nav-item {
                    margin: 0 5px;
                }

                .nav-link {
                    color: var(--navbar-text-color) !important;
                    font-weight: 500;
                    padding: 0.5rem 1rem !important;
                    transition: all 0.3s ease;
                    border-radius: 5px;
                    display: flex;
                    align-items: center;
                    white-space: nowrap;
                }
                
                .nav-link i {
                    margin-right: 8px; /* Space between icon and text */
                    font-size: 1.1em;
                }

                .nav-link:hover, .nav-item.dropdown:hover .nav-link {
                    background-color: var(--navbar-link-hover-bg);
                }
                
                .nav-item.active .nav-link {
                    background-color: var(--primary-hover-color);
                    font-weight: 700;
                }

                .search-input {
                    width: 250px;
                    padding: 8px 15px;
                    border: none;
                    border-radius: 25px;
                    background-color: var(--search-bg);
                    transition: all 0.3s ease;
                    margin: 0 15px;
                    color: #333;
                }

                .search-input:focus {
                    outline: none;
                    background-color: white;
                    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                    width: 300px;
                }
                
                /* Dropdown styling */
                .dropdown-menu {
                    border: none;
                    box-shadow: 0 5px 15px rgba(0,0,0,0.15);
                    background-color: #fff;
                }
                
                .dropdown-item {
                    color: #333 !important;
                    padding: 10px 20px;
                    font-weight: 500;
                    transition: background-color 0.2s ease, color 0.2s ease;
                }

                .dropdown-item i {
                     margin-right: 10px;
                     color: #777;
                }
                
                .dropdown-item:hover {
                    background-color: var(--primary-color);
                    color: #fff !important;
                }
                .dropdown-item:hover i {
                    color: #fff;
                }
                
                .dropdown-divider {
                    margin: 0;
                }

                .cart-btn {
                    background-color: var(--cart-btn-bg) !important;
                    color: var(--cart-btn-text) !important;
                    border: none !important;
                    padding: 0.5rem 1rem !important;
                    border-radius: 20px !important;
                    font-weight: bold;
                    transition: all 0.3s ease;
                    display: flex;
                    align-items: center;
                    white-space: nowrap;
                }

                .cart-btn:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
                }

                .badge {
                    margin-left: 5px;
                }
            </style>
            
            <!-- JavaScript for dynamic padding -->
            <script>
                document.addEventListener("DOMContentLoaded", function() {
                    var navbar = document.querySelector('.navbar');
                    if (navbar) {
                        var navbarHeight = navbar.offsetHeight;
                        document.body.style.paddingTop = navbarHeight + 'px';
                    }
                });
            </script>

            <!--begin of menu-->
            <nav class="navbar navbar-expand-lg navbar-dark"
                style="position: fixed; top: 0; width:100%;  z-index: 100000;">
                <div class="container">
                    <a class="navbar-brand" href="home">MILK.VN</a>
                    <button class="navbar-toggler" type="button" data-toggle="collapse"
                        data-target="#navbarsExampleDefault" aria-controls="navbarsExampleDefault" aria-expanded="false"
                        aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>

                    <div class="collapse navbar-collapse justify-content-end" id="navbarsExampleDefault">
                        <ul class="navbar-nav m-auto">
                             <li class="nav-item <%= isHomePage ? "active" : "" %>">
                                <a class="nav-link" href="home"><i class="fas fa-home"></i>Trang chủ</a>
                            </li>
                            <li class="nav-item <%= isShopPage ? "active" : "" %>">
                                <a class="nav-link" href="shop"><i class="fas fa-store"></i>Cửa hàng</a>
                            </li>
                             <li class="nav-item">
                                <a class="nav-link" href="#" data-toggle="modal" data-target="#supportModal"><i class="fas fa-headset"></i>Hỗ trợ</a>
                            </li>
                            
                            <!-- Search bar -->
                            <li class="nav-item">
                                <input type="text" name="txt" class="search-input"
                                    placeholder="Tìm kiếm sản phẩm..." form="searchForm">
                            </li>
                        </ul>

                        <ul class="navbar-nav">
                             <!-- User Authentication Links -->
                            <c:if test="${sessionScope.acc == null}">
                                <li class="nav-item <%= isLoginPage ? "active" : "" %>">
                                    <a class="nav-link" href="login"><i class="fas fa-sign-in-alt"></i>Đăng nhập</a>
                                </li>
                                <li class="nav-item <%= isForgotPasswordPage ? "active" : "" %>">
                                    <a class="nav-link" href="forgotPassword"><i class="fas fa-key"></i>Quên mật khẩu</a>
                                </li>
                            </c:if>

                            <!-- User Dropdown Menu -->
                            <c:if test="${sessionScope.acc != null}">
                                <li class="nav-item dropdown">
                                    <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                        <i class="fas fa-user-circle"></i>Xin chào, ${sessionScope.acc.user}
                                    </a>
                                    <div class="dropdown-menu dropdown-menu-right" aria-labelledby="userDropdown">
                                        <a class="dropdown-item" href="editProfile"><i class="fas fa-user-edit"></i>Sửa hồ sơ</a>
                                        <a class="dropdown-item" href="orderHistory"><i class="fas fa-history"></i>Lịch sử mua hàng</a>
                                        <c:if test="${sessionScope.acc.isAdmin == 1}">
                                            <div class="dropdown-divider"></div>
                                            <a class="dropdown-item" href="admin"><i class="fas fa-cogs"></i>Trang quản trị</a>
                                        </c:if>
                                        <div class="dropdown-divider"></div>
                                        <a class="dropdown-item" href="logout"><i class="fas fa-sign-out-alt"></i>Đăng xuất</a>
                                    </div>
                                </li>
                            </c:if>
                        </ul>
                        
                        <form action="search" method="post" class="form-inline my-2 my-lg-0" id="searchForm">
                            <a class="btn btn-sm ml-3 cart-btn" href="managerCart">
                                <i class="fa fa-shopping-cart"></i> Giỏ hàng
                                <b><span id="amountCart" class="badge badge-light"
                                        style="color: black; font-size: 12px;"></span></b>
                            </a>
                        </form>
                    </div>
                </div>
            </nav>

            <!-- Support Modal -->
            <div class="modal fade" id="supportModal" tabindex="-1" role="dialog" aria-labelledby="supportModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <form action="support" method="post">
                            <div class="modal-header">
                                <h5 class="modal-title" id="supportModalLabel"><i class="fas fa-headset"></i> Hỗ trợ khách hàng</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <p>Nếu bạn có bất kỳ câu hỏi hoặc cần trợ giúp, vui lòng điền vào biểu mẫu dưới đây. Chúng tôi sẽ liên lạc lại với bạn sớm nhất có thể.</p>
                                <div class="form-group">
                                    <label for="supportName">Tên của bạn</label>
                                    <input type="text" class="form-control" id="supportName" name="name" required
                                        <c:if test="${sessionScope.acc != null}">value="${sessionScope.acc.user}"</c:if>
                                    >
                                </div>
                                <div class="form-group">
                                    <label for="supportEmail">Email của bạn</label>
                                    <input type="email" class="form-control" id="supportEmail" name="email" required
                                        <c:if test="${sessionScope.acc != null}">value="${sessionScope.acc.email}"</c:if>
                                    >
                                </div>
                                <div class="form-group">
                                    <label for="supportSubject">Chủ đề</label>
                                    <input type="text" class="form-control" id="supportSubject" name="subject" required>
                                </div>
                                <div class="form-group">
                                    <label for="supportMessage">Nội dung</label>
                                    <textarea class="form-control" id="supportMessage" name="message" rows="4" required></textarea>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
                                <button type="submit" class="btn btn-primary"><i class="fas fa-paper-plane"></i> Gửi tin nhắn</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Search Modal -->
            <div class="modal fade" id="searchModal" tabindex="-1" role="dialog" aria-labelledby="searchModalLabel"
                aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="searchModalLabel">Tìm kiếm sản phẩm</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <form action="search" method="post" id="searchModalForm">
                                <div class="form-group">
                                    <input type="text" class="form-control" name="txt"
                                        placeholder="Nhập từ khóa..." required>
                                </div>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
                            <button type="submit" form="searchModalForm" class="btn btn-primary">Tìm kiếm</button>
                        </div>
                    </div>
                </div>
            </div>

            <!--end of menu-->