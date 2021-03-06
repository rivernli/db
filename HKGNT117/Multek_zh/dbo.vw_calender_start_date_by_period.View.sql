USE [Multek_ZH]
GO
/****** Object:  View [dbo].[vw_calender_start_date_by_period]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vw_calender_start_date_by_period]
as
select iperiod as ip,min(calenderYear) as y, min(calenderMonthDesc)as m, min(calenderDate) as d,
min(fiscalYearDesc) as fy, min(fiscalQuarterDesc) as q, min(fiscalPeriodDesc) as p

from dbo.vw_calender_ext
group by iperiod


GO
