USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_MSS_BookingFGStatus]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 


CREATE  procedure [dbo].[sp_MSS_BookingFGStatus]
	@Plant	VARCHAR(10)
as
begin
	
	--CurrentFiscalDate
	DECLARE @CurrentDay DATETIME
	DECLARE @CurrentFiscalYear VARCHAR(4)
	DECLARE @CurrentFiscalPeriod VARCHAR(2)

	SET @CurrentDay=CONVERT(DATETIME, CONVERT(varchar(100), getdate(), 112))
	SELECT @CurrentDay=CONVERT(DATETIME, CONVERT(varchar(100), [UpTime] , 112)) FROM [Multek_ZH].[dbo].[MSS_UpTime]
	
	SELECT @CurrentFiscalYear= substring([FiscalYearDesc],3,4),@CurrentFiscalPeriod=CONVERT(VARCHAR,FiscalPeriod) FROM  [DataWarehouse].[dbo].[DW_DIM_Calender]
	WHERE CalenderDate=@CurrentDay

	--OverallPeriod
	if (select object_ID('tempdb..#OverallPeriod')) >0 
		DROP TABLE [#OverallPeriod]
	SELECT FiscalYear
		  ,FiscalPeriod
	INTO #OverallPeriod
	FROM (
		SELECT [T$PDAT_FiscalYear] AS FiscalYear
			  ,[T$PDAT_FiscalPeriod] AS FiscalPeriod
		FROM [MSS_MSS_ByPlant]
		WHERE [T$JDAT]=@CurrentDay
			  AND(
					[T$PDAT_FiscalYear] > @CurrentFiscalYear
					OR([T$PDAT_FiscalYear] = @CurrentFiscalYear AND [T$PDAT_FiscalPeriod] >= @CurrentFiscalPeriod)
			  )
	)AS T
	WHERE [FiscalYear] != 2099
	GROUP BY FiscalYear,FiscalPeriod
	ORDER BY FiscalYear,FiscalPeriod



	DECLARE @BookingSQLString VARCHAR(MAX),  @TargetSQLString  VARCHAR(MAX), @GapSQLString  VARCHAR(MAX), @FGoutSQLString  VARCHAR(MAX), @FGSQLString  VARCHAR(MAX), @BlanceSQLString  VARCHAR(MAX), @AheadSQLString  VARCHAR(MAX)
	DECLARE @BookingTotal NUMERIC(19,4),@Booking NUMERIC(19,4),@BookingBuffer NUMERIC(19,4),@BookingAfter NUMERIC(19,4), @Target NUMERIC(19,4), @Gap NUMERIC(19,4), @FG NUMERIC(19,4),@Blance NUMERIC(19,4), @FGBuffer NUMERIC(19,4),@BlanceBuffer NUMERIC(19,4), @FGTotal NUMERIC(19,4), @BlanceTotal NUMERIC(19,4), @FGAfter NUMERIC(19,4), @BlanceAfter NUMERIC(19,4), @FGout NUMERIC(19,4), @Ahead NUMERIC(19,4)
	--#BookingStatus

	if (select object_ID('tempdb..#BookingStatus')) >0 
		DROP TABLE [#BookingStatus]
	CREATE TABLE #BookingStatus (Item VARCHAR(50))
	SET @BookingSQLString=' ALTER TABLE #BookingStatus ADD Item1 VARCHAR(50) NULL '
	SELECT @BookingSQLString=@BookingSQLString+ 'ALTER TABLE #BookingStatus ADD [' + dbo.fun_Get_Full_Period_Name([FiscalYear], [FiscalPeriod]) +'] NUMERIC(19,4) NULL '
							+ 'ALTER TABLE #BookingStatus ADD [P' + dbo.fun_Get_Full_Period_Name([FiscalYear], [FiscalPeriod]) + '_%] NUMERIC(19,4) NULL '
	FROM #OverallPeriod
	EXEC (@BookingSQLString)
	ALTER TABLE #BookingStatus ADD [After Period] NUMERIC(19,4) NULL
	ALTER TABLE #BookingStatus ADD [Buffer Order] NUMERIC(19,4) NULL
	ALTER TABLE #BookingStatus ADD Overall NUMERIC(19,4) NULL



	SET @Booking=0
	SET @Target=0
	SET @Gap=0
	SET @BookingBuffer =0
	SET @FG=0
	SET @FGAfter=0
	SET @Blance=0
	SET @FGBuffer=0
	SET @BlanceAfter=0
	SET @FGout=0
	SET @Ahead=0

	SET @BookingSQLString='INSERT INTO #BookingStatus VALUES(''Booking'','''''
	SET @TargetSQLString='INSERT INTO #BookingStatus VALUES(''Target'','''''
	SET @GapSQLString='INSERT INTO #BookingStatus VALUES(''Gap'','''''
	SET @FGoutSQLString ='INSERT INTO #BookingStatus VALUES(''F.G Out'','''''
	SET @FGSQLString='INSERT INTO #BookingStatus VALUES(''Order Backlog'',''F.G'''
	SET @BlanceSQLString='INSERT INTO #BookingStatus VALUES(''Order Backlog'',''Blance to build'''
	SET @AheadSQLString  ='INSERT INTO #BookingStatus VALUES(''Ahead F.G Out'','''''


	IF @Plant='ALL'
	BEGIN
		
		--Booking
		SELECT
			  @BookingSQLString=@BookingSQLString+ ', ' +CONVERT(VARCHAR(50),CAST(ISNULL([Booking],0)AS NUMERIC(19,4)))+', ''0'''
			  ,@Booking=@Booking+ ISNULL([Booking],0) 
			  ,@TargetSQLString=@TargetSQLString+ ', ' +CONVERT(VARCHAR(50),CAST(ISNULL([Forecast],0)AS NUMERIC(19,4)))+', ''0'''
			  ,@Target=@Target+ ISNULL([Forecast],0) 
			  ,@GapSQLString=@GapSQLString+ ', ' + (CASE WHEN [Forecast] IS NULL THEN '0' ELSE CONVERT(VARCHAR(50),CAST(ISNULL([Forecast],0)- ISNULL([Booking],0)AS NUMERIC(19,4))) END)+', ''0'''
			  ,@Gap= @Gap+ (CASE WHEN [Forecast] IS NULL THEN 0 ELSE ISNULL([Forecast],0)- ISNULL([Booking],0) END)
		FROM #OverallPeriod AS A LEFT JOIN
		(
			SELECT [T$PDAT_FiscalYear]
				  ,[T$PDAT_FiscalPeriod]
				  ,SUM([Amount]) AS Booking
			FROM [MSS_MSS_ByPlant]
			WHERE [T$JDAT]=@CurrentDay 
					AND(
					[T$PDAT_FiscalYear] > @CurrentFiscalYear
					OR([T$PDAT_FiscalYear] = @CurrentFiscalYear AND [T$PDAT_FiscalPeriod] >= @CurrentFiscalPeriod)
					)
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
		SELECT @BookingTotal=SUM([Amount])
		FROM [MSS_MSS_ByPlant]
		WHERE [T$JDAT]=@CurrentDay
		
		--Booking Buffer Order 
		SELECT @BookingBuffer =ISNULL(SUM([Amount]),0)
		FROM [MSS_MSS_ByPlant]
		WHERE  [T$JDAT]=@CurrentDay 
				AND [T$PDAT_FiscalYear] = '2099' AND [T$PDAT_FiscalPeriod] = 1
				
		--Booking After
		SELECT @BookingAfter=ISNULL(SUM([Amount]),0)
		FROM [MSS_MSS_ByPlant]
		WHERE [T$JDAT]=@CurrentDay 
			  AND [T$PDAT_FiscalYear] IS NULL
		
		-- F.G & Blance to build 
		SELECT  
		  @FGSQLString=@FGSQLString+', ' + CONVERT(VARCHAR(50),CAST(ISNULL([FGavailable],0)AS NUMERIC(19,4)))+', '+ CONVERT(VARCHAR(50),CAST(ISNULL([FGavailable],0)/(ISNULL([FGavailable],1)+ISNULL([BalanceToBuild],0)+ISNULL([FGout],0))AS NUMERIC(19,4)))
		  ,@FG=@FG+ISNULL([FGavailable],0)
		  ,@BlanceSQLString=@BlanceSQLString +', ' + CONVERT(VARCHAR(50),CAST(ISNULL([BalanceToBuild],0)AS NUMERIC(19,4)))+', '+ CONVERT(VARCHAR(50),CAST(ISNULL([BalanceToBuild],0)/(ISNULL([FGavailable],1)+ISNULL([BalanceToBuild],0)+ISNULL([FGout],0))AS NUMERIC(19,4)))
		  ,@Blance=@Blance+ISNULL([BalanceToBuild],0)
		  ,@FGout=@FGout + ISNULL([FGout],0) --FG Out
		  ,@FGoutSQLString=@FGoutSQLString  + ', ' + CONVERT(VARCHAR(50),CAST(ISNULL([FGout],0)AS NUMERIC(19,4))) + ', '+ CONVERT(VARCHAR(50),CAST(ISNULL([FGout],0)/(ISNULL([FGavailable],1)+ISNULL([BalanceToBuild],0)+ISNULL([FGout],0))AS NUMERIC(19,4)))
		FROM #OverallPeriod AS A LEFT JOIN
		(
			SELECT [T$PDAT_FiscalYear]
			  ,[T$PDAT_FiscalPeriod]
			  ,SUM([FGavailable])AS FGavailable
			  ,SUM([BalanceToBuild])AS BalanceToBuild
			FROM [MSS_OrderBacklog_ByOrder]
			WHERE [T$JDAT]=@CurrentDay 
			AND(
				[T$PDAT_FiscalYear] > @CurrentFiscalYear
				OR([T$PDAT_FiscalYear] = @CurrentFiscalYear AND [T$PDAT_FiscalPeriod] >= @CurrentFiscalPeriod)
			) 
			GROUP BY [T$PDAT_FiscalYear],[T$PDAT_FiscalPeriod] 
		)AS B
		ON  A.[FiscalYear]=B.[T$PDAT_FiscalYear] AND A.[FiscalPeriod]=B.[T$PDAT_FiscalPeriod]
		LEFT JOIN 
		(
			SELECT 
			[T$AJSD_FiscalYear]
			,[T$AJSD_FiscalPeriod]
			,SUM([FGout])AS FGout
			FROM [MSS_FGOut_ByOrder]
			WHERE [T$JDAT]=@CurrentDay 
			AND(
				[T$AJSD_FiscalYear] > @CurrentFiscalYear
				OR([T$AJSD_FiscalYear] = @CurrentFiscalYear AND [T$AJSD_FiscalPeriod] >= @CurrentFiscalPeriod)
				) 
			GROUP BY [T$AJSD_FiscalYear],[T$AJSD_FiscalPeriod]
		)AS C
		ON A.[FiscalYear]=C.[T$AJSD_FiscalYear] AND A.[FiscalPeriod]=C.[T$AJSD_FiscalPeriod]
		ORDER BY A.FiscalYear,A.FiscalPeriod

				
		
		--F.G & Blance to build    Overall 
		SELECT  
		  @FGTotal=SUM([FGavailable])
		  ,@BlanceTotal=SUM([BalanceToBuild])
		FROM [MSS_OrderBacklog_ByOrder]
		WHERE [T$JDAT]=@CurrentDay 
			
				
		-- F.G & Blance to build    Buffer Order 
		SELECT @FGBuffer=ISNULL(SUM([FGavailable]),0)
		  ,@BlanceBuffer=ISNULL(SUM([BalanceToBuild]),0)
		FROM [MSS_OrderBacklog_ByOrder]
		WHERE [T$JDAT]=@CurrentDay
		AND [T$PDAT_FiscalYear] = '2099' AND [T$PDAT_FiscalPeriod] = 1
		
		--F.G & Blance to build After 
		SELECT @FGBuffer=ISNULL(SUM([FGavailable]),0)
			   ,@BlanceAfter=ISNULL(SUM([BalanceToBuild]),0)
		FROM [MSS_OrderBacklog_ByOrder]
		WHERE [T$JDAT]=@CurrentDay
			AND [T$PDAT_FiscalYear] IS NULL
			
		--Ahead F.G Out
		SELECT  
		  @Ahead=@Ahead+ISNULL([Amount],0)
		  ,@AheadSQLString= @AheadSQLString  +', ' +CONVERT(VARCHAR(50),CAST(ISNULL([Amount],0)AS NUMERIC(19,4)))+', ''0'''
		FROM #OverallPeriod AS A LEFT JOIN
		(
			SELECT  
			  [T$AJSD_FiscalYear]
			  ,[T$AJSD_FiscalPeriod]
			  ,SUM([Amount])AS [Amount]
			FROM [MSS_AheadFGOut_ByOrder]
			WHERE [T$JDAT]=@CurrentDay 
			GROUP BY [T$AJSD_FiscalYear],[T$AJSD_FiscalPeriod]
		)AS B
		ON  A.[FiscalYear]=B.[T$AJSD_FiscalYear]
			AND A.[FiscalPeriod]=B.[T$AJSD_FiscalPeriod]
		ORDER BY A.FiscalYear,A.FiscalPeriod
		
	END
	ELSE
	BEGIN
		--Booking
		SELECT
			  @BookingSQLString=@BookingSQLString+ ', ' +CONVERT(VARCHAR(50),CAST(ISNULL([Booking],0)AS NUMERIC(19,4)))+', ''0'''
			  ,@Booking=@Booking+ ISNULL([Booking],0) 
			  ,@TargetSQLString=@TargetSQLString+ ', ' +CONVERT(VARCHAR(50),CAST(ISNULL([Forecast],0)AS NUMERIC(19,4)))+', ''0'''
			  ,@Target=@Target+ ISNULL([Forecast],0) 
			  ,@GapSQLString=@GapSQLString+ ', ' + (CASE WHEN [Forecast] IS NULL THEN '0' ELSE CONVERT(VARCHAR(50),CAST(ISNULL([Forecast],0)- ISNULL([Booking],0)AS NUMERIC(19,4))) END)+', ''0'''
			  ,@Gap= @Gap+ (CASE WHEN [Forecast] IS NULL THEN 0 ELSE ISNULL([Forecast],0)- ISNULL([Booking],0) END)
		FROM #OverallPeriod AS A LEFT JOIN
		(
			SELECT [T$PDAT_FiscalYear]
				  ,[T$PDAT_FiscalPeriod]
				  ,SUM([Amount]) AS Booking
			FROM [MSS_MSS_ByPlant]
			WHERE [T$JDAT]=@CurrentDay
					AND(
					[T$PDAT_FiscalYear] > @CurrentFiscalYear
					OR([T$PDAT_FiscalYear] = @CurrentFiscalYear AND [T$PDAT_FiscalPeriod] >= @CurrentFiscalPeriod)
					)AND [Plant]=@Plant
			GROUP BY [T$PDAT_FiscalYear],[T$PDAT_FiscalPeriod]
		)AS B
		ON  A.[FiscalYear]=B.[T$PDAT_FiscalYear]
		AND A.[FiscalPeriod]=B.[T$PDAT_FiscalPeriod]
		LEFT JOIN [MSS_Forecast] AS C
		ON  A.[FiscalYear]=substring(C.[FYear],3,4)
			AND A.[FiscalPeriod]=C.[Period]
			AND C.[Plant]=@Plant
			AND C.[Type]='Shipment'
		ORDER BY A.FiscalYear,A.FiscalPeriod

		--Booking Overall 
		SELECT @BookingTotal=SUM([Amount])
		FROM [MSS_MSS_ByPlant]
		WHERE [T$JDAT]=@CurrentDay
				AND [Plant]=@Plant
		
		--Booking Buffer Order 
		SELECT @BookingBuffer =ISNULL(SUM([Amount]),0)
		FROM [MSS_MSS_ByPlant]
		WHERE  [T$JDAT]=@CurrentDay 
				AND [T$PDAT_FiscalYear] = '2099' AND [T$PDAT_FiscalPeriod] = 1
				AND [Plant]=@Plant
		
		--Booking After
		SELECT @BookingAfter=ISNULL(SUM([Amount]),0)
		FROM [MSS_MSS_ByPlant]
		WHERE [T$JDAT]=@CurrentDay 
			  AND [T$PDAT_FiscalYear] IS NULL
			  AND [Plant]=@Plant
		
		-- F.G & Blance to build 
		SELECT  
		  @FGSQLString=@FGSQLString+', ' + CONVERT(VARCHAR(50),CAST(ISNULL([FGavailable],0)AS NUMERIC(19,4)))+', '+ CONVERT(VARCHAR(50),CAST(ISNULL([FGavailable],0)/(ISNULL([FGavailable],1)+ISNULL([BalanceToBuild],0)+ISNULL([FGout],0))AS NUMERIC(19,4)))
		  ,@FG=@FG+ISNULL([FGavailable],0)
		  ,@BlanceSQLString=@BlanceSQLString +', ' + CONVERT(VARCHAR(50),CAST(ISNULL([BalanceToBuild],0)AS NUMERIC(19,4)))+', '+ CONVERT(VARCHAR(50),CAST(ISNULL([BalanceToBuild],0)/(ISNULL([FGavailable],1)+ISNULL([BalanceToBuild],0)+ISNULL([FGout],0))AS NUMERIC(19,4)))
		  ,@Blance=@Blance+ISNULL([BalanceToBuild],0)
		  ,@FGout=@FGout + ISNULL([FGout],0) --FG Out
		  ,@FGoutSQLString=@FGoutSQLString  + ', ' + CONVERT(VARCHAR(50),CAST(ISNULL([FGout],0)AS NUMERIC(19,4))) + ', '+ CONVERT(VARCHAR(50),CAST(ISNULL([FGout],0)/(ISNULL([FGavailable],1)+ISNULL([BalanceToBuild],0)+ISNULL([FGout],0))AS NUMERIC(19,4)))
		FROM #OverallPeriod AS A LEFT JOIN
		(
			SELECT [T$PDAT_FiscalYear]
			  ,[T$PDAT_FiscalPeriod]
			  ,SUM([FGavailable])AS FGavailable
			  ,SUM([BalanceToBuild])AS BalanceToBuild
			FROM [MSS_OrderBacklog_ByOrder]
			WHERE [T$JDAT]=@CurrentDay 
			AND(
				[T$PDAT_FiscalYear] > @CurrentFiscalYear
				OR([T$PDAT_FiscalYear] = @CurrentFiscalYear AND [T$PDAT_FiscalPeriod] >= @CurrentFiscalPeriod)
			)
			AND [Plant]=@Plant 
			GROUP BY [T$PDAT_FiscalYear],[T$PDAT_FiscalPeriod] 
		)AS B
		ON  A.[FiscalYear]=B.[T$PDAT_FiscalYear] AND A.[FiscalPeriod]=B.[T$PDAT_FiscalPeriod]
		LEFT JOIN 
		(
			SELECT 
			[T$AJSD_FiscalYear]
			,[T$AJSD_FiscalPeriod]
			,SUM([FGout])AS FGout
			FROM [MSS_FGOut_ByOrder]
			WHERE [T$JDAT]=@CurrentDay 
			AND(
				[T$AJSD_FiscalYear] > @CurrentFiscalYear
				OR([T$AJSD_FiscalYear] = @CurrentFiscalYear AND [T$AJSD_FiscalPeriod] >= @CurrentFiscalPeriod)
				) 
			AND [Plant]=@Plant
			GROUP BY [T$AJSD_FiscalYear],[T$AJSD_FiscalPeriod]
		)AS C
		ON A.[FiscalYear]=C.[T$AJSD_FiscalYear] AND A.[FiscalPeriod]=C.[T$AJSD_FiscalPeriod]
		ORDER BY A.FiscalYear,A.FiscalPeriod
		
		
		--F.G & Blance to build    Overall 
		SELECT  
		  @FGTotal=SUM([FGavailable])
		  ,@BlanceTotal=SUM([BalanceToBuild])
		FROM [MSS_OrderBacklog_ByOrder]
		WHERE [T$JDAT]=@CurrentDay 
			AND [Plant]=@Plant
		
		-- F.G & Blance to build    Buffer Order 
		SELECT @FGBuffer=ISNULL(SUM([FGavailable]),0)
		  ,@BlanceBuffer=ISNULL(SUM([BalanceToBuild]),0)
		FROM [MSS_OrderBacklog_ByOrder]
		WHERE [T$JDAT]=@CurrentDay
				AND [T$PDAT_FiscalYear] = '2099' AND [T$PDAT_FiscalPeriod] = 1
				AND [Plant]=@Plant 
		
		--F.G & Blance to build After
		SELECT @FGBuffer=ISNULL(SUM([FGavailable]),0)
			   ,@BlanceAfter=ISNULL(SUM([BalanceToBuild]),0)
		FROM [MSS_OrderBacklog_ByOrder]
		WHERE [T$JDAT]=@CurrentDay
				AND [T$PDAT_FiscalYear] IS NULL
				AND [Plant]=@Plant 
		--Ahead F.G Out
		SELECT  
		  @Ahead=@Ahead+ISNULL([Amount],0)
		  ,@AheadSQLString= @AheadSQLString  +', ' +CONVERT(VARCHAR(50),CAST(ISNULL([Amount],0)AS NUMERIC(19,4)))+', ''0'''
		FROM #OverallPeriod AS A LEFT JOIN
		(
			SELECT  
			  [T$AJSD_FiscalYear]
			  ,[T$AJSD_FiscalPeriod]
			  ,SUM([Amount])AS [Amount]
			FROM [MSS_AheadFGOut_ByOrder]
			WHERE [T$JDAT]=@CurrentDay AND [Plant]=@Plant
			GROUP BY [T$AJSD_FiscalYear], [T$AJSD_FiscalPeriod]
		)AS B
		ON  A.[FiscalYear]=B.[T$AJSD_FiscalYear]
		AND A.[FiscalPeriod]=B.[T$AJSD_FiscalPeriod]
		ORDER BY A.FiscalYear,A.FiscalPeriod

	END

	SET @BookingSQLString=@BookingSQLString+ ', '+ CONVERT(VARCHAR(50),@BookingAfter)+ ', '+ CONVERT(VARCHAR(50),@BookingBuffer)+ ', '+ CONVERT(VARCHAR(50),@BookingTotal)+ ')'
	SET @TargetSQLString=@TargetSQLString+ ', 0, 0, '+ CONVERT(VARCHAR(50),@Target)+ ')'
	SET @GapSQLString=@GapSQLString+ ', 0, 0, '+ CONVERT(VARCHAR(50),@Gap)+ ')'
	SET @FGoutSQLString=@FGoutSQLString + ', 0, 0, '+ CONVERT(VARCHAR(50),@FGout)+ ')'
	SET @FGSQLString=@FGSQLString+ ', '+ CONVERT(VARCHAR(50),@FGAfter)+ ', '+ CONVERT(VARCHAR(50),@FGBuffer)+ ', '+ CONVERT(VARCHAR(50),@FGTotal)+ ')'
	SET @BlanceSQLString=@BlanceSQLString+ ', '+ CONVERT(VARCHAR(50),@BlanceAfter)+ ', '+ CONVERT(VARCHAR(50),@BlanceBuffer)+ ', '+ CONVERT(VARCHAR(50),@BlanceTotal)+ ')'
	SET @AheadSQLString=@AheadSQLString+ ', 0, 0, '+ CONVERT(VARCHAR(50),@Ahead)+ ')'

	EXEC(@BookingSQLString)
	EXEC(@TargetSQLString)
	EXEC(@GapSQLString)
	EXEC(@FGoutSQLString)
	EXEC(@FGSQLString)
	EXEC(@BlanceSQLString)
	EXEC(@AheadSQLString)

				

	SELECT * FROM [#BookingStatus]

	----Delete Table
	DROP TABLE [#OverallPeriod]	
	DROP TABLE [#BookingStatus]




	
end









GO
