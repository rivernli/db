USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_MSS_MSSMovemen]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_MSS_MSSMovemen]
	
AS
BEGIN
	DECLARE @CurrentDay DATETIME
	DECLARE @CurrentFiscalYear VARCHAR(4)
	DECLARE @CurrentFiscalPeriod VARCHAR(2)
	DECLARE @CurrentFiscal DATETIME

	SELECT @CurrentDay=CONVERT(DATETIME, CONVERT(varchar(100), [UpTime] , 112)) FROM [Multek_ZH].[dbo].[MSS_UpTime]
	SELECT @CurrentFiscalYear= substring([FiscalYearDesc],3,4),@CurrentFiscalPeriod=CONVERT(VARCHAR,FiscalPeriod) FROM  [DataWarehouse].[dbo].[DW_DIM_Calender]
	WHERE DATEDIFF(DAY,CalenderDate,@CurrentDay)=0
	
	SELECT @CurrentFiscal=CONVERT(DATETIME,@CurrentFiscalYear+'-'+@CurrentFiscalPeriod+'-01')
	--#CurrentCalender
	IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[#CurrentCalender]') AND type in (N'U'))
			DROP TABLE [dbo].[#CurrentCalender]
	SELECT [calenderDate] 
	INTO  #CurrentCalender
	FROM  [DataWarehouse].[dbo].[DW_DIM_Calender] 
	WHERE [FiscalYearDesc]='FY'+@CurrentFiscalYear AND [FiscalPeriod]=@CurrentFiscalPeriod 
	
	--#MSS
	IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[#MSS]') AND type in (N'U'))
			DROP TABLE [dbo].[#MSS]
	CREATE TABLE [dbo].[#MSS](
	[JobDate] [datetime] NULL,
	[Plant] [varchar](10) NULL, 
	[MSS] [float] NULL
	) 
	
	INSERT INTO [#MSS]
	SELECT 
		  T1.[calenderDate]as JobDate
		  ,T2.[Plant]
		  ,SUM(T2.[Amount]) AS MSS
	FROM  #CurrentCalender AS T1 LEFT JOIN (
		SELECT [T$JDAT],[Plant],[Amount] 
		FROM [MSS_MSS_ByPlant] 
		WHERE  [T$PDAT_FiscalYear]<@CurrentFiscalYear 
			OR([T$PDAT_FiscalYear]=@CurrentFiscalYear AND [T$PDAT_FiscalPeriod]<=@CurrentFiscalPeriod ) 
	) AS T2
	ON T1.[calenderDate]= T2.[T$JDAT] 
	GROUP BY T1.[calenderDate], T2.[Plant]
	ORDER BY T1.[calenderDate], T2.[Plant]
	

	--行转列
	--B1
	DECLARE   @B1String   varchar(8000)
	SET @B1String = 'SELECT  ''B1'' AS Items,'
	SELECT 
		@B1String  = @B1String + 'sum(case JobDate when '''+convert(varchar,JobDate, 120)+ ''' then MSS else 0 end) as ['+convert(varchar(11),JobDate)+ '] , ' 
	FROM [#MSS]	 
	WHERE [Plant]='B1' OR [Plant] IS NULL
	SET @B1String = left(@B1String,len(@B1String)-1)+ ' FROM #MSS WHERE [Plant]=''B1'' OR [Plant] IS NULL'
	--B2F
	DECLARE   @B2FString   varchar(8000) 
	SET @B2FString = 'SELECT  ''B2F'' AS Items,'
	SELECT 
		@B2FString  = @B2FString + 'sum(case JobDate when '''+convert(varchar,JobDate, 120)+ ''' then MSS else 0 end) as ['+convert(varchar(11),JobDate)+ '] , ' 
	FROM [#MSS]	 
	WHERE [Plant]='2F' OR [Plant] IS NULL
	SET @B2FString = left(@B2FString,len(@B2FString)-1)+ ' FROM #MSS WHERE [Plant]=''2F'' OR [Plant] IS NULL'
	--B3
	DECLARE   @B3String   varchar(8000) 
	SET @B3String = 'SELECT  ''B3'' AS Items,'
	SELECT 
		@B3String  = @B3String + 'sum(case JobDate when '''+convert(varchar,JobDate, 120)+ ''' then MSS else 0 end) as ['+convert(varchar(11),JobDate)+ '] , ' 
	FROM [#MSS]	 
	WHERE [Plant]='B3' OR [Plant] IS NULL
	SET @B3String = left(@B3String,len(@B3String)-1)+ ' FROM #MSS WHERE [Plant]=''B3'' OR [Plant] IS NULL'
	--B4
	DECLARE   @B4String   varchar(8000) 
	SET @B4String = 'SELECT  ''B4'' AS Items,'
	SELECT 
		@B4String  = @B4String + 'sum(case JobDate when '''+convert(varchar,JobDate, 120)+ ''' then MSS else 0 end) as ['+convert(varchar(11),JobDate)+ '] , ' 
	FROM [#MSS]	 
	WHERE [Plant]='B4' OR [Plant] IS NULL
	SET @B4String = left(@B4String,len(@B4String)-1)+ ' FROM #MSS WHERE [Plant]=''B4'' OR [Plant] IS NULL'
	--B5
	DECLARE   @B5String   varchar(8000) 
	SET @B5String = 'SELECT  ''B5'' AS Items,'
	SELECT 
		@B5String  = @B5String + 'sum(case JobDate when '''+convert(varchar,JobDate, 120)+ ''' then MSS else 0 end) as ['+convert(varchar(11),JobDate)+ '] , ' 
	FROM [#MSS]	 
	WHERE [Plant]='B5' OR [Plant] IS NULL
	SET @B5String = left(@B5String,len(@B5String)-1)+ ' FROM #MSS WHERE [Plant]=''B5'' OR [Plant] IS NULL'
	--HK
	DECLARE   @HKString   varchar(8000) 
	SET @HKString = 'SELECT  ''VVI'' AS Items,'
	SELECT 
		@HKString  = @HKString + 'sum(case JobDate when '''+convert(varchar,JobDate, 120)+ ''' then MSS else 0 end) as ['+convert(varchar(11),JobDate)+ '] , ' 
	FROM [#MSS]	 
	WHERE [Plant]='HK' OR [Plant] IS NULL
	SET @HKString = left(@HKString,len(@HKString)-1)+ ' FROM #MSS WHERE [Plant]=''HK'' OR [Plant] IS NULL'
	--Overall
	DECLARE   @OverallString   varchar(8000) 
	SET @OverallString = 'SELECT  ''Overall'' AS Items,'
	SELECT 
		@OverallString  = @OverallString + 'sum(case JobDate when '''+convert(varchar,JobDate, 120)+ ''' then MSS else 0 end) as ['+convert(varchar(11),JobDate)+ '] , ' 
	FROM [#MSS]	 
	GROUP BY JobDate
	SET @OverallString = left(@OverallString,len(@OverallString)-1)+ ' FROM (SELECT JobDate,SUM([MSS])AS MSS FROM #MSS GROUP BY [JobDate])AS T '
	--Forecast
	DECLARE   @ForecastString   varchar(8000) 
	SET @ForecastString = 'SELECT  ''Target'' AS Items,'
	SELECT 
		 @ForecastString = @ForecastString +CONVERT(varchar(30),ISNULL((SELECT TOP 1 [Forecast] FROM [MSS_Forecast_History] WHERE  [Type]='Shipment' AND [MSS_Forecast_History].[ChangedDate] >= #CurrentCalender.[calenderDate]  AND [Plant]='' AND  [FYear]='FY'+@CurrentFiscalYear AND [Period]=@CurrentFiscalPeriod AND  [Forecast]!=0  ORDER BY ChangedDate ASC ), 0)) + ' AS ['+convert(varchar(11),[calenderDate])+ '] , ' 
	FROM #CurrentCalender
	SET @ForecastString = left(@ForecastString,len(@ForecastString)-1)
 
	EXEC( @B1String + ' UNION ALL ' +@B2FString + ' UNION ALL ' +@B3String + ' UNION ALL ' +@B4String + ' UNION ALL ' +@B5String + ' UNION ALL ' + @HKString + ' UNION ALL ' +@OverallString + ' UNION ALL ' +  @ForecastString ) 
	--print   @B1String + ' UNION ALL ' +@B2FString + ' UNION ALL ' +@B3String + ' UNION ALL ' +@B4String + ' UNION ALL ' +@B5String + ' UNION ALL ' + @HKString + ' UNION ALL ' +@OverallString + ' UNION ALL ' +  @ForecastString 

	--Delete Table
	DROP TABLE [dbo].[#CurrentCalender]
	DROP TABLE [dbo].[#MSS]
END

GO
