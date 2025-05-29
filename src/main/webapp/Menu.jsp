<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <% String currentPage=request.getRequestURI(); boolean isHomePage=currentPage.endsWith("Home.jsp") ||
            currentPage.endsWith("home"); %>

            <style>
                :root {
                    --primary-color: #da1919;
                }

                .navbar {
                    background-color: var(--primary-color) !important;
                    padding: 15px 0;
                }

                .navbar-brand {
                    font-size: 24px;
                    font-weight: bold;
                    color: white !important;
                    margin-right: 30px;
                }

                .nav-item {
                    margin: 0 10px;
                }

                .nav-link {
                    /* color: white !important; */
                    font-weight: 500;
                    padding: 8px 15px !important;
                    transition: all 0.3s ease;
                }

                .nav-link:hover {
                    background-color: rgba(255, 255, 255, 0.1);
                    border-radius: 5px;
                }

                .search-input {
                    width: 250px;
                    padding: 8px 15px;
                    border: none;
                    border-radius: 25px;
                    background-color: rgba(255, 255, 255, 0.9);
                    transition: all 0.3s ease;
                    margin: 0 15px;
                }

                .search-input:focus {
                    outline: none;
                    background-color: white;
                    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                    width: 300px;
                }

                .btn-success {
                    background-color: white !important;
                    /* color: var(--primary-color) !important; */
                    border: none !important;
                    padding: 8px 20px !important;
                    border-radius: 20px !important;
                    transition: all 0.3s ease;
                }

                .btn-success:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
                }

                .badge {
                    margin-left: 5px;
                }
            </style>

            <!--begin of menu-->
            <nav class="navbar navbar-expand-md navbar-dark"
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
                            <li class="nav-item">
                                <a class="nav-link" href="home">Home</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="shop">Shop</a>
                            </li>
                            <% if (isHomePage) { %>
                                <li class="nav-item">
                                    <input type="text" name="txt" class="search-input"
                                        placeholder="Tìm kiếm sản phẩm..." form="searchForm">
                                </li>
                                <% } %>

                                    <%-- <c:if test="${sessionScope.acc.isSell == 1}">
                                        <li class="nav-item">
                                            <a class="nav-link" href="manager">Manager Product</a>
                                        </li>
                                        </c:if> --%>
                                        <c:if test="${sessionScope.acc != null}">
                                            <li class="nav-item">
                                                <a class="nav-link" href="#">Hello ${sessionScope.acc.user}</a>
                                            </li>
                                            <li class="nav-item">
                                                <a class="nav-link" href="logout">Logout</a>
                                            </li>
                                        </c:if>
                                        <c:if test="${sessionScope.acc == null}">
                                            <li class="nav-item">
                                                <a class="nav-link" href="login">Login</a>
                                            </li>
                                        </c:if>
                                        <c:if test="${sessionScope.acc == null}">
                                            <li class="nav-item">
                                                <a class="nav-link" href="forgotPassword">Forgot Password</a>
                                            </li>
                                        </c:if>
                                        <c:if test="${sessionScope.acc != null}">
                                            <li class="nav-item">
                                                <a class="nav-link" href="editProfile">Edit Profile</a>
                                            </li>
                                        </c:if>
                                        <c:if test="${sessionScope.acc.isAdmin == 1}">
                                            <li class="nav-item">
                                                <a class="nav-link" href="admin">Admin</a>
                                            </li>
                                        </c:if>
                                        <%-- <c:if test="${sessionScope.acc.isAdmin == 1}">
                                            <li class="nav-item">
                                                <a class="nav-link" href="statistic">Statistic</a>
                                            </li>
                                            </c:if> --%>
                        </ul>

                        <form action="search" method="post" class="form-inline my-2 my-lg-0" id="searchForm">
                            <a class="btn btn-success btn-sm ml-3" href="managerCart">
                                <i class="fa fa-shopping-cart"></i> <span style="font-size: 14px;">Cart</span>
                                <b><span id="amountCart" class="badge badge-light"
                                        style="color: black; font-size: 12px;"></span></b>
                            </a>
                        </form>
                    </div>
                </div>
            </nav>

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
                            <form action="search" method="post" id="searchForm">
                                <div class="form-group">
                                    <input type="text" class="form-control" name="txt"
                                        placeholder="Nhập từ khóa tìm kiếm..." required>
                                </div>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
                            <button type="submit" form="searchForm" class="btn btn-primary">Tìm kiếm</button>
                        </div>
                    </div>
                </div>
            </div>

            <!--end of menu-->