USE [Multek_ZH]
GO
/****** Object:  View [dbo].[vw_4RP_HubIn_extDate]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vw_4RP_HubIn_extDate]
as
SELECT     a.iDate, a.location, a.OEM, a.cusId, a.partNumber, a.amount, a.region, a.plant, a.HKDate, b.iPeriod, b.iQuarter, b.FiscalYear AS iYear, c.iPeriod AS hkPeriod, 
                      c.iQuarter AS hkQuarter, c.FiscalYear AS hkYear, b.iMonth, c.iMonth AS hkMonth
FROM     dbo.vw_4RP_HubIn_ext     AS a LEFT OUTER JOIN
                      dbo.vw_calender_ext AS b ON a.iDate = b.iDate LEFT OUTER JOIN
                      dbo.vw_calender_ext AS c ON a.HKDate = c.iDate

GO
