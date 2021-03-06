USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[DistributionReport_sp_AutomaticallyProcess_TOP20OEMCustomerCalendar_Total]    Script Date: 11/06/2014 15:47:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DistributionReport_sp_AutomaticallyProcess_TOP20OEMCustomerCalendar_Total]
	-- Add the parameters for the stored procedure here
	@Type VARCHAR(10),
	@CalculateYear INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    DECLARE @Year CHAR(4),@i INT,@j INT,@k INT,@SQLString VARCHAR(MAX),@Color VARCHAR(50),@DateFrom DATETIME,@DateTo DATETIME ,@NowMonth INT,
			@Amount BIGINT,@Site VARCHAR(50),@Plant VARCHAR(50),@Lay INT,@OEMCustomer VARCHAR(500),@OEM VARCHAR(500),@ReportCode CHAR(3),@SumCustomer VARCHAR(MAX),@SumOEM VARCHAR(MAX),
			@DateFrom1 DATETIME,@DateTo1 DATETIME,@DateFrom2 DATETIME,@DateTo2 DATETIME,@DateFrom3 DATETIME,@DateTo3 DATETIME,
			@DateFrom4 DATETIME,@DateTo4 DATETIME,@DateFrom5 DATETIME,@DateTo5 DATETIME,@DateFrom6 DATETIME,@DateTo6 DATETIME,
			@DateFrom7 DATETIME,@DateTo7 DATETIME,@DateFrom8 DATETIME,@DateTo8 DATETIME,@DateFrom9 DATETIME,@DateTo9 DATETIME,
			@DateFrom10 DATETIME,@DateTo10 DATETIME,@DateFrom11 DATETIME,@DateTo11 DATETIME,@DateFrom12 DATETIME,@DateTo12 DATETIME			
	CREATE TABLE #Temp (ReportCode VARCHAR(3),Type VARCHAR(10),Site VARCHAR(50),Plant VARCHAR(50),Year VARCHAR(4),OEMCustomer VARCHAR(300),Amount BIGINT,B1 BIGINT,B2F BIGINT,B3 BIGINT,B4 BIGINT,B5 BIGINT,VVI BIGINT) 
	CREATE TABLE #Temp1 (ReportCode VARCHAR(3),Type VARCHAR(10),Site VARCHAR(50),Plant VARCHAR(50),Year VARCHAR(4),OEMCustomer VARCHAR(300),Amount BIGINT,M1 BIGINT,M2 BIGINT,M3 BIGINT,M4 BIGINT,M5 BIGINT,M6 BIGINT,M7 BIGINT,M8 BIGINT,M9 BIGINT,M10 BIGINT,M11 BIGINT,M12 BIGINT) 
	CREATE NONCLUSTERED INDEX [TempTypeSitePlantOEMDay] ON [#Temp] 
	(
		[ReportCode] ASC,[Type] ASC,[Site] ASC,[Plant] ASC,[Year] ASC,[OEMCustomer] ASC
	)
	CREATE NONCLUSTERED INDEX [Temp1TypeSitePlantOEMDay] ON [#Temp1] 
	(
		[ReportCode] ASC,[Type] ASC,[Site] ASC,[Plant] ASC,[Year] ASC,[OEMCustomer] ASC
	)

	SET @SQLString=''
	SET @Year=CONVERT(VARCHAR(4),GETDATE()-1,120)
	SET @i=1
	WHILE @i<=@CalculateYear
		BEGIN

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
			
			-- Dis Process Top 20 Customers 
			TRUNCATE TABLE #Temp
			SET @ReportCode='001'
			SET @Site='Chi'
			SET @Plant=''
			INSERT INTO #Temp (ReportCode,Type,Site,Plant,Year,OEMCustomer,Amount) 
			SELECT @ReportCode AS ReportCode,@Type AS Type,@Site AS Site,@Plant AS Plant,@Year AS Year,* FROM dbo.DistributionReport_fun_Get_TOP20Customer('Calendar',@Type,@Site,@Plant,@DateFrom,@DateTo)

			--Update Detail
			UPDATE #Temp
			SET B1=dbo.DistributionReport_fun_Get_Amount_Customer('Calendar',Type,Site,'P2',@DateFrom,@DateTo,OEMCustomer),
			    B2F=dbo.DistributionReport_fun_Get_Amount_Customer('Calendar',Type,Site,'2F',@DateFrom,@DateTo,OEMCustomer),
			    B3=dbo.DistributionReport_fun_Get_Amount_Customer('Calendar',Type,Site,'B3',@DateFrom,@DateTo,OEMCustomer),
			    B4=dbo.DistributionReport_fun_Get_Amount_Customer('Calendar',Type,Site,'B4',@DateFrom,@DateTo,OEMCustomer),
			    B5=dbo.DistributionReport_fun_Get_Amount_Customer('Calendar',Type,Site,'B5',@DateFrom,@DateTo,OEMCustomer),
			    VVI=dbo.DistributionReport_fun_Get_Amount_Customer('Calendar',Type,Site,'HK',@DateFrom,@DateTo,OEMCustomer)
			    
			SET @SQLString='
							INSERT INTO DistributionReport_TOP20CustomerOEM_Total
							SELECT a.*
							FROM #Temp a
							WHERE NOT EXISTS(SELECT b.* FROM DistributionReport_TOP20CustomerOEM_Total b WHERE b.ReportCode+b.Type+b.Site+b.Plant+b.Year+b.OEMCustomer=a.ReportCode+a.Type+a.Site+a.Plant+a.Year+a.OEMCustomer) 

							UPDATE DistributionReport_TOP20CustomerOEM_Total
							SET Amount=b.Amount,B1=b.B1,B2F=b.B2F,B3=b.B3,B4=b.B4,B5=b.B5,VVI=b.VVI
							FROM DistributionReport_TOP20CustomerOEM_Total a,#Temp b
							WHERE a.ReportCode=b.ReportCode
								AND a.Type=b.Type
								AND a.Site=b.Site
								AND a.Plant=b.Plant
								AND a.Year=b.Year
								AND a.OEMCustomer=b.OEMCustomer
							'
			EXECUTE (@SQLString)

			DELETE DistributionReport_TOP20CustomerOEM_Total 
			WHERE ReportCode=@ReportCode
				 AND Type=@Type
				 AND Site=@Site 
				 AND Plant=@Plant 
				 AND Year=@Year
				 AND OEMCustomer NOT IN (SELECT OEMCustomer FROM #Temp)
        
			--Update Plant Detail
			TRUNCATE TABLE #Temp1
			INSERT INTO #Temp1(ReportCode,Type,Site,Plant,Year,OEMCustomer)
			SELECT ReportCode,Type,Site,'P2' AS Plant,Year,OEMCustomer	FROM #Temp
			INSERT INTO #Temp1(ReportCode,Type,Site,Plant,Year,OEMCustomer)
			SELECT ReportCode,Type,Site,'2F' AS Plant,Year,OEMCustomer	FROM #Temp
			INSERT INTO #Temp1(ReportCode,Type,Site,Plant,Year,OEMCustomer)
			SELECT ReportCode,Type,Site,'B3' AS Plant,Year,OEMCustomer	FROM #Temp
			INSERT INTO #Temp1(ReportCode,Type,Site,Plant,Year,OEMCustomer)
			SELECT ReportCode,Type,Site,'B4' AS Plant,Year,OEMCustomer	FROM #Temp
        	INSERT INTO #Temp1(ReportCode,Type,Site,Plant,Year,OEMCustomer)
			SELECT ReportCode,Type,Site,'B5' AS Plant,Year,OEMCustomer FROM #Temp
			INSERT INTO #Temp1(ReportCode,Type,Site,Plant,Year,OEMCustomer)
			SELECT ReportCode,Type,Site,'HK' AS Plant,Year,OEMCustomer	FROM #Temp
		
			UPDATE #Temp1
			SET M1=dbo.DistributionReport_fun_Get_Amount_Customer('Calendar',Type,Site,Plant,@DateFrom1,@DateTo1,OEMCustomer),
			    M2=dbo.DistributionReport_fun_Get_Amount_Customer('Calendar',Type,Site,Plant,@DateFrom2,@DateTo2,OEMCustomer),
			    M3=dbo.DistributionReport_fun_Get_Amount_Customer('Calendar',Type,Site,Plant,@DateFrom3,@DateTo3,OEMCustomer),
			    M4=dbo.DistributionReport_fun_Get_Amount_Customer('Calendar',Type,Site,Plant,@DateFrom4,@DateTo4,OEMCustomer),
			    M5=dbo.DistributionReport_fun_Get_Amount_Customer('Calendar',Type,Site,Plant,@DateFrom5,@DateTo5,OEMCustomer),
			    M6=dbo.DistributionReport_fun_Get_Amount_Customer('Calendar',Type,Site,Plant,@DateFrom6,@DateTo6,OEMCustomer),
			    M7=dbo.DistributionReport_fun_Get_Amount_Customer('Calendar',Type,Site,Plant,@DateFrom7,@DateTo7,OEMCustomer),
			    M8=dbo.DistributionReport_fun_Get_Amount_Customer('Calendar',Type,Site,Plant,@DateFrom8,@DateTo8,OEMCustomer),
			    M9=dbo.DistributionReport_fun_Get_Amount_Customer('Calendar',Type,Site,Plant,@DateFrom9,@DateTo9,OEMCustomer),
			    M10=dbo.DistributionReport_fun_Get_Amount_Customer('Calendar',Type,Site,Plant,@DateFrom10,@DateTo10,OEMCustomer),
			    M11=dbo.DistributionReport_fun_Get_Amount_Customer('Calendar',Type,Site,Plant,@DateFrom11,@DateTo11,OEMCustomer),
			    M12=dbo.DistributionReport_fun_Get_Amount_Customer('Calendar',Type,Site,Plant,@DateFrom12,@DateTo12,OEMCustomer)
			UPDATE #Temp1
			SET Amount=M1+M2+M3+M4+M5+M6+M7+M8+M9+M10+M11+M12
					
			SET @SQLString='
								INSERT INTO DistributionReport_TOP20CustomerOEM_Total_Detail
								SELECT a.*
								FROM #Temp1 a
								WHERE NOT EXISTS(SELECT b.* FROM DistributionReport_TOP20CustomerOEM_Total_Detail b WHERE b.ReportCode+b.Type+b.Site+b.Plant+b.Year+b.OEMCustomer=a.ReportCode+a.Type+a.Site+a.Plant+a.Year+a.OEMCustomer) 

								UPDATE DistributionReport_TOP20CustomerOEM_Total_Detail
								SET Amount=b.Amount,M1=b.M1,M2=b.M2,M3=b.M3,M4=b.M4,M5=b.M5,M6=b.M6,M7=b.M7,M8=b.M8,M9=b.M9,M10=b.M10,M11=b.M11,M12=b.M12
								FROM DistributionReport_TOP20CustomerOEM_Total_Detail a,#Temp1 b
								WHERE a.ReportCode=b.ReportCode
									AND a.Type=b.Type
									AND a.Site=b.Site
									AND a.Plant=b.Plant
									AND a.Year=b.Year
									AND a.OEMCustomer=b.OEMCustomer
							'
			EXECUTE (@SQLString)

			DELETE DistributionReport_TOP20CustomerOEM_Total 
			WHERE ReportCode=@ReportCode
				 AND Type=@Type
				 AND Site=@Site 
				 AND Plant=@Plant 
				 AND Year=@Year
				 AND OEMCustomer NOT IN (SELECT OEMCustomer FROM #Temp)

			-- Dis Process Top 20 OEMs 
			TRUNCATE TABLE #Temp
			SET @ReportCode='002'
			SET @Site='Chi'
			SET @Plant=''
			INSERT INTO #Temp (ReportCode,Type,Site,Plant,Year,OEMCustomer,Amount) 
			SELECT @ReportCode AS ReportCode,@Type AS Type,@Site AS Site,@Plant AS Plant,@Year AS Year,* FROM dbo.DistributionReport_fun_Get_TOP20OEM('Calendar',@Type,@Site,@Plant,@DateFrom,@DateTo)

			--Update Detail
			UPDATE #Temp
			SET B1=dbo.DistributionReport_fun_Get_Amount_OEM('Calendar',Type,Site,'P2',@DateFrom,@DateTo,OEMCustomer),
			    B2F=dbo.DistributionReport_fun_Get_Amount_OEM('Calendar',Type,Site,'2F',@DateFrom,@DateTo,OEMCustomer),
			    B3=dbo.DistributionReport_fun_Get_Amount_OEM('Calendar',Type,Site,'B3',@DateFrom,@DateTo,OEMCustomer),
			    B4=dbo.DistributionReport_fun_Get_Amount_OEM('Calendar',Type,Site,'B4',@DateFrom,@DateTo,OEMCustomer),
			    B5=dbo.DistributionReport_fun_Get_Amount_OEM('Calendar',Type,Site,'B5',@DateFrom,@DateTo,OEMCustomer),
			    VVI=dbo.DistributionReport_fun_Get_Amount_OEM('Calendar',Type,Site,'HK',@DateFrom,@DateTo,OEMCustomer)

			SET @SQLString='
							INSERT INTO DistributionReport_TOP20CustomerOEM_Total
							SELECT a.*
							FROM #Temp a
							WHERE NOT EXISTS(SELECT b.* FROM DistributionReport_TOP20CustomerOEM_Total b WHERE b.ReportCode+b.Type+b.Site+b.Plant+b.Year+b.OEMCustomer=a.ReportCode+a.Type+a.Site+a.Plant+a.Year+a.OEMCustomer) 

							UPDATE DistributionReport_TOP20CustomerOEM_Total
							SET Amount=b.Amount,B1=b.B1,B2F=b.B2F,B3=b.B3,B4=b.B4,B5=b.B5,VVI=b.VVI
							FROM DistributionReport_TOP20CustomerOEM_Total a,#Temp b
							WHERE a.ReportCode=b.ReportCode
								AND a.Type=b.Type
								AND a.Site=b.Site
								AND a.Plant=b.Plant
								AND a.Year=b.Year
								AND a.OEMCustomer=b.OEMCustomer
							'
			EXECUTE (@SQLString)

			--Update Plant Detail
			TRUNCATE TABLE #Temp1
			INSERT INTO #Temp1(ReportCode,Type,Site,Plant,Year,OEMCustomer)
			SELECT ReportCode,Type,Site,'P2' AS Plant,Year,OEMCustomer	FROM #Temp
			INSERT INTO #Temp1(ReportCode,Type,Site,Plant,Year,OEMCustomer)
			SELECT ReportCode,Type,Site,'2F' AS Plant,Year,OEMCustomer	FROM #Temp
			INSERT INTO #Temp1(ReportCode,Type,Site,Plant,Year,OEMCustomer)
			SELECT ReportCode,Type,Site,'B3' AS Plant,Year,OEMCustomer	FROM #Temp
			INSERT INTO #Temp1(ReportCode,Type,Site,Plant,Year,OEMCustomer)
			SELECT ReportCode,Type,Site,'B4' AS Plant,Year,OEMCustomer	FROM #Temp
        	INSERT INTO #Temp1(ReportCode,Type,Site,Plant,Year,OEMCustomer)
			SELECT ReportCode,Type,Site,'B5' AS Plant,Year,OEMCustomer FROM #Temp
			INSERT INTO #Temp1(ReportCode,Type,Site,Plant,Year,OEMCustomer)
			SELECT ReportCode,Type,Site,'HK' AS Plant,Year,OEMCustomer	FROM #Temp
		
			UPDATE #Temp1
			SET M1=dbo.DistributionReport_fun_Get_Amount_OEM('Calendar',Type,Site,Plant,@DateFrom1,@DateTo1,OEMCustomer),
			    M2=dbo.DistributionReport_fun_Get_Amount_OEM('Calendar',Type,Site,Plant,@DateFrom2,@DateTo2,OEMCustomer),
			    M3=dbo.DistributionReport_fun_Get_Amount_OEM('Calendar',Type,Site,Plant,@DateFrom3,@DateTo3,OEMCustomer),
			    M4=dbo.DistributionReport_fun_Get_Amount_OEM('Calendar',Type,Site,Plant,@DateFrom4,@DateTo4,OEMCustomer),
			    M5=dbo.DistributionReport_fun_Get_Amount_OEM('Calendar',Type,Site,Plant,@DateFrom5,@DateTo5,OEMCustomer),
			    M6=dbo.DistributionReport_fun_Get_Amount_OEM('Calendar',Type,Site,Plant,@DateFrom6,@DateTo6,OEMCustomer),
			    M7=dbo.DistributionReport_fun_Get_Amount_OEM('Calendar',Type,Site,Plant,@DateFrom7,@DateTo7,OEMCustomer),
			    M8=dbo.DistributionReport_fun_Get_Amount_OEM('Calendar',Type,Site,Plant,@DateFrom8,@DateTo8,OEMCustomer),
			    M9=dbo.DistributionReport_fun_Get_Amount_OEM('Calendar',Type,Site,Plant,@DateFrom9,@DateTo9,OEMCustomer),
			    M10=dbo.DistributionReport_fun_Get_Amount_OEM('Calendar',Type,Site,Plant,@DateFrom10,@DateTo10,OEMCustomer),
			    M11=dbo.DistributionReport_fun_Get_Amount_OEM('Calendar',Type,Site,Plant,@DateFrom11,@DateTo11,OEMCustomer),
			    M12=dbo.DistributionReport_fun_Get_Amount_OEM('Calendar',Type,Site,Plant,@DateFrom12,@DateTo12,OEMCustomer)
			UPDATE #Temp1
			SET Amount=M1+M2+M3+M4+M5+M6+M7+M8+M9+M10+M11+M12
	
			SET @SQLString='
								INSERT INTO DistributionReport_TOP20CustomerOEM_Total_Detail
								SELECT a.*
								FROM #Temp1 a
								WHERE NOT EXISTS(SELECT b.* FROM DistributionReport_TOP20CustomerOEM_Total_Detail b WHERE b.ReportCode+b.Type+b.Site+b.Plant+b.Year+b.OEMCustomer=a.ReportCode+a.Type+a.Site+a.Plant+a.Year+a.OEMCustomer) 

								UPDATE DistributionReport_TOP20CustomerOEM_Total_Detail
								SET Amount=b.Amount,M1=b.M1,M2=b.M2,M3=b.M3,M4=b.M4,M5=b.M5,M6=b.M6,M7=b.M7,M8=b.M8,M9=b.M9,M10=b.M10,M11=b.M11,M12=b.M12
								FROM DistributionReport_TOP20CustomerOEM_Total_Detail a,#Temp1 b
								WHERE a.ReportCode=b.ReportCode
									AND a.Type=b.Type
									AND a.Site=b.Site
									AND a.Plant=b.Plant
									AND a.Year=b.Year
									AND a.OEMCustomer=b.OEMCustomer
							'
			EXECUTE (@SQLString)

			SET @Year=@Year-1
			SET @i=@i+1
		END
		
		UPDATE DistributionReport_TOP20CustomerOEM_Total
		SET Amount=B1+B2F+B3+B4+B5+VVI
END
GO
