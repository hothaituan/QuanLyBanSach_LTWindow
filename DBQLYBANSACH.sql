USE [master]
GO
/****** Object:  Database [db_quan_ly_ban_sach]    Script Date: 02/11/2024 11:18:25 SA ******/
CREATE DATABASE [db_quan_ly_ban_sach]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'db_quan_ly_ban_sach', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS2012\MSSQL\DATA\db_quan_ly_ban_sach.mdf' , SIZE = 3136KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'db_quan_ly_ban_sach_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS2012\MSSQL\DATA\db_quan_ly_ban_sach_log.ldf' , SIZE = 784KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [db_quan_ly_ban_sach] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [db_quan_ly_ban_sach].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [db_quan_ly_ban_sach] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [db_quan_ly_ban_sach] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [db_quan_ly_ban_sach] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [db_quan_ly_ban_sach] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [db_quan_ly_ban_sach] SET ARITHABORT OFF 
GO
ALTER DATABASE [db_quan_ly_ban_sach] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [db_quan_ly_ban_sach] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [db_quan_ly_ban_sach] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [db_quan_ly_ban_sach] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [db_quan_ly_ban_sach] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [db_quan_ly_ban_sach] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [db_quan_ly_ban_sach] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [db_quan_ly_ban_sach] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [db_quan_ly_ban_sach] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [db_quan_ly_ban_sach] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [db_quan_ly_ban_sach] SET  ENABLE_BROKER 
GO
ALTER DATABASE [db_quan_ly_ban_sach] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [db_quan_ly_ban_sach] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [db_quan_ly_ban_sach] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [db_quan_ly_ban_sach] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [db_quan_ly_ban_sach] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [db_quan_ly_ban_sach] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [db_quan_ly_ban_sach] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [db_quan_ly_ban_sach] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [db_quan_ly_ban_sach] SET  MULTI_USER 
GO
ALTER DATABASE [db_quan_ly_ban_sach] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [db_quan_ly_ban_sach] SET DB_CHAINING OFF 
GO
ALTER DATABASE [db_quan_ly_ban_sach] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [db_quan_ly_ban_sach] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [db_quan_ly_ban_sach]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_chi_tiet_hoa_don]    Script Date: 02/11/2024 11:18:25 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Thêm chi tiết hóa đơn
CREATE PROCEDURE [dbo].[sp_insert_chi_tiet_hoa_don]
    @ma_hoa_don INT,
    @ma_sach INT,
    @so_luong INT
AS
BEGIN
    INSERT INTO tbl_chi_tiet_hoa_don (ma_hoa_don, ma_sach, so_luong)
    VALUES (@ma_hoa_don, @ma_sach, @so_luong);
END

