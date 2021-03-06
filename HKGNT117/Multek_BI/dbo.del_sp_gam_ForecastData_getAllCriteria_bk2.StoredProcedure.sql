USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[del_sp_gam_ForecastData_getAllCriteria_bk2]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO










--exec sp_gam_ForecastData_getBySalesId 201201,201212
-- exec [sp_gam_ForecastData_getAllCriteria] 201201,201301,@plant='B5',@oem='nec'




CREATE procedure [dbo].[del_sp_gam_ForecastData_getAllCriteria_bk2]
@startPeriod int,
@endPeriod int,
@salesman int = 0,
@plant nvarchar(10) = '',
@oem nvarchar(50) = '',
@oemgroup nvarchar(50) = '',
@subSales bit = 0,
@bkSales bit=0
as 

--select iperiod from multek_zh.dbo.vw_CalenderLDP where iperiod between @startPeriod and @endPeriod
if exists (select 1 from multek_zh.dbo.vw_CalenderLDP where iperiod = @endperiod)
begin
	select iperiod from multek_zh.dbo.vw_CalenderLDP where iperiod between @startPeriod and @endPeriod order by iperiod
end
else
begin
	declare @ydiff int
	select @ydiff =(cast(substring(cast(@startPeriod as varchar(6)),1,4) as int)-2000) *100
	select iperiod + @ydiff as iperiod from multek_zh.dbo.vw_CalenderLDP where iperiod between (@startPeriod-@ydiff) and (@endPeriod-@ydiff)  order by iperiod
end

select top 0 OEMID,CusOEM,userName,GroupName,plant,isnull(fiscal_period,0) as fiscal_period,
isnull(fcst_id,0) as fcst_id,isnull(fcst_amt_SumByPart,0) as fcst_amt,isnull(actual_amt,0) as actual_amt
into #tmp from vw_gam_OEMcomb left join gam_forecast on oemid = oem_id

if(@subSales =1)
begin
	insert into #tmp
	select OEMID,CusOEM,userName,GroupName,plant,isnull(fiscal_period,0) as fiscal_period,
	isnull(fcst_id,0) as fcst_id,isnull(fcst_amt_SumByPart,0) as fcst_amt,isnull(actual_amt,0) as actual_amt
	from vw_gam_OEMcomb left join gam_forecast on oemid = oem_id and fiscal_period between @startPeriod and @endPeriod
	where isValid=1 and salesmanid in (select sysUserId from dbo.fx_getSalesByManager(@salesman))

	if(@bkSales=1)
	begin
		insert into #tmp
		select OEMID,CusOEM,userName,GroupName,plant,isnull(fiscal_period,0) as fiscal_period,
		isnull(fcst_id,0) as fcst_id,isnull(fcst_amt_SumByPart,0) as fcst_amt,isnull(actual_amt,0) as actual_amt
		from vw_gam_OEMcomb left join gam_forecast on oemid = oem_id and fiscal_period between @startPeriod and @endPeriod
		where isValid=1 and	viewsalesmanid in (select sysUserId from dbo.fx_getSalesByManager(@salesman))
	end
end
else
begin
	insert into #tmp
	select OEMID,CusOEM,userName,GroupName,plant,isnull(fiscal_period,0) as fiscal_period,
	isnull(fcst_id,0) as fcst_id,isnull(fcst_amt_SumByPart,0) as fcst_amt,isnull(actual_amt,0) as actual_amt
	from vw_gam_OEMcomb left join gam_forecast on oemid = oem_id and fiscal_period between @startPeriod and @endPeriod
	where isValid=1 and salesmanid = @salesman
	if(@bkSales=1)
	insert into #tmp
	select OEMID,CusOEM,userName,GroupName,plant,isnull(fiscal_period,0) as fiscal_period,
	isnull(fcst_id,0) as fcst_id,isnull(fcst_amt_SumByPart,0) as fcst_amt,isnull(actual_amt,0) as actual_amt
	from vw_gam_OEMcomb left join gam_forecast on oemid = oem_id and fiscal_period between @startPeriod and @endPeriod
	where isValid=1 and viewsalesmanid =@salesman
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
select oemid,cusoem,userName,groupName,fiscal_period,fcst_id,fcst_amt,actual_amt from #tmp order by userName,cusOEM,oemid
drop table #tmp







GO
