USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_MSS_MSSAndForecast]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_MSS_MSSAndForecast] 
	@Date datetime
	,@Period VARCHAR(20)
AS
BEGIN
	--CurrentFiscalDate
	DECLARE @CurrentDay DATETIME
	DECLARE @CurrentFiscalYear VARCHAR(4)
	DECLARE @CurrentFiscalPeriod VARCHAR(2)
	DECLARE @CurrentFiscal DATETIME
	

	SELECT @CurrentDay=CONVERT(DATETIME, CONVERT(varchar(100), [UpTime] , 112)) FROM [Multek_ZH].[dbo].[MSS_UpTime]
	SELECT @CurrentFiscalYear=substring([FiscalYearDesc],3,4),@CurrentFiscalPeriod=CONVERT(VARCHAR,FiscalPeriod) FROM  [DataWarehouse].[dbo].[DW_DIM_Calender]
	WHERE DATEDIFF(DAY,CalenderDate,@CurrentDay)=0
	SELECT @CurrentFiscal=CONVERT(DATETIME,@CurrentFiscalYear+'-'+@CurrentFiscalPeriod+'-01')

	--#MSS
	IF (select object_ID('tempdb..#MSS')) >0 
		DROP TABLE [#MSS]
	CREATE TABLE #MSS (
		Plant VARCHAR(50)
		,Outstand NUMERIC(19,4)
		,FGavailable NUMERIC(19,4)
		,FGout NUMERIC(19,4)
		,Forecast NUMERIC(19,4)
	)

	--#MSSLoading
	IF (select object_ID('tempdb..#MSSLoading')) >0 
		DROP TABLE [#MSSLoading]
	SELECT 
	  [Plant]
	  ,[Amount]AS [MSS]
	INTO #MSSLoading
	FROM [MSS_MSS_ByPlant]
	WHERE 1 != 1
		


	IF @Period='ALL'
	BEGIN
		INSERT INTO #MSS
		SELECT 
		  a.[Plant]
		  ,a.[Outstanding]
		  ,a.[FGavailable]
		  ,b.[FGout]
		  ,0 as Forecast
		FROM 
		(
			SELECT 
			  [Plant]
			  ,SUM([BalanceToBuild]) AS Outstanding
			  ,SUM([FGavailable]) AS FGavailable
			FROM [MSS_OrderBacklog_ByOrder]
			WHERE [T$JDAT]=@Date
			GROUP BY  [Plant]
		) AS a 
		LEFT JOIN 
		(
			SELECT  
			  [Plant]
			  ,SUM([FGout]) AS FGout
			FROM [MSS_FGOut_ByOrder]
			WHERE [T$JDAT]=@Date
			GROUP BY  [Plant]
		) AS b
		ON a.[Plant]=b.[Plant]
		
		--MSS Loading
		INSERT INTO #MSSLoading
		SELECT 
		  [Plant]
		  ,SUM([Amount]) AS MSS
		FROM [MSS_MSS_ByPlant]
		WHERE [T$JDAT]=@Date
		GROUP BY  [Plant]
	END
	IF @Period='current'
	BEGIN
		INSERT INTO #MSS
		SELECT 
		  a.[Plant]
		  ,a.[Outstanding]
		  ,a.[FGavailable]
		  ,ISNULL(b.[FGout],0) AS FGout
		  ,(SELECT [forecast] FROM [MSS_Forecast] WHERE  [Type]='Shipment' AND [FYear]='FY'+@CurrentFiscalYear AND [period] = @CurrentFiscalPeriod AND [Plant] =a.[Plant]) as Forecast
		FROM 
		(
			SELECT 
			  [Plant]
			  ,SUM([BalanceToBuild]) AS Outstanding
			  ,SUM([FGavailable]) AS FGavailable
			FROM [MSS_OrderBacklog_ByOrder]
			WHERE [T$JDAT]=@Date
				AND ([T$PDAT_FiscalYear]<@CurrentFiscalYear
				OR([T$PDAT_FiscalYear]=@CurrentFiscalYear AND [T$PDAT_FiscalPeriod]<=@CurrentFiscalPeriod))
			GROUP BY  [Plant]
		) AS a 
		LEFT JOIN 
		(
			SELECT  
			  [Plant]
			  ,SUM([FGout]) AS FGout
			FROM [MSS_FGOut_ByOrder]
			WHERE [T$JDAT]=@Date
				AND [T$AJSD_FiscalYear]=@CurrentFiscalYear
				AND [T$AJSD_FiscalPeriod]=@CurrentFiscalPeriod
			GROUP BY  [Plant]
		) AS b
		ON a.[Plant]=b.[Plant]
		
		--MSS Loading
		INSERT INTO #MSSLoading
		SELECT 
		  [Plant]
		  ,SUM([Amount]) AS MSS
		FROM [MSS_MSS_ByPlant] 
		WHERE [T$JDAT]=@Date
				AND ([T$PDAT_FiscalYear]<@CurrentFiscalYear
				OR([T$PDAT_FiscalYear]=@CurrentFiscalYear AND [T$PDAT_FiscalPeriod]<=@CurrentFiscalPeriod))
		GROUP BY  [Plant]
	END
	IF @Period='next'
	BEGIN
		SELECT @CurrentFiscalYear= substring([FiscalYearDesc],3,4),@CurrentFiscalPeriod=CONVERT(VARCHAR,FiscalPeriod)  FROM  [DataWarehouse].[dbo].[DW_DIM_Calender] WHERE  DATEDIFF(MONTH,@CurrentFiscal, CONVERT(DATETIME, substring([FiscalYearDesc],3,4)+'-'+CONVERT(nvarchar(10),[FiscalPeriod])+'-01'))=1
		
		INSERT INTO #MSS
		SELECT 
		  a.[Plant]
		  ,a.[Outstanding]
		  ,a.[FGavailable]
		  ,ISNULL(b.[FGout],0) AS FGout
		  ,(SELECT [forecast] FROM [MSS_Forecast] WHERE  [Type]='Shipment' AND [FYear]='FY'+@CurrentFiscalYear AND [period] = @CurrentFiscalPeriod AND [Plant] =a.[Plant]) as Forecast
		FROM 
		(
			SELECT 
			  [Plant]
			  ,SUM([BalanceToBuild]) AS Outstanding
			  ,SUM([FGavailable]) AS FGavailable
			FROM [MSS_OrderBacklog_ByOrder]
			WHERE [T$JDAT]=@Date
				AND [T$PDAT_FiscalYear]=@CurrentFiscalYear
				AND [T$PDAT_FiscalPeriod]=@CurrentFiscalPeriod 
			GROUP BY  [Plant]
		) AS a 
		LEFT JOIN 
		(
			SELECT  
			  [Plant]
			  ,SUM([FGout]) AS FGout
			FROM [MSS_FGOut_ByOrder]
			WHERE [T$JDAT]=@Date
				AND [T$AJSD_FiscalYear]=@CurrentFiscalYear
				AND [T$AJSD_FiscalPeriod]=@CurrentFiscalPeriod
			GROUP BY  [Plant]
		) AS b
		ON a.[Plant]=b.[Plant]
		
		--MSS Loading
		INSERT INTO #MSSLoading
		SELECT 
		  [Plant]
		  ,SUM([Amount]) AS MSS
		FROM [MSS_MSS_ByPlant]
		WHERE [T$JDAT]=@Date
				AND [T$PDAT_FiscalYear]=@CurrentFiscalYear
				AND [T$PDAT_FiscalPeriod]=@CurrentFiscalPeriod
		GROUP BY  [Plant]	
	END
	IF @Period='third'
	BEGIN
		SELECT @CurrentFiscalYear= substring([FiscalYearDesc],3,4),@CurrentFiscalPeriod=CONVERT(VARCHAR,FiscalPeriod)  FROM  [DataWarehouse].[dbo].[DW_DIM_Calender] WHERE  DATEDIFF(MONTH,@CurrentFiscal, CONVERT(DATETIME, substring([FiscalYearDesc],3,4)+'-'+CONVERT(nvarchar(10),[FiscalPeriod])+'-01'))=2
		
		INSERT INTO #MSS
		SELECT 
		  a.[Plant]
		  ,a.[Outstanding]
		  ,a.[FGavailable]
		  ,ISNULL(b.[FGout],0) AS FGout
		  ,(SELECT [forecast] FROM [MSS_Forecast] WHERE  [Type]='Shipment' AND [FYear]='FY'+@CurrentFiscalYear AND [period] = @CurrentFiscalPeriod AND [Plant] =a.[Plant]) as Forecast
		FROM 
		(
			SELECT 
			  [Plant]
			  ,SUM([BalanceToBuild]) AS Outstanding
			  ,SUM([FGavailable]) AS FGavailable
			FROM [MSS_OrderBacklog_ByOrder]
			WHERE [T$JDAT]=@Date
				AND [T$PDAT_FiscalYear]=@CurrentFiscalYear 
				AND [T$PDAT_FiscalPeriod]=@CurrentFiscalPeriod
			GROUP BY  [Plant]
		) AS a 
		LEFT JOIN 
		(
			SELECT  
			  [Plant]
			  ,SUM([FGout]) AS FGout
			FROM [MSS_FGOut_ByOrder]
			WHERE [T$JDAT]=@Date
				AND [T$AJSD_FiscalYear]=@CurrentFiscalYear
				AND [T$AJSD_FiscalPeriod]=@CurrentFiscalPeriod
			GROUP BY  [Plant]
		) AS b
		ON a.[Plant]=b.[Plant]	
		
		--MSS Loading
		INSERT INTO #MSSLoading
		SELECT 
		  [Plant]
		  ,SUM([Amount]) AS MSS
		FROM [MSS_MSS_ByPlant]
		WHERE [T$JDAT]=@Date
				AND [T$PDAT_FiscalYear]=@CurrentFiscalYear
				AND [T$PDAT_FiscalPeriod]=@CurrentFiscalPeriod
		GROUP BY  [Plant]	
	END 
	IF @Period='future'
	BEGIN
		SELECT @CurrentFiscalYear= substring([FiscalYearDesc],3,4),@CurrentFiscalPeriod=CONVERT(VARCHAR,FiscalPeriod)  FROM  [DataWarehouse].[dbo].[DW_DIM_Calender] WHERE  DATEDIFF(MONTH,@CurrentFiscal, CONVERT(DATETIME, substring([FiscalYearDesc],3,4)+'-'+CONVERT(nvarchar(10),[FiscalPeriod])+'-01'))=3
		
		INSERT INTO #MSS
		SELECT 
		  a.[Plant]
		  ,a.[Outstanding]
		  ,a.[FGavailable]
		  ,ISNULL(b.[FGout],0) AS FGout
		  ,0 as Forecast
		FROM 
		(
			SELECT 
			  [Plant]
			  ,SUM([BalanceToBuild]) AS Outstanding
			  ,SUM([FGavailable]) AS FGavailable
			FROM [MSS_OrderBacklog_ByOrder]
			WHERE [T$JDAT]=@Date
				AND ([T$PDAT_FiscalYear]>@CurrentFiscalYear
				OR([T$PDAT_FiscalYear]=@CurrentFiscalYear AND [T$PDAT_FiscalPeriod]>=@CurrentFiscalPeriod)
				OR [T$PDAT_FiscalYear] IS NULL)
			GROUP BY  [Plant]
		) AS a 
		LEFT JOIN 
		(
			SELECT  
			  [Plant]
			  ,SUM([FGout]) AS FGout
			FROM [MSS_FGOut_ByOrder]
			WHERE [T$JDAT]=@Date
				AND [T$AJSD_FiscalYear]=@CurrentFiscalYear
				AND [T$AJSD_FiscalPeriod]=@CurrentFiscalPeriod
			GROUP BY  [Plant]
		) AS b
		ON a.[Plant]=b.[Plant]
		
		--MSS Loading
		INSERT INTO #MSSLoading
		SELECT 
		  [Plant]
		  ,SUM([Amount]) AS MSS
		FROM [MSS_MSS_ByPlant]
		WHERE [T$JDAT]=@Date
				AND ([T$PDAT_FiscalYear]>@CurrentFiscalYear
				OR ([T$PDAT_FiscalYear]=@CurrentFiscalYear AND [T$PDAT_FiscalPeriod]>=@CurrentFiscalPeriod)
				OR [T$PDAT_FiscalYear] IS NULL)
		GROUP BY  [Plant]
	END
		
		

	--#MSS122
	IF (select object_ID('tempdb..#MSS122')) >0 
		DROP TABLE [#MSS122]
	SELECT [Items],[B1],[B2F],[B3],[B4],[B5],[VVI]
	INTO #MSS122
	FROM(	
		SELECT  
				'F/G Out' AS Items
				,SUM(CASE WHEN [Plant] = 'B1' THEN [FGout] ELSE 0 END) AS B1
				,SUM(CASE WHEN [Plant] = '2F' THEN [FGout] ELSE 0 END) AS B2F
				,SUM(CASE WHEN [Plant] = 'B3' THEN [FGout] ELSE 0 END) AS B3
				,SUM(CASE WHEN [Plant] = 'B4' THEN [FGout] ELSE 0 END) AS B4
				,SUM(CASE WHEN [Plant] = 'B5' THEN [FGout] ELSE 0 END) AS B5
				,SUM(CASE WHEN [Plant] = 'HK' THEN [FGout] ELSE 0 END) AS VVI
		FROM #MSS
		UNION ALL
		SELECT  
				'F/G available' AS Items
				,SUM(CASE WHEN [Plant] = 'B1' THEN [FGavailable] ELSE 0 END) AS B1
				,SUM(CASE WHEN [Plant] = '2F' THEN [FGavailable] ELSE 0 END) AS B2F
				,SUM(CASE WHEN [Plant] = 'B3' THEN [FGavailable] ELSE 0 END) AS B3
				,SUM(CASE WHEN [Plant] = 'B4' THEN [FGavailable] ELSE 0 END) AS B4
				,SUM(CASE WHEN [Plant] = 'B5' THEN [FGavailable] ELSE 0 END) AS B5
				,SUM(CASE WHEN [Plant] = 'HK' THEN [FGavailable] ELSE 0 END) AS VVI
		FROM #MSS
		UNION ALL
		SELECT  
				'Balance to build' AS Items
				,SUM(CASE WHEN [Plant] = 'B1' THEN [Outstand] ELSE 0 END) AS B1
				,SUM(CASE WHEN [Plant] = '2F' THEN [Outstand] ELSE 0 END) AS B2F
				,SUM(CASE WHEN [Plant] = 'B3' THEN [Outstand] ELSE 0 END) AS B3
				,SUM(CASE WHEN [Plant] = 'B4' THEN [Outstand] ELSE 0 END) AS B4
				,SUM(CASE WHEN [Plant] = 'B5' THEN [Outstand] ELSE 0 END) AS B5
				,SUM(CASE WHEN [Plant] = 'HK' THEN [Outstand] ELSE 0 END) AS VVI
		FROM #MSS
	)AS T1
	

	--#MSS122SUM
	IF (select object_ID('tempdb..#MSS122SUM')) >0 
		DROP TABLE [#MSS122SUM]
	SELECT  
				'MSS Loading' AS Items
				,SUM(CASE WHEN [Plant] = 'B1' THEN [MSS] ELSE 0 END) AS B1
				,SUM(CASE WHEN [Plant] = '2F' THEN [MSS] ELSE 0 END) AS B2F
				,SUM(CASE WHEN [Plant] = 'B3' THEN [MSS] ELSE 0 END) AS B3
				,SUM(CASE WHEN [Plant] = 'B4' THEN [MSS] ELSE 0 END) AS B4
				,SUM(CASE WHEN [Plant] = 'B5' THEN [MSS] ELSE 0 END) AS B5
				,SUM(CASE WHEN [Plant] = 'HK' THEN [MSS] ELSE 0 END) AS VVI
	INTO #MSS122SUM
	FROM #MSSLoading





	--#Forecast
	IF (select object_ID('tempdb..#Forecast')) >0 
		DROP TABLE [#Forecast]
	SELECT  
			'Finance Fcst' AS Items
			,SUM(CASE WHEN [Plant] = 'B1' THEN [Forecast] ELSE 0 END) AS B1
			,SUM(CASE WHEN [Plant] = '2F' THEN [Forecast] ELSE 0 END) AS B2F
			,SUM(CASE WHEN [Plant] = 'B3' THEN [Forecast] ELSE 0 END) AS B3
			,SUM(CASE WHEN [Plant] = 'B4' THEN [Forecast] ELSE 0 END) AS B4
			,SUM(CASE WHEN [Plant] = 'B5' THEN [Forecast] ELSE 0 END) AS B5
			,SUM(CASE WHEN [Plant] = 'HK' THEN [Forecast] ELSE 0 END) AS VVI
	INTO #Forecast
	FROM #MSS





	SELECT *,([B1]+[B2F]+[B3]+[B4]+[B5]+[VVI])AS [Total]  FROM #Forecast
	UNION ALL
	SELECT *,([B1]+[B2F]+[B3]+[B4]+[B5]+[VVI])AS [Total]  FROM #MSS122SUM
	UNION ALL
	SELECT *,([B1]+[B2F]+[B3]+[B4]+[B5]+[VVI])AS [Total]  
	FROM(
		SELECT  
		'Gap(MSS Vs FIN Fcst)' AS Items
		,(CASE WHEN #Forecast.[B1] = 0 THEN 0 ELSE #MSS122SUM.[B1] - #Forecast.[B1] END) AS B1
		,(CASE WHEN #Forecast.[B2F] = 0 THEN 0 ELSE #MSS122SUM.[B2F] - #Forecast.[B2F] END) AS B2F
		,(CASE WHEN #Forecast.[B3] = 0 THEN 0 ELSE #MSS122SUM.[B3] - #Forecast.[B3] END) AS B3
		,(CASE WHEN #Forecast.[B4] = 0 THEN 0 ELSE #MSS122SUM.[B4] - #Forecast.[B4] END) AS B4
		,(CASE WHEN #Forecast.[B5] = 0 THEN 0 ELSE #MSS122SUM.[B5] - #Forecast.[B5] END) AS B5
		,(CASE WHEN #Forecast.[VVI] = 0 THEN 0 ELSE #MSS122SUM.[VVI] - #Forecast.[VVI] END) AS VVI
		FROM #Forecast,#MSS122SUM
	)T2
	UNION ALL
	SELECT *,([B1]+[B2F]+[B3]+[B4]+[B5]+[VVI])AS [Total]  FROM #MSS122



	--Delete Table
	DROP TABLE #MSS
	DROP TABLE #MSS122
	DROP TABLE #MSS122SUM
	DROP TABLE #MSSLoading
	DROP TABLE #Forecast



END


GO
