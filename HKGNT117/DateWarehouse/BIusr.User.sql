USE [DataWarehouse]
GO
/****** Object:  User [BIusr]    Script Date: 2014/11/12 17:04:25 ******/
CREATE USER [BIusr] FOR LOGIN [BIusr] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [BIusr]
GO
