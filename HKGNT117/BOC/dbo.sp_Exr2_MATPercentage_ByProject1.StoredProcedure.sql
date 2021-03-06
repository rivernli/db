USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[sp_Exr2_MATPercentage_ByProject1]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Exr2_MATPercentage_ByProject1]
AS
BEGIN
	--用于更新[Exr2_MATPercentage_ByProject] 表

	--CurrentDay
	DECLARE @CurrentDay DATETIME
	SET @CurrentDay=CONVERT(DATETIME, CONVERT(varchar(100), getdate(), 112))

	--OverallPeriod
	IF (select object_ID('tempdb..#OverallPeriod')) >0 
		DROP TABLE [#OverallPeriod]
	SELECT 
		b.[Project]
		, b.[Plant]
		, a.[FiscalYearDesc]
		, a.[FiscalPeriodDesc]
		, a.[FiscalPeriod]
	INTO [#OverallPeriod]
	FROM (
		SELECT [FiscalYearDesc], [FiscalPeriodDesc], [FiscalPeriod]
		FROM  [DataWarehouse].[dbo].[DW_DIM_Calender]
		WHERE [calenderDate]>='2009-04-01'
			AND [calenderDate]<=@CurrentDay	
		GROUP BY [FiscalYearDesc], [FiscalPeriodDesc], [FiscalPeriod]

	) AS a 
	CROSS  JOIN [BOC_Test].[dbo].[CostDetail]AS b  
	GROUP BY b.[Project], b.[Plant], a.[FiscalYearDesc], a.[FiscalPeriod], a.[FiscalPeriodDesc]
	ORDER BY b.[Project], b.[Plant], a.[FiscalYearDesc], a.[FiscalPeriod]

	--MAT percentage by Project
	IF (SELECT object_ID('BOC..Exr2_MATPercentage_ByProject')) >0 
		DROP TABLE [BOC_Test]..[Exr2_MATPercentage_ByProject]

	SELECT 
		a.[Project] 
		, a.[Plant]
		, CAST(substring(a.[FiscalYearDesc],3,4)AS INT)AS [FiscalYear]
		, a.[FiscalYearDesc]
		, a.[FiscalPeriod]
		, a.[FiscalPeriodDesc]
		, SUM(ShipmentQty) AS [ShipmentQty]
		, CAST(AVG([UnitPrice]) AS DECIMAL(18,2))AS [UnitPrice]
		, 100-AVG([ScrapRate])AS [ScrapRate]
		
		, CAST( AVG([StdCostIncludedScrap])AS DECIMAL(18,2))AS [Bom]
		, CASE SUM([UnitPrice]*[ShipmentQty]) WHEN 0 THEN NULL ELSE CAST((SUM([StdCostIncludedScrap]*[ShipmentQty])/SUM([UnitPrice]*[ShipmentQty]))*100 AS DECIMAL(18,2)) END  AS [BomPercentage]
		, CAST( AVG([StdCostExcludedScrap]) AS DECIMAL(18,2))AS [BOM100]
		, CASE SUM([UnitPrice]*[ShipmentQty]) WHEN 0 THEN NULL ELSE CAST((SUM([StdCostExcludedScrap]*[ShipmentQty])/SUM([UnitPrice]*[ShipmentQty]))*100 AS DECIMAL(18,2)) END  AS [Bom100Percentage]
		
		, CAST( AVG([t$cisu])AS DECIMAL(18,2))AS [Bom+EDM]
		, CASE SUM([UnitPrice]*[ShipmentQty]) WHEN 0 THEN NULL ELSE CAST((SUM([t$cisu]*[ShipmentQty])/SUM([UnitPrice]*[ShipmentQty]))*100 AS DECIMAL(18,2)) END  AS [Bom+EDMPercentage]
		, CAST( AVG([t$cesu]) AS DECIMAL(18,2))AS [BOM+EDM100]
		, CASE SUM([UnitPrice]*[ShipmentQty]) WHEN 0 THEN NULL ELSE CAST((SUM([t$cesu]*[ShipmentQty])/SUM([UnitPrice]*[ShipmentQty]))*100 AS DECIMAL(18,2)) END  AS [Bom+EDM100Percentage]

	INTO [BOC_Test].[dbo].[Exr2_MATPercentage_ByProject]
	FROM  [#OverallPeriod] AS a 
	LEFT  JOIN [BOC_Test].[dbo].[CostDetail]AS b   
	ON    a.[Project] =  b.[Project]
			AND a.[Plant] = b.[Plant]
			AND a.[FiscalYearDesc] = b.[FYear]
			AND a.[FiscalPeriodDesc] = b.[Period]
	GROUP BY a.[Project], a.[Plant], a.[FiscalYearDesc], a.[FiscalPeriod], a.[FiscalPeriodDesc]
	ORDER BY a.[Project], a.[Plant], a.[FiscalYearDesc], a.[FiscalPeriod], a.[FiscalPeriodDesc]

	--Delete Table
	DROP TABLE [#OverallPeriod]
END


GO
