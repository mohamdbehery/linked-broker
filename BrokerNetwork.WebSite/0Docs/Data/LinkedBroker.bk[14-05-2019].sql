USE [master]
GO
/****** Object:  Database [LinkedBroker]    Script Date: 5/14/2019 10:48:41 PM ******/
CREATE DATABASE [LinkedBroker]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'LinkedBroker', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\LinkedBroker.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'LinkedBroker_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\LinkedBroker_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [LinkedBroker] SET COMPATIBILITY_LEVEL = 140
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
ALTER DATABASE [LinkedBroker] SET  DISABLE_BROKER 
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
ALTER DATABASE [LinkedBroker] SET RECOVERY FULL 
GO
ALTER DATABASE [LinkedBroker] SET  MULTI_USER 
GO
ALTER DATABASE [LinkedBroker] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [LinkedBroker] SET DB_CHAINING OFF 
GO
ALTER DATABASE [LinkedBroker] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [LinkedBroker] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [LinkedBroker] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'LinkedBroker', N'ON'
GO
ALTER DATABASE [LinkedBroker] SET QUERY_STORE = OFF
GO
USE [LinkedBroker]
GO
ALTER DATABASE SCOPED CONFIGURATION SET IDENTITY_CACHE = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [LinkedBroker]
GO
/****** Object:  Table [dbo].[Comments]    Script Date: 5/14/2019 10:48:41 PM ******/
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
/****** Object:  Table [dbo].[Companies]    Script Date: 5/14/2019 10:48:41 PM ******/
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
/****** Object:  Table [dbo].[CompanyBrokers]    Script Date: 5/14/2019 10:48:41 PM ******/
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
/****** Object:  Table [dbo].[CompanyTypes]    Script Date: 5/14/2019 10:48:41 PM ******/
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
/****** Object:  Table [dbo].[CompanyVerificationTypes]    Script Date: 5/14/2019 10:48:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CompanyVerificationTypes](
	[CompanyVerificationTypeID] [int] IDENTITY(1,1) NOT NULL,
	[VerificationTitle] [nvarchar](200) NOT NULL,
	[ByUserID] [int] NOT NULL,
	[EntryDate] [datetime] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_CompanyVerificationTypes] PRIMARY KEY CLUSTERED 
(
	[CompanyVerificationTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CusomerPreviews]    Script Date: 5/14/2019 10:48:41 PM ******/
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
/****** Object:  Table [dbo].[Customer.CustomerStatus]    Script Date: 5/14/2019 10:48:41 PM ******/
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
/****** Object:  Table [dbo].[Customers]    Script Date: 5/14/2019 10:48:41 PM ******/
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
/****** Object:  Table [dbo].[CustomerStatus]    Script Date: 5/14/2019 10:48:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerStatus](
	[CustomerStatusID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerStatusTitle] [nvarchar](100) NOT NULL,
	[ByUserID] [bigint] NOT NULL,
	[EntryDate] [datetime] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_CusomersStatus] PRIMARY KEY CLUSTERED 
(
	[CustomerStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Files]    Script Date: 5/14/2019 10:48:42 PM ******/
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
/****** Object:  Table [dbo].[FilesLines]    Script Date: 5/14/2019 10:48:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  Table [dbo].[Locations]    Script Date: 5/14/2019 10:48:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Locations](
	[LocationID] [int] IDENTITY(1,1) NOT NULL,
	[ParentID] [int] NULL,
	[LocationName] [nvarchar](50) NOT NULL,
	[ByUserID] [bigint] NOT NULL,
	[EntryDate] [datetime] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Locations] PRIMARY KEY CLUSTERED 
(
	[LocationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OwnerShipTypes]    Script Date: 5/14/2019 10:48:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OwnerShipTypes](
	[OwnerShipTypeID] [int] IDENTITY(1,1) NOT NULL,
	[OwnerShipTitle] [nvarchar](100) NOT NULL,
	[ByUserID] [bigint] NOT NULL,
	[EntryDate] [datetime] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_OwnerShips] PRIMARY KEY CLUSTERED 
(
	[OwnerShipTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Permission.PermissionGroup]    Script Date: 5/14/2019 10:48:42 PM ******/
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
/****** Object:  Table [dbo].[PermissionGroups]    Script Date: 5/14/2019 10:48:42 PM ******/
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
/****** Object:  Table [dbo].[PreviewStatus]    Script Date: 5/14/2019 10:48:42 PM ******/
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
/****** Object:  Table [dbo].[Projects]    Script Date: 5/14/2019 10:48:42 PM ******/
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
/****** Object:  Table [dbo].[ProjectStatus]    Script Date: 5/14/2019 10:48:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProjectStatus](
	[ProjectStatusID] [int] IDENTITY(1,1) NOT NULL,
	[StatusTitle] [nvarchar](100) NOT NULL,
	[ByUserID] [bigint] NOT NULL,
	[EntryDate] [datetime] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_ProjectStatus] PRIMARY KEY CLUSTERED 
(
	[ProjectStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProjectTypes]    Script Date: 5/14/2019 10:48:42 PM ******/
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
/****** Object:  Table [dbo].[Properties]    Script Date: 5/14/2019 10:48:42 PM ******/
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
 CONSTRAINT [PK_Properties] PRIMARY KEY CLUSTERED 
(
	[PropertyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PropertyFloorTypes]    Script Date: 5/14/2019 10:48:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PropertyFloorTypes](
	[PropertyFloorTypeID] [int] IDENTITY(1,1) NOT NULL,
	[FloorTypeTitle] [nvarchar](100) NOT NULL,
	[ByUserID] [bigint] NOT NULL,
	[EntryDate] [datetime] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_FloorTypes] PRIMARY KEY CLUSTERED 
(
	[PropertyFloorTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PropertyPictures]    Script Date: 5/14/2019 10:48:42 PM ******/
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
/****** Object:  Table [dbo].[PropertyPurpose]    Script Date: 5/14/2019 10:48:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PropertyPurpose](
	[PropertyPurposeID] [int] IDENTITY(1,1) NOT NULL,
	[PropPurposeTitle] [nvarchar](100) NOT NULL,
	[ByUserID] [bigint] NOT NULL,
	[EntryDate] [datetime] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_SectionTypes] PRIMARY KEY CLUSTERED 
(
	[PropertyPurposeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PropertyRequests]    Script Date: 5/14/2019 10:48:42 PM ******/
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
/****** Object:  Table [dbo].[PropertyRequests.FollowUp]    Script Date: 5/14/2019 10:48:42 PM ******/
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
/****** Object:  Table [dbo].[PropertyTypes]    Script Date: 5/14/2019 10:48:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PropertyTypes](
	[PropertyTypeID] [int] IDENTITY(1,1) NOT NULL,
	[PropTypeTitle] [nvarchar](100) NOT NULL,
	[ByUserID] [bigint] NOT NULL,
	[EntryDate] [datetime] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_BuilderClasses] PRIMARY KEY CLUSTERED 
(
	[PropertyTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RequestStatus]    Script Date: 5/14/2019 10:48:42 PM ******/
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
/****** Object:  Table [dbo].[Shared]    Script Date: 5/14/2019 10:48:42 PM ******/
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
/****** Object:  Table [dbo].[SpecialOffers]    Script Date: 5/14/2019 10:48:42 PM ******/
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
/****** Object:  Table [dbo].[Transactions]    Script Date: 5/14/2019 10:48:42 PM ******/
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
/****** Object:  Table [dbo].[User.UserPermission]    Script Date: 5/14/2019 10:48:42 PM ******/
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
/****** Object:  Table [dbo].[UserGroups]    Script Date: 5/14/2019 10:48:42 PM ******/
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
/****** Object:  Table [dbo].[UserPermission]    Script Date: 5/14/2019 10:48:42 PM ******/
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
/****** Object:  Table [dbo].[Users]    Script Date: 5/14/2019 10:48:42 PM ******/
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
	[EntryDate] [datetime] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VerficationRequests]    Script Date: 5/14/2019 10:48:42 PM ******/
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
/****** Object:  Table [dbo].[VerficationStatus]    Script Date: 5/14/2019 10:48:42 PM ******/
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
SET IDENTITY_INSERT [dbo].[Companies] ON 

INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDesc], [CompanyVerificationTypeID], [Address], [CompanyTypeID], [Email], [Contacts], [ImgPath], [ByUserID], [EntryDate], [IsActive], [IsDeleted], [ContactsForBrokers]) VALUES (5, N'Test', N'Just for test', 2, NULL, 1, NULL, N'010', N'52874483-40cf-486b-afb8-1dd9e4fad4e5.jpg', 7, CAST(N'2019-02-24T16:19:44.107' AS DateTime), 1, 1, N'012')
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDesc], [CompanyVerificationTypeID], [Address], [CompanyTypeID], [Email], [Contacts], [ImgPath], [ByUserID], [EntryDate], [IsActive], [IsDeleted], [ContactsForBrokers]) VALUES (6, N'Test 2', N'Just test', 2, NULL, 1, NULL, N'010', N'7ccca0ef-4bcb-412d-b1fd-4d4778231acb.png', 7, CAST(N'2019-04-28T15:51:14.620' AS DateTime), 1, 0, N'012')
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDesc], [CompanyVerificationTypeID], [Address], [CompanyTypeID], [Email], [Contacts], [ImgPath], [ByUserID], [EntryDate], [IsActive], [IsDeleted], [ContactsForBrokers]) VALUES (7, N'العهد للعقارات', N'بلاب', 2, NULL, 1, NULL, N'01007330161', N'Lync.jpg', 2, CAST(N'2019-05-12T20:47:49.937' AS DateTime), 0, 0, N'01008523690')
SET IDENTITY_INSERT [dbo].[Companies] OFF
SET IDENTITY_INSERT [dbo].[CompanyBrokers] ON 

INSERT [dbo].[CompanyBrokers] ([CompanyBrokerID], [CompanyID], [UserID]) VALUES (1, 5, 2)
INSERT [dbo].[CompanyBrokers] ([CompanyBrokerID], [CompanyID], [UserID]) VALUES (2, 6, 8)
SET IDENTITY_INSERT [dbo].[CompanyBrokers] OFF
SET IDENTITY_INSERT [dbo].[CompanyTypes] ON 

INSERT [dbo].[CompanyTypes] ([CompanyTypeID], [CompanyTypeTitle]) VALUES (1, N'شركة استثمار عقارى')
INSERT [dbo].[CompanyTypes] ([CompanyTypeID], [CompanyTypeTitle]) VALUES (2, N'شركة تسويق عقارى')
INSERT [dbo].[CompanyTypes] ([CompanyTypeID], [CompanyTypeTitle]) VALUES (3, N'شركة استثمار وتسويق عقارى')
SET IDENTITY_INSERT [dbo].[CompanyTypes] OFF
SET IDENTITY_INSERT [dbo].[CompanyVerificationTypes] ON 

