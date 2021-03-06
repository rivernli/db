USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_gam_forecast_output_vertical]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE procedure [dbo].[sp_gam_forecast_output_vertical]
as
set nocount on


exec sp_gam_forecast_output_prepareUpdateASP



declare @current_period int,@past3month int
select @current_period = multek_zh.[dbo].[fx_getPeriodDate](default), @past3month = multek_zh.dbo.fx_getAddPeriod(@current_period,-3)
--select @current_period = 201210, @past3month = multek_zh.dbo.fx_getAddPeriod(@current_period,-2)

/*get forecast and match last one period ASP*/
create table #tmp (
	forecastPeriod int, cusPart nvarchar(255),
	forecastAmount int, userName nvarchar(255),
	OEMID int, cusOEM nvarchar(500),
	oemName nvarchar(500), plant nvarchar(10),
	item nvarchar(100) null, expASP float null,
	expASPperiod int null, cusASP float default(0),
	maxASP float null, minASP float null,
	layer nvarchar(10), tech nvarchar(100),
	surf nvarchar(100), ttlAmt  int null,
	ttlSqft float null, ttlQty int null
)
insert into #tmp
exec sp_gam_itemsDetailForForecastDownload @current_period

delete #tmp where forecastPeriod <=@current_period

/*match with Tech in past 3 month*/
select OEM,plant,'['+groupTech+']' as groupTech,sum(amount)as ttlAmt,sum(qty) as ttlQTY,sum(sqft) as ttlSQFT ,sum(sqft) as ASP
into #tmp2 from gam_itemsDetail where iperiod between @past3month and @current_period and groupTech <> 'UNKNOW'
group by OEM,plant,groupTech order by oem,plant 
delete #tmp2 where ttlAmt=0 or ttlSQFT=0; update #tmp2 set asp = ttlamt/ttlsqft

update #tmp set tech=groupTech,expASP=asp from #tmp left join #tmp2 
on OEM=oemName and #tmp.plant=#tmp2.plant and charindex(groupTech,cusPart,2)> 0
where tech is null and groupTech is not null

drop table #tmp2
/*end match with Tech in past 3 month*/

/*oem avg ASP*/
select OEM,plant,sum(amount)as ttlAmt,sum(qty) as ttlQTY,sum(sqft) as ttlSQFT,sum(sqft) as ASP
into #tmp3 from gam_itemsDetail where iperiod between @past3month and @current_period
group by OEM,plant order by oem,plant;
delete #tmp3 where ttlAMT=0 or ttlSQFT=0;update #tmp3 set asp = ttlamt/ttlsqft;

update #tmp set expasp=ASP from #tmp left join #tmp3 on oemName=oem and #tmp.plant=#tmp3.plant 
where expasp is null and ASP is not null
drop table #tmp3
/*end oem avg ASP*/

update #tmp set oemName = rtrim(oemName)
--select * from #tmp
/*
select #tmp.*,isnull(remark,'') as remark from #tmp left join dbo.gam_customerPart_remark 
on oemid=oem_id and cusPart=part_no
*/
select #tmp.*,isnull(remark,'') as remark,x.d,x.q from #tmp left join dbo.gam_customerPart_remark 
on oemid=oem_id and cusPart=part_no
left join multek_zh.dbo.vw_calender_start_date_by_period as x on forecastPeriod=ip

drop table #tmp
set nocount off



GO
