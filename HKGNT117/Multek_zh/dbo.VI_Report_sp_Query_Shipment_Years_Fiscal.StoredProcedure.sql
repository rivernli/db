USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[VI_Report_sp_Query_Shipment_Years_Fiscal]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[VI_Report_sp_Query_Shipment_Years_Fiscal] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
		
		SELECT RIGHT(rtrim(a.FiscalYearDesc),4) AS FiscalYear,
			   (
					SELECT MIN(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM DataWarehouse.dbo.DW_DIM_Calender b WHERE b.FiscalYearDesc=a.FiscalYearDesc AND b.FiscalPeriod=1
			   ) + ' -> '	+
			   (
					SELECT MAX(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM DataWarehouse.dbo.DW_DIM_Calender b WHERE b.FiscalYearDesc=a.FiscalYearDesc AND b.FiscalPeriod=1
			   ) AS Period1,
			   (
					SELECT MIN(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM DataWarehouse.dbo.DW_DIM_Calender b WHERE b.FiscalYearDesc=a.FiscalYearDesc AND b.FiscalPeriod=2
			   ) + ' -> '	+
			   (
					SELECT MAX(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM DataWarehouse.dbo.DW_DIM_Calender b WHERE b.FiscalYearDesc=a.FiscalYearDesc AND b.FiscalPeriod=2
			   ) AS Period2,
			   (
					SELECT MIN(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM DataWarehouse.dbo.DW_DIM_Calender b WHERE b.FiscalYearDesc=a.FiscalYearDesc AND b.FiscalPeriod=3
			   ) + ' -> '	+
			   (
					SELECT MAX(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM DataWarehouse.dbo.DW_DIM_Calender b WHERE b.FiscalYearDesc=a.FiscalYearDesc AND b.FiscalPeriod=3
			   ) AS Period3,
			   (
					SELECT MIN(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM DataWarehouse.dbo.DW_DIM_Calender b WHERE b.FiscalYearDesc=a.FiscalYearDesc AND b.FiscalPeriod=4
			   ) + ' -> '	+
			   (
					SELECT MAX(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM DataWarehouse.dbo.DW_DIM_Calender b WHERE b.FiscalYearDesc=a.FiscalYearDesc AND b.FiscalPeriod=4
			   ) AS Period4,
			   (
					SELECT MIN(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM DataWarehouse.dbo.DW_DIM_Calender b WHERE b.FiscalYearDesc=a.FiscalYearDesc AND b.FiscalPeriod=5
			   ) + ' -> '	+
			   (
					SELECT MAX(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM DataWarehouse.dbo.DW_DIM_Calender b WHERE b.FiscalYearDesc=a.FiscalYearDesc AND b.FiscalPeriod=5
			   ) AS Period5,
			   (
					SELECT MIN(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM DataWarehouse.dbo.DW_DIM_Calender b WHERE b.FiscalYearDesc=a.FiscalYearDesc AND b.FiscalPeriod=6
			   ) + ' -> '	+
			   (
					SELECT MAX(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM DataWarehouse.dbo.DW_DIM_Calender b WHERE b.FiscalYearDesc=a.FiscalYearDesc AND b.FiscalPeriod=6
			   ) AS Period6,
			   (
					SELECT MIN(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM DataWarehouse.dbo.DW_DIM_Calender b WHERE b.FiscalYearDesc=a.FiscalYearDesc AND b.FiscalPeriod=7
			   ) + ' -> '	+
			   (
					SELECT MAX(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM DataWarehouse.dbo.DW_DIM_Calender b WHERE b.FiscalYearDesc=a.FiscalYearDesc AND b.FiscalPeriod=7
			   ) AS Period7,
			   (
					SELECT MIN(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM DataWarehouse.dbo.DW_DIM_Calender b WHERE b.FiscalYearDesc=a.FiscalYearDesc AND b.FiscalPeriod=8
			   ) + ' -> '	+
			   (
					SELECT MAX(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM DataWarehouse.dbo.DW_DIM_Calender b WHERE b.FiscalYearDesc=a.FiscalYearDesc AND b.FiscalPeriod=8
			   ) AS Period8,
			   (
					SELECT MIN(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM DataWarehouse.dbo.DW_DIM_Calender b WHERE b.FiscalYearDesc=a.FiscalYearDesc AND b.FiscalPeriod=9
			   ) + ' -> '	+
			   (
					SELECT MAX(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM DataWarehouse.dbo.DW_DIM_Calender b WHERE b.FiscalYearDesc=a.FiscalYearDesc AND b.FiscalPeriod=9
			   ) AS Period9,
			   (
					SELECT MIN(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM DataWarehouse.dbo.DW_DIM_Calender b WHERE b.FiscalYearDesc=a.FiscalYearDesc AND b.FiscalPeriod=10
			   ) + ' -> '	+
			   (
					SELECT MAX(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM DataWarehouse.dbo.DW_DIM_Calender b WHERE b.FiscalYearDesc=a.FiscalYearDesc AND b.FiscalPeriod=10
			   ) AS Period10,
			   (
					SELECT MIN(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM DataWarehouse.dbo.DW_DIM_Calender b WHERE b.FiscalYearDesc=a.FiscalYearDesc AND b.FiscalPeriod=11
			   ) + ' -> '	+
			   (
					SELECT MAX(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM DataWarehouse.dbo.DW_DIM_Calender b WHERE b.FiscalYearDesc=a.FiscalYearDesc AND b.FiscalPeriod=11
			   ) AS Period11,
			   (
					SELECT MIN(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM DataWarehouse.dbo.DW_DIM_Calender b WHERE b.FiscalYearDesc=a.FiscalYearDesc AND b.FiscalPeriod=12
			   ) + ' -> '	+
			   (
					SELECT MAX(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM DataWarehouse.dbo.DW_DIM_Calender b WHERE b.FiscalYearDesc=a.FiscalYearDesc AND b.FiscalPeriod=12
			   ) AS Period12,
			   (
					SELECT MIN(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM DataWarehouse.dbo.DW_DIM_Calender b WHERE b.FiscalYearDesc=a.FiscalYearDesc AND b.FiscalQuarter=1
			   ) + ' -> '	+
			   (
					SELECT MAX(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM DataWarehouse.dbo.DW_DIM_Calender b WHERE b.FiscalYearDesc=a.FiscalYearDesc AND b.FiscalQuarter=1
			   ) AS Quarter1,
			   (
					SELECT MIN(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM DataWarehouse.dbo.DW_DIM_Calender b WHERE b.FiscalYearDesc=a.FiscalYearDesc AND b.FiscalQuarter=2
			   ) + ' -> '	+
			   (
					SELECT MAX(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM DataWarehouse.dbo.DW_DIM_Calender b WHERE b.FiscalYearDesc=a.FiscalYearDesc AND b.FiscalQuarter=2
			   ) AS Quarter2,
			   (
					SELECT MIN(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM DataWarehouse.dbo.DW_DIM_Calender b WHERE b.FiscalYearDesc=a.FiscalYearDesc AND b.FiscalQuarter=3
			   ) + ' -> '	+
			   (
					SELECT MAX(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM DataWarehouse.dbo.DW_DIM_Calender b WHERE b.FiscalYearDesc=a.FiscalYearDesc AND b.FiscalQuarter=3
			   ) AS Quarter3,
			   (
					SELECT MIN(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM DataWarehouse.dbo.DW_DIM_Calender b WHERE b.FiscalYearDesc=a.FiscalYearDesc AND b.FiscalQuarter=4
			   ) + ' -> '	+
			   (
					SELECT MAX(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM DataWarehouse.dbo.DW_DIM_Calender b WHERE b.FiscalYearDesc=a.FiscalYearDesc AND b.FiscalQuarter=4
			   ) AS Quarter4
		
		FROM (
				SELECT TOP 5 FiscalYearDesc
				FROM DataWarehouse.dbo.DW_DIM_Calender 
				WHERE LEFT(FiscalYearDesc,2)='FY'
				GROUP BY FiscalYearDesc
				ORDER BY FiscalYearDesc DESC
			  ) a

		ORDER BY FiscalYear DESC

END



GO
