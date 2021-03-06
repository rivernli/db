USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_gam_ForecastCustomerPart_Get]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[sp_gam_ForecastCustomerPart_Get]
@period int, @oemId int, @periodLong int=3,@totalPeriod int=5,
@oem nvarchar(100) output, @baanName nvarchar(100) output, @plant char(3) output
as
/*
declare @oem nvarchar(100), @baanName nvarchar(100), @plant char(3)
declare @oemid int,@period int,@periodLong int, @totalPeriod int
set @oemid=108 select @period=201211,@periodLong=3,@totalPeriod=11
--oemid=5 /sony ericsson b5.
--oemid=4 /sony ericsson b3
*/

select 
	@oem = cusOEM,
	@baanName = OEMName,
	@plant = plant 
from dbo.vw_gam_OEMcomb where oemid=@oemid

declare @sp int, @ep int
select 
	@sp = multek_zh.dbo.fx_getAddPeriod(@period,-@periodLong),
	@ep = multek_zh.dbo.fx_getAddPeriod(@period,@totalPeriod) 


select iperiod,cus_part_no,amt into #tmp from vw_gam_actualItemsAmount_for_Input where 1=2

select iperiod,cus_part_no,sum(amt) as amt into #tmx 
from vw_gam_actualItemsAmount_for_Input 
where iperiod<@period and iperiod >= @sp and oem=@baanName and plant=@plant and amt>0 
group by iperiod,cus_part_no

if(@plant ='B3')
begin
	insert into #tmp
	select #tmx.* from (select max(iperiod) as p,cus_part_no as ip from #tmx group by cus_part_no) as x
	left join #tmx on p=iperiod and ip = cus_part_no order by iperiod desc,cus_part_no
end
else
begin
	insert into #tmp
	select #tmx.* from (select max(iperiod) as p,cus_part_no as ip from #tmx group by cus_part_no having count(iperiod) >=3 ) as x
	left join #tmx on p=iperiod and ip = cus_part_no order by iperiod desc,cus_part_no
end
drop table #tmx

--making calender for period.
create table #CalenderPeriod (iperiod int)
if exists (select 1 from multek_zh.dbo.vw_CalenderLDP where iperiod = @ep)
begin
	insert into #CalenderPeriod (iperiod) select iperiod from multek_zh.dbo.vw_CalenderLDP where iperiod between @period and @ep
end
else
begin
	declare @ydiff int; select @ydiff =(cast(substring(cast(@period as varchar(6)),1,4) as int)-2000) *100
	insert into #CalenderPeriod (iperiod) 	select iperiod + @ydiff as iperiod from multek_zh.dbo.vw_CalenderLDP where iperiod between (@period-@ydiff) and (@ep-@ydiff)
end
--end making calender.

/*new for input forecast*/
select iperiod,f.sid,project,amt into #tmp2 from #CalenderPeriod as ldp 
left join (select * from gam_part_forecast where oemid=@oemid) as f on iperiod = period
where lDP.iPeriod between @period and @ep order by iperiod

drop table #CalenderPeriod

select @period as iperiod ,project as cus_part_no,0 as amt 
from #tmp2 left join #tmp on cus_part_no = project where cus_part_no is null and project is not null group by project
union all
select iperiod,cus_part_no,amt from #tmp

select iperiod,isnull(sid,0) as sid,project,amt from #tmp2




select @ep = multek_zh.[dbo].[fx_getPeriodDate](default),@sp = multek_zh.dbo.fx_getAddPeriod(@ep,-@periodLong)



select iperiod,cus_part_no,sum(amt) as samt into #tmpx from 
(select distinct project from #tmp2) as a full join vw_gam_actualItemsAmount_for_Input as b
on a.project = b.cus_part_no
where oem=@baanName and plant=@plant and iperiod < @ep and iperiod >= @sp
group by iperiod,cus_part_no order by iperiod,cus_part_no

select c.iperiod,isnull(cus_part_no,'') as cus_part_no,isnull(samt,0) as samt from multek_zh.dbo.vw_CalenderLDP as c
left join #tmpx as p on c.iperiod=p.iperiod
 where c.iperiod >= @sp and c.iperiod < @ep
drop table #tmpx
drop table #tmp
drop table #tmp2







GO
