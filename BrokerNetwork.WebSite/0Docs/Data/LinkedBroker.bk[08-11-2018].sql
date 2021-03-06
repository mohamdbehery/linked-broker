USE [master]
GO
/****** Object:  Database [BrokerNetwork]    Script Date: 11/8/2018 3:11:44 AM ******/
CREATE DATABASE [BrokerNetwork]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BrokerNetwork', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\BrokerNetwork.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'BrokerNetwork_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\BrokerNetwork_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [BrokerNetwork] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BrokerNetwork].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BrokerNetwork] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BrokerNetwork] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BrokerNetwork] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BrokerNetwork] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BrokerNetwork] SET ARITHABORT OFF 
GO
ALTER DATABASE [BrokerNetwork] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [BrokerNetwork] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BrokerNetwork] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BrokerNetwork] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BrokerNetwork] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BrokerNetwork] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BrokerNetwork] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BrokerNetwork] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BrokerNetwork] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BrokerNetwork] SET  DISABLE_BROKER 
GO
ALTER DATABASE [BrokerNetwork] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BrokerNetwork] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BrokerNetwork] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BrokerNetwork] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BrokerNetwork] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BrokerNetwork] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [BrokerNetwork] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BrokerNetwork] SET RECOVERY FULL 
GO
ALTER DATABASE [BrokerNetwork] SET  MULTI_USER 
GO
ALTER DATABASE [BrokerNetwork] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BrokerNetwork] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BrokerNetwork] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BrokerNetwork] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [BrokerNetwork] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'BrokerNetwork', N'ON'
GO
USE [BrokerNetwork]
GO
/****** Object:  Table [dbo].[Companies]    Script Date: 11/8/2018 3:11:44 AM ******/
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
 CONSTRAINT [PK_Companies] PRIMARY KEY CLUSTERED 
(
	[CompanyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CompanyBrokers]    Script Date: 11/8/2018 3:11:44 AM ******/
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
/****** Object:  Table [dbo].[CompanyTypes]    Script Date: 11/8/2018 3:11:44 AM ******/
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
/****** Object:  Table [dbo].[CompanyVerificationTypes]    Script Date: 11/8/2018 3:11:44 AM ******/
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
/****** Object:  Table [dbo].[CusomerPreviews]    Script Date: 11/8/2018 3:11:44 AM ******/
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
/****** Object:  Table [dbo].[Customer.CustomerStatus]    Script Date: 11/8/2018 3:11:44 AM ******/
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
/****** Object:  Table [dbo].[Customers]    Script Date: 11/8/2018 3:11:44 AM ******/
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
/****** Object:  Table [dbo].[CustomerStatus]    Script Date: 11/8/2018 3:11:44 AM ******/
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
/****** Object:  Table [dbo].[Files]    Script Date: 11/8/2018 3:11:44 AM ******/
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
/****** Object:  Table [dbo].[FilesLines]    Script Date: 11/8/2018 3:11:44 AM ******/
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
/****** Object:  Table [dbo].[Locations]    Script Date: 11/8/2018 3:11:44 AM ******/
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
/****** Object:  Table [dbo].[OwnerShipTypes]    Script Date: 11/8/2018 3:11:44 AM ******/
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
/****** Object:  Table [dbo].[Permission.PermissionGroup]    Script Date: 11/8/2018 3:11:44 AM ******/
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
/****** Object:  Table [dbo].[PermissionGroups]    Script Date: 11/8/2018 3:11:44 AM ******/
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
/****** Object:  Table [dbo].[PreviewStatus]    Script Date: 11/8/2018 3:11:44 AM ******/
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
/****** Object:  Table [dbo].[Projects]    Script Date: 11/8/2018 3:11:44 AM ******/
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
	[NoOfUnits] [int] NOT NULL,
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
/****** Object:  Table [dbo].[ProjectStatus]    Script Date: 11/8/2018 3:11:45 AM ******/
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
/****** Object:  Table [dbo].[ProjectTypes]    Script Date: 11/8/2018 3:11:45 AM ******/
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
/****** Object:  Table [dbo].[Properties]    Script Date: 11/8/2018 3:11:45 AM ******/
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
/****** Object:  Table [dbo].[PropertyFloorTypes]    Script Date: 11/8/2018 3:11:45 AM ******/
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
/****** Object:  Table [dbo].[PropertyPictures]    Script Date: 11/8/2018 3:11:45 AM ******/
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
/****** Object:  Table [dbo].[PropertyPurpose]    Script Date: 11/8/2018 3:11:45 AM ******/
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
/****** Object:  Table [dbo].[PropertyRequests]    Script Date: 11/8/2018 3:11:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PropertyRequests](
	[RequestID] [bigint] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](150) NULL,
	[CustomerID] [int] NOT NULL,
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
/****** Object:  Table [dbo].[PropertyRequests.FollowUp]    Script Date: 11/8/2018 3:11:45 AM ******/
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
/****** Object:  Table [dbo].[PropertyTypes]    Script Date: 11/8/2018 3:11:45 AM ******/
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
/****** Object:  Table [dbo].[RequestStatus]    Script Date: 11/8/2018 3:11:45 AM ******/
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
/****** Object:  Table [dbo].[Shared]    Script Date: 11/8/2018 3:11:45 AM ******/
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
/****** Object:  Table [dbo].[SpecialOffers]    Script Date: 11/8/2018 3:11:45 AM ******/
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
/****** Object:  Table [dbo].[Transactions]    Script Date: 11/8/2018 3:11:45 AM ******/
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
/****** Object:  Table [dbo].[User.UserPermission]    Script Date: 11/8/2018 3:11:45 AM ******/
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
/****** Object:  Table [dbo].[UserGroups]    Script Date: 11/8/2018 3:11:45 AM ******/
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
/****** Object:  Table [dbo].[UserPermission]    Script Date: 11/8/2018 3:11:45 AM ******/
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
/****** Object:  Table [dbo].[Users]    Script Date: 11/8/2018 3:11:45 AM ******/
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
/****** Object:  Table [dbo].[VerficationRequests]    Script Date: 11/8/2018 3:11:45 AM ******/
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
/****** Object:  Table [dbo].[VerficationStatus]    Script Date: 11/8/2018 3:11:45 AM ******/
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

INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDesc], [CompanyVerificationTypeID], [Address], [CompanyTypeID], [Email], [Contacts], [ImgPath], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (1, N'شركة العقارات', N'شركة العقارات تأسست عام 1980 ،لديها عدة مشاريع على مستوى الجمهورية ', 2, NULL, 2, NULL, N'01067636963 - 01067636987', N'real-estate-logo-template_1156-724.jpg', 1, CAST(N'2018-04-21T17:37:20.523' AS DateTime), 1, 0)
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDesc], [CompanyVerificationTypeID], [Address], [CompanyTypeID], [Email], [Contacts], [ImgPath], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (2, N'شركة الاختبارات النووية ', N'يييي يي', 2, NULL, 1, NULL, NULL, N'Screenshot_2_1520163147.jpg', 1, CAST(N'2018-06-28T11:25:05.280' AS DateTime), 1, 0)
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDesc], [CompanyVerificationTypeID], [Address], [CompanyTypeID], [Email], [Contacts], [ImgPath], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (3, N'شركة فى رحاب الله', N'قبرك عندنا ، تاريخ فى بناء المقابر ، دافنين كبرات مصر ، شعارنا وحدووووه', 2, NULL, 2, NULL, NULL, N'download.jpeg', 2, CAST(N'2018-08-08T22:29:53.677' AS DateTime), 1, 0)
SET IDENTITY_INSERT [dbo].[Companies] OFF
SET IDENTITY_INSERT [dbo].[CompanyBrokers] ON 

