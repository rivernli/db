USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[sp_Exr2_MATPercentageByOEMGroup]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[sp_Exr2_MATPercentageByOEMGroup] 
	@PercentageType   nvarchar(20),
	@FYear   nvarchar(10),
	@FPeriod nvarchar(10),
	@plant   nvarchar(15),
	@top     nvarchar(10),
	@Type    nvarchar(30),
    @Domain  nvarchar(50),
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
	SELECT [Period],[Project],[t$cupn],[t$cesu] AS [MATCost], [t$cisu], [t$tciu], [t$tcuu], [StdCostIncludedScrap], [StdCostExcludedScrap], [UnitPrice],[ShipmentQty],[SalesAmount], [t$type], [t$code], [Technology], [Layers], [OEMName] 
	INTO [#CostDetails] 
	FROM [dbo].[CostDetail] 
	WHERE 1 <> 1

	-- GET ALL DETAIL DATA BY PARAMATER
	IF @plant <> 'ALL'
		BEGIN
			IF @FPeriod <> 'ALL'
				BEGIN
					INSERT INTO #CostDetails
					SELECT [Period],[Project],[t$cupn],[t$cesu] AS [MATCost], [t$cisu], [t$tciu], [t$tcuu], [StdCostIncludedScrap], [StdCostExcludedScrap], [UnitPrice],[ShipmentQty],[SalesAmount], [t$type], [t$code], [Technology], [Layers], [OEMName]
					FROM [dbo].[CostDetail] 
					WHERE FYear = @FYear and Plant = @plant AND Period = @FPeriod
					and	  isnull(t$cesu,0) > 0
				END
			ELSE
				BEGIN
					INSERT INTO #CostDetails
					SELECT [Period],[Project],[t$cupn],[t$cesu] AS [MATCost], [t$cisu], [t$tciu], [t$tcuu], [StdCostIncludedScrap], [StdCostExcludedScrap], [UnitPrice],[ShipmentQty],[SalesAmount], [t$type], [t$code], [Technology], [Layers], [OEMName]
					FROM [dbo].[CostDetail] 
					WHERE FYear = @FYear and Plant = @plant
					and	  isnull(t$cesu,0) > 0
				END
		END
	ELSE
		BEGIN
			IF @FPeriod <> 'ALL'
				BEGIN
					INSERT INTO #CostDetails
					SELECT [Period],[Project],[t$cupn],[t$cesu] AS [MATCost], [t$cisu], [t$tciu], [t$tcuu], [StdCostIncludedScrap], [StdCostExcludedScrap], [UnitPrice],[ShipmentQty],[SalesAmount], [t$type], [t$code], [Technology], [Layers], [OEMName]
					FROM [dbo].[CostDetail] 
					WHERE FYear = @FYear AND PERIOD = @FPeriod
					and	  isnull(t$cesu,0) > 0
				END
			ELSE
				BEGIN
					INSERT INTO #CostDetails
					SELECT [Period],[Project],[t$cupn],[t$cesu] AS [MATCost], [t$cisu], [t$tciu], [t$tcuu], [StdCostIncludedScrap], [StdCostExcludedScrap], [UnitPrice],[ShipmentQty],[SalesAmount], [t$type], [t$code], [Technology], [Layers], [OEMName]
					FROM [dbo].[CostDetail] 
					WHERE FYear = @FYear
					and	  isnull(t$cesu,0) > 0
				END
		END

	
	--索引
	create index [Period] on [#CostDetails] (Period)
	create index [Project] on [#CostDetails] (Project)
	create index [OEMName] on [#CostDetails] (OEMName)
	
	--找出用戶的ID.
	DECLARE @id INT
	SELECT TOP 1 @id=sysuserid  FROM [Multek_BI].[dbo].[GAM_USERS] WHERE [uid]=@UserId AND [domain]=@Domain
	--列出用戶對應可以看的OEM
	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#OEMList') AND TYPE = 'U')
		DROP TABLE [#OEMList]
	SELECT [OEMName] INTO [#OEMList] FROM [Multek_BI].[dbo].[fx_getSalesForMKTRPT](@id) GROUP BY [OEMName] 
    DECLARE  @ListNumber int
    SELECT   @ListNumber=count(*) FROM  [#OEMList]
    IF @ListNumber>0 
    BEGIN
		   DELETE [#CostDetails] WHERE [OEMName] NOT IN(SELECT [OEMName] FROM [#OEMList]) 
	END
	
	--Use "MAT percentage by OEM group " in "MAT only percentage" group
	ALTER TABLE [#CostDetails] ADD [MaterialCostAmount] decimal(18,4)
	--Bom
	ALTER TABLE [#CostDetails] ADD [BOMEDM] decimal(18,2)
	--Percentage
	ALTER TABLE [#CostDetails] ADD [PERCENTAGE] decimal(18,2)
	IF @PercentageType = 'Yield'
		BEGIN
			UPDATE [#CostDetails] SET [BOMEDM] = CAST(ISNULL([StdCostIncludedScrap],0) as DECIMAL(18,2)), [PERCENTAGE] = cast(isnull([StdCostIncludedScrap],0) / (case isnull(UnitPrice,0) when 0 then 1 else UnitPrice end) *100  as decimal(18,2)) , MaterialCostAmount= isnull([StdCostIncludedScrap],0) *  isnull([ShipmentQty],0)
		END
	IF @PercentageType = '100%Yield'
		BEGIN
			UPDATE [#CostDetails] SET [BOMEDM] = CAST(ISNULL([StdCostExcludedScrap],0) as DECIMAL(18,2)), [PERCENTAGE] = cast(isnull([StdCostExcludedScrap],0) / (case isnull(UnitPrice,0) when 0 then 1 else UnitPrice end) *100  as decimal(18,2)) , MaterialCostAmount= isnull([StdCostExcludedScrap],0) *  isnull([ShipmentQty],0)
		END
	IF @PercentageType = '+EDMYield'
		BEGIN
			UPDATE [#CostDetails] SET [BOMEDM] = CAST(ISNULL([t$cisu],0) as DECIMAL(18,2)), [PERCENTAGE] = cast(isnull([t$cisu],0) / (case isnull(UnitPrice,0) when 0 then 1 else UnitPrice end) *100  as decimal(18,2)) , MaterialCostAmount= isnull([t$cisu],0) *  isnull([ShipmentQty],0)
		END
	IF @PercentageType = '+EDM100%Yield'
		BEGIN
			UPDATE [#CostDetails] SET [BOMEDM] = CAST(ISNULL([MATCost],0) as DECIMAL(18,2)), [PERCENTAGE] = cast(isnull([MATCost],0) / (case isnull(UnitPrice,0) when 0 then 1 else UnitPrice end) *100  as decimal(18,2)) , MaterialCostAmount= isnull([MATCost],0) *  isnull([ShipmentQty],0)
		END
	
	
	--UPDATE #CostDetails SET PERCENTAGE = 0 WHERE UnitPrice = 0
	DELETE [#CostDetails] WHERE ISNULL(MATCost,0)= 0 OR  ISNULL(UnitPrice,0) = 0

	-- GET TOP X OEM DATA BY SALE AMOUNT
	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#tempResult') AND TYPE = 'U')
		DROP TABLE [#tempResult]

	SELECT [OEMName],CAST(SUM(SalesAmount) AS DECIMAL(18,2)) AS [SalesAmount] INTO [#tempResult] FROM [#CostDetails] GROUP BY [OEMName]

	-- GET FINIAL DATA
	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#tempResult1') AND TYPE = 'U')
		DROP TABLE [#tempResult1]
	SELECT [OEMName],[SalesAmount] INTO #tempResult1 FROM [#tempResult] WHERE 1 <> 1

	IF @top = 0 
		BEGIN
			INSERT INTO [#tempResult1] SELECT [OEMName],[SalesAmount] FROM [#tempResult] ORDER BY SalesAmount DESC
		END
	ELSE
		BEGIN
			SET @sqlString = 'INSERT INTO [#tempResult1] SELECT TOP '++@top++' [OEMName],[SalesAmount] FROM [#tempResult] ORDER BY SalesAmount DESC'
			EXECUTE(@sqlString)
		END	


	
	CREATE INDEX INDEX_ShipmentAmount on #CostDetails(SalesAmount)
	CREATE INDEX INDEX_PERCENTAGE on #CostDetails(PERCENTAGE)
	

    IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#GroupT') AND TYPE = 'U')
		DROP TABLE [#GroupT]
	SELECT A.[Period], A.[Project], A.[t$cupn], A.[MATCost], A.[t$cisu], A.[t$tciu], A.[t$tcuu], A.[StdCostIncludedScrap], A.[StdCostExcludedScrap], A.[UnitPrice], A.[ShipmentQty], A.[SalesAmount], A.[t$type], A.[t$code], A.[Technology], A.[Layers], A.[OEMName], A.[MaterialCostAmount], A.[BOMEDM], A.[PERCENTAGE], 1 AS [indent], -1 AS [parent] 
	INTO [#GroupT] 
	FROM [#CostDetails] AS A JOIN [#tempResult1] AS B ON A.[OEMName] = B.[OEMName] 
	WHERE 1 <> 1  
	ORDER BY B.SalesAmount DESC,A.PERCENTAGE DESC 
    
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
		   INSERT INTO [#GroupT]
		   SELECT A.[Period], A.[Project], A.[t$cupn], A.[MATCost], A.[t$cisu], A.[t$tciu], A.[t$tcuu], A.[StdCostIncludedScrap], A.[StdCostExcludedScrap], A.[UnitPrice], A.[ShipmentQty], A.[SalesAmount], A.[t$type], A.[t$code], A.[Technology], A.[Layers], A.[OEMName], A.[MaterialCostAmount], A.[BOMEDM], A.[PERCENTAGE], 1 AS [indent], -1 AS [parent]  
		   FROM [#CostDetails] AS A JOIN [#tempResult1] AS B ON A.[OEMName] = B.[OEMName] 
		   WHERE A.[OEMName] In(SELECT OEM FROM @RightOEM )  
		  ORDER BY B.SalesAmount DESC,A.PERCENTAGE DESC
	   END	
	   ELSE
	   BEGIN
		  EXEC('INSERT INTO [#GroupT]
		  SELECT A.[Period], A.[Project], A.[t$cupn], A.[MATCost], A.[t$cisu], A.[t$tciu], A.[t$tcuu], A.[StdCostIncludedScrap], A.[StdCostExcludedScrap], A.[UnitPrice], A.[ShipmentQty], A.[SalesAmount], A.[t$type], A.[t$code], A.[Technology], A.[Layers], A.[OEMName], A.[MaterialCostAmount], A.[BOMEDM], A.[PERCENTAGE], 1 AS [indent], -1 AS [parent] 
		  FROM [#CostDetails] AS A JOIN [#tempResult1] AS B ON A.[OEMName] = B.[OEMName] 
		  WHERE PERCENTAGE '+@Type+'    
		  ORDER BY B.SalesAmount DESC,A.PERCENTAGE DESC')
	   END
	END
    ELSE
    BEGIN
	   IF @Type = 'ALL'
	   BEGIN
		   INSERT INTO [#GroupT]
		   SELECT A.[Period], A.[Project], A.[t$cupn], A.[MATCost], A.[t$cisu], A.[t$tciu], A.[t$tcuu], A.[StdCostIncludedScrap], A.[StdCostExcludedScrap], A.[UnitPrice], A.[ShipmentQty], A.[SalesAmount], A.[t$type], A.[t$code], A.[Technology], A.[Layers], A.[OEMName], A.[MaterialCostAmount], A.[BOMEDM], A.[PERCENTAGE], 1 AS [indent], -1 AS [parent] 
		   FROM [#CostDetails] AS A JOIN [#tempResult1] AS B ON A.[OEMName] = B.[OEMName]   
		   ORDER BY B.SalesAmount DESC,A.PERCENTAGE DESC
	   END	
	   ELSE
	   BEGIN
		  EXEC('INSERT INTO [#GroupT]
		  SELECT A.[Period], A.[Project], A.[t$cupn], A.[MATCost], A.[t$cisu], A.[t$tciu], A.[t$tcuu], A.[StdCostIncludedScrap], A.[StdCostExcludedScrap], A.[UnitPrice], A.[ShipmentQty], A.[SalesAmount], A.[t$type], A.[t$code], A.[Technology], A.[Layers], A.[OEMName], A.[MaterialCostAmount], A.[BOMEDM], A.[PERCENTAGE], 1 AS [indent], -1 AS [parent] 
		  FROM [#CostDetails] AS A JOIN [#tempResult1] AS B ON A.[OEMName] = B.[OEMName] 
		  WHERE PERCENTAGE '+ @Type +'   
		  ORDER BY B.SalesAmount DESC,A.PERCENTAGE DESC')
	   END
	END
	
	
	ALTER TABLE [#GroupT] ADD [Total] NVARCHAR(10)
	
	INSERT INTO [#GroupT]([OEMName], [SalesAmount], [PERCENTAGE] , [indent], [parent], [Total] )
	SELECT
		[OEMName], [SalesAmount], [PERCENTAGE] , [indent], [parent], [Total]
	FROM(
		SELECT 
			[OEMName]
			, SUM([SalesAmount]) AS [SalesAmount]
			, CAST(SUM([MaterialCostAmount])/SUM([SalesAmount]) *100 as DECIMAL(18,2))[PERCENTAGE]
			, 0 AS [indent]
			, -1 AS [parent]
			,NULL AS [Total]
		FROM [#GroupT]
		GROUP BY [OEMName]
		UNION ALL
		SELECT 
			'Total' AS[OEMName]
			, SUM([SalesAmount]) AS [SalesAmount]
			, CAST(SUM([MaterialCostAmount])/SUM([SalesAmount]) *100 as DECIMAL(18,2))[PERCENTAGE]
			, 0 AS [indent]
			, -1 AS [parent]
			,'Total'AS [Total]
		FROM [#GroupT]
	)AS [T]
	
	
	SELECT [OEMName],  [t$cupn], [Project], [Technology], [BOMEDM], [UnitPrice], [ShipmentQty], [SalesAmount], [PERCENTAGE], [t$code], [indent], [parent]
	FROM [#GroupT]
	ORDER BY [Total], [OEMName], [Project]
	
	--Delete Table
	DROP TABLE [#CostDetails]
	DROP TABLE [#tempResult]
	DROP TABLE [#tempResult1]
	DROP TABLE [#GroupT]
	DROP TABLE [#OEMList]


END



GO
