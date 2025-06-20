# Eclipse Fix Guide - Khắc phục lỗi sau khi sửa code

## 🚨 Vấn đề chính
Sau khi sửa code, Eclipse gặp lỗi compilation do:
1. **Import conflicts** - Thay đổi package imports
2. **Missing servlet API** - Thiếu servlet libraries
3. **Build path issues** - Classpath không đúng

## 🔧 Các bước khắc phục trong Eclipse

### **Bước 1: Clean và Rebuild Project**
```
1. Trong Eclipse: Project → Clean...
2. Chọn project BTL_TMDT
3. Check "Clean projects selected below"
4. Click "Clean"
5. Đợi rebuild tự động hoặc Project → Build Project
```

### **Bước 2: Kiểm tra Build Path**
```
1. Right-click project → Properties
2. Chọn "Java Build Path"
3. Tab "Libraries":
   - Kiểm tra có "Modulepath" hoặc "Classpath"
   - Phải có "Server Runtime" (Tomcat)
   - Phải có "JRE System Library"
   - Phải có "Web App Libraries"
4. Nếu thiếu Server Runtime:
   - Click "Add Library..." → Server Runtime → Next
   - Chọn Apache Tomcat → Finish
```

### **Bước 3: Kiểm tra Project Facets**
```
1. Project Properties → Project Facets
2. Đảm bảo enabled:
   - ✅ Java (version phù hợp)
   - ✅ Dynamic Web Module (3.1 hoặc cao hơn)
   - ✅ JavaScript (nếu cần)
```

### **Bước 4: Kiểm tra Deployment Assembly**
```
1. Project Properties → Deployment Assembly
2. Phải có:
   - src/main/java → WEB-INF/classes
   - src/main/resources → WEB-INF/classes  
   - Maven Dependencies → WEB-INF/lib
   - Web Content → /
```

### **Bước 5: Refresh và Rebuild**
```
1. Right-click project → Refresh (F5)
2. Project → Clean... → Clean project
3. Kiểm tra "Problems" tab không còn error
```

## 🔍 Kiểm tra cụ thể

### **File đã sửa cần kiểm tra:**
- ✅ `src/main/java/entity/ProductStock.java` - **File mới**
- ✅ `src/main/java/dao/WarehouseDAO.java` - Fixed imports
- ✅ `src/main/java/dao/DiscountDAO.java` - Fixed imports  
- ✅ `src/main/java/context/DBContext.java` - Removed bad import
- ✅ `src/main/java/controller/QuanLyKhoControl.java` - Fixed imports
- ✅ `src/main/java/controller/QuanLyKhuyenMaiControl.java` - Fixed imports

### **Import changes made:**
```java
// OLD: extends DBContext (from dao package - có SQLException)
// NEW: extends DBContext (from context package - có Exception)
import context.DBContext;  // Thay vì dao.DBContext

// Tất cả catch blocks đã đổi từ SQLException → Exception
```

## 🎯 Nếu vẫn lỗi

### **Plan A: Re-import project**
```
1. File → Import → Existing Projects into Workspace
2. Chọn project folder
3. Import project
```

### **Plan B: Maven clean (nếu là Maven project)**
```
1. Right-click project → Run As → Maven clean
2. Right-click project → Run As → Maven install
```

### **Plan C: Kiểm tra Server**
```
1. Servers tab → Double-click Tomcat server
2. Server Locations → "Use Tomcat installation"
3. Save và restart server
```

## 🚀 Test sau khi fix

### **Kiểm tra compilation:**
1. Không có error đỏ trong Problems tab
2. Project builds thành công
3. Có thể deploy lên server

### **Test chức năng:**
1. Start Tomcat server
2. Truy cập: `http://localhost:8080/BTL_TMDT/quanLyKho`
3. Truy cập: `http://localhost:8080/BTL_TMDT/quanLyKhuyenMai`
4. Test CRUD operations

## 📝 Files đã fix

✅ **ProductStock.java** - Entity mới cho stock reporting  
✅ **WarehouseDAO.java** - Fixed imports và exception handling  
✅ **DiscountDAO.java** - Fixed imports và exception handling  
✅ **QuanLyKho.jsp** - Fixed HTML syntax, enhanced UI  
✅ **QuanLyKhuyenMai.jsp** - Fixed HTML syntax, simplified UX  
✅ **Controllers** - Enhanced error handling & validation  

## 🔧 Tóm tắt thay đổi chính:

1. **Package imports**: `dao.DBContext` → `context.DBContext`
2. **Exception handling**: `SQLException` → `Exception` 
3. **Entity structure**: Tạo ProductStock.java riêng
4. **HTML syntax**: Fixed `></c:forEach>` → `</c:forEach>`
5. **UI enhancement**: Added alerts, badges, better forms
6. **Error handling**: Session-based messaging

---
**Sau khi làm theo guide này, project sẽ chạy bình thường trong Eclipse!** 🎉 