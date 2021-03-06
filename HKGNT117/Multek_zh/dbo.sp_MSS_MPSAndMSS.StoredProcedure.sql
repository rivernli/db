USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_MSS_MPSAndMSS]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 


CREATE  procedure [dbo].[sp_MSS_MPSAndMSS]
	@Period VARCHAR(20)
	,@Plant	VARCHAR(10)
as
begin
	--CurrentFiscalDate
	DECLARE @CurrentDay DATETIME
	DECLARE @CurrentFiscalYear VARCHAR(4)
	DECLARE @CurrentFiscalPeriod VARCHAR(2)
	DECLARE @CurrentFiscal DATETIME
	DECLARE @CurrentPeriodLastDay DATETIME

	SET @CurrentDay=CONVERT(DATETIME, CONVERT(varchar(100), getdate(), 112))
	SELECT @CurrentDay=CONVERT(DATETIME, CONVERT(varchar(100), [UpTime] , 112)) FROM [Multek_ZH].[dbo].[MSS_UpTime]
	
	SELECT @CurrentFiscalYear= substring([FiscalYearDesc],3,4),@CurrentFiscalPeriod=CONVERT(VARCHAR,FiscalPeriod) FROM  [DataWarehouse].[dbo].[DW_DIM_Calender]
	WHERE CalenderDate=@CurrentDay
	SELECT @CurrentFiscal=CONVERT(DATETIME,@CurrentFiscalYear+'-'+@CurrentFiscalPeriod+'-01')
	SET @CurrentPeriodLastDay=(SELECT TOP(1) CalenderDate FROM  [DataWarehouse].[dbo].[DW_DIM_Calender]
	WHERE [FiscalYearDesc]='FY'+@CurrentFiscalYear AND FiscalPeriod=@CurrentFiscalPeriod
	ORDER BY CalenderDate DESC)

	--#CurrentCalender
	IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[#CurrentCalender]') AND type in (N'U'))
			DROP TABLE [dbo].[#CurrentCalender]
	SELECT [calenderDate] 
	INTO  #CurrentCalender
	FROM  [DataWarehouse].[dbo].[DW_DIM_Calender] 
	WHERE [FiscalYearDesc]='FY'+@CurrentFiscalYear AND [FiscalPeriod]=@CurrentFiscalPeriod 

	--#MSSAndMPS
	IF (select object_ID('tempdb..#MSSAndMPS')) >0 
			DROP TABLE [dbo].[#MSSAndMPS]
	CREATE TABLE #MSSAndMPS (
		JobDate DATETIME
		,Forecast NUMERIC(19,4)
		,MSS NUMERIC(19,4)
		,MPS NUMERIC(19,4)
	)

	IF @Plant='ALL'
	BEGIN
		IF @Period='ALL'
		BEGIN
			INSERT INTO [#MSSAndMPS]
			SELECT 
				  a.[calenderDate]as JobDate
				  ,0 AS Forecast
				  ,ISNULL(SUM(b.[MSS]),0)AS MSS
				  ,ISNULL(SUM(c.[MPS]),0)AS MPS
			FROM  #CurrentCalender AS a LEFT JOIN  
			(--MSS
				SELECT 
					  T1.[calenderDate]as JobDate
					  ,SUM(T2.[Amount])AS MSS
				FROM  #CurrentCalender AS T1 LEFT JOIN  [MSS_MSS_ByPlant] AS T2
				ON T1.[calenderDate]= T2.[T$JDAT] 
				GROUP BY T1.[calenderDate]
			) AS b
			ON a.[calenderDate]= b.[JobDate] 
			LEFT JOIN   
			(--MPS
				SELECT 
					  T1.[calenderDate]as JobDate
					  ,SUM(T2.[Amount])AS MPS
				FROM  #CurrentCalender AS T1 LEFT JOIN  [MSS_MPS_ByPlant] AS T2
				ON T1.[calenderDate]= T2.[T$JDAT] 
				GROUP BY T1.[calenderDate]
			) AS c
			ON a.[calenderDate]= c.[JobDate] 
			GROUP BY a.[calenderDate]
			ORDER BY a.[calenderDate]
		END
		IF @Period='current'
		BEGIN
			INSERT INTO [#MSSAndMPS]
			SELECT 
				  a.[calenderDate]as JobDate
				  ,(SELECT TOP 1 [Forecast] FROM [MSS_Forecast_History] WHERE  [Type]='Shipment' AND [MSS_Forecast_History].[ChangedDate] >= a.[calenderDate]  AND [Plant]='' AND  [FYear]='FY'+@CurrentFiscalYear AND [Period]=@CurrentFiscalPeriod AND  [Forecast]!=0  ORDER BY ChangedDate ASC )AS Forecast
				  ,ISNULL(SUM(b.[MSS]),0)AS MSS
				  ,ISNULL(SUM(c.[MPS]),0)AS MPS
			FROM  #CurrentCalender AS a LEFT JOIN  
			(--MSS
				SELECT 
					  T1.[calenderDate]as JobDate
					  ,SUM(T2.[Amount])AS MSS
				FROM  #CurrentCalender AS T1 LEFT JOIN  [MSS_MSS_ByPlant] AS T2
				ON T1.[calenderDate]= T2.[T$JDAT] 
				WHERE  T2.[T$PDAT_FiscalYear]<@CurrentFiscalYear 
					OR(T2.[T$PDAT_FiscalYear]=@CurrentFiscalYear AND T2.[T$PDAT_FiscalPeriod]<=@CurrentFiscalPeriod )
				GROUP BY T1.[calenderDate]
			) AS b
			ON a.[calenderDate]= b.[JobDate] 
			LEFT JOIN   
			(--MPS
				SELECT 
					  T1.[calenderDate]as JobDate
					  ,SUM(T2.[Amount])AS MPS
				FROM  #CurrentCalender AS T1 LEFT JOIN  [MSS_MPS_ByPlant] AS T2
				ON T1.[calenderDate]= T2.[T$JDAT] 
				WHERE T2.[T$WODT_FiscalYear]<@CurrentFiscalYear
					OR(T2.[T$WODT_FiscalYear]=@CurrentFiscalYear AND T2.[T$WODT_FiscalPeriod]<=@CurrentFiscalPeriod )
				GROUP BY T1.[calenderDate]
			) AS c
			ON a.[calenderDate]= c.[JobDate] 
			GROUP BY a.[calenderDate]
			ORDER BY a.[calenderDate]
		END	
		IF @Period='next'
		BEGIN
			SELECT @CurrentFiscalYear= substring([FiscalYearDesc],3,4),@CurrentFiscalPeriod=CONVERT(VARCHAR,FiscalPeriod)  FROM  [DataWarehouse].[dbo].[DW_DIM_Calender] WHERE  DATEDIFF(MONTH,@CurrentFiscal, CONVERT(DATETIME, substring([FiscalYearDesc],3,4)+'-'+CONVERT(nvarchar(10),[FiscalPeriod])+'-01'))=1
			
			INSERT INTO [#MSSAndMPS]
			SELECT 
				  a.[calenderDate]as JobDate
				  ,(SELECT TOP 1 [Forecast] FROM [MSS_Forecast_History] WHERE  [Type]='Shipment' AND [MSS_Forecast_History].[ChangedDate] >= a.[calenderDate]  AND [Plant]='' AND  [FYear]='FY'+@CurrentFiscalYear AND [Period]=@CurrentFiscalPeriod AND  [Forecast]!=0  ORDER BY ChangedDate ASC )AS Forecast
				  ,ISNULL(SUM(b.[MSS]),0)AS MSS
				  ,ISNULL(SUM(c.[MPS]),0)AS MPS
			FROM  #CurrentCalender AS a LEFT JOIN  
			(--MSS
				SELECT 
					  T1.[calenderDate]as JobDate
					  ,SUM(T2.[Amount])AS MSS
				FROM  #CurrentCalender AS T1 LEFT JOIN  [MSS_MSS_ByPlant] AS T2
				ON T1.[calenderDate]= T2.[T$JDAT] 
				WHERE T2.[T$PDAT_FiscalYear]=@CurrentFiscalYear AND T2.[T$PDAT_FiscalPeriod]=@CurrentFiscalPeriod 
				GROUP BY T1.[calenderDate]
			) AS b
			ON a.[calenderDate]= b.[JobDate] 
			LEFT JOIN   
			(--MPS
				SELECT 
					  T1.[calenderDate]as JobDate
					  ,SUM(T2.[Amount])AS MPS
				FROM  #CurrentCalender AS T1 LEFT JOIN  [MSS_MPS_ByPlant] AS T2
				ON T1.[calenderDate]= T2.[T$JDAT] 
				WHERE T2.[T$WODT_FiscalYear]=@CurrentFiscalYear AND T2.[T$WODT_FiscalPeriod]=@CurrentFiscalPeriod 
				GROUP BY T1.[calenderDate]
			) AS c
			ON a.[calenderDate]= c.[JobDate] 
			GROUP BY a.[calenderDate]
			ORDER BY a.[calenderDate]
		END
		IF @Period='third'
		BEGIN
			SELECT @CurrentFiscalYear= substring([FiscalYearDesc],3,4),@CurrentFiscalPeriod=CONVERT(VARCHAR,FiscalPeriod)  FROM  [DataWarehouse].[dbo].[DW_DIM_Calender] WHERE  DATEDIFF(MONTH,@CurrentFiscal, CONVERT(DATETIME, substring([FiscalYearDesc],3,4)+'-'+CONVERT(nvarchar(10),[FiscalPeriod])+'-01'))=2
			
			INSERT INTO [#MSSAndMPS]
			SELECT 
				  a.[calenderDate]as JobDate
				  ,(SELECT TOP 1 [Forecast] FROM [MSS_Forecast_History] WHERE  [Type]='Shipment' AND [MSS_Forecast_History].[ChangedDate] >= a.[calenderDate]  AND [Plant]='' AND  [FYear]='FY'+@CurrentFiscalYear AND [Period]=@CurrentFiscalPeriod AND  [Forecast]!=0  ORDER BY ChangedDate ASC )AS Forecast
				  ,ISNULL(SUM(b.[MSS]),0)AS MSS
				  ,ISNULL(SUM(c.[MPS]),0)AS MPS
			FROM  #CurrentCalender AS a LEFT JOIN  
			(--MSS
				SELECT 
					  T1.[calenderDate]as JobDate
					  ,SUM(T2.[Amount])AS MSS
				FROM  #CurrentCalender AS T1 LEFT JOIN  [MSS_MSS_ByPlant] AS T2
				ON T1.[calenderDate]= T2.[T$JDAT] 
				WHERE T2.[T$PDAT_FiscalYear]=@CurrentFiscalYear AND T2.[T$PDAT_FiscalPeriod]=@CurrentFiscalPeriod 
				GROUP BY T1.[calenderDate]
			) AS b
			ON a.[calenderDate]= b.[JobDate] 
			LEFT JOIN   
			(--MPS
				SELECT 
					  T1.[calenderDate]as JobDate
					  ,SUM(T2.[Amount])AS MPS
				FROM  #CurrentCalender AS T1 LEFT JOIN  [MSS_MPS_ByPlant] AS T2
				ON T1.[calenderDate]= T2.[T$JDAT] 
				WHERE T2.[T$WODT_FiscalYear]=@CurrentFiscalYear AND T2.[T$WODT_FiscalPeriod]=@CurrentFiscalPeriod 
				GROUP BY T1.[calenderDate]
			) AS c
			ON a.[calenderDate]= c.[JobDate] 
			GROUP BY a.[calenderDate]
			ORDER BY a.[calenderDate]
		END
		IF @Period='future'
		BEGIN
			SELECT @CurrentFiscalYear= substring([FiscalYearDesc],3,4),@CurrentFiscalPeriod=CONVERT(VARCHAR,FiscalPeriod)  FROM  [DataWarehouse].[dbo].[DW_DIM_Calender] WHERE  DATEDIFF(MONTH,@CurrentFiscal, CONVERT(DATETIME, substring([FiscalYearDesc],3,4)+'-'+CONVERT(nvarchar(10),[FiscalPeriod])+'-01'))=3
			
			INSERT INTO [#MSSAndMPS]
			SELECT 
				  a.[calenderDate]as JobDate
				  ,0 AS Forecast
				  ,ISNULL(SUM(b.[MSS]),0)AS MSS
				  ,ISNULL(SUM(c.[MPS]),0)AS MPS
			FROM  #CurrentCalender AS a LEFT JOIN  
			(--MSS
				SELECT 
					  T1.[calenderDate]as JobDate
					  ,SUM(T2.[Amount])AS MSS
				FROM  #CurrentCalender AS T1 LEFT JOIN  [MSS_MSS_ByPlant] AS T2
				ON T1.[calenderDate]= T2.[T$JDAT] 
				WHERE  T2.[T$PDAT_FiscalYear]>@CurrentFiscalYear 
					OR(T2.[T$PDAT_FiscalYear]=@CurrentFiscalYear AND T2.[T$PDAT_FiscalPeriod]>=@CurrentFiscalPeriod 
					OR T2.[T$PDAT_FiscalYear] IS NULL)
				GROUP BY T1.[calenderDate]
			) AS b
			ON a.[calenderDate]= b.[JobDate] 
			LEFT JOIN   
			(--MPS
				SELECT 
					  T1.[calenderDate]as JobDate
					  ,SUM(T2.[Amount])AS MPS
				FROM  #CurrentCalender AS T1 LEFT JOIN  [MSS_MPS_ByPlant] AS T2
				ON T1.[calenderDate]= T2.[T$JDAT] 
				WHERE T2.[T$WODT_FiscalYear]>@CurrentFiscalYear
					OR(T2.[T$WODT_FiscalYear]=@CurrentFiscalYear AND T2.[T$WODT_FiscalPeriod]>=@CurrentFiscalPeriod )
				GROUP BY T1.[calenderDate]
			) AS c
			ON a.[calenderDate]= c.[JobDate] 
			GROUP BY a.[calenderDate]
			ORDER BY a.[calenderDate]

		END
	END
	ELSE
	BEGIN
		IF @Period='ALL'
		BEGIN
			INSERT INTO [#MSSAndMPS]
			SELECT 
				  a.[calenderDate]as JobDate
				  ,0 AS Forecast
				  ,ISNULL(SUM(b.[MSS]),0)AS MSS
				  ,ISNULL(SUM(c.[MPS]),0)AS MPS
			FROM  #CurrentCalender AS a LEFT JOIN  
			(--MSS
				SELECT 
					  T1.[calenderDate]as JobDate
					  ,SUM(T2.[Amount])AS MSS
				FROM  #CurrentCalender AS T1 LEFT JOIN  [MSS_MSS_ByPlant] AS T2
				ON T1.[calenderDate]= T2.[T$JDAT] 
				WHERE T2.[Plant]=@Plant
				GROUP BY T1.[calenderDate]
			) AS b
			ON a.[calenderDate]= b.[JobDate] 
			LEFT JOIN   
			(--MPS
				SELECT 
					  T1.[calenderDate]as JobDate
					  ,SUM(T2.[Amount])AS MPS
				FROM  #CurrentCalender AS T1 LEFT JOIN  [MSS_MPS_ByPlant] AS T2
				ON T1.[calenderDate]= T2.[T$JDAT] 
				WHERE T2.[Plant]=@Plant
				GROUP BY T1.[calenderDate]
			) AS c
			ON a.[calenderDate]= c.[JobDate] 

			GROUP BY a.[calenderDate]
			ORDER BY a.[calenderDate]
		END
		IF @Period='current'
		BEGIN
			INSERT INTO [#MSSAndMPS]
			
			SELECT 
				  a.[calenderDate]as JobDate
				  ,(SELECT TOP 1 [Forecast] FROM [MSS_Forecast_History] WHERE  [Type]='Shipment' AND [MSS_Forecast_History].[ChangedDate] >= a.[calenderDate]  AND [Plant]=@Plant AND  [FYear]='FY'+@CurrentFiscalYear AND [Period]=@CurrentFiscalPeriod AND  [Forecast]!=0  ORDER BY ChangedDate ASC )AS Forecast
				  ,ISNULL(SUM(b.[MSS]),0)AS MSS
				  ,ISNULL(SUM(c.[MPS]),0)AS MPS
			FROM  #CurrentCalender AS a LEFT JOIN  
			(--MSS
				SELECT 
					  T1.[calenderDate]as JobDate
					  ,SUM(T2.[Amount]) AS MSS
				FROM  #CurrentCalender AS T1 LEFT JOIN  [MSS_MSS_ByPlant] AS T2
				ON T1.[calenderDate]= T2.[T$JDAT] 
				WHERE  (T2.[T$PDAT_FiscalYear]<@CurrentFiscalYear 
					OR(T2.[T$PDAT_FiscalYear]=@CurrentFiscalYear AND T2.[T$PDAT_FiscalPeriod]<=@CurrentFiscalPeriod ))
					AND T2.[Plant]=@Plant
				GROUP BY T1.[calenderDate]
			) AS b
			ON a.[calenderDate]= b.[JobDate] 
			LEFT JOIN   
			(--MPS
				SELECT 
					  T1.[calenderDate]as JobDate
					  ,SUM(T2.[Amount])AS MPS
				FROM  #CurrentCalender AS T1 LEFT JOIN  [MSS_MPS_ByPlant] AS T2
				ON T1.[calenderDate]= T2.[T$JDAT] 
				WHERE (T2.[T$WODT_FiscalYear]<@CurrentFiscalYear
					OR(T2.[T$WODT_FiscalYear]=@CurrentFiscalYear AND T2.[T$WODT_FiscalPeriod]<=@CurrentFiscalPeriod ))
					AND T2.[Plant]=@Plant
				GROUP BY T1.[calenderDate]
			) AS c
			ON a.[calenderDate]= c.[JobDate] 
			GROUP BY a.[calenderDate]
			ORDER BY a.[calenderDate]
		END	
		IF @Period='next'
		BEGIN	
			SELECT @CurrentFiscalYear= substring([FiscalYearDesc],3,4),@CurrentFiscalPeriod=CONVERT(VARCHAR,FiscalPeriod)  FROM  [DataWarehouse].[dbo].[DW_DIM_Calender] WHERE  DATEDIFF(MONTH,@CurrentFiscal, CONVERT(DATETIME, substring([FiscalYearDesc],3,4)+'-'+CONVERT(nvarchar(10),[FiscalPeriod])+'-01'))=1
			
			INSERT INTO [#MSSAndMPS]
			SELECT 
				  a.[calenderDate]as JobDate
				  ,(SELECT TOP 1 [Forecast] FROM [MSS_Forecast_History] WHERE  [Type]='Shipment' AND [MSS_Forecast_History].[ChangedDate] >= a.[calenderDate]  AND [Plant]=@Plant AND  [FYear]='FY'+@CurrentFiscalYear AND [Period]=@CurrentFiscalPeriod AND  [Forecast]!=0  ORDER BY ChangedDate ASC )AS Forecast
				  ,ISNULL(SUM(b.[MSS]),0)AS MSS
				  ,ISNULL(SUM(c.[MPS]),0)AS MPS
			FROM  #CurrentCalender AS a LEFT JOIN  
			(--MSS
				SELECT 
					  T1.[calenderDate]as JobDate
					  ,SUM(T2.[Amount])AS MSS
				FROM  #CurrentCalender AS T1 LEFT JOIN  [MSS_MSS_ByPlant] AS T2
				ON T1.[calenderDate]= T2.[T$JDAT] 
				WHERE T2.[T$PDAT_FiscalYear]=@CurrentFiscalYear AND T2.[T$PDAT_FiscalPeriod]=@CurrentFiscalPeriod 
					AND T2.[Plant]=@Plant
				GROUP BY T1.[calenderDate]
			) AS b
			ON a.[calenderDate]= b.[JobDate] 
			LEFT JOIN   
			(--MPS
				SELECT 
					  T1.[calenderDate]as JobDate
					  ,SUM(T2.[Amount])AS MPS
				FROM  #CurrentCalender AS T1 LEFT JOIN  [MSS_MPS_ByPlant] AS T2
				ON T1.[calenderDate]= T2.[T$JDAT] 
				WHERE T2.[T$WODT_FiscalYear]=@CurrentFiscalYear AND T2.[T$WODT_FiscalPeriod]=@CurrentFiscalPeriod 
					AND T2.[Plant]=@Plant
				GROUP BY T1.[calenderDate]
			) AS c
			ON a.[calenderDate]= c.[JobDate] 
			GROUP BY a.[calenderDate]
			ORDER BY a.[calenderDate]
		END	
		IF @Period='third'
		BEGIN	
			SELECT @CurrentFiscalYear= substring([FiscalYearDesc],3,4),@CurrentFiscalPeriod=CONVERT(VARCHAR,FiscalPeriod)  FROM  [DataWarehouse].[dbo].[DW_DIM_Calender] WHERE  DATEDIFF(MONTH,@CurrentFiscal, CONVERT(DATETIME, substring([FiscalYearDesc],3,4)+'-'+CONVERT(nvarchar(10),[FiscalPeriod])+'-01'))=2
			
			INSERT INTO [#MSSAndMPS]
			SELECT 
				  a.[calenderDate]as JobDate
				  ,(SELECT TOP 1 [Forecast] FROM [MSS_Forecast_History] WHERE  [Type]='Shipment' AND [MSS_Forecast_History].[ChangedDate] >= a.[calenderDate]  AND [Plant]=@Plant AND  [FYear]='FY'+@CurrentFiscalYear AND [Period]=@CurrentFiscalPeriod AND  [Forecast]!=0  ORDER BY ChangedDate ASC )AS Forecast
				  ,ISNULL(SUM(b.[MSS]),0)AS MSS
				  ,ISNULL(SUM(c.[MPS]),0)AS MPS
			FROM  #CurrentCalender AS a LEFT JOIN  
			(--MSS
				SELECT 
					  T1.[calenderDate]as JobDate
					  ,SUM(T2.[Amount])AS MSS
				FROM  #CurrentCalender AS T1 LEFT JOIN  [MSS_MSS_ByPlant] AS T2
				ON T1.[calenderDate]= T2.[T$JDAT] 
				WHERE T2.[T$PDAT_FiscalYear]=@CurrentFiscalYear AND T2.[T$PDAT_FiscalPeriod]=@CurrentFiscalPeriod 
					AND T2.[Plant]=@Plant
				GROUP BY T1.[calenderDate]
			) AS b
			ON a.[calenderDate]= b.[JobDate] 
			LEFT JOIN   
			(--MPS
				SELECT 
					  T1.[calenderDate]as JobDate
					  ,SUM(T2.[Amount])AS MPS
				FROM  #CurrentCalender AS T1 LEFT JOIN  [MSS_MPS_ByPlant] AS T2
				ON T1.[calenderDate]= T2.[T$JDAT] 
				WHERE T2.[T$WODT_FiscalYear]=@CurrentFiscalYear AND T2.[T$WODT_FiscalPeriod]=@CurrentFiscalPeriod 
					AND T2.[Plant]=@Plant
				GROUP BY T1.[calenderDate]
			) AS c
			ON a.[calenderDate]= c.[JobDate] 
			GROUP BY a.[calenderDate]
			ORDER BY a.[calenderDate]
		END	
		IF @Period='future'
		BEGIN
			SELECT @CurrentFiscalYear= substring([FiscalYearDesc],3,4),@CurrentFiscalPeriod=CONVERT(VARCHAR,FiscalPeriod)  FROM  [DataWarehouse].[dbo].[DW_DIM_Calender] WHERE  DATEDIFF(MONTH,@CurrentFiscal, CONVERT(DATETIME, substring([FiscalYearDesc],3,4)+'-'+CONVERT(nvarchar(10),[FiscalPeriod])+'-01'))=3
			
			INSERT INTO [#MSSAndMPS]
			SELECT 
				  a.[calenderDate]as JobDate
				  ,0 AS Forecast
				  ,ISNULL(SUM(b.[MSS]),0)AS MSS
				  ,ISNULL(SUM(c.[MPS]),0)AS MPS
			FROM  #CurrentCalender AS a LEFT JOIN  
			(--MSS
				SELECT 
					  T1.[calenderDate]as JobDate
					  ,SUM(T2.[Amount])AS MSS
				FROM  #CurrentCalender AS T1 LEFT JOIN  [MSS_MSS_ByPlant] AS T2
				ON T1.[calenderDate]= T2.[T$JDAT] 
				WHERE ( T2.[T$PDAT_FiscalYear]>@CurrentFiscalYear 
					OR(T2.[T$PDAT_FiscalYear]=@CurrentFiscalYear AND T2.[T$PDAT_FiscalPeriod]>=@CurrentFiscalPeriod )
					OR T2.[T$PDAT_FiscalYear] IS NULL)
					AND T2.[Plant]=@Plant
				GROUP BY T1.[calenderDate]
			) AS b
			ON a.[calenderDate]= b.[JobDate] 
			LEFT JOIN   
			(--MPS
				SELECT 
					  T1.[calenderDate]as JobDate
					  ,SUM(T2.[Amount])AS MPS
				FROM  #CurrentCalender AS T1 LEFT JOIN  [MSS_MPS_ByPlant] AS T2
				ON T1.[calenderDate]= T2.[T$JDAT] 
				WHERE (T2.[T$WODT_FiscalYear]>@CurrentFiscalYear
					OR(T2.[T$WODT_FiscalYear]=@CurrentFiscalYear AND T2.[T$WODT_FiscalPeriod]>=@CurrentFiscalPeriod ))
					AND T2.[Plant]=@Plant
				GROUP BY T1.[calenderDate]
			) AS c
			ON a.[calenderDate]= c.[JobDate] 
			GROUP BY a.[calenderDate]
			ORDER BY a.[calenderDate]

			
		END
	END

	--行转列
	DECLARE   @MSSString   varchar(8000) 
	DECLARE   @MPSString   varchar(8000) 
	DECLARE   @ForecastString   varchar(8000) 
	SET @MSSString = 'SELECT  ''MSS'' AS Items,'
	SET @MPSString =  'SELECT  ''MPS'' AS Items,'
	SET @ForecastString  = 'SELECT  ''Forecast'' AS Items,'
	SELECT 
		@MSSString  = @MSSString + 'sum(case JobDate when '''+convert(varchar,JobDate, 120)+ ''' then CAST([MSS] AS NUMERIC(19,4)) else 0 end) as ['+convert(varchar(11),JobDate)+ '] , ' 
		,@MPSString = @MPSString + 'sum(case JobDate when '''+convert(varchar,JobDate, 120)+ ''' then CAST([MPS] AS NUMERIC(19,4))else 0 end) as ['+convert(varchar(11),JobDate)+ '] , ' 
		,@ForecastString = @ForecastString + '  sum(case JobDate when '''+convert(varchar,JobDate, 120)+ ''' then Forecast else 0 end) as ['+convert(varchar(11),JobDate)+ '] , ' 
	FROM [#MSSAndMPS]	
	SET @MSSString = left(@MSSString,len(@MSSString)-1)+ ' FROM #MSSAndMPS '
	SET @MPSString = left(@MPSString,len(@MPSString)-1)+ ' FROM #MSSAndMPS '
	SET @ForecastString  = left(@ForecastString ,len(@ForecastString )-1)+ ' FROM #MSSAndMPS '

	exec( @ForecastString+ ' UNION ALL ' + @MSSString + ' UNION ALL ' + @MPSString) 

	--Delete Table
	DROP TABLE [dbo].[#CurrentCalender]
	DROP TABLE [dbo].[#MSSAndMPS]
	
end









GO
