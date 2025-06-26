# Hướng dẫn sửa lỗi hiển thị giá khuyến mãi trong Shop.jsp

## Vấn đề
Các sản phẩm được áp dụng khuyến mãi không hiển thị giá mới và gạch đi giá cũ trên trang Shop.jsp.

## Nguyên nhân
1. **Không có dữ liệu khuyến mãi trong database**: Bảng Discount chưa có dữ liệu hoặc dữ liệu không đúng thời gian hiện tại.
2. **Logic hiển thị đã đúng**: Code trong ProductGrid.jsp đã có logic hiển thị giá khuyến mãi đúng cách.

## Giải pháp

### Bước 1: Thêm dữ liệu khuyến mãi mẫu
Chạy script SQL `update_discount_dates.sql` để thêm dữ liệu khuyến mãi mẫu:

```sql
-- Chạy file update_discount_dates.sql trong SQL Server Management Studio
-- hoặc sử dụng command line:
sqlcmd -S your_server -d quanlybansua_v2 -i update_discount_dates.sql
```

### Bước 2: Kiểm tra dữ liệu
Sau khi chạy script, kiểm tra xem có khuyến mãi nào đang hoạt động không:

```sql
SELECT 
    d.discountID,
    d.productID,
    p.name AS productName,
    d.percentOff,
    d.startDate,
    d.endDate,
    d.isActive,
    p.price AS originalPrice,
    (p.price * (100 - d.percentOff) / 100) AS salePrice
FROM [dbo].[Discount] d
JOIN [dbo].[Product] p ON d.productID = p.id
WHERE d.isActive = 1 
AND GETDATE() BETWEEN d.startDate AND d.endDate
ORDER BY d.productID;
```

### Bước 3: Test hiển thị
Truy cập trang test để kiểm tra: `http://localhost:8080/WebsiteBanSua/test-discount.jsp`

### Bước 4: Kiểm tra Shop.jsp
Truy cập trang Shop: `http://localhost:8080/WebsiteBanSua/shop`

## Cấu trúc hiển thị giá khuyến mãi

### Khi có khuyến mãi:
- **Giá khuyến mãi**: Hiển thị màu đỏ, font lớn, ở trên
- **Giá gốc**: Gạch ngang, màu xám, ở dưới
- **Badge khuyến mãi**: Hiển thị phần trăm giảm giá trên ảnh sản phẩm

### Khi không có khuyến mãi:
- **Giá bình thường**: Hiển thị màu đỏ, font lớn

## Code logic hiển thị (đã có sẵn)

```jsp
<div class="product-price">
    <c:choose>
        <c:when test="${o.discountPercent > 0}">
            <!-- Hiển thị giá khuyến mãi -->
            <p class="sale-price">
                <fmt:formatNumber value="${o.salePrice}" pattern="#,##0" var="formattedSalePrice" />
                ${fn:replace(formattedSalePrice, ',', '.')} VNĐ
            </p>
            <!-- Hiển thị giá gốc đã gạch ngang -->
            <p class="original-price">
                <fmt:formatNumber value="${o.price}" pattern="#,##0" var="formattedOriginalPrice" />
                ${fn:replace(formattedOriginalPrice, ',', '.')} VNĐ
            </p>
        </c:when>
        <c:otherwise>
            <!-- Hiển thị giá bình thường khi không có khuyến mãi -->
            <p class="sale-price">
                <fmt:formatNumber value="${o.price}" pattern="#,##0" var="formattedPrice" />
                ${fn:replace(formattedPrice, ',', '.')} VNĐ
            </p>
        </c:otherwise>
    </c:choose>
</div>
```

## CSS cho hiển thị giá

```css
.original-price {
    text-decoration: line-through;
    color: #6c757d;
    font-size: 0.9rem;
    margin: 0;
    order: 2;
    margin-top: 4px;
}

.sale-price {
    color: #c41e3a;
    font-weight: 700;
    font-size: 1.25rem;
    margin: 0;
    order: 1;
}
```

## Debug

Nếu vẫn không hiển thị đúng, kiểm tra:

1. **Console logs**: Xem debug information trong console của server
2. **Database**: Đảm bảo có dữ liệu khuyến mãi đang hoạt động
3. **Date range**: Đảm bảo ngày hiện tại nằm trong khoảng startDate và endDate
4. **isActive**: Đảm bảo isActive = 1

## Lưu ý
- Logic hiển thị đã được tối ưu và không ảnh hưởng đến chức năng khác
- Chỉ cần thêm dữ liệu khuyến mãi vào database là sẽ hoạt động
- Có thể tùy chỉnh phần trăm khuyến mãi trong script SQL 