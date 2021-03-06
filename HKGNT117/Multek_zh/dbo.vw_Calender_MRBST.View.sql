USE [Multek_ZH]
GO
/****** Object:  View [dbo].[vw_Calender_MRBST]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_Calender_MRBST]
AS
SELECT calenderDate, calenderYear, calenderMonth, 
	CAST(calenderYear AS VARCHAR) + '.' + RIGHT('0' + CAST(calenderMonth AS varchar), 2) AS CalenderMonthDesc, 
    calenderquarter, CAST(calenderYear AS VARCHAR) + '.' + CAST(calenderquarter AS VARCHAR) AS CalenderQuarterDesc, 
	calenderYearWeek AS calenderWeek, CAST(calenderYear AS VARCHAR) + '.W' + RIGHT('0' + CAST(calenderYearWeek AS VARCHAR), 2) AS CalenderWeekDesc,
	enWeek, enMonth, FiscalYear + 1 AS FiscalYear, RTRIM(FiscalYearDesc) AS FiscalYearDesc, FiscalPeriod, 
	RTRIM(FiscalYearDesc) + '.P' + RIGHT('0' + CAST(FiscalPeriod AS VARCHAR), 2) AS FiscalPeriodDesc, 
	FiscalQuarter, RTRIM(FiscalYearDesc) + '.Q' + CAST(FiscalQuarter AS VARCHAR) AS FiscalQuarterDesc,
	FiscalWeek,RTRIM(FiscalYearDesc) + '.FW' + RIGHT('0' + CAST(FiscalWeek AS VARCHAR), 2) AS FiscalWeekDesc
FROM DataWarehouse.dbo.DW_DIM_Calender


GO
