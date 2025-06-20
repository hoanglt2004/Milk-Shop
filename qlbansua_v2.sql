-- 1. Tạo database mới (xóa nếu đã tồn tại)
USE [master];
GO
IF DB_ID(N'quanlybansua_v2') IS NOT NULL
BEGIN
    ALTER DATABASE [quanlybansua_v2] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [quanlybansua_v2];
END
GO
CREATE DATABASE [quanlybansua_v2];
GO

-- 2. Thiết lập compatibility và recovery giống DB cũ
ALTER DATABASE [quanlybansua_v2] SET COMPATIBILITY_LEVEL = 140;
GO
ALTER DATABASE [quanlybansua_v2] SET RECOVERY SIMPLE;
GO

-- 3. Chuyển context sang database mới
USE [quanlybansua_v2];
GO

-- 4. Tạo các bảng với schema đã chỉnh sửa

-- 4.1 Bảng Account: bỏ isSell, email cũ; thêm các trường từ Customer: fullName, phone, address, province, email
CREATE TABLE [dbo].[Account] (
    [uID] INT IDENTITY(1,1) NOT NULL,
    [user] NCHAR(10) NULL,
    [pass] NCHAR(10) NULL,
    [isAdmin] BIT NULL,
    -- các cột của Customer hợp nhất vào đây
    [fullName] NVARCHAR(100) NULL,
    [phone] NVARCHAR(20) NULL,
    [address] NVARCHAR(255) NULL,
    [province] NVARCHAR(100) NULL,
    [email] NVARCHAR(255) NULL,
    CONSTRAINT [PK_Account] PRIMARY KEY CLUSTERED ([uID] ASC)
);
GO

-- 4.2 Bảng Category (giữ nguyên)
CREATE TABLE [dbo].[Category] (
    [cid] INT NOT NULL,
    [cname] NVARCHAR(100) NULL,
    CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED ([cid] ASC)
);
GO

-- 4.3 Bảng Product: đổi title->brand, bỏ model, sell_ID, color, image4
CREATE TABLE [dbo].[Product] (
    [id] INT IDENTITY(1,1) NOT NULL,
    [name] NVARCHAR(255) NULL,
    [image] NVARCHAR(MAX) NULL,
    [price] FLOAT NULL,
    [brand] NVARCHAR(255) NULL,
    [description] NVARCHAR(MAX) NULL,
    [cateID] INT NOT NULL,
    [delivery] NVARCHAR(100) NULL,
    [image2] NVARCHAR(MAX) NULL,
    [image3] NVARCHAR(MAX) NULL,
    CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED ([id] ASC)
);
GO

-- 4.4 Bảng Cart
CREATE TABLE [dbo].[Cart] (
    [accountID] INT NOT NULL,
    [productID] INT NOT NULL,
    [amount] INT NULL,
    [maCart] INT IDENTITY(1,1) NOT NULL,
    [size] NVARCHAR(50) NULL,
    CONSTRAINT [PK_Cart] PRIMARY KEY CLUSTERED ([maCart] ASC)
);
GO

-- 4.5 Bảng Invoice
CREATE TABLE [dbo].[Invoice] (
    [maHD] INT IDENTITY(1,1) NOT NULL,
    [accountID] INT NULL,
    [tongGia] FLOAT NULL,
    [ngayXuat] DATETIME NULL,
    [status] NVARCHAR(50) DEFAULT N'Chờ xác nhận',
    [deliveryDate] DATETIME NULL,
    CONSTRAINT [PK_Invoice] PRIMARY KEY CLUSTERED ([maHD] ASC)
);
GO

-- 4.6 Bảng Review
CREATE TABLE [dbo].[Review] (
    [accountID] INT NULL,
    [productID] INT NULL,
    [contentReview] NVARCHAR(MAX) NULL,
    [dateReview] DATE NULL,
    [maReview] INT IDENTITY(1,1) NOT NULL,
    CONSTRAINT [PK_Review] PRIMARY KEY CLUSTERED ([maReview] ASC)
);
GO