GO
/****** Object:  StoredProcedure [dbo].[sp_insert_chi_tiet_phieu_nhap]    Script Date: 02/11/2024 11:18:25 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Thêm chi tiết phiếu nhập
CREATE PROCEDURE [dbo].[sp_insert_chi_tiet_phieu_nhap]
    @ma_phieu_nhap INT,
    @ma_sach INT,
    @so_luong INT
AS
BEGIN
    INSERT INTO tbl_chi_tiet_phieu_nhap (ma_phieu_nhap, ma_sach, so_luong)
    VALUES (@ma_phieu_nhap, @ma_sach, @so_luong);
END

GO
/****** Object:  StoredProcedure [dbo].[sp_insert_hoa_don]    Script Date: 02/11/2024 11:18:25 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Thêm hóa đơn
CREATE PROCEDURE [dbo].[sp_insert_hoa_don]
    @ngay_lap_hoa_don DATE,
    @ten_khach_hang NVARCHAR(100),
    @sdt_khach_hang NVARCHAR(15)
AS
BEGIN
    INSERT INTO tbl_hoa_don (ngay_lap_hoa_don, ten_khach_hang, sdt_khach_hang)
    VALUES (@ngay_lap_hoa_don, @ten_khach_hang, @sdt_khach_hang);
END

GO
/****** Object:  StoredProcedure [dbo].[sp_insert_loai_sach]    Script Date: 02/11/2024 11:18:25 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_insert_loai_sach]
    @ten_loai_sach NVARCHAR(100)
AS
BEGIN
    INSERT INTO tbl_loai_sach (ten_loai_sach)
    VALUES (@ten_loai_sach);
END

GO
/****** Object:  StoredProcedure [dbo].[sp_insert_phieu_nhap]    Script Date: 02/11/2024 11:18:25 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Thêm phiếu nhập
CREATE PROCEDURE [dbo].[sp_insert_phieu_nhap]
    @ngay_lap_phieu_nhap DATE,
    @ten_nha_cung_cap NVARCHAR(100)
AS
BEGIN
    INSERT INTO tbl_phieu_nhap (ngay_lap_phieu_nhap, ten_nha_cung_cap)
    VALUES (@ngay_lap_phieu_nhap, @ten_nha_cung_cap);
END

GO
/****** Object:  StoredProcedure [dbo].[sp_insert_sach]    Script Date: 02/11/2024 11:18:25 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_insert_sach]
    @ten_sach NVARCHAR(100),
    @ma_loai_sach INT,
    @tac_gia NVARCHAR(100),
    @so_luong INT,
    @gia_ban DECIMAL(10, 2)
AS
BEGIN
    INSERT INTO tbl_sach (ten_sach, ma_loai_sach, tac_gia, so_luong, gia_ban)
    VALUES (@ten_sach, @ma_loai_sach, @tac_gia, @so_luong, @gia_ban);
END

GO
/****** Object:  StoredProcedure [dbo].[sp_update_chi_tiet_hoa_don]    Script Date: 02/11/2024 11:18:25 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Cập nhật chi tiết hóa đơn
CREATE PROCEDURE [dbo].[sp_update_chi_tiet_hoa_don]
    @ma_hoa_don INT,
    @ma_sach INT,
    @so_luong INT
AS
BEGIN
    UPDATE tbl_chi_tiet_hoa_don
    SET so_luong = @so_luong
    WHERE ma_hoa_don = @ma_hoa_don AND ma_sach = @ma_sach;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_update_chi_tiet_phieu_nhap]    Script Date: 02/11/2024 11:18:25 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Cập nhật chi tiết phiếu nhập
CREATE PROCEDURE [dbo].[sp_update_chi_tiet_phieu_nhap]
    @ma_phieu_nhap INT,
    @ma_sach INT,
    @so_luong INT
AS
BEGIN
    UPDATE tbl_chi_tiet_phieu_nhap
    SET so_luong = @so_luong
    WHERE ma_phieu_nhap = @ma_phieu_nhap AND ma_sach = @ma_sach;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_update_hoa_don]    Script Date: 02/11/2024 11:18:25 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Cập nhật hóa đơn
CREATE PROCEDURE [dbo].[sp_update_hoa_don]
    @ma_hoa_don INT,
    @ngay_lap_hoa_don DATE,
    @ten_khach_hang NVARCHAR(100),
    @sdt_khach_hang NVARCHAR(15)
AS
BEGIN
    UPDATE tbl_hoa_don
    SET ngay_lap_hoa_don = @ngay_lap_hoa_don,
        ten_khach_hang = @ten_khach_hang,
        sdt_khach_hang = @sdt_khach_hang
    WHERE ma_hoa_don = @ma_hoa_don;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_update_loai_sach]    Script Date: 02/11/2024 11:18:25 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Cập nhật loại sách
CREATE PROCEDURE [dbo].[sp_update_loai_sach]
    @ma_loai_sach INT,
    @ten_loai_sach NVARCHAR(100)
AS
BEGIN
    UPDATE tbl_loai_sach
    SET ten_loai_sach = @ten_loai_sach
    WHERE ma_loai_sach = @ma_loai_sach;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_update_phieu_nhap]    Script Date: 02/11/2024 11:18:25 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Cập nhật phiếu nhập
CREATE PROCEDURE [dbo].[sp_update_phieu_nhap]
    @ma_phieu_nhap INT,
    @ngay_lap_phieu_nhap DATE,
    @ten_nha_cung_cap NVARCHAR(100)
AS
BEGIN
    UPDATE tbl_phieu_nhap
    SET ngay_lap_phieu_nhap = @ngay_lap_phieu_nhap,
        ten_nha_cung_cap = @ten_nha_cung_cap
    WHERE ma_phieu_nhap = @ma_phieu_nhap;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_update_sach]    Script Date: 02/11/2024 11:18:25 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Cập nhật sách
CREATE PROCEDURE [dbo].[sp_update_sach]
    @ma_sach INT,
    @ten_sach NVARCHAR(100),
    @ma_loai_sach INT,
    @tac_gia NVARCHAR(100),
    @so_luong INT,
    @gia_ban DECIMAL(10, 2)
AS
BEGIN
    UPDATE tbl_sach
    SET ten_sach = @ten_sach,
        ma_loai_sach = @ma_loai_sach,
        tac_gia = @tac_gia,
        so_luong = @so_luong,
        gia_ban = @gia_ban
    WHERE ma_sach = @ma_sach;
END

GO
/****** Object:  Table [dbo].[tbl_loai_sach]    Script Date: 02/11/2024 11:18:25 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_loai_sach](
	[ma_loai_sach] [int] IDENTITY(1,1) NOT NULL,
	[ten_loai_sach] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[ma_loai_sach] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_sach]    Script Date: 02/11/2024 11:18:25 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_sach](
	[ma_sach] [int] IDENTITY(1,1) NOT NULL,
	[ten_sach] [nvarchar](100) NULL,
	[ma_loai_sach] [int] NULL,
	[tac_gia] [nvarchar](100) NULL,
	[so_luong] [int] NULL,
	[gia_ban] [decimal](10, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[ma_sach] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_user]    Script Date: 02/11/2024 11:18:25 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_user](
	[Username] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](50) NULL,
 CONSTRAINT [PK_tbl_user] PRIMARY KEY CLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[tbl_sach]  WITH CHECK ADD FOREIGN KEY([ma_loai_sach])
REFERENCES [dbo].[tbl_loai_sach] ([ma_loai_sach])
GO
USE [master]
GO
ALTER DATABASE [db_quan_ly_ban_sach] SET  READ_WRITE 
GO
