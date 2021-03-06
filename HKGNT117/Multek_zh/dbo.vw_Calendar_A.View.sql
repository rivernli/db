USE [Multek_ZH]
GO
/****** Object:  View [dbo].[vw_Calendar_A]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vw_Calendar_A]
AS
SELECT [calenderDate]
      ,[calenderYear]
      ,[calenderMonth]
      ,[calenderquarter]
      ,[calenderYearWeek]
      ,[calenderWeek]
      ,[enWeek]
      ,[enWeekSub]
      ,[enMonth]
      ,[FiscalYear]
      ,[FiscalYearDesc]
      ,[FiscalQuarter]
      ,[FiscalQuarterDesc]
      ,[FiscalPeriod]
      ,[FiscalPeriodDesc]
      ,[FiscalWeek]
      ,[FiscalWeekDesc]
  FROM [DataWarehouse].[dbo].[DW_DIM_Calender]
  

GO