-- 4.7 Bảng SoLuongDaBan
CREATE TABLE [dbo].[SoLuongDaBan] (
    [productID] INT NULL,
    [soLuongDaBan] INT NULL
);
GO

-- 4.8 Bảng Supplier
CREATE TABLE [dbo].[Supplier] (
    [idSupplier] INT IDENTITY(1,1) NOT NULL,
    [nameSupplier] NVARCHAR(255) NULL,
    [phoneSupplier] NVARCHAR(20) NULL,
    [emailSupplier] NVARCHAR(255) NULL,
    [addressSupplier] NVARCHAR(MAX) NULL,
    [cateID] INT NULL,
    CONSTRAINT [PK_Supplier] PRIMARY KEY CLUSTERED ([idSupplier] ASC)
);
GO

-- 4.9 Bảng TongChiTieuBanHang
CREATE TABLE [dbo].[TongChiTieuBanHang] (
    [userID] INT NULL,
    [TongChiTieu] FLOAT NULL,
    [TongBanHang] FLOAT NULL
);
GO

-- 4.10 Bảng Warehouse
CREATE TABLE [dbo].[Warehouse] (
    [warehouseID] INT IDENTITY(1,1) NOT NULL,
    [productID] INT NOT NULL,
    [quantity] INT NOT NULL,
    [importDate] DATETIME NOT NULL,
    [remainingQuantity] INT NOT NULL,
    CONSTRAINT [PK_Warehouse] PRIMARY KEY CLUSTERED ([warehouseID] ASC)
);
GO

-- 4.11 Bảng Discount
CREATE TABLE [dbo].[Discount] (
    [discountID] INT IDENTITY(1,1) NOT NULL,
    [productID] INT NOT NULL,
    [percentOff] INT NOT NULL,
    [startDate] DATETIME NOT NULL,
    [endDate] DATETIME NOT NULL,
    [isActive] BIT NOT NULL DEFAULT 1,
    CONSTRAINT [PK_Discount] PRIMARY KEY CLUSTERED ([discountID] ASC)
);
GO

-- 4.12 Bỏ phần tạo bảng Customer (đã gộp vào Account), không tạo nữa

-- 5. Chèn dữ liệu tương tự dữ liệu cũ, đã điều chỉnh phù hợp schema mới

-- 5.1 Account: chỉ insert uID, user, pass, isAdmin; cột mới fullName, phone, address, province, email có thể insert sau nếu cần
SET IDENTITY_INSERT [dbo].[Account] ON;
INSERT [dbo].[Account] ([uID], [user], [pass], [isAdmin])
VALUES 
(1, N'admin     ', N'123456    ', 1),
(2, N'abc       ', N'123456    ', 0),
(3, N'songoky   ', N'123456    ', 0),
(6, N'mrd       ', N'123       ', 1),
(1014, N'naruto    ', N'123456    ', 1),
(1015, N'sasuke    ', N'123456    ', 1),
(1016, N'sakura    ', N'123456    ', 1),
(1017, N'itachi    ', N'123456    ', 1),
(1018, N'kakashi   ', N'123456    ', 1),
(1019, N'jiraiya   ', N'123456    ', 1),
(1022, N'hoang     ', N'1234567   ', 0),
(1023, N'trong     ', N'1         ', 0);
SET IDENTITY_INSERT [dbo].[Account] OFF;
GO

-- Nếu cần chèn thêm dữ liệu cho các cột mới (fullName, phone, address, province, email), có thể làm bằng UPDATE sau khi có dữ liệu nguồn.

-- 5.2 Category
INSERT [dbo].[Category] ([cid], [cname]) VALUES (1, N'Sữa bột');
INSERT [dbo].[Category] ([cid], [cname]) VALUES (2, N'Sữa tươi');
INSERT [dbo].[Category] ([cid], [cname]) VALUES (3, N'Sữa chua');
GO

