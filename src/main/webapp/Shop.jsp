<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">

<head>
  
   <meta charset="UTF-8">
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta http-equiv="x-ua-compatible" content="ie=edge">
  <title>Shop Page</title>

  <!-- Font Awesome -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
  <!-- Google Fonts Roboto -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap" />
  <!-- MDB -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/7.2.0/mdb.min.css" />
  
  <!-- Custom styles -->
  <link href="css/style.css" rel="stylesheet" type="text/css"/> 
  <link href="css/product-cards.css" rel="stylesheet" type="text/css"/>

<style>
.sort-option {
    transition: all 0.3s ease;
    padding: 5px 10px;
    border-radius: 4px;
    cursor: pointer;
}

.sort-option:hover {
    background-color: #f8f9fa;
    transform: translateY(-2px);
}

.sort-option.active {
    background-color: #007bff;
    color: white;
    box-shadow: 0 2px 5px rgba(0,0,0,0.2);
}

.sort-option input[type="radio"] {
    display: none;
}

.sort-option label {
    cursor: pointer;
    margin: 0;
    padding: 5px 10px;
    display: inline-block;
    transition: all 0.3s ease;
}

.sort-label {
    padding: 5px 10px;
    border-radius: 4px;
    transition: background-color 0.3s ease;
}

.sort-label.active {
    background-color: #007bff;
    color: white;
}

input[type="radio"]:checked + .sort-label {
    background-color: #007bff;
    color: white;
}

/* Toast Notification */
.toast-container {
    position: fixed;
    bottom: 20px;
    right: 20px;
    z-index: 1000;
}

.toast {
    background: white;
    color: #333;
    padding: 15px 25px;
    border-radius: 8px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
    margin-top: 10px;
    display: flex;
    align-items: center;
    animation: slideIn 0.3s ease;
}

.toast.success {
    border-left: 4px solid #28a745;
}

.toast.error {
    border-left: 4px solid #dc3545;
}

@keyframes slideIn {
    from {
        transform: translateX(100%);
        opacity: 0;
    }
    to {
        transform: translateX(0);
        opacity: 1;
    }
}
</style>

</head>

