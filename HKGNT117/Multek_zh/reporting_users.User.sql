USE [Multek_ZH]
GO
/****** Object:  User [reporting_users]    Script Date: 2014/11/12 17:12:15 ******/
CREATE USER [reporting_users] FOR LOGIN [reporting_users] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [reporting_users]
GO
