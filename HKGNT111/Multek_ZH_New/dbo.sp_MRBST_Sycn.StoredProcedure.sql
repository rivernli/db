USE [Multek_ZH_New]
GO
/****** Object:  StoredProcedure [dbo].[sp_MRBST_Sycn]    Script Date: 11/06/2014 15:50:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_MRBST_Sycn]
AS
	TRUNCATE TABLE MRBST_Calender
	INSERT INTO MRBST_Calender
		SELECT calenderDate, 
		calenderYear, 
		calenderMonth, 
		CAST(calenderYear AS VARCHAR) + '.' + RIGHT('0' + CAST(calenderMonth AS varchar), 2) AS CalenderMonthDesc, 
		calenderquarter, 
		CAST(calenderYear AS VARCHAR) + '.' + CAST(calenderquarter AS VARCHAR) AS CalenderQuarterDesc, 
		calenderYearWeek AS calenderWeek, 
		CAST(calenderYear AS VARCHAR) + '.W' + RIGHT('0' + CAST(calenderYearWeek AS VARCHAR), 2) AS CalenderWeekDesc,
		enWeek, 
		enMonth, 
		FiscalYear + 1 AS FiscalYear, RTRIM(FiscalYearDesc) AS FiscalYearDesc, 
		FiscalPeriod, 
		RTRIM(FiscalYearDesc) + '.P' + RIGHT('0' + CAST(FiscalPeriod AS VARCHAR), 2) AS FiscalPeriodDesc, 
		FiscalQuarter, RTRIM(FiscalYearDesc) + '.Q' + CAST(FiscalQuarter AS VARCHAR) AS FiscalQuarterDesc,
		FiscalWeek,RTRIM(FiscalYearDesc) + '.FW' + RIGHT('0' + CAST(FiscalWeek AS VARCHAR), 2) AS FiscalWeekDesc
	FROM hkgnt117.DataWarehouse.dbo.DW_DIM_Calender WHERE calenderYear > 2007

	EXEC dbo.sp_MRBST_Sycn_Weekly_V1
	EXEC dbo.sp_MRBST_Sycn_Weekly_V2
	EXEC dbo.sp_MRBST_Sycn_Level31
	EXEC dbo.sp_MRBST_Sycn_Level33
	EXEC dbo.sp_MRBST_Sycn_Suggestion
	EXEC dbo.sp_MRBST_Sycn_TargetLine
GO
