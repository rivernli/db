USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_MSS_MSSBookingByTech]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 


CREATE  procedure [dbo].[sp_MSS_MSSBookingByTech]
	@Plant	VARCHAR(10)
as
begin
	--CurrentFiscalDate
	DECLARE @CurrentDay DATETIME
	DECLARE @CurrentFiscalYear VARCHAR(4)
	DECLARE @CurrentFiscalPeriod VARCHAR(2)

	SELECT @CurrentDay=CONVERT(DATETIME, CONVERT(varchar(100), [UpTime] , 112)) FROM [Multek_ZH].[dbo].[MSS_UpTime]
	SELECT @CurrentFiscalYear= substring([FiscalYearDesc],3,4),@CurrentFiscalPeriod=CONVERT(VARCHAR,FiscalPeriod) FROM  [DataWarehouse].[dbo].[DW_DIM_Calender]
	WHERE CalenderDate=@CurrentDay
	
	
	--#BookingByTechnology
	IF (select object_ID('tempdb..#BookingByTechnology')) >0 
		DROP TABLE [#BookingByTechnology]
	SELECT 
		[T$PDAT_FiscalYear]
		,[T$PDAT_FiscalPeriod]
		,[Technology]
		,[Amount]AS Booking
	INTO [#BookingByTechnology]	
	FROM [Multek_ZH].[dbo].[MSS_MSS_ByTechnology]
	WHERE  1!=1

	IF @Plant='ALL'
	BEGIN
		
		--#BookingByTechnology
		INSERT INTO [#BookingByTechnology]
		SELECT 
			[T$PDAT_FiscalYear]
			,[T$PDAT_FiscalPeriod]
			,[Technology]
			,ISNULL(SUM([Booking]), 0) AS Booking
		FROM (
			SELECT 
				[T$PDAT_FiscalYear]
				,[T$PDAT_FiscalPeriod]
				,[Technology]
				,SUM([Amount])AS Booking
			FROM [Multek_ZH].[dbo].[MSS_MSS_ByTechnology]
			WHERE [T$JDAT]=@CurrentDay
				AND(
					[T$PDAT_FiscalYear] > @CurrentFiscalYear
					OR([T$PDAT_FiscalYear] = @CurrentFiscalYear AND [T$PDAT_FiscalPeriod] >= @CurrentFiscalPeriod)
					OR [T$PDAT_FiscalYear] IS NULL --After Period
				)
			GROUP BY [T$PDAT_FiscalYear], [T$PDAT_FiscalPeriod], [Technology]
			UNION ALL--以前期
			SELECT 
				@CurrentFiscalYear AS [T$PDAT_FiscalYear]
				,@CurrentFiscalPeriod AS [T$PDAT_FiscalPeriod]
				,[Technology]
				,SUM([Amount])AS Booking
			FROM [Multek_ZH].[dbo].[MSS_MSS_ByTechnology]
			WHERE [T$JDAT]=@CurrentDay
				AND(
					[T$PDAT_FiscalYear] < @CurrentFiscalYear
					OR([T$PDAT_FiscalYear] = @CurrentFiscalYear AND [T$PDAT_FiscalPeriod] < @CurrentFiscalPeriod)
				)	
			GROUP BY  [Technology]
		)AS T
		GROUP BY [T$PDAT_FiscalYear], [T$PDAT_FiscalPeriod], [Technology]
		
			
	END
	ELSE
	BEGIN
		
		--#BookingByTechnology
		INSERT INTO [#BookingByTechnology]
		SELECT 
			[T$PDAT_FiscalYear]
			,[T$PDAT_FiscalPeriod]
			,[Technology]
			,ISNULL(SUM([Booking]), 0) AS Booking
		FROM (
			SELECT 
				[T$PDAT_FiscalYear]
				,[T$PDAT_FiscalPeriod]
				,[Technology]
				,SUM([Amount])AS Booking
			FROM [Multek_ZH].[dbo].[MSS_MSS_ByTechnology]
			WHERE [T$JDAT]=@CurrentDay
				AND(
					[T$PDAT_FiscalYear] > @CurrentFiscalYear
					OR([T$PDAT_FiscalYear] = @CurrentFiscalYear AND [T$PDAT_FiscalPeriod] >= @CurrentFiscalPeriod)
					OR [T$PDAT_FiscalYear] IS NULL --After Period
				)
				AND [Plant]=@Plant
			GROUP BY [T$PDAT_FiscalYear], [T$PDAT_FiscalPeriod], [Technology]
			UNION ALL--以前期
			SELECT 
				@CurrentFiscalYear AS [T$PDAT_FiscalYear]
				,@CurrentFiscalPeriod AS [T$PDAT_FiscalPeriod]
				,[Technology]
				,SUM([Amount])AS Booking
			FROM [Multek_ZH].[dbo].[MSS_MSS_ByTechnology]
			WHERE [T$JDAT]=@CurrentDay
				AND(
					[T$PDAT_FiscalYear] < @CurrentFiscalYear
					OR([T$PDAT_FiscalYear] = @CurrentFiscalYear AND [T$PDAT_FiscalPeriod] < @CurrentFiscalPeriod)
				)
				AND [Plant]=@Plant	
			GROUP BY  [Technology]
		)AS T
		GROUP BY [T$PDAT_FiscalYear], [T$PDAT_FiscalPeriod], [Technology]
	
	END
	
	
	
	--OverallPeriod
	IF (select object_ID('tempdb..#OverallPeriod')) >0 
		DROP TABLE [#OverallPeriod]
	SELECT [T$PDAT_FiscalYear] AS FiscalYear
		  ,[T$PDAT_FiscalPeriod] AS FiscalPeriod
	INTO #OverallPeriod
	FROM [#BookingByTechnology]
	WHERE  [T$PDAT_FiscalYear] != 2099 
	GROUP BY [T$PDAT_FiscalYear], [T$PDAT_FiscalPeriod]
	ORDER BY [T$PDAT_FiscalYear], [T$PDAT_FiscalPeriod]

	DECLARE @BookingSQLString VARCHAR(MAX),  @TargetSQLString  VARCHAR(MAX),  @GapSQLString  VARCHAR(MAX), @AheadSQLString  VARCHAR(MAX)
	DECLARE @BookingTotal NUMERIC(19,4) ,@BookingBuffer NUMERIC(19,4),@BookingAfter NUMERIC(19,4), @Target NUMERIC(19,4), @Gap NUMERIC(19,4)
	
	--#BookingStatus
	IF (select object_ID('tempdb..#BookingStatus')) >0 
		DROP TABLE [#BookingStatus]
	CREATE TABLE #BookingStatus ([Item] VARCHAR(50))
	SET @BookingSQLString=' ALTER TABLE #BookingStatus ADD [Technology] VARCHAR(50) NULL '
	SELECT @BookingSQLString=@BookingSQLString+ 'ALTER TABLE #BookingStatus ADD [' + dbo.fun_Get_Full_Period_Name([FiscalYear], [FiscalPeriod]) + '] NUMERIC(19,4) NULL '
	FROM #OverallPeriod
	EXEC (@BookingSQLString)
	ALTER TABLE #BookingStatus ADD [After Period] NUMERIC(19,4) NULL
	ALTER TABLE #BookingStatus ADD [Buffer Order] NUMERIC(19,4) NULL
	ALTER TABLE #BookingStatus ADD Overall NUMERIC(19,4) NULL
	ALTER TABLE #BookingStatus DROP COLUMN [Item]
	
	
	
	
	DECLARE @a int   
	DECLARE @temp varchar(50)--临时变量，用来保存游标值  
	set @a=1 
	--申明游标 为userid  
	DECLARE order_cursor CURSOR FOR SELECT [Technology] FROM [#BookingByTechnology] GROUP BY [Technology] 
	--打开游标  
	OPEN order_cursor 
	 FETCH NEXT FROM order_cursor INTO @temp   
	 WHILE @@FETCH_STATUS = 0 --返回被 FETCH  语句执行的最后游标的状态，而不是任何当前被连接打开的游标的状态。  
	  BEGIN  
		--执行sql操作
		SET @BookingAfter=0
		SET @BookingBuffer=0
		SET @BookingSQLString='INSERT INTO #BookingStatus VALUES('''+ @temp +''''
		IF @temp IS NULL
		BEGIN
			SET @BookingSQLString='INSERT INTO #BookingStatus VALUES(''NULL'''
			SELECT  
			  @BookingSQLString=@BookingSQLString+', ' + CONVERT(VARCHAR(50),CAST(ISNULL([Booking],0)AS NUMERIC(19,4)))
			FROM #OverallPeriod AS A LEFT JOIN
			(
				SELECT [T$PDAT_FiscalYear]
				  ,[T$PDAT_FiscalPeriod]
				  ,SUM([Booking])AS Booking
				FROM [#BookingByTechnology]
				WHERE [Technology] IS NULL
				GROUP BY [T$PDAT_FiscalYear],[T$PDAT_FiscalPeriod] 
			)AS B
			ON  A.[FiscalYear]=B.[T$PDAT_FiscalYear] AND A.[FiscalPeriod]=B.[T$PDAT_FiscalPeriod]
			ORDER BY A.FiscalYear,A.FiscalPeriod

			-- Overall 
			SELECT  
			  @BookingTotal=ISNULL(SUM([Booking]),0)
			FROM [#BookingByTechnology]
			WHERE [Technology] IS NULL

			-- Buffer 
			SELECT @BookingBuffer=ISNULL(SUM([Booking]),0)
			FROM [#BookingByTechnology]
			WHERE [Technology]  IS NULL	
			AND [T$PDAT_FiscalYear] = '2099' AND [T$PDAT_FiscalPeriod] = 1

			-- After 
			SELECT @BookingAfter=ISNULL(SUM([Booking]),0)
			FROM  [#BookingByTechnology]
			WHERE [Technology]  IS NULL 	
			AND [T$PDAT_FiscalYear] IS NULL
		END
		ELSE
		BEGIN
			SELECT  
			  @BookingSQLString=@BookingSQLString+', ' + CONVERT(VARCHAR(50),CAST(ISNULL([Booking],0)AS NUMERIC(19,4)))
			FROM #OverallPeriod AS A LEFT JOIN
			(
				SELECT [T$PDAT_FiscalYear]
				  ,[T$PDAT_FiscalPeriod]
				  ,SUM([Booking])AS Booking
				FROM [#BookingByTechnology]
				WHERE [Technology]=@temp
				GROUP BY [T$PDAT_FiscalYear],[T$PDAT_FiscalPeriod] 
			)AS B
			ON  A.[FiscalYear]=B.[T$PDAT_FiscalYear] AND A.[FiscalPeriod]=B.[T$PDAT_FiscalPeriod]
			ORDER BY A.FiscalYear,A.FiscalPeriod

			-- Overall 
			SELECT  
			  @BookingTotal=ISNULL(SUM([Booking]),0)
			FROM [#BookingByTechnology]
			WHERE [Technology] = @temp 

			-- Buffer 
			SELECT @BookingBuffer=ISNULL(SUM([Booking]),0)
			FROM [#BookingByTechnology]
			WHERE [Technology]=@temp 	
			AND [T$PDAT_FiscalYear] = '2099' AND [T$PDAT_FiscalPeriod] = 1

			-- After 
			SELECT @BookingAfter=ISNULL(SUM([Booking]),0)
			FROM  [#BookingByTechnology]
			WHERE [Technology]=@temp 	
			AND [T$PDAT_FiscalYear] IS NULL
		END

		
		SET @BookingSQLString=@BookingSQLString+ ', '+ CONVERT(VARCHAR(50),@BookingAfter)+ ', '+ CONVERT(VARCHAR(50),@BookingBuffer)+ ', '+ CONVERT(VARCHAR(50),@BookingTotal)+ ')'
		EXEC(@BookingSQLString)
		
		--开始循环游标变量  
		FETCH NEXT FROM order_cursor INTO @temp  
	   
	  END  

	CLOSE order_cursor--关闭游标  
	DEALLOCATE order_cursor--释放游标 




	--Total
	SET @Target=0
	SET @Gap=0
	SET @BookingBuffer =0

	SET @BookingSQLString='INSERT INTO #BookingStatus VALUES(''MSS Total'''
	SET @TargetSQLString='INSERT INTO #BookingStatus VALUES(''Finance FCST'''
	SET @GapSQLString='INSERT INTO #BookingStatus VALUES(''Gap'''
	SELECT
		  @BookingSQLString=@BookingSQLString+ ', ' +CONVERT(VARCHAR(50),CAST(ISNULL([Booking],0)AS NUMERIC(19,4)))
		  ,@TargetSQLString=@TargetSQLString+ ', ' +CONVERT(VARCHAR(50),CAST(ISNULL([Forecast],0)AS NUMERIC(19,4)))
		  ,@Target=@Target+ ISNULL([Forecast],0)
		  ,@GapSQLString=@GapSQLString+ ', ' + (CASE WHEN [Forecast] IS NULL THEN '0' ELSE CONVERT(VARCHAR(50),CAST(ISNULL([Booking],0) - ISNULL([Forecast],0)AS NUMERIC(19,4))) END)
		  ,@Gap= @Gap+ (CASE WHEN [Forecast] IS NULL THEN 0 ELSE ISNULL([Booking],0) - ISNULL([Forecast],0) END)
	FROM #OverallPeriod AS A LEFT JOIN
	(
		SELECT [T$PDAT_FiscalYear]
			  ,[T$PDAT_FiscalPeriod]
			  ,SUM([Booking]) AS Booking
		FROM [#BookingByTechnology]
		GROUP BY [T$PDAT_FiscalYear],[T$PDAT_FiscalPeriod]
	)AS B
	ON  A.[FiscalYear]=B.[T$PDAT_FiscalYear]
	AND A.[FiscalPeriod]=B.[T$PDAT_FiscalPeriod]
	LEFT JOIN [MSS_Forecast] AS C
	ON  A.[FiscalYear]=substring(C.[FYear],3,4)
		AND A.[FiscalPeriod]=C.[Period]
		AND C.[Plant]=''
		AND C.[Type]='Shipment'
	ORDER BY A.FiscalYear,A.FiscalPeriod

	--Booking Overall 
	SELECT @BookingTotal=SUM([Booking])
	FROM [#BookingByTechnology]
	
	--Booking Buffer Order 
	SELECT @BookingBuffer =ISNULL(SUM([Booking]),0)
	FROM [#BookingByTechnology]
	WHERE [T$PDAT_FiscalYear] = '2099' AND [T$PDAT_FiscalPeriod] = 1
			
	--Booking After
	SELECT @BookingAfter=ISNULL(SUM([Booking]),0)
	FROM [#BookingByTechnology]
	WHERE [T$PDAT_FiscalYear] IS NULL
	
	
	SET @BookingSQLString=@BookingSQLString+ ', '+ CONVERT(VARCHAR(50),@BookingAfter)+ ', '+ CONVERT(VARCHAR(50),@BookingBuffer)+ ', '+ CONVERT(VARCHAR(50),@BookingTotal)+ ')'
	SET @TargetSQLString=@TargetSQLString+ ', 0, 0, '+ CONVERT(VARCHAR(50),@Target)+ ')'
	SET @GapSQLString=@GapSQLString+ ', 0, 0, '+ CONVERT(VARCHAR(50),@Gap)+ ')'
	
	EXEC(@BookingSQLString)
	EXEC(@TargetSQLString)
	EXEC(@GapSQLString)


	SELECT * FROM [#BookingStatus]

	----Delete Table
	DROP TABLE [#OverallPeriod]	
	DROP TABLE [#BookingStatus]

	
END









GO
