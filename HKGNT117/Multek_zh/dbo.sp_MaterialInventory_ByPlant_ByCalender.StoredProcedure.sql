USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_MaterialInventory_ByPlant_ByCalender]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


Create PROCEDURE [dbo].[sp_MaterialInventory_ByPlant_ByCalender] 
	@Timeline   nvarchar(10)
	,@StartFY int
	,@StartQuarter int
	,@StartPeriod int
	,@EndFY int
	,@EndQuarter int
	,@EndPeriod int
AS
BEGIN
	SET NOCOUNT ON;


	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#GroupT') AND TYPE = 'U')
		DROP TABLE [#GroupT]

	-- GET TABLE STRUCTURE
	SELECT 
		[Plant]
		,[FiscalDesc]AS [Item]
		,[Amount]
	INTO [#GroupT]
	FROM [Multek_ZH].[dbo].[MaterialInventory_ByType]
	WHERE 1 <> 1
	

	IF @Timeline = 'Quarter'
		BEGIN
			INSERT INTO [#GroupT]
			SELECT 
				[Plant]
				,[QuarterDesc]AS [Item]
				,CAST( SUM([Amount])AS DECIMAL(18,2))AS [Amount]
			FROM [Multek_ZH].[dbo].[MaterialInventory_ByType]
			WHERE  (
						 @StartFY < [Year]
						 OR( @StartFY = [Year]AND @StartQuarter <= [Quarter])
					)
					AND(
						 @EndFY > [Year]
						 OR( @EndFY = [Year]AND @EndQuarter >= [Quarter])
					)
			GROUP BY [Plant], [QuarterDesc]
			
		END
	ELSE IF @Timeline = 'Period'
		BEGIN
			INSERT INTO [#GroupT]
			SELECT 
				[Plant]
				,[MonthDesc]AS [Item]
				,CAST( SUM([Amount])AS DECIMAL(18,2))AS [Amount]
			FROM [Multek_ZH].[dbo].[MaterialInventory_ByType]
			WHERE  (
						 @StartFY < [Year]
						 OR( @StartFY = [Year]AND @StartPeriod <= [Month])
					)
					AND(
						 @EndFY > [Year]
						 OR( @EndFY = [Year]AND @EndPeriod >= [Month])
					)
			GROUP BY [Plant], [MonthDesc]
			
		END
	ELSE IF @Timeline = 'Date'
		BEGIN
			INSERT INTO [#GroupT]
			SELECT 
				[Plant]
				,[DateDesc]AS [Item]
				,CAST( SUM([Amount])AS DECIMAL(18,2))AS [Amount]
			FROM [Multek_ZH].[dbo].[MaterialInventory_ByType]
			WHERE  @StartFY = [Year]
				 AND @StartPeriod = [Month]
			GROUP BY [Plant], [DateDesc]
			
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
	
	DECLARE @SQLString VARCHAR(MAX)
	
	--#MAT
	if (select object_ID('tempdb..#MAT')) >0 
		DROP TABLE [#MAT]
	CREATE TABLE #MAT ([Plant] VARCHAR(50))
	SET @SQLString=' '
	SELECT @SQLString=@SQLString+ 'ALTER TABLE #MAT ADD [' + [Item] +'] DECIMAL(18,2) NULL '
	FROM [#OverallPeriod]
	EXEC (@SQLString)
	
	DECLARE @a int   
	DECLARE @temp varchar(50)--临时变量，用来保存游标值  
	set @a=1 
	--申明游标 为userid  
	DECLARE order_cursor CURSOR FOR SELECT [Plant] FROM [#GroupT] GROUP BY [Plant]
	--打开游标  
	OPEN order_cursor 
	 FETCH NEXT FROM order_cursor INTO @temp   
	 WHILE @@FETCH_STATUS = 0 --返回被 FETCH  语句执行的最后游标的状态，而不是任何当前被连接打开的游标的状态。  
	  BEGIN  
		--执行sql操作
		
		
		SET @SQLString='INSERT INTO #MAT VALUES('''+ @temp +''''
		
		SELECT  
		  @SQLString = @SQLString + ', ' + ISNULL(CONVERT(VARCHAR(50), B.[Amount]), '') 
		FROM [#OverallPeriod] AS A LEFT JOIN
		(
			SELECT 
				[Item]
				,[Amount]
			FROM [#GroupT]
			WHERE [Plant]=@temp
		)AS B
		ON  A.[Item]=B.[Item]
		ORDER BY A.[Item]
		
		SET @SQLString=@SQLString + ')'
		EXEC(@SQLString)
		
		--开始循环游标变量  
		FETCH NEXT FROM order_cursor INTO @temp  
	   
	  END  

	CLOSE order_cursor--关闭游标  
	DEALLOCATE order_cursor--释放游标 
	
	SET @SQLString='INSERT INTO #MAT VALUES(''Total'''
	SELECT  
	  @SQLString = @SQLString + ', ' + ISNULL(CONVERT(VARCHAR(50), B.[Amount]), '')
	FROM [#OverallPeriod] AS A LEFT JOIN
	(
		SELECT 
			[Item]
			,SUM([Amount])AS [Amount]
		FROM [#GroupT]
		GROUP BY [Item]
	)AS B
	ON  A.[Item]=B.[Item]
	ORDER BY A.[Item]
	
	
	SET @SQLString=@SQLString + ')'
	EXEC(@SQLString)
	
	SELECT * FROM [#MAT]
	----Delete Table
	DROP TABLE [#GroupT]
	DROP TABLE [#OverallPeriod]	
	DROP TABLE [#MAT]

END


GO