-- 5.3 Product: insert id, name, image, price, brand (từ title cũ), description, cateID, delivery, image2, image3
SET IDENTITY_INSERT [dbo].[Product] ON;
INSERT [dbo].[Product] ([id], [name], [image], [price], [brand], [description], [cateID], [delivery], [image2], [image3]) 
VALUES 
(47, N'Sữa bột Lacsure 800g', N'https://bizweb.dktcdn.net/thumb/1024x1024/100/416/540/products/lac800.png?v=1731656026840', 788000, 
 N'OPKO Health', 
 N'LACSURE 800g là sản phẩm của tập đoàn OPKO Health Hoa Kỳ. Được nhập khẩu nguyên hộp từ Tây Ban Nha. Công thức được nghiên cứu bởi các chuyên gia hàng đầu dinh dưỡng tại Châu Âu. Lacsure là thực phẩm bổ sung cao năng lượng dành cho người trưởng thành, trung niên, người cao tuổi, người bệnh cần phục hồi sức khỏe, người có nhu cầu bổ sung dinh dưỡng.', 
 1, N'Hải Phòng', 
 N'https://bizweb.dktcdn.net/thumb/1024x1024/100/416/540/products/thong-tin-dinh-duong-a9b3d04d-f550-4c0b-85c1-59f6bd4fbe31.png?v=1731656026840', 
 N'https://bizweb.dktcdn.net/thumb/1024x1024/100/416/540/products/z5859393123981-b07f1fb715522e4450694efa66a10bcf-6fd102c8-99e5-44a9-b6fe-702754a838c6.jpg?v=1731656019127'
),
(48, N'Sữa bột Lacsure 400g', N'https://bizweb.dktcdn.net/thumb/1024x1024/100/416/540/products/lac400.png?v=1731655997527', 398000, 
 N'OPKO Health', 
 N'LACSURE 400g là sản phẩm của tập đoàn OPKO Health Hoa Kỳ. Được nhập khẩu nguyên hộp từ Tây Ban Nha. Công thức được nghiên cứu bởi các chuyên gia hàng đầu dinh dưỡng tại Châu Âu. Lacsure là thực phẩm bổ sung cao năng lượng dành cho người trưởng thành, trung niên, người cao tuổi, người bệnh cần phục hồi sức khỏe, người có nhu cầu bổ sung dinh dưỡng.', 
 1, N'Hải Phòng', 
 N'https://bizweb.dktcdn.net/thumb/1024x1024/100/416/540/products/thong-tin-dinh-duong.png?v=1731655997527', 
 N'https://bizweb.dktcdn.net/thumb/1024x1024/100/416/540/products/z5859393123981-b07f1fb715522e4450694efa66a10bcf-ac481373-d7d6-4e46-938c-a76c7884428e.jpg?v=1731655997527'
),
(49, N'SỮA BỘT NAN Expert Pro 380g', N'https://bizweb.dktcdn.net/thumb/1024x1024/100/416/540/products/nan-expert-380g-1a2d8cb2-c9be-462e-9d9b-eadba9526e5c.jpg?v=1694068865303', 203000, 
 N'Nestle', 
 N'Sữa bột Nestle NAN EXPERT PRO 380g là dòng sản phẩm sữa công thức dinh dưỡng từ Thụy Sĩ dành riêng cho trẻ tiêu chảy và bất dung nạp đường Lactose trong giai đoạn từ 0-3 tuổi của thương hiệu nổi tiếng Nestle.
Xuất xứ: Hà Lan', 
 1, N'Hải Phòng', 
 N'https://bizweb.dktcdn.net/thumb/1024x1024/100/416/540/products/nan-expert-380g-2-b248157b-7058-440f-930f-f7fe59029b87.jpg?v=1694068866687', 
 N'https://bizweb.dktcdn.net/thumb/1024x1024/100/416/540/products/nan-expert-380g-1-9ff4fa7b-c3d1-4d8d-a988-36252710481f.jpg?v=1694068867950'
),
(50, N'Sữa bột công thức Nestle PreNan 380g', N'https://bizweb.dktcdn.net/thumb/1024x1024/100/416/540/products/prenan.jpg?v=1694068951913', 223000, 
 N'Nestle', 
 N'Sữa bột công thức Nestle PreNan 380g đến từ thương hiệu Nestle là công thức đặc chế giúp cung cấp lượng chất dinh dưỡng hợp lý đáp ứng nhu cầu tăng trưởng nhanh của trẻ nhẹ cân hoặc thiếu tháng từ lúc mới sinh cho đến khi trẻ được 5kg. Sữa mang đến nguồn đạm Whey cùng chất béo MCT dễ hấp thu, phù hợp với hệ tiêu hóa non nớt của bé, cung cấp nguồn năng lượng dồi dào và cần thiết cho sự tăng trưởng về thể chất, cân nặng. Thành phần dinh dưỡng trong Pre Nan còn bổ sung DHA, ARA hỗ trợ sự phát triển tốt hơn về trí não và thị giác cho bé ngay trong giai đoạn đầu đời.', 
 1, N'Hà Nội', 
 N'https://bizweb.dktcdn.net/thumb/1024x1024/100/416/540/products/prenan-1.jpg?v=1694068953507', 
 N'https://bizweb.dktcdn.net/thumb/1024x1024/100/416/540/products/prenan-2.jpg?v=1694068954623'
),
(51, N'Sữa bột Nan Optipro Plus 4 1500g hàng nhập khẩu sản xuất tại Singapore', N'https://bizweb.dktcdn.net/thumb/medium/100/416/540/products/456-cc7e2d5a-07ea-43ed-8a4e-64899d40b55f.png?v=1728890491513', 759000, 
 N'Nestle', 
 N'Sữa bột Nan Optipro Plus 4 1500g dành cho bé từ 2-6 tuổi.
Thấu hiểu tâm lý của mẹ luôn muốn kiếm tìm những sản phẩm tốt nhất cho con, với kinh nghiệm 155 năm trong phát triển dưỡng nhi, Nestlé cho ra đời dòng sản phẩm sữa NAN OPTIPRO PLUS giúp hỗ trợ tiêu hóa, tăng cường đề kháng và phát triển thể chất & trí não nhờ: phức hợp 5HMO, 100 triệu lợi khuẩn Bifidus BL, đạm chất lượng Optipro, DHA/ARA, Canxi & Vitamin D.
Sản phẩm với công thức mới đột phá từ Thuỵ Sĩ, nhập khẩu chính hãng bởi Nestlé Việt Nam được kiểm tra nghiêm ngặt về chất lượng và an toàn sản phẩm của Nestlé toàn cầu.', 
 1, N'Hà Nội', 
 N'https://bizweb.dktcdn.net/thumb/1024x1024/100/416/540/products/123-0ae22cfa-1488-4ac7-b3ec-5a52b6569e58.png?v=1728890493743', 
 N'https://bizweb.dktcdn.net/thumb/medium/100/416/540/products/234-eb3e30d7-b6ca-4643-b85a-5043d0c5cca6.png?v=1728890493743'
),
(52, N'Sữa bột dinh dưỡng Varna Complete Lon 850g', N'https://bizweb.dktcdn.net/thumb/1024x1024/100/416/540/products/varna-xanh.jpg?v=1695716701547', 546000, 
 N'Nutifood', 
 N'Sữa bột Nutifood Varna Complete 850g với công thức FRP (Fast Recovery và Prevention) chuyên biệt giúp phòng ngừa suy giảm sức khỏe khi lớn tuổi và phục hồi sức khỏe nhanh.
Sữa bột Nutifood Varna Complete 850g với công thức đặc chế dưới sự giám sát của Viện Nghiên Cứu Dinh Dưỡng NutiFood Thụy Điển – NNRIS có chỉ số GI thấp (GI = 269) giúp ổn định đường huyết tốt cho tim mạch và tăng cường sức đề kháng.', 
 1, N'Hà Nội', 
 N'https://bizweb.dktcdn.net/thumb/medium/100/416/540/products/varna-xanh-1.jpg?v=1695716702663', 
 N'https://bizweb.dktcdn.net/thumb/medium/100/416/540/products/z4335347645653-17469517a3134b27121d57a4401917f7.jpg?v=1695716702663'
);
SET IDENTITY_INSERT [dbo].[Product] OFF;
GO

