USE [master]
GO

CREATE DATABASE [quanlybansua]
GO

ALTER DATABASE [quanlybansua] SET COMPATIBILITY_LEVEL = 140
GO

ALTER DATABASE [quanlybansua] SET RECOVERY SIMPLE
GO

USE [quanlybansua]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
    [uID] [int] IDENTITY(1,1) NOT NULL,
    [user] [nchar](10) NULL,
    [pass] [nchar](10) NULL,
    [isSell] [bit] NULL,
    [isAdmin] [bit] NULL,
    [email] [nvarchar](255) NULL,
    CONSTRAINT [PK_Account] PRIMARY KEY CLUSTERED ([uID] ASC)
)
GO

CREATE TABLE [dbo].[Category](
    [cid] [int] NOT NULL,
    [cname] [nvarchar](100) NULL,
    CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED ([cid] ASC)
)
GO

CREATE TABLE [dbo].[Product](
    [id] [int] IDENTITY(1,1) NOT NULL,
    [name] [nvarchar](255) NULL,
    [image] [nvarchar](MAX) NULL,
    [price] [float] NULL,
    [title] [nvarchar](255) NULL,
    [description] [nvarchar](MAX) NULL,
    [cateID] [int] NOT NULL,
    [sell_ID] [int] NOT NULL,
    [model] [nvarchar](100) NULL,
    [color] [nvarchar](50) NULL,
    [delivery] [nvarchar](100) NULL,
    [image2] [nvarchar](MAX) NULL,
    [image3] [nvarchar](MAX) NULL,
    [image4] [nvarchar](MAX) NULL,
    CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED ([id] ASC)
)
GO

CREATE TABLE [dbo].[Cart](
    [accountID] [int] NOT NULL,
    [productID] [int] NOT NULL,
    [amount] [int] NULL,
    [maCart] [int] IDENTITY(1,1) NOT NULL,
    [size] [nvarchar](50) NULL,
    CONSTRAINT [PK_Cart] PRIMARY KEY CLUSTERED ([maCart] ASC)
)
GO

CREATE TABLE [dbo].[Invoice](
    [invoiceID] [int] IDENTITY(1,1) NOT NULL,
    [customerID] [int] NOT NULL,
    [date] [datetime] NOT NULL,
    [totalMoney] [float] NOT NULL,
    [status] [nvarchar](50) DEFAULT N'Chờ xác nhận',
    [deliveryDate] [datetime] NULL,
    CONSTRAINT [PK_Invoice] PRIMARY KEY CLUSTERED ([invoiceID] ASC)
)
GO

CREATE TABLE [dbo].[Review](
    [accountID] [int] NULL,
    [productID] [int] NULL,
    [contentReview] [nvarchar](MAX) NULL,
    [dateReview] [date] NULL,
    [maReview] [int] IDENTITY(1,1) NOT NULL,
    CONSTRAINT [PK_Review] PRIMARY KEY CLUSTERED ([maReview] ASC)
)
GO

CREATE TABLE [dbo].[SoLuongDaBan](
    [productID] [int] NULL,
    [soLuongDaBan] [int] NULL
)
GO

CREATE TABLE [dbo].[Supplier](
    [idSupplier] [int] IDENTITY(1,1) NOT NULL,
    [nameSupplier] [nvarchar](255) NULL,
    [phoneSupplier] [nvarchar](20) NULL,
    [emailSupplier] [nvarchar](255) NULL,
    [addressSupplier] [nvarchar](MAX) NULL,
    [cateID] [int] NULL,
    CONSTRAINT [PK_Supplier] PRIMARY KEY CLUSTERED ([idSupplier] ASC)
)
GO

CREATE TABLE [dbo].[TongChiTieuBanHang](
    [userID] [int] NULL,
    [TongChiTieu] [float] NULL,
    [TongBanHang] [float] NULL
)
GO

CREATE TABLE [dbo].[Warehouse](
    [warehouseID] [int] IDENTITY(1,1) NOT NULL,
    [productID] [int] NOT NULL,
    [quantity] [int] NOT NULL,
    [importDate] [datetime] NOT NULL,
    [remainingQuantity] [int] NOT NULL,
    CONSTRAINT [PK_Warehouse] PRIMARY KEY CLUSTERED ([warehouseID] ASC)
)
GO

CREATE TABLE [dbo].[Discount](
    [discountID] [int] IDENTITY(1,1) NOT NULL,
    [productID] [int] NOT NULL,
    [percentOff] [int] NOT NULL,
    [startDate] [datetime] NOT NULL,
    [endDate] [datetime] NOT NULL,
    [isActive] [bit] NOT NULL DEFAULT 1,
    CONSTRAINT [PK_Discount] PRIMARY KEY CLUSTERED ([discountID] ASC)
)
GO

