USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[ShipmentReport_sp_Automatically_Process_Fiscal_TOP_20_OEM_Customer_By_Loc_Detail]    Script Date: 11/06/2014 15:47:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ShipmentReport_sp_Automatically_Process_Fiscal_TOP_20_OEM_Customer_By_Loc_Detail]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SET NOCOUNT ON;

    DECLARE @Year CHAR(4),@i INT,@SQLString VARCHAR(8000),
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
	TRUNCATE TABLE ShipmentReport_Shipped_All_Fixed_Top_20_Customer_Fiscal_By_Loc
	TRUNCATE TABLE ShipmentReport_Shipped_All_Fixed_Top_20_OEM_Fiscal_By_Loc

	SET @i=1
	DECLARE Fiscal_Year_C CURSOR FOR
	SELECT TOP 5 FiscalYear
	FROM ce3p1179.dbo.Calender
	GROUP BY FiscalYear
	ORDER BY FiscalYear DESC
	OPEN Fiscal_Year_C
	FETCH NEXT FROM Fiscal_Year_C INTO @Year
	WHILE @@FETCH_STATUS=0
		BEGIN
			SET @M1From=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM ce3p1179.dbo.Calender WHERE FiscalYear=@Year AND FiscalPeriod=1) 
			SET @M1To=  (SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM ce3p1179.dbo.Calender WHERE FiscalYear=@Year AND FiscalPeriod=1) 
			SET @M2From=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM ce3p1179.dbo.Calender WHERE FiscalYear=@Year AND FiscalPeriod=2) 
			SET @M2To=  (SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM ce3p1179.dbo.Calender WHERE FiscalYear=@Year AND FiscalPeriod=2) 
			SET @M3From=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM ce3p1179.dbo.Calender WHERE FiscalYear=@Year AND FiscalPeriod=3) 
			SET @M3To=  (SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM ce3p1179.dbo.Calender WHERE FiscalYear=@Year AND FiscalPeriod=3) 
			SET @M4From=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM ce3p1179.dbo.Calender WHERE FiscalYear=@Year AND FiscalPeriod=4) 
			SET @M4To=  (SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM ce3p1179.dbo.Calender WHERE FiscalYear=@Year AND FiscalPeriod=4) 
			SET @M5From=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM ce3p1179.dbo.Calender WHERE FiscalYear=@Year AND FiscalPeriod=5) 
			SET @M5To=  (SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM ce3p1179.dbo.Calender WHERE FiscalYear=@Year AND FiscalPeriod=5) 
			SET @M6From=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM ce3p1179.dbo.Calender WHERE FiscalYear=@Year AND FiscalPeriod=6) 
			SET @M6To=  (SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM ce3p1179.dbo.Calender WHERE FiscalYear=@Year AND FiscalPeriod=6) 
			SET @M7From=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM ce3p1179.dbo.Calender WHERE FiscalYear=@Year AND FiscalPeriod=7) 
			SET @M7To=  (SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM ce3p1179.dbo.Calender WHERE FiscalYear=@Year AND FiscalPeriod=7) 
			SET @M8From=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM ce3p1179.dbo.Calender WHERE FiscalYear=@Year AND FiscalPeriod=8) 
			SET @M8To=  (SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM ce3p1179.dbo.Calender WHERE FiscalYear=@Year AND FiscalPeriod=8) 
			SET @M9From=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM ce3p1179.dbo.Calender WHERE FiscalYear=@Year AND FiscalPeriod=9) 
			SET @M9To=  (SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM ce3p1179.dbo.Calender WHERE FiscalYear=@Year AND FiscalPeriod=9) 
			SET @M10From=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM ce3p1179.dbo.Calender WHERE FiscalYear=@Year AND FiscalPeriod=10) 
			SET @M10To=  (SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM ce3p1179.dbo.Calender WHERE FiscalYear=@Year AND FiscalPeriod=10) 
			SET @M11From=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM ce3p1179.dbo.Calender WHERE FiscalYear=@Year AND FiscalPeriod=11) 
			SET @M11To=  (SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM ce3p1179.dbo.Calender WHERE FiscalYear=@Year AND FiscalPeriod=11) 
			SET @M12From=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM ce3p1179.dbo.Calender WHERE FiscalYear=@Year AND FiscalPeriod=12) 
			SET @M12To=  (SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM ce3p1179.dbo.Calender WHERE FiscalYear=@Year AND FiscalPeriod=12) 
			SET @Q1From=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM ce3p1179.dbo.Calender WHERE FiscalYear=@Year AND FiscalQuarter=1) 
			SET @Q1To=  (SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM ce3p1179.dbo.Calender WHERE FiscalYear=@Year AND FiscalQuarter=1) 
			SET @Q2From=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM ce3p1179.dbo.Calender WHERE FiscalYear=@Year AND FiscalQuarter=2) 
			SET @Q2To=  (SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM ce3p1179.dbo.Calender WHERE FiscalYear=@Year AND FiscalQuarter=2) 
			SET @Q3From=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM ce3p1179.dbo.Calender WHERE FiscalYear=@Year AND FiscalQuarter=3) 
			SET @Q3To=  (SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM ce3p1179.dbo.Calender WHERE FiscalYear=@Year AND FiscalQuarter=3) 
			SET @Q4From=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM ce3p1179.dbo.Calender WHERE FiscalYear=@Year AND FiscalQuarter=4) 
			SET @Q4To=  (SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM ce3p1179.dbo.Calender WHERE FiscalYear=@Year AND FiscalQuarter=4) 
			-- Chi Process Top 20 Customers    
			EXECUTE ShipmentReport_sp_Query_TOP_20_Customer_Yearly_Shipment_Trend_Fiscal_Sum_By_Loc @Year=@Year,@DateFrom=@M1From,@DateTo=@M12To,@Loc='Chi'
			-- Chi Process Top 20 OEMs			
			EXECUTE ShipmentReport_sp_Query_TOP_20_OEM_Yearly_Shipment_Trend_Fiscal_Sum_By_Loc @Year=@Year,@DateFrom=@M1From,@DateTo=@M12To,@Loc='Chi'
			-- Dis Process Top 20 Customers    
			EXECUTE ShipmentReport_sp_Query_TOP_20_Customer_Yearly_Shipment_Trend_Fiscal_Sum_By_Loc @Year=@Year,@DateFrom=@M1From,@DateTo=@M12To,@Loc='Dis'
			-- Dis Process Top 20 OEMs			
			EXECUTE ShipmentReport_sp_Query_TOP_20_OEM_Yearly_Shipment_Trend_Fiscal_Sum_By_Loc @Year=@Year,@DateFrom=@M1From,@DateTo=@M12To,@Loc='Dis'

			SET @i=@i+1
			FETCH NEXT FROM Fiscal_Year_C INTO @Year

		END
	CLOSE Fiscal_Year_C
	DEALLOCATE Fiscal_Year_C

	UPDATE ShipmentReport_Shipped_All_Fixed_Top_20_Customer_Fiscal_By_Loc
	SET Amount=B1Amount+B12Amount+B2FAmount+B3Amount+B4Amount+B5Amount+HKAmount
	WHERE Loc='Chi'

	UPDATE ShipmentReport_Shipped_All_Fixed_Top_20_OEM_Fiscal_By_Loc
	SET Amount=B1Amount+B12Amount+B2FAmount+B3Amount+B4Amount+B5Amount+HKAmount
	WHERE Loc='Chi'

END
GO
