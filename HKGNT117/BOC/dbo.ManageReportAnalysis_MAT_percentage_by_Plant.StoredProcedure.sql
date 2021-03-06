USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[ManageReportAnalysis_MAT_percentage_by_Plant]    Script Date: 2014/11/12 17:02:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[ManageReportAnalysis_MAT_percentage_by_Plant]
	@PercentageType   nvarchar(20),
	@Plant nvarchar(50)
AS
BEGIN

	SET NOCOUNT ON;
	DECLARE @sqlString nvarchar(1000)


	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#CostDetails') AND TYPE = 'U')
		DROP TABLE #CostDetails

	-- GET TABLE STRUCTURE
	SELECT plant,FYear,Period,Project,t$cupn,t$cesu AS MATCost, t$cisu, t$tciu, t$tcuu, StdCostIncludedScrap, StdCostExcludedScrap, UnitPrice,ShipmentQty,SalesAmount, t$type, t$code, Technology, Layers INTO #CostDetails FROM dbo.CostDetail WHERE 1 <> 1

	-- GET ALL DETAIL DATA BY PARAMATER
	IF @plant <> 'ALL'
		BEGIN
			INSERT INTO #CostDetails
			SELECT plant,FYear,Period,Project,t$cupn,t$cesu AS MATCost, t$cisu, t$tciu, t$tcuu, StdCostIncludedScrap, StdCostExcludedScrap, UnitPrice,ShipmentQty,SalesAmount, t$type, t$code, Technology, Layers
			FROM dbo.CostDetail
			WHERE Plant = @plant
		END
	ELSE
		BEGIN
			INSERT INTO #CostDetails
			SELECT plant,FYear,Period,Project,t$cupn,t$cesu AS MATCost, t$cisu, t$tciu, t$tcuu, StdCostIncludedScrap, StdCostExcludedScrap, UnitPrice,ShipmentQty,SalesAmount, t$type, t$code, Technology, Layers
			FROM dbo.CostDetail
		END
	
	-- GET OEM NAME
	ALTER TABLE #CostDetails ADD OEM_NAME NVARCHAR(50)
	
	
	--索引
	create index Period on #CostDetails (Period)
	create index Project on #CostDetails (Project)
	create index OEM_NAME on #CostDetails (OEM_NAME)
	UPDATE #CostDetails SET OEM_NAME = (select X.OEM_Name from dbo.CostItemMatchOEM AS X where X.item = #CostDetails.project)
	
	
	--Use "MAT percentage by OEM group " in "MAT only percentage" group
	ALTER TABLE #CostDetails ADD MaterialCostAmount decimal(18,4)

	IF @PercentageType = 'Yield'
		BEGIN
			UPDATE #CostDetails SET  MaterialCostAmount= isnull([StdCostIncludedScrap],0) *  isnull([ShipmentQty],0)
		END
	IF @PercentageType = '100%Yield'
		BEGIN
			UPDATE #CostDetails SET  MaterialCostAmount= isnull([StdCostExcludedScrap],0) *  isnull([ShipmentQty],0)
		END
	IF @PercentageType = '+EDMYield'
		BEGIN
			UPDATE #CostDetails SET  MaterialCostAmount= isnull([t$cisu],0) *  isnull([ShipmentQty],0)
		END
	IF @PercentageType = '+EDM100%Yield'
		BEGIN
			UPDATE #CostDetails SET  MaterialCostAmount= isnull([MATCost],0) *  isnull([ShipmentQty],0)
		END
	


	
	
  

	
	

	   --INSERT INTO MAT_percentage_by_Plant
	   SELECT FYear, Period
	   ,cast( sum([MaterialCostAmount])as decimal(18,2))AS 'BOMEDM'
	   ,cast( sum(SalesAmount) as decimal(18,2))AS 'SalesAmount'
	   ,cast(isnull(sum([MaterialCostAmount]),0)/case isnull(sum(SalesAmount),0) when 0 then 1 else sum(SalesAmount) end as decimal(18,4))*100 AS 'PERCENTAGE'
	   FROM #CostDetails 
	   GROUP BY FYear, Period
	   ORDER BY FYear ,Period 
	   --FYear, Period,Project,t$cupn,MATCost, t$cisu, t$tciu, t$tcuu, StdCostIncludedScrap, StdCostExcludedScrap, UnitPrice,ShipmentQty,SalesAmount, t$type, t$code, Technology, Layers, OEM_NAME,  MaterialCostAmount, PERCENTAGE
   

END

GO
