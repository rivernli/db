USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_gam_AutoSave_Forecast_1SalesLog]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[sp_gam_AutoSave_Forecast_1SalesLog]
@msg nvarchar(50) output,
@fcst_period int =''

as


if(@fcst_period ='')
select @fcst_period = multek_zh.[dbo].[fx_getPeriodDate](default)
if not exists(select top 1 * from dbo.gam_part_forecast_log_for_sales where log_period=@fcst_period )
begin
	set @msg = 'success'
	/*
	2013-10-28
	insert into gam_part_forecast_log_for_sales 
	(log_date,period,OEM_id,log_period,Project,amt,qty,price,sqft,asp,remark,isPart,input_userId)
	select 
	getdate(),period,oemId,@fcst_period,project,amt,qty,price,sqft,asp,remark,isPart,input_userId
	from dbo.gam_part_forecast where period > @fcst_period

	--add forecast log updating
	declare @msg2 nvarchar(50)
	insert into gam_forecast_log_for_sales 
	(oem_id,fiscal_period,fcst_amt,fcst_period,submit_date,inputed_by,user_type,OLS_adjust,TopSide_adjust)
	select oem_id,fiscal_period,fcst_amt_SumByPart,@fcst_period,getdate(),inputed_by,user_type ,OLS_adjust,TopSide_adjust
	from dbo.gam_forecast where fiscal_period > @fcst_period
	*/
	
	insert into gam_part_forecast_log_for_sales 
	(log_date,period,OEM_id,log_period,Project,amt,qty,price,sqft,asp,remark,isPart,input_userId)
	select 
	getdate(),period,oemId,@fcst_period,project,amt,qty,price,sqft,asp,remark,isPart,input_userId
	from dbo.gam_part_forecast where period >= @fcst_period
	declare @msg2 nvarchar(50)
	insert into gam_forecast_log_for_sales 
	(oem_id,fiscal_period,fcst_amt,fcst_period,submit_date,inputed_by,user_type,OLS_adjust,TopSide_adjust)
	select oem_id,fiscal_period,fcst_amt_SumByPart,@fcst_period,getdate(),inputed_by,user_type ,OLS_adjust,TopSide_adjust
	from dbo.gam_forecast where fiscal_period >= @fcst_period
end
else
	set @msg = 'failed, already submited this period ' + cast(@fcst_period as varchar(8))








GO
