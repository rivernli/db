USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_gam_AutoSave_ForecastPartLog]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[sp_gam_AutoSave_ForecastPartLog]
@msg nvarchar(50) output,
@fcst_period int =''
as


if(@fcst_period ='')
select @fcst_period = multek_zh.[dbo].[fx_getPeriodDate](default)
if not exists(select top 1 * from dbo.gam_part_forecast_log where log_period=@fcst_period )
begin
	set @msg = 'success'
	/*
	2013-10-28
	insert into gam_part_forecast_log 
	(log_date,period,OEM_id,log_period,Project,amt,qty,price,sqft,asp,remark,isPart,input_userId)
	select 
	getdate(),period,oemId,@fcst_period,project,amt,qty,price,sqft,asp,remark,isPart,input_userId
	from dbo.gam_part_forecast where period > @fcst_period
	*/
	insert into gam_part_forecast_log 
	(log_date,period,OEM_id,log_period,Project,amt,qty,price,sqft,asp,remark,isPart,input_userId)
	select 
	getdate(),period,oemId,@fcst_period,project,amt,qty,price,sqft,asp,remark,isPart,input_userId
	from dbo.gam_part_forecast where period >= @fcst_period
	--add forecast log updating
	declare @msg2 nvarchar(50)
	exec [sp_gam_AutoSave_ForecastLog] @msg2 output, @fcst_period


end
else
	set @msg = 'failed, already submited this period ' + cast(@fcst_period as varchar(8))








GO
