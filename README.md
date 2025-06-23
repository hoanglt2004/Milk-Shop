# 🥛 MILK-SHOP - Hệ Thống Bán Sữa Online

## 📋 Giới Thiệu
**Milk-Shop** là một ứng dụng web thương mại điện tử chuyên về bán các sản phẩm sữa online. Dự án được phát triển bằng Java sử dụng kiến trúc JSP/Servlet với cơ sở dữ liệu Microsoft SQL Server.

## ✨ Tính Năng Chính

### 👤 Dành cho Khách Hàng
- **Quản lý tài khoản**: Đăng ký, đăng nhập, quên mật khẩu, cập nhật thông tin cá nhân
- **Duyệt sản phẩm**: Xem danh sách sản phẩm theo danh mục (Sữa bột, Sữa tươi, Sữa chua)
- **Tìm kiếm & Lọc**: Tìm kiếm theo tên, lọc theo giá, màu sắc, thương hiệu
- **Giỏ hàng**: Thêm/xóa/cập nhật sản phẩm (hỗ trợ cả session cho khách vãng lai)
- **Đặt hàng**: Đặt hàng và thanh toán trực tuyến
- **Lịch sử**: Xem lịch sử đơn hàng và hóa đơn
- **Đánh giá**: Đánh giá và nhận xét sản phẩm

### 🔧 Dành cho Admin
- **Dashboard**: Thống kê doanh thu theo thứ/tháng, tổng quan hệ thống
- **Quản lý sản phẩm**: Thêm, sửa, xóa sản phẩm với hình ảnh
- **Quản lý danh mục**: CRUD danh mục sản phẩm
- **Quản lý tài khoản**: Quản lý người dùng và phân quyền
- **Quản lý nhà cung cấp**: Thông tin và liên hệ nhà cung cấp
- **Quản lý kho**: Theo dõi tồn kho và nhập hàng
- **Quản lý khuyến mãi**: Tạo và quản lý chương trình giảm giá
- **Báo cáo**: Top sản phẩm bán chạy, top khách hàng, xuất Excel

## 🛠️ Công Nghệ Sử Dụng

### Backend
- **Java 11**
- **JSP/Servlet** - MVC Pattern
- **JSTL** - JSP Standard Tag Library
- **Maven** - Build tool
- **Microsoft SQL Server** - Database

### Frontend
- **HTML5/CSS3/JavaScript**
- **Bootstrap 4** - Responsive framework
- **Font Awesome** - Icons
- **jQuery** - DOM manipulation
- **AJAX** - Asynchronous requests

### Libraries & Dependencies
- **GSON** - JSON processing
- **Apache POI** - Excel export
- **JavaMail** - Email functionality
- **MSSQL JDBC** - Database connectivity
- **Commons Libraries** - Utilities

## 📁 Cấu Trúc Dự Án

```
Milk-Shop/
├── src/main/java/
│   ├── context/          # Kết nối database
│   ├── entity/           # Model classes
│   ├── dao/              # Data Access Objects
│   ├── control/          # Servlet Controllers
│   ├── controller/       # Additional Controllers
│   ├── filter/           # Filters
│   └── utils/            # Utilities
├── src/main/webapp/
│   ├── css/              # Stylesheets
│   ├── js/               # JavaScript files
│   ├── images/           # Static images
│   ├── WEB-INF/          # Web configuration
│   └── *.jsp             # JSP pages
├── src/main/resources/   # Configuration files
├── lib/                  # External libraries
├── pom.xml              # Maven configuration
└── qlbansua_v2.sql      # Database schema
```

## 🗄️ Cơ Sở Dữ Liệu

### Các Bảng Chính
- **Account**: Thông tin tài khoản người dùng
- **Product**: Danh sách sản phẩm
- **Category**: Danh mục sản phẩm
- **Cart**: Giỏ hàng
- **Invoice**: Hóa đơn mua hàng
- **Review**: Đánh giá sản phẩm
- **Supplier**: Nhà cung cấp
- **Warehouse**: Quản lý kho
- **Discount**: Chương trình khuyến mãi

## 🚀 Hướng Dẫn Cài Đặt

### Yêu Cầu Hệ Thống
- **Java 11** hoặc cao hơn
- **Apache Tomcat 9.0+**
- **Microsoft SQL Server**
- **Maven 3.6+**

### Các Bước Cài Đặt

1. **Clone repository**
   ```bash
   git clone <repository-url>
   cd Milk-Shop
   ```

2. **Cài đặt database**
   ```sql
   -- Chạy file qlbansua_v2.sql trong SQL Server Management Studio
   ```

3. **Cấu hình database**
   ```java
   // Cập nhật thông tin trong src/main/java/context/DBContext.java
   private final String serverName = "localhost";
   private final String dbName = "quanlybansua_v2";
   private final String userID = "sa";
   private final String password = "your_password";
   ```

4. **Build project**
   ```bash
   mvn clean compile
   mvn package
   ```

5. **Deploy lên Tomcat**
   - Copy file `.war` vào thư mục `webapps` của Tomcat
   - Khởi động Tomcat server

6. **Truy cập ứng dụng**
   ```
   http://localhost:8080/quanlybansua/home
   ```

## 👥 Tài Khoản Mặc Định

### Admin
- **Username**: `admin`
- **Password**: `123456`

### User Demo
- **Username**: `abc`
- **Password**: `123456`

## 📧 Cấu Hình Email
Cập nhật thông tin email trong `src/main/resources/email.properties`:
```properties
email.from=your_email@gmail.com
email.password=your_app_password
email.host=smtp.gmail.com
email.port=587
```

## 🌟 Tính Năng Nổi Bật
- **Responsive Design**: Tương thích mọi thiết bị
- **Real-time Search**: Tìm kiếm và lọc sản phẩm theo thời gian thực
- **Session Management**: Hỗ trợ giỏ hàng cho khách vãng lai
- **Email Integration**: Gửi email tự động cho các chức năng
- **Excel Export**: Xuất báo cáo dữ liệu ra Excel
- **Multi-image Support**: Hỗ trợ nhiều hình ảnh cho sản phẩm
- **Security**: Phân quyền người dùng rõ ràng

## 📊 Screenshots
<!-- Thêm screenshots của ứng dụng ở đây -->

## 🤝 Đóng Góp
Chúng tôi hoan nghênh mọi đóng góp để cải thiện dự án. Vui lòng:
1. Fork repository
2. Tạo feature branch
3. Commit changes
4. Push to branch
5. Tạo Pull Request

## 📝 License
Dự án này được phát hành dưới [MIT License](LICENSE).

## 📞 Liên Hệ
- **Email**: support@milkshop.com
- **Website**: https://milkshop.com
- **Phone**: +84 123 456 789

---
⭐ **Nếu dự án hữu ích, hãy để lại một star để ủng hộ chúng tôi!** ⭐


6. Công nghệ sử dụng
Backend: Java 11, JSP/Servlet, JSTL
Frontend: HTML, CSS, JavaScript, Bootstrap 4, Font Awesome
Database: Microsoft SQL Server
Libraries: GSON, Apache POI (Excel), JavaMail, Commons libraries
Build tool: Maven