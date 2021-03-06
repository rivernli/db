USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[DistributionReport_sp_AutomaticallyProcess_Location_Fiscal]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DistributionReport_sp_AutomaticallyProcess_Location_Fiscal]
	-- Add the parameters for the stored procedure here
	@Type VARCHAR(10),
	@CalculateYear INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SET NOCOUNT ON;

    DECLARE @Year CHAR(4),@i INT,@j INT,@k INT,@SQLString VARCHAR(MAX),@Color VARCHAR(50),@DateFrom DATETIME,@DateTo DATETIME ,@NowMonth INT,
			@Amount BIGINT,@Site VARCHAR(50),@Plant VARCHAR(50),@Lay INT,@OEMCustomer VARCHAR(500),@OEM VARCHAR(500),@ReportCode CHAR(3),@SumCustomer VARCHAR(MAX),@SumOEM VARCHAR(MAX),
			@DateFrom1 DATETIME,@DateTo1 DATETIME,@DateFrom2 DATETIME,@DateTo2 DATETIME,@DateFrom3 DATETIME,@DateTo3 DATETIME,
			@DateFrom4 DATETIME,@DateTo4 DATETIME,@DateFrom5 DATETIME,@DateTo5 DATETIME,@DateFrom6 DATETIME,@DateTo6 DATETIME,
			@DateFrom7 DATETIME,@DateTo7 DATETIME,@DateFrom8 DATETIME,@DateTo8 DATETIME,@DateFrom9 DATETIME,@DateTo9 DATETIME,
			@DateFrom10 DATETIME,@DateTo10 DATETIME,@DateFrom11 DATETIME,@DateTo11 DATETIME,@DateFrom12 DATETIME,@DateTo12 DATETIME			
	DECLARE @Option VARCHAR(20)
	SET @Option='FiscalPeriod'
	
	CREATE TABLE #Temp  (Country VARCHAR(100))

	--We calculate only two calendar months
	--SET @SQLString=''
	SET @Year=CONVERT(VARCHAR(4),GETDATE()-1,120)
	SET @i=1
	WHILE @i<=@CalculateYear
		BEGIN

			SET @Year=(SELECT MAX(Year) FROM dbo.DistributionReport_Fiscal_Year)-(@i-1)--CONVERT(CHAR(4),DATEADD(YEAR,-@i+1,GETDATE()-1),120)
			SET @DateFrom=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=1) 
			SET @DateTo=(SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=12) 

			SET @DateFrom1=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=1) 
			SET @DateTo1=(SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=1) 
			SET @DateFrom2=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=2) 
			SET @DateTo2=(SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=2) 
			SET @DateFrom3=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=3) 
			SET @DateTo3=(SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=3) 
			SET @DateFrom4=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=4) 
			SET @DateTo4=(SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=4) 
			SET @DateFrom5=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=5) 
			SET @DateTo5=(SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=5) 
			SET @DateFrom6=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=6) 
			SET @DateTo6=(SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=6) 
			SET @DateFrom7=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=7) 
			SET @DateTo7=(SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=7) 
			SET @DateFrom8=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=8) 
			SET @DateTo8=(SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=8) 
			SET @DateFrom9=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=9) 
			SET @DateTo9=(SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=9) 
			SET @DateFrom10=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=10) 
			SET @DateTo10=(SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=10) 
			SET @DateFrom11=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=11) 
			SET @DateTo11=(SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=11) 
			SET @DateFrom12=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=12) 
			SET @DateTo12=(SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=12) 

			-- ReportCode:001 Process HubIn Monthly Calendar Trend  Code:0001
			SET @ReportCode='002'
			SET @Site='Chi'
			SET @Plant='P2'
			TRUNCATE TABLE #Temp
			INSERT INTO #Temp
			SELECT * FROM dbo.DistributionReport_fun_Get_Location(@Option,@Type,@Site,@Plant,@DateFrom1,@DateTo12)		
			INSERT INTO DistributionReport_Location_Amount (ReportCode,Type,Site,Plant,Year,Country)
			SELECT @ReportCode AS ReportCode,@Type AS Type,@Site AS Site,@Plant AS Plant,@Year AS Year,a.Country 
			FROM #Temp a
			WHERE NOT EXISTS(SELECT b.* FROM DistributionReport_Location_Amount b WHERE b.ReportCode+b.Type+b.Site+b.Plant+b.Country+b.Year=@ReportCode+@Type+@Site+@Plant+a.Country+@Year)
			
			UPDATE DistributionReport_Location_Amount
			SET M1=dbo.DistributionReport_fun_Get_Amount_Location (@Option,@Type,@Site,@Plant,Country,@DateFrom1,@DateTo1),
				M2=dbo.DistributionReport_fun_Get_Amount_Location (@Option,@Type,@Site,@Plant,Country,@DateFrom2,@DateTo2),
				M3=dbo.DistributionReport_fun_Get_Amount_Location (@Option,@Type,@Site,@Plant,Country,@DateFrom3,@DateTo3),
				M4=dbo.DistributionReport_fun_Get_Amount_Location (@Option,@Type,@Site,@Plant,Country,@DateFrom4,@DateTo4),
				M5=dbo.DistributionReport_fun_Get_Amount_Location (@Option,@Type,@Site,@Plant,Country,@DateFrom5,@DateTo5),
				M6=dbo.DistributionReport_fun_Get_Amount_Location (@Option,@Type,@Site,@Plant,Country,@DateFrom6,@DateTo6),
				M7=dbo.DistributionReport_fun_Get_Amount_Location (@Option,@Type,@Site,@Plant,Country,@DateFrom7,@DateTo7),
				M8=dbo.DistributionReport_fun_Get_Amount_Location (@Option,@Type,@Site,@Plant,Country,@DateFrom8,@DateTo8),
				M9=dbo.DistributionReport_fun_Get_Amount_Location (@Option,@Type,@Site,@Plant,Country,@DateFrom9,@DateTo9),
				M10=dbo.DistributionReport_fun_Get_Amount_Location (@Option,@Type,@Site,@Plant,Country,@DateFrom10,@DateTo10),
				M11=dbo.DistributionReport_fun_Get_Amount_Location (@Option,@Type,@Site,@Plant,Country,@DateFrom11,@DateTo11),
				M12=dbo.DistributionReport_fun_Get_Amount_Location (@Option,@Type,@Site,@Plant,Country,@DateFrom12,@DateTo12)
			WHERE ReportCode=@ReportCode
				AND Type=@Type
				AND Site=@Site
				AND Plant=@Plant
				AND YEAR=@Year
			SET @Plant='2F'
			TRUNCATE TABLE #Temp
			INSERT INTO #Temp
			SELECT * FROM dbo.DistributionReport_fun_Get_Location(@Option,@Type,@Site,@Plant,@DateFrom1,@DateTo12)		
			INSERT INTO DistributionReport_Location_Amount (ReportCode,Type,Site,Plant,Year,Country)
			SELECT @ReportCode AS ReportCode,@Type AS Type,@Site AS Site,@Plant AS Plant,@Year AS Year,a.Country 
			FROM #Temp a
			WHERE NOT EXISTS(SELECT b.* FROM DistributionReport_Location_Amount b WHERE b.ReportCode+b.Type+b.Site+b.Plant+b.Country+b.Year=@ReportCode+@Type+@Site+@Plant+a.Country+@Year)
			
			UPDATE DistributionReport_Location_Amount
			SET M1=dbo.DistributionReport_fun_Get_Amount_Location (@Option,@Type,@Site,@Plant,Country,@DateFrom1,@DateTo1),
				M2=dbo.DistributionReport_fun_Get_Amount_Location (@Option,@Type,@Site,@Plant,Country,@DateFrom2,@DateTo2),
				M3=dbo.DistributionReport_fun_Get_Amount_Location (@Option,@Type,@Site,@Plant,Country,@DateFrom3,@DateTo3),
				M4=dbo.DistributionReport_fun_Get_Amount_Location (@Option,@Type,@Site,@Plant,Country,@DateFrom4,@DateTo4),
				M5=dbo.DistributionReport_fun_Get_Amount_Location (@Option,@Type,@Site,@Plant,Country,@DateFrom5,@DateTo5),
				M6=dbo.DistributionReport_fun_Get_Amount_Location (@Option,@Type,@Site,@Plant,Country,@DateFrom6,@DateTo6),
				M7=dbo.DistributionReport_fun_Get_Amount_Location (@Option,@Type,@Site,@Plant,Country,@DateFrom7,@DateTo7),
				M8=dbo.DistributionReport_fun_Get_Amount_Location (@Option,@Type,@Site,@Plant,Country,@DateFrom8,@DateTo8),
				M9=dbo.DistributionReport_fun_Get_Amount_Location (@Option,@Type,@Site,@Plant,Country,@DateFrom9,@DateTo9),
				M10=dbo.DistributionReport_fun_Get_Amount_Location (@Option,@Type,@Site,@Plant,Country,@DateFrom10,@DateTo10),
				M11=dbo.DistributionReport_fun_Get_Amount_Location (@Option,@Type,@Site,@Plant,Country,@DateFrom11,@DateTo11),
				M12=dbo.DistributionReport_fun_Get_Amount_Location (@Option,@Type,@Site,@Plant,Country,@DateFrom12,@DateTo12)
			WHERE ReportCode=@ReportCode
				AND Type=@Type
				AND Site=@Site
				AND Plant=@Plant
				AND YEAR=@Year
			SET @Plant='B3'
			TRUNCATE TABLE #Temp
			INSERT INTO #Temp
			SELECT * FROM dbo.DistributionReport_fun_Get_Location(@Option,@Type,@Site,@Plant,@DateFrom1,@DateTo12)		
			INSERT INTO DistributionReport_Location_Amount (ReportCode,Type,Site,Plant,Year,Country)
			SELECT @ReportCode AS ReportCode,@Type AS Type,@Site AS Site,@Plant AS Plant,@Year AS Year,a.Country 
			FROM #Temp a
			WHERE NOT EXISTS(SELECT b.* FROM DistributionReport_Location_Amount b WHERE b.ReportCode+b.Type+b.Site+b.Plant+b.Country+b.Year=@ReportCode+@Type+@Site+@Plant+a.Country+@Year)
			
			UPDATE DistributionReport_Location_Amount
			SET M1=dbo.DistributionReport_fun_Get_Amount_Location (@Option,@Type,@Site,@Plant,Country,@DateFrom1,@DateTo1),
				M2=dbo.DistributionReport_fun_Get_Amount_Location (@Option,@Type,@Site,@Plant,Country,@DateFrom2,@DateTo2),
				M3=dbo.DistributionReport_fun_Get_Amount_Location (@Option,@Type,@Site,@Plant,Country,@DateFrom3,@DateTo3),
				M4=dbo.DistributionReport_fun_Get_Amount_Location (@Option,@Type,@Site,@Plant,Country,@DateFrom4,@DateTo4),
				M5=dbo.DistributionReport_fun_Get_Amount_Location (@Option,@Type,@Site,@Plant,Country,@DateFrom5,@DateTo5),
				M6=dbo.DistributionReport_fun_Get_Amount_Location (@Option,@Type,@Site,@Plant,Country,@DateFrom6,@DateTo6),
				M7=dbo.DistributionReport_fun_Get_Amount_Location (@Option,@Type,@Site,@Plant,Country,@DateFrom7,@DateTo7),
				M8=dbo.DistributionReport_fun_Get_Amount_Location (@Option,@Type,@Site,@Plant,Country,@DateFrom8,@DateTo8),
				M9=dbo.DistributionReport_fun_Get_Amount_Location (@Option,@Type,@Site,@Plant,Country,@DateFrom9,@DateTo9),
				M10=dbo.DistributionReport_fun_Get_Amount_Location (@Option,@Type,@Site,@Plant,Country,@DateFrom10,@DateTo10),
				M11=dbo.DistributionReport_fun_Get_Amount_Location (@Option,@Type,@Site,@Plant,Country,@DateFrom11,@DateTo11),
				M12=dbo.DistributionReport_fun_Get_Amount_Location (@Option,@Type,@Site,@Plant,Country,@DateFrom12,@DateTo12)
			WHERE ReportCode=@ReportCode
				AND Type=@Type
				AND Site=@Site
				AND Plant=@Plant
				AND YEAR=@Year
			SET @Plant='B4'
			TRUNCATE TABLE #Temp
			INSERT INTO #Temp
			SELECT * FROM dbo.DistributionReport_fun_Get_Location(@Option,@Type,@Site,@Plant,@DateFrom1,@DateTo12)		
			INSERT INTO DistributionReport_Location_Amount (ReportCode,Type,Site,Plant,Year,Country)
			SELECT @ReportCode AS ReportCode,@Type AS Type,@Site AS Site,@Plant AS Plant,@Year AS Year,a.Country 
			FROM #Temp a
			WHERE NOT EXISTS(SELECT b.* FROM DistributionReport_Location_Amount b WHERE b.ReportCode+b.Type+b.Site+b.Plant+b.Country+b.Year=@ReportCode+@Type+@Site+@Plant+a.Country+@Year)
			
			UPDATE DistributionReport_Location_Amount
			SET M1=dbo.DistributionReport_fun_Get_Amount_Location (@Option,@Type,@Site,@Plant,Country,@DateFrom1,@DateTo1),
				M2=dbo.DistributionReport_fun_Get_Amount_Location (@Option,@Type,@Site,@Plant,Country,@DateFrom2,@DateTo2),
				M3=dbo.DistributionReport_fun_Get_Amount_Location (@Option,@Type,@Site,@Plant,Country,@DateFrom3,@DateTo3),
				M4=dbo.DistributionReport_fun_Get_Amount_Location (@Option,@Type,@Site,@Plant,Country,@DateFrom4,@DateTo4),
				M5=dbo.DistributionReport_fun_Get_Amount_Location (@Option,@Type,@Site,@Plant,Country,@DateFrom5,@DateTo5),
				M6=dbo.DistributionReport_fun_Get_Amount_Location (@Option,@Type,@Site,@Plant,Country,@DateFrom6,@DateTo6),
				M7=dbo.DistributionReport_fun_Get_Amount_Location (@Option,@Type,@Site,@Plant,Country,@DateFrom7,@DateTo7),
				M8=dbo.DistributionReport_fun_Get_Amount_Location (@Option,@Type,@Site,@Plant,Country,@DateFrom8,@DateTo8),
				M9=dbo.DistributionReport_fun_Get_Amount_Location (@Option,@Type,@Site,@Plant,Country,@DateFrom9,@DateTo9),
				M10=dbo.DistributionReport_fun_Get_Amount_Location (@Option,@Type,@Site,@Plant,Country,@DateFrom10,@DateTo10),
				M11=dbo.DistributionReport_fun_Get_Amount_Location (@Option,@Type,@Site,@Plant,Country,@DateFrom11,@DateTo11),
				M12=dbo.DistributionReport_fun_Get_Amount_Location (@Option,@Type,@Site,@Plant,Country,@DateFrom12,@DateTo12)
			WHERE ReportCode=@ReportCode
				AND Type=@Type
				AND Site=@Site
				AND Plant=@Plant
				AND YEAR=@Year
			SET @Plant='B5'
			TRUNCATE TABLE #Temp
			INSERT INTO #Temp
			SELECT * FROM dbo.DistributionReport_fun_Get_Location(@Option,@Type,@Site,@Plant,@DateFrom1,@DateTo12)		
			INSERT INTO DistributionReport_Location_Amount (ReportCode,Type,Site,Plant,Year,Country)
			SELECT @ReportCode AS ReportCode,@Type AS Type,@Site AS Site,@Plant AS Plant,@Year AS Year,a.Country 
			FROM #Temp a
			WHERE NOT EXISTS(SELECT b.* FROM DistributionReport_Location_Amount b WHERE b.ReportCode+b.Type+b.Site+b.Plant+b.Country+b.Year=@ReportCode+@Type+@Site+@Plant+a.Country+@Year)
			
			UPDATE DistributionReport_Location_Amount
			SET M1=dbo.DistributionReport_fun_Get_Amount_Location (@Option,@Type,@Site,@Plant,Country,@DateFrom1,@DateTo1),
				M2=dbo.DistributionReport_fun_Get_Amount_Location (@Option,@Type,@Site,@Plant,Country,@DateFrom2,@DateTo2),
				M3=dbo.DistributionReport_fun_Get_Amount_Location (@Option,@Type,@Site,@Plant,Country,@DateFrom3,@DateTo3),
				M4=dbo.DistributionReport_fun_Get_Amount_Location (@Option,@Type,@Site,@Plant,Country,@DateFrom4,@DateTo4),
				M5=dbo.DistributionReport_fun_Get_Amount_Location (@Option,@Type,@Site,@Plant,Country,@DateFrom5,@DateTo5),
				M6=dbo.DistributionReport_fun_Get_Amount_Location (@Option,@Type,@Site,@Plant,Country,@DateFrom6,@DateTo6),
				M7=dbo.DistributionReport_fun_Get_Amount_Location (@Option,@Type,@Site,@Plant,Country,@DateFrom7,@DateTo7),
				M8=dbo.DistributionReport_fun_Get_Amount_Location (@Option,@Type,@Site,@Plant,Country,@DateFrom8,@DateTo8),
				M9=dbo.DistributionReport_fun_Get_Amount_Location (@Option,@Type,@Site,@Plant,Country,@DateFrom9,@DateTo9),
				M10=dbo.DistributionReport_fun_Get_Amount_Location (@Option,@Type,@Site,@Plant,Country,@DateFrom10,@DateTo10),
				M11=dbo.DistributionReport_fun_Get_Amount_Location (@Option,@Type,@Site,@Plant,Country,@DateFrom11,@DateTo11),
				M12=dbo.DistributionReport_fun_Get_Amount_Location (@Option,@Type,@Site,@Plant,Country,@DateFrom12,@DateTo12)
			WHERE ReportCode=@ReportCode
				AND Type=@Type
				AND Site=@Site
				AND Plant=@Plant
				AND YEAR=@Year
			SET @Plant='HK'
			TRUNCATE TABLE #Temp
			INSERT INTO #Temp
			SELECT * FROM dbo.DistributionReport_fun_Get_Location(@Option,@Type,@Site,@Plant,@DateFrom1,@DateTo12)		
			INSERT INTO DistributionReport_Location_Amount (ReportCode,Type,Site,Plant,Year,Country)
			SELECT @ReportCode AS ReportCode,@Type AS Type,@Site AS Site,@Plant AS Plant,@Year AS Year,a.Country 
			FROM #Temp a
			WHERE NOT EXISTS(SELECT b.* FROM DistributionReport_Location_Amount b WHERE b.ReportCode+b.Type+b.Site+b.Plant+b.Country+b.Year=@ReportCode+@Type+@Site+@Plant+a.Country+@Year)
			
			UPDATE DistributionReport_Location_Amount
			SET M1=dbo.DistributionReport_fun_Get_Amount_Location (@Option,@Type,@Site,@Plant,Country,@DateFrom1,@DateTo1),
				M2=dbo.DistributionReport_fun_Get_Amount_Location (@Option,@Type,@Site,@Plant,Country,@DateFrom2,@DateTo2),
				M3=dbo.DistributionReport_fun_Get_Amount_Location (@Option,@Type,@Site,@Plant,Country,@DateFrom3,@DateTo3),
				M4=dbo.DistributionReport_fun_Get_Amount_Location (@Option,@Type,@Site,@Plant,Country,@DateFrom4,@DateTo4),
				M5=dbo.DistributionReport_fun_Get_Amount_Location (@Option,@Type,@Site,@Plant,Country,@DateFrom5,@DateTo5),
				M6=dbo.DistributionReport_fun_Get_Amount_Location (@Option,@Type,@Site,@Plant,Country,@DateFrom6,@DateTo6),
				M7=dbo.DistributionReport_fun_Get_Amount_Location (@Option,@Type,@Site,@Plant,Country,@DateFrom7,@DateTo7),
				M8=dbo.DistributionReport_fun_Get_Amount_Location (@Option,@Type,@Site,@Plant,Country,@DateFrom8,@DateTo8),
				M9=dbo.DistributionReport_fun_Get_Amount_Location (@Option,@Type,@Site,@Plant,Country,@DateFrom9,@DateTo9),
				M10=dbo.DistributionReport_fun_Get_Amount_Location (@Option,@Type,@Site,@Plant,Country,@DateFrom10,@DateTo10),
				M11=dbo.DistributionReport_fun_Get_Amount_Location (@Option,@Type,@Site,@Plant,Country,@DateFrom11,@DateTo11),
				M12=dbo.DistributionReport_fun_Get_Amount_Location (@Option,@Type,@Site,@Plant,Country,@DateFrom12,@DateTo12)
			WHERE ReportCode=@ReportCode
				AND Type=@Type
				AND Site=@Site
				AND Plant=@Plant
				AND YEAR=@Year
			
			SET @Year=@Year-1
			SET @i=@i+1
		END

		INSERT INTO DistributionReport_Location_Amount (ReportCode,TYPE,Site,Plant,Country,Year)
		SELECT '003' AS ReportCode,a.TYPE,a.Site,a.Plant,a.Country,a.Year
		FROM (
				SELECT TYPE,Site,Plant,Country,Year
				FROM DistributionReport_Location_Amount
				WHERE ReportCode='002'
					AND Type=@Type
				GROUP BY TYPE,Site,Plant,Country,Year
			 ) a
		WHERE NOT EXISTS(
							SELECT b.* 
							FROM DistributionReport_Location_Amount b 
							WHERE ReportCode='003' 
								AND b.Type=@Type
								AND b.Site=a.Site
								AND b.Plant=a.Plant
								AND b.Country=a.Country
								AND b.Year=a.Year
						)
						
		UPDATE DistributionReport_Location_Amount
		SET M1=(	
					SELECT SUM(M1)+SUM(M2)+SUM(M3) 
					FROM DistributionReport_Location_Amount a 
					WHERE a.ReportCode='002'
						AND a.Type=@Type
						AND a.Site=DistributionReport_Location_Amount.Site
						AND a.Plant=DistributionReport_Location_Amount.Plant
						AND a.Country=DistributionReport_Location_Amount.Country
						AND a.Year=DistributionReport_Location_Amount.Year
				),
			M2=(	
					SELECT SUM(M4)+SUM(M5)+SUM(M6) 
					FROM DistributionReport_Location_Amount a 
					WHERE a.ReportCode='002'
						AND a.Type=@Type
						AND a.Site=DistributionReport_Location_Amount.Site
						AND a.Plant=DistributionReport_Location_Amount.Plant
						AND a.Country=DistributionReport_Location_Amount.Country
						AND a.Year=DistributionReport_Location_Amount.Year
				),
			M3=(	
					SELECT SUM(M7)+SUM(M8)+SUM(M9) 
					FROM DistributionReport_Location_Amount a 
					WHERE a.ReportCode='002'
						AND a.Type=@Type
						AND a.Site=DistributionReport_Location_Amount.Site
						AND a.Plant=DistributionReport_Location_Amount.Plant
						AND a.Country=DistributionReport_Location_Amount.Country
						AND a.Year=DistributionReport_Location_Amount.Year
				),
			M4=(	
					SELECT SUM(M10)+SUM(M11)+SUM(M12) 
					FROM DistributionReport_Location_Amount a 
					WHERE a.ReportCode='002'
						AND a.Type=@Type
						AND a.Site=DistributionReport_Location_Amount.Site
						AND a.Plant=DistributionReport_Location_Amount.Plant
						AND a.Country=DistributionReport_Location_Amount.Country
						AND a.Year=DistributionReport_Location_Amount.Year
				),
			M5=0,M6=0,M7=0,M8=0,M9=0,M10=0,M11=0,M12=0
		WHERE ReportCode='003'
			AND Type=@Type

		UPDATE DistributionReport_Location_Amount
		SET Amount=M1+M2+M3+M4+M5+M6+M7+M8+M9+M10+M11+M12
END
GO