CREATE TABLE [dbo].[Customer](
    [customerID] [int] IDENTITY(1,1) NOT NULL,
    [accountID] [int] NOT NULL,
    [fullName] [nvarchar](100) NULL,
    [phone] [nvarchar](20) NULL,
    [address] [nvarchar](255) NULL,
    [province] [nvarchar](100) NULL,
    CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED ([customerID] ASC)
)
GO

SET IDENTITY_INSERT [dbo].[Account] ON
INSERT [dbo].[Account] ([uID], [user], [pass], [isSell], [isAdmin], [email]) VALUES (1, N'admin     ', N'123456    ', 1, 1, N'admin123@example.com')
INSERT [dbo].[Account] ([uID], [user], [pass], [isSell], [isAdmin], [email]) VALUES (2, N'abc       ', N'123456    ', 0, 0, N'huynhminhduc01082001@gmail.com')
INSERT [dbo].[Account] ([uID], [user], [pass], [isSell], [isAdmin], [email]) VALUES (3, N'songoky   ', N'123456    ', 1, 0, N'huynhminhduc01082001@gmail.com')
INSERT [dbo].[Account] ([uID], [user], [pass], [isSell], [isAdmin], [email]) VALUES (6, N'mrd       ', N'123       ', 1, 1, N'huynhminhduc01082001@gmail.com')
INSERT [dbo].[Account] ([uID], [user], [pass], [isSell], [isAdmin], [email]) VALUES (1014, N'naruto    ', N'123456    ', 1, 1, N'naruto@gmail.com')
INSERT [dbo].[Account] ([uID], [user], [pass], [isSell], [isAdmin], [email]) VALUES (1015, N'sasuke    ', N'123456    ', 1, 1, N'sasuke@gmail.com')
INSERT [dbo].[Account] ([uID], [user], [pass], [isSell], [isAdmin], [email]) VALUES (1016, N'sakura    ', N'123456    ', 1, 1, N'sasuke@gmail.com')
INSERT [dbo].[Account] ([uID], [user], [pass], [isSell], [isAdmin], [email]) VALUES (1017, N'itachi    ', N'123456    ', 1, 1, N'sasuke@gmail.com')
INSERT [dbo].[Account] ([uID], [user], [pass], [isSell], [isAdmin], [email]) VALUES (1018, N'kakashi   ', N'123456    ', 1, 1, N'kakashi@gmail.com')
INSERT [dbo].[Account] ([uID], [user], [pass], [isSell], [isAdmin], [email]) VALUES (1019, N'jiraiya   ', N'123456    ', 1, 1, N'kakashi@gmail.com')
INSERT [dbo].[Account] ([uID], [user], [pass], [isSell], [isAdmin], [email]) VALUES (1022, N'hoang     ', N'1234567   ', 0, 0, N'thaihoangqh123@gmail.com')
INSERT [dbo].[Account] ([uID], [user], [pass], [isSell], [isAdmin], [email]) VALUES (1023, N'trong     ', N'1         ', 0, 0, N'trong@gmail.com')
SET IDENTITY_INSERT [dbo].[Account] OFF
GO

