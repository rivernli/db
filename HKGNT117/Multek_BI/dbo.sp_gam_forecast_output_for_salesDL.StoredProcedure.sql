USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_gam_forecast_output_for_salesDL]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE procedure  [dbo].[sp_gam_forecast_output_for_salesDL]
@startPeriod int,
@endPeriod int,
@salesman int = 0,
@plant nvarchar(10) = '',
@oem nvarchar(50) = '',
@oemgroup nvarchar(50) = '',
@subSales bit = 0,
@bkSales bit=0
as 

/*
declare @salesman int, @subSales bit, @bkSales bit,@oem nvarchar(100),@oemgroup nvarchar(100),@plant nvarchar(10),@startPeriod int,@endPeriod int
select @salesman=0,@subSales=1,@bkSales=1,@startPeriod=201301,@endPeriod=201312
select @oem ='sony'
*/
set nocount on


exec sp_gam_forecast_output_prepareUpdateASP

/*get forecast and match last one period ASP*/
select top 0 * into #tmp from vw_gam_itemsDetail__join_Forecast_for_salesDL

if(@subSales =1)
begin
	insert into #tmp select * from vw_gam_itemsDetail__join_Forecast_for_salesDL where ForecastPeriod between @startPeriod and @endPeriod
	and salesmanid in (select sysUserId from dbo.fx_getSalesByManager(@salesman))
	if(@bkSales=1)
	begin
		insert into #tmp select * from vw_gam_itemsDetail__join_Forecast_for_salesDL where ForecastPeriod between @startPeriod and @endPeriod
		and viewsalesmanid in (select sysUserId from dbo.fx_getSalesByManager(@salesman))
	end
end
else
begin
	insert into #tmp select * from vw_gam_itemsDetail__join_Forecast_for_salesDL where ForecastPeriod between @startPeriod and @endPeriod
	and salesmanid  = @salesman
	if(@bkSales=1)
	begin
		insert into #tmp select * from vw_gam_itemsDetail__join_Forecast_for_salesDL where ForecastPeriod between @startPeriod and @endPeriod
		and viewsalesmanid = @salesman
	end

end
if(@plant <> '')
begin
	delete #tmp where plant <> @plant
end
if(@oemgroup <> '')
begin
	delete #tmp where groupname <> @oemgroup
end
if(@oem <> '')
begin
	delete #tmp where cusOEM not like '%' + @oem +'%'
end



declare @current_period int,@past3month int
select @current_period = multek_zh.[dbo].[fx_getPeriodDate](default), @past3month = multek_zh.dbo.fx_getAddPeriod(@current_period,-3)



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



select cusOEM,oemName,plant,cusPart,item,cusASP,expASP,expASPPeriod,maxASP,minASP,ttlAMT,ttlQty,ttlSQFT,layer,tech,surf,isnull(remark,'') as remark
into #template from #tmp left join dbo.gam_customerPart_remark on oemid=oem_id and cusPart=part_no
group by cusOEM,oemName,plant,cusPart,item,cusASP,expASP,expASPPeriod,maxASP,minASP,ttlAMT,ttlQty,ttlSQFT,layer,tech,surf,remark


delete #template from 
#template join gam_cem_oemName on oemName=baanName and cusPart not like '%]%]%]'
--select @@rowcount 

select distinct forecastPeriod into #period from #tmp order by forecastPeriod
declare @fperiod int
while exists (select 1 from #period)
begin
	select top 1 @fperiod = forecastPeriod from #period
	delete #period where forecastPeriod=@fperiod

	Declare @SQL VarChar(1000)
	SELECT @SQL = 'ALTER TABLE #template ADD [' + convert(varchar(10),@fperiod) + '] float default 0.0'
	Exec (@SQL)
	select @sql = 'update #template set ['+ convert(varchar(10),@fperiod) +']=0; update #template set ['+ convert(varchar(10),@fperiod) +
		']=forecastAmount from #template as p left join '+
		'#tmp as t on p.cusOEM=t.cusOEM and p.cuspart=t.cuspart and isnull(p.item,0)=isnull(t.item,0) where t.forecastPeriod='+  convert(varchar(10),@fperiod)
	exec(@sql)

end
drop table #period
drop table #tmp
select * from #template
drop table #template

set nocount off

/*end*/



GO
