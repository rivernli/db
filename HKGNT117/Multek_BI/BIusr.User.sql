USE [Multek_BI]
GO
/****** Object:  User [BIusr]    Script Date: 2014/11/12 17:08:58 ******/
CREATE USER [BIusr] FOR LOGIN [BIusr] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [BIusr]
GO
