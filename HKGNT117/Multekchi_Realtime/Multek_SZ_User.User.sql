USE [multekchi_realtime]
GO
/****** Object:  User [Multek_SZ_User]    Script Date: 2014/11/12 17:13:31 ******/
CREATE USER [Multek_SZ_User] FOR LOGIN [Multek_SZ_User] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [Multek_SZ_User]
GO
