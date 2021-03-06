USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[ManageReportAnalysis_sp_Query_ALL_OEMS_By_MAT_Percentage]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ManageReportAnalysis_sp_Query_ALL_OEMS_By_MAT_Percentage]
	@PercentageType   nvarchar(20),
	@FYear   nvarchar(10),
	@FPeriod nvarchar(10),
	@plant   nvarchar(15),
	@top     nvarchar(10),
	@Type    nvarchar(30),
    @UserId  nvarchar(50)
AS
BEGIN

	SET NOCOUNT ON;
	DECLARE @sqlString nvarchar(1000)

	SET @FPeriod = ISNULL(@FPeriod,'')
	SET @FPeriod = LTRIM(RTRIM(@FPeriod))

	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#CostDetails') AND TYPE = 'U')
		DROP TABLE #CostDetails

	-- GET TABLE STRUCTURE
	SELECT Period,Project,t$cupn,t$cesu AS MATCost, t$cisu, t$tciu, t$tcuu, StdCostIncludedScrap, StdCostExcludedScrap, UnitPrice,ShipmentQty,SalesAmount, t$type, t$code, Technology, Layers INTO #CostDetails FROM dbo.CostDetail WHERE 1 <> 1

	-- GET ALL DETAIL DATA BY PARAMATER
	IF @plant <> 'ALL'
		BEGIN
			IF @FPeriod <> 'P'
				BEGIN
					INSERT INTO #CostDetails
					SELECT Period,Project,t$cupn,t$cesu AS MATCost, t$cisu, t$tciu, t$tcuu, StdCostIncludedScrap, StdCostExcludedScrap, UnitPrice,ShipmentQty,SalesAmount, t$type, t$code, Technology, Layers
					FROM dbo.CostDetail
					WHERE FYear = @FYear and Plant = @plant AND Period = @FPeriod
					and	  isnull(t$cesu,0) > 0
				END
			ELSE
				BEGIN
					INSERT INTO #CostDetails
					SELECT Period,Project,t$cupn,t$cesu AS MATCost, t$cisu, t$tciu, t$tcuu, StdCostIncludedScrap, StdCostExcludedScrap, UnitPrice,ShipmentQty,SalesAmount, t$type, t$code , Technology, Layers
					FROM dbo.CostDetail
					WHERE FYear = @FYear and Plant = @plant
					and	  isnull(t$cesu,0) > 0
				END
		END
	ELSE
		BEGIN
			IF @FPeriod <> 'P'
				BEGIN
					INSERT INTO #CostDetails
					SELECT Period,Project,t$cupn,t$cesu AS MATCost, t$cisu, t$tciu, t$tcuu, StdCostIncludedScrap, StdCostExcludedScrap, UnitPrice,ShipmentQty,SalesAmount, t$type, t$code , Technology, Layers
					FROM dbo.CostDetail
					WHERE FYear = @FYear AND PERIOD = @FPeriod
					and	  isnull(t$cesu,0) > 0
				END
			ELSE
				BEGIN
					INSERT INTO #CostDetails
					SELECT Period,Project,t$cupn,t$cesu AS MATCost, t$cisu, t$tciu, t$tcuu, StdCostIncludedScrap, StdCostExcludedScrap, UnitPrice,ShipmentQty,SalesAmount, t$type, t$code , Technology, Layers
					FROM dbo.CostDetail
					WHERE FYear = @FYear
					and	  isnull(t$cesu,0) > 0
				END
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
	--Percentage
	ALTER TABLE #CostDetails ADD PERCENTAGE decimal(18,4)
	IF @PercentageType = 'Yield'
		BEGIN
			UPDATE #CostDetails SET [PERCENTAGE] = cast(isnull([StdCostIncludedScrap],0) / case isnull(UnitPrice,0) when 0 then 1 else UnitPrice end  as decimal(18,4)) , MaterialCostAmount= isnull([StdCostIncludedScrap],0) *  isnull([ShipmentQty],0)
		END
	IF @PercentageType = '100%Yield'
		BEGIN
			UPDATE #CostDetails SET [PERCENTAGE] = cast(isnull([StdCostExcludedScrap],0) / case isnull(UnitPrice,0) when 0 then 1 else UnitPrice end  as decimal(18,4)) , MaterialCostAmount= isnull([StdCostExcludedScrap],0) *  isnull([ShipmentQty],0)
		END
	IF @PercentageType = '+EDMYield'
		BEGIN
			UPDATE #CostDetails SET [PERCENTAGE] = cast(isnull([t$cisu],0) / case isnull(UnitPrice,0) when 0 then 1 else UnitPrice end  as decimal(18,4)) , MaterialCostAmount= isnull([t$cisu],0) *  isnull([ShipmentQty],0)
		END
	IF @PercentageType = '+EDM100%Yield'
		BEGIN
			UPDATE #CostDetails SET [PERCENTAGE] = cast(isnull([MATCost],0) / case isnull(UnitPrice,0) when 0 then 1 else UnitPrice end  as decimal(18,4)) , MaterialCostAmount= isnull([MATCost],0) *  isnull([ShipmentQty],0)
		END
	
	
  

	
	
	--UPDATE #CostDetails SET PERCENTAGE = 0 WHERE UnitPrice = 0
	DELETE #CostDetails WHERE ISNULL(MATCost,0)= 0 OR  ISNULL(UnitPrice,0) = 0

	-- GET TOP X OEM DATA BY SALE AMOUNT
	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#tempResult') AND TYPE = 'U')
		DROP TABLE #tempResult

	SELECT OEM_NAME,CAST(SUM(SalesAmount) AS DECIMAL(18,2)) AS SalesAmount INTO #tempResult FROM #CostDetails GROUP BY OEM_NAME

	-- GET FINIAL DATA
	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#tempResult1') AND TYPE = 'U')
		DROP TABLE #tempResult1
	SELECT * INTO #tempResult1 FROM #tempResult WHERE 1 <> 1

	IF @top = 0 
		BEGIN
			INSERT INTO #tempResult1 SELECT * FROM #tempResult ORDER BY SalesAmount DESC
		END
	ELSE
		BEGIN
			SET @sqlString = 'INSERT INTO #tempResult1 SELECT TOP '++@top++' * FROM #tempResult ORDER BY SalesAmount DESC'
			EXECUTE(@sqlString)
		END	

