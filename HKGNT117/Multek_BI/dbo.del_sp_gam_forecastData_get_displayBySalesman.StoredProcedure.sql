USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[del_sp_gam_forecastData_get_displayBySalesman]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE procedure [dbo].[del_sp_gam_forecastData_get_displayBySalesman] @startPeriod int,@endPeriod int,@salesman int=0
as
set nocount on

select iperiod from multek_zh.dbo.vw_CalenderLDP where iperiod between @startPeriod and @endPeriod
select salesmanId,userName,
isnull(fiscal_period,0) as fiscal_period,
sum(isnull(fcst_amt_sumByPart,0)) as fcst_amt,
sum(isnull(actual_amt,0)) as actual_amt,
sum(isnull(ols_adjust,0)) as OLS_adjust,
sum(isnull(topSide_adjust,0)) as TopSide_adjust

from vw_gam_OEMcomb left join gam_forecast on oemid = oem_id and fiscal_period between @startPeriod and @endPeriod
where isValid=1 and fiscal_period is not null and
(
salesmanid in (select  sysUserId from dbo.fx_getSalesByManager(@salesman)) or 
viewsalesmanid in (select  sysUserId from dbo.fx_getSalesByManager(@salesman))
)
group by salesmanId,userName,fiscal_period

set nocount off
GO
