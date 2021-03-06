USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[DistributionReport_sp_Automatically_Process_Scrap]    Script Date: 11/06/2014 15:47:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DistributionReport_sp_Automatically_Process_Scrap]
	-- Add the parameters for the stored procedure here
AS
BEGIN

	SET NOCOUNT ON 

	DECLARE @ReportCode VARCHAR(3),@Site VARCHAR(10),@Plant VARCHAR(3),@Type VARCHAR(30)
	
	CREATE TABLE #Temp(
	[ReportCode] [varchar](3) NULL,
	[Type] [varchar](50) NULL,
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
	CREATE NONCLUSTERED INDEX [TempType] ON [#Temp] 
	(
		[Type] ASC
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
	
	SET @Type='SCRAP'
	
	SET @ReportCode='555'
	SET @Site='Chi'
	SET @Plant='P2'
	TRUNCATE TABLE #Temp
	INSERT INTO #Temp
	SELECT @ReportCode AS ReportCode,@Type AS Type,
		@Site AS Site,
		@Plant AS Plant,
		Year AS Year,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_Scrap (Year,1,@Site,@Plant) AS Period1,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_Scrap (Year,2,@Site,@Plant) AS Period2,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_Scrap (Year,3,@Site,@Plant) AS Period3,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_Scrap (Year,4,@Site,@Plant) AS Period4,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_Scrap (Year,5,@Site,@Plant) AS Period5,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_Scrap (Year,6,@Site,@Plant) AS Period6,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_Scrap (Year,7,@Site,@Plant) AS Period7,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_Scrap (Year,8,@Site,@Plant) AS Period8,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_Scrap (Year,9,@Site,@Plant) AS Period9,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_Scrap (Year,10,@Site,@Plant) AS Period10,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_Scrap (Year,11,@Site,@Plant) AS Period11,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_Scrap (Year,12,@Site,@Plant) AS Period12
	FROM DistributionReport_Fiscal_Year
	--DELETE DistribitionReport_Amount_Fiscal WHERE ReportCode='555'
	INSERT INTO DistribitionReport_Amount_Fiscal
	SELECT *
	FROM #Temp a
	WHERE NOT EXISTS(SELECT * FROM DistribitionReport_Amount_Fiscal b WHERE b.ReportCode+b.Type+b.Site+b.Plant+b.Year=a.ReportCode+a.Type+a.Site+a.Plant+a.Year)
	UPDATE DistribitionReport_Amount_Fiscal
	SET M1=b.M1,M2=b.M2,M3=b.M3,M4=b.M4,M5=b.M5,M6=b.M6,M7=b.M7,M8=b.M8,M9=b.M9,M10=b.M10,M11=b.M11,M12=b.M12
	FROM DistribitionReport_Amount_Fiscal a,#Temp b
	WHERE a.ReportCode=b.ReportCode AND a.Type=b.Type 
		AND a.Site=b.Site
		AND a.Plant=b.Plant
		AND a.Year=b.Year
	SET @Plant='2F'
	TRUNCATE TABLE #Temp
	INSERT INTO #Temp
	SELECT @ReportCode AS ReportCode,@Type AS Type,
		@Site AS Site,
		@Plant AS Plant,
		Year AS Year,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_Scrap (Year,1,@Site,@Plant) AS Period1,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_Scrap (Year,2,@Site,@Plant) AS Period2,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_Scrap (Year,3,@Site,@Plant) AS Period3,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_Scrap (Year,4,@Site,@Plant) AS Period4,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_Scrap (Year,5,@Site,@Plant) AS Period5,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_Scrap (Year,6,@Site,@Plant) AS Period6,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_Scrap (Year,7,@Site,@Plant) AS Period7,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_Scrap (Year,8,@Site,@Plant) AS Period8,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_Scrap (Year,9,@Site,@Plant) AS Period9,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_Scrap (Year,10,@Site,@Plant) AS Period10,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_Scrap (Year,11,@Site,@Plant) AS Period11,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_Scrap (Year,12,@Site,@Plant) AS Period12
	FROM DistributionReport_Fiscal_Year
	--DELETE DistribitionReport_Amount_Fiscal WHERE ReportCode='555'
	INSERT INTO DistribitionReport_Amount_Fiscal
	SELECT *
	FROM #Temp a
	WHERE NOT EXISTS(SELECT * FROM DistribitionReport_Amount_Fiscal b WHERE b.ReportCode+b.Type+b.Site+b.Plant+b.Year=a.ReportCode+a.Type+a.Site+a.Plant+a.Year)
	UPDATE DistribitionReport_Amount_Fiscal
	SET M1=b.M1,M2=b.M2,M3=b.M3,M4=b.M4,M5=b.M5,M6=b.M6,M7=b.M7,M8=b.M8,M9=b.M9,M10=b.M10,M11=b.M11,M12=b.M12
	FROM DistribitionReport_Amount_Fiscal a,#Temp b
	WHERE a.ReportCode=b.ReportCode AND a.Type=b.Type 
		AND a.Site=b.Site
		AND a.Plant=b.Plant
		AND a.Year=b.Year
	SET @Plant='B3'
	TRUNCATE TABLE #Temp
	INSERT INTO #Temp
	SELECT @ReportCode AS ReportCode,@Type AS Type,
		@Site AS Site,
		@Plant AS Plant,
		Year AS Year,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_Scrap (Year,1,@Site,@Plant) AS Period1,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_Scrap (Year,2,@Site,@Plant) AS Period2,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_Scrap (Year,3,@Site,@Plant) AS Period3,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_Scrap (Year,4,@Site,@Plant) AS Period4,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_Scrap (Year,5,@Site,@Plant) AS Period5,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_Scrap (Year,6,@Site,@Plant) AS Period6,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_Scrap (Year,7,@Site,@Plant) AS Period7,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_Scrap (Year,8,@Site,@Plant) AS Period8,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_Scrap (Year,9,@Site,@Plant) AS Period9,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_Scrap (Year,10,@Site,@Plant) AS Period10,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_Scrap (Year,11,@Site,@Plant) AS Period11,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_Scrap (Year,12,@Site,@Plant) AS Period12
	FROM DistributionReport_Fiscal_Year
	--DELETE DistribitionReport_Amount_Fiscal WHERE ReportCode='555'
	INSERT INTO DistribitionReport_Amount_Fiscal
	SELECT *
	FROM #Temp a
	WHERE NOT EXISTS(SELECT * FROM DistribitionReport_Amount_Fiscal b WHERE b.ReportCode+b.Type+b.Site+b.Plant+b.Year=a.ReportCode+a.Type+a.Site+a.Plant+a.Year)
	UPDATE DistribitionReport_Amount_Fiscal
	SET M1=b.M1,M2=b.M2,M3=b.M3,M4=b.M4,M5=b.M5,M6=b.M6,M7=b.M7,M8=b.M8,M9=b.M9,M10=b.M10,M11=b.M11,M12=b.M12
	FROM DistribitionReport_Amount_Fiscal a,#Temp b
	WHERE a.ReportCode=b.ReportCode AND a.Type=b.Type 
		AND a.Site=b.Site
		AND a.Plant=b.Plant
		AND a.Year=b.Year
	SET @Plant='B4'
	TRUNCATE TABLE #Temp
	INSERT INTO #Temp
	SELECT @ReportCode AS ReportCode,@Type AS Type,
		@Site AS Site,
		@Plant AS Plant,
		Year AS Year,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_Scrap (Year,1,@Site,@Plant) AS Period1,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_Scrap (Year,2,@Site,@Plant) AS Period2,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_Scrap (Year,3,@Site,@Plant) AS Period3,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_Scrap (Year,4,@Site,@Plant) AS Period4,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_Scrap (Year,5,@Site,@Plant) AS Period5,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_Scrap (Year,6,@Site,@Plant) AS Period6,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_Scrap (Year,7,@Site,@Plant) AS Period7,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_Scrap (Year,8,@Site,@Plant) AS Period8,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_Scrap (Year,9,@Site,@Plant) AS Period9,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_Scrap (Year,10,@Site,@Plant) AS Period10,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_Scrap (Year,11,@Site,@Plant) AS Period11,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_Scrap (Year,12,@Site,@Plant) AS Period12
	FROM DistributionReport_Fiscal_Year
	--DELETE DistribitionReport_Amount_Fiscal WHERE ReportCode='555'
	INSERT INTO DistribitionReport_Amount_Fiscal
	SELECT *
	FROM #Temp a
	WHERE NOT EXISTS(SELECT * FROM DistribitionReport_Amount_Fiscal b WHERE b.ReportCode+b.Type+b.Site+b.Plant+b.Year=a.ReportCode+a.Type+a.Site+a.Plant+a.Year)
	UPDATE DistribitionReport_Amount_Fiscal
	SET M1=b.M1,M2=b.M2,M3=b.M3,M4=b.M4,M5=b.M5,M6=b.M6,M7=b.M7,M8=b.M8,M9=b.M9,M10=b.M10,M11=b.M11,M12=b.M12
	FROM DistribitionReport_Amount_Fiscal a,#Temp b
	WHERE a.ReportCode=b.ReportCode AND a.Type=b.Type 
		AND a.Site=b.Site
		AND a.Plant=b.Plant
		AND a.Year=b.Year
	SET @Plant='B5'
	TRUNCATE TABLE #Temp
	INSERT INTO #Temp
	SELECT @ReportCode AS ReportCode,@Type AS Type,
		@Site AS Site,
		@Plant AS Plant,
		Year AS Year,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_Scrap (Year,1,@Site,@Plant) AS Period1,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_Scrap (Year,2,@Site,@Plant) AS Period2,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_Scrap (Year,3,@Site,@Plant) AS Period3,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_Scrap (Year,4,@Site,@Plant) AS Period4,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_Scrap (Year,5,@Site,@Plant) AS Period5,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_Scrap (Year,6,@Site,@Plant) AS Period6,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_Scrap (Year,7,@Site,@Plant) AS Period7,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_Scrap (Year,8,@Site,@Plant) AS Period8,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_Scrap (Year,9,@Site,@Plant) AS Period9,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_Scrap (Year,10,@Site,@Plant) AS Period10,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_Scrap (Year,11,@Site,@Plant) AS Period11,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_Scrap (Year,12,@Site,@Plant) AS Period12
	FROM DistributionReport_Fiscal_Year
	--DELETE DistribitionReport_Amount_Fiscal WHERE ReportCode='555'
	INSERT INTO DistribitionReport_Amount_Fiscal
	SELECT *
	FROM #Temp a
	WHERE NOT EXISTS(SELECT * FROM DistribitionReport_Amount_Fiscal b WHERE b.ReportCode+b.Type+b.Site+b.Plant+b.Year=a.ReportCode+a.Type+a.Site+a.Plant+a.Year)
	UPDATE DistribitionReport_Amount_Fiscal
	SET M1=b.M1,M2=b.M2,M3=b.M3,M4=b.M4,M5=b.M5,M6=b.M6,M7=b.M7,M8=b.M8,M9=b.M9,M10=b.M10,M11=b.M11,M12=b.M12
	FROM DistribitionReport_Amount_Fiscal a,#Temp b
	WHERE a.ReportCode=b.ReportCode AND a.Type=b.Type 
		AND a.Site=b.Site
		AND a.Plant=b.Plant
		AND a.Year=b.Year
	SET @Plant='HK'
	TRUNCATE TABLE #Temp
	INSERT INTO #Temp
	SELECT @ReportCode AS ReportCode,@Type AS Type,
		@Site AS Site,
		@Plant AS Plant,
		Year AS Year,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_Scrap (Year,1,@Site,@Plant) AS Period1,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_Scrap (Year,2,@Site,@Plant) AS Period2,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_Scrap (Year,3,@Site,@Plant) AS Period3,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_Scrap (Year,4,@Site,@Plant) AS Period4,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_Scrap (Year,5,@Site,@Plant) AS Period5,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_Scrap (Year,6,@Site,@Plant) AS Period6,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_Scrap (Year,7,@Site,@Plant) AS Period7,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_Scrap (Year,8,@Site,@Plant) AS Period8,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_Scrap (Year,9,@Site,@Plant) AS Period9,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_Scrap (Year,10,@Site,@Plant) AS Period10,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_Scrap (Year,11,@Site,@Plant) AS Period11,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_Scrap (Year,12,@Site,@Plant) AS Period12
	FROM DistributionReport_Fiscal_Year
	--DELETE DistribitionReport_Amount_Fiscal WHERE ReportCode='555'
	INSERT INTO DistribitionReport_Amount_Fiscal
	SELECT *
	FROM #Temp a
	WHERE NOT EXISTS(SELECT * FROM DistribitionReport_Amount_Fiscal b WHERE b.ReportCode+b.Type+b.Site+b.Plant+b.Year=a.ReportCode+a.Type+a.Site+a.Plant+a.Year)
	UPDATE DistribitionReport_Amount_Fiscal
	SET M1=b.M1,M2=b.M2,M3=b.M3,M4=b.M4,M5=b.M5,M6=b.M6,M7=b.M7,M8=b.M8,M9=b.M9,M10=b.M10,M11=b.M11,M12=b.M12
	FROM DistribitionReport_Amount_Fiscal a,#Temp b
	WHERE a.ReportCode=b.ReportCode AND a.Type=b.Type 
		AND a.Site=b.Site
		AND a.Plant=b.Plant
		AND a.Year=b.Year
	SET @Plant=''
	TRUNCATE TABLE #Temp
	INSERT INTO #Temp
	SELECT @ReportCode AS ReportCode,@Type AS Type,
		@Site AS Site,
		@Plant AS Plant,
		a.Year AS Year,
		ISNULL((SELECT SUM(ISNULL(M1,0)) FROM DistribitionReport_Amount_Fiscal b WHERE b.Year=a.Year AND b.ReportCode=@ReportCode AND b.Type=@Type AND b.Site=@Site AND b.Plant<>@Plant),0) AS Period1,
		ISNULL((SELECT SUM(ISNULL(M2,0)) FROM DistribitionReport_Amount_Fiscal b WHERE b.Year=a.Year AND b.ReportCode=@ReportCode AND b.Type=@Type AND b.Site=@Site AND b.Plant<>@Plant),0) AS Period2,
		ISNULL((SELECT SUM(ISNULL(M3,0)) FROM DistribitionReport_Amount_Fiscal b WHERE b.Year=a.Year AND b.ReportCode=@ReportCode AND b.Type=@Type AND b.Site=@Site AND b.Plant<>@Plant),0) AS Period3,
		ISNULL((SELECT SUM(ISNULL(M4,0)) FROM DistribitionReport_Amount_Fiscal b WHERE b.Year=a.Year AND b.ReportCode=@ReportCode AND b.Type=@Type AND b.Site=@Site AND b.Plant<>@Plant),0) AS Period4,
		ISNULL((SELECT SUM(ISNULL(M5,0)) FROM DistribitionReport_Amount_Fiscal b WHERE b.Year=a.Year AND b.ReportCode=@ReportCode AND b.Type=@Type AND b.Site=@Site AND b.Plant<>@Plant),0) AS Period5,
		ISNULL((SELECT SUM(ISNULL(M6,0)) FROM DistribitionReport_Amount_Fiscal b WHERE b.Year=a.Year AND b.ReportCode=@ReportCode AND b.Type=@Type AND b.Site=@Site AND b.Plant<>@Plant),0) AS Period6,
		ISNULL((SELECT SUM(ISNULL(M7,0)) FROM DistribitionReport_Amount_Fiscal b WHERE b.Year=a.Year AND b.ReportCode=@ReportCode AND b.Type=@Type AND b.Site=@Site AND b.Plant<>@Plant),0) AS Period7,
		ISNULL((SELECT SUM(ISNULL(M8,0)) FROM DistribitionReport_Amount_Fiscal b WHERE b.Year=a.Year AND b.ReportCode=@ReportCode AND b.Type=@Type AND b.Site=@Site AND b.Plant<>@Plant),0) AS Period8,
		ISNULL((SELECT SUM(ISNULL(M9,0)) FROM DistribitionReport_Amount_Fiscal b WHERE b.Year=a.Year AND b.ReportCode=@ReportCode AND b.Type=@Type AND b.Site=@Site AND b.Plant<>@Plant),0) AS Period9,
		ISNULL((SELECT SUM(ISNULL(M10,0)) FROM DistribitionReport_Amount_Fiscal b WHERE b.Year=a.Year AND b.ReportCode=@ReportCode AND b.Type=@Type AND b.Site=@Site AND b.Plant<>@Plant),0) AS Period10,
		ISNULL((SELECT SUM(ISNULL(M11,0)) FROM DistribitionReport_Amount_Fiscal b WHERE b.Year=a.Year AND b.ReportCode=@ReportCode AND b.Type=@Type AND b.Site=@Site AND b.Plant<>@Plant),0) AS Period11,
		ISNULL((SELECT SUM(ISNULL(M12,0)) FROM DistribitionReport_Amount_Fiscal b WHERE b.Year=a.Year AND b.ReportCode=@ReportCode AND b.Type=@Type AND b.Site=@Site AND b.Plant<>@Plant),0) AS Period12
	FROM DistributionReport_Fiscal_Year a
	--DELETE DistribitionReport_Amount_Fiscal WHERE ReportCode='555'
	INSERT INTO DistribitionReport_Amount_Fiscal
	SELECT *
	FROM #Temp a
	WHERE NOT EXISTS(SELECT * FROM DistribitionReport_Amount_Fiscal b WHERE b.ReportCode+b.Type+b.Site+b.Plant+b.Year=a.ReportCode+a.Type+a.Site+a.Plant+a.Year)
	UPDATE DistribitionReport_Amount_Fiscal
	SET M1=b.M1,M2=b.M2,M3=b.M3,M4=b.M4,M5=b.M5,M6=b.M6,M7=b.M7,M8=b.M8,M9=b.M9,M10=b.M10,M11=b.M11,M12=b.M12
	FROM DistribitionReport_Amount_Fiscal a,#Temp b
	WHERE a.ReportCode=b.ReportCode AND a.Type=b.Type 
		AND a.Site=b.Site
		AND a.Plant=b.Plant
		AND a.Year=b.Year

	SET @ReportCode='554'
	SET @Site='Chi'
	SET @Plant='P2'
	TRUNCATE TABLE #Temp
	INSERT INTO #Temp
	SELECT @ReportCode AS ReportCode,@Type AS Type,
		@Site AS Site,
		@Plant AS Plant,
		Year AS Year,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Quarter_Scrap (Year,1,@Site,@Plant) AS Period1,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Quarter_Scrap (Year,2,@Site,@Plant) AS Period2,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Quarter_Scrap (Year,3,@Site,@Plant) AS Period3,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Quarter_Scrap (Year,4,@Site,@Plant) AS Period4,
		0 AS M5,0 AS M6,0 AS M7, 0 AS M8, 0 AS M9, 0 AS M10, 0 AS M11, 0 AS M12
	FROM DistributionReport_Fiscal_Year
	--DELETE DistribitionReport_Amount_Fiscal WHERE ReportCode='555'
	INSERT INTO DistribitionReport_Amount_Fiscal
	SELECT *
	FROM #Temp a
	WHERE NOT EXISTS(SELECT * FROM DistribitionReport_Amount_Fiscal b WHERE b.ReportCode+b.Type+b.Site+b.Plant+b.Year=a.ReportCode+a.Type+a.Site+a.Plant+a.Year)
	UPDATE DistribitionReport_Amount_Fiscal
	SET M1=b.M1,M2=b.M2,M3=b.M3,M4=b.M4,M5=b.M5,M6=b.M6,M7=b.M7,M8=b.M8,M9=b.M9,M10=b.M10,M11=b.M11,M12=b.M12
	FROM DistribitionReport_Amount_Fiscal a,#Temp b
	WHERE a.ReportCode=b.ReportCode AND a.Type=b.Type 
		AND a.Site=b.Site
		AND a.Plant=b.Plant
		AND a.Year=b.Year
	SET @Plant='2F'
	TRUNCATE TABLE #Temp
	INSERT INTO #Temp
	SELECT @ReportCode AS ReportCode,@Type AS Type,
		@Site AS Site,
		@Plant AS Plant,
		Year AS Year,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Quarter_Scrap (Year,1,@Site,@Plant) AS Period1,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Quarter_Scrap (Year,2,@Site,@Plant) AS Period2,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Quarter_Scrap (Year,3,@Site,@Plant) AS Period3,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Quarter_Scrap (Year,4,@Site,@Plant) AS Period4,
		0 AS M5,0 AS M6,0 AS M7, 0 AS M8, 0 AS M9, 0 AS M10, 0 AS M11, 0 AS M12
	FROM DistributionReport_Fiscal_Year
	--DELETE DistribitionReport_Amount_Fiscal WHERE ReportCode='555'
	INSERT INTO DistribitionReport_Amount_Fiscal
	SELECT *
	FROM #Temp a
	WHERE NOT EXISTS(SELECT * FROM DistribitionReport_Amount_Fiscal b WHERE b.ReportCode+b.Type+b.Site+b.Plant+b.Year=a.ReportCode+a.Type+a.Site+a.Plant+a.Year)
	UPDATE DistribitionReport_Amount_Fiscal
	SET M1=b.M1,M2=b.M2,M3=b.M3,M4=b.M4,M5=b.M5,M6=b.M6,M7=b.M7,M8=b.M8,M9=b.M9,M10=b.M10,M11=b.M11,M12=b.M12
	FROM DistribitionReport_Amount_Fiscal a,#Temp b
	WHERE a.ReportCode=b.ReportCode AND a.Type=b.Type 
		AND a.Site=b.Site
		AND a.Plant=b.Plant
		AND a.Year=b.Year
	SET @Plant='B3'
	TRUNCATE TABLE #Temp
	INSERT INTO #Temp
	SELECT @ReportCode AS ReportCode,@Type AS Type,
		@Site AS Site,
		@Plant AS Plant,
		Year AS Year,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Quarter_Scrap (Year,1,@Site,@Plant) AS Period1,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Quarter_Scrap (Year,2,@Site,@Plant) AS Period2,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Quarter_Scrap (Year,3,@Site,@Plant) AS Period3,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Quarter_Scrap (Year,4,@Site,@Plant) AS Period4,
		0 AS M5,0 AS M6,0 AS M7, 0 AS M8, 0 AS M9, 0 AS M10, 0 AS M11, 0 AS M12
	FROM DistributionReport_Fiscal_Year
	--DELETE DistribitionReport_Amount_Fiscal WHERE ReportCode='555'
	INSERT INTO DistribitionReport_Amount_Fiscal
	SELECT *
	FROM #Temp a
	WHERE NOT EXISTS(SELECT * FROM DistribitionReport_Amount_Fiscal b WHERE b.ReportCode+b.Type+b.Site+b.Plant+b.Year=a.ReportCode+a.Type+a.Site+a.Plant+a.Year)
	UPDATE DistribitionReport_Amount_Fiscal
	SET M1=b.M1,M2=b.M2,M3=b.M3,M4=b.M4,M5=b.M5,M6=b.M6,M7=b.M7,M8=b.M8,M9=b.M9,M10=b.M10,M11=b.M11,M12=b.M12
	FROM DistribitionReport_Amount_Fiscal a,#Temp b
	WHERE a.ReportCode=b.ReportCode AND a.Type=b.Type 
		AND a.Site=b.Site
		AND a.Plant=b.Plant
		AND a.Year=b.Year
	SET @Plant='B4'
	TRUNCATE TABLE #Temp
	INSERT INTO #Temp
	SELECT @ReportCode AS ReportCode,@Type AS Type,
		@Site AS Site,
		@Plant AS Plant,
		Year AS Year,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Quarter_Scrap (Year,1,@Site,@Plant) AS Period1,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Quarter_Scrap (Year,2,@Site,@Plant) AS Period2,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Quarter_Scrap (Year,3,@Site,@Plant) AS Period3,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Quarter_Scrap (Year,4,@Site,@Plant) AS Period4,
		0 AS M5,0 AS M6,0 AS M7, 0 AS M8, 0 AS M9, 0 AS M10, 0 AS M11, 0 AS M12
	FROM DistributionReport_Fiscal_Year
	--DELETE DistribitionReport_Amount_Fiscal WHERE ReportCode='555'
	INSERT INTO DistribitionReport_Amount_Fiscal
	SELECT *
	FROM #Temp a
	WHERE NOT EXISTS(SELECT * FROM DistribitionReport_Amount_Fiscal b WHERE b.ReportCode+b.Type+b.Site+b.Plant+b.Year=a.ReportCode+a.Type+a.Site+a.Plant+a.Year)
	UPDATE DistribitionReport_Amount_Fiscal
	SET M1=b.M1,M2=b.M2,M3=b.M3,M4=b.M4,M5=b.M5,M6=b.M6,M7=b.M7,M8=b.M8,M9=b.M9,M10=b.M10,M11=b.M11,M12=b.M12
	FROM DistribitionReport_Amount_Fiscal a,#Temp b
	WHERE a.ReportCode=b.ReportCode AND a.Type=b.Type 
		AND a.Site=b.Site
		AND a.Plant=b.Plant
		AND a.Year=b.Year
	SET @Plant='B5'
	TRUNCATE TABLE #Temp
	INSERT INTO #Temp
	SELECT @ReportCode AS ReportCode,@Type AS Type,
		@Site AS Site,
		@Plant AS Plant,
		Year AS Year,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Quarter_Scrap (Year,1,@Site,@Plant) AS Period1,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Quarter_Scrap (Year,2,@Site,@Plant) AS Period2,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Quarter_Scrap (Year,3,@Site,@Plant) AS Period3,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Quarter_Scrap (Year,4,@Site,@Plant) AS Period4,
		0 AS M5,0 AS M6,0 AS M7, 0 AS M8, 0 AS M9, 0 AS M10, 0 AS M11, 0 AS M12
	FROM DistributionReport_Fiscal_Year
	--DELETE DistribitionReport_Amount_Fiscal WHERE ReportCode='555'
	INSERT INTO DistribitionReport_Amount_Fiscal
	SELECT *
	FROM #Temp a
	WHERE NOT EXISTS(SELECT * FROM DistribitionReport_Amount_Fiscal b WHERE b.ReportCode+b.Type+b.Site+b.Plant+b.Year=a.ReportCode+a.Type+a.Site+a.Plant+a.Year)
	UPDATE DistribitionReport_Amount_Fiscal
	SET M1=b.M1,M2=b.M2,M3=b.M3,M4=b.M4,M5=b.M5,M6=b.M6,M7=b.M7,M8=b.M8,M9=b.M9,M10=b.M10,M11=b.M11,M12=b.M12
	FROM DistribitionReport_Amount_Fiscal a,#Temp b
	WHERE a.ReportCode=b.ReportCode AND a.Type=b.Type 
		AND a.Site=b.Site
		AND a.Plant=b.Plant
		AND a.Year=b.Year
	SET @Plant='HK'
	TRUNCATE TABLE #Temp
	INSERT INTO #Temp
	SELECT @ReportCode AS ReportCode,@Type AS Type,
		@Site AS Site,
		@Plant AS Plant,
		Year AS Year,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Quarter_Scrap (Year,1,@Site,@Plant) AS Period1,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Quarter_Scrap (Year,2,@Site,@Plant) AS Period2,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Quarter_Scrap (Year,3,@Site,@Plant) AS Period3,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Quarter_Scrap (Year,4,@Site,@Plant) AS Period4,
		0 AS M5,0 AS M6,0 AS M7, 0 AS M8, 0 AS M9, 0 AS M10, 0 AS M11, 0 AS M12
	FROM DistributionReport_Fiscal_Year
	--DELETE DistribitionReport_Amount_Fiscal WHERE ReportCode='555'
	INSERT INTO DistribitionReport_Amount_Fiscal
	SELECT *
	FROM #Temp a
	WHERE NOT EXISTS(SELECT * FROM DistribitionReport_Amount_Fiscal b WHERE b.ReportCode+b.Type+b.Site+b.Plant+b.Year=a.ReportCode+a.Type+a.Site+a.Plant+a.Year)
	UPDATE DistribitionReport_Amount_Fiscal
	SET M1=b.M1,M2=b.M2,M3=b.M3,M4=b.M4,M5=b.M5,M6=b.M6,M7=b.M7,M8=b.M8,M9=b.M9,M10=b.M10,M11=b.M11,M12=b.M12
	FROM DistribitionReport_Amount_Fiscal a,#Temp b
	WHERE a.ReportCode=b.ReportCode AND a.Type=b.Type 
		AND a.Site=b.Site
		AND a.Plant=b.Plant
		AND a.Year=b.Year
	SET @Plant=''
	TRUNCATE TABLE #Temp
	INSERT INTO #Temp
	SELECT @ReportCode AS ReportCode,@Type AS Type,
		@Site AS Site,
		@Plant AS Plant,
		a.Year AS Year,
		ISNULL((SELECT SUM(ISNULL(M1,0)) FROM DistribitionReport_Amount_Fiscal b WHERE b.Year=a.Year AND b.ReportCode=@ReportCode AND b.Type=@Type AND b.Site=@Site AND b.Plant<>@Plant),0) AS Period1,
		ISNULL((SELECT SUM(ISNULL(M2,0)) FROM DistribitionReport_Amount_Fiscal b WHERE b.Year=a.Year AND b.ReportCode=@ReportCode AND b.Type=@Type AND b.Site=@Site AND b.Plant<>@Plant),0) AS Period2,
		ISNULL((SELECT SUM(ISNULL(M3,0)) FROM DistribitionReport_Amount_Fiscal b WHERE b.Year=a.Year AND b.ReportCode=@ReportCode AND b.Type=@Type AND b.Site=@Site AND b.Plant<>@Plant),0) AS Period3,
		ISNULL((SELECT SUM(ISNULL(M4,0)) FROM DistribitionReport_Amount_Fiscal b WHERE b.Year=a.Year AND b.ReportCode=@ReportCode AND b.Type=@Type AND b.Site=@Site AND b.Plant<>@Plant),0) AS Period4,
		ISNULL((SELECT SUM(ISNULL(M5,0)) FROM DistribitionReport_Amount_Fiscal b WHERE b.Year=a.Year AND b.ReportCode=@ReportCode AND b.Type=@Type AND b.Site=@Site AND b.Plant<>@Plant),0) AS Period5,
		ISNULL((SELECT SUM(ISNULL(M6,0)) FROM DistribitionReport_Amount_Fiscal b WHERE b.Year=a.Year AND b.ReportCode=@ReportCode AND b.Type=@Type AND b.Site=@Site AND b.Plant<>@Plant),0) AS Period6,
		ISNULL((SELECT SUM(ISNULL(M7,0)) FROM DistribitionReport_Amount_Fiscal b WHERE b.Year=a.Year AND b.ReportCode=@ReportCode AND b.Type=@Type AND b.Site=@Site AND b.Plant<>@Plant),0) AS Period7,
		ISNULL((SELECT SUM(ISNULL(M8,0)) FROM DistribitionReport_Amount_Fiscal b WHERE b.Year=a.Year AND b.ReportCode=@ReportCode AND b.Type=@Type AND b.Site=@Site AND b.Plant<>@Plant),0) AS Period8,
		ISNULL((SELECT SUM(ISNULL(M9,0)) FROM DistribitionReport_Amount_Fiscal b WHERE b.Year=a.Year AND b.ReportCode=@ReportCode AND b.Type=@Type AND b.Site=@Site AND b.Plant<>@Plant),0) AS Period9,
		ISNULL((SELECT SUM(ISNULL(M10,0)) FROM DistribitionReport_Amount_Fiscal b WHERE b.Year=a.Year AND b.ReportCode=@ReportCode AND b.Type=@Type AND b.Site=@Site AND b.Plant<>@Plant),0) AS Period10,
		ISNULL((SELECT SUM(ISNULL(M11,0)) FROM DistribitionReport_Amount_Fiscal b WHERE b.Year=a.Year AND b.ReportCode=@ReportCode AND b.Type=@Type AND b.Site=@Site AND b.Plant<>@Plant),0) AS Period11,
		ISNULL((SELECT SUM(ISNULL(M12,0)) FROM DistribitionReport_Amount_Fiscal b WHERE b.Year=a.Year AND b.ReportCode=@ReportCode AND b.Type=@Type AND b.Site=@Site AND b.Plant<>@Plant),0) AS Period12
	FROM DistributionReport_Fiscal_Year a
	--DELETE DistribitionReport_Amount_Fiscal WHERE ReportCode='555'
	INSERT INTO DistribitionReport_Amount_Fiscal
	SELECT *
	FROM #Temp a
	WHERE NOT EXISTS(SELECT * FROM DistribitionReport_Amount_Fiscal b WHERE b.ReportCode+b.Type+b.Site+b.Plant+b.Year=a.ReportCode+a.Type+a.Site+a.Plant+a.Year)
	UPDATE DistribitionReport_Amount_Fiscal
	SET M1=b.M1,M2=b.M2,M3=b.M3,M4=b.M4,M5=b.M5,M6=b.M6,M7=b.M7,M8=b.M8,M9=b.M9,M10=b.M10,M11=b.M11,M12=b.M12
	FROM DistribitionReport_Amount_Fiscal a,#Temp b
	WHERE a.ReportCode=b.ReportCode AND a.Type=b.Type 
		AND a.Site=b.Site
		AND a.Plant=b.Plant
		AND a.Year=b.Year

END
GO
