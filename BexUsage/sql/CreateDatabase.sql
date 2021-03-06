USE [master]
GO
/****** Object:  Database [BexUsage]    Script Date: 4/28/2019 9:43:52 AM ******/
CREATE DATABASE [BexUsage]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BexUsage', FILENAME = N'C:\Users\scott\BexUsage.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'BexUsage_log', FILENAME = N'C:\Users\scott\BexUsage_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [BexUsage] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BexUsage].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BexUsage] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BexUsage] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BexUsage] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BexUsage] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BexUsage] SET ARITHABORT OFF 
GO
ALTER DATABASE [BexUsage] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [BexUsage] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BexUsage] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BexUsage] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BexUsage] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BexUsage] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BexUsage] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BexUsage] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BexUsage] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BexUsage] SET  DISABLE_BROKER 
GO
ALTER DATABASE [BexUsage] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BexUsage] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BexUsage] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BexUsage] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BexUsage] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BexUsage] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [BexUsage] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BexUsage] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [BexUsage] SET  MULTI_USER 
GO
ALTER DATABASE [BexUsage] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BexUsage] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BexUsage] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BexUsage] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [BexUsage] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [BexUsage] SET QUERY_STORE = OFF
GO
USE [BexUsage]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [BexUsage]
GO
/****** Object:  Table [dbo].[Usage]    Script Date: 4/28/2019 9:43:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usage](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[DateReported] [datetime] NOT NULL,
	[MegabytesUsed] [float] NOT NULL,
	[BaseAllowance] [float] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Usage] ADD  CONSTRAINT [DF_Usage_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[Usage] ADD  CONSTRAINT [DF_Table_1_DateRecorded]  DEFAULT (getdate()) FOR [DateReported]
GO
USE [master]
GO
ALTER DATABASE [BexUsage] SET  READ_WRITE 
GO
