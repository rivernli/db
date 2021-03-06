USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[sp_Exr2_MCOSinComparison]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Exr2_MCOSinComparison]
	@PercentageType   nvarchar(20),
	@Project nvarchar(300),
	@StartFY nvarchar(10),
	@StartPeriod nvarchar(10),
	@EndFY nvarchar(10),
	@EndPeriod nvarchar(10),
    @UserId  nvarchar(50)
AS
BEGIN

	SET NOCOUNT ON;
	DECLARE @sqlString nvarchar(1000)
	DECLARE @BomString nvarchar(1000)


	IF (select object_ID('tempdb..#CostDetails')) >0 
		DROP TABLE [#CostDetails]

	-- GET TABLE STRUCTURE
	SELECT 
		[Project]
		,[FiscalYear]
		,[FiscalPeriod]
		,[ShipmentQty]
		,[UnitPrice]
		,[Bom]AS [BOMEDM]
		,[BomPercentage]AS [Percentage]
		,[ScrapRate]
	INTO [#CostDetails]
	FROM [Exr2_MATPercentage_ByProject] WHERE 1 <> 1


	
	--Percentage
	IF @PercentageType = 'Yield'
		BEGIN
			INSERT INTO [#CostDetails]
			SELECT 
				[Project]
				,[FiscalYear]
				,[FiscalPeriod]
				,[ShipmentQty]
				,[UnitPrice]
				,[Bom]AS [BOMEDM]
				,[BomPercentage]AS [Percentage]
				,[ScrapRate]
			FROM [Exr2_MATPercentage_ByProject]
			WHERE [Project] IN ( SELECT  col   FROM   [Multek_ZH].dbo.f_split(@Project,','))  -- 分割字符串 
					AND(
						 @StartFY < [FiscalYear]
						 OR( @StartFY = [FiscalYear]AND @StartPeriod <= [FiscalPeriod])
					)
					AND(
						 @EndFY > [FiscalYear]
						 OR( @EndFY = [FiscalYear]AND @EndPeriod >= [FiscalPeriod])
					)
			SET @BomString='Bom Yielded'
		END
	IF @PercentageType = '100%Yield'
		BEGIN
			INSERT INTO [#CostDetails]
			SELECT 
				[Project]
				,[FiscalYear]
				,[FiscalPeriod]
				,[ShipmentQty]
				,[UnitPrice]
				,[Bom100]AS [BOMEDM]
				,[Bom100Percentage]AS [Percentage]
				,NULL AS [ScrapRate]
			FROM [Exr2_MATPercentage_ByProject]
			WHERE [Project] IN ( SELECT  col   FROM   [Multek_ZH].dbo.f_split(@Project,','))  -- 分割字符串 
					AND(
						 @StartFY < [FiscalYear]
						 OR( @StartFY = [FiscalYear]AND @StartPeriod <= [FiscalPeriod])
					)
					AND(
						 @EndFY > [FiscalYear]
						 OR( @EndFY = [FiscalYear]AND @EndPeriod >= [FiscalPeriod])
					)
			SET @BomString='Bom 100% Yielded'
		END
	IF @PercentageType = '+EDMYield'
		BEGIN
			INSERT INTO [#CostDetails]
			SELECT 
				[Project]
				,[FiscalYear]
				,[FiscalPeriod]
				,[ShipmentQty]
				,[UnitPrice]
				,[BOM+EDM]AS [BOMEDM]
				,[Bom+EDMPercentage]AS [Percentage]
				,[ScrapRate]
			FROM [Exr2_MATPercentage_ByProject]
			WHERE [Project] IN ( SELECT  col   FROM   [Multek_ZH].dbo.f_split(@Project,','))  -- 分割字符串 
					AND(
						 @StartFY < [FiscalYear]
						 OR( @StartFY = [FiscalYear]AND @StartPeriod <= [FiscalPeriod])
					)
					AND(
						 @EndFY > [FiscalYear]
						 OR( @EndFY = [FiscalYear]AND @EndPeriod >= [FiscalPeriod])
					)
			SET @BomString='Bom +EDM Yielded'
		END
	IF @PercentageType = '+EDM100%Yield'
		BEGIN
			INSERT INTO [#CostDetails]
			SELECT 
				[Project]
				,[FiscalYear]
				,[FiscalPeriod]
				,[ShipmentQty]
				,[UnitPrice]
				,[BOM+EDM100]AS [BOMEDM]
				,[Bom+EDM100Percentage]AS [Percentage]
				,NULL AS [ScrapRate]
			FROM [Exr2_MATPercentage_ByProject]
			WHERE [Project] IN ( SELECT  col   FROM   [Multek_ZH].dbo.f_split(@Project,','))  -- 分割字符串 
					AND(
						 @StartFY < [FiscalYear]
						 OR( @StartFY = [FiscalYear]AND @StartPeriod <= [FiscalPeriod])
					)
					AND(
						 @EndFY > [FiscalYear]
						 OR( @EndFY = [FiscalYear]AND @EndPeriod >= [FiscalPeriod])
					)
			SET @BomString='Bom +EDM 100% Yielded'
		END
		
		
		
	--OverallPeriod
	IF (select object_ID('tempdb..#OverallPeriod')) >0 
		DROP TABLE [#OverallPeriod]
	SELECT 
		[FiscalYear]
		,[FiscalPeriod]
	INTO [#OverallPeriod]
	FROM [#CostDetails]
	GROUP BY [FiscalYear],[FiscalPeriod]
	ORDER BY [FiscalYear],[FiscalPeriod]

	DECLARE @BomSQLString VARCHAR(MAX), @PriceSQLString  VARCHAR(MAX), @PercentageSQLString  VARCHAR(MAX), @ScrapRateSQLString  VARCHAR(MAX)
	
	--#MAT
	if (select object_ID('tempdb..#MAT')) >0 
		DROP TABLE [#MAT]
	CREATE TABLE #MAT (Project VARCHAR(50))
	SET @BomSQLString=' ALTER TABLE #MAT ADD Item VARCHAR(50) NULL '
	SELECT @BomSQLString=@BomSQLString+ 'ALTER TABLE #MAT ADD [' +dbo.fun_Get_Full_Period_Name([FiscalPeriod])+'-'+CONVERT(VARCHAR(4),[FiscalYear])+'] VARCHAR(50) NULL '
	FROM [#OverallPeriod]
	EXEC (@BomSQLString)
	
	
	
	DECLARE @a int   
	DECLARE @temp varchar(50)--临时变量，用来保存游标值  
	set @a=1 
	--申明游标 为userid  
	DECLARE order_cursor CURSOR FOR SELECT [Project] FROM [#CostDetails] GROUP BY [Project]
	--打开游标  
	OPEN order_cursor 
	 FETCH NEXT FROM order_cursor INTO @temp   
	 WHILE @@FETCH_STATUS = 0 --返回被 FETCH  语句执行的最后游标的状态，而不是任何当前被连接打开的游标的状态。  
	  BEGIN  
		--执行sql操作
		
		SET @ScrapRateSQLString='INSERT INTO #MAT VALUES('''+ @temp +''', ''Yielded'''
		SET @BomSQLString='INSERT INTO #MAT VALUES('''+ @temp +''', ''' + @BomString +''''
		SET @PriceSQLString='INSERT INTO #MAT VALUES('''+ @temp +''', ''Unit Selling Price'''
		SET @PercentageSQLString='INSERT INTO #MAT VALUES('''+ @temp +''', ''MAT Only Percentage'''
		
		SELECT  
		  @ScrapRateSQLString= @ScrapRateSQLString + ', ''' + ISNULL(CONVERT(VARCHAR(50), B.[ScrapRate]), '') + ''''
		  , @BomSQLString = @BomSQLString + ', ''' + ISNULL(CONVERT(VARCHAR(50), B.[BOMEDM]), '') + ''''
		  , @PriceSQLString = @PriceSQLString + ', ''' + ISNULL(CONVERT(VARCHAR(50), B.[UnitPrice]), '') + ''''
		  , @PercentageSQLString = @PercentageSQLString + ', ''' + ISNULL(CONVERT(VARCHAR(50), B.[Percentage]), 'NA') + ''''
		FROM [#OverallPeriod] AS A LEFT JOIN
		(
			SELECT 
				[FiscalYear]
				,[FiscalPeriod]
				,[UnitPrice]
				,[BOMEDM]
				,[Percentage]
				,[ScrapRate]
			FROM [#CostDetails]
			WHERE [Project]=@temp
		)AS B
		ON  A.[FiscalYear]=B.[FiscalYear] 
			AND A.[FiscalPeriod]=B.[FiscalPeriod]
		ORDER BY A.[FiscalYear], A.[FiscalPeriod]
		
		SET @ScrapRateSQLString= @ScrapRateSQLString + ')'
		SET @BomSQLString=@BomSQLString + ')'
		SET @PriceSQLString=@PriceSQLString + ')'
		SET @PercentageSQLString=@PercentageSQLString + ')'
		EXEC(@ScrapRateSQLString)
		EXEC(@BomSQLString)
		EXEC(@PriceSQLString)
		EXEC(@PercentageSQLString)
		
		--开始循环游标变量  
		FETCH NEXT FROM order_cursor INTO @temp  
	   
	  END  

	CLOSE order_cursor--关闭游标  
	DEALLOCATE order_cursor--释放游标 
	



   
	SELECT * FROM [#MAT]
	----Delete Table
	DROP TABLE [#CostDetails]
	DROP TABLE [#OverallPeriod]	
	DROP TABLE [#MAT]

END



GO