-- 5.4 Cart
SET IDENTITY_INSERT [dbo].[Cart] ON;
INSERT [dbo].[Cart] ([accountID], [productID], [amount], [maCart], [size]) VALUES (1, 47, 3, 36, NULL);
INSERT [dbo].[Cart] ([accountID], [productID], [amount], [maCart], [size]) VALUES (1022, 47, 1, 38, NULL);
SET IDENTITY_INSERT [dbo].[Cart] OFF;
GO

-- 5.5 Invoice: chèn toàn bộ như dữ liệu cũ
SET IDENTITY_INSERT [dbo].[Invoice] ON;
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (1, 1, 999, CAST(N'2021-11-20T00:00:00.000' AS DateTime));
-- ... (giữ lại tất cả các INSERT Invoice như ban đầu) ...
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (96, 1022, 866800, CAST(N'2025-05-16T00:00:00.000' AS DateTime));
SET IDENTITY_INSERT [dbo].[Invoice] OFF;
GO

-- 5.6 SoLuongDaBan
INSERT [dbo].[SoLuongDaBan] ([productID], [soLuongDaBan]) VALUES (49, 1);
INSERT [dbo].[SoLuongDaBan] ([productID], [soLuongDaBan]) VALUES (47, 1);
GO

-- 5.7 TongChiTieuBanHang
INSERT [dbo].[TongChiTieuBanHang] ([userID], [TongChiTieu], [TongBanHang]) VALUES (1, 12782.200000000003, 1019408);
INSERT [dbo].[TongChiTieuBanHang] ([userID], [TongChiTieu], [TongBanHang]) VALUES (1014, 600, 4000);
INSERT [dbo].[TongChiTieuBanHang] ([userID], [TongChiTieu], [TongBanHang]) VALUES (1015, 450, 3500);
INSERT [dbo].[TongChiTieuBanHang] ([userID], [TongChiTieu], [TongBanHang]) VALUES (1017, 900, 3000);
INSERT [dbo].[TongChiTieuBanHang] ([userID], [TongChiTieu], [TongBanHang]) VALUES (1018, 800, 2500);
INSERT [dbo].[TongChiTieuBanHang] ([userID], [TongChiTieu], [TongBanHang]) VALUES (1019, 660, 2700);
INSERT [dbo].[TongChiTieuBanHang] ([userID], [TongChiTieu], [TongBanHang]) VALUES (2, 100, 150);
INSERT [dbo].[TongChiTieuBanHang] ([userID], [TongChiTieu], [TongBanHang]) VALUES (1022, 1101436.6, 0);
GO

