USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_MSS_MSSBookingByOrder]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 


CREATE  procedure [dbo].[sp_MSS_MSSBookingByOrder]
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

	
	--#BookingByOrderType
	IF (select object_ID('tempdb..#BookingByOrderType')) >0 
		DROP TABLE [#BookingByOrderType]
	SELECT 
		[T$PDAT_FiscalYear]
		,[T$PDAT_FiscalPeriod]
		,[OrderType]
		,[Amount]AS Booking
	INTO [#BookingByOrderType]
	FROM [MSS_MSS_ByOrder]
	WHERE  1!=1
	
	IF @Plant='ALL'
	BEGIN
		
		--#BookingByOrderType
		INSERT INTO [#BookingByOrderType]
		SELECT 
			[T$PDAT_FiscalYear]
			,[T$PDAT_FiscalPeriod]
			,[OrderType]
			,ISNULL(SUM([Booking]), 0) AS Booking
		FROM (
			SELECT 
				[T$PDAT_FiscalYear]
				,[T$PDAT_FiscalPeriod]
				,[OrderType]
				,SUM([Amount])AS Booking
			FROM [MSS_MSS_ByOrder]
			WHERE [T$JDAT]=@CurrentDay
				AND(
					[T$PDAT_FiscalYear] > @CurrentFiscalYear
					OR([T$PDAT_FiscalYear] = @CurrentFiscalYear AND [T$PDAT_FiscalPeriod] >= @CurrentFiscalPeriod)
					OR [T$PDAT_FiscalYear] IS NULL --After Period
				)
			GROUP BY [T$PDAT_FiscalYear], [T$PDAT_FiscalPeriod], [OrderType]
			UNION ALL--以前期
			SELECT 
				@CurrentFiscalYear AS [T$PDAT_FiscalYear]
				,@CurrentFiscalPeriod AS [T$PDAT_FiscalPeriod]
				,[OrderType]
				,SUM([Amount])AS Booking
			FROM [MSS_MSS_ByOrder]
			WHERE [T$JDAT]=@CurrentDay
				AND(
					[T$PDAT_FiscalYear] < @CurrentFiscalYear
					OR([T$PDAT_FiscalYear] = @CurrentFiscalYear AND [T$PDAT_FiscalPeriod] < @CurrentFiscalPeriod)
				)	
			GROUP BY  [OrderType]
		)AS T
		GROUP BY [T$PDAT_FiscalYear], [T$PDAT_FiscalPeriod], [OrderType]
		
			
	END
	ELSE
	BEGIN
		
		--#BookingByOrderType
		INSERT INTO [#BookingByOrderType]
		SELECT 
			[T$PDAT_FiscalYear]
			,[T$PDAT_FiscalPeriod]
			,[OrderType]
			,ISNULL(SUM([Booking]), 0) AS Booking
		FROM (
			SELECT 
				[T$PDAT_FiscalYear]
				,[T$PDAT_FiscalPeriod]
				,[OrderType]
				,SUM([Amount])AS Booking
			FROM [MSS_MSS_ByOrder]
			WHERE [T$JDAT]=@CurrentDay
				AND(
					[T$PDAT_FiscalYear] > @CurrentFiscalYear
					OR([T$PDAT_FiscalYear] = @CurrentFiscalYear AND [T$PDAT_FiscalPeriod] >= @CurrentFiscalPeriod)
					OR [T$PDAT_FiscalYear] IS NULL --After Period
				)
				AND [Plant]=@Plant
			GROUP BY [T$PDAT_FiscalYear], [T$PDAT_FiscalPeriod], [OrderType]
			UNION ALL--以前期
			SELECT 
				@CurrentFiscalYear AS [T$PDAT_FiscalYear]
				,@CurrentFiscalPeriod AS [T$PDAT_FiscalPeriod]
				,[OrderType]
				,SUM([Amount])AS Booking
			FROM [MSS_MSS_ByOrder]
			WHERE [T$JDAT]=@CurrentDay
				AND(
					[T$PDAT_FiscalYear] < @CurrentFiscalYear
					OR([T$PDAT_FiscalYear] = @CurrentFiscalYear AND [T$PDAT_FiscalPeriod] < @CurrentFiscalPeriod)
				)
				AND [Plant]=@Plant	
			GROUP BY  [OrderType]
		)AS T
		GROUP BY [T$PDAT_FiscalYear], [T$PDAT_FiscalPeriod], [OrderType]
	
	END
	
	
	
	
	--OverallPeriod
	IF (select object_ID('tempdb..#OverallPeriod')) >0 
		DROP TABLE [#OverallPeriod]
	SELECT [T$PDAT_FiscalYear] AS FiscalYear
		  ,[T$PDAT_FiscalPeriod] AS FiscalPeriod
	INTO [#OverallPeriod]
	FROM [#BookingByOrderType]
	WHERE  [T$PDAT_FiscalYear] != 2099 
	GROUP BY [T$PDAT_FiscalYear], [T$PDAT_FiscalPeriod]
	ORDER BY [T$PDAT_FiscalYear], [T$PDAT_FiscalPeriod]


	DECLARE @BookingSQLString VARCHAR(MAX),  @TargetSQLString  VARCHAR(MAX), @GapSQLString  VARCHAR(MAX), @VMISQLString  VARCHAR(MAX), @POSQLString  VARCHAR(MAX), @AheadSQLString  VARCHAR(MAX)
	DECLARE @BookingTotal NUMERIC(19,4) ,@BookingBuffer NUMERIC(19,4),@BookingAfter NUMERIC(19,4), @Target NUMERIC(19,4), @Gap NUMERIC(19,4), @VMI NUMERIC(19,4),@PO NUMERIC(19,4), @VMIBuffer NUMERIC(19,4),@POBuffer NUMERIC(19,4), @VMITotal NUMERIC(19,4), @POTotal NUMERIC(19,4), @VMIAfter NUMERIC(19,4), @POAfter NUMERIC(19,4)
	
	--#BookingStatus
	IF (select object_ID('tempdb..#BookingStatus')) >0 
		DROP TABLE [#BookingStatus]
	CREATE TABLE #BookingStatus ([Item] VARCHAR(50))
	SET @BookingSQLString=' ALTER TABLE #BookingStatus ADD [OrderType] VARCHAR(50) NULL '
	SELECT @BookingSQLString=@BookingSQLString+ 'ALTER TABLE #BookingStatus ADD [' + dbo.fun_Get_Full_Period_Name([FiscalYear], [FiscalPeriod]) +'] NUMERIC(19,4) NULL '
							+ 'ALTER TABLE #BookingStatus ADD [' + dbo.fun_Get_Full_Period_Name([FiscalYear], [FiscalPeriod]) +'_%] NUMERIC(19,4) NULL '
	FROM #OverallPeriod
	EXEC (@BookingSQLString)
	ALTER TABLE #BookingStatus ADD [After Period] NUMERIC(19,4) NULL
	ALTER TABLE #BookingStatus ADD [Buffer Order] NUMERIC(19,4) NULL
	ALTER TABLE #BookingStatus ADD Overall NUMERIC(19,4) NULL
	ALTER TABLE #BookingStatus DROP COLUMN [Item]



	SET @Target=0
	SET @Gap=0
	SET @BookingBuffer =0
	SET @VMI=0
	SET @VMIAfter=0
	SET @PO=0
	SET @VMIBuffer=0
	SET @POAfter=0

	SET @BookingSQLString='INSERT INTO #BookingStatus VALUES(''Total'''
	SET @TargetSQLString='INSERT INTO #BookingStatus VALUES(''Target'''
	SET @GapSQLString='INSERT INTO #BookingStatus VALUES(''Gap'''
	SET @VMISQLString='INSERT INTO #BookingStatus VALUES(''VMI'''
	SET @POSQLString='INSERT INTO #BookingStatus VALUES(''PO'''
	
	
		
	
	--Total Booking
	SELECT
		  @BookingSQLString=@BookingSQLString+ ', ' +CONVERT(VARCHAR(50),CAST(ISNULL([Booking],0)AS NUMERIC(19,4)))+', ''1'''
		  ,@TargetSQLString=@TargetSQLString+ ', ' +CONVERT(VARCHAR(50),CAST(ISNULL([Forecast],0)AS NUMERIC(19,4)))+', ''0'''
		  ,@Target=@Target+ ISNULL([Forecast],0) 
		  ,@GapSQLString=@GapSQLString+ ', ' + (CASE WHEN [Forecast] IS NULL THEN '0' ELSE CONVERT(VARCHAR(50),CAST(ISNULL([Forecast],0)- ISNULL([Booking],0)AS NUMERIC(19,4))) END)+', ''0'''
		  ,@Gap= @Gap+ (CASE WHEN [Forecast] IS NULL THEN 0 ELSE ISNULL([Forecast],0)- ISNULL([Booking],0) END)
	FROM #OverallPeriod AS A LEFT JOIN
	(
		SELECT [T$PDAT_FiscalYear]
			  ,[T$PDAT_FiscalPeriod]
			  ,SUM([Booking]) AS Booking
		FROM [#BookingByOrderType]
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
	FROM [#BookingByOrderType]
	
	--Booking Buffer Order 
	SELECT @BookingBuffer =ISNULL(SUM([Booking]),0)
	FROM [#BookingByOrderType]
	WHERE  [T$PDAT_FiscalYear] = '2099' AND [T$PDAT_FiscalPeriod] = 1
			
	--Booking After
	SELECT @BookingAfter=ISNULL(SUM([Booking]),0)
	FROM [#BookingByOrderType]
	WHERE [T$PDAT_FiscalYear] IS NULL
	
	-- VMI & PO
	SELECT  
	  @VMISQLString=@VMISQLString+', ' + CONVERT(VARCHAR(50),CAST(ISNULL([VMI],0)AS NUMERIC(19,4)))+', '+ CONVERT(VARCHAR(50),CAST(ISNULL([VMI],0)/(ISNULL([VMI],1)+ISNULL([PO],0))AS NUMERIC(19,4)))
	  ,@VMI=@VMI+ISNULL([VMI],0)
	  ,@POSQLString=@POSQLString+', ' + CONVERT(VARCHAR(50),CAST(ISNULL([PO],0)AS NUMERIC(19,4)))+', '+ CONVERT(VARCHAR(50),CAST(ISNULL([PO],0)/(ISNULL([VMI],1)+ISNULL([PO],0))AS NUMERIC(19,4)))
	  ,@PO=@PO+ISNULL([PO],0)
	FROM #OverallPeriod AS A LEFT JOIN
	(--VMI
		SELECT [T$PDAT_FiscalYear]
		  ,[T$PDAT_FiscalPeriod]
		  ,SUM([Booking])AS VMI
		FROM [#BookingByOrderType]
		WHERE [OrderType] IN ('CNG', 'CLT')
		GROUP BY [T$PDAT_FiscalYear],[T$PDAT_FiscalPeriod] 
	)AS B
	ON  A.[FiscalYear]=B.[T$PDAT_FiscalYear] AND A.[FiscalPeriod]=B.[T$PDAT_FiscalPeriod]
	LEFT JOIN 
	(--PO
		SELECT [T$PDAT_FiscalYear]
		  ,[T$PDAT_FiscalPeriod]
		  ,SUM([Booking])AS PO
		FROM [#BookingByOrderType]
		WHERE  [OrderType] IN ('SLS', 'SLT', 'BFS')
		GROUP BY [T$PDAT_FiscalYear],[T$PDAT_FiscalPeriod] 
	)AS C
	ON A.[FiscalYear]=C.[T$PDAT_FiscalYear] AND A.[FiscalPeriod]=C.[T$PDAT_FiscalPeriod]
	ORDER BY A.FiscalYear,A.FiscalPeriod

			
	
	-- VMI  Overall 
	SELECT  
	  @VMITotal=ISNULL(SUM([Booking]),0)
	FROM [#BookingByOrderType]
	WHERE [OrderType] IN ('CNG', 'CLT')	
	
	-- PO   Overall 
	SELECT  
	  @POTotal=ISNULL(SUM([Booking]),0)
	FROM [#BookingByOrderType]
	WHERE [OrderType] IN ('SLS', 'SLT', 'BFS')	
		
	-- VMI  Buffer 
	SELECT @VMIBuffer=ISNULL(SUM([Booking]),0)
	FROM [#BookingByOrderType]
	WHERE [OrderType] IN ('CNG', 'CLT')	
	AND [T$PDAT_FiscalYear] = '2099' AND [T$PDAT_FiscalPeriod] = 1
	
	-- PO  Buffer 
	SELECT @POBuffer=ISNULL(SUM([Booking]),0)
	FROM [#BookingByOrderType]
	WHERE [OrderType] IN ('SLS', 'SLT', 'BFS')
	AND [T$PDAT_FiscalYear] = '2099' AND [T$PDAT_FiscalPeriod] = 1
	
	
	-- VMI  After 
	SELECT @VMIAfter=ISNULL(SUM([Booking]),0)
	FROM [#BookingByOrderType]
	WHERE [OrderType] IN ('CNG', 'CLT')	
	AND [T$PDAT_FiscalYear] IS NULL
	
	-- PO  After 
	SELECT @POAfter=ISNULL(SUM([Booking]),0)
	FROM [#BookingByOrderType]
	WHERE [OrderType] IN ('SLS', 'SLT', 'BFS')
	AND [T$PDAT_FiscalYear] IS NULL


	SET @BookingSQLString=@BookingSQLString+ ', '+ CONVERT(VARCHAR(50),@BookingAfter)+ ', '+ CONVERT(VARCHAR(50),@BookingBuffer)+ ', '+ CONVERT(VARCHAR(50),@BookingTotal)+ ')'
	SET @TargetSQLString=@TargetSQLString+ ', 0, 0, '+ CONVERT(VARCHAR(50),@Target)+ ')'
	SET @GapSQLString=@GapSQLString+ ', 0, 0, '+ CONVERT(VARCHAR(50),@Gap)+ ')'
	SET @VMISQLString=@VMISQLString+ ', '+ CONVERT(VARCHAR(50),@VMIAfter)+ ', '+ CONVERT(VARCHAR(50),@VMIBuffer)+ ', '+ CONVERT(VARCHAR(50),@VMITotal)+ ')'
	SET @POSQLString=@POSQLString+ ', '+ CONVERT(VARCHAR(50),@POAfter)+ ', '+ CONVERT(VARCHAR(50),@POBuffer)+ ', '+ CONVERT(VARCHAR(50),@POTotal)+ ')'
	
	EXEC(@VMISQLString)
	EXEC(@POSQLString)
	EXEC(@BookingSQLString)
	EXEC(@TargetSQLString)
	EXEC(@GapSQLString)
	


	SELECT * FROM [#BookingStatus]

	----Delete Table
	DROP TABLE [#BookingByOrderType]
	DROP TABLE [#OverallPeriod]	
	DROP TABLE [#BookingStatus]


	
end









GO
