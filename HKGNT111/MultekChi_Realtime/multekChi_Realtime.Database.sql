USE [master]
GO
/****** Object:  Database [multekChi_Realtime]    Script Date: 11/06/2014 15:53:06 ******/
CREATE DATABASE [multekChi_Realtime] ON  PRIMARY 
( NAME = N'multekChi_Realtime', FILENAME = N'D:\Multek_Database\multekChi_Realtime.mdf' , SIZE = 2376704KB , MAXSIZE = UNLIMITED, FILEGROWTH = 102400KB )
 LOG ON 
( NAME = N'multekChi_Realtime_log', FILENAME = N'D:\Multek_Database\multekChi_Realtime_log.ldf' , SIZE = 104704KB , MAXSIZE = 2048GB , FILEGROWTH = 102400KB )
GO
ALTER DATABASE [multekChi_Realtime] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [multekChi_Realtime].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [multekChi_Realtime] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [multekChi_Realtime] SET ANSI_NULLS OFF
GO
ALTER DATABASE [multekChi_Realtime] SET ANSI_PADDING OFF
GO
ALTER DATABASE [multekChi_Realtime] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [multekChi_Realtime] SET ARITHABORT OFF
GO
ALTER DATABASE [multekChi_Realtime] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [multekChi_Realtime] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [multekChi_Realtime] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [multekChi_Realtime] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [multekChi_Realtime] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [multekChi_Realtime] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [multekChi_Realtime] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [multekChi_Realtime] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [multekChi_Realtime] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [multekChi_Realtime] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [multekChi_Realtime] SET  DISABLE_BROKER
GO
ALTER DATABASE [multekChi_Realtime] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [multekChi_Realtime] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [multekChi_Realtime] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [multekChi_Realtime] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [multekChi_Realtime] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [multekChi_Realtime] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [multekChi_Realtime] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [multekChi_Realtime] SET  READ_WRITE
GO
ALTER DATABASE [multekChi_Realtime] SET RECOVERY SIMPLE
GO
ALTER DATABASE [multekChi_Realtime] SET  MULTI_USER
GO
ALTER DATABASE [multekChi_Realtime] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [multekChi_Realtime] SET DB_CHAINING OFF
GO
EXEC sys.sp_db_vardecimal_storage_format N'multekChi_Realtime', N'ON'
GO
