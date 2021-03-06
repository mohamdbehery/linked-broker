USE [master]
GO
/****** Object:  Database [BrokerNetwork]    Script Date: 8/7/2018 1:04:02 PM ******/
CREATE DATABASE [BrokerNetwork]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BrokerNetwork', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\BrokerNetwork.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'BrokerNetwork_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\BrokerNetwork_log.ldf' , SIZE = 13632KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
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
/****** Object:  Table [dbo].[Companies]    Script Date: 8/7/2018 1:04:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Companies](
	[CompanyID] [int] IDENTITY(1,1) NOT NULL,
	[CompanyName] [nvarchar](200) NOT NULL,
	[CompanyDesc] [nvarchar](max) NOT NULL,
	[CompanyVerificationTypeID] [int] NOT NULL,
	[ImgPath] [nvarchar](250) NULL,
	[ByUserID] [bigint] NOT NULL,
	[EntryDate] [datetime] NOT NULL CONSTRAINT [DF_Companies_EntryDate]  DEFAULT (getdate()),
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Companies] PRIMARY KEY CLUSTERED 
(
	[CompanyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CompanyVerificationTypes]    Script Date: 8/7/2018 1:04:02 PM ******/
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
/****** Object:  Table [dbo].[CusomerPreviews]    Script Date: 8/7/2018 1:04:02 PM ******/
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
/****** Object:  Table [dbo].[Customer.CustomerStatus]    Script Date: 8/7/2018 1:04:02 PM ******/
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
/****** Object:  Table [dbo].[Customers]    Script Date: 8/7/2018 1:04:02 PM ******/
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
	[EntryDate] [datetime] NOT NULL CONSTRAINT [DF_Customers_EntryDate]  DEFAULT (getdate()),
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CustomerStatus]    Script Date: 8/7/2018 1:04:02 PM ******/
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
/****** Object:  Table [dbo].[Files]    Script Date: 8/7/2018 1:04:02 PM ******/
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
/****** Object:  Table [dbo].[FilesLines]    Script Date: 8/7/2018 1:04:02 PM ******/
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
/****** Object:  Table [dbo].[Locations]    Script Date: 8/7/2018 1:04:02 PM ******/
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
/****** Object:  Table [dbo].[OwnerShipTypes]    Script Date: 8/7/2018 1:04:02 PM ******/
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
/****** Object:  Table [dbo].[Permission.PermissionGroup]    Script Date: 8/7/2018 1:04:02 PM ******/
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
/****** Object:  Table [dbo].[PermissionGroups]    Script Date: 8/7/2018 1:04:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PermissionGroups](
	[PermissionGroupID] [int] IDENTITY(1,1) NOT NULL,
	[GroupName] [nvarchar](100) NOT NULL,
	[ByUserID] [bigint] NOT NULL,
	[EntryDate] [datetime] NOT NULL CONSTRAINT [DF_PermissionGroups_EntryDate]  DEFAULT (getdate()),
	[IsActive] [bit] NOT NULL CONSTRAINT [DF_PermissionGroups_IsActive]  DEFAULT ((1)),
	[IsDeleted] [bit] NOT NULL CONSTRAINT [DF_PermissionGroups_IsDeleted]  DEFAULT ((0)),
 CONSTRAINT [PK_PermissionGroups] PRIMARY KEY CLUSTERED 
(
	[PermissionGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PreviewStatus]    Script Date: 8/7/2018 1:04:02 PM ******/
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
/****** Object:  Table [dbo].[Projects]    Script Date: 8/7/2018 1:04:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Projects](
	[CompanyID] [int] NOT NULL,
	[ProjectID] [int] IDENTITY(1,1) NOT NULL,
	[ProjectName] [nvarchar](250) NOT NULL,
	[LocationID] [int] NOT NULL,
	[AddressDetails] [nvarchar](250) NOT NULL,
	[NoOfUnits] [int] NOT NULL,
	[ProjectStatusID] [int] NOT NULL,
	[ByUserID] [bigint] NOT NULL,
	[EntryDate] [datetime] NOT NULL CONSTRAINT [DF_Projects_EntryDate]  DEFAULT (getdate()),
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Projects] PRIMARY KEY CLUSTERED 
(
	[ProjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProjectStatus]    Script Date: 8/7/2018 1:04:02 PM ******/
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
/****** Object:  Table [dbo].[Properties]    Script Date: 8/7/2018 1:04:02 PM ******/
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
	[Price] [decimal](9, 0) NULL,
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
	[EntryDate] [datetime] NOT NULL CONSTRAINT [DF_Properties_EntryDate]  DEFAULT (getdate()),
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Properties] PRIMARY KEY CLUSTERED 
(
	[PropertyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PropertyFloorTypes]    Script Date: 8/7/2018 1:04:02 PM ******/
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
/****** Object:  Table [dbo].[PropertyPictures]    Script Date: 8/7/2018 1:04:02 PM ******/
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
/****** Object:  Table [dbo].[PropertyPurpose]    Script Date: 8/7/2018 1:04:02 PM ******/
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
/****** Object:  Table [dbo].[PropertyRequests]    Script Date: 8/7/2018 1:04:02 PM ******/
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
	[CanInstallment] [bit] NULL,
	[NoOfYears] [int] NULL,
	[PropertyFloorTypeID] [int] NULL,
	[MinArea] [int] NULL,
	[MaxArea] [int] NULL,
	[OwnerShipTypeID] [int] NULL,
	[PropertyTypeID] [int] NULL,
	[PropertyPurposeID] [int] NULL,
	[Comments] [nvarchar](max) NULL,
	[ByUserID] [bigint] NOT NULL,
	[EntryDate] [datetime] NOT NULL CONSTRAINT [DF_PropertyRequests_EntryDate]  DEFAULT (getdate()),
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_PropertyRequests] PRIMARY KEY CLUSTERED 
(
	[RequestID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PropertyRequests.FollowUp]    Script Date: 8/7/2018 1:04:02 PM ******/
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
/****** Object:  Table [dbo].[PropertyTypes]    Script Date: 8/7/2018 1:04:02 PM ******/
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
/****** Object:  Table [dbo].[RequestStatus]    Script Date: 8/7/2018 1:04:02 PM ******/
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
/****** Object:  Table [dbo].[Shared]    Script Date: 8/7/2018 1:04:02 PM ******/
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
/****** Object:  Table [dbo].[Transactions]    Script Date: 8/7/2018 1:04:02 PM ******/
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
/****** Object:  Table [dbo].[User.UserPermission]    Script Date: 8/7/2018 1:04:02 PM ******/
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
/****** Object:  Table [dbo].[UserPermission]    Script Date: 8/7/2018 1:04:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserPermission](
	[UserPermissionID] [int] IDENTITY(1,1) NOT NULL,
	[PermissionTitle] [nvarchar](100) NOT NULL,
	[ByUserID] [bigint] NOT NULL,
	[IsDeleted] [bit] NOT NULL CONSTRAINT [DF_UserPermission_IsDeleted]  DEFAULT ((0)),
 CONSTRAINT [PK_UserPermission] PRIMARY KEY CLUSTERED 
(
	[UserPermissionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Users]    Script Date: 8/7/2018 1:04:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [bigint] IDENTITY(1,1) NOT NULL,
	[CompanyID] [int] NULL,
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
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Companies] ON 

INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDesc], [CompanyVerificationTypeID], [ImgPath], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (1, N'شركة العقارات', N'عن الشركة hnvg', 2, N'about.jpg', 1, CAST(N'2018-04-21 17:37:20.523' AS DateTime), 1, 0)
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDesc], [CompanyVerificationTypeID], [ImgPath], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (2, N'شركة الاختبارات النووية ', N'يييي يي', 2, N'Screenshot_2_1520163147.jpg', 1, CAST(N'2018-06-28 11:25:05.280' AS DateTime), 1, 0)
SET IDENTITY_INSERT [dbo].[Companies] OFF
SET IDENTITY_INSERT [dbo].[CompanyVerificationTypes] ON 

INSERT [dbo].[CompanyVerificationTypes] ([CompanyVerificationTypeID], [VerificationTitle], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (2, N'ممارسة حرة', 1, CAST(N'2018-04-28 22:45:26.227' AS DateTime), 1, 0)
INSERT [dbo].[CompanyVerificationTypes] ([CompanyVerificationTypeID], [VerificationTitle], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (4, N'منظمة رسمية', 1, CAST(N'2018-04-28 22:46:12.433' AS DateTime), 1, 0)
INSERT [dbo].[CompanyVerificationTypes] ([CompanyVerificationTypeID], [VerificationTitle], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (5, N'منظمة رسمية محترفة', 1, CAST(N'2018-04-28 22:46:40.660' AS DateTime), 1, 0)
SET IDENTITY_INSERT [dbo].[CompanyVerificationTypes] OFF
SET IDENTITY_INSERT [dbo].[Customers] ON 

INSERT [dbo].[Customers] ([CustomerID], [CompanyID], [CustomerStatusID], [CustomerName], [Notes], [CreatedDate], [ByUserID], [Comments], [EntryDate], [IsActive], [IsDeleted]) VALUES (10002, NULL, 1, N'محمد أسامة', N'سسس', CAST(N'2018-05-03 00:45:04.843' AS DateTime), 1, N'سسس', CAST(N'2018-05-03 00:45:04.843' AS DateTime), 1, 1)
INSERT [dbo].[Customers] ([CustomerID], [CompanyID], [CustomerStatusID], [CustomerName], [Notes], [CreatedDate], [ByUserID], [Comments], [EntryDate], [IsActive], [IsDeleted]) VALUES (20002, NULL, 1, N'سبسيب', N'رريس', CAST(N'2018-05-07 01:01:50.477' AS DateTime), 1, NULL, CAST(N'2018-05-07 01:01:50.477' AS DateTime), 0, 0)
SET IDENTITY_INSERT [dbo].[Customers] OFF
SET IDENTITY_INSERT [dbo].[CustomerStatus] ON 

INSERT [dbo].[CustomerStatus] ([CustomerStatusID], [CustomerStatusTitle], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (1, N'حالى', 1, CAST(N'2018-03-10 16:37:26.447' AS DateTime), 1, 0)
INSERT [dbo].[CustomerStatus] ([CustomerStatusID], [CustomerStatusTitle], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (2, N'سابق', 1, CAST(N'2018-03-10 16:37:56.287' AS DateTime), 1, 0)
INSERT [dbo].[CustomerStatus] ([CustomerStatusID], [CustomerStatusTitle], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (3, N'مهم', 1, CAST(N'2018-03-10 16:38:09.710' AS DateTime), 1, 0)
INSERT [dbo].[CustomerStatus] ([CustomerStatusID], [CustomerStatusTitle], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (4, N'مؤقت', 1, CAST(N'2018-03-10 16:38:49.290' AS DateTime), 1, 0)
SET IDENTITY_INSERT [dbo].[CustomerStatus] OFF
SET IDENTITY_INSERT [dbo].[Files] ON 

INSERT [dbo].[Files] ([FileID], [ParentID], [ParentType], [FileName], [FileType], [OrginalFileName], [IsActive], [IsDeleted], [CreatedDate], [LastUpdated]) VALUES (1, 2, N'Properties', N'34647360_1020784938087262_5296264115617005568_n.jpg', NULL, N'34647360_1020784938087262_5296264115617005568_n.jpg', 1, 0, CAST(N'2018-06-12 01:10:20.687' AS DateTime), CAST(N'2018-06-12 01:10:20.687' AS DateTime))
INSERT [dbo].[Files] ([FileID], [ParentID], [ParentType], [FileName], [FileType], [OrginalFileName], [IsActive], [IsDeleted], [CreatedDate], [LastUpdated]) VALUES (2, 2, N'Properties', N'34879365_1729890393726498_79741994905108480_n.jpg', NULL, N'34879365_1729890393726498_79741994905108480_n.jpg', 1, 0, CAST(N'2018-06-12 01:10:20.697' AS DateTime), CAST(N'2018-06-12 01:10:20.697' AS DateTime))
INSERT [dbo].[Files] ([FileID], [ParentID], [ParentType], [FileName], [FileType], [OrginalFileName], [IsActive], [IsDeleted], [CreatedDate], [LastUpdated]) VALUES (4, 4, N'Projects', N'Misr.Protection.png', NULL, N'Misr.Protection.png', 1, 0, CAST(N'2018-06-28 12:43:44.090' AS DateTime), CAST(N'2018-06-28 12:43:44.090' AS DateTime))
INSERT [dbo].[Files] ([FileID], [ParentID], [ParentType], [FileName], [FileType], [OrginalFileName], [IsActive], [IsDeleted], [CreatedDate], [LastUpdated]) VALUES (5, 4, N'Projects', N'Screenshot_2_1520163147.jpg', NULL, N'Screenshot_2_1520163147.jpg', 1, 0, CAST(N'2018-06-28 12:43:44.120' AS DateTime), CAST(N'2018-06-28 12:43:44.120' AS DateTime))
INSERT [dbo].[Files] ([FileID], [ParentID], [ParentType], [FileName], [FileType], [OrginalFileName], [IsActive], [IsDeleted], [CreatedDate], [LastUpdated]) VALUES (7, 3, N'Properties', N'74917f9f-56dd-4f5a-a8c4-339c04e566d9.jpg', NULL, N'74917f9f-56dd-4f5a-a8c4-339c04e566d9.jpg', 1, 0, CAST(N'2018-07-02 16:25:31.867' AS DateTime), CAST(N'2018-07-02 16:25:31.867' AS DateTime))
INSERT [dbo].[Files] ([FileID], [ParentID], [ParentType], [FileName], [FileType], [OrginalFileName], [IsActive], [IsDeleted], [CreatedDate], [LastUpdated]) VALUES (8, 1, N'Projects', N'89b8f5ce-9bde-4057-ab6d-cbe85a4c4db5.jpg', NULL, N'89b8f5ce-9bde-4057-ab6d-cbe85a4c4db5.jpg', 1, 0, CAST(N'2018-07-02 18:00:55.833' AS DateTime), CAST(N'2018-07-02 18:00:55.833' AS DateTime))
INSERT [dbo].[Files] ([FileID], [ParentID], [ParentType], [FileName], [FileType], [OrginalFileName], [IsActive], [IsDeleted], [CreatedDate], [LastUpdated]) VALUES (9, 1, N'Projects', N'49320a5d-9477-4b02-9e6f-fb7a04f7267d.png', NULL, N'49320a5d-9477-4b02-9e6f-fb7a04f7267d.png', 1, 0, CAST(N'2018-07-02 18:00:55.863' AS DateTime), CAST(N'2018-07-02 18:00:55.863' AS DateTime))
SET IDENTITY_INSERT [dbo].[Files] OFF
SET IDENTITY_INSERT [dbo].[Locations] ON 

INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (3, NULL, N'مصر', 1, CAST(N'2018-04-21 16:27:53.773' AS DateTime), 1, 0)
INSERT [dbo].[Locations] ([LocationID], [ParentID], [LocationName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (4, 3, N'القاهرة', 1, CAST(N'2018-04-21 16:28:43.890' AS DateTime), 1, 0)
SET IDENTITY_INSERT [dbo].[Locations] OFF
SET IDENTITY_INSERT [dbo].[OwnerShipTypes] ON 

INSERT [dbo].[OwnerShipTypes] ([OwnerShipTypeID], [OwnerShipTitle], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (1005, N'ايجار 12', 1, CAST(N'2018-04-17 21:03:51.443' AS DateTime), 1, 1)
INSERT [dbo].[OwnerShipTypes] ([OwnerShipTypeID], [OwnerShipTitle], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (2006, N'تمليك', 1, CAST(N'2018-04-15 01:03:15.393' AS DateTime), 1, 0)
INSERT [dbo].[OwnerShipTypes] ([OwnerShipTypeID], [OwnerShipTitle], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (2009, N'غير ذلك', 1, CAST(N'2018-04-15 01:03:08.877' AS DateTime), 1, 0)
INSERT [dbo].[OwnerShipTypes] ([OwnerShipTypeID], [OwnerShipTitle], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (3006, N'ملكية مؤقتة', 1, CAST(N'2018-04-17 21:05:13.933' AS DateTime), 0, 0)
SET IDENTITY_INSERT [dbo].[OwnerShipTypes] OFF
SET IDENTITY_INSERT [dbo].[Permission.PermissionGroup] ON 

INSERT [dbo].[Permission.PermissionGroup] ([ID], [PermissionGroupID], [UserPermissionID], [ByUserID]) VALUES (1, 2, 2, 1)
INSERT [dbo].[Permission.PermissionGroup] ([ID], [PermissionGroupID], [UserPermissionID], [ByUserID]) VALUES (2, 2, 3, 1)
INSERT [dbo].[Permission.PermissionGroup] ([ID], [PermissionGroupID], [UserPermissionID], [ByUserID]) VALUES (3, 2, 5, 1)
SET IDENTITY_INSERT [dbo].[Permission.PermissionGroup] OFF
SET IDENTITY_INSERT [dbo].[PermissionGroups] ON 

INSERT [dbo].[PermissionGroups] ([PermissionGroupID], [GroupName], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (2, N'Company Member', 1, CAST(N'2018-04-22 01:07:24.873' AS DateTime), 1, 0)
SET IDENTITY_INSERT [dbo].[PermissionGroups] OFF
SET IDENTITY_INSERT [dbo].[Projects] ON 

INSERT [dbo].[Projects] ([CompanyID], [ProjectID], [ProjectName], [LocationID], [AddressDetails], [NoOfUnits], [ProjectStatusID], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (1, 1, N'أبراج التيسير', 4, N'شارع 77 ', 125, 2, 1, CAST(N'2018-04-28 16:14:04.587' AS DateTime), 1, 0)
INSERT [dbo].[Projects] ([CompanyID], [ProjectID], [ProjectName], [LocationID], [AddressDetails], [NoOfUnits], [ProjectStatusID], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (1, 4, N'sdfdsf', 4, N'dsfsdfsdf', 1004, 2, 1, CAST(N'2018-06-28 12:34:13.737' AS DateTime), 1, 0)
SET IDENTITY_INSERT [dbo].[Projects] OFF
SET IDENTITY_INSERT [dbo].[ProjectStatus] ON 

INSERT [dbo].[ProjectStatus] ([ProjectStatusID], [StatusTitle], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (1, N'كامل التشطيب', 1, CAST(N'2018-04-28 15:34:29.713' AS DateTime), 1, 0)
INSERT [dbo].[ProjectStatus] ([ProjectStatusID], [StatusTitle], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (2, N'تحت التشطيب', 1, CAST(N'2018-04-28 15:34:40.720' AS DateTime), 1, 0)
SET IDENTITY_INSERT [dbo].[ProjectStatus] OFF
SET IDENTITY_INSERT [dbo].[Properties] ON 

INSERT [dbo].[Properties] ([PropertyID], [Title], [CustomerID], [ByUserID], [LocationID], [AddressDetails], [ProjectID], [IsUnit], [Price], [CanInstallment], [NoOfYears], [DownPayment], [FloorNum], [PropertyFloorTypeID], [NoOfProperties], [Area], [OwnerShipTypeID], [PropertyTypeID], [PropertyPurposeID], [HasElevator], [HasGarage], [AllowVisitors], [Commission], [NumberOfRooms], [NumberOfBathrooms], [ReadyDate], [LastUpdated], [SharedID], [Comments], [EntryDate], [IsActive], [IsDeleted]) VALUES (2, N'شثة ', 0, 1, 3, N'بببب', 1, 1, CAST(1000 AS Decimal(9, 0)), 1, 1, CAST(1500 AS Decimal(9, 0)), 12, 1, 10, 10, 1005, 1, 4, 1, 1, 0, NULL, 8, 10, CAST(N'2018-01-06' AS Date), CAST(N'2018-06-20 14:20:03.223' AS DateTime), N'All', N'سسس', CAST(N'2018-06-20 14:20:03.223' AS DateTime), 1, 0)
INSERT [dbo].[Properties] ([PropertyID], [Title], [CustomerID], [ByUserID], [LocationID], [AddressDetails], [ProjectID], [IsUnit], [Price], [CanInstallment], [NoOfYears], [DownPayment], [FloorNum], [PropertyFloorTypeID], [NoOfProperties], [Area], [OwnerShipTypeID], [PropertyTypeID], [PropertyPurposeID], [HasElevator], [HasGarage], [AllowVisitors], [Commission], [NumberOfRooms], [NumberOfBathrooms], [ReadyDate], [LastUpdated], [SharedID], [Comments], [EntryDate], [IsActive], [IsDeleted]) VALUES (3, N'سسسس', 0, 1, 4, N'dfgdfgdfg', 4, 0, CAST(10000 AS Decimal(9, 0)), 1, 3, CAST(300000 AS Decimal(9, 0)), 10, 1, 1, 120, 2006, 1, 4, 0, 1, 1, NULL, 3, 2, CAST(N'2018-07-24' AS Date), CAST(N'2018-07-02 16:25:31.363' AS DateTime), N'All', N'2111', CAST(N'2018-07-02 16:25:31.363' AS DateTime), 1, 0)
SET IDENTITY_INSERT [dbo].[Properties] OFF
SET IDENTITY_INSERT [dbo].[PropertyFloorTypes] ON 

INSERT [dbo].[PropertyFloorTypes] ([PropertyFloorTypeID], [FloorTypeTitle], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (1, N'الطابق الارضى سيب', 1, CAST(N'2018-04-17 21:40:55.690' AS DateTime), 1, 1)
SET IDENTITY_INSERT [dbo].[PropertyFloorTypes] OFF
SET IDENTITY_INSERT [dbo].[PropertyPurpose] ON 

INSERT [dbo].[PropertyPurpose] ([PropertyPurposeID], [PropPurposeTitle], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (4, N'سكنى', 1, CAST(N'2018-06-12 01:07:18.893' AS DateTime), 1, 0)
SET IDENTITY_INSERT [dbo].[PropertyPurpose] OFF
SET IDENTITY_INSERT [dbo].[PropertyRequests] ON 

INSERT [dbo].[PropertyRequests] ([RequestID], [Title], [CustomerID], [LocationIDs], [AddressDetails], [MinPrice], [MaxPrice], [CanInstallment], [NoOfYears], [PropertyFloorTypeID], [MinArea], [MaxArea], [OwnerShipTypeID], [PropertyTypeID], [PropertyPurposeID], [Comments], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (1, NULL, 0, 3, N'sdfsdfds', CAST(5000 AS Decimal(9, 0)), CAST(10000000 AS Decimal(9, 0)), 1, 10, 1, 100, 150, 1005, 1, 4, N'dsgdsgs', 1, CAST(N'2018-08-07 12:33:38.463' AS DateTime), 1, 0)
SET IDENTITY_INSERT [dbo].[PropertyRequests] OFF
SET IDENTITY_INSERT [dbo].[PropertyTypes] ON 

INSERT [dbo].[PropertyTypes] ([PropertyTypeID], [PropTypeTitle], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (1, N'ييي', 1, CAST(N'2018-06-12 01:09:20.310' AS DateTime), 1, 0)
SET IDENTITY_INSERT [dbo].[PropertyTypes] OFF
INSERT [dbo].[Shared] ([ShareID], [ShareTitle]) VALUES (N'All', N'All Btokers')
INSERT [dbo].[Shared] ([ShareID], [ShareTitle]) VALUES (N'OnlyMe', N'Only Me')
SET IDENTITY_INSERT [dbo].[User.UserPermission] ON 

INSERT [dbo].[User.UserPermission] ([ID], [UserID], [UserPermissionID], [ByUserID]) VALUES (1, 3, 2, 0)
INSERT [dbo].[User.UserPermission] ([ID], [UserID], [UserPermissionID], [ByUserID]) VALUES (2, 3, 3, 0)
INSERT [dbo].[User.UserPermission] ([ID], [UserID], [UserPermissionID], [ByUserID]) VALUES (3, 3, 5, 0)
SET IDENTITY_INSERT [dbo].[User.UserPermission] OFF
SET IDENTITY_INSERT [dbo].[UserPermission] ON 

INSERT [dbo].[UserPermission] ([UserPermissionID], [PermissionTitle], [ByUserID], [IsDeleted]) VALUES (2, N'اضافة مستخدم', 1, 0)
INSERT [dbo].[UserPermission] ([UserPermissionID], [PermissionTitle], [ByUserID], [IsDeleted]) VALUES (3, N'ادارة المعاينات', 1, 0)
INSERT [dbo].[UserPermission] ([UserPermissionID], [PermissionTitle], [ByUserID], [IsDeleted]) VALUES (5, N'اضافة عملية بيع/شراء', 1, 0)
SET IDENTITY_INSERT [dbo].[UserPermission] OFF
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserID], [CompanyID], [FullName], [Email], [Mobile], [UserPassword], [FavouriteLocationIDs], [Notes], [ProfileImgPath], [IsConfirmed], [LastLogin], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (1, NULL, N'Admin', N'admin@brokernetwork.com', N'01007330161', N'123456', NULL, NULL, NULL, 1, NULL, NULL, CAST(N'2018-03-11 08:49:22.800' AS DateTime), 1, 0)
INSERT [dbo].[Users] ([UserID], [CompanyID], [FullName], [Email], [Mobile], [UserPassword], [FavouriteLocationIDs], [Notes], [ProfileImgPath], [IsConfirmed], [LastLogin], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (2, NULL, N'محمد بحيرى', N'mohamed.behery@ebseg.com', N'01007330161', N'Omar@123', NULL, N'any thing', NULL, 1, NULL, NULL, CAST(N'2018-04-21 17:19:05.827' AS DateTime), 1, 0)
INSERT [dbo].[Users] ([UserID], [CompanyID], [FullName], [Email], [Mobile], [UserPassword], [FavouriteLocationIDs], [Notes], [ProfileImgPath], [IsConfirmed], [LastLogin], [ByUserID], [EntryDate], [IsActive], [IsDeleted]) VALUES (3, 1, N'عمر السيد حلمى', N'omar@test.com', N'01024567241', N'123456', NULL, NULL, NULL, 1, NULL, 1, CAST(N'2018-04-22 01:21:46.720' AS DateTime), 1, 0)
SET IDENTITY_INSERT [dbo].[Users] OFF
ALTER TABLE [dbo].[CusomerPreviews] ADD  CONSTRAINT [DF_CusomerPreviews_NoOfProperties]  DEFAULT ((1)) FOR [NoOfProperties]
GO
ALTER TABLE [dbo].[CusomerPreviews] ADD  CONSTRAINT [DF_CusomerPreviews_EntryDate_1]  DEFAULT (getdate()) FOR [EntryDate]
GO
ALTER TABLE [dbo].[Customer.CustomerStatus] ADD  CONSTRAINT [DF_Customer.CustomerStatus_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[PreviewStatus] ADD  CONSTRAINT [DF_PreviewStatus_EntryDate]  DEFAULT (getdate()) FOR [EntryDate]
GO
ALTER TABLE [dbo].[PropertyPictures] ADD  CONSTRAINT [DF_PropertyPictures_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[PropertyPictures] ADD  CONSTRAINT [DF_PropertyPictures_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[PropertyRequests.FollowUp] ADD  CONSTRAINT [DF_Requests.FollowUp_EntryDate]  DEFAULT (getdate()) FOR [EntryDate]
GO
ALTER TABLE [dbo].[PropertyRequests.FollowUp] ADD  CONSTRAINT [DF_Requests.FollowUp_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[RequestStatus] ADD  CONSTRAINT [DF_RequestStatus_EntryDate]  DEFAULT (getdate()) FOR [EntryDate]
GO
ALTER TABLE [dbo].[Transactions] ADD  CONSTRAINT [DF_Transactions_EntryDate_1]  DEFAULT (getdate()) FOR [EntryDate]
GO
ALTER TABLE [dbo].[Companies]  WITH CHECK ADD  CONSTRAINT [FK_Companies_CompanyVerificationTypes] FOREIGN KEY([CompanyVerificationTypeID])
REFERENCES [dbo].[CompanyVerificationTypes] ([CompanyVerificationTypeID])
GO
ALTER TABLE [dbo].[Companies] CHECK CONSTRAINT [FK_Companies_CompanyVerificationTypes]
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
USE [master]
GO
ALTER DATABASE [BrokerNetwork] SET  READ_WRITE 
GO
