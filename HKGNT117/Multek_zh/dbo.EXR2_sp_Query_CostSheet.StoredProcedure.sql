USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[EXR2_sp_Query_CostSheet]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[EXR2_sp_Query_CostSheet]
@Plant		nvarchar(10),
@Project	nvarchar(30),
@BomVer		nvarchar(10)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE	@sqlString	NVARCHAR(MAX)

	SET @Plant	 = ISNULL(@Plant,  '')
	SET @Project = ISNULL(@Project,'')
	SET @BomVer  = ISNULL(@BomVer, '')
	IF @Plant = 'B1' 
		SET @Plant = 'P2'

	SET @sqlString = 'SELECT * FROM FactoryLoading.dbo.TFSBOM400180 WHERE T$PLNT LIKE N'+''''+'%'+@Plant+'%'+''''

	IF @Project <> ''
		SET @sqlString = @sqlString +' AND T$PJNO LIKE N'+''''+'%'+@Project+'%'+''''

	IF @BomVer <> ''
		SET @sqlString = @sqlString +' AND T$SERN LIKE N'+''''+@BomVer+'%'+''''+ ' order by t$plnt,t$pjno,t$sern' 

	EXECUTE(@sqlString)
END


GO