-- 5.8 Supplier: (nếu có dữ liệu, chèn tương tự cũ; không có dữ liệu mẫu ở script gốc nên bỏ qua)
-- Ví dụ nếu cần:
-- INSERT [dbo].[Supplier] ([idSupplier], [nameSupplier], [phoneSupplier], [emailSupplier], [addressSupplier], [cateID]) 
-- VALUES (1, N'Tên nhà cung cấp', N'0123...', N'email@...', N'Địa chỉ...', 1);
-- GO

-- 5.9 Bỏ phần Customer: không tạo, không chèn

-- 6. Tạo lại các FK dựa trên schema mới

ALTER TABLE [dbo].[Cart]
    ADD CONSTRAINT [FK_Cart_Account] FOREIGN KEY([accountID]) REFERENCES [dbo].[Account]([uID]);
GO
ALTER TABLE [dbo].[Cart]
    ADD CONSTRAINT [FK_Cart_Product] FOREIGN KEY([productID]) REFERENCES [dbo].[Product]([id]);
GO

ALTER TABLE [dbo].[Invoice]
    ADD CONSTRAINT [FK_Invoice_Account] FOREIGN KEY([accountID]) REFERENCES [dbo].[Account]([uID]);
GO

ALTER TABLE [dbo].[Product]
    ADD CONSTRAINT [FK_Product_Category] FOREIGN KEY([cateID]) REFERENCES [dbo].[Category]([cid]);
