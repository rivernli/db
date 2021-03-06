USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_MSS_MSSBookingTrendAnalysis]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 


CREATE  procedure [dbo].[sp_MSS_MSSBookingTrendAnalysis]
	@Period VARCHAR(20)
	, @Plant VARCHAR(10)
as
begin
	IF @Plant='B1'
		SET @Plant='P2'
	SET ansi_warnings off
	--CurrentFiscalDate
	DECLARE @CurrentDay DATETIME
	DECLARE @CurrentFiscalYear VARCHAR(4)--当前
	DECLARE @CurrentFiscalPeriod VARCHAR(2)-- 当前
	DECLARE @CurrentFiscal DATETIME
	DECLARE @CurrentFiscalPeriodStartDay DATETIME-- 当前Period 第一天
	

	SELECT @CurrentDay=CONVERT(DATETIME, CONVERT(varchar(100), [UpTime] , 112)) FROM [Multek_ZH].[dbo].[MSS_UpTime]
	SELECT @CurrentFiscalYear=substring([FiscalYearDesc],3,4),@CurrentFiscalPeriod=CONVERT(VARCHAR,FiscalPeriod) FROM  [DataWarehouse].[dbo].[DW_DIM_Calender]
	WHERE DATEDIFF(DAY,CalenderDate,GETDATE())=0
	SELECT @CurrentFiscal=CONVERT(DATETIME,@CurrentFiscalYear+'-'+@CurrentFiscalPeriod+'-01')
	SELECT TOP(1) @CurrentFiscalPeriodStartDay=CalenderDate FROM  [DataWarehouse].[dbo].[DW_DIM_Calender]
	WHERE [FiscalYearDesc]='FY'+@CurrentFiscalYear AND FiscalPeriod=@CurrentFiscalPeriod
	ORDER BY CalenderDate
	
	--#CurrentCalender
	IF (SELECT object_ID('tempdb..#CurrentCalender')) >0
			DROP TABLE [dbo].[#CurrentCalender]
	SELECT [calenderDate] 
	INTO  [#CurrentCalender]
	FROM  [DataWarehouse].[dbo].[DW_DIM_Calender] 
	WHERE [FiscalYearDesc]='FY'+@CurrentFiscalYear AND [FiscalPeriod]=@CurrentFiscalPeriod 
			AND [calenderDate]<@CurrentDay
	ORDER BY [calenderDate] DESC
			
	DECLARE @BookingSQLString VARCHAR(MAX) ,@SumSQLString VARCHAR(MAX)
	SET @SumSQLString = 'INSERT INTO [#BookingAnalysis] SELECT ''Total'''
	SET @SumSQLString = @SumSQLString+ ', SUM([PTD+Ve]), SUM([PTD-Ve]), SUM([PTD])'
	
	--#BookingAnalysis
	IF (select object_ID('tempdb..#BookingAnalysis')) >0 
		DROP TABLE [#BookingAnalysis]
	CREATE TABLE #BookingAnalysis ([Description] VARCHAR(50))
	ALTER TABLE #BookingAnalysis ADD [PTD+Ve] NUMERIC(19,4) NULL
	ALTER TABLE #BookingAnalysis ADD [PTD-Ve] NUMERIC(19,4) NULL
	ALTER TABLE #BookingAnalysis ADD [PTD] NUMERIC(19,4) NULL
	
	SET @BookingSQLString=' '
	SELECT @BookingSQLString=@BookingSQLString+ 'ALTER TABLE #BookingAnalysis ADD [' +convert(varchar(11),[calenderDate]) +'+Ve] NUMERIC(19,4) NULL '
											  + 'ALTER TABLE #BookingAnalysis ADD [' +convert(varchar(11),[calenderDate]) +'-Ve] NUMERIC(19,4) NULL '
											  + 'ALTER TABLE #BookingAnalysis ADD [' +convert(varchar(11),[calenderDate]) +'] NUMERIC(19,4) NULL '
			,@SumSQLString = @SumSQLString+ ' ,SUM([' +convert(varchar(11),[calenderDate]) +'+Ve])'
											  + ' ,SUM([' +convert(varchar(11),[calenderDate]) +'-Ve]) '
											  + ' ,SUM([' +convert(varchar(11),[calenderDate]) +'])'								  
	FROM [#CurrentCalender]
	EXEC (@BookingSQLString)
	SET @SumSQLString = @SumSQLString+ ' FROM [#BookingAnalysis]'
	
	
	
	IF @Period='next'
	BEGIN
		SELECT @CurrentFiscalYear= substring([FiscalYearDesc],3,4),@CurrentFiscalPeriod=CONVERT(VARCHAR,FiscalPeriod)  FROM  [DataWarehouse].[dbo].[DW_DIM_Calender] WHERE  DATEDIFF(MONTH,@CurrentFiscal, CONVERT(DATETIME, substring([FiscalYearDesc],3,4)+'-'+CONVERT(nvarchar(10),[FiscalPeriod])+'-01'))=1
	END	
	ELSE IF @Period='third'
	BEGIN
		SELECT @CurrentFiscalYear= substring([FiscalYearDesc],3,4),@CurrentFiscalPeriod=CONVERT(VARCHAR,FiscalPeriod)  FROM  [DataWarehouse].[dbo].[DW_DIM_Calender] WHERE  DATEDIFF(MONTH,@CurrentFiscal, CONVERT(DATETIME, substring([FiscalYearDesc],3,4)+'-'+CONVERT(nvarchar(10),[FiscalPeriod])+'-01'))=2
	END	
	
	
	
	--#TFSOLP121
	IF (SELECT object_ID('tempdb..#TFSOLP121')) >0 
		DROP TABLE [#TFSOLP121]  
	SELECT 
		[T$TRDT]
		, substring(b.[FiscalYearDesc],3,4)AS [T$PCDT_FiscalYear]
		, b.[FiscalPeriod]AS [T$PCDT_FiscalPeriod]
		, substring(c.[FiscalYearDesc],3,4)AS [T$PCDN_FiscalYear]
		, c.[FiscalPeriod]AS [T$PCDN_FiscalPeriod]
		, [T$DESC]
		, [T$TRTP]
		, [T$MAMT]AS [Old_Amout]
		, [T$MAMN]AS [New_Amout]
		INTO  [#TFSOLP121]
	FROM [Multek_ZH].[dbo].[TFSOLP121180]AS a LEFT  JOIN  [DataWarehouse].[dbo].[DW_DIM_Calender] AS b 
	ON a.[T$PCDT]=b.CalenderDate
	LEFT  JOIN  [DataWarehouse].[dbo].[DW_DIM_Calender] AS c 
	ON a.[T$PCDN]=c.CalenderDate
	WHERE  1 != 1
	
	IF @Plant='ALL'
	BEGIN
		INSERT INTO  [#TFSOLP121]
		SELECT 
			[T$TRDT]
			, substring(b.[FiscalYearDesc],3,4)AS [T$PCDT_FiscalYear]
			, b.[FiscalPeriod]AS [T$PCDT_FiscalPeriod]
			, substring(c.[FiscalYearDesc],3,4)AS [T$PCDN_FiscalYear]
			, c.[FiscalPeriod]AS [T$PCDN_FiscalPeriod]
			, [T$DESC]
			, [T$TRTP]
			, SUM([T$MAMT])AS [Old_Amout]
			, SUM([T$MAMN])AS [New_Amout]
		FROM [Multek_ZH].[dbo].[TFSOLP121180]AS a LEFT  JOIN  [DataWarehouse].[dbo].[DW_DIM_Calender] AS b 
		ON a.[T$PCDT]=b.CalenderDate
		LEFT  JOIN  [DataWarehouse].[dbo].[DW_DIM_Calender] AS c 
		ON a.[T$PCDN]=c.CalenderDate
		WHERE [T$TRDT]>=@CurrentFiscalPeriodStartDay
		GROUP BY [T$TRDT], [T$DESC], [T$TRTP], b.[FiscalYearDesc], b.[FiscalPeriod], c.[FiscalYearDesc], c.[FiscalPeriod]
	
	END
	ELSE
	BEGIN
		INSERT INTO  [#TFSOLP121]
		SELECT 
			[T$TRDT]
			, substring(b.[FiscalYearDesc],3,4)AS [T$PCDT_FiscalYear]
			, b.[FiscalPeriod]AS [T$PCDT_FiscalPeriod]
			, substring(c.[FiscalYearDesc],3,4)AS [T$PCDN_FiscalYear]
			, c.[FiscalPeriod]AS [T$PCDN_FiscalPeriod]
			, [T$DESC]
			, [T$TRTP]
			, SUM([T$MAMT])AS [Old_Amout]
			, SUM([T$MAMN])AS [New_Amout]
		FROM [Multek_ZH].[dbo].[TFSOLP121180]AS a LEFT  JOIN  [DataWarehouse].[dbo].[DW_DIM_Calender] AS b 
		ON a.[T$PCDT]=b.CalenderDate
		LEFT  JOIN  [DataWarehouse].[dbo].[DW_DIM_Calender] AS c 
		ON a.[T$PCDN]=c.CalenderDate
		WHERE [T$TRDT]>=@CurrentFiscalPeriodStartDay
				AND [T$PLNT]=@Plant
		GROUP BY [T$TRDT], [T$DESC], [T$TRTP], b.[FiscalYearDesc], b.[FiscalPeriod], c.[FiscalYearDesc], c.[FiscalPeriod]
	END
	
	
	IF @Period='current'--当前其包含以前期
	BEGIN
		UPDATE [#TFSOLP121]
		SET [T$PCDT_FiscalYear] = @CurrentFiscalYear  
			,[T$PCDT_FiscalPeriod] = @CurrentFiscalPeriod  
		WHERE [T$DESC] !='Order Intake'
		AND(
			[T$PCDT_FiscalYear] < @CurrentFiscalYear
			OR([T$PCDT_FiscalYear] = @CurrentFiscalYear AND [T$PCDT_FiscalPeriod] < @CurrentFiscalPeriod)
		)	
	END	
	

			
	--MSS
	IF (SELECT object_ID('tempdb..#MSS')) >0 
		DROP TABLE [#MSS]  
	SELECT 
		[T$TRDT]
		, [T$PCDT_FiscalYear]AS [FiscalYear]
		, [T$PCDT_FiscalPeriod]AS [FiscalPeriod]
		, [T$DESC]
		, [T$TRTP]
		, [New_Amout]AS [Amount]
	INTO  [#MSS]
	FROM [#TFSOLP121]
	WHERE  1 != 1
	
	
	INSERT INTO  [#MSS] 
	SELECT 
	  [T$TRDT]
	  , [FiscalYear]
	  , [FiscalPeriod]
	  , [T$DESC]
	  , [T$TRTP]
	  , [Amount]
	FROM(
		SELECT 
		  [T$TRDT]
		  , [T$PCDT_FiscalYear]AS [FiscalYear]
		  , [T$PCDT_FiscalPeriod]AS [FiscalPeriod]
		  , [T$DESC]
		  , [T$TRTP]
		  , SUM([New_Amout])as [Amount]
		FROM [#TFSOLP121]
		WHERE  [T$DESC] ='Order Intake'
				OR [T$DESC] ='MKT-On Hold' 
				OR [T$DESC] ='QA-On Hold'
				OR [T$DESC] ='FIN-On Hold'
				OR [T$DESC] ='MKT-Order Cancel'
		GROUP BY [T$TRDT], [T$DESC], [T$TRTP], [T$PCDT_FiscalYear], [T$PCDT_FiscalPeriod]
		
		UNION ALL
		----MKT-Release QA-Release
		SELECT 
		  [T$TRDT]
		  , [T$PCDN_FiscalYear]AS [FiscalYear]
		  , [T$PCDN_FiscalPeriod]AS [FiscalPeriod]
		  , [T$DESC]
		  , [T$TRTP]
		  , SUM([New_Amout])as [Amount]
		FROM [#TFSOLP121]
		WHERE  [T$DESC] ='MKT-Release' 
				OR [T$DESC] ='QA-Release' 
		GROUP BY [T$TRDT], [T$DESC], [T$TRTP], [T$PCDN_FiscalYear], [T$PCDN_FiscalPeriod]
		
		UNION ALL
		----FIN-Release
		SELECT 
		  [T$TRDT]
		  , [T$PCDT_FiscalYear]
		  , [T$PCDT_FiscalPeriod]
		  , [T$DESC]
		  , [T$TRTP]
		  , SUM([New_Amout])as [Amount]
		FROM [#TFSOLP121]
		WHERE  [T$DESC] ='FIN-Release' 
		GROUP BY [T$TRDT], [T$DESC], [T$TRTP], [T$PCDT_FiscalYear], [T$PCDT_FiscalPeriod]
		
		UNION ALL
		----MKT-Pull Out PPC-Pull Out
		SELECT 
		  [T$TRDT]
		  , [T$PCDT_FiscalYear]
		  , [T$PCDT_FiscalPeriod]
		  , [T$DESC]
		  , [T$TRTP]
		  , SUM([New_Amout])as [Amount]
		FROM [#TFSOLP121]
		WHERE   ([T$TRTP]='MKT-Pull Out'
					OR [T$TRTP]='PPC-Pull Out'
					OR [T$TRTP]='IOP-Pull Out'
				)
				AND ([T$PCDN_FiscalYear] != [T$PCDT_FiscalYear]
					OR ([T$PCDN_FiscalYear] = [T$PCDT_FiscalYear]
						AND [T$PCDN_FiscalPeriod] != [T$PCDT_FiscalPeriod]
					)	
				)
		GROUP BY [T$TRDT], [T$DESC], [T$TRTP], [T$PCDT_FiscalYear], [T$PCDT_FiscalPeriod]
		
		UNION ALL
		----MKT-Pull In PPC-Pull In
		SELECT 
		  [T$TRDT]
		  , [T$PCDN_FiscalYear]
		  , [T$PCDN_FiscalPeriod]
		  , [T$DESC]
		  , [T$TRTP]
		  , SUM([New_Amout])as [Amount]
		FROM [#TFSOLP121]
		WHERE   ([T$TRTP]='MKT-Pull In'
					oR [T$TRTP]='PPC-Pull In'
					oR [T$TRTP]='IOP-Pull In'
				)
				AND ([T$PCDN_FiscalYear] != [T$PCDT_FiscalYear]
					OR  [T$PCDT_FiscalYear] IS NULL
					OR ([T$PCDN_FiscalYear] = [T$PCDT_FiscalYear]
						AND [T$PCDN_FiscalPeriod] != [T$PCDT_FiscalPeriod]
						)
				)
		GROUP BY [T$TRDT], [T$DESC], [T$TRTP], [T$PCDN_FiscalYear], [T$PCDN_FiscalPeriod]
		
		UNION ALL
		----Price Change + Ve
		SELECT 
		  [T$TRDT]
		  , [T$PCDT_FiscalYear]
		  , [T$PCDT_FiscalPeriod]
		  , [T$DESC]
		  , '+'AS [T$TRTP]
		  , SUM([New_Amout]-[Old_Amout])as [Amount]
		FROM [#TFSOLP121]
		WHERE  [T$DESC]='Price Change'
			AND [New_Amout]>[Old_Amout]
		GROUP BY [T$TRDT], [T$DESC], [T$TRTP], [T$PCDT_FiscalYear], [T$PCDT_FiscalPeriod]
		
		UNION ALL
		----Price Change - Ve
		SELECT 
		  [T$TRDT]
		  , [T$PCDT_FiscalYear]
		  , [T$PCDT_FiscalPeriod]
		  , [T$DESC]
		  , '-'AS [T$TRTP]
		  , SUM([New_Amout]-[Old_Amout])as [Amount]
		FROM [#TFSOLP121]
		WHERE  [T$DESC]='Price Change'
			AND [New_Amout]< [Old_Amout]
		GROUP BY [T$TRDT], [T$DESC], [T$TRTP], [T$PCDT_FiscalYear], [T$PCDT_FiscalPeriod]
		
	)AS T
	



	--Order Intake
	SET @BookingSQLString='INSERT INTO [#BookingAnalysis] VALUES(''Order Intake'''
	--PTD
	SELECT
		@BookingSQLString=@BookingSQLString + ',' + CONVERT(VARCHAR(50),ISNULL(SUM(b.[Amount]), 0))
		+ ',0,' 
		+ CONVERT(VARCHAR(50),ISNULL(SUM(b.[Amount]), 0))
	FROM   [#CurrentCalender] AS a LEFT JOIN [#MSS]AS b
	ON a.[calenderDate]= b.[T$TRDT] 
		AND b.[T$DESC]='Order Intake'
		AND b.[FiscalYear]= @CurrentFiscalYear
		AND b.[FiscalPeriod]= @CurrentFiscalPeriod
		
	SELECT
		@BookingSQLString=@BookingSQLString + ',' + CONVERT(VARCHAR(50),ISNULL(SUM(b.[Amount]), 0))
		+ ',0,' 
		+ CONVERT(VARCHAR(50),ISNULL(SUM(b.[Amount]), 0))
	FROM   [#CurrentCalender] AS a LEFT JOIN [#MSS]AS b
	ON a.[calenderDate]= b.[T$TRDT] 
		AND  b.[T$DESC]='Order Intake'
		AND b.[FiscalYear]= @CurrentFiscalYear
		AND b.[FiscalPeriod]= @CurrentFiscalPeriod
	GROUP BY a.[calenderDate]
	ORDER BY a.[calenderDate] DESC
	EXEC(@BookingSQLString+')')
	
	
	--MKT - Pull In/Out
	SET @BookingSQLString='INSERT INTO [#BookingAnalysis] VALUES(''MKT - Pull In/Out'''
	--PTD
	SELECT 
		@BookingSQLString=@BookingSQLString + ',' + CONVERT(VARCHAR(50),ISNULL(b.[In], 0))
		+ ',' + CONVERT(VARCHAR(50),ISNULL(-c.[Out], 0))
		+ ',' + CONVERT(VARCHAR(50),ISNULL(b.[In], 0) - ISNULL(c.[Out], 0))
	FROM   (
		SELECT 
			'PTD'AS [PTD]
			,SUM([Amount])AS [In]
		FROM [#MSS]
		WHERE  [T$TRTP]='MKT-Pull In'
			AND [FiscalYear]= @CurrentFiscalYear
			AND [FiscalPeriod]= @CurrentFiscalPeriod
	)AS b 
	LEFT JOIN (
		SELECT 
			'PTD'AS [PTD]
			,SUM([Amount])AS [Out]
		FROM [#MSS]
		WHERE  [T$TRTP]='MKT-Pull Out'
			AND [FiscalYear]= @CurrentFiscalYear
			AND [FiscalPeriod]= @CurrentFiscalPeriod
	)AS c 
	ON c.[PTD]=b.[PTD]
	
	SELECT 
		@BookingSQLString=@BookingSQLString + ',' + CONVERT(VARCHAR(50),ISNULL(b.[In], 0))
		+ ',' + CONVERT(VARCHAR(50),ISNULL(-c.[Out], 0))
		+ ',' + CONVERT(VARCHAR(50),ISNULL(b.[In], 0) - ISNULL(c.[Out], 0))
	FROM   [#CurrentCalender] AS a LEFT JOIN (
		SELECT 
			[T$TRDT] 
			,SUM([Amount])AS [In]
		FROM [#MSS]
		WHERE  [T$TRTP]='MKT-Pull In'
			AND [FiscalYear]= @CurrentFiscalYear
			AND [FiscalPeriod]= @CurrentFiscalPeriod
		GROUP BY [T$TRDT] 
	)AS b
	ON a.[calenderDate]= b.[T$TRDT]
	LEFT JOIN (
		SELECT 
			[T$TRDT] 
			,SUM([Amount])AS [Out]
		FROM [#MSS]
		WHERE  [T$TRTP]='MKT-Pull Out'
			AND [FiscalYear]= @CurrentFiscalYear
			AND [FiscalPeriod]= @CurrentFiscalPeriod
		GROUP BY [T$TRDT] 
	)AS c 
	ON a.[calenderDate]= c.[T$TRDT]
	ORDER BY a.[calenderDate] DESC
	EXEC(@BookingSQLString+')')

	
	--MKT - Release/on hold
	SET @BookingSQLString='INSERT INTO [#BookingAnalysis] VALUES(''MKT - Release/on hold'''
	--PTD
	SELECT 
		@BookingSQLString=@BookingSQLString + ',' + CONVERT(VARCHAR(50),ISNULL(b.[Release], 0))
		+ ',' + CONVERT(VARCHAR(50),ISNULL(-c.[OnHold], 0))
		+ ',' + CONVERT(VARCHAR(50),ISNULL(b.[Release], 0) - ISNULL(c.[OnHold], 0))
	FROM   (
		SELECT 
			'PTD'AS [PTD]
			,SUM([Amount])AS [Release]
		FROM [#MSS]
		WHERE  [T$DESC]='MKT-Release'
			AND [FiscalYear]= @CurrentFiscalYear
			AND [FiscalPeriod]= @CurrentFiscalPeriod
	)AS b 
	LEFT JOIN (
		SELECT 
			'PTD'AS [PTD]
			,SUM([Amount])AS [OnHold]
		FROM [#MSS]
		WHERE  [T$DESC]='MKT-On Hold'
			AND [FiscalYear]= @CurrentFiscalYear
			AND [FiscalPeriod]= @CurrentFiscalPeriod
	)AS c 
	ON c.[PTD]=b.[PTD]
	
	SELECT 
		@BookingSQLString=@BookingSQLString + ',' + CONVERT(VARCHAR(50),ISNULL(b.[Release], 0))
		+ ',' + CONVERT(VARCHAR(50),ISNULL(-c.[OnHold], 0))
		+ ',' + CONVERT(VARCHAR(50),ISNULL(b.[Release], 0) - ISNULL(c.[OnHold], 0))
	FROM   [#CurrentCalender] AS a LEFT JOIN (
		SELECT 
			[T$TRDT]
			,SUM([Amount])AS [Release]
		FROM [#MSS]
		WHERE  [T$DESC]='MKT-Release'
			AND [FiscalYear]= @CurrentFiscalYear
			AND [FiscalPeriod]= @CurrentFiscalPeriod
		GROUP BY [T$TRDT] 
	)AS b
	ON a.[calenderDate]= b.[T$TRDT]
	LEFT JOIN (
		SELECT 
			[T$TRDT]
			,SUM([Amount])AS [OnHold]
		FROM [#MSS]
		WHERE  [T$DESC]='MKT-On Hold'
			AND [FiscalYear]= @CurrentFiscalYear
			AND [FiscalPeriod]= @CurrentFiscalPeriod
		GROUP BY [T$TRDT] 
	)AS c 
	ON a.[calenderDate]= c.[T$TRDT]
	ORDER BY a.[calenderDate] DESC
	EXEC(@BookingSQLString+')')	
	
	
	
	
	--PPC  - Pull In/Out
	SET @BookingSQLString='INSERT INTO [#BookingAnalysis] VALUES(''PPC  - Pull In/Out'''
	--PTD
	SELECT 
		@BookingSQLString=@BookingSQLString + ',' + CONVERT(VARCHAR(50),ISNULL(b.[In], 0))
		+ ',' + CONVERT(VARCHAR(50),ISNULL(-c.[Out], 0))
		+ ',' + CONVERT(VARCHAR(50),ISNULL(b.[In], 0) - ISNULL(c.[Out], 0))
	FROM   (
		SELECT 
			'PTD'AS [PTD]
			,SUM([Amount])AS [In]
		FROM [#MSS]
		WHERE   ([T$TRTP]='PPC-Pull In' OR [T$TRTP]='IOP-Pull In')--IOP-Pull In 算入PPC-Pull In
			AND [FiscalYear]= @CurrentFiscalYear
			AND [FiscalPeriod]= @CurrentFiscalPeriod
	)AS b
	LEFT JOIN (
		SELECT 
			'PTD'AS [PTD]
			,SUM([Amount])AS [Out]
		FROM [#MSS]
		WHERE  ([T$TRTP]='PPC-Pull Out' OR [T$TRTP]='IOP-Pull Out')--IOP-Pull Out 算入PPC-Pull Out
			AND [FiscalYear]= @CurrentFiscalYear
			AND [FiscalPeriod]= @CurrentFiscalPeriod
	)AS c 
	ON c.[PTD]=b.[PTD]
	
	SELECT 
		@BookingSQLString=@BookingSQLString + ',' + CONVERT(VARCHAR(50),ISNULL(b.[In], 0))
		+ ',' + CONVERT(VARCHAR(50),ISNULL(-c.[Out], 0))
		+ ',' + CONVERT(VARCHAR(50),ISNULL(b.[In], 0) - ISNULL(c.[Out], 0))
	FROM   [#CurrentCalender] AS a LEFT JOIN (
		SELECT 
			[T$TRDT]
			,SUM([Amount])AS [In]
		FROM [#MSS]
		WHERE  ([T$TRTP]='PPC-Pull In' OR [T$TRTP]='IOP-Pull In')--IOP-Pull In 算入PPC-Pull In
			AND [FiscalYear]= @CurrentFiscalYear
			AND [FiscalPeriod]= @CurrentFiscalPeriod
		GROUP BY [T$TRDT]  
	)AS b
	ON a.[calenderDate]= b.[T$TRDT]
	LEFT JOIN (
		SELECT 
			[T$TRDT] 
			,SUM([Amount])AS [Out]
		FROM [#MSS]
		WHERE  ([T$TRTP]='PPC-Pull Out' OR [T$TRTP]='IOP-Pull Out')--IOP-Pull Out 算入PPC-Pull Out
			AND [FiscalYear]= @CurrentFiscalYear
			AND [FiscalPeriod]= @CurrentFiscalPeriod
		GROUP BY [T$TRDT] 
	)AS c 
	ON a.[calenderDate]= c.[T$TRDT]
	ORDER BY a.[calenderDate] DESC
	EXEC(@BookingSQLString+')')	
	
	
	--QA - Release/ on hold
	SET @BookingSQLString='INSERT INTO [#BookingAnalysis] VALUES(''QA - Release/on hold'''
	--PTD
	SELECT 
		@BookingSQLString=@BookingSQLString + ',' + CONVERT(VARCHAR(50),ISNULL(b.[Release], 0))
		+ ',' + CONVERT(VARCHAR(50),ISNULL(-c.[OnHold], 0))
		+ ',' +CONVERT(VARCHAR(50),ISNULL(b.[Release], 0) - ISNULL(c.[OnHold], 0))
	FROM   (
		SELECT 
			'PTD'AS [PTD]
			,SUM([Amount])AS [Release]
		FROM [#MSS]
		WHERE  [T$DESC]='QA-Release'
			AND [FiscalYear]= @CurrentFiscalYear
			AND [FiscalPeriod]= @CurrentFiscalPeriod
	)AS b 
	LEFT JOIN (
		SELECT 
			'PTD'AS [PTD]
			,SUM([Amount])AS [OnHold]
		FROM [#MSS]
		WHERE  [T$DESC]='QA-On Hold'
			AND [FiscalYear]= @CurrentFiscalYear
			AND [FiscalPeriod]= @CurrentFiscalPeriod
	)AS c 
	ON c.[PTD]=b.[PTD]
	
	SELECT 
		@BookingSQLString=@BookingSQLString + ',' + CONVERT(VARCHAR(50),ISNULL(b.[Release], 0))
		+ ',' + CONVERT(VARCHAR(50),ISNULL(-c.[OnHold], 0))
		+ ',' + CONVERT(VARCHAR(50),ISNULL(b.[Release], 0) - ISNULL(c.[OnHold], 0))
	FROM   [#CurrentCalender] AS a LEFT JOIN (
		SELECT 
			[T$TRDT]
			,SUM([Amount])AS [Release]
		FROM [#MSS]
		WHERE  [T$DESC]='QA-Release'
			AND [FiscalYear]= @CurrentFiscalYear
			AND [FiscalPeriod]= @CurrentFiscalPeriod
		GROUP BY [T$TRDT] 
	)AS b
	ON a.[calenderDate]= b.[T$TRDT]
	LEFT JOIN (
		SELECT 
			[T$TRDT]
			,SUM([Amount])AS [OnHold]
		FROM [#MSS]
		WHERE  [T$DESC]='QA-On Hold'
			AND [FiscalYear]= @CurrentFiscalYear
			AND [FiscalPeriod]= @CurrentFiscalPeriod
		GROUP BY [T$TRDT] 
	)AS c 
	ON a.[calenderDate]= c.[T$TRDT]
	ORDER BY a.[calenderDate] DESC
	EXEC(@BookingSQLString+')')
	
	
	--FIN - Release/on hold
	SET @BookingSQLString='INSERT INTO [#BookingAnalysis] VALUES(''FIN - Release/on hold'''
	--PTD
	SELECT 
		@BookingSQLString=@BookingSQLString + ',' + CONVERT(VARCHAR(50),ISNULL(b.[Release], 0))
		+ ',' + CONVERT(VARCHAR(50),ISNULL(-c.[OnHold], 0))
		+ ',' + CONVERT(VARCHAR(50),ISNULL(b.[Release], 0) - ISNULL(c.[OnHold], 0))
	FROM   (
		SELECT 
			'PTD'AS [PTD]
			,SUM([Amount])AS [Release]
		FROM [#MSS]
		WHERE  [T$DESC]='FIN-Release'
			AND [FiscalYear]= @CurrentFiscalYear
			AND [FiscalPeriod]= @CurrentFiscalPeriod
	)AS b 
	LEFT JOIN (
		SELECT 
			'PTD'AS [PTD]
			,SUM([Amount])AS [OnHold]
		FROM [#MSS]
		WHERE  [T$DESC]='FIN-On Hold'
			AND [FiscalYear]= @CurrentFiscalYear
			AND [FiscalPeriod]= @CurrentFiscalPeriod
	)AS c 
	ON c.[PTD]=b.[PTD]
	
	SELECT 
		@BookingSQLString=@BookingSQLString + ',' + CONVERT(VARCHAR(50),ISNULL(b.[Release], 0))
		+ ',' + CONVERT(VARCHAR(50),ISNULL(-c.[OnHold], 0))
		+ ',' + CONVERT(VARCHAR(50),ISNULL(b.[Release], 0) - ISNULL(c.[OnHold], 0))
	FROM   [#CurrentCalender] AS a LEFT JOIN (
		SELECT 
			[T$TRDT]
			,SUM([Amount])AS [Release]
		FROM [#MSS]
		WHERE  [T$DESC]='FIN-Release'
			AND [FiscalYear]= @CurrentFiscalYear
			AND [FiscalPeriod]= @CurrentFiscalPeriod
		GROUP BY [T$TRDT] 
	)AS b
	ON a.[calenderDate]= b.[T$TRDT]
	LEFT JOIN (
		SELECT 
			[T$TRDT]
			,SUM([Amount])AS [OnHold]
		FROM [#MSS]
		WHERE  [T$DESC]='FIN-On Hold'
			AND [FiscalYear]= @CurrentFiscalYear
			AND [FiscalPeriod]= @CurrentFiscalPeriod
		GROUP BY [T$TRDT] 
	)AS c 
	ON a.[calenderDate]= c.[T$TRDT]
	ORDER BY a.[calenderDate] DESC
	EXEC(@BookingSQLString+')')
	
	
	--Price Change        
	SET @BookingSQLString='INSERT INTO [#BookingAnalysis] VALUES(''Price Change'''
	--PTD
	SELECT
		@BookingSQLString=@BookingSQLString + ',' + CONVERT(VARCHAR(50),ISNULL(b.[Release], 0))
		+ ',' + CONVERT(VARCHAR(50),ISNULL(c.[OnHold], 0))
		+ ',' + CONVERT(VARCHAR(50),ISNULL(b.[Release], 0) + ISNULL(c.[OnHold], 0))
	FROM   (
		SELECT 
			'PTD'AS [PTD]
			,SUM([Amount])AS [Release]
		FROM [#MSS]
		WHERE  [T$DESC]='Price Change'
			AND [T$TRTP] = '+'
			AND [FiscalYear]= @CurrentFiscalYear
			AND [FiscalPeriod]= @CurrentFiscalPeriod
	)AS b
	LEFT JOIN (
		SELECT 
			'PTD'AS [PTD]
			,SUM([Amount])AS [OnHold]
		FROM [#MSS]
		WHERE  [T$DESC]='Price Change'
			AND [T$TRTP] = '-'
			AND [FiscalYear]= @CurrentFiscalYear
			AND [FiscalPeriod]= @CurrentFiscalPeriod
	)AS c 
	ON c.[PTD]=b.[PTD]
	
	SELECT
		@BookingSQLString=@BookingSQLString + ',' + CONVERT(VARCHAR(50),ISNULL(b.[Release], 0))
		+ ',' + CONVERT(VARCHAR(50),ISNULL(c.[OnHold], 0))
		+ ',' + CONVERT(VARCHAR(50),ISNULL(b.[Release], 0) + ISNULL(c.[OnHold], 0))
	FROM   [#CurrentCalender] AS a LEFT JOIN (
		SELECT 
			[T$TRDT]
			,SUM([Amount])AS [Release]
		FROM [#MSS]
		WHERE  [T$DESC]='Price Change'
			AND [T$TRTP] = '+'
			AND [FiscalYear]= @CurrentFiscalYear
			AND [FiscalPeriod]= @CurrentFiscalPeriod
		GROUP BY [T$TRDT] 
	)AS b
	ON a.[calenderDate]= b.[T$TRDT]
	LEFT JOIN (
		SELECT 
			[T$TRDT]
			,SUM([Amount])AS [OnHold]
		FROM [#MSS]
		WHERE  [T$DESC]='Price Change'
			AND [T$TRTP] = '-'
			AND [FiscalYear]= @CurrentFiscalYear
			AND [FiscalPeriod]= @CurrentFiscalPeriod
		GROUP BY [T$TRDT] 
	)AS c 
	ON a.[calenderDate]= c.[T$TRDT]
	ORDER BY a.[calenderDate] DESC
	EXEC(@BookingSQLString+')')
	
	
	--Total
	EXEC(@SumSQLString)
	
	
	--MKT-Order Cancel    
	SET @BookingSQLString='INSERT INTO [#BookingAnalysis] VALUES(''MKT-Order Cancel'''
	--PTD
	SELECT
		@BookingSQLString=@BookingSQLString + ',0'
		+ ',' + CONVERT(VARCHAR(50),ISNULL(SUM(-b.[Amount]), 0))
		+ ',' + CONVERT(VARCHAR(50),ISNULL(SUM(-b.[Amount]), 0))
	FROM   [#CurrentCalender] AS a LEFT JOIN [#MSS]AS b
	ON a.[calenderDate]= b.[T$TRDT] 
		AND b.[T$DESC]='MKT-Order Cancel'
		AND b.[FiscalYear]= @CurrentFiscalYear
		AND b.[FiscalPeriod]= @CurrentFiscalPeriod
		
	SELECT
		@BookingSQLString=@BookingSQLString + ',0' 
		+ ',' + CONVERT(VARCHAR(50),ISNULL(SUM(-b.[Amount]), 0))
		+ ',' + CONVERT(VARCHAR(50),ISNULL(SUM(-b.[Amount]), 0))
	FROM   [#CurrentCalender] AS a LEFT JOIN [#MSS]AS b
	ON a.[calenderDate]= b.[T$TRDT] 
		AND b.[T$DESC]='MKT-Order Cancel'
		AND b.[FiscalYear]= @CurrentFiscalYear
		AND b.[FiscalPeriod]= @CurrentFiscalPeriod
	GROUP BY a.[calenderDate]
	ORDER BY a.[calenderDate] DESC
	EXEC(@BookingSQLString+')')
	
	
			
	SELECT * FROM [#BookingAnalysis] 
	--Delete Table
	DROP TABLE [#CurrentCalender]
	DROP TABLE [#MSS]  
	DROP TABLE [#BookingAnalysis]
  
  
	
END









GO
