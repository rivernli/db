USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[Thin_ShipmentReport_sp_Automatically_Process_TOP_20_Customer_Detail]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Thin_ShipmentReport_sp_Automatically_Process_TOP_20_Customer_Detail]
	-- Add the parameters for the stored procedure here
	@CalculateYear INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    DECLARE @Year CHAR(4),@i INT,@j INT,@k INT,@SQLString VARCHAR(MAX),@Color VARCHAR(50),@DateFrom DATETIME,@DateTo DATETIME ,@NowMonth INT,
			@Amount BIGINT,@Site VARCHAR(50),@SiteDesc VARCHAR(50),@Plant VARCHAR(50),@PlantDesc VARCHAR(50),@Lay INT,@Customer VARCHAR(500),@OEM VARCHAR(500),@ReportCode CHAR(3),@SumCustomer VARCHAR(MAX),@SumOEM VARCHAR(MAX)
	DECLARE @DateFrom1 DATETIME,@DateTo1 DATETIME, @DateFrom2 DATETIME,@DateTo2 DATETIME, @DateFrom3 DATETIME,@DateTo3 DATETIME, @DateFrom4 DATETIME,@DateTo4 DATETIME, @DateFrom5 DATETIME,@DateTo5 DATETIME, @DateFrom6 DATETIME,@DateTo6 DATETIME, 
			@DateFrom7 DATETIME,@DateTo7 DATETIME, @DateFrom8 DATETIME,@DateTo8 DATETIME, @DateFrom9 DATETIME,@DateTo9 DATETIME, @DateFrom10 DATETIME,@DateTo10 DATETIME, @DateFrom11 DATETIME,@DateTo11 DATETIME, @DateFrom12 DATETIME,@DateTo12 DATETIME
	DECLARE @FDateFrom1 DATETIME,@FDateTo1 DATETIME, @FDateFrom2 DATETIME,@FDateTo2 DATETIME, @FDateFrom3 DATETIME,@FDateTo3 DATETIME, @FDateFrom4 DATETIME,@FDateTo4 DATETIME, @FDateFrom5 DATETIME,@FDateTo5 DATETIME, @FDateFrom6 DATETIME,@FDateTo6 DATETIME, 
			@FDateFrom7 DATETIME,@FDateTo7 DATETIME, @FDateFrom8 DATETIME,@FDateTo8 DATETIME, @FDateFrom9 DATETIME,@FDateTo9 DATETIME, @FDateFrom10 DATETIME,@FDateTo10 DATETIME, @FDateFrom11 DATETIME,@FDateTo11 DATETIME, @FDateFrom12 DATETIME,@FDateTo12 DATETIME
	DECLARE @OEMCustomer VARCHAR(20)
	CREATE TABLE #Temp (OEMCustomer VARCHAR(300),ReportCode VARCHAR(3),Site VARCHAR(50),Plant VARCHAR(50),Year VARCHAR(4),M1 BIGINT,M2 BIGINT,M3 BIGINT,M4 BIGINT,M5 BIGINT,M6 BIGINT,M7 BIGINT,M8 BIGINT,M9 BIGINT,M10 BIGINT,M11 BIGINT,M12 BIGINT)
	CREATE NONCLUSTERED INDEX [TempOEMCustomerReportCodeSSitePlantYear] ON [#Temp] 
	(
		[OEMCustomer] ASC,[ReportCode] ASC,[Site] ASC,[Plant] ASC,[Year] ASC
	)

	SET @SQLString=''
	SET @i=1
	WHILE @i<=@CalculateYear
		BEGIN

			SET @Year=(SELECT MAX(ShipmentYears) FROM dbo.ShipmentReport_Fiscal_Year) -(@i-1) --CONVERT(CHAR(4),DATEADD(YEAR,-@i+1,GETDATE()-1),120)
			SET @DateFrom1=@Year+'-01-01'
			SET @DateTo1=DATEADD(MONTH,1,@DateFrom1)-1
			SET @DateFrom2=@Year+'-02-01'
			SET @DateTo2=DATEADD(MONTH,1,@DateFrom2)-1
			SET @DateFrom3=@Year+'-03-01'
			SET @DateTo3=DATEADD(MONTH,1,@DateFrom3)-1
			SET @DateFrom4=@Year+'-04-01'
			SET @DateTo4=DATEADD(MONTH,1,@DateFrom4)-1
			SET @DateFrom5=@Year+'-05-01'
			SET @DateTo5=DATEADD(MONTH,1,@DateFrom5)-1
			SET @DateFrom6=@Year+'-06-01'
			SET @DateTo6=DATEADD(MONTH,1,@DateFrom6)-1
			SET @DateFrom7=@Year+'-07-01'
			SET @DateTo7=DATEADD(MONTH,1,@DateFrom7)-1
			SET @DateFrom8=@Year+'-08-01'
			SET @DateTo8=DATEADD(MONTH,1,@DateFrom8)-1
			SET @DateFrom9=@Year+'-09-01'
			SET @DateTo9=DATEADD(MONTH,1,@DateFrom9)-1
			SET @DateFrom10=@Year+'-10-01'
			SET @DateTo10=DATEADD(MONTH,1,@DateFrom10)-1
			SET @DateFrom11=@Year+'-11-01'
			SET @DateTo11=DATEADD(MONTH,1,@DateFrom11)-1
			SET @DateFrom12=@Year+'-12-01'
			SET @DateTo12=DATEADD(MONTH,1,@DateFrom12)-1						
			
			SET @FDateFrom1=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=1) 
			SET @FDateTo1=(SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=1) 
			SET @FDateFrom2=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=2) 
			SET @FDateTo2=(SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=2) 
			SET @FDateFrom3=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=3) 
			SET @FDateTo3=(SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=3) 
			SET @FDateFrom4=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=4) 
			SET @FDateTo4=(SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=4) 
			SET @FDateFrom5=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=5) 
			SET @FDateTo5=(SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=5) 
			SET @FDateFrom6=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=6) 
			SET @FDateTo6=(SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=6) 
			SET @FDateFrom7=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=7) 
			SET @FDateTo7=(SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=7) 
			SET @FDateFrom8=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=8) 
			SET @FDateTo8=(SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=8) 
			SET @FDateFrom9=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=9) 
			SET @FDateTo9=(SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=9) 
			SET @FDateFrom10=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=10) 
			SET @FDateTo10=(SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=10) 
			SET @FDateFrom11=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=11) 
			SET @FDateTo11=(SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=11) 
			SET @FDateFrom12=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=12) 
			SET @FDateTo12=(SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=12) 
			-------------------------------------
			SET @OEMCustomer='Customer'
			SET @ReportCode='999'
			--SET @Site='Chi'
			--SET @Plant=''
			--SET @SiteDesc ='China'
			--SET @PlantDesc=''
			--TRUNCATE TABLE #Temp
			--INSERT INTO #Temp
			--SELECT Customer,@ReportCode AS ReportCode,@SiteDesc AS Site,@PlantDesc AS Plant,Year,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom1,@DateTo1) AS M1,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom2,@DateTo2) AS M2,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom3,@DateTo3) AS M3,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom4,@DateTo4) AS M4,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom5,@DateTo5) AS M5,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom6,@DateTo6) AS M6,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom7,@DateTo7) AS M7,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom8,@DateTo8) AS M8,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom9,@DateTo9) AS M9,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom10,@DateTo10) AS M10,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom11,@DateTo11) AS M11,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom12,@DateTo12) AS M12
			--FROM ShipmentReport_Shipped_All_Fixed_Top_20_Customer 
			--WHERE Year = @Year
			--INSERT INTO ShipmentReport_Shipped_All_Fixed_Customer_OEM
			--SELECT a.*
			--FROM #Temp a
			--WHERE NOT EXISTS(SELECT b.* FROM ShipmentReport_Shipped_All_Fixed_Customer_OEM b WHERE a.OEMCustomer+a.ReportCode+a.Site+a.Plant+a.Year=b.OEMCustomer+b.ReportCode+b.Site+b.Plant+b.Year)
			--UPDATE ShipmentReport_Shipped_All_Fixed_Customer_OEM
			--SET M1=b.M1,M2=b.M2,M3=b.M3,M4=b.M4,M5=b.M5,M6=b.M6,M7=b.M7,M8=b.M8,M9=b.M9,M10=b.M10,M11=b.M11,M12=b.M12
			--FROM ShipmentReport_Shipped_All_Fixed_Customer_OEM a,#Temp b
			--WHERE a.OEMCustomer=b.OEMCustomer
			--	AND a.ReportCode=b.ReportCode
			--	AND a.Site=b.Site
			--	AND a.Plant=b.Plant
			--	AND a.Year=b.Year
			
			--SET @Site='Dis'
			--SET @Plant=''
			--SET @SiteDesc ='Display'
			--SET @PlantDesc=''
			--TRUNCATE TABLE #Temp
			--INSERT INTO #Temp
			--SELECT Customer,@ReportCode AS ReportCode,@SiteDesc AS Site,@PlantDesc AS Plant,Year,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom1,@DateTo1) AS M1,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom2,@DateTo2) AS M2,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom3,@DateTo3) AS M3,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom4,@DateTo4) AS M4,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom5,@DateTo5) AS M5,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom6,@DateTo6) AS M6,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom7,@DateTo7) AS M7,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom8,@DateTo8) AS M8,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom9,@DateTo9) AS M9,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom10,@DateTo10) AS M10,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom11,@DateTo11) AS M11,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom12,@DateTo12) AS M12
			--FROM ShipmentReport_Shipped_All_Fixed_Top_20_Customer 
			--WHERE Year = @Year
			--INSERT INTO ShipmentReport_Shipped_All_Fixed_Customer_OEM
			--SELECT a.*
			--FROM #Temp a
			--WHERE NOT EXISTS(SELECT b.* FROM ShipmentReport_Shipped_All_Fixed_Customer_OEM b WHERE a.OEMCustomer+a.ReportCode+a.Site+a.Plant+a.Year=b.OEMCustomer+b.ReportCode+b.Site+b.Plant+b.Year)
			--UPDATE ShipmentReport_Shipped_All_Fixed_Customer_OEM
			--SET M1=b.M1,M2=b.M2,M3=b.M3,M4=b.M4,M5=b.M5,M6=b.M6,M7=b.M7,M8=b.M8,M9=b.M9,M10=b.M10,M11=b.M11,M12=b.M12
			--FROM ShipmentReport_Shipped_All_Fixed_Customer_OEM a,#Temp b
			--WHERE a.OEMCustomer=b.OEMCustomer
			--	AND a.ReportCode=b.ReportCode
			--	AND a.Site=b.Site
			--	AND a.Plant=b.Plant
			--	AND a.Year=b.Year

			--SET @Site='Ger'
			--SET @Plant=''
			--SET @SiteDesc ='Germany'
			--SET @PlantDesc=''
			--TRUNCATE TABLE #Temp
			--INSERT INTO #Temp
			--SELECT Customer,@ReportCode AS ReportCode,@SiteDesc AS Site,@PlantDesc AS Plant,Year,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom1,@DateTo1) AS M1,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom2,@DateTo2) AS M2,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom3,@DateTo3) AS M3,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom4,@DateTo4) AS M4,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom5,@DateTo5) AS M5,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom6,@DateTo6) AS M6,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom7,@DateTo7) AS M7,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom8,@DateTo8) AS M8,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom9,@DateTo9) AS M9,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom10,@DateTo10) AS M10,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom11,@DateTo11) AS M11,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom12,@DateTo12) AS M12
			--FROM ShipmentReport_Shipped_All_Fixed_Top_20_Customer 
			--WHERE Year = @Year
			--INSERT INTO ShipmentReport_Shipped_All_Fixed_Customer_OEM
			--SELECT a.*
			--FROM #Temp a
			--WHERE NOT EXISTS(SELECT b.* FROM ShipmentReport_Shipped_All_Fixed_Customer_OEM b WHERE a.OEMCustomer+a.ReportCode+a.Site+a.Plant+a.Year=b.OEMCustomer+b.ReportCode+b.Site+b.Plant+b.Year)
			--UPDATE ShipmentReport_Shipped_All_Fixed_Customer_OEM
			--SET M1=b.M1,M2=b.M2,M3=b.M3,M4=b.M4,M5=b.M5,M6=b.M6,M7=b.M7,M8=b.M8,M9=b.M9,M10=b.M10,M11=b.M11,M12=b.M12
			--FROM ShipmentReport_Shipped_All_Fixed_Customer_OEM a,#Temp b
			--WHERE a.OEMCustomer=b.OEMCustomer
			--	AND a.ReportCode=b.ReportCode
			--	AND a.Site=b.Site
			--	AND a.Plant=b.Plant
			--	AND a.Year=b.Year

			SET @Site='Nfd'
			SET @Plant=''
			SET @SiteDesc ='North Field'
			SET @PlantDesc=''
			TRUNCATE TABLE #Temp
			INSERT INTO #Temp
			SELECT Customer,@ReportCode AS ReportCode,@SiteDesc AS Site,@PlantDesc AS Plant,Year,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom1,@DateTo1) AS M1,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom2,@DateTo2) AS M2,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom3,@DateTo3) AS M3,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom4,@DateTo4) AS M4,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom5,@DateTo5) AS M5,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom6,@DateTo6) AS M6,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom7,@DateTo7) AS M7,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom8,@DateTo8) AS M8,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom9,@DateTo9) AS M9,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom10,@DateTo10) AS M10,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom11,@DateTo11) AS M11,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom12,@DateTo12) AS M12
			FROM ShipmentReport_Shipped_All_Fixed_Top_20_Customer 
			WHERE Year = @Year
			INSERT INTO ShipmentReport_Shipped_All_Fixed_Customer_OEM
			SELECT a.*
			FROM #Temp a
			WHERE NOT EXISTS(SELECT b.* FROM ShipmentReport_Shipped_All_Fixed_Customer_OEM b WHERE a.OEMCustomer+a.ReportCode+a.Site+a.Plant+a.Year=b.OEMCustomer+b.ReportCode+b.Site+b.Plant+b.Year)
			UPDATE ShipmentReport_Shipped_All_Fixed_Customer_OEM
			SET M1=b.M1,M2=b.M2,M3=b.M3,M4=b.M4,M5=b.M5,M6=b.M6,M7=b.M7,M8=b.M8,M9=b.M9,M10=b.M10,M11=b.M11,M12=b.M12
			FROM ShipmentReport_Shipped_All_Fixed_Customer_OEM a,#Temp b
			WHERE a.OEMCustomer=b.OEMCustomer
				AND a.ReportCode=b.ReportCode
				AND a.Site=b.Site
				AND a.Plant=b.Plant
				AND a.Year=b.Year

			SET @Site='Sao'
			SET @Plant=''
			SET @SiteDesc ='Brazil'
			SET @PlantDesc=''
			TRUNCATE TABLE #Temp
			INSERT INTO #Temp
			SELECT Customer,@ReportCode AS ReportCode,@SiteDesc AS Site,@PlantDesc AS Plant,Year,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom1,@DateTo1) AS M1,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom2,@DateTo2) AS M2,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom3,@DateTo3) AS M3,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom4,@DateTo4) AS M4,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom5,@DateTo5) AS M5,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom6,@DateTo6) AS M6,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom7,@DateTo7) AS M7,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom8,@DateTo8) AS M8,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom9,@DateTo9) AS M9,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom10,@DateTo10) AS M10,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom11,@DateTo11) AS M11,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom12,@DateTo12) AS M12
			FROM ShipmentReport_Shipped_All_Fixed_Top_20_Customer 
			WHERE Year = @Year
			INSERT INTO ShipmentReport_Shipped_All_Fixed_Customer_OEM
			SELECT a.*
			FROM #Temp a
			WHERE NOT EXISTS(SELECT b.* FROM ShipmentReport_Shipped_All_Fixed_Customer_OEM b WHERE a.OEMCustomer+a.ReportCode+a.Site+a.Plant+a.Year=b.OEMCustomer+b.ReportCode+b.Site+b.Plant+b.Year)
			UPDATE ShipmentReport_Shipped_All_Fixed_Customer_OEM
			SET M1=b.M1,M2=b.M2,M3=b.M3,M4=b.M4,M5=b.M5,M6=b.M6,M7=b.M7,M8=b.M8,M9=b.M9,M10=b.M10,M11=b.M11,M12=b.M12
			FROM ShipmentReport_Shipped_All_Fixed_Customer_OEM a,#Temp b
			WHERE a.OEMCustomer=b.OEMCustomer
				AND a.ReportCode=b.ReportCode
				AND a.Site=b.Site
				AND a.Plant=b.Plant
				AND a.Year=b.Year

			-----------------------------------------
			SET @OEMCustomer='Customer'
			SET @ReportCode='998'
			--SET @Site='Chi'
			--SET @Plant=''
			--SET @SiteDesc ='China'
			--SET @PlantDesc=''
			--TRUNCATE TABLE #Temp
			--INSERT INTO #Temp
			--SELECT Customer,@ReportCode AS ReportCode,@SiteDesc AS Site,@PlantDesc AS Plant,Year,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom1,@FDateTo1) AS M1,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom2,@FDateTo2) AS M2,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom3,@FDateTo3) AS M3,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom4,@FDateTo4) AS M4,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom5,@FDateTo5) AS M5,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom6,@FDateTo6) AS M6,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom7,@FDateTo7) AS M7,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom8,@FDateTo8) AS M8,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom9,@FDateTo9) AS M9,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom10,@FDateTo10) AS M10,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom11,@FDateTo11) AS M11,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom12,@FDateTo12) AS M12
			--FROM ShipmentReport_Shipped_All_Fixed_Top_20_Customer_Fiscal
			--WHERE Year = @Year
			--INSERT INTO ShipmentReport_Shipped_All_Fixed_Customer_OEM
			--SELECT a.*
			--FROM #Temp a
			--WHERE NOT EXISTS(SELECT b.* FROM ShipmentReport_Shipped_All_Fixed_Customer_OEM b WHERE a.OEMCustomer+a.ReportCode+a.Site+a.Plant+a.Year=b.OEMCustomer+b.ReportCode+b.Site+b.Plant+b.Year)
			--UPDATE ShipmentReport_Shipped_All_Fixed_Customer_OEM
			--SET M1=b.M1,M2=b.M2,M3=b.M3,M4=b.M4,M5=b.M5,M6=b.M6,M7=b.M7,M8=b.M8,M9=b.M9,M10=b.M10,M11=b.M11,M12=b.M12
			--FROM ShipmentReport_Shipped_All_Fixed_Customer_OEM a,#Temp b
			--WHERE a.OEMCustomer=b.OEMCustomer
			--	AND a.ReportCode=b.ReportCode
			--	AND a.Site=b.Site
			--	AND a.Plant=b.Plant
			--	AND a.Year=b.Year

			--SET @Site='Dis'
			--SET @Plant=''
			--SET @SiteDesc ='Display'
			--SET @PlantDesc=''
			--TRUNCATE TABLE #Temp
			--INSERT INTO #Temp
			--SELECT Customer,@ReportCode AS ReportCode,@SiteDesc AS Site,@PlantDesc AS Plant,Year,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom1,@FDateTo1) AS M1,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom2,@FDateTo2) AS M2,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom3,@FDateTo3) AS M3,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom4,@FDateTo4) AS M4,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom5,@FDateTo5) AS M5,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom6,@FDateTo6) AS M6,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom7,@FDateTo7) AS M7,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom8,@FDateTo8) AS M8,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom9,@FDateTo9) AS M9,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom10,@FDateTo10) AS M10,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom11,@FDateTo11) AS M11,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom12,@FDateTo12) AS M12
			--FROM ShipmentReport_Shipped_All_Fixed_Top_20_Customer_Fiscal
			--WHERE Year = @Year
			--INSERT INTO ShipmentReport_Shipped_All_Fixed_Customer_OEM
			--SELECT a.*
			--FROM #Temp a
			--WHERE NOT EXISTS(SELECT b.* FROM ShipmentReport_Shipped_All_Fixed_Customer_OEM b WHERE a.OEMCustomer+a.ReportCode+a.Site+a.Plant+a.Year=b.OEMCustomer+b.ReportCode+b.Site+b.Plant+b.Year)
			--UPDATE ShipmentReport_Shipped_All_Fixed_Customer_OEM
			--SET M1=b.M1,M2=b.M2,M3=b.M3,M4=b.M4,M5=b.M5,M6=b.M6,M7=b.M7,M8=b.M8,M9=b.M9,M10=b.M10,M11=b.M11,M12=b.M12
			--FROM ShipmentReport_Shipped_All_Fixed_Customer_OEM a,#Temp b
			--WHERE a.OEMCustomer=b.OEMCustomer
			--	AND a.ReportCode=b.ReportCode
			--	AND a.Site=b.Site
			--	AND a.Plant=b.Plant
			--	AND a.Year=b.Year

			--SET @Site='Ger'
			--SET @Plant=''
			--SET @SiteDesc ='Germany'
			--SET @PlantDesc=''
			--TRUNCATE TABLE #Temp
			--INSERT INTO #Temp
			--SELECT Customer,@ReportCode AS ReportCode,@SiteDesc AS Site,@PlantDesc AS Plant,Year,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom1,@FDateTo1) AS M1,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom2,@FDateTo2) AS M2,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom3,@FDateTo3) AS M3,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom4,@FDateTo4) AS M4,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom5,@FDateTo5) AS M5,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom6,@FDateTo6) AS M6,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom7,@FDateTo7) AS M7,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom8,@FDateTo8) AS M8,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom9,@FDateTo9) AS M9,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom10,@FDateTo10) AS M10,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom11,@FDateTo11) AS M11,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom12,@FDateTo12) AS M12
			--FROM ShipmentReport_Shipped_All_Fixed_Top_20_Customer_Fiscal
			--WHERE Year = @Year
			--INSERT INTO ShipmentReport_Shipped_All_Fixed_Customer_OEM
			--SELECT a.*
			--FROM #Temp a
			--WHERE NOT EXISTS(SELECT b.* FROM ShipmentReport_Shipped_All_Fixed_Customer_OEM b WHERE a.OEMCustomer+a.ReportCode+a.Site+a.Plant+a.Year=b.OEMCustomer+b.ReportCode+b.Site+b.Plant+b.Year)
			--UPDATE ShipmentReport_Shipped_All_Fixed_Customer_OEM
			--SET M1=b.M1,M2=b.M2,M3=b.M3,M4=b.M4,M5=b.M5,M6=b.M6,M7=b.M7,M8=b.M8,M9=b.M9,M10=b.M10,M11=b.M11,M12=b.M12
			--FROM ShipmentReport_Shipped_All_Fixed_Customer_OEM a,#Temp b
			--WHERE a.OEMCustomer=b.OEMCustomer
			--	AND a.ReportCode=b.ReportCode
			--	AND a.Site=b.Site
			--	AND a.Plant=b.Plant
			--	AND a.Year=b.Year

			SET @Site='Nfd'
			SET @Plant=''
			SET @SiteDesc ='North Field'
			SET @PlantDesc=''
			TRUNCATE TABLE #Temp
			INSERT INTO #Temp
			SELECT Customer,@ReportCode AS ReportCode,@SiteDesc AS Site,@PlantDesc AS Plant,Year,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom1,@FDateTo1) AS M1,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom2,@FDateTo2) AS M2,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom3,@FDateTo3) AS M3,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom4,@FDateTo4) AS M4,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom5,@FDateTo5) AS M5,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom6,@FDateTo6) AS M6,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom7,@FDateTo7) AS M7,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom8,@FDateTo8) AS M8,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom9,@FDateTo9) AS M9,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom10,@FDateTo10) AS M10,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom11,@FDateTo11) AS M11,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom12,@FDateTo12) AS M12
			FROM ShipmentReport_Shipped_All_Fixed_Top_20_Customer_Fiscal
			WHERE Year = @Year
			INSERT INTO ShipmentReport_Shipped_All_Fixed_Customer_OEM
			SELECT a.*
			FROM #Temp a
			WHERE NOT EXISTS(SELECT b.* FROM ShipmentReport_Shipped_All_Fixed_Customer_OEM b WHERE a.OEMCustomer+a.ReportCode+a.Site+a.Plant+a.Year=b.OEMCustomer+b.ReportCode+b.Site+b.Plant+b.Year)
			UPDATE ShipmentReport_Shipped_All_Fixed_Customer_OEM
			SET M1=b.M1,M2=b.M2,M3=b.M3,M4=b.M4,M5=b.M5,M6=b.M6,M7=b.M7,M8=b.M8,M9=b.M9,M10=b.M10,M11=b.M11,M12=b.M12
			FROM ShipmentReport_Shipped_All_Fixed_Customer_OEM a,#Temp b
			WHERE a.OEMCustomer=b.OEMCustomer
				AND a.ReportCode=b.ReportCode
				AND a.Site=b.Site
				AND a.Plant=b.Plant
				AND a.Year=b.Year

			SET @Site='Sao'
			SET @Plant=''
			SET @SiteDesc ='Brazil'
			SET @PlantDesc=''
			TRUNCATE TABLE #Temp
			INSERT INTO #Temp
			SELECT Customer,@ReportCode AS ReportCode,@SiteDesc AS Site,@PlantDesc AS Plant,Year,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom1,@FDateTo1) AS M1,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom2,@FDateTo2) AS M2,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom3,@FDateTo3) AS M3,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom4,@FDateTo4) AS M4,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom5,@FDateTo5) AS M5,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom6,@FDateTo6) AS M6,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom7,@FDateTo7) AS M7,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom8,@FDateTo8) AS M8,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom9,@FDateTo9) AS M9,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom10,@FDateTo10) AS M10,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom11,@FDateTo11) AS M11,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom12,@FDateTo12) AS M12
			FROM ShipmentReport_Shipped_All_Fixed_Top_20_Customer_Fiscal
			WHERE Year = @Year
			INSERT INTO ShipmentReport_Shipped_All_Fixed_Customer_OEM
			SELECT a.*
			FROM #Temp a
			WHERE NOT EXISTS(SELECT b.* FROM ShipmentReport_Shipped_All_Fixed_Customer_OEM b WHERE a.OEMCustomer+a.ReportCode+a.Site+a.Plant+a.Year=b.OEMCustomer+b.ReportCode+b.Site+b.Plant+b.Year)
			UPDATE ShipmentReport_Shipped_All_Fixed_Customer_OEM
			SET M1=b.M1,M2=b.M2,M3=b.M3,M4=b.M4,M5=b.M5,M6=b.M6,M7=b.M7,M8=b.M8,M9=b.M9,M10=b.M10,M11=b.M11,M12=b.M12
			FROM ShipmentReport_Shipped_All_Fixed_Customer_OEM a,#Temp b
			WHERE a.OEMCustomer=b.OEMCustomer
				AND a.ReportCode=b.ReportCode
				AND a.Site=b.Site
				AND a.Plant=b.Plant
				AND a.Year=b.Year

			------------------------------

			--SET @OEMCustomer='Customer'
			--SET @ReportCode='997'
			--SET @Site='Chi'
			--SET @Plant='P2'
			--SET @SiteDesc ='China'
			--SET @PlantDesc='B1'
			--TRUNCATE TABLE #Temp
			--INSERT INTO #Temp
			--SELECT Customer,@ReportCode AS ReportCode,@SiteDesc AS Site,@PlantDesc AS Plant,Year,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom1,@DateTo1) AS M1,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom2,@DateTo2) AS M2,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom3,@DateTo3) AS M3,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom4,@DateTo4) AS M4,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom5,@DateTo5) AS M5,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom6,@DateTo6) AS M6,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom7,@DateTo7) AS M7,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom8,@DateTo8) AS M8,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom9,@DateTo9) AS M9,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom10,@DateTo10) AS M10,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom11,@DateTo11) AS M11,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom12,@DateTo12) AS M12
			--FROM ShipmentReport_Shipped_All_Fixed_Top_20_Customer_By_Loc
			--WHERE Year = @Year
			--	AND Loc=@Site
			--INSERT INTO ShipmentReport_Shipped_All_Fixed_Customer_OEM
			--SELECT a.*
			--FROM #Temp a
			--WHERE NOT EXISTS(SELECT b.* FROM ShipmentReport_Shipped_All_Fixed_Customer_OEM b WHERE a.OEMCustomer+a.ReportCode+a.Site+a.Plant+a.Year=b.OEMCustomer+b.ReportCode+b.Site+b.Plant+b.Year)
			--UPDATE ShipmentReport_Shipped_All_Fixed_Customer_OEM
			--SET M1=b.M1,M2=b.M2,M3=b.M3,M4=b.M4,M5=b.M5,M6=b.M6,M7=b.M7,M8=b.M8,M9=b.M9,M10=b.M10,M11=b.M11,M12=b.M12
			--FROM ShipmentReport_Shipped_All_Fixed_Customer_OEM a,#Temp b
			--WHERE a.OEMCustomer=b.OEMCustomer
			--	AND a.ReportCode=b.ReportCode
			--	AND a.Site=b.Site
			--	AND a.Plant=b.Plant
			--	AND a.Year=b.Year

			--SET @Site='Chi'
			--SET @Plant='12'
			--SET @SiteDesc ='China'
			--SET @PlantDesc='B12'
			--TRUNCATE TABLE #Temp
			--INSERT INTO #Temp
			--SELECT Customer,@ReportCode AS ReportCode,@SiteDesc AS Site,@PlantDesc AS Plant,Year,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom1,@DateTo1) AS M1,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom2,@DateTo2) AS M2,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom3,@DateTo3) AS M3,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom4,@DateTo4) AS M4,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom5,@DateTo5) AS M5,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom6,@DateTo6) AS M6,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom7,@DateTo7) AS M7,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom8,@DateTo8) AS M8,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom9,@DateTo9) AS M9,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom10,@DateTo10) AS M10,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom11,@DateTo11) AS M11,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom12,@DateTo12) AS M12
			--FROM ShipmentReport_Shipped_All_Fixed_Top_20_Customer_By_Loc
			--WHERE Year = @Year
			--	AND Loc=@Site
			--INSERT INTO ShipmentReport_Shipped_All_Fixed_Customer_OEM
			--SELECT a.*
			--FROM #Temp a
			--WHERE NOT EXISTS(SELECT b.* FROM ShipmentReport_Shipped_All_Fixed_Customer_OEM b WHERE a.OEMCustomer+a.ReportCode+a.Site+a.Plant+a.Year=b.OEMCustomer+b.ReportCode+b.Site+b.Plant+b.Year)
			--UPDATE ShipmentReport_Shipped_All_Fixed_Customer_OEM
			--SET M1=b.M1,M2=b.M2,M3=b.M3,M4=b.M4,M5=b.M5,M6=b.M6,M7=b.M7,M8=b.M8,M9=b.M9,M10=b.M10,M11=b.M11,M12=b.M12
			--FROM ShipmentReport_Shipped_All_Fixed_Customer_OEM a,#Temp b
			--WHERE a.OEMCustomer=b.OEMCustomer
			--	AND a.ReportCode=b.ReportCode
			--	AND a.Site=b.Site
			--	AND a.Plant=b.Plant
			--	AND a.Year=b.Year

			--SET @Site='Chi'
			--SET @Plant='2F'
			--SET @SiteDesc ='China'
			--SET @PlantDesc='B2F'
			--TRUNCATE TABLE #Temp
			--INSERT INTO #Temp
			--SELECT Customer,@ReportCode AS ReportCode,@SiteDesc AS Site,@PlantDesc AS Plant,Year,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom1,@DateTo1) AS M1,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom2,@DateTo2) AS M2,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom3,@DateTo3) AS M3,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom4,@DateTo4) AS M4,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom5,@DateTo5) AS M5,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom6,@DateTo6) AS M6,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom7,@DateTo7) AS M7,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom8,@DateTo8) AS M8,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom9,@DateTo9) AS M9,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom10,@DateTo10) AS M10,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom11,@DateTo11) AS M11,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom12,@DateTo12) AS M12
			--FROM ShipmentReport_Shipped_All_Fixed_Top_20_Customer_By_Loc
			--WHERE Year = @Year
			--	AND Loc=@Site
			--INSERT INTO ShipmentReport_Shipped_All_Fixed_Customer_OEM
			--SELECT a.*
			--FROM #Temp a
			--WHERE NOT EXISTS(SELECT b.* FROM ShipmentReport_Shipped_All_Fixed_Customer_OEM b WHERE a.OEMCustomer+a.ReportCode+a.Site+a.Plant+a.Year=b.OEMCustomer+b.ReportCode+b.Site+b.Plant+b.Year)
			--UPDATE ShipmentReport_Shipped_All_Fixed_Customer_OEM
			--SET M1=b.M1,M2=b.M2,M3=b.M3,M4=b.M4,M5=b.M5,M6=b.M6,M7=b.M7,M8=b.M8,M9=b.M9,M10=b.M10,M11=b.M11,M12=b.M12
			--FROM ShipmentReport_Shipped_All_Fixed_Customer_OEM a,#Temp b
			--WHERE a.OEMCustomer=b.OEMCustomer
			--	AND a.ReportCode=b.ReportCode
			--	AND a.Site=b.Site
			--	AND a.Plant=b.Plant
			--	AND a.Year=b.Year

			--SET @Site='Chi'
			--SET @Plant='B3'
			--SET @SiteDesc ='China'
			--SET @PlantDesc='B3'
			--TRUNCATE TABLE #Temp
			--INSERT INTO #Temp
			--SELECT Customer,@ReportCode AS ReportCode,@SiteDesc AS Site,@PlantDesc AS Plant,Year,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom1,@DateTo1) AS M1,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom2,@DateTo2) AS M2,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom3,@DateTo3) AS M3,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom4,@DateTo4) AS M4,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom5,@DateTo5) AS M5,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom6,@DateTo6) AS M6,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom7,@DateTo7) AS M7,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom8,@DateTo8) AS M8,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom9,@DateTo9) AS M9,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom10,@DateTo10) AS M10,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom11,@DateTo11) AS M11,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom12,@DateTo12) AS M12
			--FROM ShipmentReport_Shipped_All_Fixed_Top_20_Customer_By_Loc
			--WHERE Year = @Year
			--	AND Loc=@Site
			--INSERT INTO ShipmentReport_Shipped_All_Fixed_Customer_OEM
			--SELECT a.*
			--FROM #Temp a
			--WHERE NOT EXISTS(SELECT b.* FROM ShipmentReport_Shipped_All_Fixed_Customer_OEM b WHERE a.OEMCustomer+a.ReportCode+a.Site+a.Plant+a.Year=b.OEMCustomer+b.ReportCode+b.Site+b.Plant+b.Year)
			--UPDATE ShipmentReport_Shipped_All_Fixed_Customer_OEM
			--SET M1=b.M1,M2=b.M2,M3=b.M3,M4=b.M4,M5=b.M5,M6=b.M6,M7=b.M7,M8=b.M8,M9=b.M9,M10=b.M10,M11=b.M11,M12=b.M12
			--FROM ShipmentReport_Shipped_All_Fixed_Customer_OEM a,#Temp b
			--WHERE a.OEMCustomer=b.OEMCustomer
			--	AND a.ReportCode=b.ReportCode
			--	AND a.Site=b.Site
			--	AND a.Plant=b.Plant
			--	AND a.Year=b.Year

			--SET @Site='Chi'
			--SET @Plant='B4'
			--SET @SiteDesc ='China'
			--SET @PlantDesc='B4'
			--TRUNCATE TABLE #Temp
			--INSERT INTO #Temp
			--SELECT Customer,@ReportCode AS ReportCode,@SiteDesc AS Site,@PlantDesc AS Plant,Year,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom1,@DateTo1) AS M1,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom2,@DateTo2) AS M2,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom3,@DateTo3) AS M3,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom4,@DateTo4) AS M4,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom5,@DateTo5) AS M5,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom6,@DateTo6) AS M6,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom7,@DateTo7) AS M7,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom8,@DateTo8) AS M8,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom9,@DateTo9) AS M9,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom10,@DateTo10) AS M10,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom11,@DateTo11) AS M11,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom12,@DateTo12) AS M12
			--FROM ShipmentReport_Shipped_All_Fixed_Top_20_Customer_By_Loc
			--WHERE Year = @Year
			--	AND Loc=@Site
			--INSERT INTO ShipmentReport_Shipped_All_Fixed_Customer_OEM
			--SELECT a.*
			--FROM #Temp a
			--WHERE NOT EXISTS(SELECT b.* FROM ShipmentReport_Shipped_All_Fixed_Customer_OEM b WHERE a.OEMCustomer+a.ReportCode+a.Site+a.Plant+a.Year=b.OEMCustomer+b.ReportCode+b.Site+b.Plant+b.Year)
			--UPDATE ShipmentReport_Shipped_All_Fixed_Customer_OEM
			--SET M1=b.M1,M2=b.M2,M3=b.M3,M4=b.M4,M5=b.M5,M6=b.M6,M7=b.M7,M8=b.M8,M9=b.M9,M10=b.M10,M11=b.M11,M12=b.M12
			--FROM ShipmentReport_Shipped_All_Fixed_Customer_OEM a,#Temp b
			--WHERE a.OEMCustomer=b.OEMCustomer
			--	AND a.ReportCode=b.ReportCode
			--	AND a.Site=b.Site
			--	AND a.Plant=b.Plant
			--	AND a.Year=b.Year

			--SET @Site='Chi'
			--SET @Plant='B5'
			--SET @SiteDesc ='China'
			--SET @PlantDesc='B5'
			--TRUNCATE TABLE #Temp
			--INSERT INTO #Temp
			--SELECT Customer,@ReportCode AS ReportCode,@SiteDesc AS Site,@PlantDesc AS Plant,Year,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom1,@DateTo1) AS M1,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom2,@DateTo2) AS M2,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom3,@DateTo3) AS M3,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom4,@DateTo4) AS M4,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom5,@DateTo5) AS M5,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom6,@DateTo6) AS M6,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom7,@DateTo7) AS M7,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom8,@DateTo8) AS M8,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom9,@DateTo9) AS M9,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom10,@DateTo10) AS M10,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom11,@DateTo11) AS M11,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom12,@DateTo12) AS M12
			--FROM ShipmentReport_Shipped_All_Fixed_Top_20_Customer_By_Loc
			--WHERE Year = @Year
			--	AND Loc=@Site
			--INSERT INTO ShipmentReport_Shipped_All_Fixed_Customer_OEM
			--SELECT a.*
			--FROM #Temp a
			--WHERE NOT EXISTS(SELECT b.* FROM ShipmentReport_Shipped_All_Fixed_Customer_OEM b WHERE a.OEMCustomer+a.ReportCode+a.Site+a.Plant+a.Year=b.OEMCustomer+b.ReportCode+b.Site+b.Plant+b.Year)
			--UPDATE ShipmentReport_Shipped_All_Fixed_Customer_OEM
			--SET M1=b.M1,M2=b.M2,M3=b.M3,M4=b.M4,M5=b.M5,M6=b.M6,M7=b.M7,M8=b.M8,M9=b.M9,M10=b.M10,M11=b.M11,M12=b.M12
			--FROM ShipmentReport_Shipped_All_Fixed_Customer_OEM a,#Temp b
			--WHERE a.OEMCustomer=b.OEMCustomer
			--	AND a.ReportCode=b.ReportCode
			--	AND a.Site=b.Site
			--	AND a.Plant=b.Plant
			--	AND a.Year=b.Year

			--SET @Site='Chi'
			--SET @Plant='HK'
			--SET @SiteDesc ='China'
			--SET @PlantDesc='VVI'
			--TRUNCATE TABLE #Temp
			--INSERT INTO #Temp
			--SELECT Customer,@ReportCode AS ReportCode,@SiteDesc AS Site,@PlantDesc AS Plant,Year,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom1,@DateTo1) AS M1,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom2,@DateTo2) AS M2,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom3,@DateTo3) AS M3,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom4,@DateTo4) AS M4,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom5,@DateTo5) AS M5,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom6,@DateTo6) AS M6,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom7,@DateTo7) AS M7,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom8,@DateTo8) AS M8,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom9,@DateTo9) AS M9,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom10,@DateTo10) AS M10,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom11,@DateTo11) AS M11,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom12,@DateTo12) AS M12
			--FROM ShipmentReport_Shipped_All_Fixed_Top_20_Customer_By_Loc
			--WHERE Year = @Year
			--	AND Loc=@Site
			--INSERT INTO ShipmentReport_Shipped_All_Fixed_Customer_OEM
			--SELECT a.*
			--FROM #Temp a
			--WHERE NOT EXISTS(SELECT b.* FROM ShipmentReport_Shipped_All_Fixed_Customer_OEM b WHERE a.OEMCustomer+a.ReportCode+a.Site+a.Plant+a.Year=b.OEMCustomer+b.ReportCode+b.Site+b.Plant+b.Year)
			--UPDATE ShipmentReport_Shipped_All_Fixed_Customer_OEM
			--SET M1=b.M1,M2=b.M2,M3=b.M3,M4=b.M4,M5=b.M5,M6=b.M6,M7=b.M7,M8=b.M8,M9=b.M9,M10=b.M10,M11=b.M11,M12=b.M12
			--FROM ShipmentReport_Shipped_All_Fixed_Customer_OEM a,#Temp b
			--WHERE a.OEMCustomer=b.OEMCustomer
			--	AND a.ReportCode=b.ReportCode
			--	AND a.Site=b.Site
			--	AND a.Plant=b.Plant
			--	AND a.Year=b.Year

			----------------------
			
			--SET @OEMCustomer='Customer'
			--SET @ReportCode='996'
			--SET @Site='Chi'
			--SET @Plant='P2'
			--SET @SiteDesc ='China'
			--SET @PlantDesc='B1'
			--TRUNCATE TABLE #Temp
			--INSERT INTO #Temp
			--SELECT Customer,@ReportCode AS ReportCode,@SiteDesc AS Site,@PlantDesc AS Plant,Year,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom1,@FDateTo1) AS M1,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom2,@FDateTo2) AS M2,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom3,@FDateTo3) AS M3,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom4,@FDateTo4) AS M4,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom5,@FDateTo5) AS M5,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom6,@FDateTo6) AS M6,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom7,@FDateTo7) AS M7,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom8,@FDateTo8) AS M8,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom9,@FDateTo9) AS M9,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom10,@FDateTo10) AS M10,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom11,@FDateTo11) AS M11,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom12,@FDateTo12) AS M12
			--FROM ShipmentReport_Shipped_All_Fixed_Top_20_Customer_Fiscal_By_Loc
			--WHERE Year = @Year
			--	AND Loc=@Site
			--INSERT INTO ShipmentReport_Shipped_All_Fixed_Customer_OEM
			--SELECT a.*
			--FROM #Temp a
			--WHERE NOT EXISTS(SELECT b.* FROM ShipmentReport_Shipped_All_Fixed_Customer_OEM b WHERE a.OEMCustomer+a.ReportCode+a.Site+a.Plant+a.Year=b.OEMCustomer+b.ReportCode+b.Site+b.Plant+b.Year)
			--UPDATE ShipmentReport_Shipped_All_Fixed_Customer_OEM
			--SET M1=b.M1,M2=b.M2,M3=b.M3,M4=b.M4,M5=b.M5,M6=b.M6,M7=b.M7,M8=b.M8,M9=b.M9,M10=b.M10,M11=b.M11,M12=b.M12
			--FROM ShipmentReport_Shipped_All_Fixed_Customer_OEM a,#Temp b
			--WHERE a.OEMCustomer=b.OEMCustomer
			--	AND a.ReportCode=b.ReportCode
			--	AND a.Site=b.Site
			--	AND a.Plant=b.Plant
			--	AND a.Year=b.Year

			--SET @Site='Chi'
			--SET @Plant='12'
			--SET @SiteDesc ='China'
			--SET @PlantDesc='B12'
			--TRUNCATE TABLE #Temp
			--INSERT INTO #Temp
			--SELECT Customer,@ReportCode AS ReportCode,@SiteDesc AS Site,@PlantDesc AS Plant,Year,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom1,@FDateTo1) AS M1,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom2,@FDateTo2) AS M2,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom3,@FDateTo3) AS M3,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom4,@FDateTo4) AS M4,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom5,@FDateTo5) AS M5,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom6,@FDateTo6) AS M6,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom7,@FDateTo7) AS M7,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom8,@FDateTo8) AS M8,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom9,@FDateTo9) AS M9,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom10,@FDateTo10) AS M10,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom11,@FDateTo11) AS M11,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom12,@FDateTo12) AS M12
			--FROM ShipmentReport_Shipped_All_Fixed_Top_20_Customer_Fiscal_By_Loc
			--WHERE Year = @Year
			--	AND Loc=@Site
			--INSERT INTO ShipmentReport_Shipped_All_Fixed_Customer_OEM
			--SELECT a.*
			--FROM #Temp a
			--WHERE NOT EXISTS(SELECT b.* FROM ShipmentReport_Shipped_All_Fixed_Customer_OEM b WHERE a.OEMCustomer+a.ReportCode+a.Site+a.Plant+a.Year=b.OEMCustomer+b.ReportCode+b.Site+b.Plant+b.Year)
			--UPDATE ShipmentReport_Shipped_All_Fixed_Customer_OEM
			--SET M1=b.M1,M2=b.M2,M3=b.M3,M4=b.M4,M5=b.M5,M6=b.M6,M7=b.M7,M8=b.M8,M9=b.M9,M10=b.M10,M11=b.M11,M12=b.M12
			--FROM ShipmentReport_Shipped_All_Fixed_Customer_OEM a,#Temp b
			--WHERE a.OEMCustomer=b.OEMCustomer
			--	AND a.ReportCode=b.ReportCode
			--	AND a.Site=b.Site
			--	AND a.Plant=b.Plant
			--	AND a.Year=b.Year

			--SET @Site='Chi'
			--SET @Plant='2F'
			--SET @SiteDesc ='China'
			--SET @PlantDesc='B2F'
			--TRUNCATE TABLE #Temp
			--INSERT INTO #Temp
			--SELECT Customer,@ReportCode AS ReportCode,@SiteDesc AS Site,@PlantDesc AS Plant,Year,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom1,@FDateTo1) AS M1,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom2,@FDateTo2) AS M2,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom3,@FDateTo3) AS M3,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom4,@FDateTo4) AS M4,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom5,@FDateTo5) AS M5,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom6,@FDateTo6) AS M6,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom7,@FDateTo7) AS M7,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom8,@FDateTo8) AS M8,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom9,@FDateTo9) AS M9,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom10,@FDateTo10) AS M10,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom11,@FDateTo11) AS M11,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom12,@FDateTo12) AS M12
			--FROM ShipmentReport_Shipped_All_Fixed_Top_20_Customer_Fiscal_By_Loc
			--WHERE Year = @Year
			--	AND Loc=@Site
			--INSERT INTO ShipmentReport_Shipped_All_Fixed_Customer_OEM
			--SELECT a.*
			--FROM #Temp a
			--WHERE NOT EXISTS(SELECT b.* FROM ShipmentReport_Shipped_All_Fixed_Customer_OEM b WHERE a.OEMCustomer+a.ReportCode+a.Site+a.Plant+a.Year=b.OEMCustomer+b.ReportCode+b.Site+b.Plant+b.Year)
			--UPDATE ShipmentReport_Shipped_All_Fixed_Customer_OEM
			--SET M1=b.M1,M2=b.M2,M3=b.M3,M4=b.M4,M5=b.M5,M6=b.M6,M7=b.M7,M8=b.M8,M9=b.M9,M10=b.M10,M11=b.M11,M12=b.M12
			--FROM ShipmentReport_Shipped_All_Fixed_Customer_OEM a,#Temp b
			--WHERE a.OEMCustomer=b.OEMCustomer
			--	AND a.ReportCode=b.ReportCode
			--	AND a.Site=b.Site
			--	AND a.Plant=b.Plant
			--	AND a.Year=b.Year

			--SET @Site='Chi'
			--SET @Plant='B3'
			--SET @SiteDesc ='China'
			--SET @PlantDesc='B3'
			--TRUNCATE TABLE #Temp
			--INSERT INTO #Temp
			--SELECT Customer,@ReportCode AS ReportCode,@SiteDesc AS Site,@PlantDesc AS Plant,Year,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom1,@FDateTo1) AS M1,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom2,@FDateTo2) AS M2,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom3,@FDateTo3) AS M3,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom4,@FDateTo4) AS M4,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom5,@FDateTo5) AS M5,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom6,@FDateTo6) AS M6,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom7,@FDateTo7) AS M7,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom8,@FDateTo8) AS M8,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom9,@FDateTo9) AS M9,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom10,@FDateTo10) AS M10,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom11,@FDateTo11) AS M11,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom12,@FDateTo12) AS M12
			--FROM ShipmentReport_Shipped_All_Fixed_Top_20_Customer_Fiscal_By_Loc
			--WHERE Year = @Year
			--	AND Loc=@Site
			--INSERT INTO ShipmentReport_Shipped_All_Fixed_Customer_OEM
			--SELECT a.*
			--FROM #Temp a
			--WHERE NOT EXISTS(SELECT b.* FROM ShipmentReport_Shipped_All_Fixed_Customer_OEM b WHERE a.OEMCustomer+a.ReportCode+a.Site+a.Plant+a.Year=b.OEMCustomer+b.ReportCode+b.Site+b.Plant+b.Year)
			--UPDATE ShipmentReport_Shipped_All_Fixed_Customer_OEM
			--SET M1=b.M1,M2=b.M2,M3=b.M3,M4=b.M4,M5=b.M5,M6=b.M6,M7=b.M7,M8=b.M8,M9=b.M9,M10=b.M10,M11=b.M11,M12=b.M12
			--FROM ShipmentReport_Shipped_All_Fixed_Customer_OEM a,#Temp b
			--WHERE a.OEMCustomer=b.OEMCustomer
			--	AND a.ReportCode=b.ReportCode
			--	AND a.Site=b.Site
			--	AND a.Plant=b.Plant
			--	AND a.Year=b.Year

			--SET @Site='Chi'
			--SET @Plant='B4'
			--SET @SiteDesc ='China'
			--SET @PlantDesc='B4'
			--TRUNCATE TABLE #Temp
			--INSERT INTO #Temp
			--SELECT Customer,@ReportCode AS ReportCode,@SiteDesc AS Site,@PlantDesc AS Plant,Year,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom1,@FDateTo1) AS M1,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom2,@FDateTo2) AS M2,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom3,@FDateTo3) AS M3,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom4,@FDateTo4) AS M4,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom5,@FDateTo5) AS M5,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom6,@FDateTo6) AS M6,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom7,@FDateTo7) AS M7,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom8,@FDateTo8) AS M8,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom9,@FDateTo9) AS M9,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom10,@FDateTo10) AS M10,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom11,@FDateTo11) AS M11,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom12,@FDateTo12) AS M12
			--FROM ShipmentReport_Shipped_All_Fixed_Top_20_Customer_Fiscal_By_Loc
			--WHERE Year = @Year
			--	AND Loc=@Site
			--INSERT INTO ShipmentReport_Shipped_All_Fixed_Customer_OEM
			--SELECT a.*
			--FROM #Temp a
			--WHERE NOT EXISTS(SELECT b.* FROM ShipmentReport_Shipped_All_Fixed_Customer_OEM b WHERE a.OEMCustomer+a.ReportCode+a.Site+a.Plant+a.Year=b.OEMCustomer+b.ReportCode+b.Site+b.Plant+b.Year)
			--UPDATE ShipmentReport_Shipped_All_Fixed_Customer_OEM
			--SET M1=b.M1,M2=b.M2,M3=b.M3,M4=b.M4,M5=b.M5,M6=b.M6,M7=b.M7,M8=b.M8,M9=b.M9,M10=b.M10,M11=b.M11,M12=b.M12
			--FROM ShipmentReport_Shipped_All_Fixed_Customer_OEM a,#Temp b
			--WHERE a.OEMCustomer=b.OEMCustomer
			--	AND a.ReportCode=b.ReportCode
			--	AND a.Site=b.Site
			--	AND a.Plant=b.Plant
			--	AND a.Year=b.Year

			--SET @Site='Chi'
			--SET @Plant='B5'
			--SET @SiteDesc ='China'
			--SET @PlantDesc='B5'
			--TRUNCATE TABLE #Temp
			--INSERT INTO #Temp
			--SELECT Customer,@ReportCode AS ReportCode,@SiteDesc AS Site,@PlantDesc AS Plant,Year,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom1,@FDateTo1) AS M1,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom2,@FDateTo2) AS M2,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom3,@FDateTo3) AS M3,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom4,@FDateTo4) AS M4,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom5,@FDateTo5) AS M5,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom6,@FDateTo6) AS M6,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom7,@FDateTo7) AS M7,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom8,@FDateTo8) AS M8,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom9,@FDateTo9) AS M9,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom10,@FDateTo10) AS M10,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom11,@FDateTo11) AS M11,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom12,@FDateTo12) AS M12
			--FROM ShipmentReport_Shipped_All_Fixed_Top_20_Customer_Fiscal_By_Loc
			--WHERE Year = @Year
			--	AND Loc=@Site
			--INSERT INTO ShipmentReport_Shipped_All_Fixed_Customer_OEM
			--SELECT a.*
			--FROM #Temp a
			--WHERE NOT EXISTS(SELECT b.* FROM ShipmentReport_Shipped_All_Fixed_Customer_OEM b WHERE a.OEMCustomer+a.ReportCode+a.Site+a.Plant+a.Year=b.OEMCustomer+b.ReportCode+b.Site+b.Plant+b.Year)
			--UPDATE ShipmentReport_Shipped_All_Fixed_Customer_OEM
			--SET M1=b.M1,M2=b.M2,M3=b.M3,M4=b.M4,M5=b.M5,M6=b.M6,M7=b.M7,M8=b.M8,M9=b.M9,M10=b.M10,M11=b.M11,M12=b.M12
			--FROM ShipmentReport_Shipped_All_Fixed_Customer_OEM a,#Temp b
			--WHERE a.OEMCustomer=b.OEMCustomer
			--	AND a.ReportCode=b.ReportCode
			--	AND a.Site=b.Site
			--	AND a.Plant=b.Plant
			--	AND a.Year=b.Year

			--SET @Site='Chi'
			--SET @Plant='HK'
			--SET @SiteDesc ='China'
			--SET @PlantDesc='VVI'
			--TRUNCATE TABLE #Temp
			--INSERT INTO #Temp
			--SELECT Customer,@ReportCode AS ReportCode,@SiteDesc AS Site,@PlantDesc AS Plant,Year,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom1,@FDateTo1) AS M1,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom2,@FDateTo2) AS M2,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom3,@FDateTo3) AS M3,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom4,@FDateTo4) AS M4,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom5,@FDateTo5) AS M5,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom6,@FDateTo6) AS M6,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom7,@FDateTo7) AS M7,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom8,@FDateTo8) AS M8,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom9,@FDateTo9) AS M9,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom10,@FDateTo10) AS M10,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom11,@FDateTo11) AS M11,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom12,@FDateTo12) AS M12
			--FROM ShipmentReport_Shipped_All_Fixed_Top_20_Customer_Fiscal_By_Loc
			--WHERE Year = @Year
			--	AND Loc=@Site
			--INSERT INTO ShipmentReport_Shipped_All_Fixed_Customer_OEM
			--SELECT a.*
			--FROM #Temp a
			--WHERE NOT EXISTS(SELECT b.* FROM ShipmentReport_Shipped_All_Fixed_Customer_OEM b WHERE a.OEMCustomer+a.ReportCode+a.Site+a.Plant+a.Year=b.OEMCustomer+b.ReportCode+b.Site+b.Plant+b.Year)
			--UPDATE ShipmentReport_Shipped_All_Fixed_Customer_OEM
			--SET M1=b.M1,M2=b.M2,M3=b.M3,M4=b.M4,M5=b.M5,M6=b.M6,M7=b.M7,M8=b.M8,M9=b.M9,M10=b.M10,M11=b.M11,M12=b.M12
			--FROM ShipmentReport_Shipped_All_Fixed_Customer_OEM a,#Temp b
			--WHERE a.OEMCustomer=b.OEMCustomer
			--	AND a.ReportCode=b.ReportCode
			--	AND a.Site=b.Site
			--	AND a.Plant=b.Plant
			--	AND a.Year=b.Year

			--------------------
			
			--SET @OEMCustomer='Customer'
			--SET @ReportCode='995'
			--SET @Site='Dis'
			--SET @Plant=''
			--SET @SiteDesc ='Display'
			--SET @PlantDesc=''
			--TRUNCATE TABLE #Temp
			--INSERT INTO #Temp
			--SELECT Customer,@ReportCode AS ReportCode,@SiteDesc AS Site,@PlantDesc AS Plant,Year,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom1,@DateTo1) AS M1,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom2,@DateTo2) AS M2,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom3,@DateTo3) AS M3,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom4,@DateTo4) AS M4,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom5,@DateTo5) AS M5,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom6,@DateTo6) AS M6,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom7,@DateTo7) AS M7,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom8,@DateTo8) AS M8,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom9,@DateTo9) AS M9,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom10,@DateTo10) AS M10,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom11,@DateTo11) AS M11,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom12,@DateTo12) AS M12
			--FROM ShipmentReport_Shipped_All_Fixed_Top_20_Customer_By_Loc
			--WHERE Year = @Year
			--	AND Loc=@Site
			--INSERT INTO ShipmentReport_Shipped_All_Fixed_Customer_OEM
			--SELECT a.*
			--FROM #Temp a
			--WHERE NOT EXISTS(SELECT b.* FROM ShipmentReport_Shipped_All_Fixed_Customer_OEM b WHERE a.OEMCustomer+a.ReportCode+a.Site+a.Plant+a.Year=b.OEMCustomer+b.ReportCode+b.Site+b.Plant+b.Year)
			--UPDATE ShipmentReport_Shipped_All_Fixed_Customer_OEM
			--SET M1=b.M1,M2=b.M2,M3=b.M3,M4=b.M4,M5=b.M5,M6=b.M6,M7=b.M7,M8=b.M8,M9=b.M9,M10=b.M10,M11=b.M11,M12=b.M12
			--FROM ShipmentReport_Shipped_All_Fixed_Customer_OEM a,#Temp b
			--WHERE a.OEMCustomer=b.OEMCustomer
			--	AND a.ReportCode=b.ReportCode
			--	AND a.Site=b.Site
			--	AND a.Plant=b.Plant
			--	AND a.Year=b.Year
			----------------------
			--SET @OEMCustomer='Customer'
			--SET @ReportCode='994'
			--SET @Site='Dis'
			--SET @Plant=''
			--SET @SiteDesc ='Display'
			--SET @PlantDesc=''
			--TRUNCATE TABLE #Temp
			--INSERT INTO #Temp
			--SELECT Customer,@ReportCode AS ReportCode,@SiteDesc AS Site,@PlantDesc AS Plant,Year,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom1,@FDateTo1) AS M1,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom2,@FDateTo2) AS M2,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom3,@FDateTo3) AS M3,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom4,@FDateTo4) AS M4,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom5,@FDateTo5) AS M5,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom6,@FDateTo6) AS M6,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom7,@FDateTo7) AS M7,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom8,@FDateTo8) AS M8,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom9,@FDateTo9) AS M9,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom10,@FDateTo10) AS M10,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom11,@FDateTo11) AS M11,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom12,@FDateTo12) AS M12
			--FROM ShipmentReport_Shipped_All_Fixed_Top_20_Customer_Fiscal_By_Loc
			--WHERE Year = @Year
			--	AND Loc=@Site
			--INSERT INTO ShipmentReport_Shipped_All_Fixed_Customer_OEM
			--SELECT a.*
			--FROM #Temp a
			--WHERE NOT EXISTS(SELECT b.* FROM ShipmentReport_Shipped_All_Fixed_Customer_OEM b WHERE a.OEMCustomer+a.ReportCode+a.Site+a.Plant+a.Year=b.OEMCustomer+b.ReportCode+b.Site+b.Plant+b.Year)
			--UPDATE ShipmentReport_Shipped_All_Fixed_Customer_OEM
			--SET M1=b.M1,M2=b.M2,M3=b.M3,M4=b.M4,M5=b.M5,M6=b.M6,M7=b.M7,M8=b.M8,M9=b.M9,M10=b.M10,M11=b.M11,M12=b.M12
			--FROM ShipmentReport_Shipped_All_Fixed_Customer_OEM a,#Temp b
			--WHERE a.OEMCustomer=b.OEMCustomer
			--	AND a.ReportCode=b.ReportCode
			--	AND a.Site=b.Site
			--	AND a.Plant=b.Plant
			--	AND a.Year=b.Year
			----------------------
			--SET @OEMCustomer='Customer'
			--SET @ReportCode='993'
			--SET @Site='Ger'
			--SET @Plant=''
			--SET @SiteDesc ='Germany'
			--SET @PlantDesc=''
			--TRUNCATE TABLE #Temp
			--INSERT INTO #Temp
			--SELECT Customer,@ReportCode AS ReportCode,@SiteDesc AS Site,@PlantDesc AS Plant,Year,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom1,@DateTo1) AS M1,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom2,@DateTo2) AS M2,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom3,@DateTo3) AS M3,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom4,@DateTo4) AS M4,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom5,@DateTo5) AS M5,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom6,@DateTo6) AS M6,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom7,@DateTo7) AS M7,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom8,@DateTo8) AS M8,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom9,@DateTo9) AS M9,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom10,@DateTo10) AS M10,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom11,@DateTo11) AS M11,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom12,@DateTo12) AS M12
			--FROM ShipmentReport_Shipped_All_Fixed_Top_20_Customer_By_Loc
			--WHERE Year = @Year
			--	AND Loc=@Site
			--INSERT INTO ShipmentReport_Shipped_All_Fixed_Customer_OEM
			--SELECT a.*
			--FROM #Temp a
			--WHERE NOT EXISTS(SELECT b.* FROM ShipmentReport_Shipped_All_Fixed_Customer_OEM b WHERE a.OEMCustomer+a.ReportCode+a.Site+a.Plant+a.Year=b.OEMCustomer+b.ReportCode+b.Site+b.Plant+b.Year)
			--UPDATE ShipmentReport_Shipped_All_Fixed_Customer_OEM
			--SET M1=b.M1,M2=b.M2,M3=b.M3,M4=b.M4,M5=b.M5,M6=b.M6,M7=b.M7,M8=b.M8,M9=b.M9,M10=b.M10,M11=b.M11,M12=b.M12
			--FROM ShipmentReport_Shipped_All_Fixed_Customer_OEM a,#Temp b
			--WHERE a.OEMCustomer=b.OEMCustomer
			--	AND a.ReportCode=b.ReportCode
			--	AND a.Site=b.Site
			--	AND a.Plant=b.Plant
			--	AND a.Year=b.Year
			----------------------
			--SET @OEMCustomer='Customer'
			--SET @ReportCode='992'
			--SET @Site='Ger'
			--SET @Plant=''
			--SET @SiteDesc ='Germany'
			--SET @PlantDesc=''
			--TRUNCATE TABLE #Temp
			--INSERT INTO #Temp
			--SELECT Customer,@ReportCode AS ReportCode,@SiteDesc AS Site,@PlantDesc AS Plant,Year,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom1,@FDateTo1) AS M1,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom2,@FDateTo2) AS M2,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom3,@FDateTo3) AS M3,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom4,@FDateTo4) AS M4,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom5,@FDateTo5) AS M5,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom6,@FDateTo6) AS M6,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom7,@FDateTo7) AS M7,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom8,@FDateTo8) AS M8,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom9,@FDateTo9) AS M9,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom10,@FDateTo10) AS M10,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom11,@FDateTo11) AS M11,
			--	   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom12,@FDateTo12) AS M12
			--FROM ShipmentReport_Shipped_All_Fixed_Top_20_Customer_Fiscal_By_Loc
			--WHERE Year = @Year
			--	AND Loc=@Site
			--INSERT INTO ShipmentReport_Shipped_All_Fixed_Customer_OEM
			--SELECT a.*
			--FROM #Temp a
			--WHERE NOT EXISTS(SELECT b.* FROM ShipmentReport_Shipped_All_Fixed_Customer_OEM b WHERE a.OEMCustomer+a.ReportCode+a.Site+a.Plant+a.Year=b.OEMCustomer+b.ReportCode+b.Site+b.Plant+b.Year)
			--UPDATE ShipmentReport_Shipped_All_Fixed_Customer_OEM
			--SET M1=b.M1,M2=b.M2,M3=b.M3,M4=b.M4,M5=b.M5,M6=b.M6,M7=b.M7,M8=b.M8,M9=b.M9,M10=b.M10,M11=b.M11,M12=b.M12
			--FROM ShipmentReport_Shipped_All_Fixed_Customer_OEM a,#Temp b
			--WHERE a.OEMCustomer=b.OEMCustomer
			--	AND a.ReportCode=b.ReportCode
			--	AND a.Site=b.Site
			--	AND a.Plant=b.Plant
			--	AND a.Year=b.Year
			--------------------
			SET @OEMCustomer='Customer'
			SET @ReportCode='991'
			SET @Site='Nfd'
			SET @Plant=''
			SET @SiteDesc ='North Field'
			SET @PlantDesc=''
			TRUNCATE TABLE #Temp
			INSERT INTO #Temp
			SELECT Customer,@ReportCode AS ReportCode,@SiteDesc AS Site,@PlantDesc AS Plant,Year,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom1,@DateTo1) AS M1,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom2,@DateTo2) AS M2,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom3,@DateTo3) AS M3,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom4,@DateTo4) AS M4,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom5,@DateTo5) AS M5,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom6,@DateTo6) AS M6,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom7,@DateTo7) AS M7,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom8,@DateTo8) AS M8,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom9,@DateTo9) AS M9,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom10,@DateTo10) AS M10,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom11,@DateTo11) AS M11,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom12,@DateTo12) AS M12
			FROM ShipmentReport_Shipped_All_Fixed_Top_20_Customer_By_Loc
			WHERE Year = @Year
				AND Loc=@Site
			INSERT INTO ShipmentReport_Shipped_All_Fixed_Customer_OEM
			SELECT a.*
			FROM #Temp a
			WHERE NOT EXISTS(SELECT b.* FROM ShipmentReport_Shipped_All_Fixed_Customer_OEM b WHERE a.OEMCustomer+a.ReportCode+a.Site+a.Plant+a.Year=b.OEMCustomer+b.ReportCode+b.Site+b.Plant+b.Year)
			UPDATE ShipmentReport_Shipped_All_Fixed_Customer_OEM
			SET M1=b.M1,M2=b.M2,M3=b.M3,M4=b.M4,M5=b.M5,M6=b.M6,M7=b.M7,M8=b.M8,M9=b.M9,M10=b.M10,M11=b.M11,M12=b.M12
			FROM ShipmentReport_Shipped_All_Fixed_Customer_OEM a,#Temp b
			WHERE a.OEMCustomer=b.OEMCustomer
				AND a.ReportCode=b.ReportCode
				AND a.Site=b.Site
				AND a.Plant=b.Plant
				AND a.Year=b.Year
			--------------------
			SET @OEMCustomer='Customer'
			SET @ReportCode='990'
			SET @Site='Nfd'
			SET @Plant=''
			SET @SiteDesc ='North Field'
			SET @PlantDesc=''
			TRUNCATE TABLE #Temp
			INSERT INTO #Temp
			SELECT Customer,@ReportCode AS ReportCode,@SiteDesc AS Site,@PlantDesc AS Plant,Year,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom1,@FDateTo1) AS M1,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom2,@FDateTo2) AS M2,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom3,@FDateTo3) AS M3,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom4,@FDateTo4) AS M4,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom5,@FDateTo5) AS M5,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom6,@FDateTo6) AS M6,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom7,@FDateTo7) AS M7,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom8,@FDateTo8) AS M8,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom9,@FDateTo9) AS M9,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom10,@FDateTo10) AS M10,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom11,@FDateTo11) AS M11,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom12,@FDateTo12) AS M12
			FROM ShipmentReport_Shipped_All_Fixed_Top_20_Customer_Fiscal_By_Loc
			WHERE Year = @Year
				AND Loc=@Site
			INSERT INTO ShipmentReport_Shipped_All_Fixed_Customer_OEM
			SELECT a.*
			FROM #Temp a
			WHERE NOT EXISTS(SELECT b.* FROM ShipmentReport_Shipped_All_Fixed_Customer_OEM b WHERE a.OEMCustomer+a.ReportCode+a.Site+a.Plant+a.Year=b.OEMCustomer+b.ReportCode+b.Site+b.Plant+b.Year)
			UPDATE ShipmentReport_Shipped_All_Fixed_Customer_OEM
			SET M1=b.M1,M2=b.M2,M3=b.M3,M4=b.M4,M5=b.M5,M6=b.M6,M7=b.M7,M8=b.M8,M9=b.M9,M10=b.M10,M11=b.M11,M12=b.M12
			FROM ShipmentReport_Shipped_All_Fixed_Customer_OEM a,#Temp b
			WHERE a.OEMCustomer=b.OEMCustomer
				AND a.ReportCode=b.ReportCode
				AND a.Site=b.Site
				AND a.Plant=b.Plant
				AND a.Year=b.Year
			--------------------
			SET @OEMCustomer='Customer'
			SET @ReportCode='989'
			SET @Site='Sao'
			SET @Plant=''
			SET @SiteDesc ='Brazil'
			SET @PlantDesc=''
			TRUNCATE TABLE #Temp
			INSERT INTO #Temp
			SELECT Customer,@ReportCode AS ReportCode,@SiteDesc AS Site,@PlantDesc AS Plant,Year,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom1,@DateTo1) AS M1,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom2,@DateTo2) AS M2,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom3,@DateTo3) AS M3,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom4,@DateTo4) AS M4,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom5,@DateTo5) AS M5,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom6,@DateTo6) AS M6,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom7,@DateTo7) AS M7,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom8,@DateTo8) AS M8,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom9,@DateTo9) AS M9,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom10,@DateTo10) AS M10,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom11,@DateTo11) AS M11,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@DateFrom12,@DateTo12) AS M12
			FROM ShipmentReport_Shipped_All_Fixed_Top_20_Customer_By_Loc
			WHERE Year = @Year
				AND Loc=@Site
			INSERT INTO ShipmentReport_Shipped_All_Fixed_Customer_OEM
			SELECT a.*
			FROM #Temp a
			WHERE NOT EXISTS(SELECT b.* FROM ShipmentReport_Shipped_All_Fixed_Customer_OEM b WHERE a.OEMCustomer+a.ReportCode+a.Site+a.Plant+a.Year=b.OEMCustomer+b.ReportCode+b.Site+b.Plant+b.Year)
			UPDATE ShipmentReport_Shipped_All_Fixed_Customer_OEM
			SET M1=b.M1,M2=b.M2,M3=b.M3,M4=b.M4,M5=b.M5,M6=b.M6,M7=b.M7,M8=b.M8,M9=b.M9,M10=b.M10,M11=b.M11,M12=b.M12
			FROM ShipmentReport_Shipped_All_Fixed_Customer_OEM a,#Temp b
			WHERE a.OEMCustomer=b.OEMCustomer
				AND a.ReportCode=b.ReportCode
				AND a.Site=b.Site
				AND a.Plant=b.Plant
				AND a.Year=b.Year
			--------------------
			SET @OEMCustomer='Customer'
			SET @ReportCode='988'
			SET @Site='Sao'
			SET @Plant=''
			SET @SiteDesc ='Brazil'
			SET @PlantDesc=''
			TRUNCATE TABLE #Temp
			INSERT INTO #Temp
			SELECT Customer,@ReportCode AS ReportCode,@SiteDesc AS Site,@PlantDesc AS Plant,Year,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom1,@FDateTo1) AS M1,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom2,@FDateTo2) AS M2,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom3,@FDateTo3) AS M3,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom4,@FDateTo4) AS M4,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom5,@FDateTo5) AS M5,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom6,@FDateTo6) AS M6,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom7,@FDateTo7) AS M7,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom8,@FDateTo8) AS M8,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom9,@FDateTo9) AS M9,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom10,@FDateTo10) AS M10,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom11,@FDateTo11) AS M11,
				   dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@FDateFrom12,@FDateTo12) AS M12
			FROM ShipmentReport_Shipped_All_Fixed_Top_20_Customer_Fiscal_By_Loc
			WHERE Year = @Year
				AND Loc=@Site
			INSERT INTO ShipmentReport_Shipped_All_Fixed_Customer_OEM
			SELECT a.*
			FROM #Temp a
			WHERE NOT EXISTS(SELECT b.* FROM ShipmentReport_Shipped_All_Fixed_Customer_OEM b WHERE a.OEMCustomer+a.ReportCode+a.Site+a.Plant+a.Year=b.OEMCustomer+b.ReportCode+b.Site+b.Plant+b.Year)
			UPDATE ShipmentReport_Shipped_All_Fixed_Customer_OEM
			SET M1=b.M1,M2=b.M2,M3=b.M3,M4=b.M4,M5=b.M5,M6=b.M6,M7=b.M7,M8=b.M8,M9=b.M9,M10=b.M10,M11=b.M11,M12=b.M12
			FROM ShipmentReport_Shipped_All_Fixed_Customer_OEM a,#Temp b
			WHERE a.OEMCustomer=b.OEMCustomer
				AND a.ReportCode=b.ReportCode
				AND a.Site=b.Site
				AND a.Plant=b.Plant
				AND a.Year=b.Year

		SET @i=@i+1
	END
END
GO
