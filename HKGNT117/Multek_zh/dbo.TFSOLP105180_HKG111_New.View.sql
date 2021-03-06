USE [Multek_ZH]
GO
/****** Object:  View [dbo].[TFSOLP105180_HKG111_New]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




/****** Script for SelectTopNRows command from SSMS  ******/
CREATE VIEW [dbo].[TFSOLP105180_HKG111_New] AS
SELECT [T$LOCA]
      ,[T$ORNO]
      ,[T$PONO]
      ,[T$DATE]
      ,[T$CUNO]
      ,RTRIM([T$DESC]) AS [T$DESC]
      ,[T$DQUA]
      ,[T$AMNT]
      ,[T$ITEM]
      ,[T$CSGS]
      ,[T$DACA]
      ,[T$LAYS]
      ,[T$DOLS]
      ,[T$COST]
      ,[T$SRNB]
      ,REPLACE([T$PLNT],'2F','B2F') AS [T$PLNT]
      ,[T$HKDT]
      ,[T$CCTY]
      ,[T$PRDT]
      ,[T$COTP]
      ,[T$SQFT]
      ,[T$REFCNTD]
      ,[T$REFCNTU]
      ,[calenderDate]
      ,[calenderYear]
      ,'CY'+CAST([calenderYear] AS VARCHAR) AS [calenderYearDesc]
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
  FROM [dbo].[TFSOLP105180_HKG111] t
  LEFT JOIN Calendar_HKG111 c ON t.T$DATE=c.calenderDate
  WHERE t.T$LOCA='Chi'





GO
