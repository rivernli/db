USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_gam_ForecastData_getAllCriteria]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[sp_gam_ForecastData_getAllCriteria]
@startPeriod int,
@endPeriod int,
@salesman int = 0,
@plant nvarchar(10) = '',
@oem nvarchar(50) = '',
@oemgroup nvarchar(50) = '',
@subSales bit = 0,
@bkSales bit=0
as 

declare @cperiod int
declare @iperiod int
select @cperiod = multek_zh.[dbo].[fx_getPeriodDate](default)
select @iperiod = multek_zh.dbo.fx_getAddPeriod(@cperiod,-3),@cperiod=multek_zh.dbo.fx_getAddPeriod(@cperiod,1)


if exists (select 1 from multek_zh.dbo.vw_CalenderLDP where iperiod = @endperiod)
begin
	select  iperiod from multek_zh.dbo.vw_CalenderLDP where iperiod between @startPeriod and @endperiod 
	order by iperiod
end
else
begin
	declare @ydiff int
	select @ydiff =(cast(substring(cast(@startPeriod as varchar(6)),1,4) as int)-2000) *100
	select iperiod + @ydiff as iperiod from multek_zh.dbo.vw_CalenderLDP where iperiod between (@startPeriod-@ydiff) and (@endPeriod-@ydiff) 
	order by iperiod
end


select top 0 OEMID,CusOEM,userName,GroupName,plant,isnull(fiscal_period,0) as fiscal_period,
isnull(fcst_id,0) as fcst_id,isnull(fcst_amt_SumByPart,0) as fcst_amt,isnull(actual_amt,0) as actual_amt,0 as isViewActual,
ols_adjust,topside_adjust
into #tmp from vw_gam_OEMcomb left join gam_forecast on oemid = oem_id
where isValid=1

if(@subSales =1)
begin
	insert into #tmp 
	select OEMID,CusOEM,userName,GroupName,plant,isnull(fiscal_period,0) as fiscal_period,
	isnull(fcst_id,0) as fcst_id,isnull(fcst_amt_SumByPart,0) as fcst_amt,isnull(actual_amt,0) as actual_amt,0
	,ols_adjust,topside_adjust
	from vw_gam_OEMcomb left join gam_forecast on oemid = oem_id and fiscal_period between @startPeriod and @endPeriod
	where isValid=1 and salesmanid in (select sysUserId from dbo.fx_getSalesByManager(@salesman))

	/*for actual view*/
	insert into #tmp 
	select OEMID,CusOEM,userName,GroupName,plant,isnull(fiscal_period,0) as fiscal_period,
	isnull(fcst_id,0) as fcst_id,isnull(fcst_amt_SumByPart,0) as fcst_amt,isnull(actual_amt,0) as actual_amt,1
	,ols_adjust,topside_adjust
	from vw_gam_OEMcomb left join gam_forecast on oemid = oem_id and fiscal_period between @iperiod and @cperiod
	where isValid=1 and salesmanid in (select sysUserId from dbo.fx_getSalesByManager(@salesman))	
	

	if(@bkSales=1)
	begin
		insert into #tmp
		select OEMID,CusOEM,userName,GroupName,plant,isnull(fiscal_period,0) as fiscal_period,
		isnull(fcst_id,0) as fcst_id,isnull(fcst_amt_SumByPart,0) as fcst_amt,isnull(actual_amt,0) as actual_amt,0
		,ols_adjust,topside_adjust
		from vw_gam_OEMcomb left join gam_forecast on oemid = oem_id and fiscal_period between @startPeriod and @endPeriod
		where isValid=1 and	viewsalesmanid in (select sysUserId from dbo.fx_getSalesByManager(@salesman))
		/*for actual view*/
		insert into #tmp
		select OEMID,CusOEM,userName,GroupName,plant,isnull(fiscal_period,0) as fiscal_period,
		isnull(fcst_id,0) as fcst_id,isnull(fcst_amt_SumByPart,0) as fcst_amt,isnull(actual_amt,0) as actual_amt,1
		,ols_adjust,topside_adjust
		from vw_gam_OEMcomb left join gam_forecast on oemid = oem_id and fiscal_period between @iPeriod and @cPeriod
		where isValid=1 and	viewsalesmanid in (select sysUserId from dbo.fx_getSalesByManager(@salesman))
	end
