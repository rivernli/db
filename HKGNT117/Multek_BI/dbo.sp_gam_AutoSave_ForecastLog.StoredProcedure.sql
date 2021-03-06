USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_gam_AutoSave_ForecastLog]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE procedure [dbo].[sp_gam_AutoSave_ForecastLog]
@msg nvarchar(50) output,
@fcst_period int =''

as

--declare @fcst_period int
if(@fcst_period ='')
select @fcst_period = multek_zh.[dbo].[fx_getPeriodDate](default)
if not exists(select top 1 * from dbo.gam_forecast_log where fcst_period=@fcst_period )
begin
	set @msg = 'success'
/*
2013-10-28
	insert into gam_forecast_log 
	(oem_id,fiscal_period,fcst_amt,fcst_period,submit_date,inputed_by,user_type,OLS_adjust,TopSide_adjust)
	select oem_id,fiscal_period,fcst_amt_SumByPart,@fcst_period,getdate(),inputed_by,user_type,OLS_adjust,TopSide_adjust 
	from dbo.gam_forecast where fiscal_period > @fcst_period
*/
	insert into gam_forecast_log 
	(oem_id,fiscal_period,fcst_amt,fcst_period,submit_date,inputed_by,user_type,OLS_adjust,TopSide_adjust)
	select oem_id,fiscal_period,fcst_amt_SumByPart,@fcst_period,getdate(),inputed_by,user_type,OLS_adjust,TopSide_adjust 
	from dbo.gam_forecast where fiscal_period >= @fcst_period

end
else
	set @msg = 'failed, already submited this period ' + cast(@fcst_period as varchar(8))





GO
