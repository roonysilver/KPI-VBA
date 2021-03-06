USE [master]
GO
/****** Object:  Database [KPI]    Script Date: 12/30/2020 8:42:36 AM ******/
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
/****** Object:  User [user]    Script Date: 12/30/2020 8:42:36 AM ******/
CREATE USER [user] FOR LOGIN [user] WITH DEFAULT_SCHEMA=[db_datareader]
GO
ALTER ROLE [db_datareader] ADD MEMBER [user]
GO
/****** Object:  UserDefinedFunction [dbo].[AUTO_BRY]    Script Date: 12/30/2020 8:42:36 AM ******/
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
/****** Object:  Table [dbo].[KPI_M_Department]    Script Date: 12/30/2020 8:42:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KPI_M_Department](
	[IdDerpartment] [int] NOT NULL,
	[NameDepartment] [nvarchar](200) NOT NULL,
	[CreateBy] [nvarchar](50) NULL,
	[UpdateBy] [nvarchar](50) NULL,
	[CreateAt] [datetime] NULL,
	[UpdateAt] [datetime] NULL,
 CONSTRAINT [PK_KPI_M_Department] PRIMARY KEY CLUSTERED 
(
	[IdDerpartment] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KPI_M_ErrorType]    Script Date: 12/30/2020 8:42:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KPI_M_ErrorType](
	[IdErrorType] [int] IDENTITY(1,1) NOT NULL,
	[NameErrorType] [nvarchar](500) NULL,
	[CreateAt] [datetime] NULL,
	[CreateBy] [nvarchar](50) NULL,
	[UpdateAt] [datetime] NULL,
	[UpdateBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_KPI_T_Error] PRIMARY KEY CLUSTERED 
(
	[IdErrorType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KPI_M_Level]    Script Date: 12/30/2020 8:42:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KPI_M_Level](
	[IdLevel] [int] IDENTITY(1,1) NOT NULL,
	[Level] [nvarchar](50) NULL,
	[LevelJP] [nvarchar](50) NULL,
 CONSTRAINT [PK_Level] PRIMARY KEY CLUSTERED 
(
	[IdLevel] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KPI_M_Phase]    Script Date: 12/30/2020 8:42:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KPI_M_Phase](
	[IdPhase] [int] IDENTITY(1,1) NOT NULL,
	[NamePhase] [nvarchar](250) NULL,
	[NamePhaseJP] [nvarchar](250) NULL,
	[Target] [nvarchar](250) NULL,
	[TargetJP] [nvarchar](250) NULL,
 CONSTRAINT [PK_Phase] PRIMARY KEY CLUSTERED 
(
	[IdPhase] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KPI_M_Project]    Script Date: 12/30/2020 8:42:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KPI_M_Project](
	[IdProject] [int] IDENTITY(1,1) NOT NULL,
	[NameProject] [nvarchar](50) NULL,
	[Description] [nvarchar](max) NULL,
	[CreateAt] [datetime] NULL,
	[UpdateAt] [datetime] NULL,
	[Deleted] [int] NOT NULL,
	[IdDepartment] [int] NULL,
	[CreateBy] [nvarchar](50) NULL,
	[UpdateBy] [nvarchar](50) NULL,
	[ExpriedDate] [datetime] NULL,
 CONSTRAINT [PK_Project] PRIMARY KEY CLUSTERED 
(
	[IdProject] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KPI_M_Role]    Script Date: 12/30/2020 8:42:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KPI_M_Role](
	[IdRole] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[IdRole] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KPI_M_User]    Script Date: 12/30/2020 8:42:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KPI_M_User](
	[IdUser] [nchar](6) NOT NULL,
	[Username] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](50) NULL,
	[IdRole] [int] NOT NULL,
	[FirstName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL,
	[Dob] [date] NULL,
	[Address] [nvarchar](250) NULL,
	[Phone] [nvarchar](50) NULL,
	[Email] [nvarchar](100) NOT NULL,
	[Token] [nvarchar](max) NULL,
	[TimeForget] [datetime] NULL,
	[LoginFail] [int] NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[IdUser] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KPI_T_Error]    Script Date: 12/30/2020 8:42:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KPI_T_Error](
	[IdError] [int] IDENTITY(1,1) NOT NULL,
	[NameError] [nvarchar](500) NULL,
	[NameErrorJP] [nvarchar](500) NULL,
	[Note] [nvarchar](max) NULL,
	[CreateAt] [datetime] NULL,
	[CreateBy] [nvarchar](50) NULL,
	[UpdateAt] [datetime] NULL,
	[UpdateBy] [nvarchar](50) NULL,
	[IdErrorType] [int] NULL,
 CONSTRAINT [PK_errorKind] PRIMARY KEY CLUSTERED 
(
	[IdError] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KPI_T_ErrorAnalysis]    Script Date: 12/30/2020 8:42:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KPI_T_ErrorAnalysis](
	[Bug] [int] NULL,
	[Reference] [nvarchar](max) NULL,
	[IdErrorAnalysis] [int] IDENTITY(1,1) NOT NULL,
	[Deleted] [int] NOT NULL,
	[CreateAt] [datetime] NULL,
	[UpdateAt] [datetime] NULL,
	[CreateBy] [nvarchar](50) NULL,
	[UpdateBy] [nvarchar](50) NULL,
	[IdError] [int] NULL,
	[IdQualityAnalysis] [int] NULL,
 CONSTRAINT [PK_ContentErrorType] PRIMARY KEY CLUSTERED 
(
	[IdErrorAnalysis] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KPI_T_ProjectUser]    Script Date: 12/30/2020 8:42:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KPI_T_ProjectUser](
	[IdProjectUser] [int] IDENTITY(1,1) NOT NULL,
	[idUser] [nchar](6) NOT NULL,
	[IdProject] [int] NOT NULL,
	[CreateAt] [datetime] NULL,
	[UpdateAt] [datetime] NULL,
	[CreateBy] [nvarchar](50) NULL,
	[UpdateBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_ProjectUser] PRIMARY KEY CLUSTERED 
(
	[IdProjectUser] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KPI_T_QualityAnalysis]    Script Date: 12/30/2020 8:42:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KPI_T_QualityAnalysis](
	[IdQualityAnalysis] [int] IDENTITY(1,1) NOT NULL,
	[Hour] [float] NULL,
	[IdPhase] [int] NULL,
	[CreateAt] [datetime] NULL,
	[UpdateAt] [datetime] NULL,
	[CreateBy] [nvarchar](50) NULL,
	[UpdateBy] [nvarchar](50) NULL,
	[IdTask] [int] NULL,
 CONSTRAINT [PK_KPI_T_QualityAnalysis] PRIMARY KEY CLUSTERED 
(
	[IdQualityAnalysis] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KPI_T_Task]    Script Date: 12/30/2020 8:42:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KPI_T_Task](
	[IdTask] [int] IDENTITY(1,1) NOT NULL,
	[Content] [nvarchar](500) NULL,
	[Deleted] [int] NOT NULL,
	[IdLevel] [int] NULL,
	[IdProject] [int] NULL,
	[CreateAt] [datetime] NULL,
	[UpdateAt] [datetime] NULL,
	[CreateBy] [nvarchar](50) NULL,
	[UpdateBy] [nvarchar](50) NULL,
	[IdUser] [nchar](6) NULL,
	[Reason] [nvarchar](max) NULL,
 CONSTRAINT [PK_Content] PRIMARY KEY CLUSTERED 
(
	[IdTask] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Status]    Script Date: 12/30/2020 8:42:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Status](
	[IdStatus] [int] NOT NULL,
	[Status] [nvarchar](50) NULL,
 CONSTRAINT [PK_Status] PRIMARY KEY CLUSTERED 
(
	[IdStatus] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[KPI_M_Department] ([IdDerpartment], [NameDepartment], [CreateBy], [UpdateBy], [CreateAt], [UpdateAt]) VALUES (1, N'DEV-BAS', NULL, NULL, NULL, NULL)
INSERT [dbo].[KPI_M_Department] ([IdDerpartment], [NameDepartment], [CreateBy], [UpdateBy], [CreateAt], [UpdateAt]) VALUES (2, N'DEV-EMS', NULL, NULL, NULL, NULL)
INSERT [dbo].[KPI_M_Department] ([IdDerpartment], [NameDepartment], [CreateBy], [UpdateBy], [CreateAt], [UpdateAt]) VALUES (3, N'BPO', NULL, NULL, NULL, NULL)
INSERT [dbo].[KPI_M_Department] ([IdDerpartment], [NameDepartment], [CreateBy], [UpdateBy], [CreateAt], [UpdateAt]) VALUES (4, N'BAO', NULL, NULL, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[KPI_M_ErrorType] ON 

INSERT [dbo].[KPI_M_ErrorType] ([IdErrorType], [NameErrorType], [CreateAt], [CreateBy], [UpdateAt], [UpdateBy]) VALUES (1, N'要求定義', NULL, NULL, NULL, NULL)
INSERT [dbo].[KPI_M_ErrorType] ([IdErrorType], [NameErrorType], [CreateAt], [CreateBy], [UpdateAt], [UpdateBy]) VALUES (2, N'設計', NULL, NULL, NULL, NULL)
INSERT [dbo].[KPI_M_ErrorType] ([IdErrorType], [NameErrorType], [CreateAt], [CreateBy], [UpdateAt], [UpdateBy]) VALUES (3, N'製造', NULL, NULL, NULL, NULL)
INSERT [dbo].[KPI_M_ErrorType] ([IdErrorType], [NameErrorType], [CreateAt], [CreateBy], [UpdateAt], [UpdateBy]) VALUES (4, N'テスト、受入', NULL, NULL, NULL, NULL)
INSERT [dbo].[KPI_M_ErrorType] ([IdErrorType], [NameErrorType], [CreateAt], [CreateBy], [UpdateAt], [UpdateBy]) VALUES (5, N'調査', NULL, NULL, NULL, NULL)
INSERT [dbo].[KPI_M_ErrorType] ([IdErrorType], [NameErrorType], [CreateAt], [CreateBy], [UpdateAt], [UpdateBy]) VALUES (6, N'日本側説明不足', NULL, NULL, NULL, NULL)
INSERT [dbo].[KPI_M_ErrorType] ([IdErrorType], [NameErrorType], [CreateAt], [CreateBy], [UpdateAt], [UpdateBy]) VALUES (7, N'その他', NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[KPI_M_ErrorType] OFF
GO
SET IDENTITY_INSERT [dbo].[KPI_M_Level] ON 

INSERT [dbo].[KPI_M_Level] ([IdLevel], [Level], [LevelJP]) VALUES (1, N'Dễ', N'高         ')
INSERT [dbo].[KPI_M_Level] ([IdLevel], [Level], [LevelJP]) VALUES (2, N'Vừa', N'中         ')
INSERT [dbo].[KPI_M_Level] ([IdLevel], [Level], [LevelJP]) VALUES (3, N'Khó', N'低         ')
SET IDENTITY_INSERT [dbo].[KPI_M_Level] OFF
GO
SET IDENTITY_INSERT [dbo].[KPI_M_Phase] ON 

INSERT [dbo].[KPI_M_Phase] ([IdPhase], [NamePhase], [NamePhaseJP], [Target], [TargetJP]) VALUES (1, N'Thiết kế', N'設計', N'Tỉ lệ lỗi trên số công thiết kế', N'設計工数に対する指摘率')
INSERT [dbo].[KPI_M_Phase] ([IdPhase], [NamePhase], [NamePhaseJP], [Target], [TargetJP]) VALUES (2, N'Code', N'製造', N'Tỉ lệ lỗi trên số công Code', N'製造工数に対する指摘率')
INSERT [dbo].[KPI_M_Phase] ([IdPhase], [NamePhase], [NamePhaseJP], [Target], [TargetJP]) VALUES (3, N'Test', N'テスト', N'Tỉ lệ lỗi khi Test', N'テスト時のバグヒット率')
INSERT [dbo].[KPI_M_Phase] ([IdPhase], [NamePhase], [NamePhaseJP], [Target], [TargetJP]) VALUES (4, N'Chấp nhận ở BRC', N'BRC内部受入', N'Tỉ lệ lỗi trên số công từ khi thiết kế ~ Test', N'設計～テストまでの工数に対する指摘率')
INSERT [dbo].[KPI_M_Phase] ([IdPhase], [NamePhase], [NamePhaseJP], [Target], [TargetJP]) VALUES (5, N'Chấp nhận bởi khách hàng OSC', N'OSC様受入', N'Tỉ lệ lỗi trên số công từ khi thiết kế ~ Test', N'設計～テストまでの工数に対する指摘率')
INSERT [dbo].[KPI_M_Phase] ([IdPhase], [NamePhase], [NamePhaseJP], [Target], [TargetJP]) VALUES (6, N'Chấp nhận ở phía nghiệp vụ ( Bao gồm sau khi release)', N'業務側受入(リリース後含む', N'Tỉ lệ lỗi trên số công từ khi thiết kế ~ Test', N'設計～テストまでの工数に対する指摘率')
SET IDENTITY_INSERT [dbo].[KPI_M_Phase] OFF
GO
SET IDENTITY_INSERT [dbo].[KPI_M_Project] ON 

INSERT [dbo].[KPI_M_Project] ([IdProject], [NameProject], [Description], [CreateAt], [UpdateAt], [Deleted], [IdDepartment], [CreateBy], [UpdateBy], [ExpriedDate]) VALUES (1, N'KPI', N'Dự án KPI', CAST(N'2020-10-30T00:00:00.000' AS DateTime), CAST(N'2020-12-29T09:48:05.267' AS DateTime), 0, 2, NULL, N'BRY016', NULL)
INSERT [dbo].[KPI_M_Project] ([IdProject], [NameProject], [Description], [CreateAt], [UpdateAt], [Deleted], [IdDepartment], [CreateBy], [UpdateBy], [ExpriedDate]) VALUES (1091, N'サクラーきもち', NULL, CAST(N'2020-12-22T14:29:11.540' AS DateTime), NULL, 0, 2, N'BRY016', NULL, NULL)
INSERT [dbo].[KPI_M_Project] ([IdProject], [NameProject], [Description], [CreateAt], [UpdateAt], [Deleted], [IdDepartment], [CreateBy], [UpdateBy], [ExpriedDate]) VALUES (1101, N'HRM', NULL, CAST(N'2020-12-28T10:43:24.820' AS DateTime), NULL, 1, 1, N'BRY016', NULL, NULL)
INSERT [dbo].[KPI_M_Project] ([IdProject], [NameProject], [Description], [CreateAt], [UpdateAt], [Deleted], [IdDepartment], [CreateBy], [UpdateBy], [ExpriedDate]) VALUES (1102, N'TODO', NULL, CAST(N'2020-12-28T10:51:42.310' AS DateTime), NULL, 1, 2, N'BRY016', NULL, NULL)
INSERT [dbo].[KPI_M_Project] ([IdProject], [NameProject], [Description], [CreateAt], [UpdateAt], [Deleted], [IdDepartment], [CreateBy], [UpdateBy], [ExpriedDate]) VALUES (1103, N'TODO', NULL, CAST(N'2020-12-28T11:24:17.867' AS DateTime), NULL, 1, 2, N'BRY016', NULL, NULL)
INSERT [dbo].[KPI_M_Project] ([IdProject], [NameProject], [Description], [CreateAt], [UpdateAt], [Deleted], [IdDepartment], [CreateBy], [UpdateBy], [ExpriedDate]) VALUES (1104, N'TODO', NULL, CAST(N'2020-12-28T11:27:33.450' AS DateTime), NULL, 1, 2, N'BRY016', NULL, NULL)
INSERT [dbo].[KPI_M_Project] ([IdProject], [NameProject], [Description], [CreateAt], [UpdateAt], [Deleted], [IdDepartment], [CreateBy], [UpdateBy], [ExpriedDate]) VALUES (1105, N'TODO', NULL, CAST(N'2020-12-28T11:32:21.923' AS DateTime), NULL, 1, 1, N'BRY016', NULL, NULL)
INSERT [dbo].[KPI_M_Project] ([IdProject], [NameProject], [Description], [CreateAt], [UpdateAt], [Deleted], [IdDepartment], [CreateBy], [UpdateBy], [ExpriedDate]) VALUES (1106, N'TODO', NULL, CAST(N'2020-12-29T08:30:55.887' AS DateTime), NULL, 1, 1, N'BRY016', NULL, NULL)
INSERT [dbo].[KPI_M_Project] ([IdProject], [NameProject], [Description], [CreateAt], [UpdateAt], [Deleted], [IdDepartment], [CreateBy], [UpdateBy], [ExpriedDate]) VALUES (1107, N'TODO', NULL, CAST(N'2020-12-29T08:31:59.797' AS DateTime), NULL, 1, 2, N'BRY016', NULL, NULL)
INSERT [dbo].[KPI_M_Project] ([IdProject], [NameProject], [Description], [CreateAt], [UpdateAt], [Deleted], [IdDepartment], [CreateBy], [UpdateBy], [ExpriedDate]) VALUES (1108, N'HRM11', NULL, CAST(N'2020-12-29T09:40:02.900' AS DateTime), NULL, 1, 1, N'BRY016', NULL, NULL)
INSERT [dbo].[KPI_M_Project] ([IdProject], [NameProject], [Description], [CreateAt], [UpdateAt], [Deleted], [IdDepartment], [CreateBy], [UpdateBy], [ExpriedDate]) VALUES (1109, N'HRM11', NULL, CAST(N'2020-12-29T17:11:06.420' AS DateTime), CAST(N'2020-12-29T17:11:15.007' AS DateTime), 1, 1, N'BRY016', N'BRY016', NULL)
SET IDENTITY_INSERT [dbo].[KPI_M_Project] OFF
GO
SET IDENTITY_INSERT [dbo].[KPI_M_Role] ON 

INSERT [dbo].[KPI_M_Role] ([IdRole], [Name]) VALUES (1, N'Admin')
INSERT [dbo].[KPI_M_Role] ([IdRole], [Name]) VALUES (2, N'Manager')
INSERT [dbo].[KPI_M_Role] ([IdRole], [Name]) VALUES (3, N'Leader')
INSERT [dbo].[KPI_M_Role] ([IdRole], [Name]) VALUES (4, N'User')
SET IDENTITY_INSERT [dbo].[KPI_M_Role] OFF
GO
INSERT [dbo].[KPI_M_User] ([IdUser], [Username], [Password], [IdRole], [FirstName], [LastName], [Dob], [Address], [Phone], [Email], [Token], [TimeForget], [LoginFail]) VALUES (N'BRY001', N'Leader1', N'CE0BFD15059B68D67688884D7A3D3E8C', 3, N'Leader', N'1', CAST(N'2020-11-11' AS Date), N'Vạn Xuân', N'123156789  ', N'lq_don@brycen.com.vn', N'5f12777d-7cfa-4d0c-b652-703f90626157', CAST(N'2020-12-21T13:26:03.320' AS DateTime), 0)
INSERT [dbo].[KPI_M_User] ([IdUser], [Username], [Password], [IdRole], [FirstName], [LastName], [Dob], [Address], [Phone], [Email], [Token], [TimeForget], [LoginFail]) VALUES (N'BRY002', N'User1', N'CE0BFD15059B68D67688884D7A3D3E8C', 4, N'User', N'1', CAST(N'2020-10-10' AS Date), N'Hùng Vương', N'0906424280 ', N'tc_son@brycen.com.vn', N'ea3fd509-cada-4ae9-bae7-aa3d81476116', CAST(N'2020-11-27T08:41:33.430' AS DateTime), 0)
INSERT [dbo].[KPI_M_User] ([IdUser], [Username], [Password], [IdRole], [FirstName], [LastName], [Dob], [Address], [Phone], [Email], [Token], [TimeForget], [LoginFail]) VALUES (N'BRY003', N'Admin', N'CE0BFD15059B68D67688884D7A3D3E8C', 1, N'Admin', N'', CAST(N'1998-01-01' AS Date), N'Trần Phú', N'0339159882', N'donle2044@gmail.com', N'703764d1-12c0-4a1f-badd-e736f547a62e', CAST(N'2020-11-26T15:20:14.000' AS DateTime), 0)
INSERT [dbo].[KPI_M_User] ([IdUser], [Username], [Password], [IdRole], [FirstName], [LastName], [Dob], [Address], [Phone], [Email], [Token], [TimeForget], [LoginFail]) VALUES (N'BRY005', N'Leader2', N'CE0BFD15059B68D67688884D7A3D3E8C', 3, N'Leader', N'2', CAST(N'1997-12-01' AS Date), N'Huế', N'0382587564', N'nt_linh@brycen.com.vn', N'd451ff2b-9e9d-4bdd-8379-96eda5aea3d6', CAST(N'2020-12-25T15:41:51.000' AS DateTime), 0)
INSERT [dbo].[KPI_M_User] ([IdUser], [Username], [Password], [IdRole], [FirstName], [LastName], [Dob], [Address], [Phone], [Email], [Token], [TimeForget], [LoginFail]) VALUES (N'BRY006', N'User2', N'CE0BFD15059B68D67688884D7A3D3E8C', 4, N'User', N'2', CAST(N'1997-01-01' AS Date), N'Trần Phú', N'0339159882', N'lq_don@brycen.com.vn', N'5f12777d-7cfa-4d0c-b652-703f90626157', CAST(N'2020-12-21T13:26:03.320' AS DateTime), 0)
INSERT [dbo].[KPI_M_User] ([IdUser], [Username], [Password], [IdRole], [FirstName], [LastName], [Dob], [Address], [Phone], [Email], [Token], [TimeForget], [LoginFail]) VALUES (N'BRY007', N'User3', N'CE0BFD15059B68D67688884D7A3D3E8C', 4, N'User', N'3', CAST(N'1997-01-01' AS Date), N'Trần Phú', N'0339159882', N'lq_don@brycen.com.vn', N'5f12777d-7cfa-4d0c-b652-703f90626157', CAST(N'2020-12-21T13:26:03.320' AS DateTime), 1)
INSERT [dbo].[KPI_M_User] ([IdUser], [Username], [Password], [IdRole], [FirstName], [LastName], [Dob], [Address], [Phone], [Email], [Token], [TimeForget], [LoginFail]) VALUES (N'BRY008', N'User4', N'CE0BFD15059B68D67688884D7A3D3E8C', 4, N'User', N'4', CAST(N'1997-01-01' AS Date), N'Trần Phú', N'0339159882', N'lq_don@brycen.com.vn', N'5f12777d-7cfa-4d0c-b652-703f90626157', CAST(N'2020-12-21T13:26:03.320' AS DateTime), 0)
INSERT [dbo].[KPI_M_User] ([IdUser], [Username], [Password], [IdRole], [FirstName], [LastName], [Dob], [Address], [Phone], [Email], [Token], [TimeForget], [LoginFail]) VALUES (N'BRY009', N'User5', N'CE0BFD15059B68D67688884D7A3D3E8C', 4, N'User', N'5', CAST(N'1988-09-10' AS Date), N'Huế', N'0235264784', N'ld_hiep@brycen.com.vn', NULL, CAST(N'1900-01-02T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[KPI_M_User] ([IdUser], [Username], [Password], [IdRole], [FirstName], [LastName], [Dob], [Address], [Phone], [Email], [Token], [TimeForget], [LoginFail]) VALUES (N'BRY010', N'User6', N'CE0BFD15059B68D67688884D7A3D3E8C', 4, N'User', N'6', CAST(N'1999-12-12' AS Date), N'Huế', N'0354152456', N'abc@brycen.com.vn', NULL, CAST(N'1900-01-02T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[KPI_M_User] ([IdUser], [Username], [Password], [IdRole], [FirstName], [LastName], [Dob], [Address], [Phone], [Email], [Token], [TimeForget], [LoginFail]) VALUES (N'BRY011', N'User7', N'CE0BFD15059B68D67688884D7A3D3E8C', 4, N'User', N'7', CAST(N'1998-09-09' AS Date), N'Quảng Nam', NULL, N'abc@brycen.com.vn', NULL, CAST(N'1900-01-02T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[KPI_M_User] ([IdUser], [Username], [Password], [IdRole], [FirstName], [LastName], [Dob], [Address], [Phone], [Email], [Token], [TimeForget], [LoginFail]) VALUES (N'BRY012', N'User8', N'CE0BFD15059B68D67688884D7A3D3E8C', 4, N'User', N'8', CAST(N'1998-09-09' AS Date), N'Quảng Trị', NULL, N'abc@brycen.com.vn', NULL, CAST(N'1900-01-02T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[KPI_M_User] ([IdUser], [Username], [Password], [IdRole], [FirstName], [LastName], [Dob], [Address], [Phone], [Email], [Token], [TimeForget], [LoginFail]) VALUES (N'BRY013', N'User9', N'CE0BFD15059B68D67688884D7A3D3E8C', 4, N'User', N'9', CAST(N'1998-12-12' AS Date), N'Huế', NULL, N'abc@brycen.com.vn', NULL, CAST(N'1900-01-02T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[KPI_M_User] ([IdUser], [Username], [Password], [IdRole], [FirstName], [LastName], [Dob], [Address], [Phone], [Email], [Token], [TimeForget], [LoginFail]) VALUES (N'BRY016', N'Manager', N'CE0BFD15059B68D67688884D7A3D3E8C', 2, N'Manager', N'', NULL, N'Quảng Bình', NULL, N'bac@brycen.com.vn', NULL, CAST(N'1900-01-02T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[KPI_M_User] ([IdUser], [Username], [Password], [IdRole], [FirstName], [LastName], [Dob], [Address], [Phone], [Email], [Token], [TimeForget], [LoginFail]) VALUES (N'BRY017', N'Admin2', N'CE0BFD15059B68D67688884D7A3D3E8C', 1, N'Admin', N'2', NULL, NULL, NULL, N'bac@brycen.com.vn', NULL, CAST(N'1900-01-02T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[KPI_M_User] ([IdUser], [Username], [Password], [IdRole], [FirstName], [LastName], [Dob], [Address], [Phone], [Email], [Token], [TimeForget], [LoginFail]) VALUES (N'BRY018', N'Leader3', N'CE0BFD15059B68D67688884D7A3D3E8C', 3, N'Leader', N'3', NULL, NULL, NULL, N'bac@brycen.com.vn', NULL, CAST(N'1900-01-02T00:00:00.000' AS DateTime), 0)
GO
SET IDENTITY_INSERT [dbo].[KPI_T_Error] ON 

INSERT [dbo].[KPI_T_Error] ([IdError], [NameError], [NameErrorJP], [Note], [CreateAt], [CreateBy], [UpdateAt], [UpdateBy], [IdErrorType]) VALUES (1, N'Bỏ sót định nghĩa yêu cầu', N'要求定義漏れ', NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[KPI_T_Error] ([IdError], [NameError], [NameErrorJP], [Note], [CreateAt], [CreateBy], [UpdateAt], [UpdateBy], [IdErrorType]) VALUES (2, N'Không hiểu rõ yêu cầu', N'要求理解不足', NULL, NULL, NULL, NULL, NULL, 2)
INSERT [dbo].[KPI_T_Error] ([IdError], [NameError], [NameErrorJP], [Note], [CreateAt], [CreateBy], [UpdateAt], [UpdateBy], [IdErrorType]) VALUES (3, N'Thiếu sự thảo luận về những thông số kĩ thuật (Thiếu sự thảo luận của các trường hợp bên nghiệp vụ)', N'仕様検討不足（業務ケースの検討不足）', NULL, NULL, NULL, NULL, NULL, 2)
INSERT [dbo].[KPI_T_Error] ([IdError], [NameError], [NameErrorJP], [Note], [CreateAt], [CreateBy], [UpdateAt], [UpdateBy], [IdErrorType]) VALUES (4, N'Thiếu sự thảo luận về những thông số kĩ thuật (Thiếu sự thảo luận chi tiết)', N'仕様検討不足（詳細の検討不足）', NULL, NULL, NULL, NULL, NULL, 2)
INSERT [dbo].[KPI_T_Error] ([IdError], [NameError], [NameErrorJP], [Note], [CreateAt], [CreateBy], [UpdateAt], [UpdateBy], [IdErrorType]) VALUES (5, N'Thiếu sự thảo luận về những thông số kĩ thuật (Thiếu sự thảo luận về phạm vi ảnh hưởng)', N'仕様検討不足（影響範囲の検討不足）', NULL, NULL, NULL, NULL, NULL, 2)
INSERT [dbo].[KPI_T_Error] ([IdError], [NameError], [NameErrorJP], [Note], [CreateAt], [CreateBy], [UpdateAt], [UpdateBy], [IdErrorType]) VALUES (6, N'Thiếu sự thảo luận về những thông số kĩ thuật (Thiếu sự biết về nghiệp vụ)', N'仕様検討不足（業務の理解不足）', NULL, NULL, NULL, NULL, NULL, 2)
INSERT [dbo].[KPI_T_Error] ([IdError], [NameError], [NameErrorJP], [Note], [CreateAt], [CreateBy], [UpdateAt], [UpdateBy], [IdErrorType]) VALUES (7, N'Thiếu sự thảo luận về những thông số kĩ thuật (Thiếu sự biết trong hệ thống)', N'仕様検討不足（システム内部の理解不足）', NULL, NULL, NULL, NULL, NULL, 2)
INSERT [dbo].[KPI_T_Error] ([IdError], [NameError], [NameErrorJP], [Note], [CreateAt], [CreateBy], [UpdateAt], [UpdateBy], [IdErrorType]) VALUES (8, N'Thiếu sự thảo luận về những thông số kĩ thuật (Khác)', N'仕様検討不足（その他）', NULL, NULL, NULL, NULL, NULL, 2)
INSERT [dbo].[KPI_T_Error] ([IdError], [NameError], [NameErrorJP], [Note], [CreateAt], [CreateBy], [UpdateAt], [UpdateBy], [IdErrorType]) VALUES (9, N'Lỗi đánh máy ・Bố cục', N'誤字脱字・体裁', NULL, NULL, NULL, NULL, NULL, 2)
INSERT [dbo].[KPI_T_Error] ([IdError], [NameError], [NameErrorJP], [Note], [CreateAt], [CreateBy], [UpdateAt], [UpdateBy], [IdErrorType]) VALUES (10, N'Lỗi coding (Không theo thông số kĩ thuật ［Sai thông số kĩ thuật］', N'コーディングミス（仕様通りでない［仕様誤認］）', NULL, NULL, NULL, NULL, NULL, 3)
INSERT [dbo].[KPI_T_Error] ([IdError], [NameError], [NameErrorJP], [Note], [CreateAt], [CreateBy], [UpdateAt], [UpdateBy], [IdErrorType]) VALUES (11, N'Lỗi coding (Không theo thông số kĩ thuật ［Thiếu sự hiểu rõ về thông số kĩ thuật］', N'コーディングミス（仕様通りでない［仕様理解不足］）', NULL, NULL, NULL, NULL, NULL, 3)
INSERT [dbo].[KPI_T_Error] ([IdError], [NameError], [NameErrorJP], [Note], [CreateAt], [CreateBy], [UpdateAt], [UpdateBy], [IdErrorType]) VALUES (12, N'Lỗi coding (Thiếu sự hiểu rõ về cấu trúc của bảng)', N'コーディングミス（テーブル構成理解不足）', NULL, NULL, NULL, NULL, NULL, 3)
INSERT [dbo].[KPI_T_Error] ([IdError], [NameError], [NameErrorJP], [Note], [CreateAt], [CreateBy], [UpdateAt], [UpdateBy], [IdErrorType]) VALUES (13, N'Lỗi coding (Thiếu sự hiểu rõ về cách nắm dữ liệu)', N'コーディングミス（データの持ち方理解不足）', NULL, NULL, NULL, NULL, NULL, 3)
INSERT [dbo].[KPI_T_Error] ([IdError], [NameError], [NameErrorJP], [Note], [CreateAt], [CreateBy], [UpdateAt], [UpdateBy], [IdErrorType]) VALUES (14, N'Lỗi coding (Thiếu xác nhận phạm vi ảnh hưởng)', N'コーディングミス（影響範囲の確認不足）', NULL, NULL, NULL, NULL, NULL, 3)
INSERT [dbo].[KPI_T_Error] ([IdError], [NameError], [NameErrorJP], [Note], [CreateAt], [CreateBy], [UpdateAt], [UpdateBy], [IdErrorType]) VALUES (15, N'Lỗi coding (Không tuân theo những quy tắc)', N'コーディングミス（規約準拠していない）', NULL, NULL, NULL, NULL, NULL, 3)
INSERT [dbo].[KPI_T_Error] ([IdError], [NameError], [NameErrorJP], [Note], [CreateAt], [CreateBy], [UpdateAt], [UpdateBy], [IdErrorType]) VALUES (16, N'Lỗi coding (Không phải là mô tả chung )', N'コーディングミス（一般的な記述でない）', NULL, NULL, NULL, NULL, NULL, 3)
INSERT [dbo].[KPI_T_Error] ([IdError], [NameError], [NameErrorJP], [Note], [CreateAt], [CreateBy], [UpdateAt], [UpdateBy], [IdErrorType]) VALUES (17, N'Lỗi coding (Thiếu Error handling )', N'コーディングミス（エラーハンドリング不足）', NULL, NULL, NULL, NULL, NULL, 3)
INSERT [dbo].[KPI_T_Error] ([IdError], [NameError], [NameErrorJP], [Note], [CreateAt], [CreateBy], [UpdateAt], [UpdateBy], [IdErrorType]) VALUES (18, N'Lỗi coding (Không sử dụng hàm số chung )', N'コーディングミス（共通関数　非使用）', NULL, NULL, NULL, NULL, NULL, 3)
INSERT [dbo].[KPI_T_Error] ([IdError], [NameError], [NameErrorJP], [Note], [CreateAt], [CreateBy], [UpdateAt], [UpdateBy], [IdErrorType]) VALUES (19, N'Lỗi coding (Khả năng bảo trì thấp )', N'コーディングミス（保守性　低い）', NULL, NULL, NULL, NULL, NULL, 3)
INSERT [dbo].[KPI_T_Error] ([IdError], [NameError], [NameErrorJP], [Note], [CreateAt], [CreateBy], [UpdateAt], [UpdateBy], [IdErrorType]) VALUES (20, N'Lỗi coding (Thiếu comment ・comment tiếng Anh )', N'コーディングミス（コメント不足・コメント英語）', NULL, NULL, NULL, NULL, NULL, 3)
INSERT [dbo].[KPI_T_Error] ([IdError], [NameError], [NameErrorJP], [Note], [CreateAt], [CreateBy], [UpdateAt], [UpdateBy], [IdErrorType]) VALUES (21, N'Lỗi coding (Khác )', N'コーディングミス（その他）', NULL, NULL, NULL, NULL, NULL, 3)
INSERT [dbo].[KPI_T_Error] ([IdError], [NameError], [NameErrorJP], [Note], [CreateAt], [CreateBy], [UpdateAt], [UpdateBy], [IdErrorType]) VALUES (22, N'Thiếu hạng mục test ( Thiếu case công việc ) ', N'試験項目不足（業務ケースの不足）', NULL, NULL, NULL, NULL, NULL, 4)
INSERT [dbo].[KPI_T_Error] ([IdError], [NameError], [NameErrorJP], [Note], [CreateAt], [CreateBy], [UpdateAt], [UpdateBy], [IdErrorType]) VALUES (23, N'Thiếu hạng mục test ( Thiếu case chi tiết) ', N'試験項目不足（詳細ケースの不足）', NULL, NULL, NULL, NULL, NULL, 4)
INSERT [dbo].[KPI_T_Error] ([IdError], [NameError], [NameErrorJP], [Note], [CreateAt], [CreateBy], [UpdateAt], [UpdateBy], [IdErrorType]) VALUES (24, N'Thiếu hạng mục test ( Thiếu Data pattern) ', N'試験項目不足（データパターンの不足）', NULL, NULL, NULL, NULL, NULL, 4)
INSERT [dbo].[KPI_T_Error] ([IdError], [NameError], [NameErrorJP], [Note], [CreateAt], [CreateBy], [UpdateAt], [UpdateBy], [IdErrorType]) VALUES (25, N'Thiếu hạng mục test ( Thiếu kiểm tra phạm vi ảnh hưởng) ', N'試験項目不足（影響範囲の確認不足）', NULL, NULL, NULL, NULL, NULL, 4)
INSERT [dbo].[KPI_T_Error] ([IdError], [NameError], [NameErrorJP], [Note], [CreateAt], [CreateBy], [UpdateAt], [UpdateBy], [IdErrorType]) VALUES (26, N'Thiếu hạng mục test (Khác) ', N'試験項目不足（その他）', NULL, NULL, NULL, NULL, NULL, 4)
INSERT [dbo].[KPI_T_Error] ([IdError], [NameError], [NameErrorJP], [Note], [CreateAt], [CreateBy], [UpdateAt], [UpdateBy], [IdErrorType]) VALUES (27, N'Nội dung test sai', N'試験内容誤り', NULL, NULL, NULL, NULL, NULL, 4)
INSERT [dbo].[KPI_T_Error] ([IdError], [NameError], [NameErrorJP], [Note], [CreateAt], [CreateBy], [UpdateAt], [UpdateBy], [IdErrorType]) VALUES (28, N'Nội dung test không cụ thể', N'試験内容具体的ではない', NULL, NULL, NULL, NULL, NULL, 4)
INSERT [dbo].[KPI_T_Error] ([IdError], [NameError], [NameErrorJP], [Note], [CreateAt], [CreateBy], [UpdateAt], [UpdateBy], [IdErrorType]) VALUES (29, N' Lỗi đánh máy ・Bố cục', N'誤字脱字・体裁 ', NULL, NULL, NULL, NULL, NULL, 4)
INSERT [dbo].[KPI_T_Error] ([IdError], [NameError], [NameErrorJP], [Note], [CreateAt], [CreateBy], [UpdateAt], [UpdateBy], [IdErrorType]) VALUES (30, N'Thiếu sự hiểu biết về nội dung điều tra', N'調査内容理解不足', NULL, NULL, NULL, NULL, NULL, 5)
INSERT [dbo].[KPI_T_Error] ([IdError], [NameError], [NameErrorJP], [Note], [CreateAt], [CreateBy], [UpdateAt], [UpdateBy], [IdErrorType]) VALUES (31, N'Thiếu sự thảo luận về nội dung điều tra', N'調査内容検討不足', NULL, NULL, NULL, NULL, NULL, 5)
INSERT [dbo].[KPI_T_Error] ([IdError], [NameError], [NameErrorJP], [Note], [CreateAt], [CreateBy], [UpdateAt], [UpdateBy], [IdErrorType]) VALUES (32, N' Nội dung điều tra sai', N'調査内容間違い ', NULL, NULL, NULL, NULL, NULL, 5)
INSERT [dbo].[KPI_T_Error] ([IdError], [NameError], [NameErrorJP], [Note], [CreateAt], [CreateBy], [UpdateAt], [UpdateBy], [IdErrorType]) VALUES (33, N'Thiếu sự giải thích cho phía Nhật Bản (Nghiệp vụ, hệ thống v.v)', N'日本側説明不足（業務、システム等）', NULL, NULL, NULL, NULL, NULL, 6)
INSERT [dbo].[KPI_T_Error] ([IdError], [NameError], [NameErrorJP], [Note], [CreateAt], [CreateBy], [UpdateAt], [UpdateBy], [IdErrorType]) VALUES (34, N'Thiếu sự giải thích cho phía Nhật Bản (trình tự công việc, quy định v.v)', N'日本側説明不足（作業手順、規約等）', NULL, NULL, NULL, NULL, NULL, 6)
INSERT [dbo].[KPI_T_Error] ([IdError], [NameError], [NameErrorJP], [Note], [CreateAt], [CreateBy], [UpdateAt], [UpdateBy], [IdErrorType]) VALUES (35, N'Thiếu sự giải thích cho phía nghiệp vụ (trình tự công việc, quy định v.v)', N'日本側説明不足（改修内容）', NULL, NULL, NULL, NULL, NULL, 6)
INSERT [dbo].[KPI_T_Error] ([IdError], [NameError], [NameErrorJP], [Note], [CreateAt], [CreateBy], [UpdateAt], [UpdateBy], [IdErrorType]) VALUES (36, N'Thiếu nguồn lực đối ứng', N'対応資源不足 ', NULL, NULL, NULL, NULL, NULL, 7)
SET IDENTITY_INSERT [dbo].[KPI_T_Error] OFF
GO
SET IDENTITY_INSERT [dbo].[KPI_T_ErrorAnalysis] ON 

INSERT [dbo].[KPI_T_ErrorAnalysis] ([Bug], [Reference], [IdErrorAnalysis], [Deleted], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdError], [IdQualityAnalysis]) VALUES (9, N'', 1, 0, CAST(N'2020-12-21T14:42:22.987' AS DateTime), NULL, NULL, NULL, 8, 1)
INSERT [dbo].[KPI_T_ErrorAnalysis] ([Bug], [Reference], [IdErrorAnalysis], [Deleted], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdError], [IdQualityAnalysis]) VALUES (4, N'', 2, 0, CAST(N'2020-12-21T14:42:33.517' AS DateTime), NULL, NULL, NULL, 18, 9)
INSERT [dbo].[KPI_T_ErrorAnalysis] ([Bug], [Reference], [IdErrorAnalysis], [Deleted], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdError], [IdQualityAnalysis]) VALUES (0, N'', 3, 1, CAST(N'2020-12-21T14:49:21.637' AS DateTime), NULL, NULL, NULL, 19, 1)
INSERT [dbo].[KPI_T_ErrorAnalysis] ([Bug], [Reference], [IdErrorAnalysis], [Deleted], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdError], [IdQualityAnalysis]) VALUES (0, N'', 4, 1, CAST(N'2020-12-21T14:49:53.100' AS DateTime), NULL, NULL, NULL, 19, 1)
INSERT [dbo].[KPI_T_ErrorAnalysis] ([Bug], [Reference], [IdErrorAnalysis], [Deleted], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdError], [IdQualityAnalysis]) VALUES (6, N'', 5, 0, CAST(N'2020-12-21T14:54:12.983' AS DateTime), NULL, NULL, NULL, 18, 2)
INSERT [dbo].[KPI_T_ErrorAnalysis] ([Bug], [Reference], [IdErrorAnalysis], [Deleted], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdError], [IdQualityAnalysis]) VALUES (4, N'', 6, 0, CAST(N'2020-12-25T09:58:29.840' AS DateTime), NULL, NULL, NULL, 20, 26)
INSERT [dbo].[KPI_T_ErrorAnalysis] ([Bug], [Reference], [IdErrorAnalysis], [Deleted], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdError], [IdQualityAnalysis]) VALUES (8, N'', 7, 0, CAST(N'2020-12-29T09:41:57.630' AS DateTime), NULL, NULL, NULL, 8, 3)
INSERT [dbo].[KPI_T_ErrorAnalysis] ([Bug], [Reference], [IdErrorAnalysis], [Deleted], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdError], [IdQualityAnalysis]) VALUES (7, N'', 8, 0, CAST(N'2020-12-29T09:42:34.743' AS DateTime), NULL, NULL, NULL, 32, 4)
SET IDENTITY_INSERT [dbo].[KPI_T_ErrorAnalysis] OFF
GO
SET IDENTITY_INSERT [dbo].[KPI_T_ProjectUser] ON 

INSERT [dbo].[KPI_T_ProjectUser] ([IdProjectUser], [idUser], [IdProject], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy]) VALUES (1, N'BRY016', 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[KPI_T_ProjectUser] ([IdProjectUser], [idUser], [IdProject], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy]) VALUES (2, N'BRY001', 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[KPI_T_ProjectUser] ([IdProjectUser], [idUser], [IdProject], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy]) VALUES (7, N'BRY005', 1091, NULL, NULL, NULL, NULL)
INSERT [dbo].[KPI_T_ProjectUser] ([IdProjectUser], [idUser], [IdProject], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy]) VALUES (8, N'BRY016', 1091, NULL, NULL, NULL, NULL)
INSERT [dbo].[KPI_T_ProjectUser] ([IdProjectUser], [idUser], [IdProject], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy]) VALUES (9, N'BRY007', 1091, NULL, NULL, NULL, NULL)
INSERT [dbo].[KPI_T_ProjectUser] ([IdProjectUser], [idUser], [IdProject], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy]) VALUES (10, N'BRY008', 1091, NULL, NULL, NULL, NULL)
INSERT [dbo].[KPI_T_ProjectUser] ([IdProjectUser], [idUser], [IdProject], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy]) VALUES (51, N'BRY018', 1101, NULL, NULL, NULL, NULL)
INSERT [dbo].[KPI_T_ProjectUser] ([IdProjectUser], [idUser], [IdProject], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy]) VALUES (52, N'BRY016', 1101, NULL, NULL, NULL, NULL)
INSERT [dbo].[KPI_T_ProjectUser] ([IdProjectUser], [idUser], [IdProject], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy]) VALUES (53, N'BRY009', 1101, NULL, NULL, NULL, NULL)
INSERT [dbo].[KPI_T_ProjectUser] ([IdProjectUser], [idUser], [IdProject], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy]) VALUES (58, N'BRY018', 1102, NULL, NULL, NULL, NULL)
INSERT [dbo].[KPI_T_ProjectUser] ([IdProjectUser], [idUser], [IdProject], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy]) VALUES (59, N'BRY016', 1102, NULL, NULL, NULL, NULL)
INSERT [dbo].[KPI_T_ProjectUser] ([IdProjectUser], [idUser], [IdProject], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy]) VALUES (60, N'BRY010', 1102, NULL, NULL, NULL, NULL)
INSERT [dbo].[KPI_T_ProjectUser] ([IdProjectUser], [idUser], [IdProject], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy]) VALUES (61, N'BRY018', 1103, NULL, NULL, NULL, NULL)
INSERT [dbo].[KPI_T_ProjectUser] ([IdProjectUser], [idUser], [IdProject], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy]) VALUES (62, N'BRY016', 1103, NULL, NULL, NULL, NULL)
INSERT [dbo].[KPI_T_ProjectUser] ([IdProjectUser], [idUser], [IdProject], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy]) VALUES (63, N'BRY010', 1103, NULL, NULL, NULL, NULL)
INSERT [dbo].[KPI_T_ProjectUser] ([IdProjectUser], [idUser], [IdProject], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy]) VALUES (64, N'BRY018', 1104, NULL, NULL, NULL, NULL)
INSERT [dbo].[KPI_T_ProjectUser] ([IdProjectUser], [idUser], [IdProject], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy]) VALUES (65, N'BRY016', 1104, NULL, NULL, NULL, NULL)
INSERT [dbo].[KPI_T_ProjectUser] ([IdProjectUser], [idUser], [IdProject], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy]) VALUES (66, N'BRY010', 1104, NULL, NULL, NULL, NULL)
INSERT [dbo].[KPI_T_ProjectUser] ([IdProjectUser], [idUser], [IdProject], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy]) VALUES (67, N'BRY018', 1105, NULL, NULL, NULL, NULL)
INSERT [dbo].[KPI_T_ProjectUser] ([IdProjectUser], [idUser], [IdProject], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy]) VALUES (68, N'BRY016', 1105, NULL, NULL, NULL, NULL)
INSERT [dbo].[KPI_T_ProjectUser] ([IdProjectUser], [idUser], [IdProject], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy]) VALUES (69, N'BRY010', 1105, NULL, NULL, NULL, NULL)
INSERT [dbo].[KPI_T_ProjectUser] ([IdProjectUser], [idUser], [IdProject], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy]) VALUES (72, N'BRY018', 1106, NULL, NULL, NULL, NULL)
INSERT [dbo].[KPI_T_ProjectUser] ([IdProjectUser], [idUser], [IdProject], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy]) VALUES (73, N'BRY016', 1106, NULL, NULL, NULL, NULL)
INSERT [dbo].[KPI_T_ProjectUser] ([IdProjectUser], [idUser], [IdProject], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy]) VALUES (74, N'BRY010', 1106, NULL, NULL, NULL, NULL)
INSERT [dbo].[KPI_T_ProjectUser] ([IdProjectUser], [idUser], [IdProject], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy]) VALUES (75, N'BRY018', 1107, NULL, NULL, NULL, NULL)
INSERT [dbo].[KPI_T_ProjectUser] ([IdProjectUser], [idUser], [IdProject], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy]) VALUES (76, N'BRY016', 1107, NULL, NULL, NULL, NULL)
INSERT [dbo].[KPI_T_ProjectUser] ([IdProjectUser], [idUser], [IdProject], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy]) VALUES (77, N'BRY010', 1107, NULL, NULL, NULL, NULL)
INSERT [dbo].[KPI_T_ProjectUser] ([IdProjectUser], [idUser], [IdProject], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy]) VALUES (78, N'BRY018', 1108, NULL, NULL, NULL, NULL)
INSERT [dbo].[KPI_T_ProjectUser] ([IdProjectUser], [idUser], [IdProject], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy]) VALUES (79, N'BRY016', 1108, NULL, NULL, NULL, NULL)
INSERT [dbo].[KPI_T_ProjectUser] ([IdProjectUser], [idUser], [IdProject], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy]) VALUES (80, N'BRY009', 1108, NULL, NULL, NULL, NULL)
INSERT [dbo].[KPI_T_ProjectUser] ([IdProjectUser], [idUser], [IdProject], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy]) VALUES (84, N'BRY002', 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[KPI_T_ProjectUser] ([IdProjectUser], [idUser], [IdProject], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy]) VALUES (85, N'BRY006', 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[KPI_T_ProjectUser] ([IdProjectUser], [idUser], [IdProject], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy]) VALUES (86, N'BRY009', 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[KPI_T_ProjectUser] ([IdProjectUser], [idUser], [IdProject], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy]) VALUES (87, N'BRY018', 1109, NULL, NULL, NULL, NULL)
INSERT [dbo].[KPI_T_ProjectUser] ([IdProjectUser], [idUser], [IdProject], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy]) VALUES (88, N'BRY016', 1109, NULL, NULL, NULL, NULL)
INSERT [dbo].[KPI_T_ProjectUser] ([IdProjectUser], [idUser], [IdProject], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy]) VALUES (90, N'BRY010', 1109, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[KPI_T_ProjectUser] OFF
GO
SET IDENTITY_INSERT [dbo].[KPI_T_QualityAnalysis] ON 

INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (1, 10, 1, CAST(N'2020-12-21T14:41:52.410' AS DateTime), NULL, NULL, NULL, 6)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (2, 10, 2, CAST(N'2020-12-21T14:41:52.413' AS DateTime), NULL, NULL, NULL, 6)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (3, 8, 3, CAST(N'2020-12-21T14:41:52.417' AS DateTime), NULL, NULL, NULL, 6)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (4, 16, 4, CAST(N'2020-12-21T14:41:52.417' AS DateTime), NULL, NULL, NULL, 6)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (5, 8, 5, CAST(N'2020-12-21T14:41:52.417' AS DateTime), NULL, NULL, NULL, 6)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (6, 16, 6, CAST(N'2020-12-21T14:41:52.417' AS DateTime), NULL, NULL, NULL, 6)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (7, 5, 1, CAST(N'2020-12-21T14:42:04.930' AS DateTime), NULL, NULL, NULL, 7)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (8, 11, 2, CAST(N'2020-12-21T14:42:04.930' AS DateTime), NULL, NULL, NULL, 7)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (9, 9, 3, CAST(N'2020-12-21T14:42:04.933' AS DateTime), NULL, NULL, NULL, 7)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (10, 8, 4, CAST(N'2020-12-21T14:42:04.933' AS DateTime), NULL, NULL, NULL, 7)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (11, 8, 5, CAST(N'2020-12-21T14:42:04.933' AS DateTime), NULL, NULL, NULL, 7)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (12, 8, 6, CAST(N'2020-12-21T14:42:04.933' AS DateTime), NULL, NULL, NULL, 7)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (13, 16, 1, CAST(N'2020-12-21T14:53:00.563' AS DateTime), NULL, NULL, NULL, 8)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (14, 16, 2, CAST(N'2020-12-21T14:53:00.563' AS DateTime), NULL, NULL, NULL, 8)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (15, 16, 3, CAST(N'2020-12-21T14:53:00.563' AS DateTime), NULL, NULL, NULL, 8)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (16, 8, 4, CAST(N'2020-12-21T14:53:00.563' AS DateTime), NULL, NULL, NULL, 8)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (17, 8, 5, CAST(N'2020-12-21T14:53:00.563' AS DateTime), NULL, NULL, NULL, 8)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (18, 8, 6, CAST(N'2020-12-21T14:53:00.563' AS DateTime), NULL, NULL, NULL, 8)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (19, 8, 1, CAST(N'2020-12-22T08:30:03.203' AS DateTime), NULL, NULL, NULL, 9)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (20, 16, 2, CAST(N'2020-12-22T08:30:03.217' AS DateTime), NULL, NULL, NULL, 9)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (21, 16, 3, CAST(N'2020-12-22T08:30:03.217' AS DateTime), NULL, NULL, NULL, 9)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (22, 8, 4, CAST(N'2020-12-22T08:30:03.220' AS DateTime), NULL, NULL, NULL, 9)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (23, 10, 5, CAST(N'2020-12-22T08:30:03.220' AS DateTime), NULL, NULL, NULL, 9)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (24, 16, 6, CAST(N'2020-12-22T08:30:03.220' AS DateTime), NULL, NULL, NULL, 9)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (25, 8, 1, CAST(N'2020-12-22T15:16:14.033' AS DateTime), NULL, NULL, NULL, 10)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (26, 8, 2, CAST(N'2020-12-22T15:16:14.033' AS DateTime), NULL, NULL, NULL, 10)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (27, 8, 3, CAST(N'2020-12-22T15:16:14.033' AS DateTime), NULL, NULL, NULL, 10)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (28, 8, 4, CAST(N'2020-12-22T15:16:14.033' AS DateTime), NULL, NULL, NULL, 10)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (29, 8, 5, CAST(N'2020-12-22T15:16:14.033' AS DateTime), NULL, NULL, NULL, 10)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (30, 8, 6, CAST(N'2020-12-22T15:16:14.033' AS DateTime), NULL, NULL, NULL, 10)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (31, 8, 1, CAST(N'2020-12-22T15:30:09.247' AS DateTime), NULL, NULL, NULL, 11)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (32, 8, 2, CAST(N'2020-12-22T15:30:09.247' AS DateTime), NULL, NULL, NULL, 11)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (33, 16, 3, CAST(N'2020-12-22T15:30:09.247' AS DateTime), NULL, NULL, NULL, 11)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (34, 8, 4, CAST(N'2020-12-22T15:30:09.247' AS DateTime), NULL, NULL, NULL, 11)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (35, 8, 5, CAST(N'2020-12-22T15:30:09.247' AS DateTime), NULL, NULL, NULL, 11)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (36, 8, 6, CAST(N'2020-12-22T15:30:09.247' AS DateTime), NULL, NULL, NULL, 11)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (37, 8, 1, CAST(N'2020-12-22T15:30:10.430' AS DateTime), NULL, NULL, NULL, 12)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (38, 8, 2, CAST(N'2020-12-22T15:30:10.430' AS DateTime), NULL, NULL, NULL, 12)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (39, 8, 3, CAST(N'2020-12-22T15:30:10.430' AS DateTime), NULL, NULL, NULL, 12)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (40, 8, 4, CAST(N'2020-12-22T15:30:10.430' AS DateTime), NULL, NULL, NULL, 12)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (41, 8, 5, CAST(N'2020-12-22T15:30:10.430' AS DateTime), NULL, NULL, NULL, 12)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (42, 8, 6, CAST(N'2020-12-22T15:30:10.430' AS DateTime), NULL, NULL, NULL, 12)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (43, 8, 1, CAST(N'2020-12-22T15:30:10.593' AS DateTime), NULL, NULL, NULL, 13)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (44, 8, 2, CAST(N'2020-12-22T15:30:10.597' AS DateTime), NULL, NULL, NULL, 13)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (45, 6, 3, CAST(N'2020-12-22T15:30:10.597' AS DateTime), NULL, NULL, NULL, 13)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (46, 10, 4, CAST(N'2020-12-22T15:30:10.597' AS DateTime), NULL, NULL, NULL, 13)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (47, 8, 5, CAST(N'2020-12-22T15:30:10.597' AS DateTime), NULL, NULL, NULL, 13)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (48, 8, 6, CAST(N'2020-12-22T15:30:10.597' AS DateTime), NULL, NULL, NULL, 13)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (49, 8, 1, CAST(N'2020-12-22T15:32:00.790' AS DateTime), NULL, NULL, NULL, 14)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (50, 8, 2, CAST(N'2020-12-22T15:32:00.790' AS DateTime), NULL, NULL, NULL, 14)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (51, 8, 3, CAST(N'2020-12-22T15:32:00.793' AS DateTime), NULL, NULL, NULL, 14)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (52, 8, 4, CAST(N'2020-12-22T15:32:00.793' AS DateTime), NULL, NULL, NULL, 14)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (53, 8, 5, CAST(N'2020-12-22T15:32:00.793' AS DateTime), NULL, NULL, NULL, 14)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (54, 8, 6, CAST(N'2020-12-22T15:32:00.793' AS DateTime), NULL, NULL, NULL, 14)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (55, 8, 1, CAST(N'2020-12-22T15:38:18.493' AS DateTime), NULL, NULL, NULL, 15)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (56, 18, 2, CAST(N'2020-12-22T15:38:18.493' AS DateTime), NULL, NULL, NULL, 15)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (57, 14, 3, CAST(N'2020-12-22T15:38:18.493' AS DateTime), NULL, NULL, NULL, 15)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (58, 8, 4, CAST(N'2020-12-22T15:38:18.497' AS DateTime), NULL, NULL, NULL, 15)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (59, 8, 5, CAST(N'2020-12-22T15:38:18.497' AS DateTime), NULL, NULL, NULL, 15)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (60, 8, 6, CAST(N'2020-12-22T15:38:18.497' AS DateTime), NULL, NULL, NULL, 15)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (61, 120, 1, CAST(N'2020-12-22T15:38:19.227' AS DateTime), NULL, NULL, NULL, 16)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (62, 80, 2, CAST(N'2020-12-22T15:38:19.227' AS DateTime), NULL, NULL, NULL, 16)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (63, 80, 3, CAST(N'2020-12-22T15:38:19.227' AS DateTime), NULL, NULL, NULL, 16)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (64, 8, 4, CAST(N'2020-12-22T15:38:19.227' AS DateTime), NULL, NULL, NULL, 16)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (65, 8, 5, CAST(N'2020-12-22T15:38:19.230' AS DateTime), NULL, NULL, NULL, 16)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (66, 8, 6, CAST(N'2020-12-22T15:38:19.230' AS DateTime), NULL, NULL, NULL, 16)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (67, 8, 1, CAST(N'2020-12-22T15:38:19.387' AS DateTime), NULL, NULL, NULL, 17)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (68, 8, 2, CAST(N'2020-12-22T15:38:19.387' AS DateTime), NULL, NULL, NULL, 17)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (69, 8, 3, CAST(N'2020-12-22T15:38:19.387' AS DateTime), NULL, NULL, NULL, 17)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (70, 8, 4, CAST(N'2020-12-22T15:38:19.387' AS DateTime), NULL, NULL, NULL, 17)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (71, 8, 5, CAST(N'2020-12-22T15:38:19.387' AS DateTime), NULL, NULL, NULL, 17)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (72, 8, 6, CAST(N'2020-12-22T15:38:19.387' AS DateTime), NULL, NULL, NULL, 17)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (73, 8, 1, CAST(N'2020-12-22T15:39:45.440' AS DateTime), NULL, NULL, NULL, 18)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (74, 8, 2, CAST(N'2020-12-22T15:39:45.440' AS DateTime), NULL, NULL, NULL, 18)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (75, 8, 3, CAST(N'2020-12-22T15:39:45.440' AS DateTime), NULL, NULL, NULL, 18)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (76, 8, 4, CAST(N'2020-12-22T15:39:45.440' AS DateTime), NULL, NULL, NULL, 18)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (77, 8, 5, CAST(N'2020-12-22T15:39:45.440' AS DateTime), NULL, NULL, NULL, 18)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (78, 8, 6, CAST(N'2020-12-22T15:39:45.443' AS DateTime), NULL, NULL, NULL, 18)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (79, 8, 1, CAST(N'2020-12-22T17:07:49.153' AS DateTime), NULL, NULL, NULL, 19)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (80, 8, 2, CAST(N'2020-12-22T17:07:49.157' AS DateTime), NULL, NULL, NULL, 19)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (81, 8, 3, CAST(N'2020-12-22T17:07:49.157' AS DateTime), NULL, NULL, NULL, 19)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (82, 8, 4, CAST(N'2020-12-22T17:07:49.157' AS DateTime), NULL, NULL, NULL, 19)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (83, 8, 5, CAST(N'2020-12-22T17:07:49.157' AS DateTime), NULL, NULL, NULL, 19)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (84, 0, 6, CAST(N'2020-12-22T17:07:49.157' AS DateTime), NULL, NULL, NULL, 19)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (85, 0, 1, CAST(N'2020-12-28T08:22:39.560' AS DateTime), NULL, NULL, NULL, 21)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (86, 0, 2, CAST(N'2020-12-28T08:22:39.560' AS DateTime), NULL, NULL, NULL, 21)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (87, 0, 3, CAST(N'2020-12-28T08:22:39.560' AS DateTime), NULL, NULL, NULL, 21)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (88, 0, 4, CAST(N'2020-12-28T08:22:39.560' AS DateTime), NULL, NULL, NULL, 21)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (89, 0, 5, CAST(N'2020-12-28T08:22:39.563' AS DateTime), NULL, NULL, NULL, 21)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (90, 0, 6, CAST(N'2020-12-28T08:22:39.563' AS DateTime), NULL, NULL, NULL, 21)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (91, 0, 1, CAST(N'2020-12-28T08:25:39.440' AS DateTime), NULL, NULL, NULL, 22)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (92, 0, 2, CAST(N'2020-12-28T08:25:39.440' AS DateTime), NULL, NULL, NULL, 22)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (93, 0, 3, CAST(N'2020-12-28T08:25:39.440' AS DateTime), NULL, NULL, NULL, 22)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (94, 0, 4, CAST(N'2020-12-28T08:25:39.443' AS DateTime), NULL, NULL, NULL, 22)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (95, 0, 5, CAST(N'2020-12-28T08:25:39.443' AS DateTime), NULL, NULL, NULL, 22)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (96, 0, 6, CAST(N'2020-12-28T08:25:39.443' AS DateTime), NULL, NULL, NULL, 22)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (97, 0, 1, CAST(N'2020-12-28T08:26:20.950' AS DateTime), NULL, NULL, NULL, 23)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (98, 0, 2, CAST(N'2020-12-28T08:26:20.950' AS DateTime), NULL, NULL, NULL, 23)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (99, 0, 3, CAST(N'2020-12-28T08:26:20.950' AS DateTime), NULL, NULL, NULL, 23)
GO
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (100, 0, 4, CAST(N'2020-12-28T08:26:20.950' AS DateTime), NULL, NULL, NULL, 23)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (101, 0, 5, CAST(N'2020-12-28T08:26:20.950' AS DateTime), NULL, NULL, NULL, 23)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (102, 0, 6, CAST(N'2020-12-28T08:26:20.953' AS DateTime), NULL, NULL, NULL, 23)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (103, 0, 1, CAST(N'2020-12-28T08:27:50.363' AS DateTime), NULL, NULL, NULL, 24)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (104, 0, 2, CAST(N'2020-12-28T08:27:50.363' AS DateTime), NULL, NULL, NULL, 24)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (105, 0, 3, CAST(N'2020-12-28T08:27:50.363' AS DateTime), NULL, NULL, NULL, 24)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (106, 0, 4, CAST(N'2020-12-28T08:27:50.363' AS DateTime), NULL, NULL, NULL, 24)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (107, 0, 5, CAST(N'2020-12-28T08:27:50.363' AS DateTime), NULL, NULL, NULL, 24)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (108, 0, 6, CAST(N'2020-12-28T08:27:50.367' AS DateTime), NULL, NULL, NULL, 24)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (109, 0, 1, CAST(N'2020-12-28T08:55:14.083' AS DateTime), NULL, NULL, NULL, 25)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (110, 0, 2, CAST(N'2020-12-28T08:55:14.083' AS DateTime), NULL, NULL, NULL, 25)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (111, 0, 3, CAST(N'2020-12-28T08:55:14.083' AS DateTime), NULL, NULL, NULL, 25)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (112, 0, 4, CAST(N'2020-12-28T08:55:14.083' AS DateTime), NULL, NULL, NULL, 25)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (113, 0, 5, CAST(N'2020-12-28T08:55:14.083' AS DateTime), NULL, NULL, NULL, 25)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (114, 0, 6, CAST(N'2020-12-28T08:55:14.083' AS DateTime), NULL, NULL, NULL, 25)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (115, 0, 1, CAST(N'2020-12-29T09:43:04.560' AS DateTime), NULL, NULL, NULL, 26)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (116, 0, 2, CAST(N'2020-12-29T09:43:04.560' AS DateTime), NULL, NULL, NULL, 26)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (117, 0, 3, CAST(N'2020-12-29T09:43:04.560' AS DateTime), NULL, NULL, NULL, 26)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (118, 0, 4, CAST(N'2020-12-29T09:43:04.563' AS DateTime), NULL, NULL, NULL, 26)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (119, 0, 5, CAST(N'2020-12-29T09:43:04.563' AS DateTime), NULL, NULL, NULL, 26)
INSERT [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis], [Hour], [IdPhase], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdTask]) VALUES (120, 0, 6, CAST(N'2020-12-29T09:43:04.563' AS DateTime), NULL, NULL, NULL, 26)
SET IDENTITY_INSERT [dbo].[KPI_T_QualityAnalysis] OFF
GO
SET IDENTITY_INSERT [dbo].[KPI_T_Task] ON 

INSERT [dbo].[KPI_T_Task] ([IdTask], [Content], [Deleted], [IdLevel], [IdProject], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdUser], [Reason]) VALUES (6, N'Hệ thống hóa yêu cầu kéo dài thời gian của thiết bị', 0, 1, 1, CAST(N'2020-12-21T14:41:52.393' AS DateTime), CAST(N'2020-12-30T00:00:00.000' AS DateTime), NULL, N'BRY001', N'BRY002', N'')
INSERT [dbo].[KPI_T_Task] ([IdTask], [Content], [Deleted], [IdLevel], [IdProject], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdUser], [Reason]) VALUES (7, N'Hiển thị địa chỉ mail của người chịu trách nhiệm bên đại lý', 0, 3, 1, CAST(N'2020-12-21T14:42:04.953' AS DateTime), NULL, NULL, NULL, N'BRY006', N'')
INSERT [dbo].[KPI_T_Task] ([IdTask], [Content], [Deleted], [IdLevel], [IdProject], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdUser], [Reason]) VALUES (8, N'Code chức năng Logout', 0, 1, 1, CAST(N'2020-12-21T14:53:00.577' AS DateTime), NULL, NULL, NULL, N'BRY002', N'')
INSERT [dbo].[KPI_T_Task] ([IdTask], [Content], [Deleted], [IdLevel], [IdProject], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdUser], [Reason]) VALUES (9, N'Hệ thống hóa yêu cầu kéo dài thời gian của thiết bị 1', 0, 1, 1, CAST(N'2020-12-22T08:30:03.213' AS DateTime), NULL, NULL, NULL, N'BRY002', NULL)
INSERT [dbo].[KPI_T_Task] ([IdTask], [Content], [Deleted], [IdLevel], [IdProject], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdUser], [Reason]) VALUES (10, N'Sửa mail trả lời ', 0, 1, 1, CAST(N'2020-12-22T15:16:14.020' AS DateTime), CAST(N'2020-12-25T00:00:00.000' AS DateTime), NULL, N'BRY001', N'BRY002', NULL)
INSERT [dbo].[KPI_T_Task] ([IdTask], [Content], [Deleted], [IdLevel], [IdProject], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdUser], [Reason]) VALUES (11, N'Thay đổi điểm đến của dịch vụ gởi mail _CIC', 0, 2, 1, CAST(N'2020-12-22T15:30:01.940' AS DateTime), NULL, N'BRY002', NULL, N'BRY002', NULL)
INSERT [dbo].[KPI_T_Task] ([IdTask], [Content], [Deleted], [IdLevel], [IdProject], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdUser], [Reason]) VALUES (12, N'Ánh xạ hàng loạt cùng ticket của Item number ﾁｬｰﾀｰ便', 0, 2, 1, CAST(N'2020-12-22T15:30:01.940' AS DateTime), CAST(N'2020-12-28T00:00:00.000' AS DateTime), N'BRY002', N'BRY001', N'BRY006', NULL)
INSERT [dbo].[KPI_T_Task] ([IdTask], [Content], [Deleted], [IdLevel], [IdProject], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdUser], [Reason]) VALUES (13, N'Kiểm soát hướng dẫn xuất hàng của mỗi kho', 0, 2, 1, CAST(N'2020-12-22T15:30:01.940' AS DateTime), NULL, N'BRY002', NULL, N'BRY002', NULL)
INSERT [dbo].[KPI_T_Task] ([IdTask], [Content], [Deleted], [IdLevel], [IdProject], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdUser], [Reason]) VALUES (14, N'Sắp xếp kết quả tìm kiếm master thiết bị', 0, 3, 1, CAST(N'2020-12-22T15:32:00.787' AS DateTime), NULL, N'BRY006', NULL, N'BRY006', NULL)
INSERT [dbo].[KPI_T_Task] ([IdTask], [Content], [Deleted], [IdLevel], [IdProject], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdUser], [Reason]) VALUES (15, N'Thêm cột check ở mục liên lạc thiết bị bị thiếu', 0, 2, 1, CAST(N'2020-12-22T15:38:13.777' AS DateTime), NULL, N'BRY001', NULL, N'BRY002', N'')
INSERT [dbo].[KPI_T_Task] ([IdTask], [Content], [Deleted], [IdLevel], [IdProject], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdUser], [Reason]) VALUES (16, N'Code chức năng update', 0, 2, 1, CAST(N'2020-12-22T15:38:13.777' AS DateTime), CAST(N'2020-12-25T00:00:00.000' AS DateTime), N'BRY001', N'BRY001', N'BRY002', N'')
INSERT [dbo].[KPI_T_Task] ([IdTask], [Content], [Deleted], [IdLevel], [IdProject], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdUser], [Reason]) VALUES (17, N'Thêm gởi mail của trường hợp có claim thời hạn trả hàng', 0, 2, 1, CAST(N'2020-12-22T15:38:13.777' AS DateTime), NULL, N'BRY001', NULL, N'BRY002', NULL)
INSERT [dbo].[KPI_T_Task] ([IdTask], [Content], [Deleted], [IdLevel], [IdProject], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdUser], [Reason]) VALUES (18, N'Hiển thị số lượng lưu trữ tạm thời ', 0, 2, 1, CAST(N'2020-12-22T15:39:45.437' AS DateTime), CAST(N'2020-12-22T00:00:00.000' AS DateTime), N'BRY001', N'BRY001', N'BRY006', NULL)
INSERT [dbo].[KPI_T_Task] ([IdTask], [Content], [Deleted], [IdLevel], [IdProject], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdUser], [Reason]) VALUES (19, N'Hệ thống hóa yêu cầu kéo dài thời gian của thiết bị 111', 0, 1, 1, CAST(N'2020-12-22T17:07:49.097' AS DateTime), NULL, N'BRY001', NULL, N'BRY002', N'')
INSERT [dbo].[KPI_T_Task] ([IdTask], [Content], [Deleted], [IdLevel], [IdProject], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdUser], [Reason]) VALUES (20, N'Loại bỏ bcc(pr_yoyaku) từ địa chỉ mail của チャーター便', 0, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[KPI_T_Task] ([IdTask], [Content], [Deleted], [IdLevel], [IdProject], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdUser], [Reason]) VALUES (21, N'Code chức năng Xuất CSV', 0, 2, 1, CAST(N'2020-12-28T08:22:39.497' AS DateTime), NULL, N'BRY001', NULL, N'BRY002', NULL)
INSERT [dbo].[KPI_T_Task] ([IdTask], [Content], [Deleted], [IdLevel], [IdProject], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdUser], [Reason]) VALUES (22, N'Code chức năng Xuất CSV', 1, 2, 1, CAST(N'2020-12-28T08:25:39.437' AS DateTime), NULL, N'BRY001', NULL, N'BRY002', NULL)
INSERT [dbo].[KPI_T_Task] ([IdTask], [Content], [Deleted], [IdLevel], [IdProject], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdUser], [Reason]) VALUES (23, N'1111111111111', 1, 2, 1, CAST(N'2020-12-28T08:26:20.950' AS DateTime), NULL, N'BRY001', NULL, N'BRY006', NULL)
INSERT [dbo].[KPI_T_Task] ([IdTask], [Content], [Deleted], [IdLevel], [IdProject], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdUser], [Reason]) VALUES (24, N'1111111111111', 1, 2, 1, CAST(N'2020-12-28T08:27:50.360' AS DateTime), NULL, N'BRY001', NULL, N'BRY006', NULL)
INSERT [dbo].[KPI_T_Task] ([IdTask], [Content], [Deleted], [IdLevel], [IdProject], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdUser], [Reason]) VALUES (25, N'aaaaa', 1, 1, 1, CAST(N'2020-12-28T08:55:14.073' AS DateTime), NULL, N'BRY001', NULL, N'BRY006', NULL)
INSERT [dbo].[KPI_T_Task] ([IdTask], [Content], [Deleted], [IdLevel], [IdProject], [CreateAt], [UpdateAt], [CreateBy], [UpdateBy], [IdUser], [Reason]) VALUES (26, N'1111111111111', 1, 1, 1, CAST(N'2020-12-29T09:43:04.560' AS DateTime), NULL, N'BRY001', NULL, N'BRY009', NULL)
SET IDENTITY_INSERT [dbo].[KPI_T_Task] OFF
GO
ALTER TABLE [dbo].[KPI_M_Project] ADD  CONSTRAINT [DF_KPI_M_Project_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [dbo].[KPI_M_User] ADD  CONSTRAINT [df_id]  DEFAULT ([DBO].[AUTO_BRY]()) FOR [IdUser]
GO
ALTER TABLE [dbo].[KPI_M_User] ADD  CONSTRAINT [DF_KPI_M_User_TimeForget]  DEFAULT (((1)/(1))/(1)) FOR [TimeForget]
GO
ALTER TABLE [dbo].[KPI_M_User] ADD  CONSTRAINT [DF_KPI_M_User_CountLoginFail]  DEFAULT ((0)) FOR [LoginFail]
GO
ALTER TABLE [dbo].[KPI_T_ErrorAnalysis] ADD  CONSTRAINT [DF_KPI_T_ErrorAnalysis_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [dbo].[KPI_T_Task] ADD  CONSTRAINT [DF_KPI_T_Content_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [dbo].[KPI_M_Project]  WITH CHECK ADD  CONSTRAINT [FK_KPI_M_Project_KPI_M_Department] FOREIGN KEY([IdDepartment])
REFERENCES [dbo].[KPI_M_Department] ([IdDerpartment])
GO
ALTER TABLE [dbo].[KPI_M_Project] CHECK CONSTRAINT [FK_KPI_M_Project_KPI_M_Department]
GO
ALTER TABLE [dbo].[KPI_M_User]  WITH CHECK ADD  CONSTRAINT [FK_User_Role] FOREIGN KEY([IdRole])
REFERENCES [dbo].[KPI_M_Role] ([IdRole])
GO
ALTER TABLE [dbo].[KPI_M_User] CHECK CONSTRAINT [FK_User_Role]
GO
ALTER TABLE [dbo].[KPI_T_Error]  WITH CHECK ADD  CONSTRAINT [FK_KPI_T_Error_KPI_M_ErrorType] FOREIGN KEY([IdErrorType])
REFERENCES [dbo].[KPI_M_ErrorType] ([IdErrorType])
GO
ALTER TABLE [dbo].[KPI_T_Error] CHECK CONSTRAINT [FK_KPI_T_Error_KPI_M_ErrorType]
GO
ALTER TABLE [dbo].[KPI_T_ErrorAnalysis]  WITH CHECK ADD  CONSTRAINT [FK_KPI_T_ErrorAnalysis_KPI_T_Error] FOREIGN KEY([IdError])
REFERENCES [dbo].[KPI_T_Error] ([IdError])
GO
ALTER TABLE [dbo].[KPI_T_ErrorAnalysis] CHECK CONSTRAINT [FK_KPI_T_ErrorAnalysis_KPI_T_Error]
GO
ALTER TABLE [dbo].[KPI_T_ErrorAnalysis]  WITH CHECK ADD  CONSTRAINT [FK_KPI_T_ErrorAnalysis_KPI_T_QualityAnalysis] FOREIGN KEY([IdQualityAnalysis])
REFERENCES [dbo].[KPI_T_QualityAnalysis] ([IdQualityAnalysis])
GO
ALTER TABLE [dbo].[KPI_T_ErrorAnalysis] CHECK CONSTRAINT [FK_KPI_T_ErrorAnalysis_KPI_T_QualityAnalysis]
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
ALTER TABLE [dbo].[KPI_T_QualityAnalysis]  WITH CHECK ADD  CONSTRAINT [FK_KPI_T_QualityAnalysis_KPI_M_Phase] FOREIGN KEY([IdPhase])
REFERENCES [dbo].[KPI_M_Phase] ([IdPhase])
GO
ALTER TABLE [dbo].[KPI_T_QualityAnalysis] CHECK CONSTRAINT [FK_KPI_T_QualityAnalysis_KPI_M_Phase]
GO
ALTER TABLE [dbo].[KPI_T_QualityAnalysis]  WITH CHECK ADD  CONSTRAINT [FK_KPI_T_QualityAnalysis_KPI_T_Task] FOREIGN KEY([IdTask])
REFERENCES [dbo].[KPI_T_Task] ([IdTask])
GO
ALTER TABLE [dbo].[KPI_T_QualityAnalysis] CHECK CONSTRAINT [FK_KPI_T_QualityAnalysis_KPI_T_Task]
GO
ALTER TABLE [dbo].[KPI_T_Task]  WITH CHECK ADD  CONSTRAINT [FK_KPI_T_EditContent_KPI_M_Level] FOREIGN KEY([IdLevel])
REFERENCES [dbo].[KPI_M_Level] ([IdLevel])
GO
ALTER TABLE [dbo].[KPI_T_Task] CHECK CONSTRAINT [FK_KPI_T_EditContent_KPI_M_Level]
GO
ALTER TABLE [dbo].[KPI_T_Task]  WITH CHECK ADD  CONSTRAINT [FK_KPI_T_EditContent_KPI_M_Project] FOREIGN KEY([IdProject])
REFERENCES [dbo].[KPI_M_Project] ([IdProject])
GO
ALTER TABLE [dbo].[KPI_T_Task] CHECK CONSTRAINT [FK_KPI_T_EditContent_KPI_M_Project]
GO
ALTER TABLE [dbo].[KPI_T_Task]  WITH CHECK ADD  CONSTRAINT [FK_KPI_T_EditContent_KPI_M_User] FOREIGN KEY([IdUser])
REFERENCES [dbo].[KPI_M_User] ([IdUser])
GO
ALTER TABLE [dbo].[KPI_T_Task] CHECK CONSTRAINT [FK_KPI_T_EditContent_KPI_M_User]
GO
/****** Object:  StoredProcedure [dbo].[GET_LIST_PHASE]    Script Date: 12/30/2020 8:42:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GET_LIST_PHASE]
AS
BEGIN
SELECT * FROM KPI_M_Phase
END
GO
/****** Object:  StoredProcedure [dbo].[GET_REASON_OF_TASK]    Script Date: 12/30/2020 8:42:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GET_REASON_OF_TASK]
@idUser nchar(6),
@role NVARCHAR(50),
@idProject int,
@idTask int
AS
BEGIN
IF @role='Leader' OR @role='Manager' OR @role='Admin'
BEGIN
SELECT * FROM KPI_T_Task WHERE IdProject=@idProject AND IdTask=@idTask
END
IF @role='User'
BEGIN
SELECT * FROM KPI_T_Task WHERE IdProject=@idProject AND IdTask=@idTask AND IdUser=@idUser
END
END
GO
/****** Object:  StoredProcedure [dbo].[SP_CHECK_EMAIL]    Script Date: 12/30/2020 8:42:36 AM ******/
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
/****** Object:  StoredProcedure [dbo].[SP_CHECK_ERRORANALYSIS]    Script Date: 12/30/2020 8:42:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SP_CHECK_ERRORANALYSIS]
@IdErrorAnalysis INT,
@UserIds NCHAR(6)
AS
BEGIN
SELECT * FROM KPI_T_ErrorAnalysis ea 
				JOIN KPI_T_QualityAnalysis qa 
				JOIN (SELECT IdTask, PU.idUser, PU.IdProject FROM KPI_T_Task T 
				JOIN KPI_T_ProjectUser PU ON T.IdProject = PU.IdProject) AS TT ON TT.IdTask = qa.IdTask ON ea.IdQualityAnalysis = qa.IdQualityAnalysis 
				WHERE ea.IdErrorAnalysis=@IdErrorAnalysis AND TT.idUser = @UserIds
END
GO
/****** Object:  StoredProcedure [dbo].[SP_CHECK_EXIST_PROJECT]    Script Date: 12/30/2020 8:42:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_CHECK_EXIST_PROJECT]
@IdProject INT
AS
BEGIN
SELECT * FROM KPI_M_Project WHERE IdProject = @IdProject
END
GO
/****** Object:  StoredProcedure [dbo].[SP_CHECK_FORGET_PASS]    Script Date: 12/30/2020 8:42:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_CHECK_FORGET_PASS]
@email NVARCHAR(MAX),
@code NVARCHAR(MAX)
AS
BEGIN
	SELECT * FROM KPI_M_User WHERE Email=@email AND Token=@code
END
GO
/****** Object:  StoredProcedure [dbo].[SP_CHECK_TASK]    Script Date: 12/30/2020 8:42:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[SP_CHECK_TASK]
@IdTask INT,
@Projectid INT,
@UserIds NCHAR(6)
AS
BEGIN
SELECT * FROM KPI_T_Task T JOIN KPI_T_ProjectUser PU ON pu.IdProject = T.IdProject WHERE IdTask=@IdTask AND T.IdProject=@Projectid AND PU.idUser = @UserIds
END
GO
/****** Object:  StoredProcedure [dbo].[SP_COUNT_EDIT_CONTENT]    Script Date: 12/30/2020 8:42:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_COUNT_EDIT_CONTENT]
@search NVARCHAR(MAX),
@role NVARCHAR(10),
@idUser NCHAR(6),
@idProject INT
AS
BEGIN
DECLARE @serchConvert NVARCHAR(MAX) ='%'+@search+'%' 
	IF @role='Leader' OR @role='Manager'
BEGIN 
SELECT 
		COUNT(T.IdTask) Count FROM KPI_T_Task T
		JOIN KPI_M_Level L ON T.IdLevel=L.IdLevel
		JOIN KPI_M_User U ON U.IdUser=T.IdUser
		JOIN KPI_T_ProjectUser PU ON PU.IdProject=T.IdProject
		WHERE	T.IdProject=@idProject AND PU.idUser=@idUser AND T.Deleted=0 AND (@serchConvert=N'' OR Content LIKE @serchConvert)
END
ELSE IF @role='User'
BEGIN
SELECT
		COUNT(T.IdTask) Count FROM KPI_T_Task T
		JOIN KPI_M_Level L ON T.IdLevel=L.IdLevel
		JOIN KPI_M_User U ON U.IdUser=T.IdUser
		WHERE	IdProject=@idProject AND t.IdUser=@idUser AND T.Deleted=0 AND (@serchConvert=N'' OR Content LIKE @serchConvert)
END
ELSE IF @role='Admin'
BEGIN
SELECT 
		COUNT(T.IdTask) Count FROM KPI_T_Task T
		JOIN KPI_M_Level L ON T.IdLevel=L.IdLevel
		JOIN KPI_M_User U ON U.IdUser=T.IdUser
		WHERE	T.IdProject=@idProject AND T.Deleted=0 AND (@serchConvert=N'' OR Content LIKE @serchConvert)
END
END
GO
/****** Object:  StoredProcedure [dbo].[SP_CREATE_CODE]    Script Date: 12/30/2020 8:42:36 AM ******/
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
/****** Object:  StoredProcedure [dbo].[SP_DDL_User]    Script Date: 12/30/2020 8:42:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SP_DDL_User]
@IdProject INT
AS
BEGIN
SELECT u.IdUser, u.FirstName , u.LastName, pu.IdProject FROM KPI_M_User u JOIN KPI_T_ProjectUser pu ON u.IdUser = pu.idUser 
WHERE IdProject = @IdProject AND IdRole = 4
END
COMMIT
GO
/****** Object:  StoredProcedure [dbo].[SP_DELETE_PROJECT]    Script Date: 12/30/2020 8:42:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 CREATE PROC [dbo].[SP_DELETE_PROJECT]
 @idProject INT
 AS
 BEGIN TRANSACTION
  UPDATE KPI_M_Project
  SET Deleted=1
	WHERE IdProject=@idProject
  COMMIT
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_ANALYSYSCONTENT]    Script Date: 12/30/2020 8:42:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_GET_ANALYSYSCONTENT]
@idUser nchar(6),
@idProject int,
@role NVARCHAR(50)
AS
BEGIN
if @role='Admin'
BEGIN
SELECT P.NamePhaseJP NamePhase, QA.Hour,SUM(EA.Bug) Bug, T.IdTask FROM KPI_T_Task T
									JOIN KPI_T_QualityAnalysis QA ON QA.IdTask=T.IdTask
									JOIN KPI_M_Phase P ON P.IdPhase=QA.IdPhase
									LEFT JOIN (SELECT * FROM KPI_T_ErrorAnalysis WHERE KPI_T_ErrorAnalysis.Deleted=0)  EA ON EA.IdQualityAnalysis=QA.IdQualityAnalysis
				WHERE T.Deleted=0    AND T.IdProject=@idProject
				GROUP BY P.NamePhaseJP, QA.Hour, T.IdTask ORDER BY T.IdTask
END
ELSE
BEGIN
SELECT P.NamePhaseJP NamePhase, QA.Hour,SUM(EA.Bug) Bug, T.IdTask FROM  KPI_T_ProjectUser PU JOIN KPI_T_Task T ON PU.IdProject=T.IdProject
									JOIN KPI_T_QualityAnalysis QA ON QA.IdTask=T.IdTask
									JOIN KPI_M_Phase P ON P.IdPhase=QA.IdPhase
									LEFT JOIN (SELECT * FROM KPI_T_ErrorAnalysis WHERE KPI_T_ErrorAnalysis.Deleted=0)  EA ON EA.IdQualityAnalysis=QA.IdQualityAnalysis
				WHERE T.Deleted=0   AND PU.IdUser=@idUser AND T.IdProject=@idProject
				GROUP BY P.NamePhaseJP, QA.Hour, T.IdTask ORDER BY T.IdTask
END
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_ANALYSYSCONTENT_WITH_IDEDITCONTENT]    Script Date: 12/30/2020 8:42:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_GET_ANALYSYSCONTENT_WITH_IDEDITCONTENT]
@idUser nchar(6),
@role NVARCHAR(50),
@idProject int,
@idEditContent int
AS
BEGIN
IF @role='Leader' OR @role='Manager'	
BEGIN
SELECT P.NamePhaseJP NamePhase, QA.Hour,SUM(EA.Bug) Bug, T.IdTask FROM KPI_T_ProjectUser PU JOIN KPI_T_Task T ON PU.IdProject=T.IdProject
									JOIN KPI_T_QualityAnalysis QA ON QA.IdTask=T.IdTask
									JOIN KPI_M_Phase P ON P.IdPhase=QA.IdPhase
									LEFT JOIN (SELECT * FROM KPI_T_ErrorAnalysis WHERE KPI_T_ErrorAnalysis.Deleted=0)  EA ON EA.IdQualityAnalysis=QA.IdQualityAnalysis
				WHERE T.Deleted=0 AND PU.idUser=@idUser  AND T.IdProject=@idProject AND T.IdTask=@idEditContent
				GROUP BY P.NamePhaseJP, QA.Hour, T.IdTask ORDER BY NamePhaseJP
END
IF @role='User'
BEGIN
SELECT P.NamePhaseJP NamePhase, QA.Hour,SUM(EA.Bug) Bug, T.IdTask FROM   KPI_T_Task T
									JOIN KPI_T_QualityAnalysis QA ON QA.IdTask=T.IdTask
									JOIN KPI_M_Phase P ON P.IdPhase=QA.IdPhase
									LEFT JOIN (SELECT * FROM KPI_T_ErrorAnalysis WHERE KPI_T_ErrorAnalysis.Deleted=0)  EA ON EA.IdQualityAnalysis=QA.IdQualityAnalysis
				WHERE T.Deleted=0   AND T.IdUser=@idUser AND T.IdProject=@idProject AND T.IdTask=@idEditContent
				GROUP BY P.NamePhaseJP, QA.Hour, T.IdTask ORDER BY NamePhaseJP
END
IF @role='Admin'
BEGIN
SELECT P.NamePhaseJP NamePhase, QA.Hour,SUM(EA.Bug) Bug, T.IdTask FROM KPI_T_Task T
									JOIN KPI_T_QualityAnalysis QA ON QA.IdTask=T.IdTask
									JOIN KPI_M_Phase P ON P.IdPhase=QA.IdPhase
									LEFT JOIN (SELECT * FROM KPI_T_ErrorAnalysis WHERE KPI_T_ErrorAnalysis.Deleted=0)  EA ON EA.IdQualityAnalysis=QA.IdQualityAnalysis
				WHERE T.Deleted=0 AND T.IdProject=@idProject AND T.IdTask=@idEditContent
				GROUP BY P.NamePhaseJP, QA.Hour, T.IdTask ORDER BY NamePhaseJP
END
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_COUNT_ERRORANALYSIS]    Script Date: 12/30/2020 8:42:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_GET_COUNT_ERRORANALYSIS]
@IdQualityAnalysis INT,
@search NVARCHAR(MAX),
@UserId NCHAR(6)
AS
BEGIN
DECLARE @serchConvert NVARCHAR(MAX) ='%'+@search+'%' 
SELECT COUNT(*) AS Count FROM KPI_T_ErrorAnalysis Ea 
										  JOIN KPI_T_Error er ON er.IdError = Ea.IdError 
										  JOIN KPI_T_QualityAnalysis Qa ON Ea.IdQualityAnalysis = Qa.IdQualityAnalysis
										  JOIN (SELECT IdTask, PU.IdProject, PU.idUser FROM KPI_T_Task T JOIN KPI_T_ProjectUser PU ON T.IdProject = PU.IdProject) AS TT ON Qa.IdTask = TT.IdTask
										WHERE Ea.Deleted = 0 AND Qa.IdTask = @IdQualityAnalysis AND TT.idUser = @UserId AND (@serchConvert=N'' OR NameError LIKE @serchConvert)
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_COUNT_PROJECT]    Script Date: 12/30/2020 8:42:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_GET_COUNT_PROJECT]
@idUser NCHAR(6),
@roleName NVARCHAR(50),
@search nvarchar(255)
AS
BEGIN
if @roleName='Admin'
BEGIN
	SELECT COUNT(*) AS Count FROM KPI_M_Role Rl JOIN KPI_M_User Us ON Rl.IdRole=Us.IdRole JOIN KPI_T_ProjectUser Pu ON Us.IdUser=Pu.idUser
				JOIN KPI_M_Project Pr ON Pr.IdProject=Pu.IdProject JOIN KPI_M_Department Dp ON Dp.IdDerpartment=Pr.IdDepartment
		WHERE Rl.Name='Leader' AND Deleted=0 AND (@search = '' OR  NameProject LIKE '%'+ @search +'%' OR FirstName LIKE '%'+ @search + '%' OR LastName LIKE '%'+ @search +'%')
END
else
BEGIN
	SELECT COUNT(*) AS Count FROM KPI_M_Role Rl JOIN KPI_M_User Us ON Rl.IdRole=Us.IdRole JOIN KPI_T_ProjectUser Pu ON Us.IdUser=Pu.idUser
				JOIN KPI_M_Project Pr ON Pr.IdProject=Pu.IdProject JOIN KPI_M_Department Dp ON Dp.IdDerpartment=Pr.IdDepartment
		WHERE Rl.Name='Leader' AND Deleted=0 AND (@search = '' OR  NameProject LIKE '%'+ @search +'%' OR FirstName LIKE '%'+ @search + '%' OR LastName LIKE '%'+ @search +'%') and Pr.IdProject IN (SELECT DISTINCT IdProject FROM KPI_T_ProjectUser WHERE KPI_T_ProjectUser.idUser=@idUser)
	END
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_COUNT_TASK]    Script Date: 12/30/2020 8:42:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_GET_COUNT_TASK]
@IdProject INT,
@search NVARCHAR(MAX),
@IdUsers NCHAR(6)
AS
BEGIN
DECLARE @serchConvert NVARCHAR(MAX) ='%'+@search+'%' 
SELECT COUNT(*) AS Count FROM KPI_T_Task T JOIN KPI_T_ProjectUser PU ON T.IdProject = PU.IdProject WHERE Deleted = 0 AND T.IdProject = @IdProject AND PU.idUser = @IdUsers AND (@serchConvert=N'' OR Content LIKE @serchConvert)

END
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_LIST_EDIT_CONTENT]    Script Date: 12/30/2020 8:42:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_GET_LIST_EDIT_CONTENT]
@page INT,
@pageSize INT,
@sortColumn NVARCHAR(50),
@sortOrder NVARCHAR(4),
@search NVARCHAR(MAX),
@role NVARCHAR(10),
@idUser NCHAR(6),
@idProject INT
AS
BEGIN
DECLARE @orderBy NVARCHAR(50)=@sortColumn+@sortOrder
DECLARE @serchConvert NVARCHAR(MAX) ='%'+@search+'%' 
	IF @role='Leader' OR @role='Manager' 
BEGIN 
	SELECT * FROM
(SELECT ROW_NUMBER()OVER(ORDER BY 
					case when @orderBy='RowNumDESC' then RowNumber end DESC,
					case when @orderBy='RowNumASC' then RowNumber end ASC,
					case when @orderBy='Content' then (Select(0)) end,
					case when @orderBy='ContentASC' then Content end ASC,
					case when @orderBy='ContentDESC' then Content end DESC,
					case when @orderBy='MemberASC' then LastName end ASC,
					case when @orderBy='MemberDESC' then LastName end DESC,
					case when @orderBy='ReasonASC' then Reason end ASC,
					case when @orderBy='ReasonDESC' then Reason end DESC,
					case when @orderBy='LevelASC' then Level end ASC,
					case when @orderBy='LevelDESC' then Level end DESC
					) AS RowNum,* FROM(
					select ROW_NUMBER()OVER(Order by (Select(0))
						) as RowNumber,Content,T.IdTask,Reason,U.IdUser,Username,U.FirstName,U.LastName,L.* FROM KPI_T_Task T
						JOIN KPI_M_Level L ON T.IdLevel=L.IdLevel
						JOIN KPI_M_User U ON U.IdUser=T.IdUser
						JOIN KPI_T_ProjectUser PU ON pu.IdProject=T.IdProject
						WHERE	T.IdProject=@idProject AND pu.idUser=@idUser AND T.Deleted=0 AND (@serchConvert=N'' OR Content LIKE @serchConvert)
						) As t) AS y Where y.RowNum between (@page-1)*@pageSize + 1 and @page*@pageSize



END
ELSE IF @role='User'
BEGIN
		SELECT * FROM
(SELECT ROW_NUMBER()OVER(ORDER BY 
					case when @orderBy='RowNumDESC' then RowNumber end DESC,
					case when @orderBy='RowNumASC' then RowNumber end ASC,
					case when @orderBy='Content' then (Select(0)) end,
					case when @orderBy='ContentASC' then Content end ASC,
					case when @orderBy='ContentDESC' then Content end DESC,
					case when @orderBy='MemberASC' then LastName end ASC,
					case when @orderBy='MemberDESC' then LastName end DESC,
					case when @orderBy='ReasonASC' then Reason end ASC,
					case when @orderBy='ReasonDESC' then Reason end DESC,
					case when @orderBy='LevelASC' then Level end ASC,
					case when @orderBy='LevelDESC' then Level end DESC
					) AS RowNum,* FROM(
					select ROW_NUMBER()OVER(Order by (Select(0))
						) as RowNumber,Content,T.IdTask,Reason,U.IdUser,Username,U.FirstName,U.LastName,L.* FROM KPI_T_Task T
						JOIN KPI_M_Level L ON T.IdLevel=L.IdLevel
						JOIN KPI_M_User U ON U.IdUser=T.IdUser
						WHERE	IdProject=@idProject AND U.IdUser=@idUser AND T.Deleted=0 AND (@serchConvert=N'' OR Content LIKE @serchConvert)
						) As t) AS y Where y.RowNum between (@page-1)*@pageSize + 1 and @page*@pageSize
END
ELSE IF @role='Admin'
BEGIN
		SELECT * FROM
(SELECT ROW_NUMBER()OVER(ORDER BY 
					case when @orderBy='RowNumDESC' then RowNumber end DESC,
					case when @orderBy='RowNumASC' then RowNumber end ASC,
					case when @orderBy='Content' then (Select(0)) end,
					case when @orderBy='ContentASC' then Content end ASC,
					case when @orderBy='ContentDESC' then Content end DESC,
					case when @orderBy='MemberASC' then LastName end ASC,
					case when @orderBy='MemberDESC' then LastName end DESC,
					case when @orderBy='ReasonASC' then Reason end ASC,
					case when @orderBy='ReasonDESC' then Reason end DESC,
					case when @orderBy='LevelASC' then Level end ASC,
					case when @orderBy='LevelDESC' then Level end DESC
					) AS RowNum,* FROM(
					select ROW_NUMBER()OVER(Order by (Select(0))
						) as RowNumber,Content,T.IdTask,Reason,U.IdUser,Username,U.FirstName,U.LastName,L.* FROM KPI_T_Task T
						JOIN KPI_M_Level L ON T.IdLevel=L.IdLevel
						JOIN KPI_M_User U ON U.IdUser=T.IdUser
						WHERE	IdProject=@idProject AND T.Deleted=0 AND (@serchConvert=N'' OR Content LIKE @serchConvert)
						) As t) AS y Where y.RowNum between (@page-1)*@pageSize + 1 and @page*@pageSize
END
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_LIST_PHASE]    Script Date: 12/30/2020 8:42:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_GET_LIST_PHASE]
AS
BEGIN
SELECT * FROM KPI_M_Phase Order by IdPhase
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_LIST_PROJECT]    Script Date: 12/30/2020 8:42:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_GET_LIST_PROJECT]
@idUser NCHAR(6)
AS
BEGIN
SELECT DISTINCT Pr.NameProject,Dp.NameDepartment,Us.FirstName,Us.LastName,Pr.IdProject 
FROM KPI_M_Role Rl JOIN KPI_M_User Us ON Rl.IdRole=Us.IdRole JOIN KPI_T_ProjectUser Pu ON Us.IdUser=Pu.idUser
		JOIN KPI_M_Project Pr ON Pr.IdProject=Pu.IdProject JOIN KPI_M_Department Dp ON Dp.IdDerpartment=Pr.IdDepartment
WHERE Rl.Name='Leader' AND Deleted=0
		AND Pr.IdProject IN (SELECT DISTINCT IdProject FROM KPI_T_ProjectUser WHERE KPI_T_ProjectUser.idUser=@idUser)
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_LOCK_USER]    Script Date: 12/30/2020 8:42:36 AM ******/
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
/****** Object:  StoredProcedure [dbo].[SP_GET_MEMBER_PROJECT]    Script Date: 12/30/2020 8:42:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_GET_MEMBER_PROJECT]
@idProject INT
AS
BEGIN
	SELECT DISTINCT FirstName+' '+LastName Member, u.IdUser  FROM KPI_M_Project p JOIN KPI_T_ProjectUser pu ON p.IdProject=pu.IdProject
						JOIN KPI_M_User u ON pu.idUser=u.IdUser
						JOIN KPI_M_Role r ON u.IdRole=r.IdRole
						WHERE p.IdProject=@idProject AND r.Name='User'
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_PROJECT]    Script Date: 12/30/2020 8:42:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_GET_PROJECT]
@idProject int,
@idUser nchar(6)
AS
BEGIN
	SELECT DISTINCT Pr.NameProject,Dp.NameDepartment,Us.IdUser,Us.FirstName,Us.LastName,Pr.IdProject,Dp.IdDerpartment
	FROM KPI_M_Role Rl JOIN KPI_M_User Us ON Rl.IdRole=Us.IdRole JOIN KPI_T_ProjectUser Pu ON Us.IdUser=Pu.idUser
			JOIN KPI_M_Project Pr ON Pr.IdProject=Pu.IdProject JOIN KPI_M_Department Dp ON Dp.IdDerpartment=Pr.IdDepartment
	WHERE Rl.Name='Leader' and Deleted=0
			AND Pr.IdProject IN (SELECT DISTINCT IdProject FROM KPI_T_ProjectUser WHERE KPI_T_ProjectUser.IdProject=@idProject and KPI_T_ProjectUser.idUser=@idUser)
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_PROJECT_FOR_ROLE]    Script Date: 12/30/2020 8:42:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_GET_PROJECT_FOR_ROLE]
@idUser Nchar(6),
@role NVARCHAR(50)
AS
BEGIN
	IF @role !='Manager' AND @role!='Admin'
	BEGIN
		SELECT * FROM KPI_T_ProjectUser PU JOIN KPI_M_Project P ON pu.IdProject=p.IdProject WHERE idUser=@idUser AND p.Deleted!=1
	END
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_TASKLIST]    Script Date: 12/30/2020 8:42:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_GET_TASKLIST]
@IdProject AS INT,
@PageNumber AS INT,
@PageSize AS INT,
@search NVARCHAR(MAX),
@sortColumn NVARCHAR(50),
@sortOrder NVARCHAR(4),
@idUser NCHAR(6)
AS
BEGIN
DECLARE @orderBy NVARCHAR(50)= @sortColumn+@sortOrder
DECLARE @serchConvert NVARCHAR(MAX) ='%'+@search+'%' 
SELECT * FROM(
SELECT DISTINCT ROW_NUMBER()OVER(Order by ed.IdTask ASC) as rownum, ed.IdTask,ed.Content,u.FirstName, u.LastName, ed.CreateAt,lv.IdLevel,lv.Level,lv.LevelJP,ed.IdProject,P.NameProject,ed.Deleted FROM KPI_T_Task ed
			JOIN KPI_M_User u ON ed.IdUser = u.IdUser
			JOIN KPI_M_Level lv ON ed.IdLevel = lv.IdLevel
			JOIN KPI_T_ProjectUser PU ON pu.IdProject=ed.IdProject
			JOIN KPI_M_Project P ON P.IdProject = ed.IdProject
		 WHERE ed.Deleted = 0 AND ed.IdProject=@IdProject AND pu.IdUser = @idUser AND (@serchConvert=N'' OR Content LIKE @serchConvert)
) AS t 
ORDER BY 
(CASE @orderBy WHEN 'rownumDESC' THEN rownum END) DESC,
(CASE @orderBy WHEN 'rownumASC' THEN rownum END) ASC,
(CASE @orderBy WHEN 'ContentDESC' THEN Content END) DESC,
(CASE @orderBy WHEN 'ContentASC' THEN Content END) ASC,
(CASE @orderBy WHEN 'FirstNameDESC' THEN FirstName END) DESC,
(CASE @orderBy WHEN 'FirstNameASC' THEN FirstName END) ASC,
(CASE @orderBy WHEN 'LevelDESC' THEN IdLevel END) DESC,
(CASE @orderBy WHEN 'LevelASC' THEN IdLevel END) ASC,
(CASE @orderBy WHEN 'CreateAtDESC' THEN CreateAt END) DESC,
(CASE @orderBy WHEN 'CreateAtASC' THEN CreateAt END) ASC
OFFSET ((@PageNumber - 1) * @PageSize) ROWS
FETCH NEXT @PageSize ROWS ONLY;
END

GO
/****** Object:  StoredProcedure [dbo].[SP_GET_USER]    Script Date: 12/30/2020 8:42:36 AM ******/
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
/****** Object:  StoredProcedure [dbo].[SP_GETLIST_ERRORANALYSIS]    Script Date: 12/30/2020 8:42:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_GETLIST_ERRORANALYSIS]
@IdTask AS INT,
@PageNumber AS INT,
@PageSize AS INT,
@search NVARCHAR(MAX),
@sortColumn NVARCHAR(50),
@sortOrder NVARCHAR(4),
@IdUser NCHAR(6)
AS
BEGIN
DECLARE @orderBy NVARCHAR(50)= @sortColumn+@sortOrder
DECLARE @serchConvert NVARCHAR(MAX) ='%'+@search+'%' 
SELECT * FROM(
SELECT DISTINCT ROW_NUMBER()OVER(Order by (select(0))) as rownum,ea.IdErrorAnalysis, qaa.Content,qaa.IdPhase,qaa.NamePhase,qaa.NamePhaseJP,ea.Bug, qaa.IdTask, er.NameError,er.NameErrorJP, ea.Reference FROM KPI_T_ErrorAnalysis ea
					JOIN (SELECT IdQualityAnalysis, ph.NamePhase,ph.NamePhaseJP,ph.IdPhase, TS.Content, TS.IdTask, TS.idUser FROM KPI_T_QualityAnalysis qa
										JOIN KPI_M_Phase ph ON qa.IdPhase=ph.IdPhase
										JOIN (SELECT IdTask, IdProjectUser, PU.idUser, PU.IdProject, Content FROM KPI_T_Task tsk JOIN KPI_T_ProjectUser PU ON tsk.IdProject = PU.IdProject ) AS TS ON qa.IdTask = TS.IdTask)AS qaa ON ea.IdQualityAnalysis = qaa.IdQualityAnalysis
					JOIN KPI_T_Error er ON ea.IdError = er.IdError
		 WHERE ea.Deleted = 0 AND qaa.IdTask=@IdTask AND qaa.idUser = @IdUser AND (@serchConvert=N'' OR Content LIKE @serchConvert)
) AS t 
ORDER BY 
(CASE @orderBy WHEN 'RowNumDESC' THEN t.rownum END) DESC,
(CASE @orderBy WHEN 'RowNumASC' THEN t.rownum END) ASC,
(CASE @orderBy WHEN 'NameErrorASC' THEN t.NameError END) ASC,
(CASE @orderBy WHEN 'NameErrorDESC' THEN t.NameError END) DESC,
(CASE @orderBy WHEN 'BugASC' THEN t.Bug END) ASC,
(CASE @orderBy WHEN 'BugDESC' THEN t.Bug END) DESC,
(CASE @orderBy WHEN 'PhaseASC' THEN t.NamePhase END) ASC,
(CASE @orderBy WHEN 'PhaseDESC' THEN t.NamePhase END) DESC,
(CASE @orderBy WHEN 'ReferenceASC' THEN t.Reference END) ASC,
(CASE @orderBy WHEN 'ReferenceDESC' THEN t.Reference END) DESC
OFFSET ((@PageNumber - 1) * @PageSize) ROWS
FETCH NEXT @PageSize ROWS ONLY;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_INSERT_ERRORANALYSIS]    Script Date: 12/30/2020 8:42:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SP_INSERT_ERRORANALYSIS]
@Bug AS INT,
@Reference AS NVARCHAR(MAX),
@IdError AS INT, 
@idPhase INT,
@CreateAt DATETIME,
@idTask INT
AS
DECLARE @IdQualityAnalysis INT
SELECT @IdQualityAnalysis=IdQualityAnalysis FROM KPI_T_QualityAnalysis WHERE IdTask=@idTask AND IdPhase=@idPhase
INSERT INTO [KPI_T_ErrorAnalysis] (Bug,Reference,IdError,IdQualityAnalysis,CreateAt) 
	VALUES (@Bug,@Reference,@IdError,@IdQualityAnalysis,@CreateAt)
GO
/****** Object:  StoredProcedure [dbo].[SP_INSERT_MEMBER]    Script Date: 12/30/2020 8:42:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_INSERT_MEMBER]
@idMember nchar(6),
@idProject INT
 AS
 BEGIN TRANSACTION
	INSERT INTO KPI_T_ProjectUser(IdProject,idUser)
	VALUES (@idProject,@idMember)
 COMMIT
GO
/****** Object:  StoredProcedure [dbo].[SP_INSERT_PROJECT]    Script Date: 12/30/2020 8:42:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_INSERT_PROJECT]
@idUser nchar(6),
@idDepartment int,
@idPL nchar(6),
@nameProject nvarchar(50)
 AS
 BEGIN TRANSACTION
	DECLARE @idNewProject INT
	INSERT INTO KPI_M_Project(NameProject,IdDepartment,CreateAt,CreateBy)
	VALUES (@nameProject,@idDepartment,GETDATE(),@idUser)

	SET @idNewProject=@@IDENTITY

	INSERT INTO KPI_T_ProjectUser(IdProject,idUser)
	VALUES (@idNewProject,@idPL)

	INSERT INTO KPI_T_ProjectUser(IdProject,idUser)
	VALUES (@idNewProject,@idUser)
	
	SELECT @idNewProject 
 COMMIT
GO
/****** Object:  StoredProcedure [dbo].[SP_INSERT_TASK]    Script Date: 12/30/2020 8:42:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_INSERT_TASK]
 @Content NVARCHAR(MAX),
 @IdProject INT,
 @IdUser NCHAR(6),
 @IdLevel INT,
 @CreateAt DATETIME,
 @IdTask INT,
 @CreateBy NVARCHAR(10)
 AS
 INSERT INTO [KPI_T_Task] (Content,IdProject,IdUser,IdLevel,CreateAt,CreateBy) VALUES (@Content,@IdProject,@IdUser,@IdLevel,@CreateAt,@CreateBy)
 SELECT @idTask=@@IDENTITY
DECLARE @i INT=1
 WHILE @i<=6
 BEGIN
	INSERT INTO [KPI_T_Qualityanalysis] (Hour,IdTask,IdPhase,CreateAt) VALUES (0,@IdTask,@i,GETDATE())
	SET @i=@i+1
 END
GO
/****** Object:  StoredProcedure [dbo].[SP_LIST_DEPARTMENT]    Script Date: 12/30/2020 8:42:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SP_LIST_DEPARTMENT]
AS
BEGIN
SELECT * FROM KPI_M_Department
END
GO
/****** Object:  StoredProcedure [dbo].[SP_LIST_PL]    Script Date: 12/30/2020 8:42:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_LIST_PL]
@idProject INT
AS
BEGIN
SELECT IdUser,FirstName,LastName FROM KPI_M_User WHERE IdRole=3 AND IdUser NOT IN (SELECT idUser FROM KPI_T_ProjectUser PU JOIN KPI_M_Project P ON PU.IdProject= p.IdProject WHERE PU.IdProject!=@idProject AND Deleted=0)
END
GO
/****** Object:  StoredProcedure [dbo].[SP_LIST_USER]    Script Date: 12/30/2020 8:42:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_LIST_USER]
@projectID INT
AS
BEGIN
SELECT IdUser,FirstName,LastName FROM KPI_M_User  WHERE IdRole=4 AND IdUser NOT IN( SELECT DISTINCT idUser FROM KPI_T_ProjectUser PU JOIN KPI_M_Project P ON PU.IdProject= p.IdProject WHERE PU.IdProject!=@projectID AND Deleted =0)
END
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTCSV_ERRORANALYSIS]    Script Date: 12/30/2020 8:42:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_LISTCSV_ERRORANALYSIS]
@rownum INT,
@IdUserss NCHAR(6)
AS
BEGIN 
SELECT * FROM(
SELECT DISTINCT ROW_NUMBER()OVER(Order by (select(0))) as rownum,ea.IdErrorAnalysis, qaa.Content,qaa.FirstName,qaa.LastName,qaa.NamePhase,qaa.NamePhaseJP, er.NameError,er.NameErrorJP,ea.Bug,ea.Reference, qaa.IdUser FROM KPI_T_ErrorAnalysis ea
					JOIN (SELECT DISTINCT IdQualityAnalysis, ph.NamePhase,ph.NamePhaseJP, tu.Content, tu.IdTask, tu.FirstName, tu.LastName, tu.IdUser  FROM KPI_T_QualityAnalysis qa
										JOIN KPI_M_Phase ph ON qa.IdPhase=ph.IdPhase
										JOIN (SELECT DISTINCT us.FirstName, us.LastName , tsk.IdTask, tsk.Content, PU.idUser FROM KPI_T_Task tsk JOIN KPI_M_User us ON us.IdUser = tsk.IdUser
																																		JOIN KPI_T_ProjectUser PU ON tsk.IdProject = PU.IdProject) AS tu ON qa.IdTask = tu.IdTask) AS qaa ON ea.IdQualityAnalysis = qaa.IdQualityAnalysis
					JOIN KPI_T_Error er ON ea.IdError = er.IdError
					WHERE Deleted = 0 AND qaa.IdUser = @IdUserss
					) AS t 				
ORDER BY 
t.Content,
(CASE @RowNum WHEN 1 THEN rownum END) DESC,
(CASE @RowNum WHEN 2 THEN rownum END) ASC

END
GO
/****** Object:  StoredProcedure [dbo].[SP_SELECT_PROJECT]    Script Date: 12/30/2020 8:42:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_SELECT_PROJECT]
@idUser NCHAR(6),
@roleName NVARCHAR(50),
@pageSize INT,
@curentPage INT,
@search nvarchar(255)
AS
BEGIN
IF @roleName='Admin'
BEGIN
	select * from (
		SELECT DISTINCT ROW_NUMBER()OVER(Order by (Pr.NameProject)) as rownum, Pr.NameProject,Dp.NameDepartment,Us.FirstName,Us.LastName,Pr.IdProject 
		FROM KPI_M_Role Rl JOIN KPI_M_User Us ON Rl.IdRole=Us.IdRole JOIN KPI_T_ProjectUser Pu ON Us.IdUser=Pu.idUser
				JOIN KPI_M_Project Pr ON Pr.IdProject=Pu.IdProject JOIN KPI_M_Department Dp ON Dp.IdDerpartment=Pr.IdDepartment
		WHERE Rl.Name='Leader' AND Deleted=0 AND (@search = '' OR  NameProject LIKE '%'+ @search +'%' OR FirstName LIKE '%'+ @search + '%' OR LastName LIKE '%'+ @search +'%'))
		AS t 
		WHERE t.RowNum between (@curentPage-1)*@pageSize + 1 and @curentPage*@pageSize
END
ELSE
BEGIN
	select * from (
		SELECT DISTINCT ROW_NUMBER()OVER(Order by (Pr.NameProject)) as rownum, Pr.NameProject,Dp.NameDepartment,Us.FirstName,Us.LastName,Pr.IdProject 
		FROM KPI_M_Role Rl JOIN KPI_M_User Us ON Rl.IdRole=Us.IdRole JOIN KPI_T_ProjectUser Pu ON Us.IdUser=Pu.idUser
				JOIN KPI_M_Project Pr ON Pr.IdProject=Pu.IdProject JOIN KPI_M_Department Dp ON Dp.IdDerpartment=Pr.IdDepartment
		WHERE Rl.Name='Leader' AND Deleted=0 AND (@search = '' OR  NameProject LIKE '%'+ @search +'%' OR FirstName LIKE '%'+ @search + '%' OR LastName LIKE '%'+ @search +'%')
				AND Pr.IdProject IN (SELECT DISTINCT IdProject FROM KPI_T_ProjectUser WHERE KPI_T_ProjectUser.idUser=@idUser))
		AS t 
		WHERE t.RowNum between (@curentPage-1)*@pageSize + 1 and @curentPage*@pageSize
END
END
GO
/****** Object:  StoredProcedure [dbo].[SP_TASKLIST]    Script Date: 12/30/2020 8:42:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SP_TASKLIST]
@IdProject AS INT
AS
BEGIN 
SELECT IdTask, Content FROM KPI_T_Task WHERE Deleted = 0 AND IdProject = @IdProject
END
GO
/****** Object:  StoredProcedure [dbo].[SP_UPDATE_ERRORANALYSIS]    Script Date: 12/30/2020 8:42:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SP_UPDATE_ERRORANALYSIS]
@Bug AS INT,
@Reference AS NVARCHAR(MAX),
@IdError AS INT, 
@idPhase INT,
@idTask INT,
@IdErrorAnalysis INT,
@IdUsers NCHAR(6)
AS
DECLARE @IdQualityAnalysis INT
DECLARE @checkUserLeader NVARCHAR(50)=NULL
SELECT @IdQualityAnalysis=IdQualityAnalysis FROM KPI_T_QualityAnalysis WHERE IdTask = @idTask AND IdPhase=@idPhase
SELECT @checkUserLeader = PU.idUser FROM KPI_T_Task T JOIN KPI_T_ProjectUser PU ON T.IdProject=PU.IdProject WHERE PU.IdUser=@IdUsers AND IdTask=@idTask
		IF @checkUserLeader IS NOT NULL
UPDATE KPI_T_ErrorAnalysis SET Bug = @Bug,Reference = @Reference,IdError = @IdError ,IdQualityAnalysis = @IdQualityAnalysis WHERE IdErrorAnalysis=@IdErrorAnalysis 
GO
/****** Object:  StoredProcedure [dbo].[SP_UPDATE_LOCK_USER]    Script Date: 12/30/2020 8:42:36 AM ******/
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
/****** Object:  StoredProcedure [dbo].[SP_UPDATE_PASSWORD]    Script Date: 12/30/2020 8:42:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_UPDATE_PASSWORD]
@username NVARCHAR(50),
@password NVARCHAR(50)
AS
BEGIN
	UPDATE KPI_M_User
	SET Password=CONVERT(VARCHAR(32), HashBytes('MD5', @password), 2)
	WHERE Username=@username
END
GO
/****** Object:  StoredProcedure [dbo].[SP_UPDATE_PROJECT]    Script Date: 12/30/2020 8:42:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_UPDATE_PROJECT]
@idProject int,
@idUser nchar(6),
@idDepartment int,
@idPL nchar(6),
@nameProject nvarchar(50)
 AS
 BEGIN TRANSACTION
	UPDATE KPI_M_Project
	SET IdDepartment= @idDepartment, NameProject= @nameProject,UpdateBy=@idUser,UpdateAt=GETDATE()
	FROM KPI_M_Project JOIN KPI_M_Department ON KPI_M_Project.IdDepartment= KPI_M_Department.IdDerpartment
	WHERE IdProject=@idProject

	UPDATE KPI_T_ProjectUser
	SET idUser=@idPL
	FROM KPI_T_ProjectUser JOIN KPI_M_User ON KPI_T_ProjectUser.idUser= KPI_M_User.IdUser
	WHERE IdProject=@idProject AND KPI_M_User.IdRole=3
	DELETE PU FROM KPI_T_ProjectUser PU JOIN KPI_M_User U ON U.IdUser=PU.idUser
				WHERE U.IdRole=4 AND PU.IdProject=@idProject
 COMMIT
GO
/****** Object:  StoredProcedure [dbo].[SP_UPDATE_TASKLIST]    Script Date: 12/30/2020 8:42:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_UPDATE_TASKLIST]
@Content NVARCHAR(500),
@IdLevel INT,
@IdUser NCHAR(6),
@IdTask INT,
@UserId NCHAR(6),
@UpdateAt DATE,
@UpdateBy NVARCHAR(10)
AS
BEGIN

DECLARE @checkUserLeader NVARCHAR(50)=NULL
		SELECT @checkUserLeader = PU.idUser FROM KPI_T_Task T JOIN KPI_T_ProjectUser PU ON T.IdProject=PU.IdProject WHERE PU.IdUser=@UserId AND IdTask=@idTask
		IF @checkUserLeader IS NOT NULL
		BEGIN
			UPDATE [KPI_T_Task] SET Content=@Content,IdLevel=@IdLevel,IdUser=@IdUser, UpdateAt=@UpdateAt, UpdateBy=@UpdateBy WHERE IdTask=@IdTask SELECT @@IDENTITY
		END
END
GO
/****** Object:  StoredProcedure [dbo].[UPDATE_REASON_AND_HOUR]    Script Date: 12/30/2020 8:42:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[UPDATE_REASON_AND_HOUR]
@idUser nchar(6),
@role NVARCHAR(50),
@idProject INT,
@idTask INT,
@hourDesign FLOAT,
@hourCode FLOAT,
@hourTest FLOAT,
@Reason	NVARCHAR(MAX)
AS
BEGIN
	BEGIN TRAN
		IF @role='Leader'
		BEGIN
		DECLARE @checkUserLeader NVARCHAR(50)=NULL
		SELECT @checkUserLeader = PU.idUser FROM KPI_T_Task T JOIN KPI_T_ProjectUser PU ON T.IdProject=PU.IdProject WHERE PU.IdUser=@idUser AND IdTask=@idTask AND T.IdProject=@idProject
		IF @checkUserLeader IS NOT NULL
		BEGIN
			UPDATE KPI_T_QualityAnalysis SET Hour=@hourDesign WHERE IdTask=@idTask AND IdPhase=1
			UPDATE KPI_T_QualityAnalysis SET Hour=@hourCode WHERE IdTask=@idTask AND IdPhase=2
			UPDATE KPI_T_QualityAnalysis SET Hour=@hourTest WHERE IdTask=@idTask AND IdPhase=3
			UPDATE KPI_T_Task SET Reason=@Reason WHERE IdTask=@idTask AND IdProject=@idProject
		END
		END
	COMMIT
END
GO
USE [master]
GO
ALTER DATABASE [KPI] SET  READ_WRITE 
GO
