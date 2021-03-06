USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[DistributionReport_sp_AutomaticallyProcess_RMA_Technics_Calendar]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DistributionReport_sp_AutomaticallyProcess_RMA_Technics_Calendar]
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
	DECLARE @Option VARCHAR(10)
	SET @Option='Calendar'
	
	CREATE TABLE #Temp  (Technics VARCHAR(1))

	--We calculate only two calendar months
	--SET @SQLString=''
	SET @i=1
	WHILE @i<=@CalculateYear
		BEGIN

			SET @Year=CONVERT(CHAR(4),DATEADD(YEAR,-@i+1,GETDATE()-1),120)
			SET @DateFrom=@Year+'-01-01'
			SET @DateTo=DATEADD(YEAR,1,@DateFrom)-1

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

			-- ReportCode:001 Process HubIn Monthly Calendar Trend  Code:0001
			SET @ReportCode='001'
			SET @Site='Chi'
			SET @Plant='P2'
			TRUNCATE TABLE #Temp
			INSERT INTO #Temp
			SELECT * FROM dbo.DistributionReport_fun_Get_Technics(@Option,@Type,@Site,@Plant,@DateFrom1,@DateTo12)		
			INSERT INTO DistributionReport_Technics_Amount (ReportCode,Type,Site,Plant,Year,Technics)
			SELECT @ReportCode AS ReportCode,@Type AS Type,@Site AS Site,@Plant AS Plant,@Year AS Year,a.Technics 
			FROM #Temp a
			WHERE NOT EXISTS(SELECT b.* FROM DistributionReport_Technics_Amount b WHERE b.ReportCode+b.Type+b.Site+b.Plant+b.Technics+b.Year=@ReportCode+@Type+@Site+@Plant+a.Technics+@Year)
			
			UPDATE DistributionReport_Technics_Amount
			SET M1=dbo.DistributionReport_fun_Get_Amount_Technics (@Option,@Type,@Site,@Plant,Technics,@DateFrom1,@DateTo1),
				M2=dbo.DistributionReport_fun_Get_Amount_Technics (@Option,@Type,@Site,@Plant,Technics,@DateFrom2,@DateTo2),
				M3=dbo.DistributionReport_fun_Get_Amount_Technics (@Option,@Type,@Site,@Plant,Technics,@DateFrom3,@DateTo3),
				M4=dbo.DistributionReport_fun_Get_Amount_Technics (@Option,@Type,@Site,@Plant,Technics,@DateFrom4,@DateTo4),
				M5=dbo.DistributionReport_fun_Get_Amount_Technics (@Option,@Type,@Site,@Plant,Technics,@DateFrom5,@DateTo5),
				M6=dbo.DistributionReport_fun_Get_Amount_Technics (@Option,@Type,@Site,@Plant,Technics,@DateFrom6,@DateTo6),
				M7=dbo.DistributionReport_fun_Get_Amount_Technics (@Option,@Type,@Site,@Plant,Technics,@DateFrom7,@DateTo7),
				M8=dbo.DistributionReport_fun_Get_Amount_Technics (@Option,@Type,@Site,@Plant,Technics,@DateFrom8,@DateTo8),
				M9=dbo.DistributionReport_fun_Get_Amount_Technics (@Option,@Type,@Site,@Plant,Technics,@DateFrom9,@DateTo9),
				M10=dbo.DistributionReport_fun_Get_Amount_Technics (@Option,@Type,@Site,@Plant,Technics,@DateFrom10,@DateTo10),
				M11=dbo.DistributionReport_fun_Get_Amount_Technics (@Option,@Type,@Site,@Plant,Technics,@DateFrom11,@DateTo11),
				M12=dbo.DistributionReport_fun_Get_Amount_Technics (@Option,@Type,@Site,@Plant,Technics,@DateFrom12,@DateTo12)
			WHERE ReportCode=@ReportCode
				AND Type=@Type
				AND Site=@Site
				AND Plant=@Plant
				AND YEAR=@Year
			SET @Plant='2F'
			TRUNCATE TABLE #Temp
			INSERT INTO #Temp
			SELECT * FROM dbo.DistributionReport_fun_Get_Technics(@Option,@Type,@Site,@Plant,@DateFrom1,@DateTo12)		
			INSERT INTO DistributionReport_Technics_Amount (ReportCode,Type,Site,Plant,Year,Technics)
			SELECT @ReportCode AS ReportCode,@Type AS Type,@Site AS Site,@Plant AS Plant,@Year AS Year,a.Technics 
			FROM #Temp a
			WHERE NOT EXISTS(SELECT b.* FROM DistributionReport_Technics_Amount b WHERE b.ReportCode+b.Type+b.Site+b.Plant+b.Technics+b.Year=@ReportCode+@Type+@Site+@Plant+a.Technics+@Year)
			
			UPDATE DistributionReport_Technics_Amount
			SET M1=dbo.DistributionReport_fun_Get_Amount_Technics (@Option,@Type,@Site,@Plant,Technics,@DateFrom1,@DateTo1),
				M2=dbo.DistributionReport_fun_Get_Amount_Technics (@Option,@Type,@Site,@Plant,Technics,@DateFrom2,@DateTo2),
				M3=dbo.DistributionReport_fun_Get_Amount_Technics (@Option,@Type,@Site,@Plant,Technics,@DateFrom3,@DateTo3),
				M4=dbo.DistributionReport_fun_Get_Amount_Technics (@Option,@Type,@Site,@Plant,Technics,@DateFrom4,@DateTo4),
				M5=dbo.DistributionReport_fun_Get_Amount_Technics (@Option,@Type,@Site,@Plant,Technics,@DateFrom5,@DateTo5),
				M6=dbo.DistributionReport_fun_Get_Amount_Technics (@Option,@Type,@Site,@Plant,Technics,@DateFrom6,@DateTo6),
				M7=dbo.DistributionReport_fun_Get_Amount_Technics (@Option,@Type,@Site,@Plant,Technics,@DateFrom7,@DateTo7),
				M8=dbo.DistributionReport_fun_Get_Amount_Technics (@Option,@Type,@Site,@Plant,Technics,@DateFrom8,@DateTo8),
				M9=dbo.DistributionReport_fun_Get_Amount_Technics (@Option,@Type,@Site,@Plant,Technics,@DateFrom9,@DateTo9),
				M10=dbo.DistributionReport_fun_Get_Amount_Technics (@Option,@Type,@Site,@Plant,Technics,@DateFrom10,@DateTo10),
				M11=dbo.DistributionReport_fun_Get_Amount_Technics (@Option,@Type,@Site,@Plant,Technics,@DateFrom11,@DateTo11),
				M12=dbo.DistributionReport_fun_Get_Amount_Technics (@Option,@Type,@Site,@Plant,Technics,@DateFrom12,@DateTo12)
			WHERE ReportCode=@ReportCode
				AND Type=@Type
				AND Site=@Site
				AND Plant=@Plant
				AND YEAR=@Year
			SET @Plant='B3'
			TRUNCATE TABLE #Temp
			INSERT INTO #Temp
			SELECT * FROM dbo.DistributionReport_fun_Get_Technics(@Option,@Type,@Site,@Plant,@DateFrom1,@DateTo12)		
			INSERT INTO DistributionReport_Technics_Amount (ReportCode,Type,Site,Plant,Year,Technics)
			SELECT @ReportCode AS ReportCode,@Type AS Type,@Site AS Site,@Plant AS Plant,@Year AS Year,a.Technics 
			FROM #Temp a
			WHERE NOT EXISTS(SELECT b.* FROM DistributionReport_Technics_Amount b WHERE b.ReportCode+b.Type+b.Site+b.Plant+b.Technics+b.Year=@ReportCode+@Type+@Site+@Plant+a.Technics+@Year)
			
			UPDATE DistributionReport_Technics_Amount
			SET M1=dbo.DistributionReport_fun_Get_Amount_Technics (@Option,@Type,@Site,@Plant,Technics,@DateFrom1,@DateTo1),
				M2=dbo.DistributionReport_fun_Get_Amount_Technics (@Option,@Type,@Site,@Plant,Technics,@DateFrom2,@DateTo2),
				M3=dbo.DistributionReport_fun_Get_Amount_Technics (@Option,@Type,@Site,@Plant,Technics,@DateFrom3,@DateTo3),
				M4=dbo.DistributionReport_fun_Get_Amount_Technics (@Option,@Type,@Site,@Plant,Technics,@DateFrom4,@DateTo4),
				M5=dbo.DistributionReport_fun_Get_Amount_Technics (@Option,@Type,@Site,@Plant,Technics,@DateFrom5,@DateTo5),
				M6=dbo.DistributionReport_fun_Get_Amount_Technics (@Option,@Type,@Site,@Plant,Technics,@DateFrom6,@DateTo6),
				M7=dbo.DistributionReport_fun_Get_Amount_Technics (@Option,@Type,@Site,@Plant,Technics,@DateFrom7,@DateTo7),
				M8=dbo.DistributionReport_fun_Get_Amount_Technics (@Option,@Type,@Site,@Plant,Technics,@DateFrom8,@DateTo8),
				M9=dbo.DistributionReport_fun_Get_Amount_Technics (@Option,@Type,@Site,@Plant,Technics,@DateFrom9,@DateTo9),
				M10=dbo.DistributionReport_fun_Get_Amount_Technics (@Option,@Type,@Site,@Plant,Technics,@DateFrom10,@DateTo10),
				M11=dbo.DistributionReport_fun_Get_Amount_Technics (@Option,@Type,@Site,@Plant,Technics,@DateFrom11,@DateTo11),
				M12=dbo.DistributionReport_fun_Get_Amount_Technics (@Option,@Type,@Site,@Plant,Technics,@DateFrom12,@DateTo12)
			WHERE ReportCode=@ReportCode
				AND Type=@Type
				AND Site=@Site
				AND Plant=@Plant
				AND YEAR=@Year
			SET @Plant='B4'
			TRUNCATE TABLE #Temp
			INSERT INTO #Temp
			SELECT * FROM dbo.DistributionReport_fun_Get_Technics(@Option,@Type,@Site,@Plant,@DateFrom1,@DateTo12)		
			INSERT INTO DistributionReport_Technics_Amount (ReportCode,Type,Site,Plant,Year,Technics)
			SELECT @ReportCode AS ReportCode,@Type AS Type,@Site AS Site,@Plant AS Plant,@Year AS Year,a.Technics 
			FROM #Temp a
			WHERE NOT EXISTS(SELECT b.* FROM DistributionReport_Technics_Amount b WHERE b.ReportCode+b.Type+b.Site+b.Plant+b.Technics+b.Year=@ReportCode+@Type+@Site+@Plant+a.Technics+@Year)
			
			UPDATE DistributionReport_Technics_Amount
			SET M1=dbo.DistributionReport_fun_Get_Amount_Technics (@Option,@Type,@Site,@Plant,Technics,@DateFrom1,@DateTo1),
				M2=dbo.DistributionReport_fun_Get_Amount_Technics (@Option,@Type,@Site,@Plant,Technics,@DateFrom2,@DateTo2),
				M3=dbo.DistributionReport_fun_Get_Amount_Technics (@Option,@Type,@Site,@Plant,Technics,@DateFrom3,@DateTo3),
				M4=dbo.DistributionReport_fun_Get_Amount_Technics (@Option,@Type,@Site,@Plant,Technics,@DateFrom4,@DateTo4),
				M5=dbo.DistributionReport_fun_Get_Amount_Technics (@Option,@Type,@Site,@Plant,Technics,@DateFrom5,@DateTo5),
				M6=dbo.DistributionReport_fun_Get_Amount_Technics (@Option,@Type,@Site,@Plant,Technics,@DateFrom6,@DateTo6),
				M7=dbo.DistributionReport_fun_Get_Amount_Technics (@Option,@Type,@Site,@Plant,Technics,@DateFrom7,@DateTo7),
				M8=dbo.DistributionReport_fun_Get_Amount_Technics (@Option,@Type,@Site,@Plant,Technics,@DateFrom8,@DateTo8),
				M9=dbo.DistributionReport_fun_Get_Amount_Technics (@Option,@Type,@Site,@Plant,Technics,@DateFrom9,@DateTo9),
				M10=dbo.DistributionReport_fun_Get_Amount_Technics (@Option,@Type,@Site,@Plant,Technics,@DateFrom10,@DateTo10),
				M11=dbo.DistributionReport_fun_Get_Amount_Technics (@Option,@Type,@Site,@Plant,Technics,@DateFrom11,@DateTo11),
				M12=dbo.DistributionReport_fun_Get_Amount_Technics (@Option,@Type,@Site,@Plant,Technics,@DateFrom12,@DateTo12)
			WHERE ReportCode=@ReportCode
				AND Type=@Type
				AND Site=@Site
				AND Plant=@Plant
				AND YEAR=@Year
			SET @Plant='B5'
			TRUNCATE TABLE #Temp
			INSERT INTO #Temp
			SELECT * FROM dbo.DistributionReport_fun_Get_Technics(@Option,@Type,@Site,@Plant,@DateFrom1,@DateTo12)		
			INSERT INTO DistributionReport_Technics_Amount (ReportCode,Type,Site,Plant,Year,Technics)
			SELECT @ReportCode AS ReportCode,@Type AS Type,@Site AS Site,@Plant AS Plant,@Year AS Year,a.Technics 
			FROM #Temp a
			WHERE NOT EXISTS(SELECT b.* FROM DistributionReport_Technics_Amount b WHERE b.ReportCode+b.Type+b.Site+b.Plant+b.Technics+b.Year=@ReportCode+@Type+@Site+@Plant+a.Technics+@Year)
			
			UPDATE DistributionReport_Technics_Amount
			SET M1=dbo.DistributionReport_fun_Get_Amount_Technics (@Option,@Type,@Site,@Plant,Technics,@DateFrom1,@DateTo1),
				M2=dbo.DistributionReport_fun_Get_Amount_Technics (@Option,@Type,@Site,@Plant,Technics,@DateFrom2,@DateTo2),
				M3=dbo.DistributionReport_fun_Get_Amount_Technics (@Option,@Type,@Site,@Plant,Technics,@DateFrom3,@DateTo3),
				M4=dbo.DistributionReport_fun_Get_Amount_Technics (@Option,@Type,@Site,@Plant,Technics,@DateFrom4,@DateTo4),
				M5=dbo.DistributionReport_fun_Get_Amount_Technics (@Option,@Type,@Site,@Plant,Technics,@DateFrom5,@DateTo5),
				M6=dbo.DistributionReport_fun_Get_Amount_Technics (@Option,@Type,@Site,@Plant,Technics,@DateFrom6,@DateTo6),
				M7=dbo.DistributionReport_fun_Get_Amount_Technics (@Option,@Type,@Site,@Plant,Technics,@DateFrom7,@DateTo7),
				M8=dbo.DistributionReport_fun_Get_Amount_Technics (@Option,@Type,@Site,@Plant,Technics,@DateFrom8,@DateTo8),
				M9=dbo.DistributionReport_fun_Get_Amount_Technics (@Option,@Type,@Site,@Plant,Technics,@DateFrom9,@DateTo9),
				M10=dbo.DistributionReport_fun_Get_Amount_Technics (@Option,@Type,@Site,@Plant,Technics,@DateFrom10,@DateTo10),
				M11=dbo.DistributionReport_fun_Get_Amount_Technics (@Option,@Type,@Site,@Plant,Technics,@DateFrom11,@DateTo11),
				M12=dbo.DistributionReport_fun_Get_Amount_Technics (@Option,@Type,@Site,@Plant,Technics,@DateFrom12,@DateTo12)
			WHERE ReportCode=@ReportCode
				AND Type=@Type
				AND Site=@Site
				AND Plant=@Plant
				AND YEAR=@Year
			SET @Plant='HK'
			TRUNCATE TABLE #Temp
			INSERT INTO #Temp
			SELECT * FROM dbo.DistributionReport_fun_Get_Technics(@Option,@Type,@Site,@Plant,@DateFrom1,@DateTo12)		
			INSERT INTO DistributionReport_Technics_Amount (ReportCode,Type,Site,Plant,Year,Technics)
			SELECT @ReportCode AS ReportCode,@Type AS Type,@Site AS Site,@Plant AS Plant,@Year AS Year,a.Technics 
			FROM #Temp a
			WHERE NOT EXISTS(SELECT b.* FROM DistributionReport_Technics_Amount b WHERE b.ReportCode+b.Type+b.Site+b.Plant+b.Technics+b.Year=@ReportCode+@Type+@Site+@Plant+a.Technics+@Year)
			
			UPDATE DistributionReport_Technics_Amount
			SET M1=dbo.DistributionReport_fun_Get_Amount_Technics (@Option,@Type,@Site,@Plant,Technics,@DateFrom1,@DateTo1),
				M2=dbo.DistributionReport_fun_Get_Amount_Technics (@Option,@Type,@Site,@Plant,Technics,@DateFrom2,@DateTo2),
				M3=dbo.DistributionReport_fun_Get_Amount_Technics (@Option,@Type,@Site,@Plant,Technics,@DateFrom3,@DateTo3),
				M4=dbo.DistributionReport_fun_Get_Amount_Technics (@Option,@Type,@Site,@Plant,Technics,@DateFrom4,@DateTo4),
				M5=dbo.DistributionReport_fun_Get_Amount_Technics (@Option,@Type,@Site,@Plant,Technics,@DateFrom5,@DateTo5),
				M6=dbo.DistributionReport_fun_Get_Amount_Technics (@Option,@Type,@Site,@Plant,Technics,@DateFrom6,@DateTo6),
				M7=dbo.DistributionReport_fun_Get_Amount_Technics (@Option,@Type,@Site,@Plant,Technics,@DateFrom7,@DateTo7),
				M8=dbo.DistributionReport_fun_Get_Amount_Technics (@Option,@Type,@Site,@Plant,Technics,@DateFrom8,@DateTo8),
				M9=dbo.DistributionReport_fun_Get_Amount_Technics (@Option,@Type,@Site,@Plant,Technics,@DateFrom9,@DateTo9),
				M10=dbo.DistributionReport_fun_Get_Amount_Technics (@Option,@Type,@Site,@Plant,Technics,@DateFrom10,@DateTo10),
				M11=dbo.DistributionReport_fun_Get_Amount_Technics (@Option,@Type,@Site,@Plant,Technics,@DateFrom11,@DateTo11),
				M12=dbo.DistributionReport_fun_Get_Amount_Technics (@Option,@Type,@Site,@Plant,Technics,@DateFrom12,@DateTo12)
			WHERE ReportCode=@ReportCode
				AND Type=@Type
				AND Site=@Site
				AND Plant=@Plant
				AND YEAR=@Year
			
			
			SET @i=@i+1	
		END

		UPDATE DistributionReport_Technics_Amount
		SET Amount=M1+M2+M3+M4+M5+M6+M7+M8+M9+M10+M11+M12

END
GO
