USE [Multek_ZH]
GO
/****** Object:  User [BIusr]    Script Date: 2014/11/12 17:12:15 ******/
CREATE USER [BIusr] FOR LOGIN [BIusr] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [BIusr]
GO
