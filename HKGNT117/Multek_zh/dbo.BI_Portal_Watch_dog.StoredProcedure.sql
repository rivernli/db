USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[BI_Portal_Watch_dog]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[BI_Portal_Watch_dog]
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @Current_FYear	NVARCHAR(10)
	DECLARE	@Last_Period NVARCHAR(10)

	/*========================================================================================================*/
    -- Get Gurrent Finance Period
		SELECT @Current_FYear = FiscalYearDesc , @Last_Period = FiscalPeriod FROM ce3p1179.dbo.Calender WHERE CONVERT(CHAR,calenderDate,102) = CONVERT(CHAR,GETDATE(),102)
		
		SET @Last_Period = @Last_Period - 1
		IF	@Last_Period = 0
			BEGIN
				SET	@Last_Period = 'P12'
				SET @Current_FYear = 'FY'+CAST((CAST(RIGHT(@Current_FYear,4)AS INT) - 1) AS NVARCHAR(3))
			END
		ELSE
			BEGIN
				IF CAST(@Last_Period AS INT) < 10
					SET @Last_Period = 'P0'+CAST(@Last_Period AS NVARCHAR(3))
				ELSE
					SET @Last_Period = 'P' +CAST(@Last_Period AS NVARCHAR(3))
			END

	/*========================================================================================================*/
	-- GET Last Cost Details Data
		IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID('tempdb.#Temp_Cost_Details') AND TYPE = 'U')
			DROP TABLE #Temp_Cost_Details

		SELECT Plant,FYear,Period,Project,t$cesu AS MATCost, UnitPrice,ShipmentQty,SalesAmount,t$cesu AS PERCENTAGE INTO #Temp_Cost_Details FROM BOC.dbo.CostDetail WHERE 1 <> 1

		INSERT INTO #Temp_Cost_Details
		SELECT Plant,FYear,Period,Project,t$cesu AS MATCost, UnitPrice,ShipmentQty,SalesAmount,CAST(ISNULL(t$cesu,0) / CASE ISNULL(UnitPrice,0) WHEN 0 THEN 1 ELSE UnitPrice END  AS DECIMAL(18,4)) AS PERCENTAGE 
		FROM BOC.dbo.CostDetail
		WHERE FYear = @Current_FYear AND Period = @Last_Period AND	 ISNULL(t$cesu,0) > 0 AND ISNULL(UnitPrice,0) > 0

		ALTER TABLE #Temp_Cost_Details ADD OEM_NAME NVARCHAR(50)

		UPDATE	#Temp_Cost_Details SET OEM_NAME = (select X.OEM_Name from dbo.COMMON_ItemMatchOEM AS X where X.item = #Temp_Cost_Details.project)

	-- Sort Cost Details Data by OEM & Amount
		IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#tempSort') AND TYPE = 'U')
			DROP TABLE #tempSort

		SELECT TOP 10 OEM_NAME,CAST(SUM(SalesAmount) AS DECIMAL(18,2)) AS SalesAmount INTO #tempSort FROM #Temp_Cost_Details GROUP BY OEM_NAME ORDER BY SalesAmount DESC

	/*========================================================================================================*/
	-- Show result
		IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#tempResult') AND TYPE = 'U')
			DROP TABLE #tempResult

		CREATE INDEX INDEX_ShipmentAmount on #Temp_Cost_Details(SalesAmount)
		CREATE INDEX INDEX_PERCENTAGE on #Temp_Cost_Details(PERCENTAGE)

		SELECT X.* INTO #tempResult FROM #Temp_Cost_Details AS X JOIN #tempSort AS B ON X.OEM_NAME = B.OEM_NAME ORDER BY B.SalesAmount DESC,OEM_NAME -- DESC,X.PERCENTAGE DESC

		INSERT #tempResult(OEM_NAME,Project,SalesAmount) SELECT OEM_NAME,'Total',SalesAmount FROM #tempSort

		-- Return top 10 OEM order by sale amount
		SELECT X.* FROM #tempResult AS X JOIN #tempSort AS B ON X.OEM_NAME = B.OEM_NAME ORDER BY B.SalesAmount DESC,x.SalesAmount ASC

		-- Return top 10 Percent more then 65%
		SELECT TOP 10 * FROM #Temp_Cost_Details WHERE PERCENTAGE > 0.65 ORDER BY PERCENTAGE DESC
END



GO
