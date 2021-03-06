USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[KOI_sp_Query_PToday]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[KOI_sp_Query_PToday]
as 

select 
CalendarYear,CalendarYear+'.'+CalenderQuarter as CalenderQuarter,CalendarYear+'.'+CalendarMonth as CalendarMonth,CalendarYear+'.'+CalenderWeek as CalenderWeek, 
FiscalYear,FiscalYear+'.'+FiscalQuarter as FiscalQuarter,FiscalYear+'.'+FiscalPeriod as FiscalPeriod,FiscalYear+'.'+FiscalWeek as FiscalWeek 
from 
(
SELECT 
CONVERT(CHAR(4),GETDATE(),120) AS CalendarYear,
(SELECT CONVERT(varchar,right(100+CalenderQuarter,2)) FROM DataWarehouse.dbo.DW_DIM_Calender  WHERE CalenderDate=CONVERT(VARCHAR(10),GETDATE(),120)) AS CalenderQuarter,
CONVERT(varchar,right(100+month(GETDATE()),2)) AS CalendarMonth,
(SELECT CONVERT(varchar,right(100+calenderWeek,2)) FROM DataWarehouse.dbo.DW_DIM_Calender  WHERE CalenderDate=CONVERT(VARCHAR(10),GETDATE(),120)) AS CalenderWeek, 
(SELECT replace(FiscalYearDesc,' ','') FROM DataWarehouse.dbo.DW_DIM_Calender  WHERE CalenderDate=CONVERT(VARCHAR(10),GETDATE(),120)) AS FiscalYear,
(SELECT CONVERT(varchar,right(100+FiscalQuarter,2)) FROM DataWarehouse.dbo.DW_DIM_Calender  WHERE CalenderDate=CONVERT(VARCHAR(10),GETDATE(),120)) AS FiscalQuarter,
(SELECT CONVERT(varchar,right(100+FiscalPeriod,2)) FROM DataWarehouse.dbo.DW_DIM_Calender  WHERE CalenderDate=CONVERT(VARCHAR(10),GETDATE(),120)) AS FiscalPeriod,
(SELECT CONVERT(varchar,right(100+FiscalWeek,2)) FROM DataWarehouse.dbo.DW_DIM_Calender  WHERE CalenderDate=CONVERT(VARCHAR(10),GETDATE(),120)) AS FiscalWeek 
) tb_Calendar 

GO
