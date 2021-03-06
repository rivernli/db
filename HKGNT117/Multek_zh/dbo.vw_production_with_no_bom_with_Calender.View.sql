USE [Multek_ZH]
GO
/****** Object:  View [dbo].[vw_production_with_no_bom_with_Calender]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create VIEW [dbo].[vw_production_with_no_bom_with_Calender]
AS
SELECT     RIGHT(dbo.fx_trim(Year), 4) AS fiscalYear, dbo.fx_getQuarterByPeriod(period) AS fiscalQuarter, period AS fiscalPeriod, period, factory, department, sub_work_center, 
                      item_group, item, qty, price, amount, Year, weekly, issue_date
FROM         dbo.vw_production_with_no_bom_report

GO
