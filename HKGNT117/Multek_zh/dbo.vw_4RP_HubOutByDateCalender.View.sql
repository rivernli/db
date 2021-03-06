USE [Multek_ZH]
GO
/****** Object:  View [dbo].[vw_4RP_HubOutByDateCalender]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[vw_4RP_HubOutByDateCalender]
as
SELECT     a.iDate, dbo.fx_getFiscalYearAndPeriod(b.FiscalYear, b.FiscalPeriod) AS iPeriod, dbo.fx_getFiscalYearAndPeriod(b.FiscalYear, b.FiscalQuarter) AS iQuarter, 
                      b.FiscalYear, b.FiscalPeriod, b.FiscalQuarter, a.OEM, a.amt
FROM         dbo.vw_4RP_HubOutByDate AS a INNER JOIN
                          (SELECT     CONVERT(varchar(8), calenderDate, 112) AS cDate, FiscalYear, FiscalPeriod, FiscalQuarter
                            FROM          dbo.vw_Calender) AS b ON a.iDate = b.cDate
GO
