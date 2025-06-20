# Chuyển đổi Purple Theme sang Red Theme

## Tổng quan
Dự án đã được chuyển đổi từ purple theme sang red theme để phù hợp với màu chủ đạo của header (#da1919).

## Màu sắc được sử dụng

### Màu đỏ chính
- **Primary Red**: `#da1919` (màu chính từ header)
- **Secondary Red**: `#c41e3a` (màu đỏ đậm hơn)
- **Dark Red**: `#b71c1c` (màu đỏ tối cho badges)
- **Light Red**: `#ff4757` (màu đỏ sáng cho highlights)
- **Red Accent**: `#e55a4e` (màu đỏ cam cho effects)

### Gradient được sử dụng
1. **Main Gradient**: `linear-gradient(135deg, #da1919 0%, #c41e3a 100%)`
2. **Reverse Gradient**: `linear-gradient(135deg, #c41e3a 0%, #da1919 100%)`
3. **Badge Gradients**:
   - New: `linear-gradient(135deg, #da1919 0%, #ff4757 100%)`
   - Hot: `linear-gradient(135deg, #c41e3a 0%, #e55a4e 100%)`
   - Sale: `linear-gradient(135deg, #b71c1c 0%, #da1919 100%)`

## Files được cập nhật

### 1. CSS Files
- **`src/main/webapp/css/product-cards.css`**
  - Cập nhật product card borders và backgrounds
  - Cập nhật price buttons với red gradient
  - Cập nhật load more buttons
  - Cập nhật hover effects với red theme
  - Cập nhật product title hover color

- **`src/main/webapp/css/categories.css`**
  - Cập nhật category card hover với red gradient

### 2. JSP Files
- **`src/main/webapp/Shop.jsp`**
  - Cập nhật category filter banner với red gradient

## Chi tiết thay đổi

### Product Cards
```css
/* Trước */
border: 1px solid rgba(102, 126, 234, 0.1);
background: linear-gradient(145deg, #f8f9fa 0%, #ffffff 100%);
box-shadow: 0 20px 40px rgba(102, 126, 234, 0.2);

/* Sau */
border: 1px solid rgba(218, 25, 25, 0.1);
background: linear-gradient(145deg, #fdf2f2 0%, #ffffff 100%);
box-shadow: 0 20px 40px rgba(218, 25, 25, 0.15);
```

### Price Buttons
```css
/* Trước */
background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
box-shadow: 0 8px 20px rgba(102, 126, 234, 0.4);

/* Sau */
background: linear-gradient(135deg, #da1919 0%, #c41e3a 100%);
box-shadow: 0 8px 20px rgba(218, 25, 25, 0.4);
```

### Category Cards
```css
/* Trước */
background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);

/* Sau */
background: linear-gradient(135deg, #da1919 0%, #c41e3a 100%);
```

## Tính năng đã bảo toàn
- Tất cả hover effects và animations
- Responsive design
- Interactive elements
- Card layouts và structures
- Typography và spacing

## Lợi ích của Red Theme
1. **Thống nhất**: Phù hợp với màu header chính
2. **Ấm áp**: Màu đỏ tạo cảm giác ấm áp, thân thiện
3. **Nổi bật**: Màu đỏ thu hút sự chú ý của khách hàng
4. **Thương hiệu**: Tạo nhận diện thương hiệu mạnh mẽ
5. **Tâm lý**: Màu đỏ kích thích mua sắm và hành động

## Test Cases
- ✅ Product cards hiển thị đúng màu đỏ
- ✅ Hover effects hoạt động với red theme
- ✅ Categories có gradient đỏ khi hover
- ✅ Buttons và badges sử dụng red gradients
- ✅ Responsive design vẫn hoạt động tốt
- ✅ Contrast và readability được đảm bảo

## Tương thích
- ✅ Modern browsers (Chrome, Firefox, Safari, Edge)
- ✅ Mobile devices
- ✅ Tablet devices
- ✅ Desktop resolutions

Ngày cập nhật: $(date) 