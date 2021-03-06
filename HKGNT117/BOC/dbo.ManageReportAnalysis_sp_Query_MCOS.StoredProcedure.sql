USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[ManageReportAnalysis_sp_Query_MCOS]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ManageReportAnalysis_sp_Query_MCOS]
	@Plant nvarchar(50),
	@PercentageType   nvarchar(20),
	@Project nvarchar(50),
	@StartFY nvarchar(10),
	@StartPeriod nvarchar(10),
	@EndFY nvarchar(10),
	@EndPeriod nvarchar(10),
    @UserId  nvarchar(50)
AS
BEGIN

	SET NOCOUNT ON;
	DECLARE @sqlString nvarchar(1000)


	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#CostDetails') AND TYPE = 'U')
		DROP TABLE #CostDetails

	-- GET TABLE STRUCTURE
	SELECT 
		[Project]
		,[FiscalYearDesc]
		,[FiscalPeriodDesc]
		,[ShipmentQty]
		,[UnitPrice]
		,[Bom]AS [BOMEDM]
		,[BomPercentage]AS [PERCENTAGE]
		,[ScrapRate]
	INTO #CostDetails 
	FROM [BOC].[dbo].[Exr2_MATPercentage_ByProject] WHERE 1 <> 1
	
	--Percentage
	IF @PercentageType = 'Yield'
		BEGIN
			IF @Plant = 'ALL'
			BEGIN
				INSERT INTO #CostDetails
				SELECT 
					[Project]
					,[FiscalYearDesc]
					,[FiscalPeriodDesc]
					,[ShipmentQty]
					,[UnitPrice]
					,[Bom]AS [BOMEDM]
					,[BomPercentage]AS [PERCENTAGE]
					,[ScrapRate]
				FROM [BOC].[dbo].[Exr2_MATPercentage_ByProject]
				WHERE Project =@Project
						AND(
							 @StartFY < [FiscalYear]
							 OR( @StartFY = [FiscalYear]AND @StartPeriod <= [FiscalPeriod])
						)
						AND(
							 @EndFY > [FiscalYear]
							 OR( @EndFY = [FiscalYear]AND @EndPeriod >= [FiscalPeriod])
						)
			END
			ELSE
			BEGIN
				INSERT INTO #CostDetails
				SELECT 
					[Project]
					,[FiscalYearDesc]
					,[FiscalPeriodDesc]
					,[ShipmentQty]
					,[UnitPrice]
					,[Bom]AS [BOMEDM]
					,[BomPercentage]AS [PERCENTAGE]
					,[ScrapRate]
				FROM [BOC].[dbo].[Exr2_MATPercentage_ByProject]
				WHERE Plant = @plant
						AND Project =@Project
						AND(
							 @StartFY < [FiscalYear]
							 OR( @StartFY = [FiscalYear]AND @StartPeriod <= [FiscalPeriod])
						)
						AND(
							 @EndFY > [FiscalYear]
							 OR( @EndFY = [FiscalYear]AND @EndPeriod >= [FiscalPeriod])
						)
			END
			
		END
	IF @PercentageType = '100%Yield'
		BEGIN
			IF @Plant = 'ALL'
			BEGIN
				INSERT INTO #CostDetails
				SELECT 
					[Project]
					,[FiscalYearDesc]
					,[FiscalPeriodDesc]
					,[ShipmentQty]
					,[UnitPrice]
					,[Bom100]AS [BOMEDM]
					,[Bom100Percentage]AS [PERCENTAGE]
					,[ScrapRate]
				FROM [BOC].[dbo].[Exr2_MATPercentage_ByProject]
				WHERE Project =@Project
						AND(
							 @StartFY < [FiscalYear]
							 OR( @StartFY = [FiscalYear]AND @StartPeriod <= [FiscalPeriod])
						)
						AND(
							 @EndFY > [FiscalYear]
							 OR( @EndFY = [FiscalYear]AND @EndPeriod >= [FiscalPeriod])
						)
			END
			ELSE
			BEGIN
				INSERT INTO #CostDetails
				SELECT 
					[Project]
					,[FiscalYearDesc]
					,[FiscalPeriodDesc]
					,[ShipmentQty]
					,[UnitPrice]
					,[Bom100]AS [BOMEDM]
					,[Bom100Percentage]AS [PERCENTAGE]
					,[ScrapRate]
				FROM [BOC].[dbo].[Exr2_MATPercentage_ByProject]
				WHERE Plant = @plant
						AND Project =@Project
						AND(
							 @StartFY < [FiscalYear]
							 OR( @StartFY = [FiscalYear]AND @StartPeriod <= [FiscalPeriod])
						)
						AND(
							 @EndFY > [FiscalYear]
							 OR( @EndFY = [FiscalYear]AND @EndPeriod >= [FiscalPeriod])
						)
			END
			
		END
	IF @PercentageType = '+EDMYield'
		BEGIN
			IF @Plant = 'ALL'
			BEGIN
				INSERT INTO #CostDetails
				SELECT 
					[Project]
					,[FiscalYearDesc]
					,[FiscalPeriodDesc]
					,[ShipmentQty]
					,[UnitPrice]
					,[BOM+EDM]AS [BOMEDM]
					,[BOM+EDMPercentage]AS [PERCENTAGE]
					,[ScrapRate]
				FROM [BOC].[dbo].[Exr2_MATPercentage_ByProject]
				WHERE Project =@Project
						AND(
							 @StartFY < [FiscalYear]
							 OR( @StartFY = [FiscalYear]AND @StartPeriod <= [FiscalPeriod])
						)
						AND(
							 @EndFY > [FiscalYear]
							 OR( @EndFY = [FiscalYear]AND @EndPeriod >= [FiscalPeriod])
						)
			END
			ELSE
			BEGIN
				INSERT INTO #CostDetails
				SELECT 
					[Project]
					,[FiscalYearDesc]
					,[FiscalPeriodDesc]
					,[ShipmentQty]
					,[UnitPrice]
					,[BOM+EDM]AS [BOMEDM]
					,[BOM+EDMPercentage]AS [PERCENTAGE]
					,[ScrapRate]
				FROM [BOC].[dbo].[Exr2_MATPercentage_ByProject]
				WHERE Plant = @plant
						AND Project =@Project
						AND(
							 @StartFY < [FiscalYear]
							 OR( @StartFY = [FiscalYear]AND @StartPeriod <= [FiscalPeriod])
						)
						AND(
							 @EndFY > [FiscalYear]
							 OR( @EndFY = [FiscalYear]AND @EndPeriod >= [FiscalPeriod])
						)
			END
			
		END
	IF @PercentageType = '+EDM100%Yield'
		BEGIN
			IF @Plant = 'ALL'
			BEGIN
				INSERT INTO #CostDetails
				SELECT 
					[Project]
					,[FiscalYearDesc]
					,[FiscalPeriodDesc]
					,[ShipmentQty]
					,[UnitPrice]
					,[BOM+EDM100]AS [BOMEDM]
					,[BOM+EDM100Percentage]AS [PERCENTAGE]
					,[ScrapRate]
				FROM [BOC].[dbo].[Exr2_MATPercentage_ByProject]
				WHERE Project =@Project
						AND(
							 @StartFY < [FiscalYear]
							 OR( @StartFY = [FiscalYear]AND @StartPeriod <= [FiscalPeriod])
						)
						AND(
							 @EndFY > [FiscalYear]
							 OR( @EndFY = [FiscalYear]AND @EndPeriod >= [FiscalPeriod])
						)
			END
			ELSE
			BEGIN
				INSERT INTO #CostDetails
				SELECT 
					[Project]
					,[FiscalYearDesc]
					,[FiscalPeriodDesc]
					,[ShipmentQty]
					,[UnitPrice]
					,[BOM+EDM100]AS [BOMEDM]
					,[BOM+EDM100Percentage]AS [PERCENTAGE]
					,[ScrapRate]
				FROM [BOC].[dbo].[Exr2_MATPercentage_ByProject]
				WHERE Plant = @plant
						AND Project =@Project
						AND(
							 @StartFY < [FiscalYear]
							 OR( @StartFY = [FiscalYear]AND @StartPeriod <= [FiscalPeriod])
						)
						AND(
							 @EndFY > [FiscalYear]
							 OR( @EndFY = [FiscalYear]AND @EndPeriod >= [FiscalPeriod])
						)
			END
			
		END
	


	
	
  


   
	   SELECT 
			[FiscalYearDesc]
			,[FiscalPeriodDesc]
			,[ShipmentQty]
			,[UnitPrice]
			,[BOMEDM]
			,[PERCENTAGE]
			,[ScrapRate]
	   FROM #CostDetails 
	   UNION ALL
	   SELECT 
	   'Total'
	   , null
	   , null
	   , avg([UnitPrice])AS [UnitPrice]
	   , null AS [BOMEDM]
	   , case SUM([UnitPrice]*[ShipmentQty]) when 0 then null else cast((SUM([BOMEDM]*[ShipmentQty])/SUM([UnitPrice]*[ShipmentQty]))*100 as decimal(18,2)) end  AS [PERCENTAGE]
	   ,null AS [ScrapRate]
	   FROM #CostDetails
   

END


GO
