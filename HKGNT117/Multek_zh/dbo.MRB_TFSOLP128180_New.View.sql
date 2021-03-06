USE [Multek_ZH]
GO
/****** Object:  View [dbo].[MRB_TFSOLP128180_New]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








CREATE View [dbo].[MRB_TFSOLP128180_New] as

SELECT
	REPLACE(RTRIM([T$PLNT]),'2F','B2F') AS [T$PLNT]
      ,[T$PJNO]
      ,[T$LCNT]
      ,[T$ITEM]
      ,[T$UCOS]
      ,[T$USQF]
      ,RTRIM([T$CUST]) AS [T$CUST]
      ,RTRIM([T$OEMN]) AS [T$OEMN]
      ,RTRIM([T$TECH]) AS [T$TECH]
      ,[T$MDSC]
      ,[T$SDSC]
      ,[T$PROC]
      ,[T$SURF]
      ,[T$CWOC]
      ,[T$DATE]
      ,[T$QTYI]
      ,[T$QSQF]
      ,[T$MRBQ]
      ,[T$MSQF]
      ,[T$MCOS]
      ,[T$ICOS]
      ,[T$OUTE]
      ,[T$TYPE]
      ,[T$JDAT]
      ,[T$REFCNTD]
      ,[T$REFCNTU]
      ,[calenderDate]
      ,[calenderYear]
      ,('CY'+CAST([calenderYear] AS VARCHAR)) AS [calenderYearDesc]
      ,[calenderMonth]
      ,('CY'+RIGHT(CAST([calenderYear] AS VARCHAR),2)+'P'+CAST([calenderMonth] AS VARCHAR)) AS [calenderMonthDesc]
      ,[calenderquarter]
      ,('CY'+RIGHT(CAST([calenderYear] AS VARCHAR),2)+'Q'+CAST([calenderQuarter] AS VARCHAR)) AS [calenderQuarterDesc]
      ,[calenderWeek]
      ,('CY'+RIGHT(CAST([calenderYear] AS VARCHAR),2)+'W'+CAST([calenderWeek] AS VARCHAR)) AS [calenderWeekDesc]
      ,[enWeek]
      ,[enMonth]
      ,[FiscalYear]
      ,[FiscalYearDesc]
      ,[FiscalPeriod]
      ,('FY'+RIGHT([FiscalYear],2)+'P'+CAST([FiscalPeriod] AS VARCHAR)) AS [FiscalPeriodDesc]
      ,[FiscalQuarter]
      ,('FY'+RIGHT([FiscalYear],2)+'Q'+CAST([FiscalQuarter] AS VARCHAR)) AS [FiscalQuarterDesc]
      ,[FiscalPeriodFrom]
      ,[FiscalPeriodTo]
      ,[FiscalYearFrom]
      ,[FiscalYearTo]
      ,[FiscalQuarterFrom]
      ,[FiscalQuarterTo]
      ,[FiscalWeek]
      --,[FiscalWeekDesc]
      ,('FY'+RIGHT([FiscalYear],2)+'W'+CAST([FiscalWeek] AS VARCHAR)) AS [FiscalWeekDesc]
      ,[FiscalWeekFrom]
      ,[FiscalWeekTo]
FROM TFSOLP128180 t
LEFT JOIN Calendar_HKG111 c ON t.T$DATE=c.calenderDate










GO