INSERT [dbo].[CompanyBrokers] ([CompanyBrokerID], [CompanyID], [UserID]) VALUES (2, 1, 4)
SET IDENTITY_INSERT [dbo].[CompanyBrokers] OFF
SET IDENTITY_INSERT [dbo].[CompanyTypes] ON 

INSERT [dbo].[CompanyTypes] ([CompanyTypeID], [CompanyTypeTitle]) VALUES (1, N'شركة عقارات')
INSERT [dbo].[CompanyTypes] ([CompanyTypeID], [CompanyTypeTitle]) VALUES (2, N'شركة تسويق عقارى')
INSERT [dbo].[CompanyTypes] ([CompanyTypeID], [CompanyTypeTitle]) VALUES (3, N'الاثنين')
SET IDENTITY_INSERT [dbo].[CompanyTypes] OFF
SET IDENTITY_INSERT [dbo].[CompanyVerificationTypes] ON 

INSERT [dbo].[CompanyVerificationTypes] ([CompanyVerificationTypeID], [VerificationTitle], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (2, N'ممارسة حرة', 1, CAST(N'2018-04-28T22:45:26.227' AS DateTime), 1, 0)
INSERT [dbo].[CompanyVerificationTypes] ([CompanyVerificationTypeID], [VerificationTitle], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (4, N'منظمة رسمية', 1, CAST(N'2018-04-28T22:46:12.433' AS DateTime), 1, 0)
INSERT [dbo].[CompanyVerificationTypes] ([CompanyVerificationTypeID], [VerificationTitle], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (5, N'منظمة رسمية محترفة', 1, CAST(N'2018-04-28T22:46:40.660' AS DateTime), 1, 0)
SET IDENTITY_INSERT [dbo].[CompanyVerificationTypes] OFF
SET IDENTITY_INSERT [dbo].[Customers] ON 

INSERT [dbo].[Customers] ([CustomerID], [CompanyID], [CustomerStatusID], [CustomerName], [Notes], [CreatedDate], [ByUserID], [Comments], [EntryDate], [IsActive], [IsDeleted]) VALUES (10002, NULL, 1, N'محمد أسامة', N'سسس', CAST(N'2018-05-03T00:45:04.843' AS DateTime), 1, N'سسس', CAST(N'2018-05-03T00:45:04.843' AS DateTime), 1, 1)
INSERT [dbo].[Customers] ([CustomerID], [CompanyID], [CustomerStatusID], [CustomerName], [Notes], [CreatedDate], [ByUserID], [Comments], [EntryDate], [IsActive], [IsDeleted]) VALUES (20002, NULL, 1, N'سبسيب', N'رريس', CAST(N'2018-05-07T01:01:50.477' AS DateTime), 1, NULL, CAST(N'2018-05-07T01:01:50.477' AS DateTime), 0, 0)
SET IDENTITY_INSERT [dbo].[Customers] OFF
SET IDENTITY_INSERT [dbo].[CustomerStatus] ON 

INSERT [dbo].[CustomerStatus] ([CustomerStatusID], [CustomerStatusTitle], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (1, N'حالى', 1, CAST(N'2018-03-10T16:37:26.447' AS DateTime), 1, 0)
INSERT [dbo].[CustomerStatus] ([CustomerStatusID], [CustomerStatusTitle], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (2, N'سابق', 1, CAST(N'2018-03-10T16:37:56.287' AS DateTime), 1, 0)
INSERT [dbo].[CustomerStatus] ([CustomerStatusID], [CustomerStatusTitle], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (3, N'مهم', 1, CAST(N'2018-03-10T16:38:09.710' AS DateTime), 1, 0)
INSERT [dbo].[CustomerStatus] ([CustomerStatusID], [CustomerStatusTitle], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (4, N'مؤقت', 1, CAST(N'2018-03-10T16:38:49.290' AS DateTime), 1, 0)
SET IDENTITY_INSERT [dbo].[CustomerStatus] OFF
SET IDENTITY_INSERT [dbo].[Files] ON 

INSERT [dbo].[Files] ([FileID], [ParentID], [ParentType], [FileName], [FileType], [OrginalFileName], [IsActive], [IsDeleted], [CreatedDate], [LastUpdated]) VALUES (4, 4, N'Projects', N'Misr.Protection.png', NULL, N'Misr.Protection.png', 1, 0, CAST(N'2018-06-28T12:43:44.090' AS DateTime), CAST(N'2018-06-28T12:43:44.090' AS DateTime))
INSERT [dbo].[Files] ([FileID], [ParentID], [ParentType], [FileName], [FileType], [OrginalFileName], [IsActive], [IsDeleted], [CreatedDate], [LastUpdated]) VALUES (5, 4, N'Projects', N'Screenshot_2_1520163147.jpg', NULL, N'Screenshot_2_1520163147.jpg', 1, 0, CAST(N'2018-06-28T12:43:44.120' AS DateTime), CAST(N'2018-06-28T12:43:44.120' AS DateTime))
INSERT [dbo].[Files] ([FileID], [ParentID], [ParentType], [FileName], [FileType], [OrginalFileName], [IsActive], [IsDeleted], [CreatedDate], [LastUpdated]) VALUES (7, 3, N'Properties', N'74917f9f-56dd-4f5a-a8c4-339c04e566d9.jpg', NULL, N'74917f9f-56dd-4f5a-a8c4-339c04e566d9.jpg', 1, 0, CAST(N'2018-07-02T16:25:31.867' AS DateTime), CAST(N'2018-07-02T16:25:31.867' AS DateTime))
INSERT [dbo].[Files] ([FileID], [ParentID], [ParentType], [FileName], [FileType], [OrginalFileName], [IsActive], [IsDeleted], [CreatedDate], [LastUpdated]) VALUES (8, 1, N'Projects', N'89b8f5ce-9bde-4057-ab6d-cbe85a4c4db5.jpg', NULL, N'89b8f5ce-9bde-4057-ab6d-cbe85a4c4db5.jpg', 1, 0, CAST(N'2018-07-02T18:00:55.833' AS DateTime), CAST(N'2018-07-02T18:00:55.833' AS DateTime))
INSERT [dbo].[Files] ([FileID], [ParentID], [ParentType], [FileName], [FileType], [OrginalFileName], [IsActive], [IsDeleted], [CreatedDate], [LastUpdated]) VALUES (9, 1, N'Projects', N'49320a5d-9477-4b02-9e6f-fb7a04f7267d.png', NULL, N'49320a5d-9477-4b02-9e6f-fb7a04f7267d.png', 1, 0, CAST(N'2018-07-02T18:00:55.863' AS DateTime), CAST(N'2018-07-02T18:00:55.863' AS DateTime))
INSERT [dbo].[Files] ([FileID], [ParentID], [ParentType], [FileName], [FileType], [OrginalFileName], [IsActive], [IsDeleted], [CreatedDate], [LastUpdated]) VALUES (10, 2, N'Properties', N'784a7a58-f37a-4762-a785-950de517c763.jpg', NULL, N'784a7a58-f37a-4762-a785-950de517c763.jpg', 1, 0, CAST(N'2018-08-08T19:32:43.767' AS DateTime), CAST(N'2018-08-08T19:32:43.767' AS DateTime))
INSERT [dbo].[Files] ([FileID], [ParentID], [ParentType], [FileName], [FileType], [OrginalFileName], [IsActive], [IsDeleted], [CreatedDate], [LastUpdated]) VALUES (11, 4, N'Properties', N'6f071ddb-6352-4e96-9890-b45e80149367.jpg', NULL, N'6f071ddb-6352-4e96-9890-b45e80149367.jpg', 1, 0, CAST(N'2018-08-08T19:33:00.627' AS DateTime), CAST(N'2018-08-08T19:33:00.627' AS DateTime))
INSERT [dbo].[Files] ([FileID], [ParentID], [ParentType], [FileName], [FileType], [OrginalFileName], [IsActive], [IsDeleted], [CreatedDate], [LastUpdated]) VALUES (12, 5, N'Projects', N'64c76541-3887-492c-b50c-e385970cea71.jpg', NULL, N'64c76541-3887-492c-b50c-e385970cea71.jpg', 1, 0, CAST(N'2018-08-08T22:41:06.347' AS DateTime), CAST(N'2018-08-08T22:41:06.347' AS DateTime))
INSERT [dbo].[Files] ([FileID], [ParentID], [ParentType], [FileName], [FileType], [OrginalFileName], [IsActive], [IsDeleted], [CreatedDate], [LastUpdated]) VALUES (13, 5, N'Projects', N'73adc967-101c-47d3-812e-fc6c743adf86.jpeg', NULL, N'73adc967-101c-47d3-812e-fc6c743adf86.jpeg', 1, 0, CAST(N'2018-08-08T22:50:41.397' AS DateTime), CAST(N'2018-08-08T22:50:41.397' AS DateTime))
INSERT [dbo].[Files] ([FileID], [ParentID], [ParentType], [FileName], [FileType], [OrginalFileName], [IsActive], [IsDeleted], [CreatedDate], [LastUpdated]) VALUES (14, 5, N'Properties', N'804f48b6-78f9-4be2-9db6-cceb6b32f912.jpg', NULL, N'804f48b6-78f9-4be2-9db6-cceb6b32f912.jpg', 1, 0, CAST(N'2018-08-08T23:50:22.843' AS DateTime), CAST(N'2018-08-08T23:50:22.843' AS DateTime))
INSERT [dbo].[Files] ([FileID], [ParentID], [ParentType], [FileName], [FileType], [OrginalFileName], [IsActive], [IsDeleted], [CreatedDate], [LastUpdated]) VALUES (15, 6, N'Properties', N'7eed1493-6601-49be-bbf5-9fbb5aa9277f.jpg', NULL, N'7eed1493-6601-49be-bbf5-9fbb5aa9277f.jpg', 1, 0, CAST(N'2018-08-09T01:06:54.647' AS DateTime), CAST(N'2018-08-09T01:06:54.647' AS DateTime))
INSERT [dbo].[Files] ([FileID], [ParentID], [ParentType], [FileName], [FileType], [OrginalFileName], [IsActive], [IsDeleted], [CreatedDate], [LastUpdated]) VALUES (16, 1, N'Verfication', N'60331ef7-72df-4062-b6f1-44107b257b67.jpg', NULL, N'60331ef7-72df-4062-b6f1-44107b257b67.jpg', 1, 0, CAST(N'2018-08-29T22:13:59.587' AS DateTime), CAST(N'2018-08-29T22:13:59.590' AS DateTime))
INSERT [dbo].[Files] ([FileID], [ParentID], [ParentType], [FileName], [FileType], [OrginalFileName], [IsActive], [IsDeleted], [CreatedDate], [LastUpdated]) VALUES (18, 0, N'Verfication', N'4d12582b-2687-489a-b055-0646811744b7.jpg', NULL, N'4d12582b-2687-489a-b055-0646811744b7.jpg', 1, 0, CAST(N'2018-08-29T22:28:45.463' AS DateTime), CAST(N'2018-08-29T22:28:45.463' AS DateTime))
INSERT [dbo].[Files] ([FileID], [ParentID], [ParentType], [FileName], [FileType], [OrginalFileName], [IsActive], [IsDeleted], [CreatedDate], [LastUpdated]) VALUES (19, 0, N'Verfication', N'66679cd3-4de7-49ee-95d1-8ae7263263da.jpg', NULL, N'66679cd3-4de7-49ee-95d1-8ae7263263da.jpg', 1, 0, CAST(N'2018-08-29T22:33:57.097' AS DateTime), CAST(N'2018-08-29T22:33:57.097' AS DateTime))
INSERT [dbo].[Files] ([FileID], [ParentID], [ParentType], [FileName], [FileType], [OrginalFileName], [IsActive], [IsDeleted], [CreatedDate], [LastUpdated]) VALUES (20, 0, N'Verfication', N'b420044a-6bcf-43f7-b108-8ec8925c3a4a.jpg', NULL, N'b420044a-6bcf-43f7-b108-8ec8925c3a4a.jpg', 1, 0, CAST(N'2018-08-29T22:35:16.767' AS DateTime), CAST(N'2018-08-29T22:35:16.767' AS DateTime))
INSERT [dbo].[Files] ([FileID], [ParentID], [ParentType], [FileName], [FileType], [OrginalFileName], [IsActive], [IsDeleted], [CreatedDate], [LastUpdated]) VALUES (21, 1, N'Verfication', N'2647defe-3b59-4ddc-939b-e68080201252.jpg', NULL, N'2647defe-3b59-4ddc-939b-e68080201252.jpg', 1, 0, CAST(N'2018-08-29T22:39:23.167' AS DateTime), CAST(N'2018-08-29T22:39:23.167' AS DateTime))
INSERT [dbo].[Files] ([FileID], [ParentID], [ParentType], [FileName], [FileType], [OrginalFileName], [IsActive], [IsDeleted], [CreatedDate], [LastUpdated]) VALUES (22, 7, N'Properties', N'7d515ae6-2c40-4cc9-b98d-21e41b458ee5.png', NULL, N'7d515ae6-2c40-4cc9-b98d-21e41b458ee5.png', 1, 0, CAST(N'2018-11-06T21:19:37.313' AS DateTime), CAST(N'2018-11-06T21:19:37.313' AS DateTime))
INSERT [dbo].[Files] ([FileID], [ParentID], [ParentType], [FileName], [FileType], [OrginalFileName], [IsActive], [IsDeleted], [CreatedDate], [LastUpdated]) VALUES (23, 1, N'Verfication', N'bfa8026c-f324-490c-bc84-ad44336404dd.png', NULL, N'bfa8026c-f324-490c-bc84-ad44336404dd.png', 1, 0, CAST(N'2018-11-08T00:34:09.930' AS DateTime), CAST(N'2018-11-08T00:34:09.930' AS DateTime))
SET IDENTITY_INSERT [dbo].[Files] OFF
SET IDENTITY_INSERT [dbo].[Locations] ON 

INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (3, NULL, N'مصر', 1, CAST(N'2018-04-21T16:27:53.773' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (4, 3, N'القاهرة', 1, CAST(N'2018-04-21T16:28:43.890' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (5, 4, N'التجمع - البنفسج 1', 1, CAST(N'2018-11-07T00:27:53.120' AS DateTime), 1, 0)
SET IDENTITY_INSERT [dbo].[Locations] OFF
SET IDENTITY_INSERT [dbo].[OwnerShipTypes] ON 

INSERT [dbo].[OwnerShipTypes] ([OwnerShipTypeID], [OwnerShipTitle], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (1005, N'مالك', 1, CAST(N'2018-04-17T21:03:51.443' AS DateTime), 1, 1)
INSERT [dbo].[OwnerShipTypes] ([OwnerShipTypeID], [OwnerShipTitle], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (2006, N'وسيط', 1, CAST(N'2018-04-15T01:03:15.393' AS DateTime), 1, 0)
SET IDENTITY_INSERT [dbo].[OwnerShipTypes] OFF
SET IDENTITY_INSERT [dbo].[Permission.PermissionGroup] ON 

INSERT [dbo].[Permission.PermissionGroup] ([ID], [PermissionGroupID], [UserPermissionID], [ByUserID]) VALUES (1, 2, 2, 1)
INSERT [dbo].[Permission.PermissionGroup] ([ID], [PermissionGroupID], [UserPermissionID], [ByUserID]) VALUES (2, 2, 3, 1)
INSERT [dbo].[Permission.PermissionGroup] ([ID], [PermissionGroupID], [UserPermissionID], [ByUserID]) VALUES (3, 2, 5, 1)
SET IDENTITY_INSERT [dbo].[Permission.PermissionGroup] OFF
SET IDENTITY_INSERT [dbo].[PermissionGroups] ON 

INSERT [dbo].[PermissionGroups] ([PermissionGroupID], [GroupName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (2, N'Company Member', 1, CAST(N'2018-04-22T01:07:24.873' AS DateTime), 1, 0)
SET IDENTITY_INSERT [dbo].[PermissionGroups] OFF
SET IDENTITY_INSERT [dbo].[Projects] ON 

INSERT [dbo].[Projects] ([CompanyID], [ProjectID], [ProjectTypeID], [ProjectName], [LocationID], [AddressDetails], [NoOfUnits], [ProjectStatusID], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (1, 1, 1, N'أبراج التيسير', 4, N'شارع 77 ', 125, 2, 1, CAST(N'2018-04-28T16:14:04.587' AS DateTime), 1, 0)
INSERT [dbo].[Projects] ([CompanyID], [ProjectID], [ProjectTypeID], [ProjectName], [LocationID], [AddressDetails], [NoOfUnits], [ProjectStatusID], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (2, 4, 1, N'sdfdsf', 4, N'dsfsdfsdf', 1004, 2, 1, CAST(N'2018-06-28T12:34:13.737' AS DateTime), 1, 0)
INSERT [dbo].[Projects] ([CompanyID], [ProjectID], [ProjectTypeID], [ProjectName], [LocationID], [AddressDetails], [NoOfUnits], [ProjectStatusID], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (3, 5, 1, N'مقابر السيدة', 4, N'السيدة زينب', 10, 2, 2, CAST(N'2018-08-08T22:41:06.293' AS DateTime), 1, 0)
SET IDENTITY_INSERT [dbo].[Projects] OFF
SET IDENTITY_INSERT [dbo].[ProjectStatus] ON 

INSERT [dbo].[ProjectStatus] ([ProjectStatusID], [StatusTitle], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (1, N'كامل التشطيب', 1, CAST(N'2018-04-28T15:34:29.713' AS DateTime), 1, 0)
INSERT [dbo].[ProjectStatus] ([ProjectStatusID], [StatusTitle], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (2, N'تحت التشطيب', 1, CAST(N'2018-04-28T15:34:40.720' AS DateTime), 1, 0)
SET IDENTITY_INSERT [dbo].[ProjectStatus] OFF
SET IDENTITY_INSERT [dbo].[ProjectTypes] ON 

INSERT [dbo].[ProjectTypes] ([ProjectTypeID], [ProjectTypeName], [IsActive], [IsDeleted]) VALUES (1, N'كومباوند', 1, 0)
INSERT [dbo].[ProjectTypes] ([ProjectTypeID], [ProjectTypeName], [IsActive], [IsDeleted]) VALUES (2, N'منفصل', 1, 0)
SET IDENTITY_INSERT [dbo].[ProjectTypes] OFF
SET IDENTITY_INSERT [dbo].[Properties] ON 

INSERT [dbo].[Properties] ([PropertyID], [Title], [CustomerID], [ByUserID], [LocationID], [AddressDetails], [ProjectID], [IsUnit], [Price], [CanInstallment], [NoOfYears], [DownPayment], [FloorNum], [PropertyFloorTypeID], [NoOfProperties], [Area], [OwnerShipTypeID], [PropertyTypeID], [PropertyPurposeID], [HasElevator], [HasGarage], [AllowVisitors], [Commission], [NumberOfRooms], [NumberOfBathrooms], [ReadyDate], [LastUpdated], [SharedID], [Comments], [EntryDate], [IsActive], [IsDeleted]) VALUES (2, N'شقة النعناع', 0, 1, 4, N'شارع كلومبيا - ميدان الحجاز - مصر الجديدة', 4, 1, CAST(10000 AS Decimal(9, 0)), 1, 1, CAST(1500 AS Decimal(9, 0)), 12, 1, 10, 10, 1005, 1, 4, 1, 1, 1, NULL, 8, 10, CAST(N'2018-07-24' AS Date), CAST(N'2018-08-08T19:32:43.730' AS DateTime), N'All', N'سسس', CAST(N'2018-08-08T19:32:43.730' AS DateTime), 1, 0)
INSERT [dbo].[Properties] ([PropertyID], [Title], [CustomerID], [ByUserID], [LocationID], [AddressDetails], [ProjectID], [IsUnit], [Price], [CanInstallment], [NoOfYears], [DownPayment], [FloorNum], [PropertyFloorTypeID], [NoOfProperties], [Area], [OwnerShipTypeID], [PropertyTypeID], [PropertyPurposeID], [HasElevator], [HasGarage], [AllowVisitors], [Commission], [NumberOfRooms], [NumberOfBathrooms], [ReadyDate], [LastUpdated], [SharedID], [Comments], [EntryDate], [IsActive], [IsDeleted]) VALUES (3, N'وحدة من لا وحدة له', 0, 2, 4, N'الزمالك', NULL, 0, CAST(10000 AS Decimal(9, 0)), 1, 3, CAST(300000 AS Decimal(9, 0)), 10, 1, 1, 120, 2006, 1, 4, 0, 1, 1, NULL, 3, 2, CAST(N'2018-07-24' AS Date), CAST(N'2018-08-08T22:37:01.723' AS DateTime), N'All', N'2111', CAST(N'2018-08-08T22:37:01.723' AS DateTime), 1, 0)
INSERT [dbo].[Properties] ([PropertyID], [Title], [CustomerID], [ByUserID], [LocationID], [AddressDetails], [ProjectID], [IsUnit], [Price], [CanInstallment], [NoOfYears], [DownPayment], [FloorNum], [PropertyFloorTypeID], [NoOfProperties], [Area], [OwnerShipTypeID], [PropertyTypeID], [PropertyPurposeID], [HasElevator], [HasGarage], [AllowVisitors], [Commission], [NumberOfRooms], [NumberOfBathrooms], [ReadyDate], [LastUpdated], [SharedID], [Comments], [EntryDate], [IsActive], [IsDeleted]) VALUES (4, N'شقة الى نفسك فيه ', 0, 1, 4, N'زاج', 1, 0, CAST(120000 AS Decimal(9, 0)), 1, 3, NULL, 12, 1, 125, 1255, 1005, 1, 4, 0, 0, 1, NULL, 5, 2, CAST(N'2018-08-08' AS Date), CAST(N'2018-08-08T19:33:00.623' AS DateTime), N'All', NULL, CAST(N'2018-08-08T19:33:00.623' AS DateTime), 1, 0)
INSERT [dbo].[Properties] ([PropertyID], [Title], [CustomerID], [ByUserID], [LocationID], [AddressDetails], [ProjectID], [IsUnit], [Price], [CanInstallment], [NoOfYears], [DownPayment], [FloorNum], [PropertyFloorTypeID], [NoOfProperties], [Area], [OwnerShipTypeID], [PropertyTypeID], [PropertyPurposeID], [HasElevator], [HasGarage], [AllowVisitors], [Commission], [NumberOfRooms], [NumberOfBathrooms], [ReadyDate], [LastUpdated], [SharedID], [Comments], [EntryDate], [IsActive], [IsDeleted]) VALUES (5, N'مقبرة بحرى', 0, 2, 4, N'مقابر السيدة زينب', 5, 1, CAST(100000 AS Decimal(9, 0)), 1, 100, NULL, 10, 1, 10, 20, 1005, 1, 4, 0, 0, 1, NULL, 2, 10, CAST(N'2018-07-24' AS Date), CAST(N'2018-08-08T23:50:22.837' AS DateTime), N'All', NULL, CAST(N'2018-08-08T23:50:22.837' AS DateTime), 1, 0)
INSERT [dbo].[Properties] ([PropertyID], [Title], [CustomerID], [ByUserID], [LocationID], [AddressDetails], [ProjectID], [IsUnit], [Price], [CanInstallment], [NoOfYears], [DownPayment], [FloorNum], [PropertyFloorTypeID], [NoOfProperties], [Area], [OwnerShipTypeID], [PropertyTypeID], [PropertyPurposeID], [HasElevator], [HasGarage], [AllowVisitors], [Commission], [NumberOfRooms], [NumberOfBathrooms], [ReadyDate], [LastUpdated], [SharedID], [Comments], [EntryDate], [IsActive], [IsDeleted]) VALUES (6, N'وحدة من غير شروع', 0, 4, 4, N'الزمالك', NULL, 1, CAST(1000000 AS Decimal(9, 0)), 1, 3, CAST(5000 AS Decimal(9, 0)), 10, 1, 1000, 100, 1005, 1, 4, 0, 1, 1, NULL, 10, 2, CAST(N'2018-07-24' AS Date), CAST(N'2018-08-09T01:06:54.370' AS DateTime), N'All', NULL, CAST(N'2018-08-09T01:06:54.370' AS DateTime), 1, 0)
INSERT [dbo].[Properties] ([PropertyID], [Title], [CustomerID], [ByUserID], [LocationID], [AddressDetails], [ProjectID], [IsUnit], [Price], [CanInstallment], [NoOfYears], [DownPayment], [FloorNum], [PropertyFloorTypeID], [NoOfProperties], [Area], [OwnerShipTypeID], [PropertyTypeID], [PropertyPurposeID], [HasElevator], [HasGarage], [AllowVisitors], [Commission], [NumberOfRooms], [NumberOfBathrooms], [ReadyDate], [LastUpdated], [SharedID], [Comments], [EntryDate], [IsActive], [IsDeleted]) VALUES (7, N'jjjjjj', 0, 1, 4, N'elsalam zagazig', 4, 0, CAST(1000000 AS Decimal(9, 0)), 1, NULL, CAST(100000 AS Decimal(9, 0)), 0, 1, 0, 500, 1005, 1, 4, 1, 0, 1, 0.5, 46, 3, CAST(N'2018-11-07' AS Date), CAST(N'2018-11-06T21:19:36.210' AS DateTime), N'All', NULL, CAST(N'2018-11-06T21:19:36.210' AS DateTime), 1, 0)
SET IDENTITY_INSERT [dbo].[Properties] OFF
SET IDENTITY_INSERT [dbo].[PropertyFloorTypes] ON 

INSERT [dbo].[PropertyFloorTypes] ([PropertyFloorTypeID], [FloorTypeTitle], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (1, N'الطابق الارضى سيب', 1, CAST(N'2018-04-17T21:40:55.690' AS DateTime), 1, 1)
SET IDENTITY_INSERT [dbo].[PropertyFloorTypes] OFF
SET IDENTITY_INSERT [dbo].[PropertyPurpose] ON 

INSERT [dbo].[PropertyPurpose] ([PropertyPurposeID], [PropPurposeTitle], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (4, N'سكنى', 1, CAST(N'2018-06-12T01:07:18.893' AS DateTime), 1, 0)
SET IDENTITY_INSERT [dbo].[PropertyPurpose] OFF
SET IDENTITY_INSERT [dbo].[PropertyRequests] ON 

INSERT [dbo].[PropertyRequests] ([RequestID], [Title], [CustomerID], [LocationIDs], [AddressDetails], [MinPrice], [MaxPrice], [CanInstallment], [NoOfYears], [PropertyFloorTypeID], [MinArea], [MaxArea], [OwnerShipTypeID], [PropertyTypeID], [PropertyPurposeID], [Comments], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (1, NULL, 0, 4, N'مصر الجديدة', CAST(1000 AS Decimal(9, 0)), CAST(122222 AS Decimal(9, 0)), 1, 3, 1, 100, 1200, 1005, 1, 4, NULL, 1, CAST(N'2018-08-07T18:46:45.763' AS DateTime), 1, 0)
INSERT [dbo].[PropertyRequests] ([RequestID], [Title], [CustomerID], [LocationIDs], [AddressDetails], [MinPrice], [MaxPrice], [CanInstallment], [NoOfYears], [PropertyFloorTypeID], [MinArea], [MaxArea], [OwnerShipTypeID], [PropertyTypeID], [PropertyPurposeID], [Comments], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (2, NULL, 0, 4, N'الرحاب', CAST(200000 AS Decimal(9, 0)), CAST(1900000 AS Decimal(9, 0)), 1, 3, 1, 100, 1000, 2006, 1, 4, N'يييي', 2, CAST(N'2018-08-09T00:34:59.910' AS DateTime), 1, 0)
SET IDENTITY_INSERT [dbo].[PropertyRequests] OFF
SET IDENTITY_INSERT [dbo].[PropertyTypes] ON 

INSERT [dbo].[PropertyTypes] ([PropertyTypeID], [PropTypeTitle], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (1, N'ييي', 1, CAST(N'2018-06-12T01:09:20.310' AS DateTime), 1, 0)
SET IDENTITY_INSERT [dbo].[PropertyTypes] OFF
INSERT [dbo].[Shared] ([ShareID], [ShareTitle]) VALUES (N'All', N'كل السماسرة')
INSERT [dbo].[Shared] ([ShareID], [ShareTitle]) VALUES (N'OnlyMe', N'معى فقط')
INSERT [dbo].[Shared] ([ShareID], [ShareTitle]) VALUES (N'VerifiedBroker', N'سماسرة موثقين')
SET IDENTITY_INSERT [dbo].[SpecialOffers] ON 

INSERT [dbo].[SpecialOffers] ([OfferID], [OfferTitle], [OfferDesc], [EntryDate], [ImgPath], [IsActive], [IsDeleted], [ByUserID], [SortOrder]) VALUES (1, N'عرض جديد اشترى وحدتك بدون مقدم', N'يييي', CAST(N'2018-11-07T18:19:54.660' AS DateTime), N'AlbumArt_{B5020207-474E-4720-4833-E61FCB3BB900}_Large.jpg', 1, 0, 1, NULL)
SET IDENTITY_INSERT [dbo].[SpecialOffers] OFF
SET IDENTITY_INSERT [dbo].[User.UserPermission] ON 

INSERT [dbo].[User.UserPermission] ([ID], [UserID], [UserPermissionID], [ByUserID]) VALUES (1, 3, 2, 0)
INSERT [dbo].[User.UserPermission] ([ID], [UserID], [UserPermissionID], [ByUserID]) VALUES (2, 3, 3, 0)
INSERT [dbo].[User.UserPermission] ([ID], [UserID], [UserPermissionID], [ByUserID]) VALUES (3, 3, 5, 0)
SET IDENTITY_INSERT [dbo].[User.UserPermission] OFF
INSERT [dbo].[UserGroups] ([UserGroupName], [UserGroupDesc]) VALUES (N'Admin', NULL)
INSERT [dbo].[UserGroups] ([UserGroupName], [UserGroupDesc]) VALUES (N'SuperAdmin', NULL)
INSERT [dbo].[UserGroups] ([UserGroupName], [UserGroupDesc]) VALUES (N'User', NULL)
SET IDENTITY_INSERT [dbo].[UserPermission] ON 

INSERT [dbo].[UserPermission] ([UserPermissionID], [PermissionTitle], [ByUserID], [IsDeleted]) VALUES (2, N'اضافة مستخدم', 1, 0)
INSERT [dbo].[UserPermission] ([UserPermissionID], [PermissionTitle], [ByUserID], [IsDeleted]) VALUES (3, N'ادارة المعاينات', 1, 0)
INSERT [dbo].[UserPermission] ([UserPermissionID], [PermissionTitle], [ByUserID], [IsDeleted]) VALUES (5, N'اضافة عملية بيع/شراء', 1, 0)
SET IDENTITY_INSERT [dbo].[UserPermission] OFF
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserID], [CompanyID], [UserGroupName], [IsVerfied], [FullName], [Email], [Mobile], [UserPassword], [FavouriteLocationIDs], [Notes], [ProfileImgPath], [IsConfirmed], [LastLogin], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (1, NULL, N'Admin', 0, N'صبح صبح ياعم الحاج', N'admin@brokernetwork.com', N'01007330161', N'123456', NULL, NULL, N'Mohamed Behery.jpg', 1, NULL, NULL, CAST(N'2018-03-11T08:49:22.800' AS DateTime), 1, 0)
INSERT [dbo].[Users] ([UserID], [CompanyID], [UserGroupName], [IsVerfied], [FullName], [Email], [Mobile], [UserPassword], [FavouriteLocationIDs], [Notes], [ProfileImgPath], [IsConfirmed], [LastLogin], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (2, NULL, N'User', NULL, N'محمد بحيرى', N'mohamed.behery@ebseg.com', N'01007330168', N'Omar@123', NULL, N'any thing', NULL, 1, NULL, NULL, CAST(N'2018-04-21T17:19:05.827' AS DateTime), 1, 0)
INSERT [dbo].[Users] ([UserID], [CompanyID], [UserGroupName], [IsVerfied], [FullName], [Email], [Mobile], [UserPassword], [FavouriteLocationIDs], [Notes], [ProfileImgPath], [IsConfirmed], [LastLogin], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (3, 1, N'User', NULL, N'عمر السيد حلمى', N'omar@test.com', N'01024567241', N'123456', NULL, NULL, NULL, 1, NULL, 1, CAST(N'2018-04-22T01:21:46.720' AS DateTime), 1, 0)
INSERT [dbo].[Users] ([UserID], [CompanyID], [UserGroupName], [IsVerfied], [FullName], [Email], [Mobile], [UserPassword], [FavouriteLocationIDs], [Notes], [ProfileImgPath], [IsConfirmed], [LastLogin], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (4, NULL, N'User', NULL, N'محمد أسامة محمد خليل', N'medo@yahoo.com', N'01067636963', N'123456', NULL, N'Go To Fucking Hell', N'be3a7af3-aa5b-4e3e-99c0-5a9f0f97f60f.jpg', 1, NULL, NULL, CAST(N'2018-08-09T00:55:19.820' AS DateTime), 1, 0)
SET IDENTITY_INSERT [dbo].[Users] OFF
SET IDENTITY_INSERT [dbo].[VerficationRequests] ON 

INSERT [dbo].[VerficationRequests] ([VerficationID], [UserID], [CompanyID], [RequestContent], [VerfiedStatusID], [AdminMessage], [LastUpdated], [EntryDate]) VALUES (1, 1, 2, N'سيييdfsd', 2, NULL, CAST(N'2018-11-07T23:17:37.547' AS DateTime), CAST(N'2018-08-29T22:51:32.470' AS DateTime))
INSERT [dbo].[VerficationRequests] ([VerficationID], [UserID], [CompanyID], [RequestContent], [VerfiedStatusID], [AdminMessage], [LastUpdated], [EntryDate]) VALUES (2, 1, 1, N'كوكو', 1, NULL, CAST(N'2018-11-08T00:34:09.720' AS DateTime), CAST(N'2018-11-08T00:34:09.720' AS DateTime))
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
ALTER DATABASE [BrokerNetwork] SET  READ_WRITE 
GO
