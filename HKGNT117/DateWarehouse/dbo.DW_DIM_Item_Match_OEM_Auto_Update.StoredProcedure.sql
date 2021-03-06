USE [DataWarehouse]
GO
/****** Object:  StoredProcedure [dbo].[DW_DIM_Item_Match_OEM_Auto_Update]    Script Date: 2014/11/12 17:04:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DW_DIM_Item_Match_OEM_Auto_Update]
AS
BEGIN
	SET NOCOUNT ON;

    -- Get Data Table from Baan TTIITM001180,TTCMCS044180
	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#temp_TTIITM001180') AND TYPE = 'U')
		DROP TABLE #temp_TTIITM001180

	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#temp_TTCMCS044180') AND TYPE = 'U')
		DROP TABLE #temp_TTCMCS044180

	SELECT * INTO #temp_TTIITM001180 FROM OPENQUERY(AS1P1,'SELECT T$ITEM,T$CITG,T$CSGS FROM BAAN.TTIITM001180')

	DELETE #temp_TTIITM001180 WHERE T$ITEM IN(SELECT T$ITEM FROM DW_DIM_Item_Match_OEM)

	SELECT * INTO #temp_TTCMCS044180 FROM OPENQUERY(AS1P1,'SELECT * FROM BAAN.TTCMCS044180')

	INSERT INTO dbo.DW_DIM_Item_Match_OEM 
	SELECT A.T$ITEM,A.T$CSGS,B.T$DSCA FROM #temp_TTIITM001180 AS A LEFT JOIN #temp_TTCMCS044180 AS B ON A.T$CSGS = B.T$CSGP
--	WHERE  A.T$ITEM NOT IN(SELECT T$ITEM FROM DW_DIM_Item_Match_OEM)

END

GO
