USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_gam_ForecastCustomerPart_Get_bk]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






create procedure [dbo].[sp_gam_ForecastCustomerPart_Get_bk]
@period int, @oemId int, @periodLong int=4,@totalPeriod int=5,
@oem nvarchar(100) output, @baanName nvarchar(100) output, @plant char(3) output
as
/*
declare @oem nvarchar(100)
declare @baanName nvarchar(100)
declare @plant char(3)
declare @oemid int
set @oemid=77
*/

select @oem=cusOEM,@baanName=OEMName,@plant=plant from dbo.vw_gam_OEMcomb where oemid=@oemid
declare @sp int; declare @ep int
select @sp = multek_zh.dbo.fx_getAddPeriod(@period,-@periodLong) ,@ep = multek_zh.dbo.fx_getAddPeriod(@period,@totalPeriod) 

select iperiod,cus_part_no,sum(amt) as amt into #tmx from vw_gam_actualItemsAmount_for_Input 
where iperiod<@period and (iperiod between @sp and @period) and oem=@baanName and plant=@plant and amt>0 group by iperiod,cus_part_no

--add iperiod<@period on above query
--change 'select max(iperiod) as p,cus_part_no as ip from #tmx group by cus_part_no'
select #tmx.* into #tmp from (select max(iperiod) as p,cus_part_no as ip from #tmx group by cus_part_no having count(iperiod) >=3 ) as x
left join #tmx on p=iperiod and ip = cus_part_no order by iperiod desc,cus_part_no

drop table #tmx

--making calender for period.
create table #CalenderPeriod (iperiod int)
if exists (select 1 from multek_zh.dbo.vw_CalenderLDP where iperiod = @ep)
begin
	insert into #CalenderPeriod (iperiod)
	select iperiod from multek_zh.dbo.vw_CalenderLDP where iperiod between @period and @ep
end
else
begin
	declare @ydiff int
	select @ydiff =(cast(substring(cast(@period as varchar(6)),1,4) as int)-2000) *100
	insert into #CalenderPeriod (iperiod)
	select iperiod + @ydiff as iperiod from multek_zh.dbo.vw_CalenderLDP where iperiod between (@period-@ydiff) and (@ep-@ydiff)
end
--end making calender.

/*new for input forecast*/
select iperiod,f.sid,project,amt into #tmp2 from #CalenderPeriod as ldp 
left join (select * from gam_part_forecast where oemid=@oemid ) as f on iperiod = period
where lDP.iPeriod between @period and @ep
order by iperiod
drop table #CalenderPeriod

/*
select
isnull(#tmp.iperiod,#tmp2.iperiod) as iperiod,
isnull(cus_part_no,project) as cus_part_no,
isnull(#tmp.amt,#tmp2.amt) as amt
from #tmp full join #tmp2 on #tmp.iperiod=#tmp2.iperiod and project=cus_part_no
*/
select @period as iperiod ,project as cus_part_no,0 as amt 
	from #tmp2 left join #tmp on cus_part_no = project where cus_part_no is null and project is not null group by project
union all
select iperiod,cus_part_no,amt from #tmp

select iperiod,isnull(sid,0) as sid,project,amt from #tmp2


drop table #tmp
drop table #tmp2





GO
