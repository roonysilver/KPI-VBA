USE [master]
GO
/****** Object:  Database [KPI]    Script Date: 10/27/2020 4:01:40 PM ******/
CREATE DATABASE [KPI]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'KPI', FILENAME = N'D:\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\KPI.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'KPI_log', FILENAME = N'D:\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\KPI_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [KPI].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [KPI] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [KPI] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [KPI] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [KPI] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [KPI] SET ARITHABORT OFF 
GO
ALTER DATABASE [KPI] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [KPI] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [KPI] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [KPI] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [KPI] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [KPI] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [KPI] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [KPI] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [KPI] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [KPI] SET  DISABLE_BROKER 
GO
ALTER DATABASE [KPI] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [KPI] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [KPI] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [KPI] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [KPI] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [KPI] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [KPI] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [KPI] SET RECOVERY FULL 
GO
ALTER DATABASE [KPI] SET  MULTI_USER 
GO
ALTER DATABASE [KPI] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [KPI] SET DB_CHAINING OFF 
GO
ALTER DATABASE [KPI] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [KPI] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [KPI] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'KPI', N'ON'
GO
ALTER DATABASE [KPI] SET QUERY_STORE = OFF
GO
USE [KPI]
GO
/****** Object:  UserDefinedFunction [dbo].[AUTO_BRY]    Script Date: 10/27/2020 4:01:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[AUTO_BRY]()
RETURNS VARCHAR(6)
AS
BEGIN
	DECLARE @ID VARCHAR(6)
	IF (SELECT COUNT(IdUser) FROM [dbo].[KPI_M_User]) = 0
		SET @ID = '0'
	ELSE
		SELECT @ID = MAX(RIGHT(IdUser, 3)) FROM [dbo].[KPI_M_User]
		SELECT @ID = CASE
			WHEN @ID >= 0 and @ID < 9 THEN 'BRY00' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 9 and @ID < 99 THEN 'BRY0' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 99 THEN 'BRY' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
		END
	RETURN @ID
END
GO
/****** Object:  Table [dbo].[KPI_M_Department]    Script Date: 10/27/2020 4:01:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KPI_M_Department](
	[IdDerpartment] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
 CONSTRAINT [PK_KPI_M_Department] PRIMARY KEY CLUSTERED 
(
	[IdDerpartment] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KPI_M_ErrorType]    Script Date: 10/27/2020 4:01:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KPI_M_ErrorType](
	[IdError] [int] IDENTITY(1,1) NOT NULL,
	[NameVN] [nvarchar](300) NULL,
	[NameJP] [nvarchar](300) NULL,
	[NoteJP] [nvarchar](400) NULL,
	[NoteVN] [nvarchar](400) NULL,
 CONSTRAINT [PK_errorKind] PRIMARY KEY CLUSTERED 
(
	[IdError] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KPI_M_Level]    Script Date: 10/27/2020 4:01:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KPI_M_Level](
	[IdLevel] [int] IDENTITY(1,1) NOT NULL,
	[LevelJP] [nvarchar](10) NULL,
	[LevelVN] [nvarchar](10) NULL,
 CONSTRAINT [PK_Level] PRIMARY KEY CLUSTERED 
(
	[IdLevel] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KPI_M_Phase]    Script Date: 10/27/2020 4:01:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KPI_M_Phase](
	[IdPhase] [int] IDENTITY(1,1) NOT NULL,
	[NamePhaseJP] [nvarchar](50) NULL,
	[NamePhaseVN] [nvarchar](50) NULL,
 CONSTRAINT [PK_Phase] PRIMARY KEY CLUSTERED 
(
	[IdPhase] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KPI_M_Project]    Script Date: 10/27/2020 4:01:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KPI_M_Project](
	[IdProject] [int] IDENTITY(1,1) NOT NULL,
	[NameJP] [nvarchar](50) NULL,
	[NameVN] [nvarchar](50) NULL,
	[IdAnalysis] [int] NULL,
	[IdDepartment] [int] NULL,
	[Description] [nvarchar](max) NULL,
	[CreateAt] [date] NULL,
	[UpdateAt] [date] NULL,
	[IdUser] [nchar](6) NULL,
	[Deleted] [int] NOT NULL,
 CONSTRAINT [PK_Project] PRIMARY KEY CLUSTERED 
(
	[IdProject] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KPI_M_Role]    Script Date: 10/27/2020 4:01:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KPI_M_Role](
	[IdRole] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](10) NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[IdRole] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KPI_M_User]    Script Date: 10/27/2020 4:01:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KPI_M_User](
	[IdUser] [nchar](6) NOT NULL,
	[Username] [nvarchar](50) NULL,
	[Password] [nvarchar](50) NULL,
	[IdRole] [int] NULL,
	[FirstName] [varchar](50) NULL,
	[LastName] [nvarchar](50) NULL,
	[Dob] [date] NULL,
	[Address] [nvarchar](250) NULL,
	[Phone] [nvarchar](50) NULL,
	[Email] [nvarchar](100) NULL,
	[Token] [nvarchar](max) NULL,
	[TimeForget] [datetime] NULL,
	[LoginFail] [int] NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[IdUser] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KPI_T_Content]    Script Date: 10/27/2020 4:01:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KPI_T_Content](
	[IdContent] [int] IDENTITY(1,1) NOT NULL,
	[ContentJP] [nvarchar](500) NULL,
	[ContentVN] [nvarchar](500) NULL,
	[IdUser] [nchar](6) NULL,
	[Deleted] [int] NOT NULL,
 CONSTRAINT [PK_Content] PRIMARY KEY CLUSTERED 
(
	[IdContent] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KPI_T_ContentErrorType]    Script Date: 10/27/2020 4:01:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KPI_T_ContentErrorType](
	[IdContent] [int] IDENTITY(1,1) NOT NULL,
	[idPhase] [int] NOT NULL,
	[Bug] [int] NULL,
	[Reference] [nvarchar](max) NULL,
	[IdContentErrorType] [int] NOT NULL,
	[IdError] [int] NULL,
 CONSTRAINT [PK_ContentErrorType] PRIMARY KEY CLUSTERED 
(
	[IdContentErrorType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KPI_T_PhaseAnalysis]    Script Date: 10/27/2020 4:01:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KPI_T_PhaseAnalysis](
	[Hour] [float] NULL,
	[Bug] [int] NULL,
	[Ratio] [float] NULL,
	[OverStandard] [nvarchar](50) NULL,
	[IdAnalysis] [int] NOT NULL,
	[IdPhase] [int] NOT NULL,
	[IdPhaseAnalysis] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_PhaseAnalysis] PRIMARY KEY CLUSTERED 
(
	[IdPhaseAnalysis] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KPI_T_ProjectAnalysis]    Script Date: 10/27/2020 4:01:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KPI_T_ProjectAnalysis](
	[IdAnalysis] [int] IDENTITY(1,1) NOT NULL,
	[IdContent] [int] NULL,
	[IdLevel] [int] NULL,
	[WhyJP] [nvarchar](max) NULL,
	[WhyVN] [nvarchar](max) NULL,
 CONSTRAINT [PK_Analysis] PRIMARY KEY CLUSTERED 
(
	[IdAnalysis] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KPI_T_ProjectUser]    Script Date: 10/27/2020 4:01:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KPI_T_ProjectUser](
	[idUser] [nchar](6) NOT NULL,
	[IdProject] [int] NOT NULL,
 CONSTRAINT [PK_ProjectUser] PRIMARY KEY CLUSTERED 
(
	[idUser] ASC,
	[IdProject] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KPI_T_Target]    Script Date: 10/27/2020 4:01:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KPI_T_Target](
	[IdTarget] [int] IDENTITY(1,1) NOT NULL,
	[TargetJP] [nvarchar](200) NULL,
	[AverageTarget] [float] NULL,
	[ToleranceTarget] [float] NULL,
	[IdPhase] [int] NULL,
	[TargetVN] [nvarchar](200) NULL,
	[IdProject] [int] NULL,
 CONSTRAINT [PK_Target] PRIMARY KEY CLUSTERED 
(
	[IdTarget] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[KPI_M_Department] ON 

INSERT [dbo].[KPI_M_Department] ([IdDerpartment], [Name]) VALUES (1, N'DEV-BAS')
INSERT [dbo].[KPI_M_Department] ([IdDerpartment], [Name]) VALUES (2, N'DEV-EMS')
INSERT [dbo].[KPI_M_Department] ([IdDerpartment], [Name]) VALUES (3, N'BPO')
INSERT [dbo].[KPI_M_Department] ([IdDerpartment], [Name]) VALUES (4, N'BAO')
SET IDENTITY_INSERT [dbo].[KPI_M_Department] OFF
GO
SET IDENTITY_INSERT [dbo].[KPI_M_ErrorType] ON 

INSERT [dbo].[KPI_M_ErrorType] ([IdError], [NameVN], [NameJP], [NoteJP], [NoteVN]) VALUES (1, N'Bỏ sót định nghĩa yêu cầu', N'要求定義漏れ', NULL, NULL)
INSERT [dbo].[KPI_M_ErrorType] ([IdError], [NameVN], [NameJP], [NoteJP], [NoteVN]) VALUES (2, N'Không hiểu rõ yêu cầu', N'要求理解不足 ', NULL, NULL)
INSERT [dbo].[KPI_M_ErrorType] ([IdError], [NameVN], [NameJP], [NoteJP], [NoteVN]) VALUES (3, N'Thiếu sự thảo luận về những thông số kĩ thuật (Thiếu sự thảo luận của các trường hợp bên nghiệp vụ)', N'仕様検討不足（業務ケースの検討不足）', NULL, NULL)
INSERT [dbo].[KPI_M_ErrorType] ([IdError], [NameVN], [NameJP], [NoteJP], [NoteVN]) VALUES (4, N'Thiếu sự thảo luận về những thông số kĩ thuật (Thiếu sự thảo luận chi tiết)', N'仕様検討不足（詳細の検討不足）', NULL, NULL)
INSERT [dbo].[KPI_M_ErrorType] ([IdError], [NameVN], [NameJP], [NoteJP], [NoteVN]) VALUES (5, N'Thiếu sự thảo luận về những thông số kĩ thuật (Thiếu sự thảo luận về phạm vi ảnh hưởng)', N'仕様検討不足（影響範囲の検討不足）', NULL, NULL)
INSERT [dbo].[KPI_M_ErrorType] ([IdError], [NameVN], [NameJP], [NoteJP], [NoteVN]) VALUES (6, N'Thiếu sự thảo luận về những thông số kĩ thuật (Thiếu sự biết về nghiệp vụ)', N'仕様検討不足（業務の理解不足）', NULL, NULL)
INSERT [dbo].[KPI_M_ErrorType] ([IdError], [NameVN], [NameJP], [NoteJP], [NoteVN]) VALUES (7, N'Thiếu sự thảo luận về những thông số kĩ thuật (Thiếu sự biết trong hệ thống)', N'仕様検討不足（システム内部の理解不足）', NULL, NULL)
INSERT [dbo].[KPI_M_ErrorType] ([IdError], [NameVN], [NameJP], [NoteJP], [NoteVN]) VALUES (8, N'Thiếu sự thảo luận về những thông số kĩ thuật (Khác)', N'仕様検討不足（その他）', NULL, NULL)
INSERT [dbo].[KPI_M_ErrorType] ([IdError], [NameVN], [NameJP], [NoteJP], [NoteVN]) VALUES (9, N'Lỗi đánh máy ・Bố cục', N'誤字脱字・体裁 ', NULL, NULL)
INSERT [dbo].[KPI_M_ErrorType] ([IdError], [NameVN], [NameJP], [NoteJP], [NoteVN]) VALUES (10, N'Lỗi coding (Không theo thông số kĩ thuật ［Sai thông số kĩ thuật］', N'コーディングミス（仕様通りでない［仕様誤認］）', NULL, NULL)
INSERT [dbo].[KPI_M_ErrorType] ([IdError], [NameVN], [NameJP], [NoteJP], [NoteVN]) VALUES (11, N'Lỗi coding (Không theo thông số kĩ thuật ［Thiếu sự hiểu rõ về thông số kĩ thuật］', N'コーディングミス（仕様通りでない［仕様理解不足］）', NULL, NULL)
INSERT [dbo].[KPI_M_ErrorType] ([IdError], [NameVN], [NameJP], [NoteJP], [NoteVN]) VALUES (12, N'Lỗi coding (Thiếu sự hiểu rõ về cấu trúc của bảng)', N'コーディングミス（テーブル構成理解不足）', NULL, NULL)
INSERT [dbo].[KPI_M_ErrorType] ([IdError], [NameVN], [NameJP], [NoteJP], [NoteVN]) VALUES (13, N'Lỗi coding (Thiếu sự hiểu rõ về cách nắm dữ liệu)', N'コーディングミス（データの持ち方理解不足）', NULL, NULL)
INSERT [dbo].[KPI_M_ErrorType] ([IdError], [NameVN], [NameJP], [NoteJP], [NoteVN]) VALUES (14, N'Lỗi coding (Thiếu xác nhận phạm vi ảnh hưởng)', N'コーディングミス（影響範囲の確認不足）', NULL, NULL)
INSERT [dbo].[KPI_M_ErrorType] ([IdError], [NameVN], [NameJP], [NoteJP], [NoteVN]) VALUES (15, N'Lỗi coding (Không tuân theo những quy tắc)', N'コーディングミス（規約準拠していない）', NULL, NULL)
INSERT [dbo].[KPI_M_ErrorType] ([IdError], [NameVN], [NameJP], [NoteJP], [NoteVN]) VALUES (16, N'Lỗi coding (Không phải là mô tả chung )', N'コーディングミス（一般的な記述でない）', NULL, NULL)
INSERT [dbo].[KPI_M_ErrorType] ([IdError], [NameVN], [NameJP], [NoteJP], [NoteVN]) VALUES (17, N'Lỗi coding (Thiếu Error handling )', N'コーディングミス（エラーハンドリング不足）', NULL, NULL)
INSERT [dbo].[KPI_M_ErrorType] ([IdError], [NameVN], [NameJP], [NoteJP], [NoteVN]) VALUES (18, N'Lỗi coding (Không sử dụng hàm số chung )', N'コーディングミス（共通関数　非使用）', NULL, NULL)
INSERT [dbo].[KPI_M_ErrorType] ([IdError], [NameVN], [NameJP], [NoteJP], [NoteVN]) VALUES (19, N'Lỗi coding (Khả năng bảo trì thấp )', N'コーディングミス（保守性　低い）', NULL, NULL)
INSERT [dbo].[KPI_M_ErrorType] ([IdError], [NameVN], [NameJP], [NoteJP], [NoteVN]) VALUES (20, N'Lỗi coding (Thiếu comment ・comment tiếng Anh )', N'コーディングミス（コメント不足・コメント英語）', NULL, NULL)
INSERT [dbo].[KPI_M_ErrorType] ([IdError], [NameVN], [NameJP], [NoteJP], [NoteVN]) VALUES (21, N'Lỗi coding (Khác )', N'コーディングミス（その他）', NULL, NULL)
INSERT [dbo].[KPI_M_ErrorType] ([IdError], [NameVN], [NameJP], [NoteJP], [NoteVN]) VALUES (22, N'Thiếu hạng mục test ( Thiếu case công việc ) ', N'試験項目不足（業務ケースの不足）', NULL, NULL)
INSERT [dbo].[KPI_M_ErrorType] ([IdError], [NameVN], [NameJP], [NoteJP], [NoteVN]) VALUES (23, N'Thiếu hạng mục test ( Thiếu case chi tiết) ', N'試験項目不足（詳細ケースの不足）', NULL, NULL)
INSERT [dbo].[KPI_M_ErrorType] ([IdError], [NameVN], [NameJP], [NoteJP], [NoteVN]) VALUES (24, N'Thiếu hạng mục test ( Thiếu Data pattern) ', N'試験項目不足（データパターンの不足） ', NULL, NULL)
INSERT [dbo].[KPI_M_ErrorType] ([IdError], [NameVN], [NameJP], [NoteJP], [NoteVN]) VALUES (25, N'Thiếu hạng mục test ( Thiếu kiểm tra phạm vi ảnh hưởng) ', N'試験項目不足（影響範囲の確認不足）', NULL, NULL)
INSERT [dbo].[KPI_M_ErrorType] ([IdError], [NameVN], [NameJP], [NoteJP], [NoteVN]) VALUES (26, N'Thiếu hạng mục test (Khác) ', N'試験項目不足（その他）', NULL, NULL)
INSERT [dbo].[KPI_M_ErrorType] ([IdError], [NameVN], [NameJP], [NoteJP], [NoteVN]) VALUES (27, N'Nội dung test sai', N'試験内容誤り', NULL, NULL)
INSERT [dbo].[KPI_M_ErrorType] ([IdError], [NameVN], [NameJP], [NoteJP], [NoteVN]) VALUES (28, N'Nội dung test không cụ thể', N'試験内容具体的ではない ', NULL, NULL)
INSERT [dbo].[KPI_M_ErrorType] ([IdError], [NameVN], [NameJP], [NoteJP], [NoteVN]) VALUES (29, N' Lỗi đánh máy ・Bố cục', N'誤字脱字・体裁', NULL, NULL)
INSERT [dbo].[KPI_M_ErrorType] ([IdError], [NameVN], [NameJP], [NoteJP], [NoteVN]) VALUES (30, N'Thiếu sự hiểu biết về nội dung điều tra', N'調査内容理解不足 ', NULL, NULL)
INSERT [dbo].[KPI_M_ErrorType] ([IdError], [NameVN], [NameJP], [NoteJP], [NoteVN]) VALUES (31, N'Thiếu sự thảo luận về nội dung điều tra', N'調査内容検討不足', NULL, NULL)
INSERT [dbo].[KPI_M_ErrorType] ([IdError], [NameVN], [NameJP], [NoteJP], [NoteVN]) VALUES (32, N' Nội dung điều tra sai', N'調査内容間違い', NULL, NULL)
INSERT [dbo].[KPI_M_ErrorType] ([IdError], [NameVN], [NameJP], [NoteJP], [NoteVN]) VALUES (33, N'Thiếu sự giải thích cho phía Nhật Bản (Nghiệp vụ, hệ thống v.v)', N'日本側説明不足（業務、システム等）', NULL, NULL)
INSERT [dbo].[KPI_M_ErrorType] ([IdError], [NameVN], [NameJP], [NoteJP], [NoteVN]) VALUES (34, N'Thiếu sự giải thích cho phía Nhật Bản (trình tự công việc, quy định v.v)', N'日本側説明不足（作業手順、規約等）', NULL, NULL)
INSERT [dbo].[KPI_M_ErrorType] ([IdError], [NameVN], [NameJP], [NoteJP], [NoteVN]) VALUES (35, N'Thiếu sự giải thích cho phía nghiệp vụ (trình tự công việc, quy định v.v)', N'日本側説明不足（改修内容）', NULL, NULL)
INSERT [dbo].[KPI_M_ErrorType] ([IdError], [NameVN], [NameJP], [NoteJP], [NoteVN]) VALUES (36, N'Thiếu nguồn lực đối ứng', N'対応資源不足', NULL, NULL)
SET IDENTITY_INSERT [dbo].[KPI_M_ErrorType] OFF
GO
SET IDENTITY_INSERT [dbo].[KPI_M_Level] ON 

INSERT [dbo].[KPI_M_Level] ([IdLevel], [LevelJP], [LevelVN]) VALUES (1, N'高         ', N'Cao       ')
INSERT [dbo].[KPI_M_Level] ([IdLevel], [LevelJP], [LevelVN]) VALUES (2, N'中         ', N'Vừa       ')
INSERT [dbo].[KPI_M_Level] ([IdLevel], [LevelJP], [LevelVN]) VALUES (3, N'低         ', N'Thấp      ')
SET IDENTITY_INSERT [dbo].[KPI_M_Level] OFF
GO
SET IDENTITY_INSERT [dbo].[KPI_M_Phase] ON 

INSERT [dbo].[KPI_M_Phase] ([IdPhase], [NamePhaseJP], [NamePhaseVN]) VALUES (1, N'設計', N'Thiết kế')
INSERT [dbo].[KPI_M_Phase] ([IdPhase], [NamePhaseJP], [NamePhaseVN]) VALUES (2, N'製造', N'Code')
INSERT [dbo].[KPI_M_Phase] ([IdPhase], [NamePhaseJP], [NamePhaseVN]) VALUES (3, N'テスト', N'Test')
INSERT [dbo].[KPI_M_Phase] ([IdPhase], [NamePhaseJP], [NamePhaseVN]) VALUES (4, N'BRC内部受入', N'Chấp nhận trong nội bộ BRC')
INSERT [dbo].[KPI_M_Phase] ([IdPhase], [NamePhaseJP], [NamePhaseVN]) VALUES (5, N'OSC様受入', N' Chấp nhận của khách hàng OSC')
INSERT [dbo].[KPI_M_Phase] ([IdPhase], [NamePhaseJP], [NamePhaseVN]) VALUES (6, N'業務側受入(リリース後含む', N'Chấp nhận của phía nghiệp vụ ')
SET IDENTITY_INSERT [dbo].[KPI_M_Phase] OFF
GO
SET IDENTITY_INSERT [dbo].[KPI_M_Role] ON 

INSERT [dbo].[KPI_M_Role] ([IdRole], [Name]) VALUES (1, N'Admin')
INSERT [dbo].[KPI_M_Role] ([IdRole], [Name]) VALUES (2, N'Manager')
INSERT [dbo].[KPI_M_Role] ([IdRole], [Name]) VALUES (3, N'Leader')
INSERT [dbo].[KPI_M_Role] ([IdRole], [Name]) VALUES (4, N'User')
SET IDENTITY_INSERT [dbo].[KPI_M_Role] OFF
GO
INSERT [dbo].[KPI_M_User] ([IdUser], [Username], [Password], [IdRole], [FirstName], [LastName], [Dob], [Address], [Phone], [Email], [Token], [TimeForget], [LoginFail]) VALUES (N'BRY001', N'donle', N'CE0BFD15059B68D67688884D7A3D3E8C', 1, N'Ðôn', N'Lê ', CAST(N'2020-11-11' AS Date), N'Vạn Xuân', N'123156789  ', N'lq_don@brycen.com.vn', N'b5c4b9bc-4aef-4b96-b0ea-49f91e3957ae', CAST(N'2020-10-27T15:21:13.437' AS DateTime), 0)
INSERT [dbo].[KPI_M_User] ([IdUser], [Username], [Password], [IdRole], [FirstName], [LastName], [Dob], [Address], [Phone], [Email], [Token], [TimeForget], [LoginFail]) VALUES (N'BRY002', N'congson813', N'12356', 1, N'Son', N'Trần', CAST(N'2020-10-10' AS Date), N'Hùng Vương', N'0906424280 ', NULL, NULL, CAST(N'1985-01-01T00:00:00.000' AS DateTime), 0)
GO
ALTER TABLE [dbo].[KPI_M_Project] ADD  CONSTRAINT [DF_KPI_M_Project_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [dbo].[KPI_M_User] ADD  CONSTRAINT [df_id]  DEFAULT ([DBO].[AUTO_BRY]()) FOR [IdUser]
GO
ALTER TABLE [dbo].[KPI_M_User] ADD  CONSTRAINT [DF_KPI_M_User_TimeForget]  DEFAULT (((1)/(1))/(1)) FOR [TimeForget]
GO
ALTER TABLE [dbo].[KPI_M_User] ADD  CONSTRAINT [DF_KPI_M_User_CountLoginFail]  DEFAULT ((0)) FOR [LoginFail]
GO
ALTER TABLE [dbo].[KPI_T_Content] ADD  CONSTRAINT [DF_KPI_T_Content_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [dbo].[KPI_M_Project]  WITH CHECK ADD  CONSTRAINT [FK_KPI_M_Project_KPI_M_Department] FOREIGN KEY([IdDepartment])
REFERENCES [dbo].[KPI_M_Department] ([IdDerpartment])
GO
ALTER TABLE [dbo].[KPI_M_Project] CHECK CONSTRAINT [FK_KPI_M_Project_KPI_M_Department]
GO
ALTER TABLE [dbo].[KPI_M_Project]  WITH CHECK ADD  CONSTRAINT [FK_KPI_M_Project_KPI_M_User] FOREIGN KEY([IdUser])
REFERENCES [dbo].[KPI_M_User] ([IdUser])
GO
ALTER TABLE [dbo].[KPI_M_Project] CHECK CONSTRAINT [FK_KPI_M_Project_KPI_M_User]
GO
ALTER TABLE [dbo].[KPI_M_Project]  WITH CHECK ADD  CONSTRAINT [FK_Project_Analysis] FOREIGN KEY([IdAnalysis])
REFERENCES [dbo].[KPI_T_ProjectAnalysis] ([IdAnalysis])
GO
ALTER TABLE [dbo].[KPI_M_Project] CHECK CONSTRAINT [FK_Project_Analysis]
GO
ALTER TABLE [dbo].[KPI_M_User]  WITH CHECK ADD  CONSTRAINT [FK_User_Role] FOREIGN KEY([IdRole])
REFERENCES [dbo].[KPI_M_Role] ([IdRole])
GO
ALTER TABLE [dbo].[KPI_M_User] CHECK CONSTRAINT [FK_User_Role]
GO
ALTER TABLE [dbo].[KPI_T_Content]  WITH CHECK ADD  CONSTRAINT [FK_Content_User] FOREIGN KEY([IdUser])
REFERENCES [dbo].[KPI_M_User] ([IdUser])
GO
ALTER TABLE [dbo].[KPI_T_Content] CHECK CONSTRAINT [FK_Content_User]
GO
ALTER TABLE [dbo].[KPI_T_ContentErrorType]  WITH CHECK ADD  CONSTRAINT [FK_ContentErrorType_ErrorType] FOREIGN KEY([IdError])
REFERENCES [dbo].[KPI_M_ErrorType] ([IdError])
GO
ALTER TABLE [dbo].[KPI_T_ContentErrorType] CHECK CONSTRAINT [FK_ContentErrorType_ErrorType]
GO
ALTER TABLE [dbo].[KPI_T_ContentErrorType]  WITH CHECK ADD  CONSTRAINT [FK_ContentErrorType_Phase] FOREIGN KEY([idPhase])
REFERENCES [dbo].[KPI_M_Phase] ([IdPhase])
GO
ALTER TABLE [dbo].[KPI_T_ContentErrorType] CHECK CONSTRAINT [FK_ContentErrorType_Phase]
GO
ALTER TABLE [dbo].[KPI_T_ContentErrorType]  WITH CHECK ADD  CONSTRAINT [FK_ContentPhase_Content] FOREIGN KEY([IdContent])
REFERENCES [dbo].[KPI_T_Content] ([IdContent])
GO
ALTER TABLE [dbo].[KPI_T_ContentErrorType] CHECK CONSTRAINT [FK_ContentPhase_Content]
GO
ALTER TABLE [dbo].[KPI_T_PhaseAnalysis]  WITH CHECK ADD  CONSTRAINT [FK_PhaseAnalysis_Analysis] FOREIGN KEY([IdAnalysis])
REFERENCES [dbo].[KPI_T_ProjectAnalysis] ([IdAnalysis])
GO
ALTER TABLE [dbo].[KPI_T_PhaseAnalysis] CHECK CONSTRAINT [FK_PhaseAnalysis_Analysis]
GO
ALTER TABLE [dbo].[KPI_T_PhaseAnalysis]  WITH CHECK ADD  CONSTRAINT [FK_PhaseAnalysis_Phase] FOREIGN KEY([IdPhase])
REFERENCES [dbo].[KPI_M_Phase] ([IdPhase])
GO
ALTER TABLE [dbo].[KPI_T_PhaseAnalysis] CHECK CONSTRAINT [FK_PhaseAnalysis_Phase]
GO
ALTER TABLE [dbo].[KPI_T_ProjectAnalysis]  WITH CHECK ADD  CONSTRAINT [FK_Analysis_Content] FOREIGN KEY([IdContent])
REFERENCES [dbo].[KPI_T_Content] ([IdContent])
GO
ALTER TABLE [dbo].[KPI_T_ProjectAnalysis] CHECK CONSTRAINT [FK_Analysis_Content]
GO
ALTER TABLE [dbo].[KPI_T_ProjectAnalysis]  WITH CHECK ADD  CONSTRAINT [FK_Analysis_Level] FOREIGN KEY([IdLevel])
REFERENCES [dbo].[KPI_M_Level] ([IdLevel])
GO
ALTER TABLE [dbo].[KPI_T_ProjectAnalysis] CHECK CONSTRAINT [FK_Analysis_Level]
GO
ALTER TABLE [dbo].[KPI_T_ProjectUser]  WITH CHECK ADD  CONSTRAINT [FK_ProjectUser_Project] FOREIGN KEY([IdProject])
REFERENCES [dbo].[KPI_M_Project] ([IdProject])
GO
ALTER TABLE [dbo].[KPI_T_ProjectUser] CHECK CONSTRAINT [FK_ProjectUser_Project]
GO
ALTER TABLE [dbo].[KPI_T_ProjectUser]  WITH CHECK ADD  CONSTRAINT [FK_ProjectUser_User] FOREIGN KEY([idUser])
REFERENCES [dbo].[KPI_M_User] ([IdUser])
GO
ALTER TABLE [dbo].[KPI_T_ProjectUser] CHECK CONSTRAINT [FK_ProjectUser_User]
GO
ALTER TABLE [dbo].[KPI_T_Target]  WITH CHECK ADD  CONSTRAINT [FK_KPI_T_Target_KPI_M_Phase] FOREIGN KEY([IdPhase])
REFERENCES [dbo].[KPI_M_Phase] ([IdPhase])
GO
ALTER TABLE [dbo].[KPI_T_Target] CHECK CONSTRAINT [FK_KPI_T_Target_KPI_M_Phase]
GO
ALTER TABLE [dbo].[KPI_T_Target]  WITH CHECK ADD  CONSTRAINT [FK_Target_Project] FOREIGN KEY([IdTarget])
REFERENCES [dbo].[KPI_M_Project] ([IdProject])
GO
ALTER TABLE [dbo].[KPI_T_Target] CHECK CONSTRAINT [FK_Target_Project]
GO
/****** Object:  StoredProcedure [dbo].[SP_CHECK_EMAIL]    Script Date: 10/27/2020 4:01:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_CHECK_EMAIL]
@email NVARCHAR(MAX)
AS
BEGIN
	SELECT * FROM KPI_M_User WHERE Email=@email
END
GO
/****** Object:  StoredProcedure [dbo].[SP_CREATE_CODE]    Script Date: 10/27/2020 4:01:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_CREATE_CODE]
@email NVARCHAR(MAX),
@code NVARCHAR(MAX),
@timeForget DATETIME
AS
BEGIN
	UPDATE KPI_M_User
	SET Token=@code, TimeForget=@timeForget
	WHERE Email=@email
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_LOCK_USER]    Script Date: 10/27/2020 4:01:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_GET_LOCK_USER]
@Username NVARCHAR(50)
AS
BEGIN
	SELECT LoginFail FROM KPI_M_User WHERE Username=@Username
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_USER]    Script Date: 10/27/2020 4:01:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_GET_USER]
@password NVARCHAR(50),
@username NVARCHAR(50)
AS
BEGIN
	DECLARE @passwordMd5 NVARCHAR(50)
	SET @passwordMd5=CONVERT(VARCHAR(32), HashBytes('MD5', @password), 2)
	SELECT * FROM KPI_M_User JOIN KPI_M_Role ON KPI_M_User.IdRole=KPI_M_Role.IdRole WHERE KPI_M_User.Password=@passwordMd5 AND KPI_M_User.Username=@username
END
GO
/****** Object:  StoredProcedure [dbo].[SP_UPDATE_LOCK_USER]    Script Date: 10/27/2020 4:01:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_UPDATE_LOCK_USER]
@Fail INT,
@Username NVARCHAR(50)
AS
BEGIN
	UPDATE KPI_M_User
	SET LoginFail=@Fail
	WHERE Username=@Username
END
GO
USE [master]
GO
ALTER DATABASE [KPI] SET  READ_WRITE 
GO
