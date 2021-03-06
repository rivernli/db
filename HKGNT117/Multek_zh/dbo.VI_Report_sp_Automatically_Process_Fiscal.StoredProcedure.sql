USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[VI_Report_sp_Automatically_Process_Fiscal]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[VI_Report_sp_Automatically_Process_Fiscal]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SET NOCOUNT ON;

    DECLARE @Year CHAR(4),@SQLString VARCHAR(8000),
			@M1From VARCHAR(10),@M1To VARCHAR(10),@M2From VARCHAR(10),@M2To VARCHAR(10),
			@M3From VARCHAR(10),@M3To VARCHAR(10),@M4From VARCHAR(10),@M4To VARCHAR(10),
			@M5From VARCHAR(10),@M5To VARCHAR(10),@M6From VARCHAR(10),@M6To VARCHAR(10),
			@M7From VARCHAR(10),@M7To VARCHAR(10),@M8From VARCHAR(10),@M8To VARCHAR(10),
			@M9From VARCHAR(10),@M9To VARCHAR(10),@M10From VARCHAR(10),@M10To VARCHAR(10),
			@M11From VARCHAR(10),@M11To VARCHAR(10),@M12From VARCHAR(10),@M12To VARCHAR(10),
			@Q1From VARCHAR(10),@Q1To VARCHAR(10),@Q2From VARCHAR(10),@Q2To VARCHAR(10),
			@Q3From VARCHAR(10),@Q3To VARCHAR(10),@Q4From VARCHAR(10),@Q4To VARCHAR(10),
			@Color VARCHAR(50)

	-- Initial all
	TRUNCATE TABLE VI_Report_Shipped_All_Fixed_Fiscal	
	
	DECLARE Fiscal_Year_C CURSOR FOR
	SELECT TOP 5 FiscalYear
	FROM DataWarehouse.dbo.DW_DIM_Calender
	GROUP BY FiscalYear
	ORDER BY FiscalYear DESC
	OPEN Fiscal_Year_C
	FETCH NEXT FROM Fiscal_Year_C INTO @Year
	WHILE @@FETCH_STATUS=0
		BEGIN
			SET @M1From=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM DataWarehouse.dbo.DW_DIM_Calender WHERE FiscalYear=@Year AND FiscalPeriod=1) 
			SET @M1To=  (SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM DataWarehouse.dbo.DW_DIM_Calender WHERE FiscalYear=@Year AND FiscalPeriod=1) 
			SET @M2From=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM DataWarehouse.dbo.DW_DIM_Calender WHERE FiscalYear=@Year AND FiscalPeriod=2) 
			SET @M2To=  (SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM DataWarehouse.dbo.DW_DIM_Calender WHERE FiscalYear=@Year AND FiscalPeriod=2) 
			SET @M3From=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM DataWarehouse.dbo.DW_DIM_Calender WHERE FiscalYear=@Year AND FiscalPeriod=3) 
			SET @M3To=  (SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM DataWarehouse.dbo.DW_DIM_Calender WHERE FiscalYear=@Year AND FiscalPeriod=3) 
			SET @M4From=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM DataWarehouse.dbo.DW_DIM_Calender WHERE FiscalYear=@Year AND FiscalPeriod=4) 
			SET @M4To=  (SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM DataWarehouse.dbo.DW_DIM_Calender WHERE FiscalYear=@Year AND FiscalPeriod=4) 
			SET @M5From=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM DataWarehouse.dbo.DW_DIM_Calender WHERE FiscalYear=@Year AND FiscalPeriod=5) 
			SET @M5To=  (SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM DataWarehouse.dbo.DW_DIM_Calender WHERE FiscalYear=@Year AND FiscalPeriod=5) 
			SET @M6From=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM DataWarehouse.dbo.DW_DIM_Calender WHERE FiscalYear=@Year AND FiscalPeriod=6) 
			SET @M6To=  (SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM DataWarehouse.dbo.DW_DIM_Calender WHERE FiscalYear=@Year AND FiscalPeriod=6) 
			SET @M7From=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM DataWarehouse.dbo.DW_DIM_Calender WHERE FiscalYear=@Year AND FiscalPeriod=7) 
			SET @M7To=  (SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM DataWarehouse.dbo.DW_DIM_Calender WHERE FiscalYear=@Year AND FiscalPeriod=7) 
			SET @M8From=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM DataWarehouse.dbo.DW_DIM_Calender WHERE FiscalYear=@Year AND FiscalPeriod=8) 
			SET @M8To=  (SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM DataWarehouse.dbo.DW_DIM_Calender WHERE FiscalYear=@Year AND FiscalPeriod=8) 
			SET @M9From=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM DataWarehouse.dbo.DW_DIM_Calender WHERE FiscalYear=@Year AND FiscalPeriod=9) 
			SET @M9To=  (SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM DataWarehouse.dbo.DW_DIM_Calender WHERE FiscalYear=@Year AND FiscalPeriod=9) 
			SET @M10From=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM DataWarehouse.dbo.DW_DIM_Calender WHERE FiscalYear=@Year AND FiscalPeriod=10) 
			SET @M10To=  (SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM DataWarehouse.dbo.DW_DIM_Calender WHERE FiscalYear=@Year AND FiscalPeriod=10) 
			SET @M11From=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM DataWarehouse.dbo.DW_DIM_Calender WHERE FiscalYear=@Year AND FiscalPeriod=11) 
			SET @M11To=  (SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM DataWarehouse.dbo.DW_DIM_Calender WHERE FiscalYear=@Year AND FiscalPeriod=11) 
			SET @M12From=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM DataWarehouse.dbo.DW_DIM_Calender WHERE FiscalYear=@Year AND FiscalPeriod=12) 
			SET @M12To=  (SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM DataWarehouse.dbo.DW_DIM_Calender WHERE FiscalYear=@Year AND FiscalPeriod=12) 
			SET @Q1From=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM DataWarehouse.dbo.DW_DIM_Calender WHERE FiscalYear=@Year AND FiscalQuarter=1) 
			SET @Q1To=  (SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM DataWarehouse.dbo.DW_DIM_Calender WHERE FiscalYear=@Year AND FiscalQuarter=1) 
			SET @Q2From=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM DataWarehouse.dbo.DW_DIM_Calender WHERE FiscalYear=@Year AND FiscalQuarter=2) 
			SET @Q2To=  (SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM DataWarehouse.dbo.DW_DIM_Calender WHERE FiscalYear=@Year AND FiscalQuarter=2) 
			SET @Q3From=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM DataWarehouse.dbo.DW_DIM_Calender WHERE FiscalYear=@Year AND FiscalQuarter=3) 
			SET @Q3To=  (SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM DataWarehouse.dbo.DW_DIM_Calender WHERE FiscalYear=@Year AND FiscalQuarter=3) 
			SET @Q4From=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM DataWarehouse.dbo.DW_DIM_Calender WHERE FiscalYear=@Year AND FiscalQuarter=4) 
			SET @Q4To=  (SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM DataWarehouse.dbo.DW_DIM_Calender WHERE FiscalYear=@Year AND FiscalQuarter=4) 
			-- Process Site Monthly Shipment Trend   Code:0002
			SET @SQLString='
							DECLARE @Site VARCHAR(50)
							DECLARE Site_C CURSOR FOR 
							SELECT ShipmentSite 
							FROM VI_Report_Site 
							OPEN Site_C
							FETCH NEXT FROM Site_C INTO @Site
							WHILE @@FETCH_STATUS=0
								BEGIN
									-- Process Global Monthly Shipment Trend  Code:0002
									INSERT INTO VI_Report_Shipped_All_Fixed_Fiscal (ReportCode,Site,Plant,Year,M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12)
									SELECT ''002'' AS ReportCode ,@Site AS Site,'''' AS Plant,'+''''+@Year+''''+' AS Year,* FROM dbo.fun_VI_Reprot_Sum_by_Year_Site_Fiscal_Period('+''''+@Year+''''+','+''''+@M1From+''''+','+''''+@M1To+''''+','+''''+@M2From+''''+','+''''+@M2To+''''+','+''''+@M3From+''''+','+''''+@M3To+''''+','+''''+@M4From+''''+','+''''+@M4To+''''+','+''''+@M5From+''''+','+''''+@M5To+''''+','+''''+@M6From+''''+','+''''+@M6To+''''+','+''''+@M7From+''''+','+''''+@M7To+''''+','+''''+@M8From+''''+','+''''+@M8To+''''+','+''''+@M9From+''''+','+''''+@M9To+''''+','+''''+@M10From+''''+','+''''+@M10To+''''+','+''''+@M11From+''''+','+''''+@M11To+''''+','+''''+@M12From+''''+','+''''+@M12To+''''+',@Site,NULL)								
									FETCH NEXT FROM Site_C INTO @Site
								END
							CLOSE Site_C
							DEALLOCATE Site_C
							'
			EXECUTE (@SQLString)
			-- Process Site(chi) Plant 12 Monthly Shipment Trend   Code:0003
			INSERT INTO VI_Report_Shipped_All_Fixed_Fiscal (ReportCode,Site,Plant,Year,M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12)
			SELECT '003','Chi','12',@Year,* FROM dbo.fun_VI_Report_Sum_by_Year_Site_Plant_Fiscal_Period(@Year,@M1From,@M1To,@M2From,@M2To,@M3From,@M3To,@M4From,@M4To,@M5From,@M5To,@M6From,@M6To,@M7From,@M7To,@M8From,@M8To,@M9From,@M9To,@M10From,@M10To,@M11From,@M11To,@M12From,@M12To,'CHI','12')
			INSERT INTO VI_Report_Shipped_All_Fixed_Fiscal (ReportCode,Site,Plant,Year,M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12)
			SELECT '003','Chi','2F',@Year,* FROM dbo.fun_VI_Report_Sum_by_Year_Site_Plant_Fiscal_Period(@Year,@M1From,@M1To,@M2From,@M2To,@M3From,@M3To,@M4From,@M4To,@M5From,@M5To,@M6From,@M6To,@M7From,@M7To,@M8From,@M8To,@M9From,@M9To,@M10From,@M10To,@M11From,@M11To,@M12From,@M12To,'CHI','2F')
			INSERT INTO VI_Report_Shipped_All_Fixed_Fiscal (ReportCode,Site,Plant,Year,M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12)
			SELECT '003','Chi','B3',@Year,* FROM dbo.fun_VI_Report_Sum_by_Year_Site_Plant_Fiscal_Period(@Year,@M1From,@M1To,@M2From,@M2To,@M3From,@M3To,@M4From,@M4To,@M5From,@M5To,@M6From,@M6To,@M7From,@M7To,@M8From,@M8To,@M9From,@M9To,@M10From,@M10To,@M11From,@M11To,@M12From,@M12To,'CHI','B3')
			INSERT INTO VI_Report_Shipped_All_Fixed_Fiscal (ReportCode,Site,Plant,Year,M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12)
			SELECT '003','Chi','B4',@Year,* FROM dbo.fun_VI_Report_Sum_by_Year_Site_Plant_Fiscal_Period(@Year,@M1From,@M1To,@M2From,@M2To,@M3From,@M3To,@M4From,@M4To,@M5From,@M5To,@M6From,@M6To,@M7From,@M7To,@M8From,@M8To,@M9From,@M9To,@M10From,@M10To,@M11From,@M11To,@M12From,@M12To,'CHI','B4')
			INSERT INTO VI_Report_Shipped_All_Fixed_Fiscal (ReportCode,Site,Plant,Year,M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12)
			SELECT '003','Chi','B5',@Year,* FROM dbo.fun_VI_Report_Sum_by_Year_Site_Plant_Fiscal_Period(@Year,@M1From,@M1To,@M2From,@M2To,@M3From,@M3To,@M4From,@M4To,@M5From,@M5To,@M6From,@M6To,@M7From,@M7To,@M8From,@M8To,@M9From,@M9To,@M10From,@M10To,@M11From,@M11To,@M12From,@M12To,'CHI','B5')
			INSERT INTO VI_Report_Shipped_All_Fixed_Fiscal (ReportCode,Site,Plant,Year,M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12)
			SELECT '003','Chi','HK',@Year,* FROM dbo.fun_VI_Report_Sum_by_Year_Site_Plant_Fiscal_Period(@Year,@M1From,@M1To,@M2From,@M2To,@M3From,@M3To,@M4From,@M4To,@M5From,@M5To,@M6From,@M6To,@M7From,@M7To,@M8From,@M8To,@M9From,@M9To,@M10From,@M10To,@M11From,@M11To,@M12From,@M12To,'CHI','HK')
			INSERT INTO VI_Report_Shipped_All_Fixed_Fiscal (ReportCode,Site,Plant,Year,M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12)
			SELECT '003','Chi','P2',@Year,* FROM dbo.fun_VI_Report_Sum_by_Year_Site_Plant_Fiscal_Period(@Year,@M1From,@M1To,@M2From,@M2To,@M3From,@M3To,@M4From,@M4To,@M5From,@M5To,@M6From,@M6To,@M7From,@M7To,@M8From,@M8To,@M9From,@M9To,@M10From,@M10To,@M11From,@M11To,@M12From,@M12To,'CHI','P2')
			INSERT INTO VI_Report_Shipped_All_Fixed_Fiscal (ReportCode,Site,Plant,Year,M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12)
			SELECT '003','Chi','NA',@Year,* FROM dbo.fun_VI_Report_Sum_by_Year_Site_Plant_Fiscal_Period(@Year,@M1From,@M1To,@M2From,@M2To,@M3From,@M3To,@M4From,@M4To,@M5From,@M5To,@M6From,@M6To,@M7From,@M7To,@M8From,@M8To,@M9From,@M9To,@M10From,@M10To,@M11From,@M11To,@M12From,@M12To,'CHI','NA')

			-- Process Site Monthly Shipment Trend   Code:0004
			SET @SQLString='
							DECLARE @Site VARCHAR(50)
							DECLARE Site_C CURSOR FOR 
							SELECT ShipmentSite 
							FROM VI_Report_Site 
							OPEN Site_C
							FETCH NEXT FROM Site_C INTO @Site
							WHILE @@FETCH_STATUS=0
								BEGIN
									-- Process Global Monthly Shipment Trend  Code:0002
									INSERT INTO VI_Report_Shipped_All_Fixed_Fiscal (ReportCode,Site,Plant,Year,M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12)
									SELECT ''004'' AS ReportCode ,@Site AS Site,'''' AS Plant,'+''''+@Year+''''+' AS Year,* FROM dbo.fun_VI_Report_Sum_by_Year_Site_Fiscal_Quarter('+''''+@Year+''''+','+''''+@Q1From+''''+','+''''+@Q1To+''''+','+''''+@Q2From+''''+','+''''+@Q2To+''''+','+''''+@Q3From+''''+','+''''+@Q3To+''''+','+''''+@Q4From+''''+','+''''+@Q4To+''''+',@Site,NULL)								
									FETCH NEXT FROM Site_C INTO @Site
								END
							CLOSE Site_C
							DEALLOCATE Site_C
							'
			EXECUTE (@SQLString)
			-- Process Site(chi) Plant 12 Monthly Shipment Trend   Code:0005
			INSERT INTO VI_Report_Shipped_All_Fixed_Fiscal (ReportCode,Site,Plant,Year,M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12)
			SELECT '005','Chi','12',@Year,* FROM dbo.fun_VI_Report_Sum_by_Year_Site_Plant_Fiscal_Quarter(@Year,@Q1From,@Q1To,@Q2From,@Q2To,@Q3From,@Q3To,@Q4From,@Q4To,'CHI','12')
			INSERT INTO VI_Report_Shipped_All_Fixed_Fiscal (ReportCode,Site,Plant,Year,M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12)
			SELECT '005','Chi','2F',@Year,* FROM dbo.fun_VI_Report_Sum_by_Year_Site_Plant_Fiscal_Quarter(@Year,@Q1From,@Q1To,@Q2From,@Q2To,@Q3From,@Q3To,@Q4From,@Q4To,'CHI','2F')
			INSERT INTO VI_Report_Shipped_All_Fixed_Fiscal (ReportCode,Site,Plant,Year,M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12)
			SELECT '005','Chi','B3',@Year,* FROM dbo.fun_VI_Report_Sum_by_Year_Site_Plant_Fiscal_Quarter(@Year,@Q1From,@Q1To,@Q2From,@Q2To,@Q3From,@Q3To,@Q4From,@Q4To,'CHI','B3')
			INSERT INTO VI_Report_Shipped_All_Fixed_Fiscal (ReportCode,Site,Plant,Year,M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12)
			SELECT '005','Chi','B4',@Year,* FROM dbo.fun_VI_Report_Sum_by_Year_Site_Plant_Fiscal_Quarter(@Year,@Q1From,@Q1To,@Q2From,@Q2To,@Q3From,@Q3To,@Q4From,@Q4To,'CHI','B4')
			INSERT INTO VI_Report_Shipped_All_Fixed_Fiscal (ReportCode,Site,Plant,Year,M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12)
			SELECT '005','Chi','B5',@Year,* FROM dbo.fun_VI_Report_Sum_by_Year_Site_Plant_Fiscal_Quarter(@Year,@Q1From,@Q1To,@Q2From,@Q2To,@Q3From,@Q3To,@Q4From,@Q4To,'CHI','B5')
			INSERT INTO VI_Report_Shipped_All_Fixed_Fiscal (ReportCode,Site,Plant,Year,M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12)
			SELECT '005','Chi','HK',@Year,* FROM dbo.fun_VI_Report_Sum_by_Year_Site_Plant_Fiscal_Quarter(@Year,@Q1From,@Q1To,@Q2From,@Q2To,@Q3From,@Q3To,@Q4From,@Q4To,'CHI','HK')
			INSERT INTO VI_Report_Shipped_All_Fixed_Fiscal (ReportCode,Site,Plant,Year,M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12)
			SELECT '005','Chi','P2',@Year,* FROM dbo.fun_VI_Report_Sum_by_Year_Site_Plant_Fiscal_Quarter(@Year,@Q1From,@Q1To,@Q2From,@Q2To,@Q3From,@Q3To,@Q4From,@Q4To,'CHI','P2')
			INSERT INTO VI_Report_Shipped_All_Fixed_Fiscal (ReportCode,Site,Plant,Year,M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12)
			SELECT '005','Chi','NA',@Year,* FROM dbo.fun_VI_Report_Sum_by_Year_Site_Plant_Fiscal_Quarter(@Year,@Q1From,@Q1To,@Q2From,@Q2To,@Q3From,@Q3To,@Q4From,@Q4To,'CHI','NA')			

			FETCH NEXT FROM Fiscal_Year_C INTO @Year

		END
	CLOSE Fiscal_Year_C
	DEALLOCATE Fiscal_Year_C	

END







GO
