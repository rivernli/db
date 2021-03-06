USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_MaterialInventory_ByType_ByCalender]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_MaterialInventory_ByType_ByCalender] 
	@Plant nvarchar(10)
	,@Category nvarchar(10)
	,@Timeline   nvarchar(10)
	,@StartFY int
	,@StartQuarter int
	,@StartPeriod int
	,@EndFY int
	,@EndQuarter int
	,@EndPeriod int
AS
BEGIN
	SET NOCOUNT ON;
	
	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#DetailT') AND TYPE = 'U')
		DROP TABLE [#DetailT]
	-- GET TABLE STRUCTURE
	SELECT 
		[Type]
		,[Description]
		,[Date]
		,[Year]
		,[Quarter]
		,[Month]
		,[QuarterDesc]
		,[MonthDesc]
		,[DateDesc]
		,[FiscalYear]
		,[FiscalQuarter]
		,[FiscalPeriod]
		,[FiscalQuarterDesc]
		,[FiscalPeriodDesc]
		,[FiscalDesc]
		,[Amount]
	INTO [#DetailT]
	FROM [Multek_ZH].[dbo].[MaterialInventory_ByType]
	WHERE 1 <> 1
	
	IF @Plant='ALL'
		BEGIN
			IF @Category='ALL'
				BEGIN
					INSERT INTO  [#DetailT]
					SELECT 
						[Type]
						,[Description]
						,[Date]
						,[Year]
						,[Quarter]
						,[Month]
						,[QuarterDesc]
						,[MonthDesc]
						,[DateDesc]
						,[FiscalYear]
						,[FiscalQuarter]
						,[FiscalPeriod]
						,[FiscalQuarterDesc]
						,[FiscalPeriodDesc]
						,[FiscalDesc]
						,[Amount]
					FROM [Multek_ZH].[dbo].[MaterialInventory_ByType]
				END
			ELSE IF @Category='BOM+EDM'
				BEGIN
					INSERT INTO  [#DetailT]
					SELECT 
						[Type]
						,[Description]
						,[Date]
						,[Year]
						,[Quarter]
						,[Month]
						,[QuarterDesc]
						,[MonthDesc]
						,[DateDesc]
						,[FiscalYear]
						,[FiscalQuarter]
						,[FiscalPeriod]
						,[FiscalQuarterDesc]
						,[FiscalPeriodDesc]
						,[FiscalDesc]
						,[Amount]
					FROM [Multek_ZH].[dbo].[MaterialInventory_ByType]
					WHERE [Category]='BOM' OR [Category]='EDM'
				END
			ELSE
				BEGIN
					INSERT INTO  [#DetailT]
					SELECT 
						[Type]
						,[Description]
						,[Date]
						,[Year]
						,[Quarter]
						,[Month]
						,[QuarterDesc]
						,[MonthDesc]
						,[DateDesc]
						,[FiscalYear]
						,[FiscalQuarter]
						,[FiscalPeriod]
						,[FiscalQuarterDesc]
						,[FiscalPeriodDesc]
						,[FiscalDesc]
						,[Amount]
					FROM [Multek_ZH].[dbo].[MaterialInventory_ByType]
					WHERE [Category]=@Category
				END
		
		END
	ELSE
		BEGIN
			IF @Category='ALL'
				BEGIN
					INSERT INTO  [#DetailT]
					SELECT 
						[Type]
						,[Description]
						,[Date]
						,[Year]
						,[Quarter]
						,[Month]
						,[QuarterDesc]
						,[MonthDesc]
						,[DateDesc]
						,[FiscalYear]
						,[FiscalQuarter]
						,[FiscalPeriod]
						,[FiscalQuarterDesc]
						,[FiscalPeriodDesc]
						,[FiscalDesc]
						,[Amount]
					FROM [Multek_ZH].[dbo].[MaterialInventory_ByType]
					WHERE [Plant]= @Plant
				END
			ELSE IF @Category='BOM+EDM'
				BEGIN
					INSERT INTO  [#DetailT]
					SELECT 
						[Type]
						,[Description]
						,[Date]
						,[Year]
						,[Quarter]
						,[Month]
						,[QuarterDesc]
						,[MonthDesc]
						,[DateDesc]
						,[FiscalYear]
						,[FiscalQuarter]
						,[FiscalPeriod]
						,[FiscalQuarterDesc]
						,[FiscalPeriodDesc]
						,[FiscalDesc]
						,[Amount]
					FROM [Multek_ZH].[dbo].[MaterialInventory_ByType]
					WHERE [Plant]= @Plant AND ([Category]='BOM' OR [Category]='EDM')
				END
			ELSE
				BEGIN
					INSERT INTO  [#DetailT]
					SELECT 
						[Type]
						,[Description]
						,[Date]
						,[Year]
						,[Quarter]
						,[Month]
						,[QuarterDesc]
						,[MonthDesc]
						,[DateDesc]
						,[FiscalYear]
						,[FiscalQuarter]
						,[FiscalPeriod]
						,[FiscalQuarterDesc]
						,[FiscalPeriodDesc]
						,[FiscalDesc]
						,[Amount]
					FROM [Multek_ZH].[dbo].[MaterialInventory_ByType]
					WHERE [Plant]= @Plant AND [Category]=@Category
				END
		END
		


	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#GroupT') AND TYPE = 'U')
		DROP TABLE [#GroupT]

	-- GET TABLE STRUCTURE
	SELECT 
		[Type]
		,[FiscalDesc]AS [Item]
		,[Amount]
	INTO [#GroupT]
	FROM [#DetailT]
	WHERE 1 <> 1
	

	IF @Timeline = 'Quarter'
		BEGIN
			INSERT INTO [#GroupT]
			SELECT 
				[Type]
				,[QuarterDesc]AS [Item]
				,CAST( SUM([Amount])AS DECIMAL(18,2))AS [Amount]
			FROM [#DetailT]
			WHERE  (
						 @StartFY < [Year]
						 OR( @StartFY = [Year]AND @StartQuarter <= [Quarter])
					)
					AND(
						 @EndFY > [Year]
						 OR( @EndFY = [Year]AND @EndQuarter >= [Quarter])
					)
			GROUP BY [Type], [QuarterDesc]
			
		END
	ELSE IF @Timeline = 'Period'
		BEGIN
			INSERT INTO [#GroupT]
			SELECT 
				[Type]
				,[MonthDesc]AS [Item]
				,CAST( SUM([Amount])AS DECIMAL(18,2))AS [Amount]
			FROM [#DetailT]
			WHERE  (
						 @StartFY < [Year]
						 OR( @StartFY = [Year]AND @StartPeriod <= [Month])
					)
					AND(
						 @EndFY > [Year]
						 OR( @EndFY = [Year]AND @EndPeriod >= [Month])
					)
			GROUP BY [Type], [MonthDesc]
			
		END
	ELSE IF @Timeline = 'Date'
		BEGIN
			INSERT INTO [#GroupT]
			SELECT 
				[Type]
				,[DateDesc]AS [Item]
				,CAST( SUM([Amount])AS DECIMAL(18,2))AS [Amount]
			FROM [#DetailT]
			WHERE  @StartFY = [Year]
				 AND @StartPeriod = [Month]
			GROUP BY [Type], [DateDesc]
			
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
	CREATE TABLE #MAT ([Type] VARCHAR(50))
	SET @SQLString=' '
	SELECT @SQLString=@SQLString+ 'ALTER TABLE #MAT ADD [' + [Item] +'] DECIMAL(18,2) NULL '
	FROM [#OverallPeriod]
	EXEC (@SQLString)
	
	DECLARE @a int   
	DECLARE @temp varchar(50)--临时变量，用来保存游标值  
	set @a=1 
	--申明游标 为userid  
	DECLARE order_cursor CURSOR FOR SELECT [Type] FROM [#GroupT] GROUP BY [Type]
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
			WHERE [Type]=@temp
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
	DROP TABLE [#DetailT]
	DROP TABLE [#GroupT]
	DROP TABLE [#OverallPeriod]	
	DROP TABLE [#MAT]

END


GO
