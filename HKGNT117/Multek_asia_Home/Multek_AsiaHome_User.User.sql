USE [Multek_AsiaHome]
GO
/****** Object:  User [Multek_AsiaHome_User]    Script Date: 2014/11/12 17:07:58 ******/
CREATE USER [Multek_AsiaHome_User] FOR LOGIN [Multek_AsiaHome_User] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [Multek_AsiaHome_User]
GO
