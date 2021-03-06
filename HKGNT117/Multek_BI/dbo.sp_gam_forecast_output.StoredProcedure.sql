USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_gam_forecast_output]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








CREATE procedure [dbo].[sp_gam_forecast_output]
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


/*make flat table for view*/
/*
select cusOEM,oemName,plant,cusPart,item,expASP,expASPPeriod,maxASP,minASP,ttlAMT,ttlQty,ttlSQFT,layer,tech,surf
into #template from #tmp 
group by cusOEM,oemName,plant,cusPart,item,expASP,expASPPeriod,maxASP,minASP,ttlAMT,ttlQty,ttlSQFT,layer,tech,surf
*/
/*
select cusOEM,oemName,plant,cusPart,item,expASP,expASPPeriod,maxASP,minASP,ttlAMT,ttlQty,ttlSQFT,layer,tech,surf,isnull(remark,'') as remark
into #template from #tmp left join dbo.gam_customerPart_remark on oemid=oem_id and cusPart=part_no
group by cusOEM,oemName,plant,cusPart,item,expASP,expASPPeriod,maxASP,minASP,ttlAMT,ttlQty,ttlSQFT,layer,tech,surf,remark
*/
/*add salesman at 23/8/2012 */
select oemid,userName,cusOEM,rtrim(oemName) as oemName,plant,cusPart,item,cusASP,expASP,expASPPeriod,maxASP,minASP,ttlAMT,ttlQty,ttlSQFT,layer,tech,surf,isnull(remark,'') as remark
into #template from #tmp left join dbo.gam_customerPart_remark on oemid=oem_id and cusPart=part_no
group by oemid,userName,cusOEM,oemName,plant,cusPart,item,cusASP,expASP,expASPPeriod,maxASP,minASP,ttlAMT,ttlQty,ttlSQFT,layer,tech,surf,remark


--collect future period from #tmp table--
select distinct forecastPeriod into #period from #tmp order by forecastPeriod
declare @fperiod int,@i int,@SQL VarChar(1000)
select @i=0
while exists (select 1 from #period)
begin
	select top 1 @fperiod = forecastPeriod,@i=@i+1 from #period
	if(@i > 13)
		break
	delete #period where forecastPeriod=@fperiod

	SELECT @SQL = 'ALTER TABLE #template ADD [' + convert(varchar(10),@fperiod) + '] float default 0.0'
	Exec (@SQL)
	select @sql = 'update #template set ['+ convert(varchar(10),@fperiod) +']=0; update #template set ['+ convert(varchar(10),@fperiod) +
		']=forecastAmount from #template as p left join '+
		'#tmp as t on p.oemid=t.oemid and p.cuspart=t.cuspart and isnull(p.item,0)=isnull(t.item,0) where t.forecastPeriod='+  convert(varchar(10),@fperiod)
		--'#tmp as t on p.cusOEM=t.cusOEM and p.oemName=t.oemName and p.plant=t.plant and p.cuspart=t.cuspart and isnull(p.item,0)=isnull(t.item,0) where t.forecastPeriod='+  convert(varchar(10),@fperiod)
	exec(@sql)
end
while(@i < 13)
begin
	select @i=@i+1,@fperiod=multek_zh.dbo.fx_getAddPeriod(@current_period,@i),
	@SQL = 'ALTER TABLE #template ADD [' + convert(varchar(10),@fperiod) + '] float default 0.0'
	Exec (@SQL)
	select @sql= 'update #template set [' + convert(varchar(10),@fperiod) + '] =0'
	Exec (@SQL)
	
end

drop table #period
drop table #tmp
alter table #template drop column oemid
select * from #template
drop table #template

set nocount off

/*end*/
/*
SELECT cusOEM,cusPart,item,[201301], [201302] FROM (
 SELECT cusOEM,cusPart,item,forecastPeriod,forecastAmount FROM #tmp  GROUP BY cusOEM,cusPart,item,forecastPeriod,forecastAmount
) as GroupTable
PIVOT
(
 Sum(forecastAmount)
 FOR forecastPeriod IN ([201301], [201302])
) AS PivotTable
order by cusOEM,cusPart
*/









GO