--	SELECT * FROM #CostDetails
--	SELECT * FROM #tempResult1

--	DELETE #CostDetails WHERE MATCost IS NULL OR MATCost = 0 OR  UnitPrice IS NULL OR UnitPrice = 0
--	select * from #CostDetails WHERE MATCost IS NULL OR MATCost = 0 OR  UnitPrice IS NULL OR UnitPrice = 0

	ALTER TABLE #CostDetails ADD FYEAR NVARCHAR(10)
	UPDATE #CostDetails SET FYEAR = @FYear
	CREATE INDEX INDEX_ShipmentAmount on #CostDetails(SalesAmount)
	CREATE INDEX INDEX_PERCENTAGE on #CostDetails(PERCENTAGE)
	
	----GET Layers
	--ALTER TABLE #CostDetails ADD Layers NVARCHAR(10)
	----Layers
	--UPDATE #CostDetails SET Layers =substring([Project],2,2)--从Project第二们取两位
	----Technology
	--UPDATE #CostDetails SET t$type  = (SELECT  [T$ASTR] FROM [TFIATT006180] where [TFIATT006180].[T$ITEM] = #CostDetails.project and [TFIATT006180].[T$ATTR]='type')
	----SurfaceFinish
	----UPDATE #CostDetails SET t$code  = (SELECT  [TFSAMI040180].[T$DSCA] FROM [TFIATT006180],[TFSAMI040180] where [TFIATT006180].[T$ITEM] = #CostDetails.project and [TFIATT006180].[T$ATTR]='surf' and [TFSAMI040180].[T$MNWC]=[TFIATT006180].[T$ASTR])
	
	
	
	----Forcase
	--ALTER TABLE #CostDetails ADD Forcase NVARCHAR(50)
	--UPDATE #CostDetails SET [Forcase] = ManageReportAnalysis_MaintainTarget.[Value]
	--FROM  #CostDetails,ManageReportAnalysis_MaintainTarget
	--WHERE ManageReportAnalysis_MaintainTarget.[Target]='Technology' AND ManageReportAnalysis_MaintainTarget.[FiscalYear]=#CostDetails.[FYear] AND ManageReportAnalysis_MaintainTarget.[Cyc]=#CostDetails.[Period] AND ManageReportAnalysis_MaintainTarget.[Type]=#CostDetails.[t$type] 
	
	--UPDATE #CostDetails SET [Forcase] = ManageReportAnalysis_MaintainTarget.[Value]
	--FROM  #CostDetails,ManageReportAnalysis_MaintainTarget
	--WHERE #CostDetails.[Forcase] IS NOT NULL  AND ManageReportAnalysis_MaintainTarget.[Target]='SurfaceFinish' AND ManageReportAnalysis_MaintainTarget.[FiscalYear]=#CostDetails.[FYear] AND ManageReportAnalysis_MaintainTarget.[Cyc]=#CostDetails.[Period] AND ManageReportAnalysis_MaintainTarget.[Type]=(SELECT  [T$ASTR] FROM [TFIATT006180] where [TFIATT006180].[T$ITEM] = #CostDetails.project and [TFIATT006180].[T$ATTR]='surf') 
    
    
    
    -- 
    DECLARE  @User1Number int
    SELECT   @User1Number=count(*) FROM  RightUserTable WHERE RightUserTable.suid=@UserId
    IF @User1Number>0
    BEGIN
       declare @RightOEM table(OEM NVARCHAR(50) )
       INSERT INTO  @RightOEM 
       SELECT  RightOEMTable.oem FROM RightOEMTable INNER JOIN RightUserTable ON RightOEMTable.suid = RightUserTable.suid
	   WHERE RightUserTable.suid=@UserId OR RightUserTable.muid=@UserId
	  
	   IF @Type = 'ALL'
	   BEGIN
		   SELECT X.* FROM #CostDetails AS X JOIN #tempResult1 AS B ON X.OEM_NAME = B.OEM_NAME WHERE X.OEM_NAME In(SELECT OEM FROM @RightOEM ) ORDER BY B.SalesAmount DESC,X.PERCENTAGE DESC
	   END	
	   ELSE
	   BEGIN
		  exec('SELECT X.* FROM #CostDetails AS X JOIN #tempResult1 AS B ON X.OEM_NAME = B.OEM_NAME WHERE PERCENTAGE '+@Type+'  ORDER BY B.SalesAmount DESC,X.PERCENTAGE DESC')
	   END
	END
    ELSE
    BEGIN
	   IF @Type = 'ALL'
	   BEGIN
		   SELECT X.* FROM #CostDetails AS X JOIN #tempResult1 AS B ON X.OEM_NAME = B.OEM_NAME  ORDER BY B.SalesAmount DESC,X.PERCENTAGE DESC
	   END	
	   ELSE
	   BEGIN
		  exec('SELECT X.* FROM #CostDetails AS X JOIN #tempResult1 AS B ON X.OEM_NAME = B.OEM_NAME WHERE PERCENTAGE '+ @Type +'  ORDER BY B.SalesAmount DESC,X.PERCENTAGE DESC')
	   END
	END

 --   DECLARE  @User1Number int
 --   SELECT   @User1Number=count(*) FROM  RightUserTable WHERE RightUserTable.suid=@UserId
 --   IF @User1Number>0
 --   BEGIN
 --      declare @RightOEM table(OEM NVARCHAR(50) )
 --      INSERT INTO  @RightOEM 
 --      SELECT  RightOEMTable.oem FROM RightOEMTable INNER JOIN RightUserTable ON RightOEMTable.suid = RightUserTable.suid
	--   WHERE RightUserTable.suid=@UserId OR RightUserTable.muid=@UserId

	--   IF @Type = 'MORE'
	--   BEGIN
	--	SELECT X.* FROM #CostDetails AS X JOIN #tempResult1 AS B ON X.OEM_NAME = B.OEM_NAME WHERE PERCENTAGE >= 0.65 AND X.OEM_NAME In(SELECT OEM FROM @RightOEM ) ORDER BY B.SalesAmount DESC,X.PERCENTAGE DESC
	--   END

	--   IF @Type = 'LESS'
	--   BEGIN
	--	SELECT X.* FROM #CostDetails AS X JOIN #tempResult1 AS B ON X.OEM_NAME = B.OEM_NAME WHERE PERCENTAGE <0.65 AND X.OEM_NAME In(SELECT OEM FROM @RightOEM ) ORDER BY B.SalesAmount DESC,X.PERCENTAGE DESC
	--   END

	--   IF @Type = 'ALL'
	--   BEGIN
	--	SELECT X.* FROM #CostDetails AS X JOIN #tempResult1 AS B ON X.OEM_NAME = B.OEM_NAME WHERE X.OEM_NAME In(SELECT OEM FROM @RightOEM ) ORDER BY B.SalesAmount DESC,X.PERCENTAGE DESC
	--   END	
	--END
 --   ELSE
 --   BEGIN
	--   IF @Type = 'MORE'
	--   BEGIN
	--	SELECT X.* FROM #CostDetails AS X JOIN #tempResult1 AS B ON X.OEM_NAME = B.OEM_NAME WHERE PERCENTAGE >= 0.65  ORDER BY B.SalesAmount DESC,X.PERCENTAGE DESC
	--   END

	--   IF @Type = 'LESS'
	--   BEGIN
	--	SELECT X.* FROM #CostDetails AS X JOIN #tempResult1 AS B ON X.OEM_NAME = B.OEM_NAME WHERE PERCENTAGE <0.65  ORDER BY B.SalesAmount DESC,X.PERCENTAGE DESC
	--   END

	--   IF @Type = 'ALL'
	--   BEGIN
	--	SELECT X.* FROM #CostDetails AS X JOIN #tempResult1 AS B ON X.OEM_NAME = B.OEM_NAME  ORDER BY B.SalesAmount DESC,X.PERCENTAGE DESC
	--   END	
	--END

	
--	-- DELTE USED TEMP TABLE 
--	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#tempResult') AND TYPE = 'U')
--		DROP TABLE #tempResult
--	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#tempResult1') AND TYPE = 'U')
--		DROP TABLE #tempResult1
--	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#CostDetails') AND TYPE = 'U')
--		DROP TABLE #CostDetails

END

GO
