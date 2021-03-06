USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[SalesAnalysis_sp_Automatically_Process_Fiscal_JVM_3]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SalesAnalysis_sp_Automatically_Process_Fiscal_JVM_3]
	-- Add the parameters for the stored procedure here
AS
BEGIN

	SET NOCOUNT ON 

	DECLARE @Plant VARCHAR(10)
	
	CREATE TABLE #Temp(
	[ReportCode] [varchar](3) NULL,
	[Site] [varchar](50) NULL,
	[Plant] [varchar](50) NULL,
	[Year] [varchar](4) NULL,
	[M1] [numeric](18, 2) NULL,
	[M2] [numeric](18, 2) NULL,
	[M3] [numeric](18, 2) NULL,
	[M4] [numeric](18, 2) NULL,
	[M5] [numeric](18, 2) NULL,
	[M6] [numeric](18, 2) NULL,
	[M7] [numeric](18, 2) NULL,
	[M8] [numeric](18, 2) NULL,
	[M9] [numeric](18, 2) NULL,
	[M10] [numeric](18, 2) NULL,
	[M11] [numeric](18, 2) NULL,
	[M12] [numeric](18, 2) NULL
	) 
	
	CREATE NONCLUSTERED INDEX [TempReportCode] ON [#Temp] 
	(
		[ReportCode] ASC
	)
	CREATE NONCLUSTERED INDEX [TempSite] ON [#Temp] 
	(
		[Site] ASC
	)
	CREATE NONCLUSTERED INDEX [TempPlant] ON [#Temp] 
	(
		[Plant] ASC
	)
	CREATE NONCLUSTERED INDEX [TempYear] ON [#Temp] 
	(
		[Year] ASC
	)
	
	TRUNCATE TABLE #Temp
	SET @Plant='ZhuHai'
	INSERT INTO #Temp
	SELECT '001' AS ReportCode,
		'Chi' AS Site,
		@Plant AS Plant,
		Year AS Year,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,1,@Plant) AS Period1,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,2,@Plant) AS Period2,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,3,@Plant) AS Period3,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,4,@Plant) AS Period4,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,5,@Plant) AS Period5,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,6,@Plant) AS Period6,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,7,@Plant) AS Period7,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,8,@Plant) AS Period8,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,9,@Plant) AS Period9,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,10,@Plant) AS Period10,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,11,@Plant) AS Period11,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,12,@Plant) AS Period12
	FROM SalesAnalysis_Fiscal_Year
	INSERT INTO #Temp
	SELECT '002' AS ReportCode,
		'Chi' AS Site,
		@Plant AS Plant,
		Year AS Year,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Quarter_JVM_3_1 (Year,1,@Plant) AS Period1,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Quarter_JVM_3_1 (Year,2,@Plant) AS Period2,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Quarter_JVM_3_1 (Year,3,@Plant) AS Period3,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Quarter_JVM_3_1 (Year,4,@Plant) AS Period4,
		0 AS Period5,0 AS Period6,0 AS Period7,0 AS Period8,0 AS Period9,0 AS Period10,0 AS Period11,0 AS Period12
	FROM SalesAnalysis_Fiscal_Year

	SET @Plant='B1'
	INSERT INTO #Temp
	SELECT '001' AS ReportCode,
		'Chi' AS Site,
		@Plant AS Plant,
		Year AS Year,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,1,@Plant) AS Period1,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,2,@Plant) AS Period2,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,3,@Plant) AS Period3,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,4,@Plant) AS Period4,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,5,@Plant) AS Period5,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,6,@Plant) AS Period6,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,7,@Plant) AS Period7,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,8,@Plant) AS Period8,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,9,@Plant) AS Period9,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,10,@Plant) AS Period10,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,11,@Plant) AS Period11,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,12,@Plant) AS Period12
	FROM SalesAnalysis_Fiscal_Year
	INSERT INTO #Temp
	SELECT '002' AS ReportCode,
		'Chi' AS Site,
		@Plant AS Plant,
		Year AS Year,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Quarter_JVM_3_1 (Year,1,@Plant) AS Period1,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Quarter_JVM_3_1 (Year,2,@Plant) AS Period2,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Quarter_JVM_3_1 (Year,3,@Plant) AS Period3,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Quarter_JVM_3_1 (Year,4,@Plant) AS Period4,
		0 AS Period5,0 AS Period6,0 AS Period7,0 AS Period8,0 AS Period9,0 AS Period10,0 AS Period11,0 AS Period12
	FROM SalesAnalysis_Fiscal_Year
	
	SET @Plant='B2F'
	INSERT INTO #Temp
	SELECT '001' AS ReportCode,
		'Chi' AS Site,
		@Plant AS Plant,
		Year AS Year,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,1,@Plant) AS Period1,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,2,@Plant) AS Period2,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,3,@Plant) AS Period3,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,4,@Plant) AS Period4,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,5,@Plant) AS Period5,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,6,@Plant) AS Period6,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,7,@Plant) AS Period7,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,8,@Plant) AS Period8,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,9,@Plant) AS Period9,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,10,@Plant) AS Period10,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,11,@Plant) AS Period11,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,12,@Plant) AS Period12
	FROM SalesAnalysis_Fiscal_Year
	INSERT INTO #Temp
	SELECT '002' AS ReportCode,
		'Chi' AS Site,
		@Plant AS Plant,
		Year AS Year,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Quarter_JVM_3_1 (Year,1,@Plant) AS Period1,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Quarter_JVM_3_1 (Year,2,@Plant) AS Period2,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Quarter_JVM_3_1 (Year,3,@Plant) AS Period3,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Quarter_JVM_3_1 (Year,4,@Plant) AS Period4,
		0 AS Period5,0 AS Period6,0 AS Period7,0 AS Period8,0 AS Period9,0 AS Period10,0 AS Period11,0 AS Period12
	FROM SalesAnalysis_Fiscal_Year
	
	SET @Plant='B3'
	INSERT INTO #Temp
	SELECT '001' AS ReportCode,
		'Chi' AS Site,
		@Plant AS Plant,
		Year AS Year,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,1,@Plant) AS Period1,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,2,@Plant) AS Period2,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,3,@Plant) AS Period3,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,4,@Plant) AS Period4,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,5,@Plant) AS Period5,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,6,@Plant) AS Period6,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,7,@Plant) AS Period7,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,8,@Plant) AS Period8,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,9,@Plant) AS Period9,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,10,@Plant) AS Period10,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,11,@Plant) AS Period11,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,12,@Plant) AS Period12
	FROM SalesAnalysis_Fiscal_Year
	INSERT INTO #Temp
	SELECT '002' AS ReportCode,
		'Chi' AS Site,
		@Plant AS Plant,
		Year AS Year,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Quarter_JVM_3_1 (Year,1,@Plant) AS Period1,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Quarter_JVM_3_1 (Year,2,@Plant) AS Period2,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Quarter_JVM_3_1 (Year,3,@Plant) AS Period3,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Quarter_JVM_3_1 (Year,4,@Plant) AS Period4,
		0 AS Period5,0 AS Period6,0 AS Period7,0 AS Period8,0 AS Period9,0 AS Period10,0 AS Period11,0 AS Period12
	FROM SalesAnalysis_Fiscal_Year
	
	SET @Plant='B4'
	INSERT INTO #Temp
	SELECT '001' AS ReportCode,
		'Chi' AS Site,
		@Plant AS Plant,
		Year AS Year,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,1,@Plant) AS Period1,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,2,@Plant) AS Period2,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,3,@Plant) AS Period3,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,4,@Plant) AS Period4,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,5,@Plant) AS Period5,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,6,@Plant) AS Period6,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,7,@Plant) AS Period7,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,8,@Plant) AS Period8,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,9,@Plant) AS Period9,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,10,@Plant) AS Period10,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,11,@Plant) AS Period11,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,12,@Plant) AS Period12
	FROM SalesAnalysis_Fiscal_Year
	INSERT INTO #Temp
	SELECT '002' AS ReportCode,
		'Chi' AS Site,
		@Plant AS Plant,
		Year AS Year,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Quarter_JVM_3_1 (Year,1,@Plant) AS Period1,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Quarter_JVM_3_1 (Year,2,@Plant) AS Period2,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Quarter_JVM_3_1 (Year,3,@Plant) AS Period3,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Quarter_JVM_3_1 (Year,4,@Plant) AS Period4,
		0 AS Period5,0 AS Period6,0 AS Period7,0 AS Period8,0 AS Period9,0 AS Period10,0 AS Period11,0 AS Period12
	FROM SalesAnalysis_Fiscal_Year

	SET @Plant='B5'
	INSERT INTO #Temp
	SELECT '001' AS ReportCode,
		'Chi' AS Site,
		@Plant AS Plant,
		Year AS Year,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,1,@Plant) AS Period1,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,2,@Plant) AS Period2,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,3,@Plant) AS Period3,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,4,@Plant) AS Period4,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,5,@Plant) AS Period5,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,6,@Plant) AS Period6,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,7,@Plant) AS Period7,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,8,@Plant) AS Period8,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,9,@Plant) AS Period9,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,10,@Plant) AS Period10,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,11,@Plant) AS Period11,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,12,@Plant) AS Period12
	FROM SalesAnalysis_Fiscal_Year
	INSERT INTO #Temp
	SELECT '002' AS ReportCode,
		'Chi' AS Site,
		@Plant AS Plant,
		Year AS Year,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Quarter_JVM_3_1 (Year,1,@Plant) AS Period1,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Quarter_JVM_3_1 (Year,2,@Plant) AS Period2,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Quarter_JVM_3_1 (Year,3,@Plant) AS Period3,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Quarter_JVM_3_1 (Year,4,@Plant) AS Period4,
		0 AS Period5,0 AS Period6,0 AS Period7,0 AS Period8,0 AS Period9,0 AS Period10,0 AS Period11,0 AS Period12
	FROM SalesAnalysis_Fiscal_Year
	
	SET @Plant='VVI'
	INSERT INTO #Temp
	SELECT '001' AS ReportCode,
		'Chi' AS Site,
		@Plant AS Plant,
		Year AS Year,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,1,@Plant) AS Period1,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,2,@Plant) AS Period2,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,3,@Plant) AS Period3,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,4,@Plant) AS Period4,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,5,@Plant) AS Period5,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,6,@Plant) AS Period6,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,7,@Plant) AS Period7,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,8,@Plant) AS Period8,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,9,@Plant) AS Period9,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,10,@Plant) AS Period10,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,11,@Plant) AS Period11,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Period_JVM_3_1 (Year,12,@Plant) AS Period12
	FROM SalesAnalysis_Fiscal_Year
	INSERT INTO #Temp
	SELECT '002' AS ReportCode,
		'Chi' AS Site,
		@Plant AS Plant,
		Year AS Year,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Quarter_JVM_3_1 (Year,1,@Plant) AS Period1,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Quarter_JVM_3_1 (Year,2,@Plant) AS Period2,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Quarter_JVM_3_1 (Year,3,@Plant) AS Period3,
		dbo.SalesAnalysis_fun_Get_Sum_Fiscal_Quarter_JVM_3_1 (Year,4,@Plant) AS Period4,
		0 AS Period5,0 AS Period6,0 AS Period7,0 AS Period8,0 AS Period9,0 AS Period10,0 AS Period11,0 AS Period12
	FROM SalesAnalysis_Fiscal_Year

	INSERT INTO SalesAnalysis_Amount_Fiscal
	SELECT *
	FROM #Temp a
	WHERE NOT EXISTS(SELECT * FROM SalesAnalysis_Amount_Fiscal b WHERE b.ReportCode+b.Site+b.Plant+b.Year=a.ReportCode+a.Site+a.Plant+a.Year)
	UPDATE SalesAnalysis_Amount_Fiscal
	SET M1=b.M1,M2=b.M2,M3=b.M3,M4=b.M4,M5=b.M5,M6=b.M6,M7=b.M7,M8=b.M8,M9=b.M9,M10=b.M10,M11=b.M11,M12=b.M12
	FROM SalesAnalysis_Amount_Fiscal a,#Temp b
	WHERE a.ReportCode=b.ReportCode
		AND a.Site=b.Site
		AND a.Plant=b.Plant
		AND a.Year=b.Year

END
GO
