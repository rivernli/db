USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[ManageReportAnalysis_sp_Query_ALL_OEMS_By_MAT_Percentage_1]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,Rivern Li>
-- Create date: <Create Date,2010/07/07,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ManageReportAnalysis_sp_Query_ALL_OEMS_By_MAT_Percentage_1]
	@FYear   nvarchar(10),
	@FPeriod nvarchar(10),
	@plant   nvarchar(15),
	@top     nvarchar(10)
AS
BEGIN

	SET NOCOUNT ON;
	DECLARE @sqlString nvarchar(1000),@BeginTime DATETIME

	SET @BeginTime=GETDATE()

	SET @FPeriod = ISNULL(@FPeriod,'')
	SET @FPeriod = LTRIM(RTRIM(@FPeriod))

	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#CostDetails') AND TYPE = 'U')
		DROP TABLE #CostDetails

	-- GET TABLE STRUCTURE
	SELECT Period,Project,t$cesu AS MATCost, UnitPrice,ShipmentQty,SalesAmount,t$cesu AS PERCENTAGE INTO #CostDetails FROM dbo.CostDetail WHERE 1 <> 1

	-- GET ALL DETAIL DATA BY PARAMATER
	IF @plant <> 'ALL'
		BEGIN
			IF @FPeriod <> 'P'
				BEGIN
					INSERT INTO #CostDetails
					SELECT Period,Project,t$cesu AS MATCost, UnitPrice,ShipmentQty,SalesAmount,cast(isnull(t$cesu,0) / case isnull(UnitPrice,0) when 0 then 1 else UnitPrice end  as decimal(18,4)) AS PERCENTAGE 
					FROM dbo.CostDetail
					WHERE FYear = @FYear and Plant = @plant AND Period = @FPeriod
					and	  isnull(t$cesu,0) > 0
				END
			ELSE
				BEGIN
					INSERT INTO #CostDetails
					SELECT Period,Project,t$cesu AS MATCost, UnitPrice,ShipmentQty,SalesAmount,cast(isnull(t$cesu,0) / case isnull(UnitPrice,0) when 0 then 1 else UnitPrice end  as decimal(18,4)) AS PERCENTAGE 
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
					SELECT Period,Project,t$cesu AS MATCost, UnitPrice,ShipmentQty,SalesAmount,cast(isnull(t$cesu,0) / case isnull(UnitPrice,0) when 0 then 1 else UnitPrice end  as decimal(18,4)) AS PERCENTAGE 
					FROM dbo.CostDetail
					WHERE FYear = @FYear AND PERIOD = @FPeriod
					and	  isnull(t$cesu,0) > 0
				END
			ELSE
				BEGIN
					INSERT INTO #CostDetails
					SELECT Period,Project,t$cesu AS MATCost, UnitPrice,ShipmentQty,SalesAmount,cast(isnull(t$cesu,0) / case isnull(UnitPrice,0) when 0 then 1 else UnitPrice end  as decimal(18,4)) AS PERCENTAGE 
					FROM dbo.CostDetail
					WHERE FYear = @FYear
					and	  isnull(t$cesu,0) > 0
				END
		END

	-- GET OEM NAME
	ALTER TABLE #CostDetails ADD OEM_NAME NVARCHAR(50)
	create index Period on #CostDetails (Period)
	create index Project on #CostDetails (Project)
	create index OEM_NAME on #CostDetails (OEM_NAME)


	UPDATE #CostDetails SET OEM_NAME = (select X.OEM_Name from dbo.CostItemMatchOEM AS X where X.item = #CostDetails.project)
	UPDATE #CostDetails SET PERCENTAGE = 0 WHERE UnitPrice = 0

	-- GET TOP X OEM DATA BY SALE AMOUNT
--	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#tempResult') AND TYPE = 'U')
--		DROP TABLE #tempResult

	SELECT OEM_NAME,CAST(SUM(SalesAmount) AS DECIMAL(18,2)) AS SalesAmount INTO #tempResult FROM #CostDetails GROUP BY OEM_NAME

	-- GET FINIAL DATA
--	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#tempResult1') AND TYPE = 'U')
--		DROP TABLE #tempResult1
	SELECT * INTO #tempResult1 FROM #tempResult WHERE 1 <> 1




	IF @top = 0 
		BEGIN
			INSERT INTO #tempResult1 SELECT * FROM #tempResult ORDER BY SalesAmount DESC
				SELECT @BEGINTIME,GETDATE()
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
				SELECT @BEGINTIME,GETDATE()

	SELECT X.* FROM #CostDetails AS X JOIN #tempResult1 AS B ON X.OEM_NAME = B.OEM_NAME ORDER BY B.SalesAmount DESC,X.PERCENTAGE DESC
				SELECT @BEGINTIME,GETDATE()

--	-- DELTE USED TEMP TABLE 
--	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#tempResult') AND TYPE = 'U')
--		DROP TABLE #tempResult
--	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#tempResult1') AND TYPE = 'U')
--		DROP TABLE #tempResult1
--	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#CostDetails') AND TYPE = 'U')
--		DROP TABLE #CostDetails

END


GO
