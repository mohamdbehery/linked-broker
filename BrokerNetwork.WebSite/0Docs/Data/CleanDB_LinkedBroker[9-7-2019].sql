USE [master]
GO
/****** Object:  Database [LinkedBroker]    Script Date: 7/9/2019 12:29:11 PM ******/
CREATE DATABASE [LinkedBroker]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'LinkedBroker', FILENAME = N'E:\MSSQL.MSSQLSERVER\DATA\LinkedBroker.mdf' , SIZE = 5120KB , MAXSIZE = 204800KB , FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'LinkedBroker_log', FILENAME = N'D:\MSSQL.MSSQLSERVER\DATA\LinkedBroker_log.ldf' , SIZE = 1024KB , MAXSIZE = 102400KB , FILEGROWTH = 1024KB )
GO
ALTER DATABASE [LinkedBroker] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [LinkedBroker].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [LinkedBroker] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [LinkedBroker] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [LinkedBroker] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [LinkedBroker] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [LinkedBroker] SET ARITHABORT OFF 
GO
ALTER DATABASE [LinkedBroker] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [LinkedBroker] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [LinkedBroker] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [LinkedBroker] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [LinkedBroker] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [LinkedBroker] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [LinkedBroker] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [LinkedBroker] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [LinkedBroker] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [LinkedBroker] SET  ENABLE_BROKER 
GO
ALTER DATABASE [LinkedBroker] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [LinkedBroker] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [LinkedBroker] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [LinkedBroker] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [LinkedBroker] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [LinkedBroker] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [LinkedBroker] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [LinkedBroker] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [LinkedBroker] SET  MULTI_USER 
GO
ALTER DATABASE [LinkedBroker] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [LinkedBroker] SET DB_CHAINING OFF 
GO
ALTER DATABASE [LinkedBroker] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [LinkedBroker] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [LinkedBroker] SET DELAYED_DURABILITY = DISABLED 
GO
USE [LinkedBroker]
GO
/****** Object:  User [Broker]    Script Date: 7/9/2019 12:29:12 PM ******/
CREATE USER [Broker] FOR LOGIN [Broker] WITH DEFAULT_SCHEMA=[Broker]
GO
/****** Object:  DatabaseRole [gd_execprocs]    Script Date: 7/9/2019 12:29:12 PM ******/
CREATE ROLE [gd_execprocs]
GO
ALTER ROLE [db_securityadmin] ADD MEMBER [Broker]
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [Broker]
GO
ALTER ROLE [db_backupoperator] ADD MEMBER [Broker]
GO
ALTER ROLE [db_datareader] ADD MEMBER [Broker]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [Broker]
GO
/****** Object:  Schema [Broker]    Script Date: 7/9/2019 12:29:13 PM ******/
CREATE SCHEMA [Broker]
GO
/****** Object:  Table [dbo].[Comments]    Script Date: 7/9/2019 12:29:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comments](
	[CommentID] [bigint] IDENTITY(1,1) NOT NULL,
	[UserID] [bigint] NULL,
	[PostID] [bigint] NULL,
	[PostType] [int] NULL,
	[CommentMsg] [nvarchar](max) NULL,
	[CreatedDate] [datetime] NULL,
 CONSTRAINT [PK_Comments] PRIMARY KEY CLUSTERED 
(
	[CommentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Companies]    Script Date: 7/9/2019 12:29:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Companies](
	[CompanyID] [int] IDENTITY(1,1) NOT NULL,
	[CompanyName] [nvarchar](200) NOT NULL,
	[CompanyDesc] [nvarchar](max) NOT NULL,
	[CompanyVerificationTypeID] [int] NOT NULL,
	[Address] [nvarchar](250) NULL,
	[CompanyTypeID] [int] NOT NULL,
	[Email] [nvarchar](50) NULL,
	[Contacts] [nvarchar](250) NULL,
	[ImgPath] [nvarchar](250) NULL,
	[ByUserID] [bigint] NOT NULL,
	[EntryDate] [datetime] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[ContactsForBrokers] [nvarchar](250) NULL,
 CONSTRAINT [PK_Companies] PRIMARY KEY CLUSTERED 
(
	[CompanyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CompanyBrokers]    Script Date: 7/9/2019 12:29:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CompanyBrokers](
	[CompanyBrokerID] [bigint] IDENTITY(1,1) NOT NULL,
	[CompanyID] [int] NOT NULL,
	[UserID] [bigint] NOT NULL,
 CONSTRAINT [PK_CompanyBrokers] PRIMARY KEY CLUSTERED 
(
	[CompanyBrokerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CompanyTypes]    Script Date: 7/9/2019 12:29:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CompanyTypes](
	[CompanyTypeID] [int] IDENTITY(1,1) NOT NULL,
	[CompanyTypeTitle] [nvarchar](50) NULL,
 CONSTRAINT [PK_CompanyTypes] PRIMARY KEY CLUSTERED 
(
	[CompanyTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CompanyVerificationTypes]    Script Date: 7/9/2019 12:29:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CompanyVerificationTypes](
	[CompanyVerificationTypeID] [int] IDENTITY(1,1) NOT NULL,
	[VerificationTitle] [nvarchar](200) NOT NULL,
	[ByUserID] [int] NOT NULL,
	[EntryDate] [datetime] NOT NULL CONSTRAINT [DF_CompanyVerificationTypes_EntryDate]  DEFAULT (getdate()),
	[IsActive] [bit] NOT NULL CONSTRAINT [DF_CompanyVerificationTypes_IsActive]  DEFAULT ((1)),
	[IsDeleted] [bit] NOT NULL CONSTRAINT [DF_CompanyVerificationTypes_IsDeleted]  DEFAULT ((0)),
 CONSTRAINT [PK_CompanyVerificationTypes] PRIMARY KEY CLUSTERED 
(
	[CompanyVerificationTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CusomerPreviews]    Script Date: 7/9/2019 12:29:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CusomerPreviews](
	[CustomerPreviewID] [bigint] IDENTITY(1,1) NOT NULL,
	[PropertyID] [bigint] NOT NULL,
	[CustomerID] [bigint] NOT NULL,
	[PreviewDate] [datetime] NOT NULL,
	[PreviewTime] [time](7) NULL,
	[PreviewStatusID] [int] NOT NULL,
	[NoOfProperties] [int] NOT NULL,
	[ShawAlertBeforeMinutes] [nvarchar](50) NOT NULL,
	[Comments] [nvarchar](max) NULL,
	[ByUserID] [bigint] NOT NULL,
	[EntryDate] [datetime] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_CusomerPreviews] PRIMARY KEY CLUSTERED 
(
	[CustomerPreviewID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Customer.CustomerStatus]    Script Date: 7/9/2019 12:29:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer.CustomerStatus](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[CustomerID] [bigint] NOT NULL,
	[CustomerStatusID] [int] NOT NULL,
	[Comments] [nvarchar](max) NOT NULL,
	[ByUserID] [bigint] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Customer.CustomerStatus] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Customers]    Script Date: 7/9/2019 12:29:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[CustomerID] [bigint] IDENTITY(1,1) NOT NULL,
	[CompanyID] [int] NULL,
	[CustomerStatusID] [int] NOT NULL,
	[CustomerName] [nvarchar](250) NOT NULL,
	[Notes] [nvarchar](max) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ByUserID] [bigint] NOT NULL,
	[Comments] [nvarchar](max) NULL,
	[EntryDate] [datetime] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CustomerStatus]    Script Date: 7/9/2019 12:29:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerStatus](
	[CustomerStatusID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerStatusTitle] [nvarchar](100) NOT NULL,
	[ByUserID] [bigint] NOT NULL,
	[EntryDate] [datetime] NOT NULL CONSTRAINT [DF_CustomerStatus_EntryDate]  DEFAULT (getdate()),
	[IsActive] [bit] NOT NULL CONSTRAINT [DF_CustomerStatus_IsActive]  DEFAULT ((1)),
	[IsDeleted] [bit] NOT NULL CONSTRAINT [DF_CustomerStatus_IsDeleted]  DEFAULT ((0)),
 CONSTRAINT [PK_CusomersStatus] PRIMARY KEY CLUSTERED 
(
	[CustomerStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Files]    Script Date: 7/9/2019 12:29:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Files](
	[FileID] [bigint] IDENTITY(1,1) NOT NULL,
	[ParentID] [bigint] NOT NULL,
	[ParentType] [nvarchar](50) NULL,
	[FileName] [nvarchar](250) NULL,
	[FileType] [nvarchar](50) NULL,
	[OrginalFileName] [nvarchar](250) NULL,
	[IsActive] [bit] NULL,
	[IsDeleted] [bit] NULL,
	[CreatedDate] [datetime] NULL,
	[LastUpdated] [datetime] NULL,
 CONSTRAINT [PK_Files] PRIMARY KEY CLUSTERED 
(
	[FileID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[FilesLines]    Script Date: 7/9/2019 12:29:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FilesLines](
	[FilesLineID] [bigint] NOT NULL,
	[ParentID] [bigint] NULL,
	[ParentTypeID] [char](2) NULL,
	[Path] [nvarchar](250) NULL,
	[IsDeleted] [bit] NULL,
 CONSTRAINT [PK_FilesLines] PRIMARY KEY CLUSTERED 
(
	[FilesLineID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Locations]    Script Date: 7/9/2019 12:29:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Locations](
	[LocationID] [int] IDENTITY(1,1) NOT NULL,
	[ParentID] [int] NULL,
	[LocationName] [nvarchar](50) NOT NULL,
	[ByUserID] [bigint] NOT NULL,
	[EntryDate] [datetime] NOT NULL CONSTRAINT [DF_Locations_EntryDate]  DEFAULT (getdate()),
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Locations] PRIMARY KEY CLUSTERED 
(
	[LocationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OwnerShipTypes]    Script Date: 7/9/2019 12:29:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OwnerShipTypes](
	[OwnerShipTypeID] [int] IDENTITY(1,1) NOT NULL,
	[OwnerShipTitle] [nvarchar](100) NOT NULL,
	[ByUserID] [bigint] NOT NULL,
	[EntryDate] [datetime] NOT NULL CONSTRAINT [DF_OwnerShipTypes_EntryDate]  DEFAULT (getdate()),
	[IsActive] [bit] NOT NULL CONSTRAINT [DF_OwnerShipTypes_IsActive]  DEFAULT ((1)),
	[IsDeleted] [bit] NOT NULL CONSTRAINT [DF_OwnerShipTypes_IsDeleted]  DEFAULT ((0)),
 CONSTRAINT [PK_OwnerShips] PRIMARY KEY CLUSTERED 
(
	[OwnerShipTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Permission.PermissionGroup]    Script Date: 7/9/2019 12:29:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Permission.PermissionGroup](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[PermissionGroupID] [int] NOT NULL,
	[UserPermissionID] [int] NOT NULL,
	[ByUserID] [bigint] NOT NULL,
 CONSTRAINT [PK_Permission.PermissionGroup] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PermissionGroups]    Script Date: 7/9/2019 12:29:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PermissionGroups](
	[PermissionGroupID] [int] IDENTITY(1,1) NOT NULL,
	[GroupName] [nvarchar](100) NOT NULL,
	[ByUserID] [bigint] NOT NULL,
	[EntryDate] [datetime] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_PermissionGroups] PRIMARY KEY CLUSTERED 
(
	[PermissionGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PreviewStatus]    Script Date: 7/9/2019 12:29:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PreviewStatus](
	[PreviewStatusID] [int] IDENTITY(1,1) NOT NULL,
	[StatusTitle] [nvarchar](100) NOT NULL,
	[ByUserID] [bigint] NOT NULL,
	[EntryDate] [datetime] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_PreviewStatus] PRIMARY KEY CLUSTERED 
(
	[PreviewStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Projects]    Script Date: 7/9/2019 12:29:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Projects](
	[CompanyID] [int] NOT NULL,
	[ProjectID] [int] IDENTITY(1,1) NOT NULL,
	[ProjectTypeID] [int] NOT NULL,
	[ProjectName] [nvarchar](250) NOT NULL,
	[LocationID] [int] NOT NULL,
	[AddressDetails] [nvarchar](250) NOT NULL,
	[NoOfUnits] [int] NULL,
	[ProjectStatusID] [int] NOT NULL,
	[ByUserID] [bigint] NOT NULL,
	[EntryDate] [datetime] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Projects] PRIMARY KEY CLUSTERED 
(
	[ProjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProjectStatus]    Script Date: 7/9/2019 12:29:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProjectStatus](
	[ProjectStatusID] [int] IDENTITY(1,1) NOT NULL,
	[StatusTitle] [nvarchar](100) NOT NULL,
	[ByUserID] [bigint] NOT NULL,
	[EntryDate] [datetime] NOT NULL CONSTRAINT [DF_ProjectStatus_EntryDate]  DEFAULT (getdate()),
	[IsActive] [bit] NOT NULL CONSTRAINT [DF_ProjectStatus_IsActive]  DEFAULT ((1)),
	[IsDeleted] [bit] NOT NULL CONSTRAINT [DF_ProjectStatus_IsDeleted]  DEFAULT ((0)),
 CONSTRAINT [PK_ProjectStatus] PRIMARY KEY CLUSTERED 
(
	[ProjectStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProjectTypes]    Script Date: 7/9/2019 12:29:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProjectTypes](
	[ProjectTypeID] [int] IDENTITY(1,1) NOT NULL,
	[ProjectTypeName] [nvarchar](50) NULL,
	[IsActive] [bit] NULL,
	[IsDeleted] [bit] NULL,
 CONSTRAINT [PK_ProjectTypes] PRIMARY KEY CLUSTERED 
(
	[ProjectTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Properties]    Script Date: 7/9/2019 12:29:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Properties](
	[PropertyID] [bigint] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](150) NULL,
	[CustomerID] [int] NOT NULL,
	[ByUserID] [bigint] NOT NULL,
	[LocationID] [int] NOT NULL,
	[AddressDetails] [nvarchar](250) NOT NULL,
	[ProjectID] [int] NULL,
	[IsUnit] [bit] NOT NULL,
	[Price] [decimal](9, 0) NOT NULL,
	[CanInstallment] [bit] NOT NULL,
	[NoOfYears] [int] NULL,
	[DownPayment] [decimal](9, 0) NULL,
	[FloorNum] [int] NOT NULL,
	[PropertyFloorTypeID] [int] NOT NULL,
	[NoOfProperties] [int] NOT NULL,
	[Area] [int] NOT NULL,
	[OwnerShipTypeID] [int] NOT NULL,
	[PropertyTypeID] [int] NOT NULL,
	[PropertyPurposeID] [int] NOT NULL,
	[HasElevator] [bit] NOT NULL,
	[HasGarage] [bit] NOT NULL,
	[AllowVisitors] [bit] NOT NULL,
	[Commission] [float] NULL,
	[NumberOfRooms] [int] NOT NULL,
	[NumberOfBathrooms] [int] NOT NULL,
	[ReadyDate] [date] NOT NULL,
	[LastUpdated] [datetime] NOT NULL,
	[SharedID] [nvarchar](50) NULL,
	[Comments] [nvarchar](max) NULL,
	[EntryDate] [datetime] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[CommissionType] [int] NULL,
 CONSTRAINT [PK_Properties] PRIMARY KEY CLUSTERED 
(
	[PropertyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PropertyFloorTypes]    Script Date: 7/9/2019 12:29:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PropertyFloorTypes](
	[PropertyFloorTypeID] [int] IDENTITY(1,1) NOT NULL,
	[FloorTypeTitle] [nvarchar](100) NOT NULL,
	[ByUserID] [bigint] NOT NULL,
	[EntryDate] [datetime] NOT NULL CONSTRAINT [DF_PropertyFloorTypes_EntryDate]  DEFAULT (getdate()),
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_FloorTypes] PRIMARY KEY CLUSTERED 
(
	[PropertyFloorTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PropertyPictures]    Script Date: 7/9/2019 12:29:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PropertyPictures](
	[PropertyID] [bigint] NOT NULL,
	[PropPictureID] [bigint] IDENTITY(1,1) NOT NULL,
	[PicturePath] [nvarchar](500) NOT NULL,
	[PropDesc] [nchar](10) NULL,
	[EntryDate] [datetime] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_PropertyPictures] PRIMARY KEY CLUSTERED 
(
	[PropPictureID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PropertyPurpose]    Script Date: 7/9/2019 12:29:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PropertyPurpose](
	[PropertyPurposeID] [int] IDENTITY(1,1) NOT NULL,
	[PropPurposeTitle] [nvarchar](100) NOT NULL,
	[ByUserID] [bigint] NOT NULL,
	[EntryDate] [datetime] NOT NULL CONSTRAINT [DF_PropertyPurpose_EntryDate]  DEFAULT (getdate()),
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_SectionTypes] PRIMARY KEY CLUSTERED 
(
	[PropertyPurposeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PropertyRequests]    Script Date: 7/9/2019 12:29:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PropertyRequests](
	[RequestID] [bigint] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](150) NULL,
	[CustomerID] [int] NOT NULL,
	[GovID] [int] NULL,
	[CityID] [int] NULL,
	[LocationIDs] [int] NULL,
	[AddressDetails] [nvarchar](250) NULL,
	[MinPrice] [decimal](9, 0) NULL,
	[MaxPrice] [decimal](9, 0) NULL,
	[CanInstallment] [bit] NOT NULL,
	[NoOfYears] [int] NULL,
	[PropertyFloorTypeID] [int] NULL,
	[MinArea] [int] NULL,
	[MaxArea] [int] NULL,
	[OwnerShipTypeID] [int] NULL,
	[PropertyTypeID] [int] NULL,
	[PropertyPurposeID] [int] NULL,
	[Comments] [nvarchar](max) NULL,
	[ByUserID] [bigint] NOT NULL,
	[EntryDate] [datetime] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_PropertyRequests] PRIMARY KEY CLUSTERED 
(
	[RequestID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PropertyRequests.FollowUp]    Script Date: 7/9/2019 12:29:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PropertyRequests.FollowUp](
	[FollowUpID] [bigint] IDENTITY(1,1) NOT NULL,
	[RequestID] [bigint] NOT NULL,
	[RequestStatusID] [int] NOT NULL,
	[Comments] [nvarchar](max) NOT NULL,
	[ByUserID] [bigint] NOT NULL,
	[EntryDate] [datetime] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Requests.FollowUp] PRIMARY KEY CLUSTERED 
(
	[FollowUpID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PropertyTypes]    Script Date: 7/9/2019 12:29:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PropertyTypes](
	[PropertyTypeID] [int] IDENTITY(1,1) NOT NULL,
	[PropTypeTitle] [nvarchar](100) NOT NULL,
	[ByUserID] [bigint] NOT NULL,
	[EntryDate] [datetime] NOT NULL CONSTRAINT [DF_PropertyTypes_EntryDate]  DEFAULT (getdate()),
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_BuilderClasses] PRIMARY KEY CLUSTERED 
(
	[PropertyTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RequestStatus]    Script Date: 7/9/2019 12:29:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RequestStatus](
	[RequestStatusID] [int] IDENTITY(1,1) NOT NULL,
	[StatusTitle] [nvarchar](100) NOT NULL,
	[ByUserID] [bigint] NOT NULL,
	[EntryDate] [datetime] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_RequestStatus] PRIMARY KEY CLUSTERED 
(
	[RequestStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Shared]    Script Date: 7/9/2019 12:29:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Shared](
	[ShareID] [nvarchar](50) NOT NULL,
	[ShareTitle] [nvarchar](50) NULL,
 CONSTRAINT [PK_Shared] PRIMARY KEY CLUSTERED 
(
	[ShareID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SpecialOffers]    Script Date: 7/9/2019 12:29:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SpecialOffers](
	[OfferID] [int] IDENTITY(1,1) NOT NULL,
	[OfferTitle] [nvarchar](250) NOT NULL,
	[OfferDesc] [nvarchar](max) NULL,
	[EntryDate] [datetime] NOT NULL,
	[ImgPath] [nvarchar](250) NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[ByUserID] [bigint] NULL,
	[SortOrder] [int] NULL,
 CONSTRAINT [PK_SpecialOffers] PRIMARY KEY CLUSTERED 
(
	[OfferID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Transactions]    Script Date: 7/9/2019 12:29:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transactions](
	[PreviewID] [bigint] NOT NULL,
	[TransactionID] [bigint] IDENTITY(1,1) NOT NULL,
	[PropertyID] [bigint] NOT NULL,
	[CustomerID] [bigint] NOT NULL,
	[PreviewDate] [date] NOT NULL,
	[PreviewTime] [time](7) NULL,
	[Reason] [nvarchar](500) NULL,
	[PreviewStatusID] [int] NOT NULL,
	[ByUserID] [bigint] NOT NULL,
	[EntryDate] [datetime] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Transactions] PRIMARY KEY CLUSTERED 
(
	[TransactionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[User.UserPermission]    Script Date: 7/9/2019 12:29:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User.UserPermission](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [bigint] NOT NULL,
	[UserPermissionID] [int] NOT NULL,
	[ByUserID] [bigint] NOT NULL,
 CONSTRAINT [PK_User.UserPermission] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UserGroups]    Script Date: 7/9/2019 12:29:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserGroups](
	[UserGroupName] [nvarchar](50) NOT NULL,
	[UserGroupDesc] [nvarchar](max) NULL,
 CONSTRAINT [PK_UserGroups] PRIMARY KEY CLUSTERED 
(
	[UserGroupName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UserPermission]    Script Date: 7/9/2019 12:29:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserPermission](
	[UserPermissionID] [int] IDENTITY(1,1) NOT NULL,
	[PermissionTitle] [nvarchar](100) NOT NULL,
	[ByUserID] [bigint] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_UserPermission] PRIMARY KEY CLUSTERED 
(
	[UserPermissionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Users]    Script Date: 7/9/2019 12:29:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [bigint] IDENTITY(1,1) NOT NULL,
	[CompanyID] [int] NULL,
	[UserGroupName] [nvarchar](50) NOT NULL,
	[IsVerfied] [bit] NULL,
	[FullName] [nvarchar](250) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[Mobile] [nvarchar](20) NOT NULL,
	[UserPassword] [nvarchar](250) NOT NULL,
	[FavouriteLocationIDs] [nvarchar](50) NULL,
	[Notes] [nvarchar](max) NULL,
	[ProfileImgPath] [nvarchar](250) NULL,
	[IsConfirmed] [bit] NOT NULL,
	[LastLogin] [datetime] NULL,
	[ByUserID] [bigint] NULL,
	[EntryDate] [datetime] NOT NULL CONSTRAINT [DF_Users_EntryDate]  DEFAULT (getdate()),
	[Provider] [nvarchar](50) NULL,
	[ProviderID] [nvarchar](50) NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[VerficationRequests]    Script Date: 7/9/2019 12:29:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VerficationRequests](
	[VerficationID] [bigint] IDENTITY(1,1) NOT NULL,
	[UserID] [bigint] NOT NULL,
	[CompanyID] [int] NOT NULL,
	[RequestContent] [nvarchar](max) NULL,
	[VerfiedStatusID] [int] NULL,
	[AdminMessage] [nvarchar](max) NULL,
	[LastUpdated] [datetime] NOT NULL,
	[EntryDate] [datetime] NOT NULL,
 CONSTRAINT [PK_VerficationRequests_1] PRIMARY KEY CLUSTERED 
(
	[VerficationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[VerficationStatus]    Script Date: 7/9/2019 12:29:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VerficationStatus](
	[VerfiedStatusID] [int] IDENTITY(1,1) NOT NULL,
	[VerfiedStatusTitle] [nvarchar](50) NULL,
 CONSTRAINT [PK_VerficationStatus] PRIMARY KEY CLUSTERED 
(
	[VerfiedStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[Companies] ADD  CONSTRAINT [DF_Companies_EntryDate]  DEFAULT (getdate()) FOR [EntryDate]
GO
ALTER TABLE [dbo].[CusomerPreviews] ADD  CONSTRAINT [DF_CusomerPreviews_NoOfProperties]  DEFAULT ((1)) FOR [NoOfProperties]
GO
ALTER TABLE [dbo].[CusomerPreviews] ADD  CONSTRAINT [DF_CusomerPreviews_EntryDate_1]  DEFAULT (getdate()) FOR [EntryDate]
GO
ALTER TABLE [dbo].[Customer.CustomerStatus] ADD  CONSTRAINT [DF_Customer.CustomerStatus_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[Customers] ADD  CONSTRAINT [DF_Customers_EntryDate]  DEFAULT (getdate()) FOR [EntryDate]
GO
ALTER TABLE [dbo].[PermissionGroups] ADD  CONSTRAINT [DF_PermissionGroups_EntryDate]  DEFAULT (getdate()) FOR [EntryDate]
GO
ALTER TABLE [dbo].[PermissionGroups] ADD  CONSTRAINT [DF_PermissionGroups_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[PermissionGroups] ADD  CONSTRAINT [DF_PermissionGroups_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[PreviewStatus] ADD  CONSTRAINT [DF_PreviewStatus_EntryDate]  DEFAULT (getdate()) FOR [EntryDate]
GO
ALTER TABLE [dbo].[Projects] ADD  CONSTRAINT [DF_Projects_EntryDate]  DEFAULT (getdate()) FOR [EntryDate]
GO
ALTER TABLE [dbo].[Properties] ADD  CONSTRAINT [DF_Properties_EntryDate]  DEFAULT (getdate()) FOR [EntryDate]
GO
ALTER TABLE [dbo].[PropertyPictures] ADD  CONSTRAINT [DF_PropertyPictures_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[PropertyPictures] ADD  CONSTRAINT [DF_PropertyPictures_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[PropertyRequests] ADD  CONSTRAINT [DF_PropertyRequests_EntryDate]  DEFAULT (getdate()) FOR [EntryDate]
GO
ALTER TABLE [dbo].[PropertyRequests.FollowUp] ADD  CONSTRAINT [DF_Requests.FollowUp_EntryDate]  DEFAULT (getdate()) FOR [EntryDate]
GO
ALTER TABLE [dbo].[PropertyRequests.FollowUp] ADD  CONSTRAINT [DF_Requests.FollowUp_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[RequestStatus] ADD  CONSTRAINT [DF_RequestStatus_EntryDate]  DEFAULT (getdate()) FOR [EntryDate]
GO
ALTER TABLE [dbo].[Transactions] ADD  CONSTRAINT [DF_Transactions_EntryDate_1]  DEFAULT (getdate()) FOR [EntryDate]
GO
ALTER TABLE [dbo].[UserPermission] ADD  CONSTRAINT [DF_UserPermission_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[Comments]  WITH CHECK ADD  CONSTRAINT [FK_Comments_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Comments] CHECK CONSTRAINT [FK_Comments_Users]
GO
ALTER TABLE [dbo].[Companies]  WITH CHECK ADD  CONSTRAINT [FK_Companies_CompanyTypes] FOREIGN KEY([CompanyTypeID])
REFERENCES [dbo].[CompanyTypes] ([CompanyTypeID])
GO
ALTER TABLE [dbo].[Companies] CHECK CONSTRAINT [FK_Companies_CompanyTypes]
GO
ALTER TABLE [dbo].[Companies]  WITH CHECK ADD  CONSTRAINT [FK_Companies_CompanyVerificationTypes] FOREIGN KEY([CompanyVerificationTypeID])
REFERENCES [dbo].[CompanyVerificationTypes] ([CompanyVerificationTypeID])
GO
ALTER TABLE [dbo].[Companies] CHECK CONSTRAINT [FK_Companies_CompanyVerificationTypes]
GO
ALTER TABLE [dbo].[CompanyBrokers]  WITH CHECK ADD  CONSTRAINT [FK_CompanyBrokers_Companies] FOREIGN KEY([CompanyID])
REFERENCES [dbo].[Companies] ([CompanyID])
GO
ALTER TABLE [dbo].[CompanyBrokers] CHECK CONSTRAINT [FK_CompanyBrokers_Companies]
GO
ALTER TABLE [dbo].[CompanyBrokers]  WITH CHECK ADD  CONSTRAINT [FK_CompanyBrokers_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[CompanyBrokers] CHECK CONSTRAINT [FK_CompanyBrokers_Users]
GO
ALTER TABLE [dbo].[CusomerPreviews]  WITH CHECK ADD  CONSTRAINT [FK_CusomerPreviews_Customers] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customers] ([CustomerID])
GO
ALTER TABLE [dbo].[CusomerPreviews] CHECK CONSTRAINT [FK_CusomerPreviews_Customers]
GO
ALTER TABLE [dbo].[CusomerPreviews]  WITH CHECK ADD  CONSTRAINT [FK_CusomerPreviews_PreviewStatus] FOREIGN KEY([PreviewStatusID])
REFERENCES [dbo].[PreviewStatus] ([PreviewStatusID])
GO
ALTER TABLE [dbo].[CusomerPreviews] CHECK CONSTRAINT [FK_CusomerPreviews_PreviewStatus]
GO
ALTER TABLE [dbo].[Customer.CustomerStatus]  WITH CHECK ADD  CONSTRAINT [FK_Customer.CustomerStatus_Customers] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customers] ([CustomerID])
GO
ALTER TABLE [dbo].[Customer.CustomerStatus] CHECK CONSTRAINT [FK_Customer.CustomerStatus_Customers]
GO
ALTER TABLE [dbo].[Customer.CustomerStatus]  WITH CHECK ADD  CONSTRAINT [FK_Customer.CustomerStatus_CustomerStatus] FOREIGN KEY([CustomerStatusID])
REFERENCES [dbo].[CustomerStatus] ([CustomerStatusID])
GO
ALTER TABLE [dbo].[Customer.CustomerStatus] CHECK CONSTRAINT [FK_Customer.CustomerStatus_CustomerStatus]
GO
ALTER TABLE [dbo].[Customers]  WITH CHECK ADD  CONSTRAINT [FK_Customers_CustomerStatus] FOREIGN KEY([CustomerStatusID])
REFERENCES [dbo].[CustomerStatus] ([CustomerStatusID])
GO
ALTER TABLE [dbo].[Customers] CHECK CONSTRAINT [FK_Customers_CustomerStatus]
GO
ALTER TABLE [dbo].[Customers]  WITH CHECK ADD  CONSTRAINT [FK_Customers_Users] FOREIGN KEY([ByUserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Customers] CHECK CONSTRAINT [FK_Customers_Users]
GO
ALTER TABLE [dbo].[Permission.PermissionGroup]  WITH CHECK ADD  CONSTRAINT [FK_Permission.PermissionGroup_PermissionGroups] FOREIGN KEY([PermissionGroupID])
REFERENCES [dbo].[PermissionGroups] ([PermissionGroupID])
GO
ALTER TABLE [dbo].[Permission.PermissionGroup] CHECK CONSTRAINT [FK_Permission.PermissionGroup_PermissionGroups]
GO
ALTER TABLE [dbo].[Permission.PermissionGroup]  WITH CHECK ADD  CONSTRAINT [FK_Permission.PermissionGroup_UserPermission] FOREIGN KEY([UserPermissionID])
REFERENCES [dbo].[UserPermission] ([UserPermissionID])
GO
ALTER TABLE [dbo].[Permission.PermissionGroup] CHECK CONSTRAINT [FK_Permission.PermissionGroup_UserPermission]
GO
ALTER TABLE [dbo].[Projects]  WITH CHECK ADD  CONSTRAINT [FK_Projects_Companies] FOREIGN KEY([CompanyID])
REFERENCES [dbo].[Companies] ([CompanyID])
GO
ALTER TABLE [dbo].[Projects] CHECK CONSTRAINT [FK_Projects_Companies]
GO
ALTER TABLE [dbo].[Projects]  WITH CHECK ADD  CONSTRAINT [FK_Projects_Locations] FOREIGN KEY([LocationID])
REFERENCES [dbo].[Locations] ([LocationID])
GO
ALTER TABLE [dbo].[Projects] CHECK CONSTRAINT [FK_Projects_Locations]
GO
ALTER TABLE [dbo].[Projects]  WITH CHECK ADD  CONSTRAINT [FK_Projects_ProjectStatus] FOREIGN KEY([ProjectStatusID])
REFERENCES [dbo].[ProjectStatus] ([ProjectStatusID])
GO
ALTER TABLE [dbo].[Projects] CHECK CONSTRAINT [FK_Projects_ProjectStatus]
GO
ALTER TABLE [dbo].[Projects]  WITH CHECK ADD  CONSTRAINT [FK_Projects_ProjectTypes] FOREIGN KEY([ProjectTypeID])
REFERENCES [dbo].[ProjectTypes] ([ProjectTypeID])
GO
ALTER TABLE [dbo].[Projects] CHECK CONSTRAINT [FK_Projects_ProjectTypes]
GO
ALTER TABLE [dbo].[Properties]  WITH CHECK ADD  CONSTRAINT [FK_Properties_FloorTypes] FOREIGN KEY([PropertyFloorTypeID])
REFERENCES [dbo].[PropertyFloorTypes] ([PropertyFloorTypeID])
GO
ALTER TABLE [dbo].[Properties] CHECK CONSTRAINT [FK_Properties_FloorTypes]
GO
ALTER TABLE [dbo].[Properties]  WITH CHECK ADD  CONSTRAINT [FK_Properties_Locations] FOREIGN KEY([LocationID])
REFERENCES [dbo].[Locations] ([LocationID])
GO
ALTER TABLE [dbo].[Properties] CHECK CONSTRAINT [FK_Properties_Locations]
GO
ALTER TABLE [dbo].[Properties]  WITH CHECK ADD  CONSTRAINT [FK_Properties_OwnerShips] FOREIGN KEY([OwnerShipTypeID])
REFERENCES [dbo].[OwnerShipTypes] ([OwnerShipTypeID])
GO
ALTER TABLE [dbo].[Properties] CHECK CONSTRAINT [FK_Properties_OwnerShips]
GO
ALTER TABLE [dbo].[Properties]  WITH CHECK ADD  CONSTRAINT [FK_Properties_Projects] FOREIGN KEY([ProjectID])
REFERENCES [dbo].[Projects] ([ProjectID])
GO
ALTER TABLE [dbo].[Properties] CHECK CONSTRAINT [FK_Properties_Projects]
GO
ALTER TABLE [dbo].[Properties]  WITH CHECK ADD  CONSTRAINT [FK_Properties_PropertyTypes] FOREIGN KEY([PropertyTypeID])
REFERENCES [dbo].[PropertyTypes] ([PropertyTypeID])
GO
ALTER TABLE [dbo].[Properties] CHECK CONSTRAINT [FK_Properties_PropertyTypes]
GO
ALTER TABLE [dbo].[Properties]  WITH CHECK ADD  CONSTRAINT [FK_Properties_SectionTypes] FOREIGN KEY([PropertyPurposeID])
REFERENCES [dbo].[PropertyPurpose] ([PropertyPurposeID])
GO
ALTER TABLE [dbo].[Properties] CHECK CONSTRAINT [FK_Properties_SectionTypes]
GO
ALTER TABLE [dbo].[Properties]  WITH CHECK ADD  CONSTRAINT [FK_Properties_Shared] FOREIGN KEY([SharedID])
REFERENCES [dbo].[Shared] ([ShareID])
GO
ALTER TABLE [dbo].[Properties] CHECK CONSTRAINT [FK_Properties_Shared]
GO
ALTER TABLE [dbo].[Properties]  WITH CHECK ADD  CONSTRAINT [FK_Properties_Users] FOREIGN KEY([ByUserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Properties] CHECK CONSTRAINT [FK_Properties_Users]
GO
ALTER TABLE [dbo].[PropertyPictures]  WITH CHECK ADD  CONSTRAINT [FK_PropertyPictures_Properties] FOREIGN KEY([PropertyID])
REFERENCES [dbo].[Properties] ([PropertyID])
GO
ALTER TABLE [dbo].[PropertyPictures] CHECK CONSTRAINT [FK_PropertyPictures_Properties]
GO
ALTER TABLE [dbo].[PropertyRequests]  WITH CHECK ADD  CONSTRAINT [FK_PropertyRequests_FloorTypes] FOREIGN KEY([PropertyFloorTypeID])
REFERENCES [dbo].[PropertyFloorTypes] ([PropertyFloorTypeID])
GO
ALTER TABLE [dbo].[PropertyRequests] CHECK CONSTRAINT [FK_PropertyRequests_FloorTypes]
GO
ALTER TABLE [dbo].[PropertyRequests]  WITH CHECK ADD  CONSTRAINT [FK_PropertyRequests_Locations] FOREIGN KEY([LocationIDs])
REFERENCES [dbo].[Locations] ([LocationID])
GO
ALTER TABLE [dbo].[PropertyRequests] CHECK CONSTRAINT [FK_PropertyRequests_Locations]
GO
ALTER TABLE [dbo].[PropertyRequests]  WITH CHECK ADD  CONSTRAINT [FK_PropertyRequests_OwnerShips] FOREIGN KEY([OwnerShipTypeID])
REFERENCES [dbo].[OwnerShipTypes] ([OwnerShipTypeID])
GO
ALTER TABLE [dbo].[PropertyRequests] CHECK CONSTRAINT [FK_PropertyRequests_OwnerShips]
GO
ALTER TABLE [dbo].[PropertyRequests]  WITH CHECK ADD  CONSTRAINT [FK_PropertyRequests_PropertyTypes] FOREIGN KEY([PropertyTypeID])
REFERENCES [dbo].[PropertyTypes] ([PropertyTypeID])
GO
ALTER TABLE [dbo].[PropertyRequests] CHECK CONSTRAINT [FK_PropertyRequests_PropertyTypes]
GO
ALTER TABLE [dbo].[PropertyRequests]  WITH CHECK ADD  CONSTRAINT [FK_PropertyRequests_SectionTypes] FOREIGN KEY([PropertyPurposeID])
REFERENCES [dbo].[PropertyPurpose] ([PropertyPurposeID])
GO
ALTER TABLE [dbo].[PropertyRequests] CHECK CONSTRAINT [FK_PropertyRequests_SectionTypes]
GO
ALTER TABLE [dbo].[PropertyRequests.FollowUp]  WITH CHECK ADD  CONSTRAINT [FK_PropertyRequests.FollowUp_PropertyRequests] FOREIGN KEY([RequestID])
REFERENCES [dbo].[PropertyRequests] ([RequestID])
GO
ALTER TABLE [dbo].[PropertyRequests.FollowUp] CHECK CONSTRAINT [FK_PropertyRequests.FollowUp_PropertyRequests]
GO
ALTER TABLE [dbo].[PropertyRequests.FollowUp]  WITH CHECK ADD  CONSTRAINT [FK_PropertyRequests.FollowUp_RequestStatus] FOREIGN KEY([RequestStatusID])
REFERENCES [dbo].[RequestStatus] ([RequestStatusID])
GO
ALTER TABLE [dbo].[PropertyRequests.FollowUp] CHECK CONSTRAINT [FK_PropertyRequests.FollowUp_RequestStatus]
GO
ALTER TABLE [dbo].[Transactions]  WITH CHECK ADD  CONSTRAINT [FK_Transactions_CusomerPreviews] FOREIGN KEY([PreviewID])
REFERENCES [dbo].[CusomerPreviews] ([CustomerPreviewID])
GO
ALTER TABLE [dbo].[Transactions] CHECK CONSTRAINT [FK_Transactions_CusomerPreviews]
GO
ALTER TABLE [dbo].[Transactions]  WITH CHECK ADD  CONSTRAINT [FK_Transactions_Customers] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customers] ([CustomerID])
GO
ALTER TABLE [dbo].[Transactions] CHECK CONSTRAINT [FK_Transactions_Customers]
GO
ALTER TABLE [dbo].[User.UserPermission]  WITH CHECK ADD  CONSTRAINT [FK_User.UserPermission_UserPermission] FOREIGN KEY([UserPermissionID])
REFERENCES [dbo].[UserPermission] ([UserPermissionID])
GO
ALTER TABLE [dbo].[User.UserPermission] CHECK CONSTRAINT [FK_User.UserPermission_UserPermission]
GO
ALTER TABLE [dbo].[User.UserPermission]  WITH CHECK ADD  CONSTRAINT [FK_User.UserPermission_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[User.UserPermission] CHECK CONSTRAINT [FK_User.UserPermission_Users]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Companies] FOREIGN KEY([CompanyID])
REFERENCES [dbo].[Companies] ([CompanyID])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Companies]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_UserGroups] FOREIGN KEY([UserGroupName])
REFERENCES [dbo].[UserGroups] ([UserGroupName])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_UserGroups]
GO
ALTER TABLE [dbo].[VerficationRequests]  WITH CHECK ADD  CONSTRAINT [FK_VerficationRequests_Companies] FOREIGN KEY([CompanyID])
REFERENCES [dbo].[Companies] ([CompanyID])
GO
ALTER TABLE [dbo].[VerficationRequests] CHECK CONSTRAINT [FK_VerficationRequests_Companies]
GO
ALTER TABLE [dbo].[VerficationRequests]  WITH CHECK ADD  CONSTRAINT [FK_VerficationRequests_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[VerficationRequests] CHECK CONSTRAINT [FK_VerficationRequests_Users]
GO
ALTER TABLE [dbo].[VerficationRequests]  WITH CHECK ADD  CONSTRAINT [FK_VerficationRequests_VerficationStatus] FOREIGN KEY([VerfiedStatusID])
REFERENCES [dbo].[VerficationStatus] ([VerfiedStatusID])
GO
ALTER TABLE [dbo].[VerficationRequests] CHECK CONSTRAINT [FK_VerficationRequests_VerficationStatus]
GO
USE [master]
GO
ALTER DATABASE [LinkedBroker] SET  READ_WRITE 
GO
