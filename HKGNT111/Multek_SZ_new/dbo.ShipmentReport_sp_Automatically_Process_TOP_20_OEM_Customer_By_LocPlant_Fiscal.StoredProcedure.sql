USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[ShipmentReport_sp_Automatically_Process_TOP_20_OEM_Customer_By_LocPlant_Fiscal]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ShipmentReport_sp_Automatically_Process_TOP_20_OEM_Customer_By_LocPlant_Fiscal]
	-- Add the parameters for the stored procedure here
	@CalculateYear INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
   DECLARE @Year CHAR(4),@i INT,@j INT,@k INT,@SQLString VARCHAR(MAX),@Color VARCHAR(50),@DateFrom DATETIME,@DateTo DATETIME ,@NowMonth INT,
			@Amount BIGINT,@Site VARCHAR(50),@Plant VARCHAR(50),@Lay INT,@OEMCustomer VARCHAR(500),@OEM VARCHAR(500),@ReportCode CHAR(3),@SumCustomer VARCHAR(MAX),@SumOEM VARCHAR(MAX),
			@M1From VARCHAR(10),@M1To VARCHAR(10),@M2From VARCHAR(10),@M2To VARCHAR(10),
			@M3From VARCHAR(10),@M3To VARCHAR(10),@M4From VARCHAR(10),@M4To VARCHAR(10),
			@M5From VARCHAR(10),@M5To VARCHAR(10),@M6From VARCHAR(10),@M6To VARCHAR(10),
			@M7From VARCHAR(10),@M7To VARCHAR(10),@M8From VARCHAR(10),@M8To VARCHAR(10),
			@M9From VARCHAR(10),@M9To VARCHAR(10),@M10From VARCHAR(10),@M10To VARCHAR(10),
			@M11From VARCHAR(10),@M11To VARCHAR(10),@M12From VARCHAR(10),@M12To VARCHAR(10),@Type VARCHAR(10)
	CREATE TABLE #Temp (Loc VARCHAR(10),Plant VARCHAR(3),Year VARCHAR(4),OEMCustomer VARCHAR(300),Amount BIGINT) 
	CREATE NONCLUSTERED INDEX [TempTypeSitePlantOEMDay] ON [#Temp] 
	(
		[Loc] ASC,[Plant] ASC,[Year] ASC,[OEMCustomer] ASC
	)
	SET @SQLString=''
	SET @Year=CONVERT(VARCHAR(4),GETDATE()-1,120)
	SET @i=1
	WHILE @i<=@CalculateYear
		BEGIN
		
			SET @Year=(SELECT MAX(ShipmentYears) FROM dbo.ShipmentReport_Fiscal_Year) -(@i-1) --CONVERT(CHAR(4),DATEADD(YEAR,-@i+1,GETDATE()-1),120)
			SET @DateFrom=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=1) 
			SET @DateTo=(SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=12) 
			SET @M1From=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=1) 
			SET @M1To=  (SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=1) 
			SET @M2From=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=2) 
			SET @M2To=  (SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=2) 
			SET @M3From=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=3) 
			SET @M3To=  (SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=3) 
			SET @M4From=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=4) 
			SET @M4To=  (SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=4) 
			SET @M5From=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=5) 
			SET @M5To=  (SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=5) 
			SET @M6From=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=6) 
			SET @M6To=  (SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=6) 
			SET @M7From=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=7) 
			SET @M7To=  (SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=7) 
			SET @M8From=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=8) 
			SET @M8To=  (SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=8) 
			SET @M9From=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=9) 
			SET @M9To=  (SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=9) 
			SET @M10From=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=10) 
			SET @M10To=  (SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=10) 
			SET @M11From=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=11) 
			SET @M11To=  (SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=11) 
			SET @M12From=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=12) 
			SET @M12To=  (SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=12) 

			-- Dis Process Top 20 Customers 
			TRUNCATE TABLE #Temp
			SET @OEMCustomer='Customer'
			SET @Site='Chi'
			SET @Plant='P2'
			INSERT INTO #Temp (Loc,Plant,Year,OEMCustomer,Amount) 
			SELECT @Site AS Loc,@Plant AS Plant,@Year AS Year,* FROM dbo.ShipmentReport_fun_Get_TOP_20_Customer_OEM_By_LocPlant(@OEMCustomer,@Site,@Plant,@DateFrom,@DateTo)
			DELETE ShipmentReport_Shipped_All_Fixed_Top_20_Customer_Fiscal_By_LocPlant
			FROM ShipmentReport_Shipped_All_Fixed_Top_20_Customer_Fiscal_By_LocPlant a
			WHERE a.Year=@Year
				AND a.Loc=@Site
				AND a.Plant=@Plant
				AND NOT EXISTS(SELECT * FROM #Temp b WHERE b.OEMCustomer=a.Customer )

			SET @SQLString='
							INSERT INTO ShipmentReport_Shipped_All_Fixed_Top_20_Customer_Fiscal_By_LocPlant(Loc,Plant,Year ,Customer,Amount)
							SELECT a.*
							FROM #Temp a
							WHERE NOT EXISTS(SELECT b.* FROM ShipmentReport_Shipped_All_Fixed_Top_20_Customer_Fiscal_By_LocPlant b WHERE b.Loc+b.Plant+b.Year+b.Customer=a.Loc+a.Plant+a.Year+a.OEMCustomer) 
							'
			EXECUTE (@SQLString)
			UPDATE ShipmentReport_Shipped_All_Fixed_Top_20_Customer_Fiscal_By_LocPlant
			SET M1=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@M1From,@M1To),
				M2=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@M2From,@M2To),
				M3=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@M3From,@M3To),
				M4=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@M4From,@M4To),
				M5=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@M5From,@M5To),
				M6=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@M6From,@M6To),
				M7=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@M7From,@M7To),
				M8=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@M8From,@M8To),
				M9=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@M9From,@M9To),
				M10=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@M10From,@M10To),
				M11=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@M11From,@M11To),
				M12=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@M12From,@M12To)
			WHERE Year=@Year
				AND Loc=@Site
				AND Plant=@Plant
					
			TRUNCATE TABLE #Temp
			SET @Site='Chi'
			SET @Plant='2F'
			INSERT INTO #Temp (Loc,Plant,Year,OEMCustomer,Amount) 
			SELECT @Site AS Loc,@Plant AS Plant,@Year AS Year,* FROM dbo.ShipmentReport_fun_Get_TOP_20_Customer_OEM_By_LocPlant(@OEMCustomer,@Site,@Plant,@DateFrom,@DateTo)
			DELETE ShipmentReport_Shipped_All_Fixed_Top_20_Customer_Fiscal_By_LocPlant
			FROM ShipmentReport_Shipped_All_Fixed_Top_20_Customer_Fiscal_By_LocPlant a
			WHERE a.Year=@Year
				AND a.Loc=@Site
				AND a.Plant=@Plant
				AND NOT EXISTS(SELECT * FROM #Temp b WHERE b.OEMCustomer=a.Customer )

			SET @SQLString='
							INSERT INTO ShipmentReport_Shipped_All_Fixed_Top_20_Customer_Fiscal_By_LocPlant(Loc,Plant,Year ,Customer,Amount)
							SELECT a.*
							FROM #Temp a
							WHERE NOT EXISTS(SELECT b.* FROM ShipmentReport_Shipped_All_Fixed_Top_20_Customer_Fiscal_By_LocPlant b WHERE b.Loc+b.Plant+b.Year+b.Customer=a.Loc+a.Plant+a.Year+a.OEMCustomer) 
							'
			EXECUTE (@SQLString)
			UPDATE ShipmentReport_Shipped_All_Fixed_Top_20_Customer_Fiscal_By_LocPlant
			SET M1=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@M1From,@M1To),
				M2=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@M2From,@M2To),
				M3=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@M3From,@M3To),
				M4=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@M4From,@M4To),
				M5=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@M5From,@M5To),
				M6=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@M6From,@M6To),
				M7=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@M7From,@M7To),
				M8=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@M8From,@M8To),
				M9=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@M9From,@M9To),
				M10=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@M10From,@M10To),
				M11=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@M11From,@M11To),
				M12=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@M12From,@M12To)
			WHERE Year=@Year
				AND Loc=@Site
				AND Plant=@Plant
			TRUNCATE TABLE #Temp
			SET @Site='Chi'
			SET @Plant='B3'
			INSERT INTO #Temp (Loc,Plant,Year,OEMCustomer,Amount) 
			SELECT @Site AS Loc,@Plant AS Plant,@Year AS Year,* FROM dbo.ShipmentReport_fun_Get_TOP_20_Customer_OEM_By_LocPlant(@OEMCustomer,@Site,@Plant,@DateFrom,@DateTo)
			DELETE ShipmentReport_Shipped_All_Fixed_Top_20_Customer_Fiscal_By_LocPlant
			FROM ShipmentReport_Shipped_All_Fixed_Top_20_Customer_Fiscal_By_LocPlant a
			WHERE a.Year=@Year
				AND a.Loc=@Site
				AND a.Plant=@Plant
				AND NOT EXISTS(SELECT * FROM #Temp b WHERE b.OEMCustomer=a.Customer )

			SET @SQLString='
							INSERT INTO ShipmentReport_Shipped_All_Fixed_Top_20_Customer_Fiscal_By_LocPlant(Loc,Plant,Year ,Customer,Amount)
							SELECT a.*
							FROM #Temp a
							WHERE NOT EXISTS(SELECT b.* FROM ShipmentReport_Shipped_All_Fixed_Top_20_Customer_Fiscal_By_LocPlant b WHERE b.Loc+b.Plant+b.Year+b.Customer=a.Loc+a.Plant+a.Year+a.OEMCustomer) 
							'
			EXECUTE (@SQLString)
			UPDATE ShipmentReport_Shipped_All_Fixed_Top_20_Customer_Fiscal_By_LocPlant
			SET M1=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@M1From,@M1To),
				M2=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@M2From,@M2To),
				M3=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@M3From,@M3To),
				M4=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@M4From,@M4To),
				M5=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@M5From,@M5To),
				M6=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@M6From,@M6To),
				M7=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@M7From,@M7To),
				M8=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@M8From,@M8To),
				M9=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@M9From,@M9To),
				M10=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@M10From,@M10To),
				M11=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@M11From,@M11To),
				M12=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@M12From,@M12To)
			WHERE Year=@Year
				AND Loc=@Site
				AND Plant=@Plant
			TRUNCATE TABLE #Temp
			SET @Site='Chi'
			SET @Plant='B4'
			INSERT INTO #Temp (Loc,Plant,Year,OEMCustomer,Amount) 
			SELECT @Site AS Loc,@Plant AS Plant,@Year AS Year,* FROM dbo.ShipmentReport_fun_Get_TOP_20_Customer_OEM_By_LocPlant(@OEMCustomer,@Site,@Plant,@DateFrom,@DateTo)
			DELETE ShipmentReport_Shipped_All_Fixed_Top_20_Customer_Fiscal_By_LocPlant
			FROM ShipmentReport_Shipped_All_Fixed_Top_20_Customer_Fiscal_By_LocPlant a
			WHERE a.Year=@Year
				AND a.Loc=@Site
				AND a.Plant=@Plant
				AND NOT EXISTS(SELECT * FROM #Temp b WHERE b.OEMCustomer=a.Customer )

			SET @SQLString='
							INSERT INTO ShipmentReport_Shipped_All_Fixed_Top_20_Customer_Fiscal_By_LocPlant(Loc,Plant,Year ,Customer,Amount)
							SELECT a.*
							FROM #Temp a
							WHERE NOT EXISTS(SELECT b.* FROM ShipmentReport_Shipped_All_Fixed_Top_20_Customer_Fiscal_By_LocPlant b WHERE b.Loc+b.Plant+b.Year+b.Customer=a.Loc+a.Plant+a.Year+a.OEMCustomer) 
							'
			EXECUTE (@SQLString)
			UPDATE ShipmentReport_Shipped_All_Fixed_Top_20_Customer_Fiscal_By_LocPlant
			SET M1=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@M1From,@M1To),
				M2=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@M2From,@M2To),
				M3=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@M3From,@M3To),
				M4=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@M4From,@M4To),
				M5=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@M5From,@M5To),
				M6=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@M6From,@M6To),
				M7=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@M7From,@M7To),
				M8=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@M8From,@M8To),
				M9=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@M9From,@M9To),
				M10=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@M10From,@M10To),
				M11=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@M11From,@M11To),
				M12=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@M12From,@M12To)
			WHERE Year=@Year
				AND Loc=@Site
				AND Plant=@Plant
			TRUNCATE TABLE #Temp
			SET @Site='Chi'
			SET @Plant='B5'
			INSERT INTO #Temp (Loc,Plant,Year,OEMCustomer,Amount) 
			SELECT @Site AS Loc,@Plant AS Plant,@Year AS Year,* FROM dbo.ShipmentReport_fun_Get_TOP_20_Customer_OEM_By_LocPlant(@OEMCustomer,@Site,@Plant,@DateFrom,@DateTo)
			DELETE ShipmentReport_Shipped_All_Fixed_Top_20_Customer_Fiscal_By_LocPlant
			FROM ShipmentReport_Shipped_All_Fixed_Top_20_Customer_Fiscal_By_LocPlant a
			WHERE a.Year=@Year
				AND a.Loc=@Site
				AND a.Plant=@Plant
				AND NOT EXISTS(SELECT * FROM #Temp b WHERE b.OEMCustomer=a.Customer )

			SET @SQLString='
							INSERT INTO ShipmentReport_Shipped_All_Fixed_Top_20_Customer_Fiscal_By_LocPlant(Loc,Plant,Year ,Customer,Amount)
							SELECT a.*
							FROM #Temp a
							WHERE NOT EXISTS(SELECT b.* FROM ShipmentReport_Shipped_All_Fixed_Top_20_Customer_Fiscal_By_LocPlant b WHERE b.Loc+b.Plant+b.Year+b.Customer=a.Loc+a.Plant+a.Year+a.OEMCustomer) 
							'
			EXECUTE (@SQLString)
			UPDATE ShipmentReport_Shipped_All_Fixed_Top_20_Customer_Fiscal_By_LocPlant
			SET M1=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@M1From,@M1To),
				M2=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@M2From,@M2To),
				M3=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@M3From,@M3To),
				M4=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@M4From,@M4To),
				M5=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@M5From,@M5To),
				M6=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@M6From,@M6To),
				M7=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@M7From,@M7To),
				M8=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@M8From,@M8To),
				M9=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@M9From,@M9To),
				M10=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@M10From,@M10To),
				M11=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@M11From,@M11To),
				M12=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@M12From,@M12To)
			WHERE Year=@Year
				AND Loc=@Site
				AND Plant=@Plant
			TRUNCATE TABLE #Temp
			SET @Site='Chi'
			SET @Plant='HK'
			INSERT INTO #Temp (Loc,Plant,Year,OEMCustomer,Amount) 
			SELECT @Site AS Loc,@Plant AS Plant,@Year AS Year,* FROM dbo.ShipmentReport_fun_Get_TOP_20_Customer_OEM_By_LocPlant(@OEMCustomer,@Site,@Plant,@DateFrom,@DateTo)
			DELETE ShipmentReport_Shipped_All_Fixed_Top_20_Customer_Fiscal_By_LocPlant
			FROM ShipmentReport_Shipped_All_Fixed_Top_20_Customer_Fiscal_By_LocPlant a
			WHERE a.Year=@Year
				AND a.Loc=@Site
				AND a.Plant=@Plant
				AND NOT EXISTS(SELECT * FROM #Temp b WHERE b.OEMCustomer=a.Customer )

			SET @SQLString='
							INSERT INTO ShipmentReport_Shipped_All_Fixed_Top_20_Customer_Fiscal_By_LocPlant(Loc,Plant,Year ,Customer,Amount)
							SELECT a.*
							FROM #Temp a
							WHERE NOT EXISTS(SELECT b.* FROM ShipmentReport_Shipped_All_Fixed_Top_20_Customer_Fiscal_By_LocPlant b WHERE b.Loc+b.Plant+b.Year+b.Customer=a.Loc+a.Plant+a.Year+a.OEMCustomer) 
							'
			EXECUTE (@SQLString)
			UPDATE ShipmentReport_Shipped_All_Fixed_Top_20_Customer_Fiscal_By_LocPlant
			SET M1=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@M1From,@M1To),
				M2=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@M2From,@M2To),
				M3=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@M3From,@M3To),
				M4=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@M4From,@M4To),
				M5=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@M5From,@M5To),
				M6=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@M6From,@M6To),
				M7=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@M7From,@M7To),
				M8=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@M8From,@M8To),
				M9=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@M9From,@M9To),
				M10=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@M10From,@M10To),
				M11=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@M11From,@M11To),
				M12=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,Customer,@Site,@Plant,@M12From,@M12To)
			WHERE Year=@Year
				AND Loc=@Site
				AND Plant=@Plant

			SET @Type='ASP'
			UPDATE ShipmentReport_Shipped_All_Fixed_Top_20_Customer_Fiscal_By_LocPlant
			SET ASP1=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_Customer(@Type,Loc,Plant,@M1From,@M1To,Customer),
				ASP2=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_Customer(@Type,Loc,Plant,@M2From,@M2To,Customer),
				ASP3=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_Customer(@Type,Loc,Plant,@M3From,@M3To,Customer),
				ASP4=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_Customer(@Type,Loc,Plant,@M4From,@M4To,Customer),
				ASP5=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_Customer(@Type,Loc,Plant,@M5From,@M5To,Customer),
				ASP6=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_Customer(@Type,Loc,Plant,@M6From,@M6To,Customer),
				ASP7=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_Customer(@Type,Loc,Plant,@M7From,@M7To,Customer),
				ASP8=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_Customer(@Type,Loc,Plant,@M8From,@M8To,Customer),
				ASP9=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_Customer(@Type,Loc,Plant,@M9From,@M9To,Customer),
				ASP10=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_Customer(@Type,Loc,Plant,@M10From,@M10To,Customer),
				ASP11=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_Customer(@Type,Loc,Plant,@M11From,@M11To,Customer),
				ASP12=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_Customer(@Type,Loc,Plant,@M12From,@M12To,Customer)
			WHERE Year=@Year
				AND Loc=@Site
			SET @Type='ALC'
			UPDATE ShipmentReport_Shipped_All_Fixed_Top_20_Customer_Fiscal_By_LocPlant
			SET ALC1=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_Customer(@Type,Loc,Plant,@M1From,@M1To,Customer),
				ALC2=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_Customer(@Type,Loc,Plant,@M2From,@M2To,Customer),
				ALC3=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_Customer(@Type,Loc,Plant,@M3From,@M3To,Customer),
				ALC4=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_Customer(@Type,Loc,Plant,@M4From,@M4To,Customer),
				ALC5=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_Customer(@Type,Loc,Plant,@M5From,@M5To,Customer),
				ALC6=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_Customer(@Type,Loc,Plant,@M6From,@M6To,Customer),
				ALC7=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_Customer(@Type,Loc,Plant,@M7From,@M7To,Customer),
				ALC8=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_Customer(@Type,Loc,Plant,@M8From,@M8To,Customer),
				ALC9=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_Customer(@Type,Loc,Plant,@M9From,@M9To,Customer),
				ALC10=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_Customer(@Type,Loc,Plant,@M10From,@M10To,Customer),
				ALC11=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_Customer(@Type,Loc,Plant,@M11From,@M11To,Customer),
				ALC12=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_Customer(@Type,Loc,Plant,@M12From,@M12To,Customer)
			WHERE Year=@Year
				AND Loc=@Site
			SET @Type='PPL'
			UPDATE ShipmentReport_Shipped_All_Fixed_Top_20_Customer_Fiscal_By_LocPlant
			SET PPL1=(CASE WHEN ALC1=0 THEN 0 ELSE ASP1/ALC1*1.0000 END),
				PPL2=(CASE WHEN ALC2=0 THEN 0 ELSE ASP2/ALC2*1.0000 END),
				PPL3=(CASE WHEN ALC3=0 THEN 0 ELSE ASP3/ALC3*1.0000 END),
				PPL4=(CASE WHEN ALC4=0 THEN 0 ELSE ASP4/ALC4*1.0000 END),
				PPL5=(CASE WHEN ALC5=0 THEN 0 ELSE ASP5/ALC5*1.0000 END),
				PPL6=(CASE WHEN ALC6=0 THEN 0 ELSE ASP6/ALC6*1.0000 END),
				PPL7=(CASE WHEN ALC7=0 THEN 0 ELSE ASP7/ALC7*1.0000 END),
				PPL8=(CASE WHEN ALC8=0 THEN 0 ELSE ASP8/ALC8*1.0000 END),
				PPL9=(CASE WHEN ALC9=0 THEN 0 ELSE ASP9/ALC9*1.0000 END),
				PPL10=(CASE WHEN ALC10=0 THEN 0 ELSE ASP10/ALC10*1.0000 END),
				PPL11=(CASE WHEN ALC11=0 THEN 0 ELSE ASP11/ALC11*1.0000 END),
				PPL12=(CASE WHEN ALC12=0 THEN 0 ELSE ASP12/ALC12*1.0000 END)
			WHERE Year=@Year
				AND Loc=@Site

			SET @Type='ASP'
			UPDATE ShipmentReport_Shipped_All_Fixed_Top_20_Customer_Fiscal_By_Loc
			SET ASP1=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_Customer(@Type,Loc,'ZhuHai',@M1From,@M1To,Customer),
				ASP2=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_Customer(@Type,Loc,'ZhuHai',@M2From,@M2To,Customer),
				ASP3=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_Customer(@Type,Loc,'ZhuHai',@M3From,@M3To,Customer),
				ASP4=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_Customer(@Type,Loc,'ZhuHai',@M4From,@M4To,Customer),
				ASP5=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_Customer(@Type,Loc,'ZhuHai',@M5From,@M5To,Customer),
				ASP6=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_Customer(@Type,Loc,'ZhuHai',@M6From,@M6To,Customer),
				ASP7=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_Customer(@Type,Loc,'ZhuHai',@M7From,@M7To,Customer),
				ASP8=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_Customer(@Type,Loc,'ZhuHai',@M8From,@M8To,Customer),
				ASP9=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_Customer(@Type,Loc,'ZhuHai',@M9From,@M9To,Customer),
				ASP10=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_Customer(@Type,Loc,'ZhuHai',@M10From,@M10To,Customer),
				ASP11=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_Customer(@Type,Loc,'ZhuHai',@M11From,@M11To,Customer),
				ASP12=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_Customer(@Type,Loc,'ZhuHai',@M12From,@M12To,Customer)
			WHERE Year=@Year
				AND Loc=@Site
			SET @Type='ALC'
			UPDATE ShipmentReport_Shipped_All_Fixed_Top_20_Customer_Fiscal_By_Loc
			SET ALC1=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_Customer(@Type,Loc,'ZhuHai',@M1From,@M1To,Customer),
				ALC2=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_Customer(@Type,Loc,'ZhuHai',@M2From,@M2To,Customer),
				ALC3=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_Customer(@Type,Loc,'ZhuHai',@M3From,@M3To,Customer),
				ALC4=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_Customer(@Type,Loc,'ZhuHai',@M4From,@M4To,Customer),
				ALC5=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_Customer(@Type,Loc,'ZhuHai',@M5From,@M5To,Customer),
				ALC6=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_Customer(@Type,Loc,'ZhuHai',@M6From,@M6To,Customer),
				ALC7=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_Customer(@Type,Loc,'ZhuHai',@M7From,@M7To,Customer),
				ALC8=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_Customer(@Type,Loc,'ZhuHai',@M8From,@M8To,Customer),
				ALC9=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_Customer(@Type,Loc,'ZhuHai',@M9From,@M9To,Customer),
				ALC10=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_Customer(@Type,Loc,'ZhuHai',@M10From,@M10To,Customer),
				ALC11=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_Customer(@Type,Loc,'ZhuHai',@M11From,@M11To,Customer),
				ALC12=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_Customer(@Type,Loc,'ZhuHai',@M12From,@M12To,Customer)
			WHERE Year=@Year
				AND Loc=@Site
			SET @Type='PPL'
			UPDATE ShipmentReport_Shipped_All_Fixed_Top_20_Customer_Fiscal_By_Loc
			SET PPL1=(CASE WHEN ALC1=0 THEN 0 ELSE ASP1/ALC1*1.0000 END),
				PPL2=(CASE WHEN ALC2=0 THEN 0 ELSE ASP2/ALC2*1.0000 END),
				PPL3=(CASE WHEN ALC3=0 THEN 0 ELSE ASP3/ALC3*1.0000 END),
				PPL4=(CASE WHEN ALC4=0 THEN 0 ELSE ASP4/ALC4*1.0000 END),
				PPL5=(CASE WHEN ALC5=0 THEN 0 ELSE ASP5/ALC5*1.0000 END),
				PPL6=(CASE WHEN ALC6=0 THEN 0 ELSE ASP6/ALC6*1.0000 END),
				PPL7=(CASE WHEN ALC7=0 THEN 0 ELSE ASP7/ALC7*1.0000 END),
				PPL8=(CASE WHEN ALC8=0 THEN 0 ELSE ASP8/ALC8*1.0000 END),
				PPL9=(CASE WHEN ALC9=0 THEN 0 ELSE ASP9/ALC9*1.0000 END),
				PPL10=(CASE WHEN ALC10=0 THEN 0 ELSE ASP10/ALC10*1.0000 END),
				PPL11=(CASE WHEN ALC11=0 THEN 0 ELSE ASP11/ALC11*1.0000 END),
				PPL12=(CASE WHEN ALC12=0 THEN 0 ELSE ASP12/ALC12*1.0000 END)
			WHERE Year=@Year
				AND Loc=@Site

			TRUNCATE TABLE #Temp
			SET @OEMCustomer='OEM'
			SET @Site='Chi'
			SET @Plant='P2'
			INSERT INTO #Temp (Loc,Plant,Year,OEMCustomer,Amount) 
			SELECT @Site AS Loc,@Plant AS Plant,@Year AS Year,* FROM dbo.ShipmentReport_fun_Get_TOP_20_Customer_OEM_By_LocPlant(@OEMCustomer,@Site,@Plant,@DateFrom,@DateTo)
			DELETE ShipmentReport_Shipped_All_Fixed_Top_20_OEM_Fiscal_By_LocPlant
			FROM ShipmentReport_Shipped_All_Fixed_Top_20_OEM_Fiscal_By_LocPlant a
			WHERE a.Year=@Year
				AND a.Loc=@Site
				AND a.Plant=@Plant
				AND NOT EXISTS(SELECT * FROM #Temp b WHERE b.OEMCustomer=a.OEM )

			SET @SQLString='
							INSERT INTO ShipmentReport_Shipped_All_Fixed_Top_20_OEM_Fiscal_By_LocPlant(Loc,Plant,Year ,OEM,Amount)
							SELECT a.*
							FROM #Temp a
							WHERE NOT EXISTS(SELECT b.* FROM ShipmentReport_Shipped_All_Fixed_Top_20_OEM_Fiscal_By_LocPlant b WHERE b.Loc+b.Plant+b.Year+b.OEM=a.Loc+a.Plant+a.Year+a.OEMCustomer) 
							'
			EXECUTE (@SQLString)
			UPDATE ShipmentReport_Shipped_All_Fixed_Top_20_OEM_Fiscal_By_LocPlant
			SET M1=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,@Plant,@M1From,@M1To),
				M2=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,@Plant,@M2From,@M2To),
				M3=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,@Plant,@M3From,@M3To),
				M4=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,@Plant,@M4From,@M4To),
				M5=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,@Plant,@M5From,@M5To),
				M6=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,@Plant,@M6From,@M6To),
				M7=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,@Plant,@M7From,@M7To),
				M8=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,@Plant,@M8From,@M8To),
				M9=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,@Plant,@M9From,@M9To),
				M10=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,@Plant,@M10From,@M10To),
				M11=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,@Plant,@M11From,@M11To),
				M12=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,@Plant,@M12From,@M12To)
			WHERE Year=@Year
				AND Loc=@Site
				AND Plant=@Plant
			TRUNCATE TABLE #Temp
			SET @Site='Chi'
			SET @Plant='2F'
			INSERT INTO #Temp (Loc,Plant,Year,OEMCustomer,Amount) 
			SELECT @Site AS Loc,@Plant AS Plant,@Year AS Year,* FROM dbo.ShipmentReport_fun_Get_TOP_20_Customer_OEM_By_LocPlant(@OEMCustomer,@Site,@Plant,@DateFrom,@DateTo)
			DELETE ShipmentReport_Shipped_All_Fixed_Top_20_OEM_Fiscal_By_LocPlant
			FROM ShipmentReport_Shipped_All_Fixed_Top_20_OEM_Fiscal_By_LocPlant a
			WHERE a.Year=@Year
				AND a.Loc=@Site
				AND a.Plant=@Plant
				AND NOT EXISTS(SELECT * FROM #Temp b WHERE b.OEMCustomer=a.OEM )

			SET @SQLString='
							INSERT INTO ShipmentReport_Shipped_All_Fixed_Top_20_OEM_Fiscal_By_LocPlant(Loc,Plant,Year ,OEM,Amount)
							SELECT a.*
							FROM #Temp a
							WHERE NOT EXISTS(SELECT b.* FROM ShipmentReport_Shipped_All_Fixed_Top_20_OEM_Fiscal_By_LocPlant b WHERE b.Loc+b.Plant+b.Year+b.OEM=a.Loc+a.Plant+a.Year+a.OEMCustomer) 
							'
			EXECUTE (@SQLString)
			UPDATE ShipmentReport_Shipped_All_Fixed_Top_20_OEM_Fiscal_By_LocPlant
			SET M1=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,@Plant,@M1From,@M1To),
				M2=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,@Plant,@M2From,@M2To),
				M3=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,@Plant,@M3From,@M3To),
				M4=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,@Plant,@M4From,@M4To),
				M5=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,@Plant,@M5From,@M5To),
				M6=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,@Plant,@M6From,@M6To),
				M7=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,@Plant,@M7From,@M7To),
				M8=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,@Plant,@M8From,@M8To),
				M9=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,@Plant,@M9From,@M9To),
				M10=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,@Plant,@M10From,@M10To),
				M11=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,@Plant,@M11From,@M11To),
				M12=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,@Plant,@M12From,@M12To)
			WHERE Year=@Year
				AND Loc=@Site
				AND Plant=@Plant
			TRUNCATE TABLE #Temp
			SET @Site='Chi'
			SET @Plant='B3'
			INSERT INTO #Temp (Loc,Plant,Year,OEMCustomer,Amount) 
			SELECT @Site AS Loc,@Plant AS Plant,@Year AS Year,* FROM dbo.ShipmentReport_fun_Get_TOP_20_Customer_OEM_By_LocPlant(@OEMCustomer,@Site,@Plant,@DateFrom,@DateTo)
			DELETE ShipmentReport_Shipped_All_Fixed_Top_20_OEM_Fiscal_By_LocPlant
			FROM ShipmentReport_Shipped_All_Fixed_Top_20_OEM_Fiscal_By_LocPlant a
			WHERE a.Year=@Year
				AND a.Loc=@Site
				AND a.Plant=@Plant
				AND NOT EXISTS(SELECT * FROM #Temp b WHERE b.OEMCustomer=a.OEM )

			SET @SQLString='
							INSERT INTO ShipmentReport_Shipped_All_Fixed_Top_20_OEM_Fiscal_By_LocPlant(Loc,Plant,Year ,OEM,Amount)
							SELECT a.*
							FROM #Temp a
							WHERE NOT EXISTS(SELECT b.* FROM ShipmentReport_Shipped_All_Fixed_Top_20_OEM_Fiscal_By_LocPlant b WHERE b.Loc+b.Plant+b.Year+b.OEM=a.Loc+a.Plant+a.Year+a.OEMCustomer) 
							'
			EXECUTE (@SQLString)
			UPDATE ShipmentReport_Shipped_All_Fixed_Top_20_OEM_Fiscal_By_LocPlant
			SET M1=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,@Plant,@M1From,@M1To),
				M2=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,@Plant,@M2From,@M2To),
				M3=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,@Plant,@M3From,@M3To),
				M4=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,@Plant,@M4From,@M4To),
				M5=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,@Plant,@M5From,@M5To),
				M6=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,@Plant,@M6From,@M6To),
				M7=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,@Plant,@M7From,@M7To),
				M8=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,@Plant,@M8From,@M8To),
				M9=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,@Plant,@M9From,@M9To),
				M10=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,@Plant,@M10From,@M10To),
				M11=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,@Plant,@M11From,@M11To),
				M12=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,@Plant,@M12From,@M12To)
			WHERE Year=@Year
				AND Loc=@Site
				AND Plant=@Plant
			TRUNCATE TABLE #Temp
			SET @Site='Chi'
			SET @Plant='B4'
			INSERT INTO #Temp (Loc,Plant,Year,OEMCustomer,Amount) 
			SELECT @Site AS Loc,@Plant AS Plant,@Year AS Year,* FROM dbo.ShipmentReport_fun_Get_TOP_20_Customer_OEM_By_LocPlant(@OEMCustomer,@Site,@Plant,@DateFrom,@DateTo)
			DELETE ShipmentReport_Shipped_All_Fixed_Top_20_OEM_Fiscal_By_LocPlant
			FROM ShipmentReport_Shipped_All_Fixed_Top_20_OEM_Fiscal_By_LocPlant a
			WHERE a.Year=@Year
				AND a.Loc=@Site
				AND a.Plant=@Plant
				AND NOT EXISTS(SELECT * FROM #Temp b WHERE b.OEMCustomer=a.OEM )

			SET @SQLString='
							INSERT INTO ShipmentReport_Shipped_All_Fixed_Top_20_OEM_Fiscal_By_LocPlant(Loc,Plant,Year ,OEM,Amount)
							SELECT a.*
							FROM #Temp a
							WHERE NOT EXISTS(SELECT b.* FROM ShipmentReport_Shipped_All_Fixed_Top_20_OEM_Fiscal_By_LocPlant b WHERE b.Loc+b.Plant+b.Year+b.OEM=a.Loc+a.Plant+a.Year+a.OEMCustomer) 
							'
			EXECUTE (@SQLString)
			UPDATE ShipmentReport_Shipped_All_Fixed_Top_20_OEM_Fiscal_By_LocPlant
			SET M1=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,@Plant,@M1From,@M1To),
				M2=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,@Plant,@M2From,@M2To),
				M3=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,@Plant,@M3From,@M3To),
				M4=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,@Plant,@M4From,@M4To),
				M5=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,@Plant,@M5From,@M5To),
				M6=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,@Plant,@M6From,@M6To),
				M7=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,@Plant,@M7From,@M7To),
				M8=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,@Plant,@M8From,@M8To),
				M9=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,@Plant,@M9From,@M9To),
				M10=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,@Plant,@M10From,@M10To),
				M11=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,@Plant,@M11From,@M11To),
				M12=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,@Plant,@M12From,@M12To)
			WHERE Year=@Year
				AND Loc=@Site
				AND Plant=@Plant
			TRUNCATE TABLE #Temp
			SET @Site='Chi'
			SET @Plant='B5'
			INSERT INTO #Temp (Loc,Plant,Year,OEMCustomer,Amount) 
			SELECT @Site AS Loc,@Plant AS Plant,@Year AS Year,* FROM dbo.ShipmentReport_fun_Get_TOP_20_Customer_OEM_By_LocPlant(@OEMCustomer,@Site,@Plant,@DateFrom,@DateTo)
			DELETE ShipmentReport_Shipped_All_Fixed_Top_20_OEM_Fiscal_By_LocPlant
			FROM ShipmentReport_Shipped_All_Fixed_Top_20_OEM_Fiscal_By_LocPlant a
			WHERE a.Year=@Year
				AND a.Loc=@Site
				AND a.Plant=@Plant
				AND NOT EXISTS(SELECT * FROM #Temp b WHERE b.OEMCustomer=a.OEM )

			SET @SQLString='
							INSERT INTO ShipmentReport_Shipped_All_Fixed_Top_20_OEM_Fiscal_By_LocPlant(Loc,Plant,Year ,OEM,Amount)
							SELECT a.*
							FROM #Temp a
							WHERE NOT EXISTS(SELECT b.* FROM ShipmentReport_Shipped_All_Fixed_Top_20_OEM_Fiscal_By_LocPlant b WHERE b.Loc+b.Plant+b.Year+b.OEM=a.Loc+a.Plant+a.Year+a.OEMCustomer) 
							'
			EXECUTE (@SQLString)
			UPDATE ShipmentReport_Shipped_All_Fixed_Top_20_OEM_Fiscal_By_LocPlant
			SET M1=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,@Plant,@M1From,@M1To),
				M2=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,@Plant,@M2From,@M2To),
				M3=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,@Plant,@M3From,@M3To),
				M4=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,@Plant,@M4From,@M4To),
				M5=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,@Plant,@M5From,@M5To),
				M6=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,@Plant,@M6From,@M6To),
				M7=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,@Plant,@M7From,@M7To),
				M8=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,@Plant,@M8From,@M8To),
				M9=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,@Plant,@M9From,@M9To),
				M10=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,@Plant,@M10From,@M10To),
				M11=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,@Plant,@M11From,@M11To),
				M12=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,@Plant,@M12From,@M12To)
			WHERE Year=@Year
				AND Loc=@Site
				AND Plant=@Plant
			TRUNCATE TABLE #Temp
			SET @Site='Chi'
			SET @Plant='HK'
			INSERT INTO #Temp (Loc,Plant,Year,OEMCustomer,Amount) 
			SELECT @Site AS Loc,@Plant AS Plant,@Year AS Year,* FROM dbo.ShipmentReport_fun_Get_TOP_20_Customer_OEM_By_LocPlant(@OEMCustomer,@Site,@Plant,@DateFrom,@DateTo)
			DELETE ShipmentReport_Shipped_All_Fixed_Top_20_OEM_Fiscal_By_LocPlant
			FROM ShipmentReport_Shipped_All_Fixed_Top_20_OEM_Fiscal_By_LocPlant a
			WHERE a.Year=@Year
				AND a.Loc=@Site
				AND a.Plant=@Plant
				AND NOT EXISTS(SELECT * FROM #Temp b WHERE b.OEMCustomer=a.OEM )

			SET @SQLString='
							INSERT INTO ShipmentReport_Shipped_All_Fixed_Top_20_OEM_Fiscal_By_LocPlant(Loc,Plant,Year ,OEM,Amount)
							SELECT a.*
							FROM #Temp a
							WHERE NOT EXISTS(SELECT b.* FROM ShipmentReport_Shipped_All_Fixed_Top_20_OEM_Fiscal_By_LocPlant b WHERE b.Loc+b.Plant+b.Year+b.OEM=a.Loc+a.Plant+a.Year+a.OEMCustomer) 
							'
			EXECUTE (@SQLString)
			UPDATE ShipmentReport_Shipped_All_Fixed_Top_20_OEM_Fiscal_By_LocPlant
			SET M1=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,@Plant,@M1From,@M1To),
				M2=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,@Plant,@M2From,@M2To),
				M3=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,@Plant,@M3From,@M3To),
				M4=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,@Plant,@M4From,@M4To),
				M5=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,@Plant,@M5From,@M5To),
				M6=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,@Plant,@M6From,@M6To),
				M7=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,@Plant,@M7From,@M7To),
				M8=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,@Plant,@M8From,@M8To),
				M9=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,@Plant,@M9From,@M9To),
				M10=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,@Plant,@M10From,@M10To),
				M11=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,@Plant,@M11From,@M11To),
				M12=dbo.ShipmentReport_fun_Get_Amount_OEM_Customer(@OEMCustomer,OEM,@Site,@Plant,@M12From,@M12To)
			WHERE Year=@Year
				AND Loc=@Site
				AND Plant=@Plant
			
			SET @Type='ASP'
			UPDATE ShipmentReport_Shipped_All_Fixed_Top_20_OEM_Fiscal_By_LocPlant
			SET ASP1=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_OEM(@Type,Loc,Plant,@M1From,@M1To,OEM),
				ASP2=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_OEM(@Type,Loc,Plant,@M2From,@M2To,OEM),
				ASP3=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_OEM(@Type,Loc,Plant,@M3From,@M3To,OEM),
				ASP4=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_OEM(@Type,Loc,Plant,@M4From,@M4To,OEM),
				ASP5=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_OEM(@Type,Loc,Plant,@M5From,@M5To,OEM),
				ASP6=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_OEM(@Type,Loc,Plant,@M6From,@M6To,OEM),
				ASP7=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_OEM(@Type,Loc,Plant,@M7From,@M7To,OEM),
				ASP8=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_OEM(@Type,Loc,Plant,@M8From,@M8To,OEM),
				ASP9=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_OEM(@Type,Loc,Plant,@M9From,@M9To,OEM),
				ASP10=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_OEM(@Type,Loc,Plant,@M10From,@M10To,OEM),
				ASP11=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_OEM(@Type,Loc,Plant,@M11From,@M11To,OEM),
				ASP12=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_OEM(@Type,Loc,Plant,@M12From,@M12To,OEM)
			WHERE Year=@Year
				AND Loc=@Site
			SET @Type='ALC'
			UPDATE ShipmentReport_Shipped_All_Fixed_Top_20_OEM_Fiscal_By_LocPlant
			SET ALC1=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_OEM(@Type,Loc,Plant,@M1From,@M1To,OEM),
				ALC2=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_OEM(@Type,Loc,Plant,@M2From,@M2To,OEM),
				ALC3=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_OEM(@Type,Loc,Plant,@M3From,@M3To,OEM),
				ALC4=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_OEM(@Type,Loc,Plant,@M4From,@M4To,OEM),
				ALC5=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_OEM(@Type,Loc,Plant,@M5From,@M5To,OEM),
				ALC6=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_OEM(@Type,Loc,Plant,@M6From,@M6To,OEM),
				ALC7=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_OEM(@Type,Loc,Plant,@M7From,@M7To,OEM),
				ALC8=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_OEM(@Type,Loc,Plant,@M8From,@M8To,OEM),
				ALC9=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_OEM(@Type,Loc,Plant,@M9From,@M9To,OEM),
				ALC10=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_OEM(@Type,Loc,Plant,@M10From,@M10To,OEM),
				ALC11=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_OEM(@Type,Loc,Plant,@M11From,@M11To,OEM),
				ALC12=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_OEM(@Type,Loc,Plant,@M12From,@M12To,OEM)
			WHERE Year=@Year
				AND Loc=@Site
			SET @Type='PPL'
			UPDATE ShipmentReport_Shipped_All_Fixed_Top_20_OEM_Fiscal_By_LocPlant
			SET PPL1=(CASE WHEN ALC1=0 THEN 0 ELSE ASP1/ALC1*1.0000 END),
				PPL2=(CASE WHEN ALC2=0 THEN 0 ELSE ASP2/ALC2*1.0000 END),
				PPL3=(CASE WHEN ALC3=0 THEN 0 ELSE ASP3/ALC3*1.0000 END),
				PPL4=(CASE WHEN ALC4=0 THEN 0 ELSE ASP4/ALC4*1.0000 END),
				PPL5=(CASE WHEN ALC5=0 THEN 0 ELSE ASP5/ALC5*1.0000 END),
				PPL6=(CASE WHEN ALC6=0 THEN 0 ELSE ASP6/ALC6*1.0000 END),
				PPL7=(CASE WHEN ALC7=0 THEN 0 ELSE ASP7/ALC7*1.0000 END),
				PPL8=(CASE WHEN ALC8=0 THEN 0 ELSE ASP8/ALC8*1.0000 END),
				PPL9=(CASE WHEN ALC9=0 THEN 0 ELSE ASP9/ALC9*1.0000 END),
				PPL10=(CASE WHEN ALC10=0 THEN 0 ELSE ASP10/ALC10*1.0000 END),
				PPL11=(CASE WHEN ALC11=0 THEN 0 ELSE ASP11/ALC11*1.0000 END),
				PPL12=(CASE WHEN ALC12=0 THEN 0 ELSE ASP12/ALC12*1.0000 END)
			WHERE Year=@Year
				AND Loc=@Site

			SET @Type='ASP'
			UPDATE ShipmentReport_Shipped_All_Fixed_Top_20_OEM_Fiscal_By_Loc
			SET ASP1=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_OEM(@Type,Loc,'ZhuHai',@M1From,@M1To,OEM),
				ASP2=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_OEM(@Type,Loc,'ZhuHai',@M2From,@M2To,OEM),
				ASP3=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_OEM(@Type,Loc,'ZhuHai',@M3From,@M3To,OEM),
				ASP4=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_OEM(@Type,Loc,'ZhuHai',@M4From,@M4To,OEM),
				ASP5=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_OEM(@Type,Loc,'ZhuHai',@M5From,@M5To,OEM),
				ASP6=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_OEM(@Type,Loc,'ZhuHai',@M6From,@M6To,OEM),
				ASP7=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_OEM(@Type,Loc,'ZhuHai',@M7From,@M7To,OEM),
				ASP8=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_OEM(@Type,Loc,'ZhuHai',@M8From,@M8To,OEM),
				ASP9=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_OEM(@Type,Loc,'ZhuHai',@M9From,@M9To,OEM),
				ASP10=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_OEM(@Type,Loc,'ZhuHai',@M10From,@M10To,OEM),
				ASP11=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_OEM(@Type,Loc,'ZhuHai',@M11From,@M11To,OEM),
				ASP12=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_OEM(@Type,Loc,'ZhuHai',@M12From,@M12To,OEM)
			WHERE Year=@Year
				AND Loc=@Site
			SET @Type='ALC'
			UPDATE ShipmentReport_Shipped_All_Fixed_Top_20_OEM_Fiscal_By_Loc
			SET ALC1=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_OEM(@Type,Loc,'ZhuHai',@M1From,@M1To,OEM),
				ALC2=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_OEM(@Type,Loc,'ZhuHai',@M2From,@M2To,OEM),
				ALC3=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_OEM(@Type,Loc,'ZhuHai',@M3From,@M3To,OEM),
				ALC4=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_OEM(@Type,Loc,'ZhuHai',@M4From,@M4To,OEM),
				ALC5=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_OEM(@Type,Loc,'ZhuHai',@M5From,@M5To,OEM),
				ALC6=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_OEM(@Type,Loc,'ZhuHai',@M6From,@M6To,OEM),
				ALC7=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_OEM(@Type,Loc,'ZhuHai',@M7From,@M7To,OEM),
				ALC8=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_OEM(@Type,Loc,'ZhuHai',@M8From,@M8To,OEM),
				ALC9=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_OEM(@Type,Loc,'ZhuHai',@M9From,@M9To,OEM),
				ALC10=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_OEM(@Type,Loc,'ZhuHai',@M10From,@M10To,OEM),
				ALC11=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_OEM(@Type,Loc,'ZhuHai',@M11From,@M11To,OEM),
				ALC12=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_OEM(@Type,Loc,'ZhuHai',@M12From,@M12To,OEM)
			WHERE Year=@Year
				AND Loc=@Site
			SET @Type='PPL'
			UPDATE ShipmentReport_Shipped_All_Fixed_Top_20_OEM_Fiscal_By_Loc
			SET PPL1=(CASE WHEN ALC1=0 THEN 0 ELSE ASP1/ALC1*1.0000 END),
				PPL2=(CASE WHEN ALC2=0 THEN 0 ELSE ASP2/ALC2*1.0000 END),
				PPL3=(CASE WHEN ALC3=0 THEN 0 ELSE ASP3/ALC3*1.0000 END),
				PPL4=(CASE WHEN ALC4=0 THEN 0 ELSE ASP4/ALC4*1.0000 END),
				PPL5=(CASE WHEN ALC5=0 THEN 0 ELSE ASP5/ALC5*1.0000 END),
				PPL6=(CASE WHEN ALC6=0 THEN 0 ELSE ASP6/ALC6*1.0000 END),
				PPL7=(CASE WHEN ALC7=0 THEN 0 ELSE ASP7/ALC7*1.0000 END),
				PPL8=(CASE WHEN ALC8=0 THEN 0 ELSE ASP8/ALC8*1.0000 END),
				PPL9=(CASE WHEN ALC9=0 THEN 0 ELSE ASP9/ALC9*1.0000 END),
				PPL10=(CASE WHEN ALC10=0 THEN 0 ELSE ASP10/ALC10*1.0000 END),
				PPL11=(CASE WHEN ALC11=0 THEN 0 ELSE ASP11/ALC11*1.0000 END),
				PPL12=(CASE WHEN ALC12=0 THEN 0 ELSE ASP12/ALC12*1.0000 END)
			WHERE Year=@Year
				AND Loc=@Site
									 
			SET @i=@i+1
		END
END
GO
