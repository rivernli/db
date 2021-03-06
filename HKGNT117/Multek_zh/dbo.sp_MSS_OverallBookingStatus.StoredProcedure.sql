USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_MSS_OverallBookingStatus]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_MSS_OverallBookingStatus]
	
AS
BEGIN
	--CurrentFiscalDate
	DECLARE @CurrentDay DATETIME
	DECLARE @CurrentFiscalYear VARCHAR(4)
	DECLARE @CurrentFiscalPeriod VARCHAR(2)
	SELECT @CurrentDay=CONVERT(DATETIME, CONVERT(varchar(100), [UpTime] , 112)) FROM [Multek_ZH].[dbo].[MSS_UpTime]
	SELECT @CurrentFiscalYear= substring([FiscalYearDesc],3,4),@CurrentFiscalPeriod=CONVERT(VARCHAR,FiscalPeriod) FROM  [DataWarehouse].[dbo].[DW_DIM_Calender]
	WHERE CalenderDate=@CurrentDay
	
	--Booking 当前其包含以前期的Booking
	IF (select object_ID('tempdb..#Booking')) >0 
		DROP TABLE [#Booking]
	SELECT [T$PDAT_FiscalYear]
		  ,[T$PDAT_FiscalPeriod]
		  ,[Plant]
		  ,ISNULL(SUM([Booking]), 0)  AS Booking
	INTO [#Booking]
	FROM (
		SELECT [T$PDAT_FiscalYear]
			  ,[T$PDAT_FiscalPeriod]
			  ,[Plant]
			  ,SUM([Amount]) AS Booking
		FROM [MSS_MSS_ByPlant]
		WHERE [T$JDAT]=@CurrentDay
				AND(
					[T$PDAT_FiscalYear] > @CurrentFiscalYear
					OR([T$PDAT_FiscalYear] = @CurrentFiscalYear AND [T$PDAT_FiscalPeriod] >= @CurrentFiscalPeriod)
					OR [T$PDAT_FiscalYear] IS NULL --After Period
				)
		GROUP BY [T$PDAT_FiscalYear], [T$PDAT_FiscalPeriod], [Plant]
		UNION ALL--以前期
		SELECT @CurrentFiscalYear AS [T$PDAT_FiscalYear]
			  ,@CurrentFiscalPeriod AS [T$PDAT_FiscalPeriod]
			  ,[Plant]
			  ,SUM([Amount]) AS Booking
		FROM [MSS_MSS_ByPlant]
		WHERE [T$JDAT]=@CurrentDay
				AND(
					[T$PDAT_FiscalYear] < @CurrentFiscalYear
					OR([T$PDAT_FiscalYear] = @CurrentFiscalYear AND [T$PDAT_FiscalPeriod] < @CurrentFiscalPeriod)
				)	
		GROUP BY [Plant]
	)AS T
	GROUP BY [T$PDAT_FiscalYear], [T$PDAT_FiscalPeriod], [Plant]
	

	--OverallPeriod
	IF (select object_ID('tempdb..#OverallPeriod')) >0 
		DROP TABLE [#OverallPeriod]
	SELECT [T$PDAT_FiscalYear]
		  ,[T$PDAT_FiscalPeriod]
	INTO #OverallPeriod
	FROM [#Booking]
	WHERE [T$PDAT_FiscalYear] != 2099	
	GROUP BY [T$PDAT_FiscalYear],[T$PDAT_FiscalPeriod]
	ORDER BY [T$PDAT_FiscalYear],[T$PDAT_FiscalPeriod]

	DECLARE @BookingSQLString VARCHAR(MAX), @Plant VARCHAR(50), @TargetSQLString  VARCHAR(MAX), @GapSQLString  VARCHAR(MAX)
	DECLARE @BookingTotal NUMERIC(19,4), @BufferBuffer NUMERIC(19,4), @BookingAfter NUMERIC(19,4), @Target NUMERIC(19,4), @Gap NUMERIC(19,4)
	--#BookingStatus
	if (select object_ID('tempdb..#BookingStatus')) >0 
		DROP TABLE [#BookingStatus]
	CREATE TABLE #BookingStatus (Plant VARCHAR(50))
	SET @BookingSQLString=' ALTER TABLE #BookingStatus ADD Item VARCHAR(50) NULL '
	SELECT @BookingSQLString=@BookingSQLString+ 'ALTER TABLE #BookingStatus ADD [' + dbo.fun_Get_Full_Period_Name([T$PDAT_FiscalYear], [T$PDAT_FiscalPeriod]) + '] NUMERIC(19,4) NULL '
	FROM #OverallPeriod
	EXEC (@BookingSQLString)
	ALTER TABLE #BookingStatus ADD [After Period] NUMERIC(19,4) NULL
	ALTER TABLE #BookingStatus ADD [Buffer Order] NUMERIC(19,4) NULL
	ALTER TABLE #BookingStatus ADD Overall NUMERIC(19,4) NULL
	
	
	
	--Overall Plant
	SET @Plant='Overall'
	SET @Target=0
	SET @Gap=0
	SET @BufferBuffer =0
	SET @BookingAfter =0
	SET @BookingSQLString='INSERT INTO #BookingStatus VALUES('+''''+@Plant+''',''MSS'''
	SET @TargetSQLString='INSERT INTO #BookingStatus VALUES('+''''+@Plant+''',''Finance FCST'''
	SET @GapSQLString='INSERT INTO #BookingStatus VALUES('+''''+@Plant+''',''Gap'''
	SELECT
		  @BookingSQLString=@BookingSQLString+ ', ' +CONVERT(VARCHAR(50),CAST(ISNULL([Booking],0)AS NUMERIC(19,4)))
		  ,@TargetSQLString=@TargetSQLString+ ', ' +CONVERT(VARCHAR(50),ISNULL([Forecast],0))
		  ,@Target=@Target+ ISNULL([Forecast],0) 
		  ,@GapSQLString=@GapSQLString+ ', ' + (CASE WHEN [Forecast] IS NULL THEN '0' ELSE CONVERT(VARCHAR(50),CAST(ISNULL([Booking],0) - ISNULL([Forecast],0) AS NUMERIC(19,4))) END)
		  ,@Gap= @Gap+ (CASE WHEN [Forecast] IS NULL THEN 0 ELSE ISNULL([Booking],0) - ISNULL([Forecast],0) END)
	FROM #OverallPeriod AS A LEFT JOIN
	(
		SELECT [T$PDAT_FiscalYear]
			  ,[T$PDAT_FiscalPeriod]
			  ,SUM([Booking]) AS Booking
		FROM [#Booking]
		WHERE [T$PDAT_FiscalYear] != 2099	
		GROUP BY [T$PDAT_FiscalYear],[T$PDAT_FiscalPeriod]
	)AS B
	ON  A.[T$PDAT_FiscalYear]=B.[T$PDAT_FiscalYear]
	AND A.[T$PDAT_FiscalPeriod]=B.[T$PDAT_FiscalPeriod]
	LEFT JOIN  [MSS_Forecast] AS C
	ON  A.[T$PDAT_FiscalYear]=substring(C.[FYear],3,4)
		AND A.[T$PDAT_FiscalPeriod]=C.[Period]
		AND C.[Plant]=''
		AND C.[Type]='Shipment'
	ORDER BY A.[T$PDAT_FiscalYear],A.[T$PDAT_FiscalPeriod]
	
	--Booking Overall 
	SELECT @BookingTotal=ISNULL(SUM([Booking]),0)
	FROM [#Booking]
	
	--Booking Buffer Order 
	SELECT @BufferBuffer =ISNULL(SUM([Booking]),0)
	FROM [#Booking]
	WHERE  [T$PDAT_FiscalYear] = '2099' AND [T$PDAT_FiscalPeriod] = 1
			
	--Booking After
	SELECT @BookingAfter=ISNULL(SUM([Booking]),0)
	FROM [#Booking]
	WHERE [T$PDAT_FiscalYear] IS NULL

	SET @BookingSQLString=@BookingSQLString+ ', '+ CONVERT(VARCHAR(50),@BookingAfter)+ ', '+ CONVERT(VARCHAR(50),@BufferBuffer)+ ', '+ CONVERT(VARCHAR(50),@BookingTotal)+ ')'
	SET @TargetSQLString=@TargetSQLString+ ', 0, 0, '+ CONVERT(VARCHAR(50),@Target)+ ')'
	SET @GapSQLString=@GapSQLString+ ', 0, 0, '+ CONVERT(VARCHAR(50),@Gap)+ ')'
	EXEC(@BookingSQLString)
	EXEC(@TargetSQLString)
	EXEC(@GapSQLString)

	

	--B1
	SET @Plant='B1'
	SET @Target=0
	SET @Gap=0
	SET @BufferBuffer =0
	SET @BookingAfter =0
	SET @BookingSQLString='INSERT INTO #BookingStatus VALUES('+''''+@Plant+''',''MSS'''
	SET @TargetSQLString='INSERT INTO #BookingStatus VALUES('+''''+@Plant+''',''Finance FCST'''
	SET @GapSQLString='INSERT INTO #BookingStatus VALUES('+''''+@Plant+''',''Gap'''
	SELECT
		  @BookingSQLString=@BookingSQLString+ ', ' +CONVERT(VARCHAR(50),CAST(ISNULL([Booking],0)AS NUMERIC(19,4)))
		  ,@TargetSQLString=@TargetSQLString+ ', ' +CONVERT(VARCHAR(50),ISNULL([Forecast],0))
		  ,@Target=@Target+ ISNULL([Forecast],0) 
		  ,@GapSQLString=@GapSQLString+ ', ' + (CASE WHEN [Forecast] IS NULL THEN '0' ELSE CONVERT(VARCHAR(50),CAST(ISNULL([Booking],0) - ISNULL([Forecast],0)AS NUMERIC(19,4))) END)
		  ,@Gap= @Gap+ (CASE WHEN [Forecast] IS NULL THEN 0 ELSE ISNULL([Booking],0) - ISNULL([Forecast],0) END)
	FROM #OverallPeriod AS A LEFT JOIN
	(
		SELECT [T$PDAT_FiscalYear]
			  ,[T$PDAT_FiscalPeriod]
			  ,SUM([Booking]) AS Booking
		FROM [#Booking]
		WHERE [Plant]=@Plant
		GROUP BY [T$PDAT_FiscalYear], [T$PDAT_FiscalPeriod]	
	)AS B
	ON  A.[T$PDAT_FiscalYear]=B.[T$PDAT_FiscalYear]
	AND A.[T$PDAT_FiscalPeriod]=B.[T$PDAT_FiscalPeriod]
	LEFT JOIN  [MSS_Forecast] AS C
	ON  A.[T$PDAT_FiscalYear]=substring(C.[FYear],3,4)
		AND A.[T$PDAT_FiscalPeriod]=C.[Period]
		AND C.[Plant]=@Plant
		AND C.[Type]='Shipment'
	ORDER BY A.[T$PDAT_FiscalYear],A.[T$PDAT_FiscalPeriod]
		
	--Booking Overall 
	SELECT @BookingTotal=ISNULL(SUM([Booking]),0)
	FROM [#Booking]
	WHERE  [Plant]=@Plant
	
	--Booking Buffer Order 
	SELECT @BufferBuffer =ISNULL(SUM([Booking]),0)
	FROM [#Booking]
	WHERE  [T$PDAT_FiscalYear] = '2099' AND [T$PDAT_FiscalPeriod] = 1
			AND [Plant]=@Plant
			
	--Booking After
	SELECT @BookingAfter=ISNULL(SUM([Booking]),0)
	FROM [#Booking]
	WHERE [T$PDAT_FiscalYear] IS NULL
		  AND [Plant]=@Plant
	
	SET @BookingSQLString=@BookingSQLString+ ', '+ CONVERT(VARCHAR(50),@BookingAfter)+ ', '+ CONVERT(VARCHAR(50),@BufferBuffer)+ ', '+ CONVERT(VARCHAR(50),@BookingTotal)+ ')'
	SET @TargetSQLString=@TargetSQLString+ ', 0, 0, '+ CONVERT(VARCHAR(50),@Target)+ ')'
	SET @GapSQLString=@GapSQLString+ ', 0, 0, '+ CONVERT(VARCHAR(50),@Gap)+ ')'
	EXEC(@BookingSQLString)
	EXEC(@TargetSQLString)
	EXEC(@GapSQLString)




	--2F
	SET @Plant='2F'
	SET @Target=0
	SET @Gap=0
	SET @BufferBuffer =0
	SET @BookingAfter =0
	SET @BookingSQLString='INSERT INTO #BookingStatus VALUES(''B2F'',''MSS'''
	SET @TargetSQLString='INSERT INTO #BookingStatus VALUES(''B2F'',''Finance FCST'''
	SET @GapSQLString='INSERT INTO #BookingStatus VALUES(''B2F'',''Gap'''
	SELECT
		  @BookingSQLString=@BookingSQLString+ ', ' +CONVERT(VARCHAR(50),CAST(ISNULL([Booking],0)AS NUMERIC(19,4)))
		  ,@TargetSQLString=@TargetSQLString+ ', ' +CONVERT(VARCHAR(50),ISNULL([Forecast],0))
		  ,@Target=@Target+ ISNULL([Forecast],0) 
		  ,@GapSQLString=@GapSQLString+ ', ' + (CASE WHEN [Forecast] IS NULL THEN '0' ELSE CONVERT(VARCHAR(50),CAST(ISNULL([Booking],0) - ISNULL([Forecast],0)AS NUMERIC(19,4))) END)
		  ,@Gap= @Gap+ (CASE WHEN [Forecast] IS NULL THEN 0 ELSE ISNULL([Booking],0) - ISNULL([Forecast],0) END)
	FROM #OverallPeriod AS A LEFT JOIN
	(
		SELECT [T$PDAT_FiscalYear]
			  ,[T$PDAT_FiscalPeriod]
			  ,SUM([Booking]) AS Booking
		FROM [#Booking]
		WHERE [Plant]=@Plant
		GROUP BY [T$PDAT_FiscalYear], [T$PDAT_FiscalPeriod]
	)AS B
	ON  A.[T$PDAT_FiscalYear]=B.[T$PDAT_FiscalYear]
	AND A.[T$PDAT_FiscalPeriod]=B.[T$PDAT_FiscalPeriod]
	LEFT JOIN  [MSS_Forecast] AS C
	ON  A.[T$PDAT_FiscalYear]=substring(C.[FYear],3,4)
		AND A.[T$PDAT_FiscalPeriod]=C.[Period]
		AND C.[Plant]=@Plant
		AND C.[Type]='Shipment'
	ORDER BY A.[T$PDAT_FiscalYear],A.[T$PDAT_FiscalPeriod]
		
	--Booking Overall 
	SELECT @BookingTotal=ISNULL(SUM([Booking]),0)
	FROM [#Booking]
	WHERE [Plant]=@Plant
	
	--Booking Buffer Order 
	SELECT @BufferBuffer =ISNULL(SUM([Booking]),0)
	FROM [#Booking]
	WHERE  [T$PDAT_FiscalYear] = '2099' AND [T$PDAT_FiscalPeriod] = 1
			AND [Plant]=@Plant
			
	--Booking After
	SELECT @BookingAfter=ISNULL(SUM([Booking]),0)
	FROM [#Booking]
	WHERE [T$PDAT_FiscalYear] IS NULL
		  AND [Plant]=@Plant

	SET @BookingSQLString=@BookingSQLString+ ', '+ CONVERT(VARCHAR(50),@BookingAfter)+ ', '+ CONVERT(VARCHAR(50),@BufferBuffer)+ ', '+ CONVERT(VARCHAR(50),@BookingTotal)+ ')'
	SET @TargetSQLString=@TargetSQLString+ ', 0, 0, '+ CONVERT(VARCHAR(50),@Target)+ ')'
	SET @GapSQLString=@GapSQLString+ ', 0, 0, '+ CONVERT(VARCHAR(50),@Gap)+ ')'
	

	EXEC(@BookingSQLString)
	EXEC(@TargetSQLString)
	EXEC(@GapSQLString)




	--B3
	SET @Plant='B3'
	SET @Target=0
	SET @Gap=0
	SET @BufferBuffer =0
	SET @BookingAfter =0
	SET @BookingSQLString='INSERT INTO #BookingStatus VALUES('+''''+@Plant+''',''MSS'''
	SET @TargetSQLString='INSERT INTO #BookingStatus VALUES('+''''+@Plant+''',''Finance FCST'''
	SET @GapSQLString='INSERT INTO #BookingStatus VALUES('+''''+@Plant+''',''Gap'''
	SELECT
		  @BookingSQLString=@BookingSQLString+ ', ' +CONVERT(VARCHAR(50),CAST(ISNULL([Booking],0)AS NUMERIC(19,4)))
		  ,@TargetSQLString=@TargetSQLString+ ', ' +CONVERT(VARCHAR(50),ISNULL([Forecast],0))
		  ,@Target=@Target+ ISNULL([Forecast],0) 
		  ,@GapSQLString=@GapSQLString+ ', ' + (CASE WHEN [Forecast] IS NULL THEN '0' ELSE CONVERT(VARCHAR(50),CAST(ISNULL([Booking],0) - ISNULL([Forecast],0)AS NUMERIC(19,4))) END)
		  ,@Gap= @Gap+ (CASE WHEN [Forecast] IS NULL THEN 0 ELSE ISNULL([Booking],0) - ISNULL([Forecast],0) END)
	FROM #OverallPeriod AS A LEFT JOIN
	(
		SELECT [T$PDAT_FiscalYear]
			  ,[T$PDAT_FiscalPeriod]
			  ,SUM([Booking]) AS Booking
		FROM [#Booking]
		WHERE [Plant]=@Plant
		GROUP BY [T$PDAT_FiscalYear], [T$PDAT_FiscalPeriod]
	)AS B
	ON  A.[T$PDAT_FiscalYear]=B.[T$PDAT_FiscalYear]
	AND A.[T$PDAT_FiscalPeriod]=B.[T$PDAT_FiscalPeriod]
	LEFT JOIN  [MSS_Forecast] AS C
	ON  A.[T$PDAT_FiscalYear]=substring(C.[FYear],3,4)
		AND A.[T$PDAT_FiscalPeriod]=C.[Period]
		AND C.[Plant]=@Plant
		AND C.[Type]='Shipment'
	ORDER BY A.[T$PDAT_FiscalYear],A.[T$PDAT_FiscalPeriod]
		
	--Booking Overall 
	SELECT @BookingTotal=ISNULL(SUM([Booking]),0)
	FROM [#Booking]
	WHERE [Plant]=@Plant
	
	--Booking Buffer Order 
	SELECT @BufferBuffer =ISNULL(SUM([Booking]),0)
	FROM [#Booking]
	WHERE  [T$PDAT_FiscalYear] = '2099' AND [T$PDAT_FiscalPeriod] = 1
			AND [Plant]=@Plant
			
	--Booking After
	SELECT @BookingAfter=ISNULL(SUM([Booking]),0)
	FROM [#Booking]
	WHERE [T$PDAT_FiscalYear] IS NULL
		  AND [Plant]=@Plant
		  
	SET @BookingSQLString=@BookingSQLString+ ', '+ CONVERT(VARCHAR(50),@BookingAfter)+ ', '+ CONVERT(VARCHAR(50),@BufferBuffer)+ ', '+ CONVERT(VARCHAR(50),@BookingTotal)+ ')'
	SET @TargetSQLString=@TargetSQLString+ ', 0, 0, '+ CONVERT(VARCHAR(50),@Target)+ ')'
	SET @GapSQLString=@GapSQLString+ ', 0, 0, '+ CONVERT(VARCHAR(50),@Gap)+ ')'
	EXEC(@BookingSQLString)
	EXEC(@TargetSQLString)
	EXEC(@GapSQLString)





	--B4
	SET @Plant='B4'
	SET @Target=0
	SET @Gap=0
	SET @BufferBuffer =0
	SET @BookingAfter =0
	SET @BookingSQLString='INSERT INTO #BookingStatus VALUES('+''''+@Plant+''',''MSS'''
	SET @TargetSQLString='INSERT INTO #BookingStatus VALUES('+''''+@Plant+''',''Finance FCST'''
	SET @GapSQLString='INSERT INTO #BookingStatus VALUES('+''''+@Plant+''',''Gap'''
	SELECT
		  @BookingSQLString=@BookingSQLString+ ', ' +CONVERT(VARCHAR(50),CAST(ISNULL([Booking],0)AS NUMERIC(19,4)))
		  ,@TargetSQLString=@TargetSQLString+ ', ' +CONVERT(VARCHAR(50),ISNULL([Forecast],0))
		  ,@Target=@Target+ ISNULL([Forecast],0) 
		  ,@GapSQLString=@GapSQLString+ ', ' + (CASE WHEN [Forecast] IS NULL THEN '0' ELSE CONVERT(VARCHAR(50),CAST(ISNULL([Booking],0) - ISNULL([Forecast],0)AS NUMERIC(19,4))) END)
		  ,@Gap= @Gap+ (CASE WHEN [Forecast] IS NULL THEN 0 ELSE ISNULL([Booking],0) - ISNULL([Forecast],0) END)
	FROM #OverallPeriod AS A LEFT JOIN
	(
		SELECT [T$PDAT_FiscalYear]
			  ,[T$PDAT_FiscalPeriod]
			  ,SUM([Booking]) AS Booking
		FROM [#Booking]
		WHERE [Plant]=@Plant
		GROUP BY [T$PDAT_FiscalYear], [T$PDAT_FiscalPeriod]
	)AS B
	ON  A.[T$PDAT_FiscalYear]=B.[T$PDAT_FiscalYear]
	AND A.[T$PDAT_FiscalPeriod]=B.[T$PDAT_FiscalPeriod]
	LEFT JOIN  [MSS_Forecast] AS C
	ON  A.[T$PDAT_FiscalYear]=substring(C.[FYear],3,4)
		AND A.[T$PDAT_FiscalPeriod]=C.[Period]
		AND C.[Plant]=@Plant
		AND C.[Type]='Shipment'
	ORDER BY A.[T$PDAT_FiscalYear],A.[T$PDAT_FiscalPeriod]
		
	--Booking Overall 
	SELECT @BookingTotal=ISNULL(SUM([Booking]),0)
	FROM [#Booking]
	WHERE [Plant]=@Plant
	
	--Booking Buffer Order 
	SELECT @BufferBuffer =ISNULL(SUM([Booking]),0)
	FROM [#Booking]
	WHERE  [T$PDAT_FiscalYear] = '2099' AND [T$PDAT_FiscalPeriod] = 1
			AND [Plant]=@Plant
			
	--Booking After
	SELECT @BookingAfter=ISNULL(SUM([Booking]),0)
	FROM [#Booking]
	WHERE [T$PDAT_FiscalYear] IS NULL
		  AND [Plant]=@Plant
		  
	SET @BookingSQLString=@BookingSQLString+ ', '+ CONVERT(VARCHAR(50),@BookingAfter)+ ', '+ CONVERT(VARCHAR(50),@BufferBuffer)+ ', '+ CONVERT(VARCHAR(50),@BookingTotal)+ ')'
	SET @TargetSQLString=@TargetSQLString+ ', 0, 0, '+ CONVERT(VARCHAR(50),@Target)+ ')'
	SET @GapSQLString=@GapSQLString+ ', 0, 0, '+ CONVERT(VARCHAR(50),@Gap)+ ')'
	EXEC(@BookingSQLString)
	EXEC(@TargetSQLString)
	EXEC(@GapSQLString)


	--B5
	SET @Plant='B5'
	SET @Target=0
	SET @Gap=0
	SET @BufferBuffer =0
	SET @BookingAfter =0
	SET @BookingSQLString='INSERT INTO #BookingStatus VALUES('+''''+@Plant+''',''MSS'''
	SET @TargetSQLString='INSERT INTO #BookingStatus VALUES('+''''+@Plant+''',''Finance FCST'''
	SET @GapSQLString='INSERT INTO #BookingStatus VALUES('+''''+@Plant+''',''Gap'''
	SELECT
		  @BookingSQLString=@BookingSQLString+ ', ' +CONVERT(VARCHAR(50),CAST(ISNULL([Booking],0)AS NUMERIC(19,4)))
		  ,@TargetSQLString=@TargetSQLString+ ', ' +CONVERT(VARCHAR(50),ISNULL([Forecast],0))
		  ,@Target=@Target+ ISNULL([Forecast],0) 
		  ,@GapSQLString=@GapSQLString+ ', ' + (CASE WHEN [Forecast] IS NULL THEN '0' ELSE CONVERT(VARCHAR(50),CAST(ISNULL([Booking],0) - ISNULL([Forecast],0)AS NUMERIC(19,4))) END)
		  ,@Gap= @Gap+ (CASE WHEN [Forecast] IS NULL THEN 0 ELSE ISNULL([Booking],0) - ISNULL([Forecast],0) END)
	FROM #OverallPeriod AS A LEFT JOIN
	(
		SELECT [T$PDAT_FiscalYear]
			  ,[T$PDAT_FiscalPeriod]
			  ,SUM([Booking]) AS Booking
		FROM [#Booking]
		WHERE [Plant]=@Plant
		GROUP BY [T$PDAT_FiscalYear], [T$PDAT_FiscalPeriod]
	)AS B
	ON  A.[T$PDAT_FiscalYear]=B.[T$PDAT_FiscalYear]
	AND A.[T$PDAT_FiscalPeriod]=B.[T$PDAT_FiscalPeriod]
	LEFT JOIN  [MSS_Forecast] AS C
	ON  A.[T$PDAT_FiscalYear]=substring(C.[FYear],3,4)
		AND A.[T$PDAT_FiscalPeriod]=C.[Period]
		AND C.[Plant]=@Plant
		AND C.[Type]='Shipment'
	ORDER BY A.[T$PDAT_FiscalYear],A.[T$PDAT_FiscalPeriod]
		
	--Booking Overall 
	SELECT @BookingTotal=ISNULL(SUM([Booking]),0)
	FROM [#Booking]
	WHERE [Plant]=@Plant
	
	--Booking Buffer Order 
	SELECT @BufferBuffer =ISNULL(SUM([Booking]),0)
	FROM [#Booking]
	WHERE  [T$PDAT_FiscalYear] = '2099' AND [T$PDAT_FiscalPeriod] = 1
			AND [Plant]=@Plant
			
	--Booking After
	SELECT @BookingAfter=ISNULL(SUM([Booking]),0)
	FROM [#Booking]
	WHERE [T$PDAT_FiscalYear] IS NULL
		  AND [Plant]=@Plant
		  
	SET @BookingSQLString=@BookingSQLString+ ', '+ CONVERT(VARCHAR(50),@BookingAfter)+ ', '+ CONVERT(VARCHAR(50),@BufferBuffer)+ ', '+ CONVERT(VARCHAR(50),@BookingTotal)+ ')'
	SET @TargetSQLString=@TargetSQLString+ ', 0, 0, '+ CONVERT(VARCHAR(50),@Target)+ ')'
	SET @GapSQLString=@GapSQLString+ ', 0, 0, '+ CONVERT(VARCHAR(50),@Gap)+ ')'
	EXEC(@BookingSQLString)
	EXEC(@TargetSQLString)
	EXEC(@GapSQLString)



	--VVI
	SET @Plant='HK'
	SET @Target=0
	SET @Gap=0
	SET @BufferBuffer =0
	SET @BookingAfter =0
	SET @BookingSQLString='INSERT INTO #BookingStatus VALUES(''VVI'',''MSS'''
	SET @TargetSQLString='INSERT INTO #BookingStatus VALUES(''VVI'',''Finance FCST'''
	SET @GapSQLString='INSERT INTO #BookingStatus VALUES(''VVI'',''Gap'''
	SELECT
		  @BookingSQLString=@BookingSQLString+ ', ' +CONVERT(VARCHAR(50),CAST(ISNULL([Booking],0)AS NUMERIC(19,4)))
		  ,@TargetSQLString=@TargetSQLString+ ', ' +CONVERT(VARCHAR(50),ISNULL([Forecast],0))
		  ,@Target=@Target+ ISNULL([Forecast],0) 
		  ,@GapSQLString=@GapSQLString+ ', ' + (CASE WHEN [Forecast] IS NULL THEN '0' ELSE CONVERT(VARCHAR(50),CAST(ISNULL([Booking],0) - ISNULL([Forecast],0)AS NUMERIC(19,4))) END)
		  ,@Gap= @Gap+ (CASE WHEN [Forecast] IS NULL THEN 0 ELSE ISNULL([Booking],0) - ISNULL([Forecast],0) END)
	FROM #OverallPeriod AS A LEFT JOIN
	(
		SELECT [T$PDAT_FiscalYear]
			  ,[T$PDAT_FiscalPeriod]
			  ,SUM([Booking]) AS Booking
		FROM [#Booking]
		WHERE [Plant]=@Plant
		GROUP BY [T$PDAT_FiscalYear], [T$PDAT_FiscalPeriod]
	)AS B
	ON  A.[T$PDAT_FiscalYear]=B.[T$PDAT_FiscalYear]
	AND A.[T$PDAT_FiscalPeriod]=B.[T$PDAT_FiscalPeriod]
	LEFT JOIN  [MSS_Forecast] AS C
	ON  A.[T$PDAT_FiscalYear]=substring(C.[FYear],3,4)
		AND A.[T$PDAT_FiscalPeriod]=C.[Period]
		AND C.[Plant]=@Plant
		AND C.[Type]='Shipment'
	ORDER BY A.[T$PDAT_FiscalYear],A.[T$PDAT_FiscalPeriod]
		
	--Booking Overall 
	SELECT @BookingTotal=ISNULL(SUM([Booking]),0)
	FROM [#Booking]
	WHERE [Plant]=@Plant
	
	--Booking Buffer Order 
	SELECT @BufferBuffer =ISNULL(SUM([Booking]),0)
	FROM [#Booking]
	WHERE  [T$PDAT_FiscalYear] = '2099' AND [T$PDAT_FiscalPeriod] = 1
			AND [Plant]=@Plant
			
	--Booking After
	SELECT @BookingAfter=ISNULL(SUM([Booking]),0)
	FROM [#Booking]
	WHERE [T$PDAT_FiscalYear] IS NULL
		  AND [Plant]=@Plant
		  
	SET @BookingSQLString=@BookingSQLString+ ', '+ CONVERT(VARCHAR(50),@BookingAfter)+ ', '+ CONVERT(VARCHAR(50),@BufferBuffer)+ ', '+ CONVERT(VARCHAR(50),@BookingTotal)+ ')'
	SET @TargetSQLString=@TargetSQLString+ ', 0, 0, '+ CONVERT(VARCHAR(50),@Target)+ ')'
	SET @GapSQLString=@GapSQLString+ ', 0, 0, '+ CONVERT(VARCHAR(50),@Gap)+ ')'
	EXEC(@BookingSQLString)
	EXEC(@TargetSQLString)
	EXEC(@GapSQLString)


	SELECT * FROM [#BookingStatus]

	----Delete Table
	DROP TABLE [#Booking]
	DROP TABLE [#OverallPeriod]	
	DROP TABLE [#BookingStatus]
END

GO
