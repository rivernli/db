USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[sp_Exr2_MCOSTrend_ByOEMName]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Exr2_MCOSTrend_ByOEMName]
	@Plant nvarchar(50)
	,@Timeline   nvarchar(10)
	,@PercentageType   nvarchar(20)
	,@OEMName nvarchar(MAX)
	,@StartFY int
	,@StartQuarter int
	,@StartPeriod int
	,@ENDFY int
	,@ENDQuarter int
	,@ENDPeriod int
	,@Domain  nvarchar(50)
    ,@UserId  nvarchar(50)
AS
BEGIN
	SET NOCOUNT ON;
	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#CostDetails') AND TYPE = 'U')
		DROP TABLE [#CostDetails]

	-- GET TABLE STRUCTURE
	SELECT 
		[OEMName]
		,[FiscalYear]
		,[FiscalYearDesc]
		,[FiscalQuarter]
		,[FiscalQuarterDesc]
		,[FiscalPeriod]
		,[FiscalPeriodDesc]
		,[ShipmentQty]
		,[UnitPrice]
		,[SalesAmount]
		,[Bom]AS [BOMEDM]
		,[BomPercentage]AS [PERCENTAGE]
	INTO [#CostDetails]
	FROM [Exr2_MCOS_ByOEM] WHERE 1 <> 1
	
	--Percentage
	IF @PercentageType = 'Yield'
		BEGIN
			IF @Plant = 'ALL'
			BEGIN
				INSERT INTO [#CostDetails]
				SELECT 
					[OEMName]
					,[FiscalYear]
					,[FiscalYearDesc]
					,[FiscalQuarter]
					,[FiscalQuarterDesc]
					,[FiscalPeriod]
					,[FiscalPeriodDesc]
					,[ShipmentQty]
					,[UnitPrice]
					,[SalesAmount]
					,[Bom]AS [BOMEDM]
					,[BomPercentage]AS [PERCENTAGE]
				FROM [Exr2_MCOS_ByOEM]
				WHERE [OEMName] IN ( SELECT  col   FROM   [Multek_ZH].dbo.f_split(@OEMName,','))  -- 分割字符串 
				
			END
			ELSE
			BEGIN
				INSERT INTO [#CostDetails]
				SELECT 
					[OEMName]
					,[FiscalYear]
					,[FiscalYearDesc]
					,[FiscalQuarter]
					,[FiscalQuarterDesc]
					,[FiscalPeriod]
					,[FiscalPeriodDesc]
					,[ShipmentQty]
					,[UnitPrice]
					,[SalesAmount]
					,[Bom]AS [BOMEDM]
					,[BomPercentage]AS [PERCENTAGE]
				FROM [Exr2_MCOS_ByOEM]
				WHERE Plant = @plant
						AND [OEMName] IN ( SELECT  col   FROM   [Multek_ZH].dbo.f_split(@OEMName,','))  -- 分割字符串 
						
			END
			
		END
	IF @PercentageType = '100%Yield'
		BEGIN
			IF @Plant = 'ALL'
			BEGIN
				INSERT INTO [#CostDetails]
				SELECT 
					[OEMName]
					,[FiscalYear]
					,[FiscalYearDesc]
					,[FiscalQuarter]
					,[FiscalQuarterDesc]
					,[FiscalPeriod]
					,[FiscalPeriodDesc]
					,[ShipmentQty]
					,[UnitPrice]
					,[SalesAmount]
					,[Bom100]AS [BOMEDM]
					,[Bom100Percentage]AS [PERCENTAGE]
				FROM [Exr2_MCOS_ByOEM]
				WHERE [OEMName] IN ( SELECT  col   FROM   [Multek_ZH].dbo.f_split(@OEMName,','))  -- 分割字符串 
				
			END
			ELSE
			BEGIN
				INSERT INTO [#CostDetails]
				SELECT 
					[OEMName]
					,[FiscalYear]
					,[FiscalYearDesc]
					,[FiscalQuarter]
					,[FiscalQuarterDesc]
					,[FiscalPeriod]
					,[FiscalPeriodDesc]
					,[ShipmentQty]
					,[UnitPrice]
					,[SalesAmount]
					,[Bom100]AS [BOMEDM]
					,[Bom100Percentage]AS [PERCENTAGE]
				FROM [Exr2_MCOS_ByOEM]
				WHERE Plant = @plant
						AND [OEMName] IN ( SELECT  col   FROM   [Multek_ZH].dbo.f_split(@OEMName,','))  -- 分割字符串 
						
			END
			
		END
	IF @PercentageType = '+EDMYield'
		BEGIN
			IF @Plant = 'ALL'
			BEGIN
				INSERT INTO [#CostDetails]
				SELECT 
					[OEMName]
					,[FiscalYear]
					,[FiscalYearDesc]
					,[FiscalQuarter]
					,[FiscalQuarterDesc]
					,[FiscalPeriod]
					,[FiscalPeriodDesc]
					,[ShipmentQty]
					,[UnitPrice]
					,[SalesAmount]
					,[BOM+EDM]AS [BOMEDM]
					,[BOM+EDMPercentage]AS [PERCENTAGE]
				FROM [Exr2_MCOS_ByOEM]
				WHERE [OEMName] IN ( SELECT  col   FROM   [Multek_ZH].dbo.f_split(@OEMName,','))  -- 分割字符串 
				
			END
			ELSE
			BEGIN
				INSERT INTO [#CostDetails]
				SELECT 
					[OEMName]
					,[FiscalYear]
					,[FiscalYearDesc]
					,[FiscalQuarter]
					,[FiscalQuarterDesc]
					,[FiscalPeriod]
					,[FiscalPeriodDesc]
					,[ShipmentQty]
					,[UnitPrice]
					,[SalesAmount]
					,[BOM+EDM]AS [BOMEDM]
					,[BOM+EDMPercentage]AS [PERCENTAGE]
				FROM [Exr2_MCOS_ByOEM]
				WHERE Plant = @plant
						AND [OEMName] IN ( SELECT  col   FROM   [Multek_ZH].dbo.f_split(@OEMName,','))  -- 分割字符串 
						
			END
			
		END
	IF @PercentageType = '+EDM100%Yield'
		BEGIN
			IF @Plant = 'ALL'
			BEGIN
				INSERT INTO [#CostDetails]
				SELECT 
					[OEMName]
					,[FiscalYear]
					,[FiscalYearDesc]
					,[FiscalQuarter]
					,[FiscalQuarterDesc]
					,[FiscalPeriod]
					,[FiscalPeriodDesc]
					,[ShipmentQty]
					,[UnitPrice]
					,[SalesAmount]
					,[BOM+EDM100]AS [BOMEDM]
					,[BOM+EDM100Percentage]AS [PERCENTAGE]
				FROM [Exr2_MCOS_ByOEM]
				WHERE [OEMName] IN ( SELECT  col   FROM   [Multek_ZH].dbo.f_split(@OEMName,','))  -- 分割字符串 

			END
			ELSE
			BEGIN
				INSERT INTO [#CostDetails]
				SELECT 
					[OEMName]
					,[FiscalYear]
					,[FiscalYearDesc]
					,[FiscalQuarter]
					,[FiscalQuarterDesc]
					,[FiscalPeriod]
					,[FiscalPeriodDesc]
					,[ShipmentQty]
					,[UnitPrice]
					,[SalesAmount]
					,[BOM+EDM100]AS [BOMEDM]
					,[BOM+EDM100Percentage]AS [PERCENTAGE]
				FROM [Exr2_MCOS_ByOEM]
				WHERE Plant = @plant
						AND [OEMName] IN ( SELECT  col   FROM   [Multek_ZH].dbo.f_split(@OEMName,','))  -- 分割字符串 
						
			END
			
		END
	

	
	---- GroupT
	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#GroupT') AND TYPE = 'U')
		DROP TABLE [#GroupT]
	SELECT 
		[OEMName]
		,[FiscalYearDesc] AS [Item]
		, [SalesAmount]
		, [PERCENTAGE]
	INTO [#GroupT]
	FROM [#CostDetails]
	WHERE 1<>1
			
	
	IF @Timeline = 'Year'
	BEGIN
		INSERT INTO [#GroupT]
		SELECT 
			[OEMName]
			,[FiscalYearDesc] AS [Item]
			, CASE SUM([UnitPrice]*[ShipmentQty]) WHEN 0 THEN NULL ELSE CAST( SUM([UnitPrice]*[ShipmentQty])AS DECIMAL(18,2)) END  AS [SalesAmount]
			, CASE SUM([UnitPrice]*[ShipmentQty]) WHEN 0 THEN NULL ELSE CAST((SUM([BOMEDM]*[ShipmentQty])/SUM([UnitPrice]*[ShipmentQty]))*100 AS DECIMAL(18,2)) END  AS [PERCENTAGE]
		FROM [#CostDetails]
		WHERE  (
					 @StartFY <= [FiscalYear]
				)
				AND(
					 @ENDFY >= [FiscalYear]
				)
		GROUP BY [OEMName], [FiscalYearDesc]
		
	END
	ELSE IF @Timeline = 'Quarter'
	BEGIN
		INSERT INTO [#GroupT]
		SELECT 
			[OEMName]
			,[FiscalYearDesc]+[FiscalQuarterDesc] AS [Item]
			, CASE SUM([UnitPrice]*[ShipmentQty]) WHEN 0 THEN NULL ELSE CAST( SUM([UnitPrice]*[ShipmentQty])AS DECIMAL(18,2)) END  AS [SalesAmount]
			, CASE SUM([UnitPrice]*[ShipmentQty]) WHEN 0 THEN NULL ELSE CAST((SUM([BOMEDM]*[ShipmentQty])/SUM([UnitPrice]*[ShipmentQty]))*100 AS DECIMAL(18,2)) END  AS [PERCENTAGE]
		FROM [#CostDetails]
		WHERE  (
					 @StartFY < [FiscalYear]
					 OR( @StartFY = [FiscalYear]AND @StartQuarter <= [FiscalQuarter])
				)
				AND(
					 @ENDFY > [FiscalYear]
					 OR( @ENDFY = [FiscalYear]AND @ENDQuarter >= [FiscalQuarter])
				)
		GROUP BY [OEMName], [FiscalYearDesc], [FiscalQuarterDesc]
		
	END
	ELSE IF @Timeline = 'Period'
	BEGIN
		INSERT INTO [#GroupT]
		SELECT 
			[OEMName]
			,[FiscalYearDesc]+[FiscalPeriodDesc] AS [Item]
			, CASE SUM([UnitPrice]*[ShipmentQty]) WHEN 0 THEN NULL ELSE CAST( SUM([UnitPrice]*[ShipmentQty])AS DECIMAL(18,2)) END  AS [SalesAmount]
			, CASE SUM([UnitPrice]*[ShipmentQty]) WHEN 0 THEN NULL ELSE CAST((SUM([BOMEDM]*[ShipmentQty])/SUM([UnitPrice]*[ShipmentQty]))*100 AS DECIMAL(18,2)) END  AS [PERCENTAGE]
		FROM [#CostDetails]
		WHERE  (
					 @StartFY < [FiscalYear]
					 OR( @StartFY = [FiscalYear]AND @StartPeriod <= [FiscalPeriod])
				)
				AND(
					 @ENDFY > [FiscalYear]
					 OR( @ENDFY = [FiscalYear]AND @ENDPeriod >= [FiscalPeriod])
				)
		GROUP BY [OEMName], [FiscalYearDesc], [FiscalPeriodDesc]
		
	END
	
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
		   DELETE FROM [#CostDetails] WHERE [OEMName]NOT IN( SELECT [OEMName] FROM [#OEMList])
	END
	
	--OverallPeriod
	IF (select object_ID('tempdb..#OverallPeriod')) >0 
		DROP TABLE [#OverallPeriod]
	SELECT 
		[Item]
	INTO [#OverallPeriod]
	FROM [#GroupT]
	GROUP BY [Item]
	ORDER BY [Item]
	
	DECLARE @BomSQLString VARCHAR(MAX), @PercentageSQLString  VARCHAR(MAX)
	
	--#MAT
	if (select object_ID('tempdb..#MAT')) >0 
		DROP TABLE [#MAT]
	CREATE TABLE #MAT (Project VARCHAR(50))
	SET @BomSQLString=' ALTER TABLE #MAT ADD Item VARCHAR(50) NULL '
	SELECT @BomSQLString=@BomSQLString+ 'ALTER TABLE #MAT ADD [' + [Item] +'] VARCHAR(50) NULL '
	FROM [#OverallPeriod]
	EXEC (@BomSQLString)
	
	DECLARE @a int   
	DECLARE @temp varchar(50)--临时变量，用来保存游标值  
	set @a=1 
	--申明游标 为userid  
	DECLARE order_cursor CURSOR FOR SELECT [OEMName] FROM [#CostDetails] GROUP BY [OEMName]
	--打开游标  
	OPEN order_cursor 
	 FETCH NEXT FROM order_cursor INTO @temp   
	 WHILE @@FETCH_STATUS = 0 --返回被 FETCH  语句执行的最后游标的状态，而不是任何当前被连接打开的游标的状态。  
	  BEGIN  
		--执行sql操作
		
		
		SET @BomSQLString='INSERT INTO #MAT VALUES('''+ @temp +''', ''Revenue'''
		SET @PercentageSQLString='INSERT INTO #MAT VALUES('''+ @temp +''', ''MCOS'''
		
		SELECT  
		  @BomSQLString = @BomSQLString + ', ''' + ISNULL(CONVERT(VARCHAR(50), B.[SalesAmount]), '') + ''''
		  , @PercentageSQLString = @PercentageSQLString + ', ''' + ISNULL(CONVERT(VARCHAR(50), B.[PERCENTAGE]), 'NA') + ''''
		FROM [#OverallPeriod] AS A LEFT JOIN
		(
			SELECT 
				[Item]
				,[SalesAmount]
				,[PERCENTAGE]
			FROM [#GroupT]
			WHERE [OEMName]=@temp
		)AS B
		ON  A.[Item]=B.[Item]
		ORDER BY A.[Item]
		
		
		SET @BomSQLString=@BomSQLString + ')'
		SET @PercentageSQLString=@PercentageSQLString + ')'
		EXEC(@BomSQLString)
		EXEC(@PercentageSQLString)
		
		--开始循环游标变量  
		FETCH NEXT FROM order_cursor INTO @temp  
	   
	  END  

	CLOSE order_cursor--关闭游标  
	DEALLOCATE order_cursor--释放游标 
	
	
	
	
	SELECT * FROM [#MAT]
	----Delete Table
	DROP TABLE [#CostDetails]
	DROP TABLE [#GroupT]
	DROP TABLE [#OverallPeriod]	
	DROP TABLE [#MAT]



END


GO