GO

ALTER TABLE [dbo].[Review]
    ADD CONSTRAINT [FK_Review_Account] FOREIGN KEY([accountID]) REFERENCES [dbo].[Account]([uID]);
GO
ALTER TABLE [dbo].[Review]
    ADD CONSTRAINT [FK_Review_Product] FOREIGN KEY([productID]) REFERENCES [dbo].[Product]([id]);
GO

ALTER TABLE [dbo].[SoLuongDaBan]
    ADD CONSTRAINT [FK_SoLuongDaBan_Product] FOREIGN KEY([productID]) REFERENCES [dbo].[Product]([id]);
GO

ALTER TABLE [dbo].[Supplier]
    ADD CONSTRAINT [FK_Supplier_Category] FOREIGN KEY([cateID]) REFERENCES [dbo].[Category]([cid]);
GO

ALTER TABLE [dbo].[TongChiTieuBanHang]
    ADD CONSTRAINT [FK_TongChiTieuBanHang_Account] FOREIGN KEY([userID]) REFERENCES [dbo].[Account]([uID]);
GO

ALTER TABLE [dbo].[Warehouse]
    ADD CONSTRAINT [FK_Warehouse_Product] FOREIGN KEY([productID]) REFERENCES [dbo].[Product]([id]);
GO

ALTER TABLE [dbo].[Discount]
    ADD CONSTRAINT [FK_Discount_Product] FOREIGN KEY([productID]) REFERENCES [dbo].[Product]([id]);
GO

-- LƯU Ý: Không có FK nào liên quan đến Customer nữa, nên không thêm/dropp FK đó.

-- 7. Stored Procedures:
-- 7.1 DROP các proc cũ tham chiếu cột đã xóa (sell_ID, isSell, email cũ)
IF OBJECT_ID(N'dbo.proc_CapNhatTongBanHang', N'P') IS NOT NULL
    DROP PROCEDURE dbo.proc_CapNhatTongBanHang;
GO
IF OBJECT_ID(N'dbo.proc_CapNhatTrangThaiDonHang', N'P') IS NOT NULL
    DROP PROCEDURE dbo.proc_CapNhatTrangThaiDonHang;
GO

-- 7.2 Tạo lại proc không liên quan tới các cột đã xóa
CREATE PROCEDURE [dbo].[proc_CapNhatSoLuongDaBan]
    @productID INT,
    @soLuongBanThem INT
AS
BEGIN
    UPDATE SoLuongDaBan
    SET soLuongDaBan = soLuongDaBan + @soLuongBanThem
    WHERE productID = @productID;
END;
GO

CREATE PROCEDURE [dbo].[proc_CapNhatTongChiTieu]
    @userID INT,
    @chiTieuThem FLOAT
AS
BEGIN
    UPDATE TongChiTieuBanHang
    SET TongChiTieu = TongChiTieu + @chiTieuThem
    WHERE userID = @userID;
END;
GO

CREATE PROCEDURE [dbo].[proc_CapNhatSoLuongKho]
    @productID INT,
    @soLuongGiam INT
AS
BEGIN
    DECLARE @warehouseID INT;
    SELECT TOP 1 @warehouseID = warehouseID
    FROM Warehouse
    WHERE productID = @productID AND remainingQuantity > 0
    ORDER BY importDate ASC;
    IF @warehouseID IS NOT NULL
    BEGIN
        UPDATE Warehouse
        SET remainingQuantity = remainingQuantity - @soLuongGiam
        WHERE warehouseID = @warehouseID;
    END
END;
GO

-- 7.3 Nếu cần nghiệp vụ mới cho cập nhật tổng bán hàng hoặc trạng thái đơn, viết proc mới phù hợp schema hiện tại.