SET IDENTITY_INSERT [dbo].[Product] ON
INSERT [dbo].[Product] ([id], [name], [image], [price], [title], [description], [cateID], [sell_ID], [model], [color], [delivery], [image2], [image3], [image4]) VALUES (47, N'Sữa bột Lacsure 800g', N'https://bizweb.dktcdn.net/thumb/1024x1024/100/416/540/products/lac800.png?v=1731656026840', 788000, N'OPKO Health', N'LACSURE 800g là sản phẩm của tập đoàn OPKO Health Hoa Kỳ. Được nhập khẩu nguyên hộp từ Tây Ban Nha. Công thức được nghiên cứu bởi các chuyên gia hàng đầu dinh dưỡng tại Châu Âu. Lacsure là thực phẩm bổ sung cao năng lượng dành cho người trưởng thành, trung niên, người cao tuổi, người bệnh cần phục hồi sức khỏe, người có nhu cầu bổ sung dinh dưỡng.', 1, 1, NULL, NULL, N'Hải Phòng', N'https://bizweb.dktcdn.net/thumb/1024x1024/100/416/540/products/thong-tin-dinh-duong-a9b3d04d-f550-4c0b-85c1-59f6bd4fbe31.png?v=1731656026840', N'https://bizweb.dktcdn.net/thumb/1024x1024/100/416/540/products/z5859393123981-b07f1fb715522e4450694efa66a10bcf-6fd102c8-99e5-44a9-b6fe-702754a838c6.jpg?v=1731656019127', N'')
INSERT [dbo].[Product] ([id], [name], [image], [price], [title], [description], [cateID], [sell_ID], [model], [color], [delivery], [image2], [image3], [image4]) VALUES (48, N'Sữa bột Lacsure 400g', N'https://bizweb.dktcdn.net/thumb/1024x1024/100/416/540/products/lac400.png?v=1731655997527', 398000, N'OPKO Health', N'LACSURE 400g là sản phẩm của tập đoàn OPKO Health Hoa Kỳ. Được nhập khẩu nguyên hộp từ Tây Ban Nha. Công thức được nghiên cứu bởi các chuyên gia hàng đầu dinh dưỡng tại Châu Âu. Lacsure là thực phẩm bổ sung cao năng lượng dành cho người trưởng thành, trung niên, người cao tuổi, người bệnh cần phục hồi sức khỏe, người có nhu cầu bổ sung dinh dưỡng.', 1, 1, NULL, NULL, N'Hải Phòng', N'https://bizweb.dktcdn.net/thumb/1024x1024/100/416/540/products/thong-tin-dinh-duong.png?v=1731655997527', N'https://bizweb.dktcdn.net/thumb/1024x1024/100/416/540/products/z5859393123981-b07f1fb715522e4450694efa66a10bcf-ac481373-d7d6-4e46-938c-a76c7884428e.jpg?v=1731655997527', N'')
INSERT [dbo].[Product] ([id], [name], [image], [price], [title], [description], [cateID], [sell_ID], [model], [color], [delivery], [image2], [image3], [image4]) VALUES (49, N'SỮA BỘT NAN Expert Pro 380g', N'https://bizweb.dktcdn.net/thumb/1024x1024/100/416/540/products/nan-expert-380g-1a2d8cb2-c9be-462e-9d9b-eadba9526e5c.jpg?v=1694068865303', 203000, N'Nestle', N'Sữa bột Nestle NAN EXPERT PRO 380g là dòng sản phẩm sữa công thức dinh dưỡng từ Thụy Sĩ dành riêng cho trẻ tiêu chảy và bất dung nạp đường Lactose trong giai đoạn từ 0-3 tuổi của thương hiệu nổi tiếng Nestle.
Xuất xứ: Hà Lan', 1, 1, NULL, NULL, N'Hải Phòng', N'https://bizweb.dktcdn.net/thumb/1024x1024/100/416/540/products/nan-expert-380g-2-b248157b-7058-440f-930f-f7fe59029b87.jpg?v=1694068866687', N'https://bizweb.dktcdn.net/thumb/1024x1024/100/416/540/products/nan-expert-380g-1-9ff4fa7b-c3d1-4d8d-a988-36252710481f.jpg?v=1694068867950', N'https://bizweb.dktcdn.net/thumb/1024x1024/100/416/540/products/sua-bot-nan-expert-pro-lactose-free-400g-0-36-thang-5.jpg?v=1694068877843')
INSERT [dbo].[Product] ([id], [name], [image], [price], [title], [description], [cateID], [sell_ID], [model], [color], [delivery], [image2], [image3], [image4]) VALUES (50, N'Sữa bột công thức Nestle PreNan 380g', N'https://bizweb.dktcdn.net/thumb/1024x1024/100/416/540/products/prenan.jpg?v=1694068951913', 223000, N'Nestle', N'Sữa bột công thức Nestle PreNan 380g đến từ thương hiệu Nestle là công thức đặc chế giúp cung cấp lượng chất dinh dưỡng hợp lý đáp ứng nhu cầu tăng trưởng nhanh của trẻ nhẹ cân hoặc thiếu tháng từ lúc mới sinh cho đến khi trẻ được 5kg. Sữa mang đến nguồn đạm Whey cùng chất béo MCT dễ hấp thu, phù hợp với hệ tiêu hóa non nớt của bé, cung cấp nguồn năng lượng dồi dào và cần thiết cho sự tăng trưởng về thể chất, cân nặng. Thành phần dinh dưỡng trong Pre Nan còn bổ sung DHA, ARA hỗ trợ sự phát triển tốt hơn về trí não và thị giác cho bé ngay trong giai đoạn đầu đời.', 1, 1, NULL, NULL, N'Hà Nội', N'https://bizweb.dktcdn.net/thumb/1024x1024/100/416/540/products/prenan-1.jpg?v=1694068953507', N'https://bizweb.dktcdn.net/thumb/1024x1024/100/416/540/products/prenan-2.jpg?v=1694068954623', N'https://bizweb.dktcdn.net/thumb/1024x1024/100/416/540/products/z3860444660459-068b982dc17f9b5eb83333c9b2a54fa6-ee0829f3-bf2e-46e6-bb56-80bd818bb79b.jpg?v=1694068954623')
INSERT [dbo].[Product] ([id], [name], [image], [price], [title], [description], [cateID], [sell_ID], [model], [color], [delivery], [image2], [image3], [image4]) VALUES (51, N'Sữa bột Nan Optipro Plus 4 1500g hàng nhập khẩu sản xuất tại Singapore', N'https://bizweb.dktcdn.net/thumb/medium/100/416/540/products/456-cc7e2d5a-07ea-43ed-8a4e-64899d40b55f.png?v=1728890491513', 759000, N'Nestle', N'Sữa bột Nan Optipro Plus 4 1500g dành cho bé từ 2-6 tuổi.
Thấu hiểu tâm lý của mẹ luôn muốn kiếm tìm những sản phẩm tốt nhất cho con, với kinh nghiệm 155 năm trong phát triển dưỡng nhi, Nestlé cho ra đời dòng sản phẩm sữa NAN OPTIPRO PLUS giúp hỗ trợ tiêu hóa, tăng cường đề kháng và phát triển thể chất & trí não nhờ: phức hợp 5HMO, 100 triệu lợi khuẩn Bifidus BL, đạm chất lượng Optipro, DHA/ARA, Canxi & Vitamin D.
Sản phẩm với công thức mới đột phá từ Thuỵ Sĩ, nhập khẩu chính hãng bởi Nestlé Việt Nam được kiểm tra nghiêm ngặt về chất lượng và an toàn sản phẩm của Nestlé toàn cầu.', 1, 1, NULL, NULL, N'Hà Nội', N'https://bizweb.dktcdn.net/thumb/1024x1024/100/416/540/products/123-0ae22cfa-1488-4ac7-b3ec-5a52b6569e58.png?v=1728890493743', N'https://bizweb.dktcdn.net/thumb/medium/100/416/540/products/234-eb3e30d7-b6ca-4643-b85a-5043d0c5cca6.png?v=1728890493743', N'https://bizweb.dktcdn.net/thumb/1024x1024/100/416/540/products/z3860444660459-068b982dc17f9b5eb83333c9b2a54fa6-b353a486-8f0a-4f7b-8988-ce1e837ad078.jpg?v=1728890493743')
INSERT [dbo].[Product] ([id], [name], [image], [price], [title], [description], [cateID], [sell_ID], [model], [color], [delivery], [image2], [image3], [image4]) VALUES (52, N'Sữa bột dinh dưỡng Varna Complete Lon 850g', N'https://bizweb.dktcdn.net/thumb/1024x1024/100/416/540/products/varna-xanh.jpg?v=1695716701547', 546000, N'Nutifood', N'Sữa bột Nutifood Varna Complete 850g với công thức FRP (Fast Recovery và Prevention) chuyên biệt giúp phòng ngừa suy giảm sức khỏe khi lớn tuổi và phục hồi sức khỏe nhanh.
Sữa bột Nutifood Varna Complete 850g với công thức đặc chế dưới sự giám sát của Viện Nghiên Cứu Dinh Dưỡng NutiFood Thụy Điển – NNRIS có chỉ số GI thấp (GI = 269) giúp ổn định đường huyết tốt cho tim mạch và tăng cường sức đề kháng.', 1, 1, NULL, NULL, N'Hà Nội', N'https://bizweb.dktcdn.net/thumb/medium/100/416/540/products/varna-xanh-1.jpg?v=1695716702663', N'https://bizweb.dktcdn.net/thumb/medium/100/416/540/products/z4335347645653-17469517a3134b27121d57a4401917f7.jpg?v=1695716702663', N'')
SET IDENTITY_INSERT [dbo].[Product] OFF
GO

SET IDENTITY_INSERT [dbo].[Cart] ON
INSERT [dbo].[Cart] ([accountID], [productID], [amount], [maCart], [size]) VALUES (1, 47, 3, 36, NULL)
INSERT [dbo].[Cart] ([accountID], [productID], [amount], [maCart], [size]) VALUES (1022, 47, 1, 38, NULL)
SET IDENTITY_INSERT [dbo].[Cart] OFF
GO

INSERT [dbo].[Category] ([cid], [cname]) VALUES (1, N'Sữa bột')
INSERT [dbo].[Category] ([cid], [cname]) VALUES (2, N'Sữa tươi')
INSERT [dbo].[Category] ([cid], [cname]) VALUES (3, N'Sữa chua')
GO

SET IDENTITY_INSERT [dbo].[Invoice] ON
INSERT [dbo].[Invoice] ([invoiceID], [customerID], [date], [totalMoney], [status], [deliveryDate]) 
VALUES (1, 1, CAST(N'2021-11-20T00:00:00.000' AS DateTime), 999, N'Chờ xác nhận', NULL)
INSERT [dbo].[Invoice] ([invoiceID], [customerID], [date], [totalMoney], [status], [deliveryDate]) 
VALUES (2, 1, CAST(N'2021-11-20T00:00:00.000' AS DateTime), 800, N'Chờ xác nhận', NULL)
INSERT [dbo].[Invoice] ([invoiceID], [customerID], [date], [totalMoney], [status], [deliveryDate]) 
VALUES (3, 1, CAST(N'2021-11-20T00:00:00.000' AS DateTime), 400, N'Chờ xác nhận', NULL)
INSERT [dbo].[Invoice] ([invoiceID], [customerID], [date], [totalMoney], [status], [deliveryDate]) 
VALUES (4, 1, CAST(N'2021-11-20T00:00:00.000' AS DateTime), 511.2, N'Chờ xác nhận', NULL)
INSERT [dbo].[Invoice] ([invoiceID], [customerID], [date], [totalMoney], [status], [deliveryDate]) 
VALUES (5, 1, CAST(N'2021-11-20T00:00:00.000' AS DateTime), 241.20000000000002, N'Chờ xác nhận', NULL)
INSERT [dbo].[Invoice] ([invoiceID], [customerID], [date], [totalMoney], [status], [deliveryDate]) 
VALUES (6, 1, CAST(N'2021-11-20T00:00:00.000' AS DateTime), 392.40000000000003, N'Chờ xác nhận', NULL)
INSERT [dbo].[Invoice] ([invoiceID], [customerID], [date], [totalMoney], [status], [deliveryDate]) 
VALUES (7, 1, CAST(N'2021-11-20T00:00:00.000' AS DateTime), 482.40000000000003, N'Chờ xác nhận', NULL)
INSERT [dbo].[Invoice] ([invoiceID], [customerID], [date], [totalMoney], [status], [deliveryDate]) 
VALUES (8, 2, CAST(N'2021-11-18T00:00:00.000' AS DateTime), 300, N'Chờ xác nhận', NULL)
INSERT [dbo].[Invoice] ([invoiceID], [customerID], [date], [totalMoney], [status], [deliveryDate]) 
VALUES (9, 2, CAST(N'2021-11-17T00:00:00.000' AS DateTime), 400, N'Chờ xác nhận', NULL)
INSERT [dbo].[Invoice] ([invoiceID], [customerID], [date], [totalMoney], [status], [deliveryDate]) 
VALUES (10, 1, CAST(N'2021-11-20T00:00:00.000' AS DateTime), 180, N'Chờ xác nhận', NULL)
INSERT [dbo].[Invoice] ([invoiceID], [customerID], [date], [totalMoney], [status], [deliveryDate]) 
VALUES (11, 1, CAST(N'2021-11-20T00:00:00.000' AS DateTime), 1079.1000000000001, N'Chờ xác nhận', NULL)
INSERT [dbo].[Invoice] ([invoiceID], [customerID], [date], [totalMoney], [status], [deliveryDate]) 
VALUES (12, 1, CAST(N'2021-11-20T00:00:00.000' AS DateTime), 122.4, N'Chờ xác nhận', NULL)
INSERT [dbo].[Invoice] ([invoiceID], [customerID], [date], [totalMoney], [status], [deliveryDate]) 
VALUES (13, 1, CAST(N'2021-11-20T00:00:00.000' AS DateTime), 1394.1000000000001, N'Chờ xác nhận', NULL)
INSERT [dbo].[Invoice] ([invoiceID], [customerID], [date], [totalMoney], [status], [deliveryDate]) 
VALUES (14, 2, CAST(N'2021-10-01T00:00:00.000' AS DateTime), 256, N'Chờ xác nhận', NULL)
INSERT [dbo].[Invoice] ([invoiceID], [customerID], [date], [totalMoney], [status], [deliveryDate]) 
VALUES (15, 3, CAST(N'2021-10-03T00:00:00.000' AS DateTime), 450, N'Chờ xác nhận', NULL)
INSERT [dbo].[Invoice] ([invoiceID], [customerID], [date], [totalMoney], [status], [deliveryDate]) 
VALUES (16, 2, CAST(N'2021-09-05T00:00:00.000' AS DateTime), 200, N'Chờ xác nhận', NULL)
INSERT [dbo].[Invoice] ([invoiceID], [customerID], [date], [totalMoney], [status], [deliveryDate]) 
VALUES (17, 2, CAST(N'2021-08-06T00:00:00.000' AS DateTime), 100, N'Chờ xác nhận', NULL)
INSERT [dbo].[Invoice] ([invoiceID], [customerID], [date], [totalMoney], [status], [deliveryDate]) 
VALUES (18, 3, CAST(N'2021-07-07T00:00:00.000' AS DateTime), 156, N'Chờ xác nhận', NULL)
INSERT [dbo].[Invoice] ([invoiceID], [customerID], [date], [totalMoney], [status], [deliveryDate]) 
VALUES (19, 3, CAST(N'2021-06-06T00:00:00.000' AS DateTime), 256, N'Chờ xác nhận', NULL)
INSERT [dbo].[Invoice] ([invoiceID], [customerID], [date], [totalMoney], [status], [deliveryDate]) 
VALUES (20, 3, CAST(N'2021-05-05T00:00:00.000' AS DateTime), 158, N'Chờ xác nhận', NULL)
INSERT [dbo].[Invoice] ([invoiceID], [customerID], [date], [totalMoney], [status], [deliveryDate]) 
VALUES (21, 2, CAST(N'2021-04-04T00:00:00.000' AS DateTime), 800, N'Chờ xác nhận', NULL)
INSERT [dbo].[Invoice] ([invoiceID], [customerID], [date], [totalMoney], [status], [deliveryDate]) 
VALUES (22, 3, CAST(N'2021-03-03T00:00:00.000' AS DateTime), 750, N'Chờ xác nhận', NULL)
INSERT [dbo].[Invoice] ([invoiceID], [customerID], [date], [totalMoney], [status], [deliveryDate]) 
VALUES (23, 2, CAST(N'2021-02-02T00:00:00.000' AS DateTime), 657, N'Chờ xác nhận', NULL)
INSERT [dbo].[Invoice] ([invoiceID], [customerID], [date], [totalMoney], [status], [deliveryDate]) 
VALUES (24, 1, CAST(N'2021-01-01T00:00:00.000' AS DateTime), 800, N'Chờ xác nhận', NULL)
INSERT [dbo].[Invoice] ([invoiceID], [customerID], [date], [totalMoney], [status], [deliveryDate]) 
VALUES (25, 1, CAST(N'2021-11-25T00:00:00.000' AS DateTime), 1491.6, N'Chờ xác nhận', NULL)
INSERT [dbo].[Invoice] ([invoiceID], [customerID], [date], [totalMoney], [status], [deliveryDate]) 
VALUES (26, 1, CAST(N'2021-11-26T00:00:00.000' AS DateTime), 396, N'Chờ xác nhận', NULL)
INSERT [dbo].[Invoice] ([invoiceID], [customerID], [date], [totalMoney], [status], [deliveryDate]) 
VALUES (27, 1, CAST(N'2021-11-29T00:00:00.000' AS DateTime), 761.2, N'Chờ xác nhận', NULL)
INSERT [dbo].[Invoice] ([invoiceID], [customerID], [date], [totalMoney], [status], [deliveryDate]) 
VALUES (28, 1, CAST(N'2021-11-29T00:00:00.000' AS DateTime), 1687.4, N'Chờ xác nhận', NULL)
INSERT [dbo].[Invoice] ([invoiceID], [customerID], [date], [totalMoney], [status], [deliveryDate]) 
VALUES (29, 1, CAST(N'2021-11-29T00:00:00.000' AS DateTime), 1760, N'Chờ xác nhận', NULL)
INSERT [dbo].[Invoice] ([invoiceID], [customerID], [date], [totalMoney], [status], [deliveryDate]) 
VALUES (30, 1, CAST(N'2021-12-01T00:00:00.000' AS DateTime), 2175.8, N'Chờ xác nhận', NULL)
INSERT [dbo].[Invoice] ([invoiceID], [customerID], [date], [totalMoney], [status], [deliveryDate]) 
VALUES (31, 1, CAST(N'2021-12-01T00:00:00.000' AS DateTime), 396, N'Chờ xác nhận', NULL)
INSERT [dbo].[Invoice] ([invoiceID], [customerID], [date], [totalMoney], [status], [deliveryDate]) 
VALUES (32, 1, CAST(N'2021-12-02T00:00:00.000' AS DateTime), 739.2, N'Chờ xác nhận', NULL)
INSERT [dbo].[Invoice] ([invoiceID], [customerID], [date], [totalMoney], [status], [deliveryDate]) 
VALUES (33, 1, CAST(N'2021-12-03T00:00:00.000' AS DateTime), 567.6, N'Chờ xác nhận', NULL)
INSERT [dbo].[Invoice] ([invoiceID], [customerID], [date], [totalMoney], [status], [deliveryDate]) 
VALUES (34, 1, CAST(N'2021-12-14T00:00:00.000' AS DateTime), 803, N'Chờ xác nhận', NULL)
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (1, 1, 999, CAST(N'2021-11-20T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (2, 1, 800, CAST(N'2021-11-20T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (3, 1, 400, CAST(N'2021-11-20T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (4, 1, 511.2, CAST(N'2021-11-20T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (5, 1, 241.20000000000002, CAST(N'2021-11-20T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (6, 1, 392.40000000000003, CAST(N'2021-11-20T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (7, 1, 482.40000000000003, CAST(N'2021-11-20T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (8, 2, 300, CAST(N'2021-11-18T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (9, 2, 400, CAST(N'2021-11-17T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (10, 1, 180, CAST(N'2021-11-20T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (11, 1, 1079.1000000000001, CAST(N'2021-11-20T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (12, 1, 122.4, CAST(N'2021-11-20T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (13, 1, 1394.1000000000001, CAST(N'2021-11-20T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (14, 2, 256, CAST(N'2021-10-01T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (15, 3, 450, CAST(N'2021-10-03T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (16, 2, 200, CAST(N'2021-09-05T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (17, 2, 100, CAST(N'2021-08-06T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (18, 3, 156, CAST(N'2021-07-07T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (19, 3, 256, CAST(N'2021-06-06T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (20, 3, 158, CAST(N'2021-05-05T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (21, 2, 800, CAST(N'2021-04-04T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (22, 3, 750, CAST(N'2021-03-03T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (23, 2, 657, CAST(N'2021-02-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (24, 1, 800, CAST(N'2021-01-01T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (25, 1, 1491.6, CAST(N'2021-11-25T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (26, 1, 396, CAST(N'2021-11-26T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (27, 1, 761.2, CAST(N'2021-11-29T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (28, 1, 1687.4, CAST(N'2021-11-29T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (29, 1, 1760, CAST(N'2021-11-29T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (30, 1, 2175.8, CAST(N'2021-12-01T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (31, 1, 396, CAST(N'2021-12-01T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (32, 1, 739.2, CAST(N'2021-12-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (33, 1, 567.6, CAST(N'2021-12-03T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (34, 1, 803, CAST(N'2021-12-14T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (80, 1022, 396, CAST(N'2025-05-12T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (93, 1022, 209, CAST(N'2025-05-12T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (94, 1022, 171.6, CAST(N'2025-05-12T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (95, 1022, 223300, CAST(N'2025-05-16T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (96, 1022, 866800, CAST(N'2025-05-16T00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Invoice] OFF
GO

INSERT [dbo].[SoLuongDaBan] ([productID], [soLuongDaBan]) VALUES (49, 1)
INSERT [dbo].[SoLuongDaBan] ([productID], [soLuongDaBan]) VALUES (47, 1)
GO

INSERT [dbo].[TongChiTieuBanHang] ([userID], [TongChiTieu], [TongBanHang]) VALUES (1, 12782.200000000003, 1019408)
INSERT [dbo].[TongChiTieuBanHang] ([userID], [TongChiTieu], [TongBanHang]) VALUES (1014, 600, 4000)
INSERT [dbo].[TongChiTieuBanHang] ([userID], [TongChiTieu], [TongBanHang]) VALUES (1015, 450, 3500)
INSERT [dbo].[TongChiTieuBanHang] ([userID], [TongChiTieu], [TongBanHang]) VALUES (1017, 900, 3000)
INSERT [dbo].[TongChiTieuBanHang] ([userID], [TongChiTieu], [TongBanHang]) VALUES (1018, 800, 2500)
INSERT [dbo].[TongChiTieuBanHang] ([userID], [TongChiTieu], [TongBanHang]) VALUES (1019, 660, 2700)
INSERT [dbo].[TongChiTieuBanHang] ([userID], [TongChiTieu], [TongBanHang]) VALUES (2, 100, 150)
INSERT [dbo].[TongChiTieuBanHang] ([userID], [TongChiTieu], [TongBanHang]) VALUES (1022, 1101436.6, 0)
GO

ALTER TABLE [dbo].[Cart] ADD CONSTRAINT [FK_Cart_Account] FOREIGN KEY([accountID])
REFERENCES [dbo].[Account] ([uID])
GO
ALTER TABLE [dbo].[Cart] ADD CONSTRAINT [FK_Cart_Product] FOREIGN KEY([productID])
REFERENCES [dbo].[Product] ([id])
GO

ALTER TABLE [dbo].[Invoice] ADD CONSTRAINT [FK_Invoice_Account] FOREIGN KEY([accountID])
REFERENCES [dbo].[Account] ([uID])
GO

ALTER TABLE [dbo].[Product] ADD CONSTRAINT [FK_Product_Account] FOREIGN KEY([sell_ID])
REFERENCES [dbo].[Account] ([uID])
GO
ALTER TABLE [dbo].[Product] ADD CONSTRAINT [FK_Product_Category] FOREIGN KEY([cateID])
REFERENCES [dbo].[Category] ([cid])
GO

ALTER TABLE [dbo].[Review] ADD CONSTRAINT [FK_Review_Account] FOREIGN KEY([accountID])
REFERENCES [dbo].[Account] ([uID])
GO
ALTER TABLE [dbo].[Review] ADD CONSTRAINT [FK_Review_Product] FOREIGN KEY([productID])
REFERENCES [dbo].[Product] ([id])
GO

ALTER TABLE [dbo].[SoLuongDaBan] ADD CONSTRAINT [FK_SoLuongDaBan_Product] FOREIGN KEY([productID])
REFERENCES [dbo].[Product] ([id])
GO

ALTER TABLE [dbo].[Supplier] ADD CONSTRAINT [FK_Supplier_Category] FOREIGN KEY([cateID])
REFERENCES [dbo].[Category] ([cid])
GO

ALTER TABLE [dbo].[TongChiTieuBanHang] ADD CONSTRAINT [FK_TongChiTieuBanHang_Account] FOREIGN KEY([userID])
REFERENCES [dbo].[Account] ([uID])
GO

ALTER TABLE [dbo].[Warehouse] ADD CONSTRAINT [FK_Warehouse_Product] FOREIGN KEY([productID])
REFERENCES [dbo].[Product] ([id])
GO

ALTER TABLE [dbo].[Discount] ADD CONSTRAINT [FK_Discount_Product] FOREIGN KEY([productID])
REFERENCES [dbo].[Product] ([id])
GO

ALTER TABLE [dbo].[Customer] ADD CONSTRAINT [FK_Customer_Account] FOREIGN KEY([accountID])
REFERENCES [dbo].[Account] ([uID])
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[proc_CapNhatSoLuongDaBan] @productID int, @soLuongBanThem int
AS
BEGIN
    UPDATE SoLuongDaBan SET [soLuongDaBan] = [soLuongDaBan] + @soLuongBanThem WHERE productID = @productID
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[proc_CapNhatTongBanHang] @sell_ID int, @banHangThem float
AS
BEGIN
    UPDATE TongChiTieuBanHang SET TongBanHang = TongBanHang + @banHangThem WHERE [userID] = @sell_ID
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[proc_CapNhatTongChiTieu] @userID int, @chiTieuThem float
AS
BEGIN
    UPDATE TongChiTieuBanHang SET TongChiTieu = TongChiTieu + @chiTieuThem WHERE [userID] = @userID
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[proc_CapNhatSoLuongKho] @productID int, @soLuongGiam int
AS
BEGIN
    DECLARE @warehouseID int
    
    SELECT TOP 1 @warehouseID = warehouseID 
    FROM Warehouse 
    WHERE productID = @productID AND remainingQuantity > 0 
    ORDER BY importDate ASC
    
    IF @warehouseID IS NOT NULL
    BEGIN
        UPDATE Warehouse 
        SET remainingQuantity = remainingQuantity - @soLuongGiam 
        WHERE warehouseID = @warehouseID
    END
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[proc_CapNhatTrangThaiDonHang] @maHD int, @status nvarchar(50)
AS
BEGIN
    UPDATE Invoice 
    SET [status] = @status,
        [deliveryDate] = CASE WHEN @status = N'Đã giao hàng' THEN GETDATE() ELSE [deliveryDate] END
    WHERE [maHD] = @maHD
    
    IF @status = N'Đã giao hàng'
    BEGIN
        DECLARE @sellID int
        DECLARE @tongGia float
        
        SELECT @tongGia = tongGia FROM Invoice WHERE maHD = @maHD
        
        UPDATE TongChiTieuBanHang
        SET TongBanHang = TongBanHang + @tongGia
        WHERE userID IN (SELECT DISTINCT sell_ID FROM Product p 
                         JOIN Cart c ON p.id = c.productID
                         WHERE c.accountID = (SELECT accountID FROM Invoice WHERE maHD = @maHD))
    END
END
GO