end
else
begin
	insert into #tmp
	select OEMID,CusOEM,userName,GroupName,plant,isnull(fiscal_period,0) as fiscal_period,
	isnull(fcst_id,0) as fcst_id,isnull(fcst_amt_SumByPart,0) as fcst_amt,isnull(actual_amt,0) as actual_amt,0
	,ols_adjust,topside_adjust
	from vw_gam_OEMcomb left join gam_forecast on oemid = oem_id and fiscal_period between @startPeriod and @endPeriod
	where isValid=1 and salesmanid = @salesman
	/*for actual view*/
	insert into #tmp
	select OEMID,CusOEM,userName,GroupName,plant,isnull(fiscal_period,0) as fiscal_period,
	isnull(fcst_id,0) as fcst_id,isnull(fcst_amt_SumByPart,0) as fcst_amt,isnull(actual_amt,0) as actual_amt,1
	,ols_adjust,topside_adjust
	from vw_gam_OEMcomb left join gam_forecast on oemid = oem_id and fiscal_period between @iPeriod and @cPeriod
	where isValid=1 and salesmanid = @salesman

	if(@bkSales=1)
	begin
		insert into #tmp
		select OEMID,CusOEM,userName,GroupName,plant,isnull(fiscal_period,0) as fiscal_period,
		isnull(fcst_id,0) as fcst_id,isnull(fcst_amt_SumByPart,0) as fcst_amt,isnull(actual_amt,0) as actual_amt,0
		,ols_adjust,topside_adjust
		from vw_gam_OEMcomb left join gam_forecast on oemid = oem_id and fiscal_period between @startPeriod and @endPeriod
		where isValid=1 and viewsalesmanid =@salesman
		
		/*for actual view*/
		insert into #tmp
		select OEMID,CusOEM,userName,GroupName,plant,isnull(fiscal_period,0) as fiscal_period,
		isnull(fcst_id,0) as fcst_id,isnull(fcst_amt_SumByPart,0) as fcst_amt,isnull(actual_amt,0) as actual_amt,1
		,ols_adjust,topside_adjust
		from vw_gam_OEMcomb left join gam_forecast on oemid = oem_id and fiscal_period between @iPeriod and @cPeriod
		where isValid=1 and viewsalesmanid =@salesman
	end
end

select distinct * into #tmpX from #tmp
truncate table #tmp
insert into #tmp select * from #tmpX
drop table #tmpX

if(@plant <> '')
begin
	select * into #tmpP from #tmp where plant=@plant
	truncate table #tmp
	insert into #tmp select * from #tmpP
	drop table #tmpP
end
if(@oemgroup <> '')
begin
	select * into #tmpG from #tmp where groupName=@oemgroup
	truncate table #tmp
	insert into #tmp select * from #tmpG
	drop table #tmpG
end
if(@oem <> '')
begin
	select * into #tmpO from #tmp where cusOEM like '%' + @oem +'%'
	truncate table #tmp
	insert into #tmp select * from #tmpO
	drop table #tmpO
end

select oemid,cusoem,userName,groupName,fiscal_period,fcst_id,fcst_amt,actual_amt
,isnull(ols_adjust,0) as ols_adjust, isnull(topside_adjust,0) as topside_adjust
from #tmp where isViewActual=0 order by userName,cusOEM,oemid


--select distinct fiscal_period from #tmp where isViewActual=1 and fiscal_period > 0 order by fiscal_period
select  iperiod from multek_zh.dbo.vw_CalenderLDP where iperiod between @iperiod and @cperiod order by iperiod


select oemid,cusoem,userName,groupName,fiscal_period,fcst_id,fcst_amt,actual_amt 
,isnull(ols_adjust,0) as ols_adjust, isnull(topside_adjust,0) as topside_adjust
from #tmp where isViewActual=1 and fiscal_period>0 order by userName,cusOEM,oemid

drop table #tmp









GO
