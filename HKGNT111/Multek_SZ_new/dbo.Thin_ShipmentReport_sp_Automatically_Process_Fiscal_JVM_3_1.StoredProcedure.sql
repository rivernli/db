USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[Thin_ShipmentReport_sp_Automatically_Process_Fiscal_JVM_3_1]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Thin_ShipmentReport_sp_Automatically_Process_Fiscal_JVM_3_1]
	-- Add the parameters for the stored procedure here
AS
BEGIN

	SET NOCOUNT ON 

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
	
	--TRUNCATE TABLE #Temp
	--INSERT INTO #Temp
	--SELECT '888' AS ReportCode,
	--	'Chi' AS Site,
	--	'' AS Plant,
	--	ShipmentYears AS Year,
	--	dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_JVM_3_1 (ShipmentYears,1,'Chi') AS Period1,
	--	dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_JVM_3_1 (ShipmentYears,2,'Chi') AS Period2,
	--	dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_JVM_3_1 (ShipmentYears,3,'Chi') AS Period3,
	--	dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_JVM_3_1 (ShipmentYears,4,'Chi') AS Period4,
	--	dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_JVM_3_1 (ShipmentYears,5,'Chi') AS Period5,
	--	dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_JVM_3_1 (ShipmentYears,6,'Chi') AS Period6,
	--	dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_JVM_3_1 (ShipmentYears,7,'Chi') AS Period7,
	--	dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_JVM_3_1 (ShipmentYears,8,'Chi') AS Period8,
	--	dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_JVM_3_1 (ShipmentYears,9,'Chi') AS Period9,
	--	dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_JVM_3_1 (ShipmentYears,10,'Chi') AS Period10,
	--	dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_JVM_3_1 (ShipmentYears,11,'Chi') AS Period11,
	--	dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_JVM_3_1 (ShipmentYears,12,'Chi') AS Period12
	--FROM ShipmentReport_Fiscal_Year
	
	----DELETE ShipmentReport_Shipped_All_Fixed_Fiscal WHERE ReportCode='888'
	--INSERT INTO ShipmentReport_Shipped_All_Fixed_Fiscal
	--SELECT *
	--FROM #Temp a
	--WHERE NOT EXISTS(SELECT * FROM ShipmentReport_Shipped_All_Fixed_Fiscal b WHERE b.ReportCode+b.Site+b.Plant+b.Year=a.ReportCode+a.Site+a.Plant+a.Year)
	--UPDATE ShipmentReport_Shipped_All_Fixed_Fiscal
	--SET M1=b.M1,M2=b.M2,M3=b.M3,M4=b.M4,M5=b.M5,M6=b.M6,M7=b.M7,M8=b.M8,M9=b.M9,M10=b.M10,M11=b.M11,M12=b.M12
	--FROM ShipmentReport_Shipped_All_Fixed_Fiscal a,#Temp b
	--WHERE a.ReportCode=b.ReportCode
	--	AND a.Site=b.Site
	--	AND a.Plant=b.Plant
	--	AND a.Year=b.Year

	----DELETE ShipmentReport_Shipped_All_Fixed_Fiscal WHERE ReportCode='887'
	--TRUNCATE TABLE #Temp
	--INSERT INTO #Temp
	--SELECT '887' AS ReportCode,
	--	'Chi' AS Site,
	--	'' AS Plant,
	--	ShipmentYears AS Year,
	--	dbo.ShipmentReport_fun_Get_Sum_Fiscal_Quarter_JVM_3_1 (ShipmentYears,1,'Chi') AS Period1,
	--	dbo.ShipmentReport_fun_Get_Sum_Fiscal_Quarter_JVM_3_1 (ShipmentYears,2,'Chi') AS Period2,
	--	dbo.ShipmentReport_fun_Get_Sum_Fiscal_Quarter_JVM_3_1 (ShipmentYears,3,'Chi') AS Period3,
	--	dbo.ShipmentReport_fun_Get_Sum_Fiscal_Quarter_JVM_3_1 (ShipmentYears,4,'Chi') AS Period4,
	--	0 AS Period5,0 AS Period6,0 AS Period7,0 AS Period8,0 AS Period9,0 AS Period10,0 AS Period11,0 AS Period12
	--FROM ShipmentReport_Fiscal_Year
	--INSERT INTO ShipmentReport_Shipped_All_Fixed_Fiscal
	--SELECT *
	--FROM #Temp a
	--WHERE NOT EXISTS(SELECT * FROM ShipmentReport_Shipped_All_Fixed_Fiscal b WHERE b.ReportCode+b.Site+b.Plant+b.Year=a.ReportCode+a.Site+a.Plant+a.Year)
	--UPDATE ShipmentReport_Shipped_All_Fixed_Fiscal
	--SET M1=b.M1,M2=b.M2,M3=b.M3,M4=b.M4,M5=b.M5,M6=b.M6,M7=b.M7,M8=b.M8,M9=b.M9,M10=b.M10,M11=b.M11,M12=b.M12
	--FROM ShipmentReport_Shipped_All_Fixed_Fiscal a,#Temp b
	--WHERE a.ReportCode=b.ReportCode
	--	AND a.Site=b.Site
	--	AND a.Plant=b.Plant
	--	AND a.Year=b.Year

	--UPDATE ShipmentReport_Shipped_All_Fixed_Fiscal
	--SET M1=0,M2=0,M3=0,M4=0,M5=0,M6=0,M7=0,M8=0,M9=0,M10=0,M11=0,M12=0
	--WHERE Site='Chi'
	--	AND ReportCode='999'
	--UPDATE ShipmentReport_Shipped_All_Fixed_Fiscal
	--SET M1=(SELECT a.M1 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Chi' AND a.ReportCode='888' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)-
	--	   (CASE WHEN (SELECT a.M1 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Chi' AND a.ReportCode='888' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)=0 THEN 0 ELSE 1 END)*
	--	   (SELECT a.M1 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Chi' AND a.ReportCode='002' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year),
	--	M2=(SELECT a.M2 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Chi' AND a.ReportCode='888' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)-
	--	   (CASE WHEN (SELECT a.M2 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Chi' AND a.ReportCode='888' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)=0 THEN 0 ELSE 1 END)*
	--	   (SELECT a.M2 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Chi' AND a.ReportCode='002' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year),
	--	M3=(SELECT a.M3 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Chi' AND a.ReportCode='888' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)-
	--	   (CASE WHEN (SELECT a.M3 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Chi' AND a.ReportCode='888' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)=0 THEN 0 ELSE 1 END)*
	--	   (SELECT a.M3 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Chi' AND a.ReportCode='002' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year),
	--	M4=(SELECT a.M4 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Chi' AND a.ReportCode='888' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)-
	--	   (CASE WHEN (SELECT a.M4 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Chi' AND a.ReportCode='888' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)=0 THEN 0 ELSE 1 END)*
	--	   (SELECT a.M4 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Chi' AND a.ReportCode='002' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year),
	--	M5=(SELECT a.M5 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Chi' AND a.ReportCode='888' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)-
	--	   (CASE WHEN (SELECT a.M5 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Chi' AND a.ReportCode='888' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)=0 THEN 0 ELSE 1 END)*
	--	   (SELECT a.M5 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Chi' AND a.ReportCode='002' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year),
	--	M6=(SELECT a.M6 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Chi' AND a.ReportCode='888' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)-
	--	   (CASE WHEN (SELECT a.M6 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Chi' AND a.ReportCode='888' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)=0 THEN 0 ELSE 1 END)*
	--	   (SELECT a.M6 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Chi' AND a.ReportCode='002' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year),
	--	M7=(SELECT a.M7 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Chi' AND a.ReportCode='888' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)-
	--	   (CASE WHEN (SELECT a.M7 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Chi' AND a.ReportCode='888' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)=0 THEN 0 ELSE 1 END)*
	--	   (SELECT a.M7 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Chi' AND a.ReportCode='002' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year),
	--	M8=(SELECT a.M8 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Chi' AND a.ReportCode='888' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)-
	--	   (CASE WHEN (SELECT a.M8 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Chi' AND a.ReportCode='888' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)=0 THEN 0 ELSE 1 END)*
	--	   (SELECT a.M8 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Chi' AND a.ReportCode='002' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year),
	--	M9=(SELECT a.M9 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Chi' AND a.ReportCode='888' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)-
	--	   (CASE WHEN (SELECT a.M9 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Chi' AND a.ReportCode='888' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)=0 THEN 0 ELSE 1 END)*
	--	   (SELECT a.M9 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Chi' AND a.ReportCode='002' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year),
	--	M10=(SELECT a.M10 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Chi' AND a.ReportCode='888' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)-
	--	   (CASE WHEN (SELECT a.M10 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Chi' AND a.ReportCode='888' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)=0 THEN 0 ELSE 1 END)*
	--	   (SELECT a.M10 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Chi' AND a.ReportCode='002' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year),
	--	M11=(SELECT a.M11 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Chi' AND a.ReportCode='888' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)-
	--	   (CASE WHEN (SELECT a.M11 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Chi' AND a.ReportCode='888' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)=0 THEN 0 ELSE 1 END)*
	--	   (SELECT a.M11 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Chi' AND a.ReportCode='002' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year),
	--	M12=(SELECT a.M12 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Chi' AND a.ReportCode='888' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)-
	--	   (CASE WHEN (SELECT a.M12 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Chi' AND a.ReportCode='888' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)=0 THEN 0 ELSE 1 END)*
	--	   (SELECT a.M12 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Chi' AND a.ReportCode='002' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)
	--WHERE Site='Chi'
	--	AND Plant='HK'
	--	AND ReportCode='999'
	--UPDATE ShipmentReport_Shipped_All_Fixed_Fiscal
	--SET M1=0,M2=0,M3=0,M4=0,M5=0,M6=0,M7=0,M8=0,M9=0,M10=0,M11=0,M12=0
	--WHERE Site='Chi'
	--	AND ReportCode='998'
	--UPDATE ShipmentReport_Shipped_All_Fixed_Fiscal
	--SET M1=(SELECT a.M1 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Chi' AND a.ReportCode='887' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)-
	--	   (CASE WHEN (SELECT a.M1 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Chi' AND a.ReportCode='887' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)=0 THEN 0 ELSE 1 END)*
	--	   (SELECT a.M1 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Chi' AND a.ReportCode='004' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year),
	--	M2=(SELECT a.M2 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Chi' AND a.ReportCode='887' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)-
	--	   (CASE WHEN (SELECT a.M2 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Chi' AND a.ReportCode='887' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)=0 THEN 0 ELSE 1 END)*
	--	   (SELECT a.M2 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Chi' AND a.ReportCode='004' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year),
	--	M3=(SELECT a.M3 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Chi' AND a.ReportCode='887' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)-
	--	   (CASE WHEN (SELECT a.M3 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Chi' AND a.ReportCode='887' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)=0 THEN 0 ELSE 1 END)*
	--	   (SELECT a.M3 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Chi' AND a.ReportCode='004' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year),
	--	M4=(SELECT a.M4 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Chi' AND a.ReportCode='887' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)-
	--	   (CASE WHEN (SELECT a.M4 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Chi' AND a.ReportCode='887' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)=0 THEN 0 ELSE 1 END)*
	--	   (SELECT a.M4 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Chi' AND a.ReportCode='004' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year),
	--	M5=0,M6=0,M7=0,M8=0,M9=0,M10=0,M11=0,M12=0
	--WHERE Site='Chi'
	--	AND Plant='HK'
	--	AND ReportCode='998'


	----DELETE ShipmentReport_Shipped_All_Fixed_Fiscal WHERE ReportCode='886'
	--TRUNCATE TABLE #Temp
	--INSERT INTO #Temp
	--SELECT '886' AS ReportCode,
	--	'Dis' AS Site,
	--	'' AS Plant,
	--	ShipmentYears AS Year,
	--	dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_JVM_Display_3_1 (ShipmentYears,1) AS Period1,
	--	dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_JVM_Display_3_1 (ShipmentYears,2) AS Period2,
	--	dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_JVM_Display_3_1 (ShipmentYears,3) AS Period3,
	--	dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_JVM_Display_3_1 (ShipmentYears,4) AS Period4,
	--	dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_JVM_Display_3_1 (ShipmentYears,5) AS Period5,
	--	dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_JVM_Display_3_1 (ShipmentYears,6) AS Period6,
	--	dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_JVM_Display_3_1 (ShipmentYears,7) AS Period7,
	--	dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_JVM_Display_3_1 (ShipmentYears,8) AS Period8,
	--	dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_JVM_Display_3_1 (ShipmentYears,9) AS Period9,
	--	dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_JVM_Display_3_1 (ShipmentYears,10) AS Period10,
	--	dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_JVM_Display_3_1 (ShipmentYears,11) AS Period11,
	--	dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_JVM_Display_3_1 (ShipmentYears,12) AS Period12
	--FROM ShipmentReport_Fiscal_Year
	--INSERT INTO ShipmentReport_Shipped_All_Fixed_Fiscal
	--SELECT *
	--FROM #Temp a
	--WHERE NOT EXISTS(SELECT * FROM ShipmentReport_Shipped_All_Fixed_Fiscal b WHERE b.ReportCode+b.Site+b.Plant+b.Year=a.ReportCode+a.Site+a.Plant+a.Year)
	--UPDATE ShipmentReport_Shipped_All_Fixed_Fiscal
	--SET M1=b.M1,M2=b.M2,M3=b.M3,M4=b.M4,M5=b.M5,M6=b.M6,M7=b.M7,M8=b.M8,M9=b.M9,M10=b.M10,M11=b.M11,M12=b.M12
	--FROM ShipmentReport_Shipped_All_Fixed_Fiscal a,#Temp b
	--WHERE a.ReportCode=b.ReportCode
	--	AND a.Site=b.Site
	--	AND a.Plant=b.Plant
	--	AND a.Year=b.Year

	----DELETE ShipmentReport_Shipped_All_Fixed_Fiscal WHERE ReportCode='885'
	--TRUNCATE TABLE #Temp
	--INSERT INTO #Temp
	--SELECT '885' AS ReportCode,
	--	'Dis' AS Site,
	--	'' AS Plant,
	--	ShipmentYears AS Year,
	--	dbo.ShipmentReport_fun_Get_Sum_Fiscal_Quarter_JVM_Display_3_1 (ShipmentYears,1) AS Period1,
	--	dbo.ShipmentReport_fun_Get_Sum_Fiscal_Quarter_JVM_Display_3_1 (ShipmentYears,2) AS Period2,
	--	dbo.ShipmentReport_fun_Get_Sum_Fiscal_Quarter_JVM_Display_3_1 (ShipmentYears,3) AS Period3,
	--	dbo.ShipmentReport_fun_Get_Sum_Fiscal_Quarter_JVM_Display_3_1 (ShipmentYears,4) AS Period4,
	--	0 AS Period5,0 AS Period6,0 AS Period7,0 AS Period8,0 AS Period9,0 AS Period10,0 AS Period11,0 AS Period12
	--FROM ShipmentReport_Fiscal_Year
	--INSERT INTO ShipmentReport_Shipped_All_Fixed_Fiscal
	--SELECT *
	--FROM #Temp a
	--WHERE NOT EXISTS(SELECT * FROM ShipmentReport_Shipped_All_Fixed_Fiscal b WHERE b.ReportCode+b.Site+b.Plant+b.Year=a.ReportCode+a.Site+a.Plant+a.Year)
	--UPDATE ShipmentReport_Shipped_All_Fixed_Fiscal
	--SET M1=b.M1,M2=b.M2,M3=b.M3,M4=b.M4,M5=b.M5,M6=b.M6,M7=b.M7,M8=b.M8,M9=b.M9,M10=b.M10,M11=b.M11,M12=b.M12
	--FROM ShipmentReport_Shipped_All_Fixed_Fiscal a,#Temp b
	--WHERE a.ReportCode=b.ReportCode
	--	AND a.Site=b.Site
	--	AND a.Plant=b.Plant
	--	AND a.Year=b.Year

	--UPDATE ShipmentReport_Shipped_All_Fixed_Fiscal
	--SET M1=0,M2=0,M3=0,M4=0,M5=0,M6=0,M7=0,M8=0,M9=0,M10=0,M11=0,M12=0
	--WHERE Site='Dis'
	--	AND ReportCode='997'
	--UPDATE ShipmentReport_Shipped_All_Fixed_Fiscal
	--SET M1=(SELECT a.M1 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Dis' AND a.ReportCode='886' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)-
	--	   (CASE WHEN (SELECT a.M1 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Dis' AND a.ReportCode='886' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)=0 THEN 0 ELSE 1 END)*
	--	   (SELECT a.M1 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Dis' AND a.ReportCode='002' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year),
	--	M2=(SELECT a.M2 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Dis' AND a.ReportCode='886' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)-
	--	   (CASE WHEN (SELECT a.M2 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Dis' AND a.ReportCode='886' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)=0 THEN 0 ELSE 1 END)*
	--	   (SELECT a.M2 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Dis' AND a.ReportCode='002' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year),
	--	M3=(SELECT a.M3 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Dis' AND a.ReportCode='886' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)-
	--	   (CASE WHEN (SELECT a.M3 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Dis' AND a.ReportCode='886' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)=0 THEN 0 ELSE 1 END)*
	--	   (SELECT a.M3 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Dis' AND a.ReportCode='002' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year),
	--	M4=(SELECT a.M4 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Dis' AND a.ReportCode='886' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)-
	--	   (CASE WHEN (SELECT a.M4 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Dis' AND a.ReportCode='886' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)=0 THEN 0 ELSE 1 END)*
	--	   (SELECT a.M4 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Dis' AND a.ReportCode='002' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year),
	--	M5=(SELECT a.M5 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Dis' AND a.ReportCode='886' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)-
	--	   (CASE WHEN (SELECT a.M5 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Dis' AND a.ReportCode='886' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)=0 THEN 0 ELSE 1 END)*
	--	   (SELECT a.M5 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Dis' AND a.ReportCode='002' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year),
	--	M6=(SELECT a.M6 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Dis' AND a.ReportCode='886' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)-
	--	   (CASE WHEN (SELECT a.M6 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Dis' AND a.ReportCode='886' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)=0 THEN 0 ELSE 1 END)*
	--	   (SELECT a.M6 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Dis' AND a.ReportCode='002' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year),
	--	M7=(SELECT a.M7 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Dis' AND a.ReportCode='886' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)-
	--	   (CASE WHEN (SELECT a.M7 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Dis' AND a.ReportCode='886' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)=0 THEN 0 ELSE 1 END)*
	--	   (SELECT a.M7 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Dis' AND a.ReportCode='002' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year),
	--	M8=(SELECT a.M8 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Dis' AND a.ReportCode='886' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)-
	--	   (CASE WHEN (SELECT a.M8 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Dis' AND a.ReportCode='886' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)=0 THEN 0 ELSE 1 END)*
	--	   (SELECT a.M8 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Dis' AND a.ReportCode='002' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year),
	--	M9=(SELECT a.M9 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Dis' AND a.ReportCode='886' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)-
	--	   (CASE WHEN (SELECT a.M9 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Dis' AND a.ReportCode='886' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)=0 THEN 0 ELSE 1 END)*
	--	   (SELECT a.M9 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Dis' AND a.ReportCode='002' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year),
	--	M10=(SELECT a.M10 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Dis' AND a.ReportCode='886' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)-
	--	   (CASE WHEN (SELECT a.M10 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Dis' AND a.ReportCode='886' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)=0 THEN 0 ELSE 1 END)*
	--	   (SELECT a.M10 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Dis' AND a.ReportCode='002' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year),
	--	M11=(SELECT a.M11 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Dis' AND a.ReportCode='886' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)-
	--	   (CASE WHEN (SELECT a.M11 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Dis' AND a.ReportCode='886' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)=0 THEN 0 ELSE 1 END)*
	--	   (SELECT a.M11 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Dis' AND a.ReportCode='002' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year),
	--	M12=(SELECT a.M12 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Dis' AND a.ReportCode='886' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)-
	--	   (CASE WHEN (SELECT a.M12 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Dis' AND a.ReportCode='886' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)=0 THEN 0 ELSE 1 END)*
	--	   (SELECT a.M12 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Dis' AND a.ReportCode='002' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)
	--WHERE Site='Dis'
	--	AND ReportCode='997'
	--UPDATE ShipmentReport_Shipped_All_Fixed_Fiscal
	--SET M1=0,M2=0,M3=0,M4=0,M5=0,M6=0,M7=0,M8=0,M9=0,M10=0,M11=0,M12=0
	--WHERE Site='Dis'
	--	AND ReportCode='996'
	--UPDATE ShipmentReport_Shipped_All_Fixed_Fiscal
	--SET M1=(SELECT a.M1 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Dis' AND a.ReportCode='885' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)-
	--	   (CASE WHEN (SELECT a.M1 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Dis' AND a.ReportCode='885' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)=0 THEN 0 ELSE 1 END)*
	--	   (SELECT a.M1 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Dis' AND a.ReportCode='004' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year),
	--	M2=(SELECT a.M2 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Dis' AND a.ReportCode='885' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)-
	--	   (CASE WHEN (SELECT a.M2 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Dis' AND a.ReportCode='885' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)=0 THEN 0 ELSE 1 END)*
	--	   (SELECT a.M2 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Dis' AND a.ReportCode='004' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year),
	--	M3=(SELECT a.M3 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Dis' AND a.ReportCode='885' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)-
	--	   (CASE WHEN (SELECT a.M3 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Dis' AND a.ReportCode='885' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)=0 THEN 0 ELSE 1 END)*
	--	   (SELECT a.M3 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Dis' AND a.ReportCode='004' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year),
	--	M4=(SELECT a.M4 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Dis' AND a.ReportCode='885' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)-
	--	   (CASE WHEN (SELECT a.M4 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Dis' AND a.ReportCode='885' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)=0 THEN 0 ELSE 1 END)*
	--	   (SELECT a.M4 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Dis' AND a.ReportCode='004' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year),
	--	M5=0,M6=0,M7=0,M8=0,M9=0,M10=0,M11=0,M12=0
	--WHERE Site='Dis'
	--	AND ReportCode='996'

	----DELETE ShipmentReport_Shipped_All_Fixed_Fiscal WHERE ReportCode='884'
	--TRUNCATE TABLE #Temp
	--INSERT INTO #Temp
	--SELECT '884' AS ReportCode,
	--	'Ger' AS Site,
	--	'' AS Plant,
	--	ShipmentYears AS Year,
	--	dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_JVM_Germany_3_1 (ShipmentYears,1) AS Period1,
	--	dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_JVM_Germany_3_1 (ShipmentYears,2) AS Period2,
	--	dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_JVM_Germany_3_1 (ShipmentYears,3) AS Period3,
	--	dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_JVM_Germany_3_1 (ShipmentYears,4) AS Period4,
	--	dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_JVM_Germany_3_1 (ShipmentYears,5) AS Period5,
	--	dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_JVM_Germany_3_1 (ShipmentYears,6) AS Period6,
	--	dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_JVM_Germany_3_1 (ShipmentYears,7) AS Period7,
	--	dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_JVM_Germany_3_1 (ShipmentYears,8) AS Period8,
	--	dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_JVM_Germany_3_1 (ShipmentYears,9) AS Period9,
	--	dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_JVM_Germany_3_1 (ShipmentYears,10) AS Period10,
	--	dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_JVM_Germany_3_1 (ShipmentYears,11) AS Period11,
	--	dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_JVM_Germany_3_1 (ShipmentYears,12) AS Period12
	--FROM ShipmentReport_Fiscal_Year
	--INSERT INTO ShipmentReport_Shipped_All_Fixed_Fiscal
	--SELECT *
	--FROM #Temp a
	--WHERE NOT EXISTS(SELECT * FROM ShipmentReport_Shipped_All_Fixed_Fiscal b WHERE b.ReportCode+b.Site+b.Plant+b.Year=a.ReportCode+a.Site+a.Plant+a.Year)
	--UPDATE ShipmentReport_Shipped_All_Fixed_Fiscal
	--SET M1=b.M1,M2=b.M2,M3=b.M3,M4=b.M4,M5=b.M5,M6=b.M6,M7=b.M7,M8=b.M8,M9=b.M9,M10=b.M10,M11=b.M11,M12=b.M12
	--FROM ShipmentReport_Shipped_All_Fixed_Fiscal a,#Temp b
	--WHERE a.ReportCode=b.ReportCode
	--	AND a.Site=b.Site
	--	AND a.Plant=b.Plant
	--	AND a.Year=b.Year

	----DELETE ShipmentReport_Shipped_All_Fixed_Fiscal WHERE ReportCode='883'
	--TRUNCATE TABLE #Temp
	--INSERT INTO #Temp
	--SELECT '883' AS ReportCode,
	--	'Ger' AS Site,
	--	'' AS Plant,
	--	ShipmentYears AS Year,
	--	dbo.ShipmentReport_fun_Get_Sum_Fiscal_Quarter_JVM_Germany_3_1 (ShipmentYears,1) AS Period1,
	--	dbo.ShipmentReport_fun_Get_Sum_Fiscal_Quarter_JVM_Germany_3_1 (ShipmentYears,2) AS Period2,
	--	dbo.ShipmentReport_fun_Get_Sum_Fiscal_Quarter_JVM_Germany_3_1 (ShipmentYears,3) AS Period3,
	--	dbo.ShipmentReport_fun_Get_Sum_Fiscal_Quarter_JVM_Germany_3_1 (ShipmentYears,4) AS Period4,
	--	0 AS Period5,0 AS Period6,0 AS Period7,0 AS Period8,0 AS Period9,0 AS Period10,0 AS Period11,0 AS Period12
	--FROM ShipmentReport_Fiscal_Year
	--INSERT INTO ShipmentReport_Shipped_All_Fixed_Fiscal
	--SELECT *
	--FROM #Temp a
	--WHERE NOT EXISTS(SELECT * FROM ShipmentReport_Shipped_All_Fixed_Fiscal b WHERE b.ReportCode+b.Site+b.Plant+b.Year=a.ReportCode+a.Site+a.Plant+a.Year)
	--UPDATE ShipmentReport_Shipped_All_Fixed_Fiscal
	--SET M1=b.M1,M2=b.M2,M3=b.M3,M4=b.M4,M5=b.M5,M6=b.M6,M7=b.M7,M8=b.M8,M9=b.M9,M10=b.M10,M11=b.M11,M12=b.M12
	--FROM ShipmentReport_Shipped_All_Fixed_Fiscal a,#Temp b
	--WHERE a.ReportCode=b.ReportCode
	--	AND a.Site=b.Site
	--	AND a.Plant=b.Plant
	--	AND a.Year=b.Year

	--UPDATE ShipmentReport_Shipped_All_Fixed_Fiscal
	--SET M1=0,M2=0,M3=0,M4=0,M5=0,M6=0,M7=0,M8=0,M9=0,M10=0,M11=0,M12=0
	--WHERE Site='Ger'
	--	AND ReportCode='995'
	--UPDATE ShipmentReport_Shipped_All_Fixed_Fiscal
	--SET M1=(SELECT a.M1 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Ger' AND a.ReportCode='884' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)-
	--	   (CASE WHEN (SELECT a.M1 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Ger' AND a.ReportCode='884' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)=0 THEN 0 ELSE 1 END)*
	--	   (SELECT a.M1 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Ger' AND a.ReportCode='002' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year),
	--	M2=(SELECT a.M2 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Ger' AND a.ReportCode='884' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)-
	--	   (CASE WHEN (SELECT a.M2 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Ger' AND a.ReportCode='884' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)=0 THEN 0 ELSE 1 END)*
	--	   (SELECT a.M2 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Ger' AND a.ReportCode='002' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year),
	--	M3=(SELECT a.M3 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Ger' AND a.ReportCode='884' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)-
	--	   (CASE WHEN (SELECT a.M3 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Ger' AND a.ReportCode='884' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)=0 THEN 0 ELSE 1 END)*
	--	   (SELECT a.M3 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Ger' AND a.ReportCode='002' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year),
	--	M4=(SELECT a.M4 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Ger' AND a.ReportCode='884' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)-
	--	   (CASE WHEN (SELECT a.M4 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Ger' AND a.ReportCode='884' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)=0 THEN 0 ELSE 1 END)*
	--	   (SELECT a.M4 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Ger' AND a.ReportCode='002' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year),
	--	M5=(SELECT a.M5 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Ger' AND a.ReportCode='884' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)-
	--	   (CASE WHEN (SELECT a.M5 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Ger' AND a.ReportCode='884' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)=0 THEN 0 ELSE 1 END)*
	--	   (SELECT a.M5 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Ger' AND a.ReportCode='002' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year),
	--	M6=(SELECT a.M6 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Ger' AND a.ReportCode='884' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)-
	--	   (CASE WHEN (SELECT a.M6 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Ger' AND a.ReportCode='884' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)=0 THEN 0 ELSE 1 END)*
	--	   (SELECT a.M6 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Ger' AND a.ReportCode='002' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year),
	--	M7=(SELECT a.M7 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Ger' AND a.ReportCode='884' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)-
	--	   (CASE WHEN (SELECT a.M7 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Ger' AND a.ReportCode='884' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)=0 THEN 0 ELSE 1 END)*
	--	   (SELECT a.M7 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Ger' AND a.ReportCode='002' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year),
	--	M8=(SELECT a.M8 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Ger' AND a.ReportCode='884' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)-
	--	   (CASE WHEN (SELECT a.M8 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Ger' AND a.ReportCode='884' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)=0 THEN 0 ELSE 1 END)*
	--	   (SELECT a.M8 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Ger' AND a.ReportCode='002' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year),
	--	M9=(SELECT a.M9 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Ger' AND a.ReportCode='884' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)-
	--	   (CASE WHEN (SELECT a.M9 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Ger' AND a.ReportCode='884' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)=0 THEN 0 ELSE 1 END)*
	--	   (SELECT a.M9 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Ger' AND a.ReportCode='002' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year),
	--	M10=(SELECT a.M10 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Ger' AND a.ReportCode='884' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)-
	--	   (CASE WHEN (SELECT a.M10 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Ger' AND a.ReportCode='884' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)=0 THEN 0 ELSE 1 END)*
	--	   (SELECT a.M10 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Ger' AND a.ReportCode='002' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year),
	--	M11=(SELECT a.M11 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Ger' AND a.ReportCode='884' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)-
	--	   (CASE WHEN (SELECT a.M11 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Ger' AND a.ReportCode='884' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)=0 THEN 0 ELSE 1 END)*
	--	   (SELECT a.M11 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Ger' AND a.ReportCode='002' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year),
	--	M12=(SELECT a.M12 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Ger' AND a.ReportCode='884' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)-
	--	   (CASE WHEN (SELECT a.M12 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Ger' AND a.ReportCode='884' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)=0 THEN 0 ELSE 1 END)*
	--	   (SELECT a.M12 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Ger' AND a.ReportCode='002' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)
	--WHERE Site='Ger'
	--	AND ReportCode='995'
	--UPDATE ShipmentReport_Shipped_All_Fixed_Fiscal
	--SET M1=0,M2=0,M3=0,M4=0,M5=0,M6=0,M7=0,M8=0,M9=0,M10=0,M11=0,M12=0
	--WHERE Site='Ger'
	--	AND ReportCode='994'
	--UPDATE ShipmentReport_Shipped_All_Fixed_Fiscal
	--SET M1=(SELECT a.M1 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Ger' AND a.ReportCode='883' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)-
	--	   (CASE WHEN (SELECT a.M1 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Ger' AND a.ReportCode='883' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)=0 THEN 0 ELSE 1 END)*
	--	   (SELECT a.M1 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Ger' AND a.ReportCode='004' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year),
	--	M2=(SELECT a.M2 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Ger' AND a.ReportCode='883' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)-
	--	   (CASE WHEN (SELECT a.M2 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Ger' AND a.ReportCode='883' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)=0 THEN 0 ELSE 1 END)*
	--	   (SELECT a.M2 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Ger' AND a.ReportCode='004' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year),
	--	M3=(SELECT a.M3 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Ger' AND a.ReportCode='883' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)-
	--	   (CASE WHEN (SELECT a.M3 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Ger' AND a.ReportCode='883' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)=0 THEN 0 ELSE 1 END)*
	--	   (SELECT a.M3 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Ger' AND a.ReportCode='004' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year),
	--	M4=(SELECT a.M4 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Ger' AND a.ReportCode='883' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)-
	--	   (CASE WHEN (SELECT a.M4 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Ger' AND a.ReportCode='883' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)=0 THEN 0 ELSE 1 END)*
	--	   (SELECT a.M4 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Ger' AND a.ReportCode='004' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year),
	--	M5=0,M6=0,M7=0,M8=0,M9=0,M10=0,M11=0,M12=0
	--WHERE Site='Ger'
	--	AND ReportCode='994'

	--DELETE ShipmentReport_Shipped_All_Fixed_Fiscal WHERE ReportCode='882'
	TRUNCATE TABLE #Temp
	INSERT INTO #Temp
	SELECT '882' AS ReportCode,
		'Sao' AS Site,
		'' AS Plant,
		ShipmentYears AS Year,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_JVM_Brazil_3_1 (ShipmentYears,1) AS Period1,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_JVM_Brazil_3_1 (ShipmentYears,2) AS Period2,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_JVM_Brazil_3_1 (ShipmentYears,3) AS Period3,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_JVM_Brazil_3_1 (ShipmentYears,4) AS Period4,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_JVM_Brazil_3_1 (ShipmentYears,5) AS Period5,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_JVM_Brazil_3_1 (ShipmentYears,6) AS Period6,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_JVM_Brazil_3_1 (ShipmentYears,7) AS Period7,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_JVM_Brazil_3_1 (ShipmentYears,8) AS Period8,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_JVM_Brazil_3_1 (ShipmentYears,9) AS Period9,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_JVM_Brazil_3_1 (ShipmentYears,10) AS Period10,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_JVM_Brazil_3_1 (ShipmentYears,11) AS Period11,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Period_JVM_Brazil_3_1 (ShipmentYears,12) AS Period12
	FROM ShipmentReport_Fiscal_Year
	INSERT INTO ShipmentReport_Shipped_All_Fixed_Fiscal
	SELECT *
	FROM #Temp a
	WHERE NOT EXISTS(SELECT * FROM ShipmentReport_Shipped_All_Fixed_Fiscal b WHERE b.ReportCode+b.Site+b.Plant+b.Year=a.ReportCode+a.Site+a.Plant+a.Year)
	UPDATE ShipmentReport_Shipped_All_Fixed_Fiscal
	SET M1=b.M1,M2=b.M2,M3=b.M3,M4=b.M4,M5=b.M5,M6=b.M6,M7=b.M7,M8=b.M8,M9=b.M9,M10=b.M10,M11=b.M11,M12=b.M12
	FROM ShipmentReport_Shipped_All_Fixed_Fiscal a,#Temp b
	WHERE a.ReportCode=b.ReportCode
		AND a.Site=b.Site
		AND a.Plant=b.Plant
		AND a.Year=b.Year

	--DELETE ShipmentReport_Shipped_All_Fixed_Fiscal WHERE ReportCode='881'
	TRUNCATE TABLE #Temp
	INSERT INTO #Temp
	SELECT '881' AS ReportCode,
		'Sao' AS Site,
		'' AS Plant,
		ShipmentYears AS Year,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Quarter_JVM_Brazil_3_1 (ShipmentYears,1) AS Period1,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Quarter_JVM_Brazil_3_1 (ShipmentYears,2) AS Period2,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Quarter_JVM_Brazil_3_1 (ShipmentYears,3) AS Period3,
		dbo.ShipmentReport_fun_Get_Sum_Fiscal_Quarter_JVM_Brazil_3_1 (ShipmentYears,4) AS Period4,
		0 AS Period5,0 AS Period6,0 AS Period7,0 AS Period8,0 AS Period9,0 AS Period10,0 AS Period11,0 AS Period12
	FROM ShipmentReport_Fiscal_Year
	INSERT INTO ShipmentReport_Shipped_All_Fixed_Fiscal
	SELECT *
	FROM #Temp a
	WHERE NOT EXISTS(SELECT * FROM ShipmentReport_Shipped_All_Fixed_Fiscal b WHERE b.ReportCode+b.Site+b.Plant+b.Year=a.ReportCode+a.Site+a.Plant+a.Year)
	UPDATE ShipmentReport_Shipped_All_Fixed_Fiscal
	SET M1=b.M1,M2=b.M2,M3=b.M3,M4=b.M4,M5=b.M5,M6=b.M6,M7=b.M7,M8=b.M8,M9=b.M9,M10=b.M10,M11=b.M11,M12=b.M12
	FROM ShipmentReport_Shipped_All_Fixed_Fiscal a,#Temp b
	WHERE a.ReportCode=b.ReportCode
		AND a.Site=b.Site
		AND a.Plant=b.Plant
		AND a.Year=b.Year

	UPDATE ShipmentReport_Shipped_All_Fixed_Fiscal
	SET M1=0,M2=0,M3=0,M4=0,M5=0,M6=0,M7=0,M8=0,M9=0,M10=0,M11=0,M12=0
	WHERE Site='Sao'
		AND ReportCode='993'
	UPDATE ShipmentReport_Shipped_All_Fixed_Fiscal
	SET M1=(SELECT a.M1 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Sao' AND a.ReportCode='882' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)-
		   (CASE WHEN (SELECT a.M1 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Sao' AND a.ReportCode='882' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)=0 THEN 0 ELSE 1 END)*
		   (SELECT a.M1 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Sao' AND a.ReportCode='002' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year),
		M2=(SELECT a.M2 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Sao' AND a.ReportCode='882' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)-
		   (CASE WHEN (SELECT a.M2 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Sao' AND a.ReportCode='882' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)=0 THEN 0 ELSE 1 END)*
		   (SELECT a.M2 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Sao' AND a.ReportCode='002' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year),
		M3=(SELECT a.M3 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Sao' AND a.ReportCode='882' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)-
		   (CASE WHEN (SELECT a.M3 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Sao' AND a.ReportCode='882' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)=0 THEN 0 ELSE 1 END)*
		   (SELECT a.M3 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Sao' AND a.ReportCode='002' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year),
		M4=(SELECT a.M4 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Sao' AND a.ReportCode='882' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)-
		   (CASE WHEN (SELECT a.M4 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Sao' AND a.ReportCode='882' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)=0 THEN 0 ELSE 1 END)*
		   (SELECT a.M4 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Sao' AND a.ReportCode='002' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year),
		M5=(SELECT a.M5 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Sao' AND a.ReportCode='882' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)-
		   (CASE WHEN (SELECT a.M5 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Sao' AND a.ReportCode='882' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)=0 THEN 0 ELSE 1 END)*
		   (SELECT a.M5 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Sao' AND a.ReportCode='002' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year),
		M6=(SELECT a.M6 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Sao' AND a.ReportCode='882' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)-
		   (CASE WHEN (SELECT a.M6 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Sao' AND a.ReportCode='882' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)=0 THEN 0 ELSE 1 END)*
		   (SELECT a.M6 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Sao' AND a.ReportCode='002' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year),
		M7=(SELECT a.M7 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Sao' AND a.ReportCode='882' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)-
		   (CASE WHEN (SELECT a.M7 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Sao' AND a.ReportCode='882' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)=0 THEN 0 ELSE 1 END)*
		   (SELECT a.M7 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Sao' AND a.ReportCode='002' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year),
		M8=(SELECT a.M8 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Sao' AND a.ReportCode='882' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)-
		   (CASE WHEN (SELECT a.M8 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Sao' AND a.ReportCode='882' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)=0 THEN 0 ELSE 1 END)*
		   (SELECT a.M8 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Sao' AND a.ReportCode='002' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year),
		M9=(SELECT a.M9 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Sao' AND a.ReportCode='882' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)-
		   (CASE WHEN (SELECT a.M9 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Sao' AND a.ReportCode='882' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)=0 THEN 0 ELSE 1 END)*
		   (SELECT a.M9 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Sao' AND a.ReportCode='002' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year),
		M10=(SELECT a.M10 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Sao' AND a.ReportCode='882' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)-
		   (CASE WHEN (SELECT a.M10 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Sao' AND a.ReportCode='882' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)=0 THEN 0 ELSE 1 END)*
		   (SELECT a.M10 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Sao' AND a.ReportCode='002' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year),
		M11=(SELECT a.M11 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Sao' AND a.ReportCode='882' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)-
		   (CASE WHEN (SELECT a.M11 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Sao' AND a.ReportCode='882' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)=0 THEN 0 ELSE 1 END)*
		   (SELECT a.M11 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Sao' AND a.ReportCode='002' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year),
		M12=(SELECT a.M12 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Sao' AND a.ReportCode='882' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)-
		   (CASE WHEN (SELECT a.M12 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Sao' AND a.ReportCode='882' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)=0 THEN 0 ELSE 1 END)*
		   (SELECT a.M12 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Sao' AND a.ReportCode='002' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)
	WHERE Site='Sao'
		AND ReportCode='993'
	UPDATE ShipmentReport_Shipped_All_Fixed_Fiscal
	SET M1=0,M2=0,M3=0,M4=0,M5=0,M6=0,M7=0,M8=0,M9=0,M10=0,M11=0,M12=0
	WHERE Site='Sao'
		AND ReportCode='992'
	UPDATE ShipmentReport_Shipped_All_Fixed_Fiscal
	SET M1=(SELECT a.M1 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Sao' AND a.ReportCode='881' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)-
		   (CASE WHEN (SELECT a.M1 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Sao' AND a.ReportCode='881' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)=0 THEN 0 ELSE 1 END)*
		   (SELECT a.M1 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Sao' AND a.ReportCode='004' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year),
		M2=(SELECT a.M2 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Sao' AND a.ReportCode='881' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)-
		   (CASE WHEN (SELECT a.M2 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Sao' AND a.ReportCode='881' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)=0 THEN 0 ELSE 1 END)*
		   (SELECT a.M2 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Sao' AND a.ReportCode='004' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year),
		M3=(SELECT a.M3 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Sao' AND a.ReportCode='881' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)-
		   (CASE WHEN (SELECT a.M3 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Sao' AND a.ReportCode='881' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)=0 THEN 0 ELSE 1 END)*
		   (SELECT a.M3 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Sao' AND a.ReportCode='004' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year),
		M4=(SELECT a.M4 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Sao' AND a.ReportCode='881' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)-
		   (CASE WHEN (SELECT a.M4 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Sao' AND a.ReportCode='881' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year)=0 THEN 0 ELSE 1 END)*
		   (SELECT a.M4 FROM ShipmentReport_Shipped_All_Fixed_Fiscal a WHERE a.Site='Sao' AND a.ReportCode='004' AND a.Year=ShipmentReport_Shipped_All_Fixed_Fiscal.Year),
		M5=0,M6=0,M7=0,M8=0,M9=0,M10=0,M11=0,M12=0
	WHERE Site='Sao'
		AND ReportCode='992'

END
GO
