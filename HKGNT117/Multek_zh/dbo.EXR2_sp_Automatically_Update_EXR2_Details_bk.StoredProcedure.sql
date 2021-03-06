USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[EXR2_sp_Automatically_Update_EXR2_Details_bk]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[EXR2_sp_Automatically_Update_EXR2_Details_bk]
	-- Add the parameters for the stored procedure here
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE	@Current_FYear NVARCHAR(10) , @Current_FProd    NVARCHAR(4)
	DECLARE @Period_start_Date	DATETIME, @Period_end_Date	DATETIME

	-- Get current period 
	SELECT @Current_FYear = FiscalYearDesc,@Current_FProd = FiscalPeriod
	FROM   DataWarehouse.dbo.DW_DIM_Calender
	WHERE  calenderDate = convert(varchar(100),GETDATE(),23)

	-- get period start & period end date
	SELECT TOP 1 @Period_start_Date = convert(varchar(100),calenderDate,23) FROM ce3p1179.dbo.Calender WHERE FiscalYearDesc = @Current_FYear AND FiscalPeriod = @Current_FProd ORDER BY calenderDate ASC
	SELECT TOP 1 @Period_end_Date   = convert(varchar(100),calenderDate,23) FROM ce3p1179.dbo.Calender WHERE FiscalYearDesc = @Current_FYear AND FiscalPeriod = @Current_FProd ORDER BY calenderDate DESC

	-- IF EXISTS CURRENT PERIOD DATA , THEN CLEAR IT , & REUPDATE

	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#tempResult') AND TYPE = 'U')
		DROP TABLE #tempResult

	SELECT * INTO #tempResult FROM dbo.EXR2_Details AS A WHERE 1 <> 1

	IF EXISTS(SELECT TOP 1 * FROM dbo.EXR2_Details_TEST WHERE FYear = @Current_FYear AND Period = @Current_FProd)
		BEGIN
			DELETE dbo.EXR2_Details_TEST WHERE FYear = @Current_FYear AND Period = @Current_FProd
		END
	ELSE
		BEGIN
			INSERT INTO #tempResult(Plant,Project,UnitPrice,ShipmentQty,SalesAmount,[ShipmentArea(SQFT)])
			SELECT	A.T$PLNT,A.T$ITEM,A.T$PRIC,SUM(A.T$TQUA) AS Proj_Qty,SUM(A.T$AMNT) AS Sale_Amount,CAST(SUM(A.T$SQFT) AS DECIMAL(18,4)) AS Area_SQFT
			FROM	FactoryLoading.dbo.TFSCPP711180  AS A
			WHERE	A.T$PLNT <> '2F'
			AND		A.T$PLNT <> 'HK'
			AND		A.T$ASDT BETWEEN @Period_start_Date AND @Period_end_Date
			GROUP BY A.T$PLNT,A.T$ITEM,A.T$PRIC
			ORDER BY A.T$PLNT,A.T$ITEM,A.T$PRIC

			UPDATE #tempResult SET Plant = 'B1' WHERE Plant = 'P2'

			UPDATE #tempResult SET FYear = @Current_FYear
			UPDATE #tempResult SET Period = CASE LEN(@Current_FProd) WHEN 1 THEN 'P0'+@Current_FProd WHEN 2 THEN 'P'+@Current_FProd END
		END

	SELECT * FROM #tempResult
END

GO
