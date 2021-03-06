USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_MSS_MSSOrderBookingSummary]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 


CREATE  procedure [dbo].[sp_MSS_MSSOrderBookingSummary]

as
begin
	
	--CurrentFiscalDate
	DECLARE @CurrentDay DATETIME
	DECLARE @CurrentFiscalYear VARCHAR(4)
	DECLARE @CurrentFiscalPeriod VARCHAR(2)
	DECLARE @CurrentFiscal DATETIME

	SELECT @CurrentDay=CONVERT(DATETIME, CONVERT(varchar(100), [UpTime] , 112)) FROM [Multek_ZH].[dbo].[MSS_UpTime]
	SELECT @CurrentFiscalYear=substring([FiscalYearDesc],3,4),@CurrentFiscalPeriod=CONVERT(VARCHAR,FiscalPeriod) FROM  [DataWarehouse].[dbo].[DW_DIM_Calender]
	WHERE DATEDIFF(DAY,CalenderDate,GETDATE())=0
	SELECT @CurrentFiscal=CONVERT(DATETIME,@CurrentFiscalYear+'-'+@CurrentFiscalPeriod+'-01')

	
	
	--OverallPeriod
	IF (select object_ID('tempdb..#OverallPeriod')) >0 
		DROP TABLE [#OverallPeriod]
	SELECT TOP(6)
		  [T$PDAT_FiscalYear]
		  ,[T$PDAT_FiscalPeriod]
	INTO #OverallPeriod
	FROM [MSS_MSS_ByPlant]
	WHERE [T$JDAT]=@CurrentDay
		AND([T$PDAT_FiscalYear] > @CurrentFiscalYear
			OR([T$PDAT_FiscalYear] = @CurrentFiscalYear AND [T$PDAT_FiscalPeriod] >= @CurrentFiscalPeriod)
			)
		AND [T$PDAT_FiscalYear] != 2099	
	GROUP BY [T$PDAT_FiscalYear],[T$PDAT_FiscalPeriod]
	ORDER BY [T$PDAT_FiscalYear],[T$PDAT_FiscalPeriod]
	
	--Booking 当前其包含以前期的Booking
	IF (select object_ID('tempdb..#Booking')) >0 
		DROP TABLE [#Booking]
	SELECT [T$PDAT_FiscalYear]
		  ,[T$PDAT_FiscalPeriod]
		  ,[Plant]
		  ,ISNULL(SUM([Booking]), 0)  AS Booking
	INTO [#Booking]
	FROM (
		SELECT 
			  T2.[T$PDAT_FiscalYear]
			  , T2.[T$PDAT_FiscalPeriod]
			  , T2.[Plant]
			  ,SUM([Amount])AS Booking
		FROM  [#OverallPeriod] AS T1 LEFT JOIN  [MSS_MSS_ByPlant] AS T2
					ON T1.[T$PDAT_FiscalYear]= T2.[T$PDAT_FiscalYear] AND  T1.[T$PDAT_FiscalPeriod]= T2.[T$PDAT_FiscalPeriod]
		WHERE [T$JDAT]= @CurrentDay 
		GROUP BY T2.[Plant], T2.[T$PDAT_FiscalYear], T2.[T$PDAT_FiscalPeriod]
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
	
	
	--#MSS Booking
	IF (select object_ID('tempdb..#MSSBooking')) >0 
		DROP TABLE [#MSSBooking]
	SELECT 
	   [T$PDAT_FiscalYear]
	   ,[T$PDAT_FiscalPeriod]
	   ,[B1], [2F], [B3], [B4], [B5], [HK]
    INTO [#MSSBooking]
	FROM [#Booking] AS [SourceTable]
	PIVOT (
	   SUM([Booking])
	   FOR [Plant] IN (
		  [B1], [2F], [B3], [B4], [B5], [HK]
	   )
	) AS [PivotTable]
	ORDER BY [T$PDAT_FiscalYear], [T$PDAT_FiscalPeriod]
	
	
	--#MSS Order Booking Summary (KUSD)
	IF (select object_ID('tempdb..#BookingSummary')) >0 
		DROP TABLE [#BookingSummary]
		
	--Shipment ahead
	SELECT 
		'Shipment ahead to ' + dbo.fun_Get_Full_Period_Name(@CurrentFiscalYear, @CurrentFiscalPeriod) AS [Duration]
		, [B1]
		, [2F]AS [B2F]
		, [B3]
		, [B4]
		, [B5]
		, [HK]AS [VVI]
		, ([B1] + [2F] + [B3] + [B4] + [B5] + [HK]) AS Overall
		, 0 AS WeeklyBooking
	INTO [#BookingSummary]
	FROM (
		SELECT  
		  a.[Plant]
		  ,ISNULL(SUM(b.[Amount]), 0) AS [Number]
		FROM (SELECT 'B1'AS [Plant] 
		UNION ALL SELECT  '2F'AS [Plant] 
		UNION ALL SELECT  'B3'AS [Plant] 
		UNION ALL SELECT  'B4'AS [Plant] 
		UNION ALL SELECT  'B5'AS [Plant] 
		UNION ALL SELECT  'HK'AS [Plant]
		)AS a LEFT JOIN [MSS_AheadFGOut_ByOrder] AS b
		ON a.[Plant]=b.[Plant]
			AND b.[T$JDAT]=@CurrentDay 
			AND b.[T$AJSD_FiscalYear]=@CurrentFiscalYear
			AND b.[T$AJSD_FiscalPeriod]=@CurrentFiscalPeriod
		GROUP BY a.[Plant]
	) AS [SourceTable]
	PIVOT (
	   SUM([Number])
	   FOR [Plant] IN (
		  [B1], [2F], [B3], [B4], [B5], [HK]
	   )
	) AS [PivotTable]
	
	
	--MSS
	INSERT INTO [#BookingSummary]
	SELECT  
		dbo.fun_Get_Full_Period_Name([T$PDAT_FiscalYear], [T$PDAT_FiscalPeriod]) AS Duration
		, ISNULL([B1], 0) AS B1
		, ISNULL([2F], 0) AS [B2F]
		, ISNULL([B3], 0) AS B3
		, ISNULL([B4], 0) AS B4
		, ISNULL([B5], 0) AS B5
		, ISNULL([HK], 0) AS [VVI]
		, (ISNULL([B1], 0) + ISNULL([2F], 0) + ISNULL([B3], 0) + ISNULL([B4], 0) + ISNULL([B5], 0) + ISNULL([HK], 0)) AS Overall
		, (ISNULL([B1], 0) + ISNULL([2F], 0) + ISNULL([B3], 0) + ISNULL([B4], 0) + ISNULL([B5], 0) + ISNULL([HK], 0))
			/(SELECT COUNT(*) FROM  (SELECT [FiscalWeek] FROM [DataWarehouse].[dbo].[DW_DIM_Calender] WHERE substring([FiscalYearDesc],3,4)=[#MSSBooking].[T$PDAT_FiscalYear] AND FiscalPeriod=[#MSSBooking].[T$PDAT_FiscalPeriod] GROUP BY [FiscalWeek])AS T)
			 AS WeeklyBooking
	FROM [#MSSBooking]

	--Next 
	DECLARE @FiscalYear VARCHAR(4)
	DECLARE @FiscalPeriod VARCHAR(2)
	SELECT @FiscalYear= substring([FiscalYearDesc],3,4),@FiscalPeriod=CONVERT(VARCHAR,FiscalPeriod)  FROM  [DataWarehouse].[dbo].[DW_DIM_Calender] WHERE  DATEDIFF(MONTH,@CurrentFiscal, CONVERT(DATETIME, substring([FiscalYearDesc],3,4)+'-'+CONVERT(nvarchar(10),[FiscalPeriod])+'-01'))=5
	
	INSERT INTO [#BookingSummary]
	SELECT 
		'Next of ' + dbo.fun_Get_Full_Period_Name(@FiscalYear, @FiscalPeriod) AS [Duration]
		, ISNULL([B1], 0) AS B1
		, ISNULL([2F], 0) AS[B2F]
		, ISNULL([B3], 0) AS B3
		, ISNULL([B4], 0) AS B4
		, ISNULL([B5], 0) AS B5
		, ISNULL([HK], 0) AS [VVI]
		, (ISNULL([B1], 0) + ISNULL([2F], 0) + ISNULL([B3], 0) + ISNULL([B4], 0) + ISNULL([B5], 0) + ISNULL([HK], 0)) AS Overall
		, 0 AS WeeklyBooking
	FROM (
		SELECT 
			  [Plant]
			  ,SUM([Amount])AS [Booking]
		FROM [MSS_MSS_ByPlant]
		WHERE [T$JDAT]=@CurrentDay
			AND([T$PDAT_FiscalYear] > @FiscalYear
			OR([T$PDAT_FiscalYear] = @FiscalYear AND [T$PDAT_FiscalPeriod] > @FiscalPeriod)
			OR [T$PDAT_FiscalYear]IS NULL
			)
		GROUP BY [Plant]
	) AS [SourceTable]
	PIVOT (
	   SUM([Booking])
	   FOR [Plant] IN (
		  [B1], [2F], [B3], [B4], [B5], [HK]
	   )
	) AS [PivotTable]
	
	
	--On hold
	INSERT INTO [#BookingSummary]
	SELECT 
		'On hold' AS Duration
		, ISNULL([B1], 0) AS B1
		, ISNULL([B2F], 0) AS[B2F]
		, ISNULL([B3], 0) AS B3
		, ISNULL([B4], 0) AS B4
		, ISNULL([B5], 0) AS B5
		, ISNULL([VVI], 0) AS [VVI]
		, (ISNULL([B1], 0) + ISNULL([B2F], 0) + ISNULL([B3], 0) + ISNULL([B4], 0) + ISNULL([B5], 0) + ISNULL([VVI], 0)) AS Overall
		, 0 AS WeeklyBooking
	FROM (
		--On hold
		SELECT  
			[T$PLNT] AS [Plant]
			,SUM([T$AMNT]) AS [OnHold]
		FROM [TFSOLP120180]
		WHERE  [T$DATE]= DATEADD(DAY, -1, CONVERT(DATETIME, CONVERT(varchar(100), getdate(), 112)))
		GROUP BY [T$PLNT]
	) AS [SourceTable]
	PIVOT (
	   SUM([OnHold])
	   FOR [Plant] IN (
		  [B1], [B2F], [B3], [B4], [B5], [VVI]
	   )
	) AS [PivotTable]
	
	
	
	
	
	SELECT * FROM [#BookingSummary]
	UNION ALL
	-- Total order on hand
	SELECT  
		'Total order on hand' AS [Duration]
		, SUM([B1]) AS B1
		, SUM([B2F]) AS B2F
		, SUM([B3]) AS B3
		, SUM([B4]) AS B4
		, SUM([B5]) AS B5
		, SUM([VVI]) AS [VVI]
		, SUM([Overall]) AS [Overall]
		, 0 AS WeeklyBooking
	FROM [#BookingSummary]
	
	

		
  



	--Delete Table
	DROP TABLE [#OverallPeriod]
	DROP TABLE [#MSSBooking]
	DROP TABLE [#BookingSummary]




	
END









GO
