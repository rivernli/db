USE [master]
GO
/****** Object:  Database [multekchi_realtime]    Script Date: 2014/11/12 17:13:30 ******/
CREATE DATABASE [multekchi_realtime] ON  PRIMARY 
( NAME = N'multekchi_realtime', FILENAME = N'D:\DataBase\multekchi_realtime.mdf' , SIZE = 22589056KB , MAXSIZE = UNLIMITED, FILEGROWTH = 102400KB )
 LOG ON 
( NAME = N'multekchi_realtime_log', FILENAME = N'D:\DataBase\multekchi_realtime_log.ldf' , SIZE = 9216KB , MAXSIZE = 2048GB , FILEGROWTH = 102400KB )
GO
ALTER DATABASE [multekchi_realtime] SET COMPATIBILITY_LEVEL = 90
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [multekchi_realtime].[dbo].[sp_fulltext_database] @action = 'disable'
end
GO
ALTER DATABASE [multekchi_realtime] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [multekchi_realtime] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [multekchi_realtime] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [multekchi_realtime] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [multekchi_realtime] SET ARITHABORT OFF 
GO
ALTER DATABASE [multekchi_realtime] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [multekchi_realtime] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [multekchi_realtime] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [multekchi_realtime] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [multekchi_realtime] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [multekchi_realtime] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [multekchi_realtime] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [multekchi_realtime] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [multekchi_realtime] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [multekchi_realtime] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [multekchi_realtime] SET  DISABLE_BROKER 
GO
ALTER DATABASE [multekchi_realtime] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [multekchi_realtime] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [multekchi_realtime] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [multekchi_realtime] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [multekchi_realtime] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [multekchi_realtime] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [multekchi_realtime] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [multekchi_realtime] SET  MULTI_USER 
GO
ALTER DATABASE [multekchi_realtime] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [multekchi_realtime] SET DB_CHAINING OFF 
GO
ALTER DATABASE [multekchi_realtime] SET  READ_WRITE 
GO