<body class="skin-light" onload="loadAmountCart(); initializeShopPage();">

  <!--Main Navigation-->
  <header>

 	 <jsp:include page="Menu.jsp"></jsp:include>

  </header>
  <!--Main Navigation-->

  <!--Main layout-->
  <main>
    <div class="container">

      <!-- Category Selection Banner -->
      <c:if test="${selectedCid != null}">
        <div class="row mb-4">
          <div class="col-12">
                            <div class="alert alert-info d-flex align-items-center" style="border-radius: 10px; border: none; background: linear-gradient(135deg, #da1919 0%, #c41e3a 100%); color: white;">
              <i class="fas fa-filter fa-lg mr-3"></i>
              <div class="flex-grow-1">
                <h5 class="mb-1">Đang xem sản phẩm theo danh mục</h5>
                <c:forEach items="${listCC}" var="category">
                  <c:if test="${category.cid == selectedCid}">
                    <p class="mb-0"><strong>"${category.cname}"</strong></p>
                  </c:if>
                </c:forEach>
              </div>
              <a href="shop" class="btn btn-light btn-sm ml-3">
                <i class="fas fa-times mr-1"></i>
                Xem tất cả
              </a>
            </div>
          </div>
        </div>
      </c:if>

      <!--Grid row-->
      <div class="row mt-5">

        <!--Grid column-->
        <div class="col-md-4 mb-4">

          <!-- Section: Sidebar -->
          <section>

            <!-- Section: Categories -->
            <section>

              <h5>Categories</h5>

              <div class="text-muted small text-uppercase mb-5">
			<c:forEach items="${listCC}" var="o">
                    <p class="mb-3">
                        <a href="#!" class="card-link-secondary category-link" data-category="${o.cid}">${o.cname}</a>
                    </p>
              </c:forEach>
              </div>

            </section>
            <!-- Section: Categories -->

            <!-- Section: Filters -->
            <section>

              <h5 class="pt-2 mb-4">Filters</h5>

              <section class="mb-4">

                <!-- Lấy từ khóa tìm kiếm từ request parameter -->
                <% 
                String searchKeyword = "";
                if (request.getAttribute("txtS") != null) {
                    searchKeyword = (String) request.getAttribute("txtS");
                } else if (request.getParameter("search") != null) {
                    searchKeyword = request.getParameter("search");
                }
                %>

                <!-- Hiển thị từ khóa trong ô search -->
                <div class="form-group">
                  <input type="text" class="form-control" id="searchInput" name="txt" placeholder="Enter keyword..." value="${searchKeyword}" oninput="searchByName(this);">
                </div>

                <script>
                let searchTimeout;
                let currentSearchText = '';
                
                function searchByName(param) {
                    clearTimeout(searchTimeout);
                    const searchInput = document.getElementById('searchInput');
                    
                    searchTimeout = setTimeout(() => {
                        const txtSearch = searchInput.value;
                        currentSearchText = txtSearch;
                        
                        // Clear category selection when searching
                        document.querySelectorAll('.category-link').forEach(link => link.classList.remove('active'));
                        
                        if (txtSearch.length > 0) {
                            $.ajax({
                                url: "shop",
                                type: "get",
                                data: {
                                    search: txtSearch
                                },
                                beforeSend: function(xhr) {
                                    // Set header for AJAX request detection in servlet
                                    xhr.setRequestHeader("X-Requested-With", "XMLHttpRequest");
                                },
                                success: function (data) {
                                    var row = document.getElementById("content");
                                    row.innerHTML = data;
                                    
                                    // Update URL
                                    const currentUrl = new URL(window.location.href);
                                    currentUrl.searchParams.set('search', txtSearch);
                                    currentUrl.searchParams.delete('cid');
                                    window.history.pushState({}, '', currentUrl);
                                },
                                error: function (xhr) {
                                    console.error('Search failed:', xhr);
                                }
                            });
                        } else {
                            // If search is cleared, show all products
                            loadAllProducts();
                        }
                    }, 300);
                }

                function loadAllProducts() {
                    // Clear category selection
                    document.querySelectorAll('.category-link').forEach(link => link.classList.remove('active'));
                    
                    $.ajax({
                        url: "shop",
                        type: "get",
                        beforeSend: function(xhr) {
                            // Set header for AJAX request detection in servlet
                            xhr.setRequestHeader("X-Requested-With", "XMLHttpRequest");
                        },
                        success: function (data) {
                            var row = document.getElementById("content");
                            row.innerHTML = data;
                            
                            // Update URL to remove all parameters
                            window.history.pushState({}, '', window.location.pathname);
                        }
                    });
                }
                </script>

              </section>

          
              <!-- Section: Price -->
              <section class="mb-4">

                <h6 class="font-weight-bold mb-3">Giá</h6>

                <div class="form-check pl-0 mb-3">
                  <input onchange="applyFilters(false)" type="radio" class="form-check-input" id="priceDefault" name="priceSort" value="" <c:if test="${empty sortType || sortType == 'default' || sortType == 'az' || sortType == 'za' || sortType == 'new'}">checked</c:if>>
                  <label class="form-check-label small text-uppercase card-link-secondary" for="priceDefault">Mặc định</label>
                </div>
                <div class="form-check pl-0 mb-3">
                  <input onchange="applyFilters(false)" type="radio" class="form-check-input" id="priceAsc" name="priceSort" value="price_asc" <c:if test="${sortType == 'price_asc'}">checked</c:if>>
                  <label class="form-check-label small text-uppercase card-link-secondary" for="priceAsc">Giá: Thấp đến Cao</label>
                </div>
                <div class="form-check pl-0 mb-3">
                  <input onchange="applyFilters(false)" type="radio" class="form-check-input" id="priceDesc" name="priceSort" value="price_desc" <c:if test="${sortType == 'price_desc'}">checked</c:if>>
                  <label class="form-check-label small text-uppercase card-link-secondary" for="priceDesc">Giá: Cao đến Thấp</label>
                </div>
                <form onsubmit="event.preventDefault(); applyFilters();">
                  <div class="d-flex align-items-center mt-4 pb-1">
                    <div class="md-form md-outline my-0">
                      <input id="priceMin" type="number" class="form-control mb-0" value="${priceMin}">
                      <label for="priceMin">VNĐ Thấp nhất</label>
                    </div>
                    <p class="px-2 mb-0 text-muted"> - </p>
                    <div class="md-form md-outline my-0">
                      <input id="priceMax" type="number" class="form-control mb-0" value="${priceMax}">
                      <label for="priceMax">VNĐ Cao nhất</label>
                    </div>
                  </div>
                   <button type="submit" class="btn btn-primary btn-sm btn-block mt-2">Lọc theo giá</button>
                </form>

              </section>
              <!-- Section: Price -->

            </section>
            <!-- Section: Filters -->

          </section>
          <!-- Section: Sidebar -->

        </div>
        <!--Grid column-->

        <!--Grid column-->
        <div class="col-md-8 mb-4">

          <!-- Section: Block Content -->
          <section class="mb-3">

            <div class="row d-flex justify-content-around align-items-center">
              <div class="col-12 col-md-8 text-center text-md-left">
                <form id="sortForm" class="d-flex align-items-center">
                  <label class="mr-2 font-weight-bold">Xếp theo:</label>
                  <input type="radio" id="sortDefault" name="sortOption" value="default" <c:if test="${empty sortType || sortType == 'default'}">checked</c:if> class="ml-2 mr-1" onclick="applyFilters()">
                  <label for="sortDefault" class="mr-3 sort-label">Mặc định</label>
                  <input type="radio" id="sortAZ" name="sortOption" value="az" <c:if test="${sortType == 'az'}">checked</c:if> class="mr-1" onclick="applyFilters()">
                  <label for="sortAZ" class="mr-3 sort-label">Tên A-Z</label>
                  <input type="radio" id="sortZA" name="sortOption" value="za" <c:if test="${sortType == 'za'}">checked</c:if> class="mr-1" onclick="applyFilters()">
                  <label for="sortZA" class="mr-3 sort-label">Tên Z-A</label>
                  <input type="radio" id="sortNew" name="sortOption" value="new" <c:if test="${sortType == 'new'}">checked</c:if> class="mr-1" onclick="applyFilters()">
                  <label for="sortNew" class="sort-label">Hàng mới</label>
                </form>
              </div>
            </div>
            <script>
            function sortProducts(type) {
                var searchText = document.getElementById('searchInput').value;
                var cid = document.querySelector('.category-link.active')?.dataset.category || '';
                
                $.ajax({
                    url: "shop",
                    type: "get",
                    data: {
                        search: searchText,
                        cid: cid,
                        sort: type
                    },
                    beforeSend: function(xhr) {
                        // Set header for AJAX request detection in servlet
                        xhr.setRequestHeader("X-Requested-With", "XMLHttpRequest");
                    },
                    success: function(data) {
                        var row = document.getElementById('content');
                        row.innerHTML = data;
                        
                        // Update URL
                        const currentUrl = new URL(window.location.href);
                        if (type !== 'default') {
                            currentUrl.searchParams.set('sort', type);
                        } else {
                            currentUrl.searchParams.delete('sort');
                        }
                        window.history.pushState({}, '', currentUrl);
                    }
                });
            }
            </script>

          </section>
          <!-- Section: Block Content -->

          <!--Section: Block Content-->
          <section>

            <!-- Grid row -->
            <div class="row" id="content">
				<jsp:include page="ProductGrid.jsp" />
            </div>
            <!-- Grid row -->
          </section>
          <!--Section: Block Content-->

    </div>
  </main>
  <!--Main layout-->

  <!-- Toast Notification Container -->
  <div class="toast-container"></div>

  <!-- Footer -->
  

   <jsp:include page="Footer.jsp"></jsp:include>
  
  <!-- jQuery -->
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <!-- Bootstrap core JavaScript -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>
  <!-- MDB -->
  <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/7.2.0/mdb.min.js"></script>
  <!-- Custom scripts -->
  <script type="text/javascript" src="js/script.js"></script>

  <!-- Shop page specific scripts -->
  <script>
    let filterTimeout;

    // Initialize shop page and handle category filtering
    document.addEventListener('DOMContentLoaded', function() {
        const urlParams = new URLSearchParams(window.location.search);
        const categoryId = urlParams.get('cid');
        
        if (categoryId) {
            // If category ID is present in URL, load that category
            loadCategory(categoryId);
            
            // Highlight the active category in sidebar
            const categoryLink = document.querySelector(`.category-link[data-category="${categoryId}"]`);
            if (categoryLink) {
                categoryLink.classList.add('active');
            }
        } else {
            // If no category is selected, initialize page normally
            initializeShopPage();
        }
    });

    function applyFilters(useTimeout = true) {
        if (useTimeout) {
            clearTimeout(filterTimeout);
            filterTimeout = setTimeout(() => {
                performAjaxFilter();
            }, 500);
        } else {
            performAjaxFilter();
        }
    }

    function performAjaxFilter() {
        var cid = document.querySelector('.category-link.active')?.dataset.category || '';
        var searchKeyword = document.getElementById('searchInput').value;
        var priceMin = document.getElementById('priceMin').value;
        var priceMax = document.getElementById('priceMax').value;
        
        // Determine sort type from both radio groups
        var sortType = document.querySelector('input[name="priceSort"]:checked')?.value || '';
        if (!sortType) {
            sortType = document.querySelector('input[name="sortOption"]:checked')?.value || 'default';
        }

        $.ajax({
            url: "shop", // All requests go to ShopControl
            type: "get",
            data: {
                cid: cid,
                search: searchKeyword,
                sort: sortType,
                priceMin: priceMin,
                priceMax: priceMax
            },
            beforeSend: function(xhr) {
                // Set header for AJAX request detection in servlet
                xhr.setRequestHeader("X-Requested-With", "XMLHttpRequest");
            },
            success: function(data) {
                document.getElementById("content").innerHTML = data;
                // Update URL without reloading page
                updateUrl(cid, searchKeyword, sortType, priceMin, priceMax);
            },
            error: function(xhr) {
                console.error("An error occurred during filtering: ", xhr);
            }
        });
    }

    function updateUrl(cid, search, sort, priceMin, priceMax) {
        var newUrl = window.location.pathname + '?';
        var params = [];
        if (cid) params.push('cid=' + cid);
        if (search) params.push('search=' + search);
        if (sort && sort !== 'default') params.push('sort=' + sort);
        if (priceMin) params.push('priceMin=' + priceMin);
        if (priceMax) params.push('priceMax=' + priceMax);

        history.pushState(null, '', newUrl + params.join('&'));
    }

    document.querySelectorAll('.category-link').forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault();
            const categoryId = this.dataset.category;
            
            // Clear search input and other filters
            document.getElementById('searchInput').value = '';
            document.querySelectorAll('input[name="priceSort"]').forEach(input => input.checked = false);
            document.getElementById('priceMin').value = '';
            document.getElementById('priceMax').value = '';
            
            // Highlight active category
            document.querySelectorAll('.category-link').forEach(el => el.classList.remove('active'));
            this.classList.add('active');
            
            // Load products by category
            $.ajax({
                url: "shop",
                type: "get",
                data: {
                    cid: categoryId
                },
                beforeSend: function(xhr) {
                    // Set header for AJAX request detection in servlet
                    xhr.setRequestHeader("X-Requested-With", "XMLHttpRequest");
                },
                success: function (responseData) {
                    document.getElementById("content").innerHTML = responseData;
                    
                    // Update URL
                    const currentUrl = new URL(window.location.href);
                    currentUrl.searchParams.set('cid', categoryId);
                    window.history.pushState({}, '', currentUrl);
                },
                error: function(xhr) {
                    console.error('Error loading category:', xhr);
                }
            });
        });
    });

    function loadAmountCart(){
    	 $.ajax({
             url: "/WebsiteBanSua/loadAllAmountCart",
             type: "get", //send it through get method
             data: {
                 
             },
             success: function (responseData) {
                 document.getElementById("amountCart").innerHTML = responseData;
             }
         });
    }
    
    function initializeShopPage() {
        // Check if there are products displayed
        const contentDiv = document.getElementById("content");
        const hasProducts = contentDiv.querySelectorAll('.col-md-4').length > 0;
        
        // If no products are displayed, load all products
        if (!hasProducts) {
            console.log("No products found on page load, loading all products...");
            loadAllProducts();
        }
    }         

    function loadCategory(categoryId) {
        // Find and click the category link to trigger the event listener
        const categoryLink = document.querySelector(`.category-link[data-category="${categoryId}"]`);
        if (categoryLink) {
            categoryLink.click();
        }
    }

    function addToCart(productId, button) {
        // Prevent multiple clicks
        if (button.disabled) {
            return;
        }

        // Disable button and show loading state
        button.disabled = true;
        button.classList.add('loading');

        $.ajax({
            url: "/WebsiteBanSua/addCart",
            type: "post",
            data: {
                pid: productId,
                quantity: 1
            },
            success: function(response) {
                // Update cart count
                loadAmountCart();
                
                // Show success toast
                showToast('success', 'Đã thêm sản phẩm vào giỏ hàng!');
            },
            error: function(xhr) {
                // Show error toast
                showToast('error', 'Có lỗi xảy ra. Vui lòng thử lại!');
            },
            complete: function() {
                // Always reset button state after request completes
                setTimeout(() => {
                    button.disabled = false;
                    button.classList.remove('loading');
                }, 500);
            }
        });
    }

    function showToast(type, message) {
        // Remove existing toasts
        const existingToasts = document.querySelectorAll('.toast');
        existingToasts.forEach(toast => toast.remove());

        // Create and show new toast
        const toastContainer = document.querySelector('.toast-container');
        if (!toastContainer) return;

        const toast = document.createElement('div');
        toast.className = `toast ${type}`;
        toast.innerHTML = message;
        
        toastContainer.appendChild(toast);
        
        // Auto remove toast after 3 seconds
        setTimeout(() => {
            toast.style.opacity = '0';
            setTimeout(() => {
                toast.remove();
            }, 300);
        }, 3000);
    }

    // Add styles for active category
    const style = document.createElement('style');
    style.textContent = `
        .category-link {
            color: #666;
            text-decoration: none;
            transition: all 0.3s ease;
            cursor: pointer;
        }
        .category-link:hover {
            color: #da1919;
            text-decoration: none;
            transform: translateX(5px);
        }
        .category-link.active {
            color: #da1919;
            font-weight: bold;
        }
    `;
    document.head.appendChild(style);
  </script>

</body>

</html>