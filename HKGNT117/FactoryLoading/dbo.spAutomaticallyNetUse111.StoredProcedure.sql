USE [FactoryLoading]
GO
/****** Object:  StoredProcedure [dbo].[spAutomaticallyNetUse111]    Script Date: 2014/11/12 17:06:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spAutomaticallyNetUse111]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
    -- Insert statements for procedure here
	DECLARE @SQLString VARCHAR(MAX)

	SET @SQLString='master.dbo.xp_cmdshell ''net use * /del /y'''
	EXECUTE (@SQLString)
	SET @SQLString='master.dbo.xp_cmdshell ''net use  w: \\hkgnt111\d$\Multek_Database_Backup\117_Database_Backup P@ssw0rd /user:asia\hkg_sql'''
	EXECUTE (@SQLString)
	--SET @SQLString='master.dbo.xp_cmdshell ''del w:\*.*'''
	--EXECUTE (@SQLString)
	--BACKUP DATABASE  Multek_ZH TO DISK='W:\H_BACKUP.bak' with init 
END

GO
