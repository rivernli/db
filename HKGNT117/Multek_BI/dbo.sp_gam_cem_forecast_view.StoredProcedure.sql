USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_gam_cem_forecast_view]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[sp_gam_cem_forecast_view] @period int=0
as
set nocount on

if @period=0 
	select @period=multek_zh.dbo.fx_getCurrentPeriod()
	
	--set @period=201402
/*
select * from gam_cem_forecast  where period=@period
order by OEM,plant
*/


/*get OEM, plant list from CEM forecast data*/
select distinct userName,cusOEM,oem,a.plant,oemid 
into #tmp 
from gam_cem_forecast as a left join dbo.vw_gam_OEMcomb as b on a.oem=b.oemname and a.plant=b.plant
where a.period = @period and b.oemname is not null and b.isValid=1

--select * from #tmp
/*get (sales defind part no.) forecast data from GAM/BDM forecast */
select * into #tmp2 from dbo.gam_part_forecast where oemid in (select oemid from #tmp)
and period > @period and project like '%]%]%]' order by period


select distinct oemid,project into #tmp4 from #tmp2


select a.oemid,'--' as customer_code,oem,b.project as cpn,'--' as ipn,plant,asp,null as guessPrice,null as priceMaster,
0 as q1,0 as q2,0 as q3,0 as q4,0 as q5,0 as q6
into #result from #tmp as a right join #tmp4 as b on a.oemid=b.oemid
left join gam_customerPart_remark as c on a.oemid=c.oem_id and b.project = c.part_no
drop table #tmp;
drop table #tmp4


select top 12 period into #period from #tmp2 group by period order by period 

declare @fperiod int,@i int,@SQL VarChar(1000)
select @i=0
while exists (select 1 from #period)
begin
	select top 1 @fperiod = period,@i=@i+1 from #period
	if(@i > 12)
		break
	delete #period where period=@fperiod
	SELECT @SQL = 'ALTER TABLE #result ADD [p' + convert(varchar(2),@i) + '] float default 0.0'
	Exec (@SQL)
	select @sql = 'update #result set [p'+ convert(varchar(2),@i) +']=0; update #result set [p'+ convert(varchar(2),@i) +
		']=amt from #result as p left join '+
		'#tmp2 as t on p.oemid=t.oemid and p.cpn=t.project where t.period='+  convert(varchar(10),@fperiod)
	exec(@sql)
end
drop table #period
drop table #tmp2

while(@i < 12)
begin
	select @i=@i+1,@fperiod=multek_zh.dbo.fx_getAddPeriod(@period,@i),
	@SQL = 'ALTER TABLE #result ADD [p' + convert(varchar(2),@i) + '] float default 0.0'
	Exec (@SQL)
	select @sql= 'update #result set [p' + convert(varchar(2),@i) + '] =0'
	Exec (@SQL)	
end

ALTER TABLE #result drop column [oemid]

select * into #total from #result 
union all
select customer_code,oem,cpn,ipn,plant,asp,guessPrice,priceMaster,q1,q2,q3,q4,q5,q6,p1,p2,p3,p4,p5,p6,
p6 as p7,p6 as p8,p6 as p9,p6 as p10,p6 as p11,p6 as p12
from gam_cem_forecast where period=@period
order by oem,plant, cpn
drop table #result


select * from #total

select oem,plant,p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12 from 
(
select 0 as t,oem,plant,sum(p1) as p1,sum(p2) as p2,sum(p3) as p3,sum(p4) as p4,sum(p5) as p5,sum(p6) as p6,
sum(p7) as p7,sum(p8) as p8,sum(p9) as p9,sum(p10) as p10,sum(p11) as p11,sum(p12) as p12
from #total group by oem,plant
union all
select 1 as t,'TOTAL','ALL',sum(p1) as p1,sum(p2) as p2,sum(p3) as p3,sum(p4) as p4,sum(p5) as p5,sum(p6) as p6,
sum(p7) as p7,sum(p8) as p8,sum(p9) as p9,sum(p10) as p10,sum(p11) as p11,sum(p12) as p12
from #total
) as X order by t,oem,plant

drop table #total
set nocount off


GO
