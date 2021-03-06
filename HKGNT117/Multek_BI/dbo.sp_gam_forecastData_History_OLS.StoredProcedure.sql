USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_gam_forecastData_History_OLS]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_gam_forecastData_History_OLS] @oemid int,@period int
as

select multek_zh.dbo.fx_getCurrentPeriod() as InPeriod,fcst_amt_sumByPart as amt,ols_adjust as ols,topSide_adjust  as topside
from gam_forecast where oem_id=@oemid and fiscal_period=@period

select top 6 submit_date as save_date,fcst_period as InPeriod,fcst_amt as amt, ols_adjust as ols ,topside_adjust  as topside
from gam_forecast_log where oem_id=@oemid and fiscal_period=@period
order by fcst_period desc
GO
