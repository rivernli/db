USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_gam_cem_forecast_mix_result_download_vertical]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_gam_cem_forecast_mix_result_download_vertical]
as
set nocount on

declare @currentPeriod int,@nextPeriod int,@i int
select @i=1,@currentPeriod=multek_zh.[dbo].[fx_getPeriodDate](default),@nextPeriod=multek_zh.dbo.fx_getAddPeriod(@currentPeriod,@i)

if not exists (select top 1 1 from gam_CEM_mix_Sales_forecast_result where period=@currentPeriod  and username='CEM')
begin
	exec [sp_gam_cem_forecast_mix_result]
end

select @nextPeriod as forecastPeriod,cpn as cusPart,p1 as forecastAmt,
userName,0 as oemid,cusOEM,oemName,plant,ipn as item,expASP,expASPPeriod,cusASP,maxASP,minASP,
layer,tech,surf,ttlAMt,ttlSQFT,ttlQty,remark
into #tmp from gam_CEM_mix_Sales_forecast_result where period=@currentPeriod

declare @sql nvarchar(500)
while(@i <=12)
begin
	select @i=@i+1,@nextPeriod=multek_zh.dbo.fx_getAddPeriod(@currentPeriod,@i)

	select @sql = N'insert into #tmp 
	select ' + cast(@nextPeriod as nchar(6)) +N' as forecastPeriod,cpn as cusPart,p'+ cast(@i as nchar(3)) +N' as forecastAmt,
	userName,0 as oemid,cusOEM,oemName,plant,ipn as item,expASP,expASPPeriod,cusASP,maxASP,minASP,layer,tech,surf,ttlAMt,ttlSQFT,ttlQty,remark
	from gam_CEM_mix_Sales_forecast_result where period='+ cast(@currentPeriod as nchar(6))
	exec sp_executesql @sql
end


select #tmp.*,x.d,x.q from #tmp 
left join multek_zh.dbo.vw_calender_start_date_by_period as x on forecastPeriod=ip
order by cusOEM,cusPart,forecastPeriod

drop table #tmp
set nocount off
GO