INSERT [dbo].[CompanyVerificationTypes] ([CompanyVerificationTypeID], [VerificationTitle], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (2, N'ممارسة حرة', 1, CAST(N'2018-04-28T22:45:26.227' AS DateTime), 1, 0)
INSERT [dbo].[CompanyVerificationTypes] ([CompanyVerificationTypeID], [VerificationTitle], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (4, N'منظمة رسمية', 1, CAST(N'2018-04-28T22:46:12.433' AS DateTime), 1, 0)
INSERT [dbo].[CompanyVerificationTypes] ([CompanyVerificationTypeID], [VerificationTitle], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (5, N'منظمة رسمية محترفة', 1, CAST(N'2018-04-28T22:46:40.660' AS DateTime), 1, 0)
SET IDENTITY_INSERT [dbo].[CompanyVerificationTypes] OFF
SET IDENTITY_INSERT [dbo].[CustomerStatus] ON 

INSERT [dbo].[CustomerStatus] ([CustomerStatusID], [CustomerStatusTitle], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (1, N'حالى', 1, CAST(N'2018-03-10T16:37:26.447' AS DateTime), 1, 0)
INSERT [dbo].[CustomerStatus] ([CustomerStatusID], [CustomerStatusTitle], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (2, N'سابق', 1, CAST(N'2018-03-10T16:37:56.287' AS DateTime), 1, 0)
INSERT [dbo].[CustomerStatus] ([CustomerStatusID], [CustomerStatusTitle], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (3, N'مهم', 1, CAST(N'2018-03-10T16:38:09.710' AS DateTime), 1, 0)
INSERT [dbo].[CustomerStatus] ([CustomerStatusID], [CustomerStatusTitle], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (4, N'مؤقت', 1, CAST(N'2018-03-10T16:38:49.290' AS DateTime), 1, 0)
SET IDENTITY_INSERT [dbo].[CustomerStatus] OFF
SET IDENTITY_INSERT [dbo].[Files] ON 

INSERT [dbo].[Files] ([FileID], [ParentID], [ParentType], [FileName], [FileType], [OrginalFileName], [IsActive], [IsDeleted], [CreatedDate], [LastUpdated]) VALUES (1, 1, N'Properties', N'139e28f9-4dcc-42c4-be3e-aa9e65b856de.png', NULL, N'139e28f9-4dcc-42c4-be3e-aa9e65b856de.png', 1, 0, CAST(N'2019-01-14T09:07:31.407' AS DateTime), CAST(N'2019-01-14T09:07:31.407' AS DateTime))
INSERT [dbo].[Files] ([FileID], [ParentID], [ParentType], [FileName], [FileType], [OrginalFileName], [IsActive], [IsDeleted], [CreatedDate], [LastUpdated]) VALUES (2, 1, N'Properties', N'32a9a62a-a5d1-46e3-89cd-60edcebb4627.png', NULL, N'32a9a62a-a5d1-46e3-89cd-60edcebb4627.png', 1, 0, CAST(N'2019-01-14T09:07:31.407' AS DateTime), CAST(N'2019-01-14T09:07:31.407' AS DateTime))
INSERT [dbo].[Files] ([FileID], [ParentID], [ParentType], [FileName], [FileType], [OrginalFileName], [IsActive], [IsDeleted], [CreatedDate], [LastUpdated]) VALUES (3, 1, N'Properties', N'993e2e24-aa12-46f9-a8b0-85718aa21162.png', NULL, N'993e2e24-aa12-46f9-a8b0-85718aa21162.png', 1, 0, CAST(N'2019-01-14T09:07:31.423' AS DateTime), CAST(N'2019-01-14T09:07:31.423' AS DateTime))
INSERT [dbo].[Files] ([FileID], [ParentID], [ParentType], [FileName], [FileType], [OrginalFileName], [IsActive], [IsDeleted], [CreatedDate], [LastUpdated]) VALUES (4, 12, N'Properties', N'00b516a6-8a8c-469e-ba19-f1b8cea18ff3.jpg', NULL, N'00b516a6-8a8c-469e-ba19-f1b8cea18ff3.jpg', 1, 0, CAST(N'2019-02-03T09:44:26.657' AS DateTime), CAST(N'2019-02-03T09:44:26.657' AS DateTime))
INSERT [dbo].[Files] ([FileID], [ParentID], [ParentType], [FileName], [FileType], [OrginalFileName], [IsActive], [IsDeleted], [CreatedDate], [LastUpdated]) VALUES (5, 12, N'Properties', N'a0333445-337b-4db8-b658-11ae2d8c4d62.jpg', NULL, N'a0333445-337b-4db8-b658-11ae2d8c4d62.jpg', 1, 0, CAST(N'2019-02-03T09:45:29.220' AS DateTime), CAST(N'2019-02-03T09:45:29.220' AS DateTime))
INSERT [dbo].[Files] ([FileID], [ParentID], [ParentType], [FileName], [FileType], [OrginalFileName], [IsActive], [IsDeleted], [CreatedDate], [LastUpdated]) VALUES (6, 1, N'Projects', N'3b8f65d1-887d-4399-84fb-e5d06b246ff7.jpg', NULL, N'3b8f65d1-887d-4399-84fb-e5d06b246ff7.jpg', 1, 0, CAST(N'2019-02-03T09:59:50.207' AS DateTime), CAST(N'2019-02-03T09:59:50.207' AS DateTime))
INSERT [dbo].[Files] ([FileID], [ParentID], [ParentType], [FileName], [FileType], [OrginalFileName], [IsActive], [IsDeleted], [CreatedDate], [LastUpdated]) VALUES (8, 15, N'Properties', N'ffaca383-3bdc-45d5-83ba-7b1c09148f51.jpg', NULL, N'ffaca383-3bdc-45d5-83ba-7b1c09148f51.jpg', 1, 0, CAST(N'2019-02-03T10:06:24.393' AS DateTime), CAST(N'2019-02-03T10:06:24.393' AS DateTime))
INSERT [dbo].[Files] ([FileID], [ParentID], [ParentType], [FileName], [FileType], [OrginalFileName], [IsActive], [IsDeleted], [CreatedDate], [LastUpdated]) VALUES (9, 17, N'Properties', N'952a27c8-bed6-4483-a330-14e53f87e752.jpg', NULL, N'952a27c8-bed6-4483-a330-14e53f87e752.jpg', 1, 0, CAST(N'2019-02-09T08:27:40.373' AS DateTime), CAST(N'2019-02-09T08:27:40.373' AS DateTime))
INSERT [dbo].[Files] ([FileID], [ParentID], [ParentType], [FileName], [FileType], [OrginalFileName], [IsActive], [IsDeleted], [CreatedDate], [LastUpdated]) VALUES (10, 8, N'Projects', N'0d52301b-5090-45d9-89e1-277b84a48788.png', NULL, N'0d52301b-5090-45d9-89e1-277b84a48788.png', 1, 0, CAST(N'2019-02-12T06:35:41.690' AS DateTime), CAST(N'2019-02-12T06:35:41.690' AS DateTime))
INSERT [dbo].[Files] ([FileID], [ParentID], [ParentType], [FileName], [FileType], [OrginalFileName], [IsActive], [IsDeleted], [CreatedDate], [LastUpdated]) VALUES (11, 13, N'Projects', N'47f21de7-0f52-48b3-afae-74f6dac9c0e8.jpg', NULL, N'47f21de7-0f52-48b3-afae-74f6dac9c0e8.jpg', 1, 0, CAST(N'2019-02-24T16:25:12.537' AS DateTime), CAST(N'2019-02-24T16:25:12.537' AS DateTime))
INSERT [dbo].[Files] ([FileID], [ParentID], [ParentType], [FileName], [FileType], [OrginalFileName], [IsActive], [IsDeleted], [CreatedDate], [LastUpdated]) VALUES (12, 0, N'Properties', N'362e6e93-94f3-4f30-aba8-3eb6d580e2c0.jpg', NULL, N'362e6e93-94f3-4f30-aba8-3eb6d580e2c0.jpg', 1, 0, CAST(N'2019-02-24T16:27:35.303' AS DateTime), CAST(N'2019-02-24T16:27:35.303' AS DateTime))
INSERT [dbo].[Files] ([FileID], [ParentID], [ParentType], [FileName], [FileType], [OrginalFileName], [IsActive], [IsDeleted], [CreatedDate], [LastUpdated]) VALUES (13, 0, N'Properties', N'e571dec6-3b27-49d2-be62-c27ee28d08c6.jpg', NULL, N'e571dec6-3b27-49d2-be62-c27ee28d08c6.jpg', 1, 0, CAST(N'2019-02-24T16:29:57.163' AS DateTime), CAST(N'2019-02-24T16:29:57.163' AS DateTime))
INSERT [dbo].[Files] ([FileID], [ParentID], [ParentType], [FileName], [FileType], [OrginalFileName], [IsActive], [IsDeleted], [CreatedDate], [LastUpdated]) VALUES (14, 29, N'Properties', N'5fc2db5c-922b-462f-9d85-cdd9c13203e0.jpg', NULL, N'5fc2db5c-922b-462f-9d85-cdd9c13203e0.jpg', 1, 0, CAST(N'2019-02-24T16:42:16.823' AS DateTime), CAST(N'2019-02-24T16:42:16.823' AS DateTime))
INSERT [dbo].[Files] ([FileID], [ParentID], [ParentType], [FileName], [FileType], [OrginalFileName], [IsActive], [IsDeleted], [CreatedDate], [LastUpdated]) VALUES (16, 29, N'Properties', N'9a6f2900-f60a-4f0f-a129-e5616b097e1f.jpg', NULL, N'9a6f2900-f60a-4f0f-a129-e5616b097e1f.jpg', 1, 0, CAST(N'2019-02-24T16:45:20.527' AS DateTime), CAST(N'2019-02-24T16:45:20.527' AS DateTime))
INSERT [dbo].[Files] ([FileID], [ParentID], [ParentType], [FileName], [FileType], [OrginalFileName], [IsActive], [IsDeleted], [CreatedDate], [LastUpdated]) VALUES (17, 30, N'Properties', N'7b00f811-60c2-4320-9aef-0d8373482f2b.jpg', NULL, N'7b00f811-60c2-4320-9aef-0d8373482f2b.jpg', 1, 0, CAST(N'2019-02-24T16:47:18.650' AS DateTime), CAST(N'2019-02-24T16:47:18.650' AS DateTime))
INSERT [dbo].[Files] ([FileID], [ParentID], [ParentType], [FileName], [FileType], [OrginalFileName], [IsActive], [IsDeleted], [CreatedDate], [LastUpdated]) VALUES (18, 7, N'Verfication', N'e34a212c-8917-42e8-bb76-09b1ccc4c698.jpg', NULL, N'e34a212c-8917-42e8-bb76-09b1ccc4c698.jpg', 1, 0, CAST(N'2019-02-25T21:28:23.840' AS DateTime), CAST(N'2019-02-25T21:28:23.840' AS DateTime))
INSERT [dbo].[Files] ([FileID], [ParentID], [ParentType], [FileName], [FileType], [OrginalFileName], [IsActive], [IsDeleted], [CreatedDate], [LastUpdated]) VALUES (19, 31, N'Properties', N'998c43d1-7060-4cd5-921f-d6ff4dd6c0fb.jpeg', NULL, N'998c43d1-7060-4cd5-921f-d6ff4dd6c0fb.jpeg', 1, 0, CAST(N'2019-03-24T05:45:41.590' AS DateTime), CAST(N'2019-03-24T05:45:41.590' AS DateTime))
INSERT [dbo].[Files] ([FileID], [ParentID], [ParentType], [FileName], [FileType], [OrginalFileName], [IsActive], [IsDeleted], [CreatedDate], [LastUpdated]) VALUES (20, 32, N'Properties', N'73932310-85b8-4d30-8ccc-9add57d27c54.jpeg', NULL, N'73932310-85b8-4d30-8ccc-9add57d27c54.jpeg', 1, 0, CAST(N'2019-03-24T05:47:10.950' AS DateTime), CAST(N'2019-03-24T05:47:10.950' AS DateTime))
INSERT [dbo].[Files] ([FileID], [ParentID], [ParentType], [FileName], [FileType], [OrginalFileName], [IsActive], [IsDeleted], [CreatedDate], [LastUpdated]) VALUES (21, 33, N'Properties', N'328cd07e-299c-4abc-abf4-ce5ff8cee776.jpg', NULL, N'328cd07e-299c-4abc-abf4-ce5ff8cee776.jpg', 1, 0, CAST(N'2019-03-24T05:56:03.963' AS DateTime), CAST(N'2019-03-24T05:56:03.963' AS DateTime))
INSERT [dbo].[Files] ([FileID], [ParentID], [ParentType], [FileName], [FileType], [OrginalFileName], [IsActive], [IsDeleted], [CreatedDate], [LastUpdated]) VALUES (22, 33, N'Properties', N'14d299a1-2b80-40f3-aaee-495235ad27d3.jpeg', NULL, N'14d299a1-2b80-40f3-aaee-495235ad27d3.jpeg', 1, 0, CAST(N'2019-03-24T05:56:03.980' AS DateTime), CAST(N'2019-03-24T05:56:03.980' AS DateTime))
INSERT [dbo].[Files] ([FileID], [ParentID], [ParentType], [FileName], [FileType], [OrginalFileName], [IsActive], [IsDeleted], [CreatedDate], [LastUpdated]) VALUES (23, 34, N'Properties', N'acb0fd84-26b2-4397-a57d-7946fac22675.jpeg', NULL, N'acb0fd84-26b2-4397-a57d-7946fac22675.jpeg', 1, 0, CAST(N'2019-04-28T15:47:27.320' AS DateTime), CAST(N'2019-04-28T15:47:27.320' AS DateTime))
INSERT [dbo].[Files] ([FileID], [ParentID], [ParentType], [FileName], [FileType], [OrginalFileName], [IsActive], [IsDeleted], [CreatedDate], [LastUpdated]) VALUES (24, 14, N'Projects', N'502eb455-9c08-4a87-b529-9895b2203662.jpg', NULL, N'502eb455-9c08-4a87-b529-9895b2203662.jpg', 1, 0, CAST(N'2019-05-04T22:19:24.687' AS DateTime), CAST(N'2019-05-04T22:19:24.687' AS DateTime))
SET IDENTITY_INSERT [dbo].[Files] OFF
SET IDENTITY_INSERT [dbo].[Locations] ON 

INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (3, NULL, N'مصر', 1, CAST(N'2018-04-21T16:27:53.773' AS DateTime), 1, 1)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (4, 3, N'القاهرة', 1, CAST(N'2018-04-21T16:28:43.890' AS DateTime), 1, 1)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (5, 4, N'التجمع - البنفسج 1', 1, CAST(N'2018-11-07T00:27:53.120' AS DateTime), 1, 1)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (6, NULL, N'القاهرة الجديدة', 7, CAST(N'2019-01-14T11:58:37.307' AS DateTime), 1, 1)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (7, 6, N'التجمع', 7, CAST(N'2019-01-14T11:58:59.760' AS DateTime), 1, 1)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (8, 7, N'البنفسج عمارات', 7, CAST(N'2019-01-14T11:59:23.823' AS DateTime), 1, 1)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (9, 7, N'النرجس', 7, CAST(N'2019-02-01T12:02:33.187' AS DateTime), 1, 1)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (10, 7, N'البنفسج فيلات', 7, CAST(N'2019-02-01T12:06:35.840' AS DateTime), 1, 1)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (11, 7, N'النرجس فيلات', 7, CAST(N'2019-02-01T12:06:54.857' AS DateTime), 1, 1)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (12, 7, N'اللوتس', 7, CAST(N'2019-02-01T12:07:13.670' AS DateTime), 1, 1)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (13, 7, N'شرق الأكاديمية', 7, CAST(N'2019-02-01T12:07:30.343' AS DateTime), 1, 1)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (14, 7, N'جنوب الأكاديمية', 7, CAST(N'2019-02-01T12:07:46.330' AS DateTime), 1, 1)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (15, 7, N'الياسمين', 7, CAST(N'2019-02-01T12:08:01.377' AS DateTime), 1, 1)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (16, 7, N'القرنفل', 7, CAST(N'2019-02-01T12:08:44.300' AS DateTime), 1, 1)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (17, 7, N'التمر حنة', 7, CAST(N'2019-02-01T12:08:58.333' AS DateTime), 1, 1)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (18, 7, N'الحى الأول', 7, CAST(N'2019-02-01T12:09:27.770' AS DateTime), 1, 1)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (19, 7, N'الحى الثالث', 7, CAST(N'2019-02-01T12:09:44.600' AS DateTime), 1, 1)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (20, 7, N'الحى الخامس', 7, CAST(N'2019-02-01T12:09:59.133' AS DateTime), 1, 1)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (21, NULL, N'القاهرة الجديدة', 7, CAST(N'2019-02-07T07:44:52.793' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (22, 21, N'التجمع', 7, CAST(N'2019-02-07T07:45:21.263' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (23, 22, N'البنفسج', 7, CAST(N'2019-02-07T07:45:46.107' AS DateTime), 1, 1)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (24, 22, N'Compounds التجمع', 7, CAST(N'2019-02-07T07:46:51.810' AS DateTime), 1, 1)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (25, 22, N'البنفسج عمارات', 7, CAST(N'2019-02-07T07:47:19.263' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (26, 22, N'البنفسج', 7, CAST(N'2019-02-07T07:47:19.480' AS DateTime), 1, 1)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (27, 22, N'اللوتس', 7, CAST(N'2019-02-07T07:47:43.480' AS DateTime), 1, 1)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (28, 22, N'اللوتس', 7, CAST(N'2019-02-07T07:47:43.637' AS DateTime), 1, 1)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (29, 22, N'المستثمرين الشمالية', 7, CAST(N'2019-02-07T08:36:58.997' AS DateTime), 1, 1)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (30, 22, N'المستثمرين الجنوبية', 7, CAST(N'2019-02-07T08:37:29.200' AS DateTime), 1, 1)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (31, NULL, N'النرجس عمارات', 7, CAST(N'2019-02-07T08:37:54.513' AS DateTime), 1, 1)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (32, 22, N'النرجس عمارات', 7, CAST(N'2019-02-07T08:38:12.390' AS DateTime), 1, 1)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (33, 22, N'النرجس عمارات', 7, CAST(N'2019-02-07T08:38:12.640' AS DateTime), 1, 1)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (34, 22, N'البنفسج فيلات', 7, CAST(N'2019-02-07T08:39:07.530' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (35, 22, N'اللوتس', 7, CAST(N'2019-02-07T08:39:31.560' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (36, 22, N'المستثمرين الشمالية', 7, CAST(N'2019-02-07T08:41:34.670' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (37, 22, N'المستثمرين الجنوبية', 7, CAST(N'2019-02-07T08:41:46.703' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (38, 22, N'النرجس عمارات', 7, CAST(N'2019-02-07T08:42:07.047' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (39, 22, N'النرجس فيلات', 7, CAST(N'2019-02-07T08:42:19.763' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (40, 22, N'الزهور', 7, CAST(N'2019-02-07T08:42:36.937' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (41, 22, N'الياسمين', 7, CAST(N'2019-02-07T08:42:50.967' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (42, 22, N'جاردينيا هايتس - أبو الهول', 7, CAST(N'2019-02-07T08:43:13.233' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (43, 22, N'الأندلس', 7, CAST(N'2019-02-07T08:43:46.780' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (44, 22, N'التمر حنة', 7, CAST(N'2019-02-07T08:44:07.857' AS DateTime), 1, 1)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (45, 22, N'التمر حنة', 7, CAST(N'2019-02-07T08:44:08.140' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (46, 22, N'القرنفل', 7, CAST(N'2019-02-07T08:44:24.047' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (47, 22, N'التجمع الأول', 7, CAST(N'2019-02-07T08:44:54.827' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (48, 22, N'التجمع الثالث', 7, CAST(N'2019-02-07T08:45:15.857' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (49, 22, N'الأحياء', 7, CAST(N'2019-02-07T08:45:39.093' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (50, 22, N'الشويفات', 7, CAST(N'2019-02-07T08:45:52.297' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (51, 22, N'غرب أربيلا', 7, CAST(N'2019-02-07T08:46:12.873' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (52, 22, N'جنوب الأكاديمية', 7, CAST(N'2019-02-07T08:47:31.890' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (53, 22, N'شرق الأكاديمية', 7, CAST(N'2019-02-07T08:47:47.593' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (54, 22, N'القطامية', 7, CAST(N'2019-02-07T08:48:30.890' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (55, 22, N'شارع التسعين الرئيسي', 7, CAST(N'2019-02-07T09:18:07.663' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (56, 22, N'خلف الميراج', 7, CAST(N'2019-02-07T09:18:56.053' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (57, 22, N'بيت الوطن', 7, CAST(N'2019-02-07T09:19:33.040' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (58, 21, N'Compounds التجمع', 7, CAST(N'2019-02-07T09:21:55.753' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (59, 58, N'ميفيدا', 7, CAST(N'2019-02-07T09:23:18.050' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (60, 58, N'القطامية ديونز', 7, CAST(N'2019-02-07T09:23:36.037' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (61, 58, N'ايست تاون', 7, CAST(N'2019-02-07T09:23:50.567' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (62, 58, N'لى روا', 7, CAST(N'2019-02-07T09:24:05.847' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (63, 22, N'مينا جاردنز', 7, CAST(N'2019-02-07T09:24:26.597' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (64, 58, N'لا ميرادا', 7, CAST(N'2019-02-07T09:24:50.520' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (65, 58, N'قطامية جاردنز', 7, CAST(N'2019-02-07T09:25:09.427' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (66, 22, N'سكوير', 7, CAST(N'2019-02-07T09:25:30.943' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (67, 58, N'هايد بارك', 7, CAST(N'2019-02-07T09:25:43.457' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (68, 58, N'ماونتن فيو هايد بارك', 7, CAST(N'2019-02-07T09:26:00.973' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (69, 58, N'بالم هيلز القطامية', 7, CAST(N'2019-02-07T09:26:19.443' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (70, 58, N'ليان ريزيدنس', 7, CAST(N'2019-02-07T09:28:25.767' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (71, 58, N'سيفورا هايتس', 7, CAST(N'2019-02-07T09:28:50.457' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (72, 58, N'ديار', 7, CAST(N'2019-02-07T09:29:01.767' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (73, 58, N'كانتري كلوب', 7, CAST(N'2019-02-07T09:29:25.003' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (74, 58, N'ايمرالد بارك', 7, CAST(N'2019-02-07T09:29:43.407' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (75, 58, N'صن سيتي جاردنز', 7, CAST(N'2019-02-07T09:30:03.783' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (76, 58, N'باراديس', 7, CAST(N'2019-02-07T09:30:24.097' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (77, 58, N'رويال توليب', 7, CAST(N'2019-02-07T09:30:38.440' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (78, 58, N'بيلاجيو صبور', 7, CAST(N'2019-02-07T09:30:54.813' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (79, 58, N'زيزينيا جاردنز', 7, CAST(N'2019-02-07T09:31:19.393' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (80, 58, N'حياة', 7, CAST(N'2019-02-07T09:31:57.970' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (81, 58, N'جولي هايتس', 7, CAST(N'2019-02-07T09:32:13.157' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (82, 58, N'وان بيس', 7, CAST(N'2019-02-07T09:32:26.830' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (83, 58, N'لينا سبرينجز', 7, CAST(N'2019-02-07T09:32:44.143' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (84, 58, N'مون فالي 2', 7, CAST(N'2019-02-07T09:32:57.267' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (85, 58, N'ريحانة', 7, CAST(N'2019-02-07T09:33:13.207' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (86, 58, N'سيزونز', 7, CAST(N'2019-02-07T09:33:29.627' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (87, 58, N'فلورز بارك', 7, CAST(N'2019-02-07T09:33:53.690' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (88, 58, N'درة القاهرة', 7, CAST(N'2019-02-07T09:34:14.173' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (89, 58, N'بارك فيو', 7, CAST(N'2019-02-07T09:34:26.927' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (90, 58, N'حياتي ريزيدنس', 7, CAST(N'2019-02-07T09:34:41.533' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (91, 58, N'فيلينو', 7, CAST(N'2019-02-07T09:34:56.300' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (92, 58, N'الحرية', 7, CAST(N'2019-02-07T09:35:08.177' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (93, 58, N'جولدن هايتس 1', 7, CAST(N'2019-02-07T09:35:20.830' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (94, 58, N'الباتيو 1', 7, CAST(N'2019-02-07T09:35:35.643' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (95, 58, N'الأزهر', 7, CAST(N'2019-02-07T09:35:48.050' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (96, 58, N'قطامية بلازا', 7, CAST(N'2019-02-07T09:36:05.127' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (97, 58, N'فاميلي سيتي', 7, CAST(N'2019-02-07T09:36:23.567' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (98, 58, N'فيلارا', 7, CAST(N'2019-02-07T09:36:45.597' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (99, 58, N'المصراوية', 7, CAST(N'2019-02-07T09:36:57.347' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (100, 58, N'قطامية هايتس', 7, CAST(N'2019-02-07T09:37:17.987' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (101, 58, N'ريماس', 7, CAST(N'2019-02-07T09:37:31.347' AS DateTime), 1, 0)
GO
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (102, 58, N'الروضة', 7, CAST(N'2019-02-07T09:37:42.707' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (103, 58, N'اديرا 1', 7, CAST(N'2019-02-07T09:37:55.267' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (104, 58, N'اديرا 2', 7, CAST(N'2019-02-07T09:38:16.283' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (105, 58, N'حياة هايتس', 7, CAST(N'2019-02-07T09:38:29.347' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (106, 58, N'ريفر واك وادي دجلة', 7, CAST(N'2019-02-07T09:38:55.583' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (107, 58, N'ووتر واي', 7, CAST(N'2019-02-07T09:39:13.237' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (108, 58, N'ايديا فيردى', 7, CAST(N'2019-02-07T09:39:44.317' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (109, 58, N'ستيللا', 7, CAST(N'2019-02-07T09:39:57.113' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (110, 58, N'الباتيو 2', 7, CAST(N'2019-02-07T09:40:10.317' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (111, 58, N'لانوفا فيستا', 7, CAST(N'2019-02-07T09:40:25.037' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (112, 58, N'لاجو فيستا', 7, CAST(N'2019-02-07T09:40:41.003' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (113, 58, N'جولدن هايتس 2', 7, CAST(N'2019-02-07T09:40:57.597' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (114, 58, N'كازا فيردي', 7, CAST(N'2019-02-07T09:41:11.067' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (115, 58, N'فيلدج أفينيو', 7, CAST(N'2019-02-07T09:41:28.957' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (116, 58, N'الطلائع', 7, CAST(N'2019-02-07T09:41:41.927' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (117, 58, N'رويال لاجون', 7, CAST(N'2019-02-07T09:41:56.333' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (118, 58, N'سيرينا هايتس', 7, CAST(N'2019-02-07T09:42:11.020' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (119, 58, N'عصفور الجنة', 7, CAST(N'2019-02-07T09:42:24.990' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (120, 58, N'مدينة الصحفيين', 7, CAST(N'2019-02-07T09:42:39.770' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (121, 58, N'ايتوال دي فيل', 7, CAST(N'2019-02-07T09:42:56.130' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (122, 58, N'المرام لاند مارك', 7, CAST(N'2019-02-07T09:43:09.897' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (123, 58, N'الأشرفية', 7, CAST(N'2019-02-07T09:43:22.597' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (124, 58, N'زهرة التجمع', 7, CAST(N'2019-02-07T09:43:35.800' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (125, 58, N'لاكوينتا', 7, CAST(N'2019-02-07T09:43:48.597' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (126, 58, N'الجوهرة', 7, CAST(N'2019-02-07T09:43:59.897' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (127, 58, N'الصفا', 7, CAST(N'2019-02-07T09:44:10.957' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (128, 58, N'كونكورد جاردنز', 7, CAST(N'2019-02-07T09:44:26.363' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (129, 58, N'جاردن هيلز', 7, CAST(N'2019-02-07T09:44:39.287' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (130, 58, N'ريتاج', 7, CAST(N'2019-02-07T09:44:50.503' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (131, 58, N'عربية', 7, CAST(N'2019-02-07T09:45:00.333' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (132, 58, N'جزيرة جرين بارك', 7, CAST(N'2019-02-07T09:45:13.833' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (133, 58, N'جراند ريزيدنس', 7, CAST(N'2019-02-07T09:45:27.753' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (134, 58, N'الأصيل', 7, CAST(N'2019-02-07T09:45:37.627' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (135, 58, N'أوركيديا', 7, CAST(N'2019-02-07T09:45:51.067' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (136, 58, N'جاردن فيو', 7, CAST(N'2019-02-07T09:46:03.503' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (137, 58, N'مون فالي 1', 7, CAST(N'2019-02-07T09:46:15.097' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (138, 58, N'90 أفينيو', 7, CAST(N'2019-02-07T09:46:50.830' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (139, 58, N'الزهوة', 7, CAST(N'2019-02-07T09:47:03.317' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (140, 58, N'فلور دي فيل', 7, CAST(N'2019-02-07T09:47:18.783' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (141, 58, N'ذا فيلا', 7, CAST(N'2019-02-07T09:47:32.800' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (142, 58, N'نيو ميريلاند', 7, CAST(N'2019-02-07T09:47:46.737' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (143, 58, N'لايف فيو', 7, CAST(N'2019-02-07T09:47:59.003' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (144, 58, N'مينا ريزيدنس', 7, CAST(N'2019-02-07T09:48:12.080' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (145, 58, N'زيزينيا سيتي', 7, CAST(N'2019-02-07T09:48:24.393' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (146, 58, N'جنتي', 7, CAST(N'2019-02-07T09:48:34.097' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (147, 58, N'أصالة', 7, CAST(N'2019-02-07T09:48:44.020' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (148, 58, N'ريفيرا هيلز', 7, CAST(N'2019-02-07T09:48:56.223' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (149, 58, N'ريفيرا هايتس', 7, CAST(N'2019-02-07T09:49:09.660' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (150, 58, N'حدائق الفداء', 7, CAST(N'2019-02-07T09:49:34.003' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (151, 58, N'لاتيرا', 7, CAST(N'2019-02-07T09:49:46.473' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (152, 58, N'ذا فيلج جايت', 7, CAST(N'2019-02-07T09:50:00.160' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (153, 58, N'مارفل سيتي', 7, CAST(N'2019-02-07T09:50:14.130' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (154, 58, N'لايت سيتي', 7, CAST(N'2019-02-07T09:50:30.050' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (155, 58, N'فيلج', 7, CAST(N'2019-02-07T09:50:42.067' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (156, 58, N'جاليريا مون فالي', 7, CAST(N'2019-02-07T09:50:57.440' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (157, 58, N'إيجلز', 7, CAST(N'2019-02-07T09:51:10.363' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (158, 58, N'فاونتن بارك', 7, CAST(N'2019-02-07T09:51:22.987' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (159, 58, N'فيلج جاردن القطامية', 7, CAST(N'2019-02-07T09:51:38.287' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (160, 58, N'ديار بارك', 7, CAST(N'2019-02-07T09:51:50.847' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (161, 58, N'جاردينيا سيرنجز', 7, CAST(N'2019-02-07T09:52:10.550' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (162, 58, N'لاند مارك', 7, CAST(N'2019-02-07T09:52:22.473' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (163, 58, N'ماونتن فيو 1', 7, CAST(N'2019-02-07T09:52:39.630' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (164, 58, N'ماونتن فيو 2', 7, CAST(N'2019-02-07T09:53:33.833' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (165, 58, N'الباتيو 3', 7, CAST(N'2019-02-07T09:53:49.130' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (166, 58, N'كونكورديا 2', 7, CAST(N'2019-02-07T09:54:04.147' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (167, 58, N'ليك فيو', 7, CAST(N'2019-02-07T09:54:15.613' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (168, 58, N'ستون بارك', 7, CAST(N'2019-02-07T09:54:27.723' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (169, 58, N'بورتو كايرو', 7, CAST(N'2019-02-07T09:54:44.067' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (170, 58, N'سوان ليك', 7, CAST(N'2019-02-07T09:54:56.147' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (171, 58, N'مارينا سيتي', 7, CAST(N'2019-02-07T09:55:24.490' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (172, 58, N'رويال مكسيم', 7, CAST(N'2019-02-07T09:55:51.443' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (173, 58, N'قطامية ريزيدنس', 7, CAST(N'2019-02-07T09:56:09.647' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (174, 58, N'برايت سيتي', 7, CAST(N'2019-02-07T09:56:23.287' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (175, 58, N'ديار المخابرات', 7, CAST(N'2019-02-07T09:56:41.520' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (176, 58, N'كايرو فيستيفال سيتي', 7, CAST(N'2019-02-07T09:58:02.973' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (177, 58, N'لاروز', 7, CAST(N'2019-02-07T09:58:14.207' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (178, 58, N'تاج سيتي', 7, CAST(N'2019-02-07T09:58:25.113' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (179, 58, N'أكويا', 7, CAST(N'2019-02-07T09:58:41.473' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (180, 58, N'ميد تاون', 7, CAST(N'2019-02-07T09:59:20.647' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (181, 58, N'ليلى', 7, CAST(N'2019-02-07T09:59:41.020' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (182, 58, N'كايرو بيزنس بارك', 7, CAST(N'2019-02-07T09:59:56.473' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (183, 22, N'سكن', 7, CAST(N'2019-02-07T10:00:16.377' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (184, 58, N'هاي لاند بارك', 7, CAST(N'2019-02-07T10:00:30.283' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (185, 58, N'ماونتن فيو إكسكيوتف ريزيدنس', 7, CAST(N'2019-02-07T10:00:59.050' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (186, 58, N'ريجنتس بارك', 7, CAST(N'2019-02-07T10:01:13.160' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (187, 58, N'فيليت', 7, CAST(N'2019-02-07T10:01:29.050' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (188, 58, N'أسوار', 7, CAST(N'2019-02-07T10:01:39.537' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (189, 58, N'منتجع النخيل', 7, CAST(N'2019-02-07T10:01:57.287' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (190, 58, N'ليك فيو ريزيدنس', 7, CAST(N'2019-02-07T10:02:12.237' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (191, 58, N'لايف ميديكال', 7, CAST(N'2019-02-07T10:02:43.597' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (192, 58, N'إيطاليان سكوير', 7, CAST(N'2019-02-07T10:02:58.440' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (193, 58, N'أى سيتي', 7, CAST(N'2019-02-07T10:03:13.143' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (194, 58, N'قطامية هيلز', 7, CAST(N'2019-02-07T10:03:45.973' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (195, 58, N'ساراي', 7, CAST(N'2019-02-07T10:03:58.473' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (196, 58, N'أب هيل ريزيدنس', 7, CAST(N'2019-02-07T10:04:20.037' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (197, 58, N'روك فيرا', 7, CAST(N'2019-02-07T10:04:33.457' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (198, 58, N'قطامية جيت', 7, CAST(N'2019-02-07T10:04:45.177' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (199, 58, N'درة القرن', 7, CAST(N'2019-02-07T10:04:56.143' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (200, 58, N'فيفث سكوير', 7, CAST(N'2019-02-07T10:05:11.270' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (201, 22, N'إم سكوير جاردنز', 7, CAST(N'2019-02-07T10:05:39.067' AS DateTime), 1, 0)
GO
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (202, 58, N'لافاونتن', 7, CAST(N'2019-02-07T10:06:00.487' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (203, 58, N'بروميناد ريزيدنس', 7, CAST(N'2019-02-07T10:06:17.520' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (204, 58, N'الباتيو 7', 7, CAST(N'2019-02-07T10:06:30.487' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (205, 58, N'نست كايرو', 7, CAST(N'2019-02-07T10:06:52.910' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (206, 58, N'كابتل جاردنز', 7, CAST(N'2019-02-07T10:07:05.957' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (207, 58, N'قطامية بريز', 7, CAST(N'2019-02-07T10:07:19.817' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (208, 58, N'لو ريف', 7, CAST(N'2019-02-07T10:07:32.660' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (209, 58, N'مدينة الياسمين', 7, CAST(N'2019-02-07T10:07:44.660' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (210, 58, N'أرابيلا فيلدج', 7, CAST(N'2019-02-07T10:07:58.237' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (211, 58, N'إيزي لايف', 7, CAST(N'2019-02-07T10:08:10.583' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (212, 58, N'فيوتشر جيت', 7, CAST(N'2019-02-07T10:08:23.613' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (213, 58, N'ميراج ريزيدنس', 7, CAST(N'2019-02-07T10:08:54.097' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (214, 58, N'سيتي جيت', 7, CAST(N'2019-02-07T10:09:52.613' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (215, 58, N'سيتي جيت', 7, CAST(N'2019-02-07T10:09:52.833' AS DateTime), 1, 1)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (216, 58, N'بالم هيلز', 7, CAST(N'2019-02-07T10:10:15.113' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (217, 58, N'رامبلاز', 7, CAST(N'2019-02-07T10:10:30.147' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (218, 58, N'الفداء جاردنز', 7, CAST(N'2019-02-07T10:10:48.067' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (219, 58, N'صفوة ريزيدنس', 7, CAST(N'2019-02-07T10:11:01.287' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (220, 58, N'الغازي جاردن', 7, CAST(N'2019-02-07T10:11:29.253' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (221, 58, N'أزاد', 7, CAST(N'2019-02-07T10:11:41.207' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (222, 58, N'سمارت لايف', 7, CAST(N'2019-02-07T10:11:51.927' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (223, 58, N'ذا كور', 7, CAST(N'2019-02-07T10:12:17.770' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (224, 58, N'الباتيو أورو', 7, CAST(N'2019-02-07T10:13:38.317' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (225, 58, N'كابيتل جيت', 7, CAST(N'2019-02-07T10:13:49.787' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (226, 58, N'أزار', 7, CAST(N'2019-02-07T10:14:00.253' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (227, 58, N'أوريانا', 7, CAST(N'2019-02-07T10:14:13.630' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (228, 58, N'ديستريكت 5', 7, CAST(N'2019-02-07T10:14:26.223' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (229, 58, N'العربية جيت', 7, CAST(N'2019-02-07T10:14:40.677' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (230, 58, N'ادرس ايست', 7, CAST(N'2019-02-07T10:14:54.130' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (231, 58, N'ذا أيقون ريزيدنس', 7, CAST(N'2019-02-07T10:15:14.443' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (232, 58, N'كاونتي', 7, CAST(N'2019-02-07T10:15:26.410' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (233, 58, N'وينسر بالاس', 7, CAST(N'2019-02-07T10:16:10.833' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (234, 58, N'ستيلا بارك', 7, CAST(N'2019-02-07T10:16:22.147' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (235, 58, N'تاج سلطان', 7, CAST(N'2019-02-07T10:16:42.160' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (236, 58, N'زيزينيا روز', 7, CAST(N'2019-02-07T10:16:59.050' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (237, 58, N'ستون ريزيدنس', 7, CAST(N'2019-02-07T10:17:10.677' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (238, 58, N'أزادير', 7, CAST(N'2019-02-07T10:17:22.300' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (239, 58, N'ويسترن فيل', 7, CAST(N'2019-02-07T10:17:36.440' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (240, 58, N'كليوباترا إيست', 7, CAST(N'2019-02-07T10:17:54.380' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (241, 58, N'روك إيليت', 7, CAST(N'2019-02-07T10:18:22.130' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (242, 58, N'رويال جرين', 7, CAST(N'2019-02-07T10:18:33.440' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (243, 58, N'ميراج سيتي', 7, CAST(N'2019-02-07T10:18:47.660' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (244, 58, N'فيفيندا', 7, CAST(N'2019-02-07T10:19:16.317' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (245, 58, N'تريو جاردنز', 7, CAST(N'2019-02-07T10:19:30.943' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (246, 58, N'اليجانتري', 7, CAST(N'2019-02-07T10:19:42.803' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (247, 58, N'لايف جاردن', 7, CAST(N'2019-02-07T10:19:57.303' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (248, 58, N'غرب الجولف', 7, CAST(N'2019-02-07T10:20:25.583' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (249, 58, N'الدبلوماسيين', 7, CAST(N'2019-02-07T10:20:47.207' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (250, 22, N'دار مصر', 7, CAST(N'2019-02-07T10:21:11.770' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (251, 21, N'مدينة المستقبل', 7, CAST(N'2019-02-07T10:25:03.350' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (252, 251, N'جرين سكوير', 7, CAST(N'2019-02-07T10:25:24.177' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (253, 251, N'زيزينيا المستقبل', 7, CAST(N'2019-02-07T10:25:39.443' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (254, 251, N'نيوبوليس', 7, CAST(N'2019-02-07T10:25:59.147' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (255, 251, N'لافينير', 7, CAST(N'2019-02-07T10:26:11.147' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (256, 251, N'أريا لاند مارك صبور', 7, CAST(N'2019-02-07T10:26:41.240' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (257, 251, N'لاميرادا المستقبل', 7, CAST(N'2019-02-07T10:28:23.897' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (258, 251, N'بيتا جرينز', 7, CAST(N'2019-02-07T10:28:40.473' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (259, 251, N'أوديسيا', 7, CAST(N'2019-02-07T10:28:52.053' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (260, 251, N'بلوم فيلدز', 7, CAST(N'2019-02-07T10:29:15.163' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (261, 251, N'هاب تاون', 7, CAST(N'2019-02-07T10:29:27.177' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (262, 251, N'ذا كانيون', 7, CAST(N'2019-02-07T10:29:49.177' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (263, 251, N'Others...', 7, CAST(N'2019-02-07T10:30:18.833' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (264, 58, N'ام سكوير جاردن', 7, CAST(N'2019-02-07T12:00:42.817' AS DateTime), 1, 0)
SET IDENTITY_INSERT [dbo].[Locations] OFF
SET IDENTITY_INSERT [dbo].[OwnerShipTypes] ON 

INSERT [dbo].[OwnerShipTypes] ([OwnerShipTypeID], [OwnerShipTitle], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (1005, N'مالك', 1, CAST(N'2018-04-17T21:03:51.443' AS DateTime), 1, 1)
INSERT [dbo].[OwnerShipTypes] ([OwnerShipTypeID], [OwnerShipTitle], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (2006, N'وسيط', 1, CAST(N'2018-04-15T01:03:15.393' AS DateTime), 1, 0)
SET IDENTITY_INSERT [dbo].[OwnerShipTypes] OFF
SET IDENTITY_INSERT [dbo].[Projects] ON 

INSERT [dbo].[Projects] ([CompanyID], [ProjectID], [ProjectTypeID], [ProjectName], [LocationID], [AddressDetails], [NoOfUnits], [ProjectStatusID], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (5, 13, 1, N'الاندلس ٩١٢', 43, N'الاندلس الجديدة', 6, 2, 7, CAST(N'2019-02-24T16:25:12.503' AS DateTime), 1, 0)
INSERT [dbo].[Projects] ([CompanyID], [ProjectID], [ProjectTypeID], [ProjectName], [LocationID], [AddressDetails], [NoOfUnits], [ProjectStatusID], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (6, 14, 1, N'Hhh', 36, N'Hh', 3, 2, 7, CAST(N'2019-04-28T15:53:29.807' AS DateTime), 1, 0)
SET IDENTITY_INSERT [dbo].[Projects] OFF
SET IDENTITY_INSERT [dbo].[ProjectStatus] ON 

INSERT [dbo].[ProjectStatus] ([ProjectStatusID], [StatusTitle], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (1, N'تشطيب كامل', 1, CAST(N'2018-04-28T15:34:29.713' AS DateTime), 1, 0)
INSERT [dbo].[ProjectStatus] ([ProjectStatusID], [StatusTitle], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (2, N'نصف تشطيب', 1, CAST(N'2018-04-28T15:34:40.720' AS DateTime), 1, 0)
INSERT [dbo].[ProjectStatus] ([ProjectStatusID], [StatusTitle], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (3, N'غير متشطبة', 1, CAST(N'2019-02-06T10:46:15.000' AS DateTime), 1, 0)
SET IDENTITY_INSERT [dbo].[ProjectStatus] OFF
SET IDENTITY_INSERT [dbo].[ProjectTypes] ON 

INSERT [dbo].[ProjectTypes] ([ProjectTypeID], [ProjectTypeName], [IsActive], [IsDeleted]) VALUES (1, N'كومباوند', 1, 0)
INSERT [dbo].[ProjectTypes] ([ProjectTypeID], [ProjectTypeName], [IsActive], [IsDeleted]) VALUES (2, N'منفصل', 1, 0)
SET IDENTITY_INSERT [dbo].[ProjectTypes] OFF
SET IDENTITY_INSERT [dbo].[Properties] ON 

INSERT [dbo].[Properties] ([PropertyID], [Title], [CustomerID], [ByUserID], [LocationID], [AddressDetails], [ProjectID], [IsUnit], [Price], [CanInstallment], [NoOfYears], [DownPayment], [FloorNum], [PropertyFloorTypeID], [NoOfProperties], [Area], [OwnerShipTypeID], [PropertyTypeID], [PropertyPurposeID], [HasElevator], [HasGarage], [AllowVisitors], [Commission], [NumberOfRooms], [NumberOfBathrooms], [ReadyDate], [LastUpdated], [SharedID], [Comments], [EntryDate], [IsActive], [IsDeleted]) VALUES (29, N'Test 2', 0, 7, 43, N'تالت نمرة من التسعين', 13, 0, CAST(2000000 AS Decimal(9, 0)), 1, 3, CAST(450000 AS Decimal(9, 0)), 0, 2, 0, 240, 1005, 1, 6, 1, 1, 1, 1, 4, 3, CAST(N'2019-03-24' AS Date), CAST(N'2019-02-27T08:08:16.870' AS DateTime), N'All', NULL, CAST(N'2019-02-27T08:08:16.870' AS DateTime), 1, 1)
INSERT [dbo].[Properties] ([PropertyID], [Title], [CustomerID], [ByUserID], [LocationID], [AddressDetails], [ProjectID], [IsUnit], [Price], [CanInstallment], [NoOfYears], [DownPayment], [FloorNum], [PropertyFloorTypeID], [NoOfProperties], [Area], [OwnerShipTypeID], [PropertyTypeID], [PropertyPurposeID], [HasElevator], [HasGarage], [AllowVisitors], [Commission], [NumberOfRooms], [NumberOfBathrooms], [ReadyDate], [LastUpdated], [SharedID], [Comments], [EntryDate], [IsActive], [IsDeleted]) VALUES (30, N'Test1', 0, 7, 35, N'اللوتس الشمالية', NULL, 0, CAST(1400000 AS Decimal(9, 0)), 1, 4, CAST(400000 AS Decimal(9, 0)), 0, 1, 0, 200, 1005, 1, 6, 1, 1, 1, 1, 3, 3, CAST(N'0001-01-01' AS Date), CAST(N'2019-02-27T08:07:54.417' AS DateTime), N'All', NULL, CAST(N'2019-02-27T08:07:54.417' AS DateTime), 1, 1)
INSERT [dbo].[Properties] ([PropertyID], [Title], [CustomerID], [ByUserID], [LocationID], [AddressDetails], [ProjectID], [IsUnit], [Price], [CanInstallment], [NoOfYears], [DownPayment], [FloorNum], [PropertyFloorTypeID], [NoOfProperties], [Area], [OwnerShipTypeID], [PropertyTypeID], [PropertyPurposeID], [HasElevator], [HasGarage], [AllowVisitors], [Commission], [NumberOfRooms], [NumberOfBathrooms], [ReadyDate], [LastUpdated], [SharedID], [Comments], [EntryDate], [IsActive], [IsDeleted]) VALUES (31, N'دوبلكس 320م بمنطقة الدفاع الوطني استلام فوري', 0, 10, 37, N'الدفاع الوطني', NULL, 0, CAST(1750000 AS Decimal(9, 0)), 1, 1, CAST(875000 AS Decimal(9, 0)), 0, 1, 0, 320, 1005, 4, 6, 0, 1, 0, 0.5, 5, 3, CAST(N'2019-04-01' AS Date), CAST(N'2019-03-24T05:45:38.683' AS DateTime), N'All', N'دوبلكس ارضي و بيزمنت استلام فوري  ', CAST(N'2019-03-24T05:45:38.683' AS DateTime), 1, 1)
INSERT [dbo].[Properties] ([PropertyID], [Title], [CustomerID], [ByUserID], [LocationID], [AddressDetails], [ProjectID], [IsUnit], [Price], [CanInstallment], [NoOfYears], [DownPayment], [FloorNum], [PropertyFloorTypeID], [NoOfProperties], [Area], [OwnerShipTypeID], [PropertyTypeID], [PropertyPurposeID], [HasElevator], [HasGarage], [AllowVisitors], [Commission], [NumberOfRooms], [NumberOfBathrooms], [ReadyDate], [LastUpdated], [SharedID], [Comments], [EntryDate], [IsActive], [IsDeleted]) VALUES (32, N'دوبلكس 320م بمنطقة الدفاع الوطني استلام فوري', 0, 10, 37, N'الدفاع الوطني', NULL, 0, CAST(1750000 AS Decimal(9, 0)), 1, 1, CAST(875000 AS Decimal(9, 0)), 0, 1, 0, 320, 1005, 4, 6, 0, 1, 1, 0.5, 5, 3, CAST(N'2019-04-01' AS Date), CAST(N'2019-03-24T21:15:32.793' AS DateTime), N'All', N'دوبلكس ارضي و بيزمنت استلام فوري  320 متر واجهة حجر هاشمي و مدخل رخام مستورد', CAST(N'2019-03-24T21:15:32.793' AS DateTime), 1, 0)
INSERT [dbo].[Properties] ([PropertyID], [Title], [CustomerID], [ByUserID], [LocationID], [AddressDetails], [ProjectID], [IsUnit], [Price], [CanInstallment], [NoOfYears], [DownPayment], [FloorNum], [PropertyFloorTypeID], [NoOfProperties], [Area], [OwnerShipTypeID], [PropertyTypeID], [PropertyPurposeID], [HasElevator], [HasGarage], [AllowVisitors], [Commission], [NumberOfRooms], [NumberOfBathrooms], [ReadyDate], [LastUpdated], [SharedID], [Comments], [EntryDate], [IsActive], [IsDeleted]) VALUES (33, N'شقة 165م داكل كمبوند المستشارين الجنوبية', 0, 10, 37, N'المستشارين الجنوبية', NULL, 0, CAST(1150000 AS Decimal(9, 0)), 1, 1, CAST(575000 AS Decimal(9, 0)), 0, 2, 0, 165, 1005, 1, 6, 1, 1, 1, 0.5, 3, 3, CAST(N'2019-10-01' AS Date), CAST(N'2019-03-24T21:15:11.497' AS DateTime), N'All', N'شقة 165 متر 3 نوم - 3 حمام - 3 رسيبشن - مطبخ استلام 6 شهور نصف تشطيب خصم 100 الف للكاش', CAST(N'2019-03-24T21:15:11.497' AS DateTime), 1, 0)
INSERT [dbo].[Properties] ([PropertyID], [Title], [CustomerID], [ByUserID], [LocationID], [AddressDetails], [ProjectID], [IsUnit], [Price], [CanInstallment], [NoOfYears], [DownPayment], [FloorNum], [PropertyFloorTypeID], [NoOfProperties], [Area], [OwnerShipTypeID], [PropertyTypeID], [PropertyPurposeID], [HasElevator], [HasGarage], [AllowVisitors], [Commission], [NumberOfRooms], [NumberOfBathrooms], [ReadyDate], [LastUpdated], [SharedID], [Comments], [EntryDate], [IsActive], [IsDeleted]) VALUES (34, N'شقة ٢٤٥ متر بالقرنفل', 0, 7, 46, N'القرنفل ٩', NULL, 0, CAST(1800000 AS Decimal(9, 0)), 0, NULL, NULL, 0, 2, 0, 245, 2006, 1, 6, 1, 1, 1, 1, 4, 3, CAST(N'0001-01-01' AS Date), CAST(N'2019-04-28T15:47:27.273' AS DateTime), N'All', NULL, CAST(N'2019-04-28T15:47:27.273' AS DateTime), 1, 0)
INSERT [dbo].[Properties] ([PropertyID], [Title], [CustomerID], [ByUserID], [LocationID], [AddressDetails], [ProjectID], [IsUnit], [Price], [CanInstallment], [NoOfYears], [DownPayment], [FloorNum], [PropertyFloorTypeID], [NoOfProperties], [Area], [OwnerShipTypeID], [PropertyTypeID], [PropertyPurposeID], [HasElevator], [HasGarage], [AllowVisitors], [Commission], [NumberOfRooms], [NumberOfBathrooms], [ReadyDate], [LastUpdated], [SharedID], [Comments], [EntryDate], [IsActive], [IsDeleted]) VALUES (35, N'Jj', 0, 7, 36, N'Kk', 14, 0, CAST(1600000 AS Decimal(9, 0)), 1, 2, CAST(200000 AS Decimal(9, 0)), 0, 2, 0, 200, 2006, 1, 6, 1, 1, 1, 2, 3, 2, CAST(N'0001-01-01' AS Date), CAST(N'2019-04-28T15:55:00.293' AS DateTime), N'VerifiedBroker', NULL, CAST(N'2019-04-28T15:55:00.293' AS DateTime), 1, 0)
INSERT [dbo].[Properties] ([PropertyID], [Title], [CustomerID], [ByUserID], [LocationID], [AddressDetails], [ProjectID], [IsUnit], [Price], [CanInstallment], [NoOfYears], [DownPayment], [FloorNum], [PropertyFloorTypeID], [NoOfProperties], [Area], [OwnerShipTypeID], [PropertyTypeID], [PropertyPurposeID], [HasElevator], [HasGarage], [AllowVisitors], [Commission], [NumberOfRooms], [NumberOfBathrooms], [ReadyDate], [LastUpdated], [SharedID], [Comments], [EntryDate], [IsActive], [IsDeleted]) VALUES (36, N'test', 0, 7, 25, N'banafseg', NULL, 0, CAST(1500000 AS Decimal(9, 0)), 1, 2, CAST(500000 AS Decimal(9, 0)), 0, 2, 0, 210, 2006, 1, 6, 1, 1, 1, 1, 3, 2, CAST(N'2019-03-01' AS Date), CAST(N'2019-05-04T22:01:12.427' AS DateTime), N'All', NULL, CAST(N'2019-05-04T22:01:12.427' AS DateTime), 1, 0)
SET IDENTITY_INSERT [dbo].[Properties] OFF
SET IDENTITY_INSERT [dbo].[PropertyFloorTypes] ON 

INSERT [dbo].[PropertyFloorTypes] ([PropertyFloorTypeID], [FloorTypeTitle], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (1, N'أرضى', 1, CAST(N'2018-04-17T21:40:55.690' AS DateTime), 1, 0)
INSERT [dbo].[PropertyFloorTypes] ([PropertyFloorTypeID], [FloorTypeTitle], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (2, N'متكرر', 1, CAST(N'2018-11-25T15:38:25.267' AS DateTime), 1, 0)
INSERT [dbo].[PropertyFloorTypes] ([PropertyFloorTypeID], [FloorTypeTitle], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (3, N'رووف', 1, CAST(N'2018-11-25T15:38:33.400' AS DateTime), 1, 0)
SET IDENTITY_INSERT [dbo].[PropertyFloorTypes] OFF
SET IDENTITY_INSERT [dbo].[PropertyPurpose] ON 

INSERT [dbo].[PropertyPurpose] ([PropertyPurposeID], [PropPurposeTitle], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (4, N'طوب أحمر', 1, CAST(N'2018-06-12T01:07:18.893' AS DateTime), 1, 0)
INSERT [dbo].[PropertyPurpose] ([PropertyPurposeID], [PropPurposeTitle], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (6, N'نصف تشطيب', 1, CAST(N'2019-03-26T00:39:25.230' AS DateTime), 1, 0)
INSERT [dbo].[PropertyPurpose] ([PropertyPurposeID], [PropPurposeTitle], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (7, N'لوكس', 1, CAST(N'2019-03-26T00:39:44.590' AS DateTime), 1, 0)
INSERT [dbo].[PropertyPurpose] ([PropertyPurposeID], [PropPurposeTitle], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (8, N'سوبر لوكس', 1, CAST(N'2019-03-26T00:40:01.717' AS DateTime), 1, 0)
SET IDENTITY_INSERT [dbo].[PropertyPurpose] OFF
SET IDENTITY_INSERT [dbo].[PropertyRequests] ON 

INSERT [dbo].[PropertyRequests] ([RequestID], [Title], [CustomerID], [GovID], [CityID], [LocationIDs], [AddressDetails], [MinPrice], [MaxPrice], [CanInstallment], [NoOfYears], [PropertyFloorTypeID], [MinArea], [MaxArea], [OwnerShipTypeID], [PropertyTypeID], [PropertyPurposeID], [Comments], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (11, N'مطلوب شقة ارضى بحديقة بنفسج فيلات', 0, 21, 22, NULL, N'بنفسج فيلات', CAST(300000 AS Decimal(9, 0)), CAST(1500000 AS Decimal(9, 0)), 1, 2, NULL, 180, 250, NULL, 1, 6, NULL, 7, CAST(N'2019-05-04T22:05:10.620' AS DateTime), 1, 0)
INSERT [dbo].[PropertyRequests] ([RequestID], [Title], [CustomerID], [GovID], [CityID], [LocationIDs], [AddressDetails], [MinPrice], [MaxPrice], [CanInstallment], [NoOfYears], [PropertyFloorTypeID], [MinArea], [MaxArea], [OwnerShipTypeID], [PropertyTypeID], [PropertyPurposeID], [Comments], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (12, N'طلببب', 0, 21, 22, 34, N'يبيبيب', CAST(0 AS Decimal(9, 0)), CAST(0 AS Decimal(9, 0)), 0, NULL, 1, NULL, NULL, NULL, NULL, 4, NULL, 2, CAST(N'2019-05-12T21:08:13.203' AS DateTime), 1, 0)
SET IDENTITY_INSERT [dbo].[PropertyRequests] OFF
SET IDENTITY_INSERT [dbo].[PropertyTypes] ON 

INSERT [dbo].[PropertyTypes] ([PropertyTypeID], [PropTypeTitle], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (1, N'شقة', 1, CAST(N'2018-06-12T01:09:20.310' AS DateTime), 1, 0)
INSERT [dbo].[PropertyTypes] ([PropertyTypeID], [PropTypeTitle], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (4, N'دوبلكس', 1, CAST(N'2018-11-25T15:21:28.557' AS DateTime), 1, 0)
SET IDENTITY_INSERT [dbo].[PropertyTypes] OFF
INSERT [dbo].[Shared] ([ShareID], [ShareTitle]) VALUES (N'All', N'كل الوسطاء')
INSERT [dbo].[Shared] ([ShareID], [ShareTitle]) VALUES (N'OnlyMe', N'معى فقط')
INSERT [dbo].[Shared] ([ShareID], [ShareTitle]) VALUES (N'VerifiedBroker', N'وسطاء موثقين')
SET IDENTITY_INSERT [dbo].[SpecialOffers] ON 

INSERT [dbo].[SpecialOffers] ([OfferID], [OfferTitle], [OfferDesc], [EntryDate], [ImgPath], [IsActive], [IsDeleted], [ByUserID], [SortOrder]) VALUES (1, N'قسم خاص باتحاد الملاك', N'لمشاريع اتحاد الملاك بأسعار مناسبة
', CAST(N'2019-02-03T10:17:47.193' AS DateTime), NULL, 1, 1, 7, NULL)
INSERT [dbo].[SpecialOffers] ([OfferID], [OfferTitle], [OfferDesc], [EntryDate], [ImgPath], [IsActive], [IsDeleted], [ByUserID], [SortOrder]) VALUES (2, N'ytytytytytytytytytytytytytytytytytytytytytytyt', N'ytytytytytytytytytytytytytytytytytytytytytytytytytytytytytyt', CAST(N'2019-02-06T10:52:30.517' AS DateTime), N'Beee444G.jpg', 1, 1, 2, NULL)
INSERT [dbo].[SpecialOffers] ([OfferID], [OfferTitle], [OfferDesc], [EntryDate], [ImgPath], [IsActive], [IsDeleted], [ByUserID], [SortOrder]) VALUES (3, N'Test', N'Whatever', CAST(N'2019-02-23T10:52:50.943' AS DateTime), N'52598838_2270700476551933_6826967146828922880_o.jpg', 1, 1, 7, NULL)
INSERT [dbo].[SpecialOffers] ([OfferID], [OfferTitle], [OfferDesc], [EntryDate], [ImgPath], [IsActive], [IsDeleted], [ByUserID], [SortOrder]) VALUES (4, N'مشروع اتحاد ملاك بالأندلس', N'التفاصيل', CAST(N'2019-05-05T19:17:30.583' AS DateTime), N'Moon Wow.jpg', 1, 0, 7, NULL)
SET IDENTITY_INSERT [dbo].[SpecialOffers] OFF
INSERT [dbo].[UserGroups] ([UserGroupName], [UserGroupDesc]) VALUES (N'Admin', NULL)
INSERT [dbo].[UserGroups] ([UserGroupName], [UserGroupDesc]) VALUES (N'SuperAdmin', NULL)
INSERT [dbo].[UserGroups] ([UserGroupName], [UserGroupDesc]) VALUES (N'User', NULL)
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserID], [CompanyID], [UserGroupName], [IsVerfied], [FullName], [Email], [Mobile], [UserPassword], [FavouriteLocationIDs], [Notes], [ProfileImgPath], [IsConfirmed], [LastLogin], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (2, NULL, N'Admin', 1, N'Ahmed Safwat', N'info@linkedbroker.com', N'01062800820', N'Admin123!', NULL, NULL, NULL, 1, NULL, NULL, CAST(N'2019-01-01T14:00:33.440' AS DateTime), 1, 0)
INSERT [dbo].[Users] ([UserID], [CompanyID], [UserGroupName], [IsVerfied], [FullName], [Email], [Mobile], [UserPassword], [FavouriteLocationIDs], [Notes], [ProfileImgPath], [IsConfirmed], [LastLogin], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (6, NULL, N'User', NULL, N'عمر بحيرى', N'mohamd.behery@yahoo.com', N'01007330161', N'Omar@123', NULL, NULL, N'Screenshot_5.png', 1, NULL, NULL, CAST(N'2019-01-14T05:01:43.467' AS DateTime), 1, 0)
INSERT [dbo].[Users] ([UserID], [CompanyID], [UserGroupName], [IsVerfied], [FullName], [Email], [Mobile], [UserPassword], [FavouriteLocationIDs], [Notes], [ProfileImgPath], [IsConfirmed], [LastLogin], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (7, NULL, N'Admin', 0, N'Ahmed safwat', N'a.safwat.a1990@gmail.com', N'00201062800820', N'safwatsafwat', NULL, N'Welcome', N'46421777_10156034728436139_8968861268555333632_n.jpg', 1, NULL, NULL, CAST(N'2019-01-14T08:55:38.833' AS DateTime), 1, 0)
INSERT [dbo].[Users] ([UserID], [CompanyID], [UserGroupName], [IsVerfied], [FullName], [Email], [Mobile], [UserPassword], [FavouriteLocationIDs], [Notes], [ProfileImgPath], [IsConfirmed], [LastLogin], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (8, NULL, N'User', NULL, N'ahmad salama', N'salamaa2000@gmail.com', N'01066466070', N'asd100100', NULL, NULL, N'ahmad salama.jpg', 1, NULL, NULL, CAST(N'2019-02-07T13:13:26.553' AS DateTime), 1, 0)
INSERT [dbo].[Users] ([UserID], [CompanyID], [UserGroupName], [IsVerfied], [FullName], [Email], [Mobile], [UserPassword], [FavouriteLocationIDs], [Notes], [ProfileImgPath], [IsConfirmed], [LastLogin], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (9, NULL, N'User', NULL, N'Mohamed El Amin ', N'moelmeeto@gmail.com', N'01062266434', N'love@1432', NULL, NULL, N'20190209_011431.jpg', 1, NULL, NULL, CAST(N'2019-02-09T11:14:11.430' AS DateTime), 1, 0)
INSERT [dbo].[Users] ([UserID], [CompanyID], [UserGroupName], [IsVerfied], [FullName], [Email], [Mobile], [UserPassword], [FavouriteLocationIDs], [Notes], [ProfileImgPath], [IsConfirmed], [LastLogin], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (10, NULL, N'User', 0, N'ابرار العقارية', N'abrar.abrar.newcairo@gmail.com', N'01020144556', N'abrar123abrar', NULL, NULL, N'abrar logo FACEBOOK --.jpg', 1, NULL, NULL, CAST(N'2019-02-28T03:19:42.000' AS DateTime), 1, 0)
INSERT [dbo].[Users] ([UserID], [CompanyID], [UserGroupName], [IsVerfied], [FullName], [Email], [Mobile], [UserPassword], [FavouriteLocationIDs], [Notes], [ProfileImgPath], [IsConfirmed], [LastLogin], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (11, NULL, N'User', NULL, N'Mohamed safwat al said ', N'marcosafwat11@gmail.com', N'01099993111', N'marcomarco99', NULL, NULL, N'23426086-63FE-47CB-84B9-CC9DEE0E2BC3.jpeg', 0, NULL, NULL, CAST(N'2019-03-26T13:30:34.310' AS DateTime), 1, 0)
INSERT [dbo].[Users] ([UserID], [CompanyID], [UserGroupName], [IsVerfied], [FullName], [Email], [Mobile], [UserPassword], [FavouriteLocationIDs], [Notes], [ProfileImgPath], [IsConfirmed], [LastLogin], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (12, NULL, N'User', NULL, N'محمد صفوت السيد ', N'marcosafwat11@icloud.com', N'01099993111', N'marcomarco99', NULL, NULL, NULL, 0, NULL, NULL, CAST(N'2019-03-26T13:50:54.953' AS DateTime), 1, 0)
INSERT [dbo].[Users] ([UserID], [CompanyID], [UserGroupName], [IsVerfied], [FullName], [Email], [Mobile], [UserPassword], [FavouriteLocationIDs], [Notes], [ProfileImgPath], [IsConfirmed], [LastLogin], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (13, NULL, N'User', NULL, N'محمد أسامة محمد', N'eng.mo7ammed.osama@gmail.com', N'01067636965', N'123456789!', NULL, N'dfgd', NULL, 1, NULL, NULL, CAST(N'2019-03-27T14:09:45.173' AS DateTime), 1, 0)
INSERT [dbo].[Users] ([UserID], [CompanyID], [UserGroupName], [IsVerfied], [FullName], [Email], [Mobile], [UserPassword], [FavouriteLocationIDs], [Notes], [ProfileImgPath], [IsConfirmed], [LastLogin], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (14, NULL, N'User', NULL, N'Ahmed Safwat', N'a.safwat.a@aucegypt.edu', N'01062800820', N'safwatsafwat', NULL, NULL, NULL, 1, NULL, NULL, CAST(N'2019-04-02T19:17:04.450' AS DateTime), 1, 0)
INSERT [dbo].[Users] ([UserID], [CompanyID], [UserGroupName], [IsVerfied], [FullName], [Email], [Mobile], [UserPassword], [FavouriteLocationIDs], [Notes], [ProfileImgPath], [IsConfirmed], [LastLogin], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (15, NULL, N'User', NULL, N'Mohamad Montaser ', N'mohammont@gmail.com', N'01009019371', N'01009019371aaa', NULL, N'أنا إللي مربي أحمد صفوت ', NULL, 1, NULL, NULL, CAST(N'2019-04-05T04:09:22.657' AS DateTime), 1, 0)
INSERT [dbo].[Users] ([UserID], [CompanyID], [UserGroupName], [IsVerfied], [FullName], [Email], [Mobile], [UserPassword], [FavouriteLocationIDs], [Notes], [ProfileImgPath], [IsConfirmed], [LastLogin], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (16, NULL, N'User', NULL, N'Mohamed El Amin', N'egybrokers2020@gmail.com', N'00201062266434', N'love1432', NULL, N'Mohammed is an expert in real estate of new Cairo and the new capital, likes to help and give advice.', N'32859544_215450802517055_4525663432715796480_n.jpg', 1, NULL, NULL, CAST(N'2019-04-13T02:51:55.673' AS DateTime), 1, 0)
INSERT [dbo].[Users] ([UserID], [CompanyID], [UserGroupName], [IsVerfied], [FullName], [Email], [Mobile], [UserPassword], [FavouriteLocationIDs], [Notes], [ProfileImgPath], [IsConfirmed], [LastLogin], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (17, NULL, N'User', NULL, N'نهي النجار', N'noha.el.naggar@hotmail.com', N'01065554454', N'kamara2002', NULL, N'بدايه جديده ان شاءالله ف عالم التسويق ', NULL, 0, NULL, NULL, CAST(N'2019-04-30T15:26:20.207' AS DateTime), 1, 0)
SET IDENTITY_INSERT [dbo].[Users] OFF
SET IDENTITY_INSERT [dbo].[VerficationRequests] ON 

INSERT [dbo].[VerficationRequests] ([VerficationID], [UserID], [CompanyID], [RequestContent], [VerfiedStatusID], [AdminMessage], [LastUpdated], [EntryDate]) VALUES (2, 7, 5, N'Hh', 2, N'تم التوثيق بنجاح', CAST(N'2019-02-25T21:28:23.730' AS DateTime), CAST(N'2019-02-25T21:28:23.730' AS DateTime))
INSERT [dbo].[VerficationRequests] ([VerficationID], [UserID], [CompanyID], [RequestContent], [VerfiedStatusID], [AdminMessage], [LastUpdated], [EntryDate]) VALUES (3, 7, 6, N'And now', 2, N'Nice', CAST(N'2019-04-28T15:57:09.963' AS DateTime), CAST(N'2019-04-28T15:55:49.277' AS DateTime))
SET IDENTITY_INSERT [dbo].[VerficationRequests] OFF
SET IDENTITY_INSERT [dbo].[VerficationStatus] ON 

INSERT [dbo].[VerficationStatus] ([VerfiedStatusID], [VerfiedStatusTitle]) VALUES (1, N'جارى التوثيق')
INSERT [dbo].[VerficationStatus] ([VerfiedStatusID], [VerfiedStatusTitle]) VALUES (2, N'تم التوثيق')
INSERT [dbo].[VerficationStatus] ([VerfiedStatusID], [VerfiedStatusTitle]) VALUES (3, N'رفض لنقص البيانات')
INSERT [dbo].[VerficationStatus] ([VerfiedStatusID], [VerfiedStatusTitle]) VALUES (4, N'رفض نهائى')
SET IDENTITY_INSERT [dbo].[VerficationStatus] OFF
ALTER TABLE [dbo].[Companies] ADD  CONSTRAINT [DF_Companies_EntryDate]  DEFAULT (getdate()) FOR [EntryDate]
GO
ALTER TABLE [dbo].[CompanyVerificationTypes] ADD  CONSTRAINT [DF_CompanyVerificationTypes_EntryDate]  DEFAULT (getdate()) FOR [EntryDate]
GO
ALTER TABLE [dbo].[CompanyVerificationTypes] ADD  CONSTRAINT [DF_CompanyVerificationTypes_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[CompanyVerificationTypes] ADD  CONSTRAINT [DF_CompanyVerificationTypes_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[CusomerPreviews] ADD  CONSTRAINT [DF_CusomerPreviews_NoOfProperties]  DEFAULT ((1)) FOR [NoOfProperties]
GO
ALTER TABLE [dbo].[CusomerPreviews] ADD  CONSTRAINT [DF_CusomerPreviews_EntryDate_1]  DEFAULT (getdate()) FOR [EntryDate]
GO
ALTER TABLE [dbo].[Customer.CustomerStatus] ADD  CONSTRAINT [DF_Customer.CustomerStatus_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[Customers] ADD  CONSTRAINT [DF_Customers_EntryDate]  DEFAULT (getdate()) FOR [EntryDate]
GO
ALTER TABLE [dbo].[CustomerStatus] ADD  CONSTRAINT [DF_CustomerStatus_EntryDate]  DEFAULT (getdate()) FOR [EntryDate]
GO
ALTER TABLE [dbo].[CustomerStatus] ADD  CONSTRAINT [DF_CustomerStatus_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[CustomerStatus] ADD  CONSTRAINT [DF_CustomerStatus_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[Locations] ADD  CONSTRAINT [DF_Locations_EntryDate]  DEFAULT (getdate()) FOR [EntryDate]
GO
ALTER TABLE [dbo].[OwnerShipTypes] ADD  CONSTRAINT [DF_OwnerShipTypes_EntryDate]  DEFAULT (getdate()) FOR [EntryDate]
GO
ALTER TABLE [dbo].[OwnerShipTypes] ADD  CONSTRAINT [DF_OwnerShipTypes_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[OwnerShipTypes] ADD  CONSTRAINT [DF_OwnerShipTypes_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
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
ALTER TABLE [dbo].[ProjectStatus] ADD  CONSTRAINT [DF_ProjectStatus_EntryDate]  DEFAULT (getdate()) FOR [EntryDate]
GO
ALTER TABLE [dbo].[ProjectStatus] ADD  CONSTRAINT [DF_ProjectStatus_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[ProjectStatus] ADD  CONSTRAINT [DF_ProjectStatus_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[Properties] ADD  CONSTRAINT [DF_Properties_EntryDate]  DEFAULT (getdate()) FOR [EntryDate]
GO
ALTER TABLE [dbo].[PropertyFloorTypes] ADD  CONSTRAINT [DF_PropertyFloorTypes_EntryDate]  DEFAULT (getdate()) FOR [EntryDate]
GO
ALTER TABLE [dbo].[PropertyPictures] ADD  CONSTRAINT [DF_PropertyPictures_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[PropertyPictures] ADD  CONSTRAINT [DF_PropertyPictures_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[PropertyPurpose] ADD  CONSTRAINT [DF_PropertyPurpose_EntryDate]  DEFAULT (getdate()) FOR [EntryDate]
GO
ALTER TABLE [dbo].[PropertyRequests] ADD  CONSTRAINT [DF_PropertyRequests_EntryDate]  DEFAULT (getdate()) FOR [EntryDate]
GO
ALTER TABLE [dbo].[PropertyRequests.FollowUp] ADD  CONSTRAINT [DF_Requests.FollowUp_EntryDate]  DEFAULT (getdate()) FOR [EntryDate]
GO
ALTER TABLE [dbo].[PropertyRequests.FollowUp] ADD  CONSTRAINT [DF_Requests.FollowUp_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[PropertyTypes] ADD  CONSTRAINT [DF_PropertyTypes_EntryDate]  DEFAULT (getdate()) FOR [EntryDate]
GO
ALTER TABLE [dbo].[RequestStatus] ADD  CONSTRAINT [DF_RequestStatus_EntryDate]  DEFAULT (getdate()) FOR [EntryDate]
GO
ALTER TABLE [dbo].[Transactions] ADD  CONSTRAINT [DF_Transactions_EntryDate_1]  DEFAULT (getdate()) FOR [EntryDate]
GO
ALTER TABLE [dbo].[UserPermission] ADD  CONSTRAINT [DF_UserPermission_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_EntryDate]  DEFAULT (getdate()) FOR [EntryDate]
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
