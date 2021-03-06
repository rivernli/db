USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcDBBackup]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2010-11-9 23:00
-- Description:	备份数据库
-- =============================================
CREATE PROCEDURE [dbo].[ProcDBBackup]
	@dbname nvarchar(50),
	@bakurl nvarchar(100)
AS
BEGIN
	backup database @dbname to disk=@bakurl
    select @@rowcount 
END

GO
