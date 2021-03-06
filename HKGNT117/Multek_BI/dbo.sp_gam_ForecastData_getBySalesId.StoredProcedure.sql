USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_gam_ForecastData_getBySalesId]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









CREATE procedure [dbo].[sp_gam_ForecastData_getBySalesId]
@startPeriod int,
@endPeriod int,
@salesman int = 0
as 

select iperiod from multek_zh.dbo.vw_CalenderLDP where iperiod between @startPeriod and @endPeriod
select OEMID,CusOEM,userName,GroupName,
isnull(fiscal_period,0) as fiscal_period,
isnull(fcst_id,0) as fcst_id,
isnull(fcst_amt_sumByPart,0) as fcst_amt,
isnull(actual_amt,0) as actual_amt,

isnull(ols_adjust,0) as OLS_adjust,
isnull(topSide_adjust,0) as TopSide_adjust

from vw_gam_OEMcomb left join gam_forecast on oemid = oem_id and fiscal_period between @startPeriod and @endPeriod
where isValid=1 and 
(
salesmanid in (select  sysUserId from dbo.fx_getSalesByManager(@salesman)) or 
viewsalesmanid in (select  sysUserId from dbo.fx_getSalesByManager(@salesman))
)
order by userName,cusOEM,oemid

GO
