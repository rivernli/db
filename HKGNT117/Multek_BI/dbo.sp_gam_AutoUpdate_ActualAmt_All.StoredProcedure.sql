USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_gam_AutoUpdate_ActualAmt_All]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE procedure [dbo].[sp_gam_AutoUpdate_ActualAmt_All]
as 

set nocount on

declare @cperiod int
select @cperiod = multek_zh.[dbo].[fx_getPeriodDate](default)

/*
update gam_forecast set actual_amt = amt
from gam_forecast, vw_gam_salesActual as upd
where gam_forecast.oem_id = upd.oemid and fiscal_period=iperiod
and actual_amt <> cast(amt as int) and iperiod < @cperiod
*/
update gam_forecast set actual_amt = cast(round(isnull(amt,0),0) as int)
from gam_forecast left join vw_gam_salesActual as upd
on gam_forecast.oem_id = upd.oemid and fiscal_period=iperiod
where fiscal_period <= @cperiod and actual_amt <> cast(round(isnull(amt,0),0) as int)


update gam_forecast set actual_amt = 0 where fiscal_period>=@cperiod

update gam_forecast set actual_amt = amt
from gam_forecast, vw_gam_salesLoad as upd
where gam_forecast.oem_id = upd.oemid and fiscal_period=iperiod
and iperiod >=@cperiod


insert into gam_forecast (oem_id,fiscal_period,fcst_amt,actual_amt,inputed_by,user_type)
select oemid,iperiod,0,amt,0,'n' 
from vw_gam_salesActual left join gam_forecast on oem_id=oemid and fiscal_period=iperiod
where iperiod < @cperiod and fcst_id is null

insert into gam_forecast (oem_id,fiscal_period,fcst_amt,actual_amt,inputed_by,user_type)
select oemid,iperiod,0,amt,0,'n' from vw_gam_salesLoad left join 
gam_forecast on oem_id=oemid and fiscal_period=iperiod
where iperiod >= @cperiod and fcst_id is null




set nocount off


GO
