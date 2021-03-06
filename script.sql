USE [master]
GO
/****** Object:  Database [YELLOW_MOON_SHOP]    Script Date: 10/18/2020 4:27:11 PM ******/
CREATE DATABASE [YELLOW_MOON_SHOP]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'YELLOW_MOON_SHOP', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\YELLOW_MOON_SHOP.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'YELLOW_MOON_SHOP_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\YELLOW_MOON_SHOP_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [YELLOW_MOON_SHOP] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [YELLOW_MOON_SHOP].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [YELLOW_MOON_SHOP] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [YELLOW_MOON_SHOP] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [YELLOW_MOON_SHOP] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [YELLOW_MOON_SHOP] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [YELLOW_MOON_SHOP] SET ARITHABORT OFF 
GO
ALTER DATABASE [YELLOW_MOON_SHOP] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [YELLOW_MOON_SHOP] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [YELLOW_MOON_SHOP] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [YELLOW_MOON_SHOP] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [YELLOW_MOON_SHOP] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [YELLOW_MOON_SHOP] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [YELLOW_MOON_SHOP] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [YELLOW_MOON_SHOP] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [YELLOW_MOON_SHOP] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [YELLOW_MOON_SHOP] SET  ENABLE_BROKER 
GO
ALTER DATABASE [YELLOW_MOON_SHOP] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [YELLOW_MOON_SHOP] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [YELLOW_MOON_SHOP] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [YELLOW_MOON_SHOP] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [YELLOW_MOON_SHOP] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [YELLOW_MOON_SHOP] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [YELLOW_MOON_SHOP] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [YELLOW_MOON_SHOP] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [YELLOW_MOON_SHOP] SET  MULTI_USER 
GO
ALTER DATABASE [YELLOW_MOON_SHOP] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [YELLOW_MOON_SHOP] SET DB_CHAINING OFF 
GO
ALTER DATABASE [YELLOW_MOON_SHOP] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [YELLOW_MOON_SHOP] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [YELLOW_MOON_SHOP] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [YELLOW_MOON_SHOP] SET QUERY_STORE = OFF
GO
USE [YELLOW_MOON_SHOP]
GO
/****** Object:  Table [dbo].[account]    Script Date: 10/18/2020 4:27:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[account](
	[username] [varchar](30) NOT NULL,
	[password] [varchar](30) NOT NULL,
	[fullname] [varchar](50) NOT NULL,
	[phone] [varchar](10) NOT NULL,
	[address] [varchar](255) NOT NULL,
	[role] [int] NOT NULL,
	[status] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cart]    Script Date: 10/18/2020 4:27:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cart](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[cartId]  AS ('UID'+right('00000000'+CONVERT([varchar](8),[id]),(8))) PERSISTED,
	[username] [varchar](30) NULL,
	[fullname] [varchar](50) NOT NULL,
	[phone] [varchar](10) NOT NULL,
	[address] [varchar](255) NOT NULL,
	[date] [date] NOT NULL,
	[total] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cartDetail]    Script Date: 10/18/2020 4:27:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cartDetail](
	[detailId] [int] IDENTITY(1,1) NOT NULL,
	[cartId] [int] NOT NULL,
	[productId] [int] NOT NULL,
	[quantity] [int] NOT NULL,
	[price] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[detailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[category]    Script Date: 10/18/2020 4:27:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[category](
	[categoryId] [int] NOT NULL,
	[categoryName] [varchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[categoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[log]    Script Date: 10/18/2020 4:27:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[log](
	[logId] [int] IDENTITY(1,1) NOT NULL,
	[date] [datetime] NOT NULL,
	[username] [varchar](30) NOT NULL,
	[productId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[logId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[product]    Script Date: 10/18/2020 4:27:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[product](
	[productId] [int] IDENTITY(1,1) NOT NULL,
	[productName] [varchar](255) NOT NULL,
	[image] [varchar](255) NOT NULL,
	[price] [int] NOT NULL,
	[quantity] [int] NOT NULL,
	[createDate] [datetime] NOT NULL,
	[expirationDate] [datetime] NOT NULL,
	[status] [int] NOT NULL,
	[category] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[productId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[role]    Script Date: 10/18/2020 4:27:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[role](
	[roleId] [int] NOT NULL,
	[roleName] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[roleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[status]    Script Date: 10/18/2020 4:27:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[status](
	[statusId] [int] NOT NULL,
	[statusName] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[statusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[account] ([username], [password], [fullname], [phone], [address], [role], [status]) VALUES (N'admin', N'admin', N'Admin', N'0123456789', N'Ho Chi Minh', 1, 2)
INSERT [dbo].[account] ([username], [password], [fullname], [phone], [address], [role], [status]) VALUES (N'hongngoc', N'hongngoc', N'Ngoc Nguyen', N'0123456789', N'Ho Chi Minh', 2, 2)
GO
SET IDENTITY_INSERT [dbo].[cart] ON 

INSERT [dbo].[cart] ([id], [username], [fullname], [phone], [address], [date], [total]) VALUES (1, NULL, N'Test', N'0123456789', N'Address', CAST(N'2020-10-18' AS Date), 0)
INSERT [dbo].[cart] ([id], [username], [fullname], [phone], [address], [date], [total]) VALUES (2, NULL, N'Test', N'0123456789', N'Test Address', CAST(N'2020-10-18' AS Date), 700000)
INSERT [dbo].[cart] ([id], [username], [fullname], [phone], [address], [date], [total]) VALUES (3, N'hongngoc', N'Ngoc Nguyen', N'0123456789', N'Ho Chi Minh', CAST(N'2020-10-18' AS Date), 3575000)
INSERT [dbo].[cart] ([id], [username], [fullname], [phone], [address], [date], [total]) VALUES (4, NULL, N'Test', N'0123456789', N'Test Address', CAST(N'2020-10-18' AS Date), 700000)
INSERT [dbo].[cart] ([id], [username], [fullname], [phone], [address], [date], [total]) VALUES (5, NULL, N'Test', N'0123456789', N'Test Address', CAST(N'2020-10-18' AS Date), 700000)
INSERT [dbo].[cart] ([id], [username], [fullname], [phone], [address], [date], [total]) VALUES (6, NULL, N'Test', N'0123456789', N'Test Address', CAST(N'2020-10-18' AS Date), 475000)
INSERT [dbo].[cart] ([id], [username], [fullname], [phone], [address], [date], [total]) VALUES (7, NULL, N'Test', N'0123456789', N'Test Address', CAST(N'2020-10-18' AS Date), 1050000)
INSERT [dbo].[cart] ([id], [username], [fullname], [phone], [address], [date], [total]) VALUES (8, NULL, N'Test', N'0123456789', N'Test Address', CAST(N'2020-10-18' AS Date), 1050000)
SET IDENTITY_INSERT [dbo].[cart] OFF
GO
SET IDENTITY_INSERT [dbo].[cartDetail] ON 

INSERT [dbo].[cartDetail] ([detailId], [cartId], [productId], [quantity], [price]) VALUES (1, 2, 18, 2, 700000)
INSERT [dbo].[cartDetail] ([detailId], [cartId], [productId], [quantity], [price]) VALUES (2, 3, 18, 2, 700000)
INSERT [dbo].[cartDetail] ([detailId], [cartId], [productId], [quantity], [price]) VALUES (3, 3, 22, 23, 2875000)
INSERT [dbo].[cartDetail] ([detailId], [cartId], [productId], [quantity], [price]) VALUES (4, 4, 20, 2, 700000)
INSERT [dbo].[cartDetail] ([detailId], [cartId], [productId], [quantity], [price]) VALUES (5, 4, 26, 1, 120000)
INSERT [dbo].[cartDetail] ([detailId], [cartId], [productId], [quantity], [price]) VALUES (6, 5, 18, 2, 700000)
INSERT [dbo].[cartDetail] ([detailId], [cartId], [productId], [quantity], [price]) VALUES (7, 6, 18, 1, 350000)
INSERT [dbo].[cartDetail] ([detailId], [cartId], [productId], [quantity], [price]) VALUES (8, 6, 22, 1, 125000)
INSERT [dbo].[cartDetail] ([detailId], [cartId], [productId], [quantity], [price]) VALUES (9, 7, 20, 3, 1050000)
INSERT [dbo].[cartDetail] ([detailId], [cartId], [productId], [quantity], [price]) VALUES (10, 8, 20, 3, 1050000)
SET IDENTITY_INSERT [dbo].[cartDetail] OFF
GO
INSERT [dbo].[category] ([categoryId], [categoryName]) VALUES (1, N'Macaron')
INSERT [dbo].[category] ([categoryId], [categoryName]) VALUES (2, N'Macha')
INSERT [dbo].[category] ([categoryId], [categoryName]) VALUES (3, N'Lotus')
INSERT [dbo].[category] ([categoryId], [categoryName]) VALUES (4, N'Chocolate')
INSERT [dbo].[category] ([categoryId], [categoryName]) VALUES (5, N'Green Bean')
GO
SET IDENTITY_INSERT [dbo].[log] ON 

INSERT [dbo].[log] ([logId], [date], [username], [productId]) VALUES (1, CAST(N'2020-10-18T00:00:00.000' AS DateTime), N'admin', 26)
INSERT [dbo].[log] ([logId], [date], [username], [productId]) VALUES (2, CAST(N'2020-10-18T00:00:00.000' AS DateTime), N'admin', 22)
INSERT [dbo].[log] ([logId], [date], [username], [productId]) VALUES (3, CAST(N'2020-10-18T00:00:00.000' AS DateTime), N'admin', 26)
SET IDENTITY_INSERT [dbo].[log] OFF
GO
SET IDENTITY_INSERT [dbo].[product] ON 

INSERT [dbo].[product] ([productId], [productName], [image], [price], [quantity], [createDate], [expirationDate], [status], [category]) VALUES (2, N'Pink Macaron', N'pink-macaron.jpg', 100000, 100, CAST(N'2020-09-10T00:00:00.000' AS DateTime), CAST(N'2020-10-20T00:00:00.000' AS DateTime), 1, 1)
INSERT [dbo].[product] ([productId], [productName], [image], [price], [quantity], [createDate], [expirationDate], [status], [category]) VALUES (4, N'Matcha Red Bean', N'Matcha-Red-Bean.jpg', 85000, 200, CAST(N'2020-09-20T00:00:00.000' AS DateTime), CAST(N'2020-10-20T00:00:00.000' AS DateTime), 1, 2)
INSERT [dbo].[product] ([productId], [productName], [image], [price], [quantity], [createDate], [expirationDate], [status], [category]) VALUES (5, N'Lava Chocolate', N'Lava-Chocolate.jpg', 75000, 250, CAST(N'2020-09-12T00:00:00.000' AS DateTime), CAST(N'2020-10-18T00:00:00.000' AS DateTime), 1, 4)
INSERT [dbo].[product] ([productId], [productName], [image], [price], [quantity], [createDate], [expirationDate], [status], [category]) VALUES (6, N'Green Bean', N'green-bean.jpg', 60000, 300, CAST(N'2020-09-10T00:00:00.000' AS DateTime), CAST(N'2020-10-20T00:00:00.000' AS DateTime), 1, 5)
INSERT [dbo].[product] ([productId], [productName], [image], [price], [quantity], [createDate], [expirationDate], [status], [category]) VALUES (8, N'Matcha Lava Yolk', N'matcha-lava-yolk.jpg', 95000, 90, CAST(N'2020-09-25T00:00:00.000' AS DateTime), CAST(N'2020-10-10T00:00:00.000' AS DateTime), 1, 2)
INSERT [dbo].[product] ([productId], [productName], [image], [price], [quantity], [createDate], [expirationDate], [status], [category]) VALUES (9, N'White Lotus With Yam', N'White-Lotus-With-Yam.jpg', 120000, 60, CAST(N'2020-09-30T00:00:00.000' AS DateTime), CAST(N'2020-10-20T00:00:00.000' AS DateTime), 1, 3)
INSERT [dbo].[product] ([productId], [productName], [image], [price], [quantity], [createDate], [expirationDate], [status], [category]) VALUES (10, N'Green Bean Double Yolks', N'green-bean-double-yolk.jpeg', 150000, 200, CAST(N'2020-09-20T00:00:00.000' AS DateTime), CAST(N'2020-10-30T00:00:00.000' AS DateTime), 1, 5)
INSERT [dbo].[product] ([productId], [productName], [image], [price], [quantity], [createDate], [expirationDate], [status], [category]) VALUES (11, N'Low Sugar Pure Lotus', N'Low-Sugar-Pure-Lotus.jpg', 200000, 50, CAST(N'2020-09-19T00:00:00.000' AS DateTime), CAST(N'2020-10-30T00:00:00.000' AS DateTime), 1, 1)
INSERT [dbo].[product] ([productId], [productName], [image], [price], [quantity], [createDate], [expirationDate], [status], [category]) VALUES (12, N'Pure Lotus', N'Pure-Lotus-Single-Yolk.jpg', 165000, 65, CAST(N'2020-09-25T00:00:00.000' AS DateTime), CAST(N'2020-10-25T00:00:00.000' AS DateTime), 1, 3)
INSERT [dbo].[product] ([productId], [productName], [image], [price], [quantity], [createDate], [expirationDate], [status], [category]) VALUES (13, N'Sugar Free White Lotus', N'Sugar-Free-White-Lotus.jpg', 115000, 30, CAST(N'2020-09-20T00:00:00.000' AS DateTime), CAST(N'2020-10-30T00:00:00.000' AS DateTime), 1, 3)
INSERT [dbo].[product] ([productId], [productName], [image], [price], [quantity], [createDate], [expirationDate], [status], [category]) VALUES (14, N'Lava Chocolate', N'Lava-Chocolate.jpg', 110000, 150, CAST(N'2020-09-29T00:00:00.000' AS DateTime), CAST(N'2020-10-22T00:00:00.000' AS DateTime), 1, 4)
INSERT [dbo].[product] ([productId], [productName], [image], [price], [quantity], [createDate], [expirationDate], [status], [category]) VALUES (15, N'Green Bean', N'green-bean.jpg', 60000, 350, CAST(N'2020-10-05T00:00:00.000' AS DateTime), CAST(N'2020-10-22T00:00:00.000' AS DateTime), 1, 1)
INSERT [dbo].[product] ([productId], [productName], [image], [price], [quantity], [createDate], [expirationDate], [status], [category]) VALUES (16, N'Matcha Single Yolk', N'Matcha-Single-Yolk-Custard.jpg', 200000, 100, CAST(N'2020-10-01T00:00:00.000' AS DateTime), CAST(N'2020-10-30T00:00:00.000' AS DateTime), 1, 2)
INSERT [dbo].[product] ([productId], [productName], [image], [price], [quantity], [createDate], [expirationDate], [status], [category]) VALUES (17, N'Pure Lotus', N'Pure-Lotus-Single-Yolk.jpg', 215000, 150, CAST(N'2020-10-01T00:00:00.000' AS DateTime), CAST(N'2020-10-31T00:00:00.000' AS DateTime), 1, 1)
INSERT [dbo].[product] ([productId], [productName], [image], [price], [quantity], [createDate], [expirationDate], [status], [category]) VALUES (18, N'Lava Chocolate Luxury', N'Lava-Chocolate.jpg', 350000, 92, CAST(N'2020-10-12T00:00:00.000' AS DateTime), CAST(N'2020-11-06T00:00:00.000' AS DateTime), 1, 4)
INSERT [dbo].[product] ([productId], [productName], [image], [price], [quantity], [createDate], [expirationDate], [status], [category]) VALUES (19, N'Pink Macaron', N'pink-macaron.jpg', 200000, 100, CAST(N'2020-10-14T00:00:00.000' AS DateTime), CAST(N'2020-10-06T00:00:00.000' AS DateTime), 1, 1)
INSERT [dbo].[product] ([productId], [productName], [image], [price], [quantity], [createDate], [expirationDate], [status], [category]) VALUES (20, N'Matcha Red Bean', N'Matcha-Red-Bean.jpg', 350000, 92, CAST(N'2020-10-15T00:00:00.000' AS DateTime), CAST(N'2020-11-07T00:00:00.000' AS DateTime), 1, 1)
INSERT [dbo].[product] ([productId], [productName], [image], [price], [quantity], [createDate], [expirationDate], [status], [category]) VALUES (21, N'Matcha Red Bean', N'Matcha-Red-Bean.jpg', 154000, 100, CAST(N'2020-10-05T00:00:00.000' AS DateTime), CAST(N'2020-11-04T00:00:00.000' AS DateTime), 1, 1)
INSERT [dbo].[product] ([productId], [productName], [image], [price], [quantity], [createDate], [expirationDate], [status], [category]) VALUES (22, N'Matcha Red Bean', N'Matcha-Red-Bean.jpg', 125000, 22, CAST(N'2020-10-14T00:00:00.000' AS DateTime), CAST(N'2020-10-31T00:00:00.000' AS DateTime), 1, 1)
INSERT [dbo].[product] ([productId], [productName], [image], [price], [quantity], [createDate], [expirationDate], [status], [category]) VALUES (23, N'Low Sugar Pure Lotus', N'Low-Sugar-Pure-Lotus.jpg', 65000, 35, CAST(N'2020-10-01T00:00:00.000' AS DateTime), CAST(N'2020-10-30T00:00:00.000' AS DateTime), 1, 3)
INSERT [dbo].[product] ([productId], [productName], [image], [price], [quantity], [createDate], [expirationDate], [status], [category]) VALUES (24, N'Matcha Lava Yolk', N'matcha-lava-yolk.jpg', 165000, 65, CAST(N'2020-10-12T00:00:00.000' AS DateTime), CAST(N'2020-10-29T00:00:00.000' AS DateTime), 1, 2)
INSERT [dbo].[product] ([productId], [productName], [image], [price], [quantity], [createDate], [expirationDate], [status], [category]) VALUES (25, N'Green Bean', N'green-bean.jpg', 98000, 65, CAST(N'2020-10-12T00:00:00.000' AS DateTime), CAST(N'2020-10-31T00:00:00.000' AS DateTime), 1, 1)
INSERT [dbo].[product] ([productId], [productName], [image], [price], [quantity], [createDate], [expirationDate], [status], [category]) VALUES (26, N'Pink Macaron', N'pink-macaron.jpg', 120000, 0, CAST(N'2020-10-15T00:00:00.000' AS DateTime), CAST(N'2020-10-30T00:00:00.000' AS DateTime), 0, 1)
INSERT [dbo].[product] ([productId], [productName], [image], [price], [quantity], [createDate], [expirationDate], [status], [category]) VALUES (27, N'Green Bean', N'green-bean.jpg', 66666, 10, CAST(N'2020-10-15T00:00:00.000' AS DateTime), CAST(N'2020-10-16T00:00:00.000' AS DateTime), 1, 5)
INSERT [dbo].[product] ([productId], [productName], [image], [price], [quantity], [createDate], [expirationDate], [status], [category]) VALUES (28, N'Pink Macaron', N'pink-macaron.jpg', 57857, 45, CAST(N'2020-10-15T00:00:00.000' AS DateTime), CAST(N'2020-10-17T00:00:00.000' AS DateTime), 1, 1)
SET IDENTITY_INSERT [dbo].[product] OFF
GO
INSERT [dbo].[role] ([roleId], [roleName]) VALUES (1, N'admin')
INSERT [dbo].[role] ([roleId], [roleName]) VALUES (2, N'customer')
GO
INSERT [dbo].[status] ([statusId], [statusName]) VALUES (0, N'out-of-stock')
INSERT [dbo].[status] ([statusId], [statusName]) VALUES (1, N'available')
INSERT [dbo].[status] ([statusId], [statusName]) VALUES (2, N'active')
INSERT [dbo].[status] ([statusId], [statusName]) VALUES (3, N'deleted')
GO
ALTER TABLE [dbo].[account]  WITH CHECK ADD FOREIGN KEY([role])
REFERENCES [dbo].[role] ([roleId])
GO
ALTER TABLE [dbo].[account]  WITH CHECK ADD FOREIGN KEY([status])
REFERENCES [dbo].[status] ([statusId])
GO
ALTER TABLE [dbo].[cart]  WITH CHECK ADD FOREIGN KEY([username])
REFERENCES [dbo].[account] ([username])
GO
ALTER TABLE [dbo].[cartDetail]  WITH CHECK ADD FOREIGN KEY([cartId])
REFERENCES [dbo].[cart] ([id])
GO
ALTER TABLE [dbo].[cartDetail]  WITH CHECK ADD FOREIGN KEY([productId])
REFERENCES [dbo].[product] ([productId])
GO
ALTER TABLE [dbo].[log]  WITH CHECK ADD FOREIGN KEY([productId])
REFERENCES [dbo].[product] ([productId])
GO
ALTER TABLE [dbo].[log]  WITH CHECK ADD FOREIGN KEY([username])
REFERENCES [dbo].[account] ([username])
GO
ALTER TABLE [dbo].[product]  WITH CHECK ADD FOREIGN KEY([category])
REFERENCES [dbo].[category] ([categoryId])
GO
ALTER TABLE [dbo].[product]  WITH CHECK ADD FOREIGN KEY([status])
REFERENCES [dbo].[status] ([statusId])
GO
USE [master]
GO
ALTER DATABASE [YELLOW_MOON_SHOP] SET  READ_WRITE 
GO
