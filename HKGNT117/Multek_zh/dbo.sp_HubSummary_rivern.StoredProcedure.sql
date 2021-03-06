USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_HubSummary_rivern]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






--use multek_zh;
--exec sp_HubSummary 20111017
 
/*
declare @idate int
set @idate = 20111013
*/

CREATE procedure [dbo].[sp_HubSummary_rivern] @idate int, @isK bit =0
as

select o.oem,o.plant,amount,(datediff(d,outDate,inDate)-transit) as days,transit into #tmp
from vw_4RP_HubInv as o left join dbo.hubInventoryOEMPolicy as p
on o.warehouseId=p.warehouseId
where iDate = @iDate

select nme.*,
isnull(w1amt,0) as w1amt,
isnull(w2amt,0) as w2amt,
isnull(w4amt,0) as w4amt,
isnull(w6amt,0) as w6amt,
isnull(w8amt,0) as w8amt,
isnull(w12amt,0) as w12amt,
isnull(wOV12amt,0) as wOV12amt
into #tmp2
from 
	(select oem,plant,round(sum(amount),0) as totalK from #tmp group by oem,plant) as nme
full join 
	(select round(sum(amount),0) as w1amt,oem,plant from #tmp where days <=0 group by oem,plant) as w1 
	on nme.oem=w1.oem and nme.plant = w1.plant --in transit
full join 
	(select round(sum(amount),0) as w2amt,oem,plant from #tmp where days between 1 and 14 group by oem,plant) as w2 
	on nme.oem=w2.oem and nme.plant = w2.plant --below 2
full join 
	(select round(sum(amount),0) as w4amt,oem,plant from #tmp where days between 15 and 28 group by oem,plant) as w4
	on nme.oem=w4.oem and nme.plant = w4.plant --2 - 4
full join 
	(select round(sum(amount),0) as w6amt,oem,plant from #tmp where days between 29 and 42 group by oem,plant) as w6 
	on nme.oem=w6.oem and nme.plant = w6.plant --4 - 6
full join 
	(select round(sum(amount),0) as w8amt,oem,plant from #tmp where days between 43 and 56 group by oem,plant) as w8 
	on nme.oem=w8.oem and nme.plant = w8.plant --6 - 8
full join 
	(select round(sum(amount),0) as w12amt,oem,plant from #tmp where days between 57 and 84 group by oem,plant) as w12 
	on nme.oem=w12.oem and nme.plant = w12.plant --8 - 12
full join 
	(select round(sum(amount),0) as wOV12amt,oem,plant from #tmp where days >84 group by oem,plant) as wOV12 
	on nme.oem=wOV12.oem and nme.plant = wOV12.plant --over  12
drop table #tmp

/*
select isnull(x.oem,y.oem)as oem,isnull(x.plant,y.plant) as plant,isnull(oamt,0) oamt,isnull(iamt,0) as iamt,
isnull(fg_ava,0) as fg_ava, isnull(fg_amt,0) as fg_amt into #out_in_backlog
from (
select isnull(o.oem,i.oem) as oem,isnull(o.plant,i.plant) as plant,
isnull(oamt,0) as oAmt,isnull(iamt,0) as iAmt from 
(select oem,plant,sum(amount) as oAmt from dbo.vw_4RP_HUBOUT where idate <= @iDate group by oem,plant) as o
full join 
(select oem,plant,sum(amount) as iAmt from vw_4RP_HubIn_ext where idate <= @idate group by oem,plant) as i
on i.oem=o.oem and i.plant=o.plant
) as x full join 
(select T$ECDT as oem,T$plnt as plant,sum(fg_avaible) as fg_ava,sum(T$AMNT) as fg_amt 
		from vw_4RP_HubBacklog where CONVERT(varchar(8), T$DDTA , 112) = @idate group by t$ecdt,t$plnt) as y
on y.oem=x.oem and y.plant=x.plant
*/



declare @iperiod int
select @iperiod=iperiod from dbo.vw_Calender_ext where idate = @idate
select isnull(x.oem,y.oem)as oem,isnull(x.plant,y.plant) as plant,isnull(oamt,0) oamt,isnull(iamt,0) as iamt,
isnull(fg_ava,0) as fg_ava, isnull(fg_amt,0) as fg_amt into #out_in_backlog
from (
select isnull(o.oem,i.oem) as oem,isnull(o.plant,i.plant) as plant,
isnull(oamt,0) as oAmt,isnull(iamt,0) as iAmt from 
(select oem,plant,sum(amount) as oAmt from dbo.vw_4RP_HubOutExt where iperiod=@iperiod group by oem,plant) as o
full join 
--(select oem,plant,sum(amount) as iAmt from vw_4RP_HubIn_extDate where iperiod=@iperiod group by oem,plant) as i	-- OP said the field iperiod should be changed to hkperiod at 2013/07/09
(select oem,plant,sum(amount) as iAmt from vw_4RP_HubIn_extDate where hkPeriod=@iperiod group by oem,plant) as i
on i.oem=o.oem and i.plant=o.plant
) as x full join 
(select T$ECDT as oem,T$plnt as plant,sum(fg_avaible) as fg_ava,sum(T$AMNT) as fg_amt 
	from vw_4RP_HubBacklog_ext where iperiod<=@iperiod group by t$ecdt,t$plnt) as y
on y.oem=x.oem and y.plant=x.plant

--select * from #out_in_backlog
select @iperiod

select outAmt-inAmt as delta,fg_total-fg_available as fg_bal,fg_total + inAmt as fcst,*into #result
from (
	select isnull(a.oem,b.oem) as oem,isnull(a.plant,b.plant) as plant,
	round(isnull(iAmt,0),0) as inAmt,round(isnull(oAmt,0),0) as outAmt,
	round(isnull(fg_amt,0),0) as fg_total,round(isnull(fg_ava,0),0) as fg_available,
	isnull(wov12amt,0) as over12weeks,
	isnull(w12amt,0) as over8weeks,
	isnull(w8amt,0) as over6weeks,
	isnull(w6amt,0) as over4weeks,
	isnull(w4amt,0) as over2weeks,
	isnull(w2amt,0) as lessthen2weeks,
	isnull(w1amt,0) as intransit,
	isnull(totalK,0) as total
	from #tmp2 as a full join #out_in_backlog as b 
	on a.oem=b.oem and a.plant=b.plant
) as h order by oem,plant

drop table #out_in_backlog
drop table #tmp2

if(@isK =1)
	update #result set 
		delta=round(delta/1000.0,0),fg_bal=round(fg_bal/1000.0,0),fcst=round(fcst/1000.0,0),
		inAmt=round(inAmt/1000.0,0),outAmt=round(outAmt/1000.0,0),fg_total=round(fg_total/1000.0,0),
		fg_available=round(fg_available/1000.0,0),over12weeks=round(over12weeks/1000.0,0),
		over8weeks=round(over8weeks/1000.0,0),over6weeks=round(over6weeks/1000.0,0),
		over4weeks=round(over4weeks/1000.0,0),over2weeks=round(over2weeks/1000.0,0),
		lessthen2weeks=round(lessthen2weeks/1000.0,0),intransit=round(intransit/1000.0,0),total=round(total/1000.0,0)

select * from #result
union all
select sum(delta),sum(fg_bal),sum(fcst),'Total','all',sum(inAmt),sum(outAmt),sum(fg_total),sum(fg_available),sum(over12weeks),sum(over8weeks),
sum(over6weeks),sum(over4weeks),sum(over2weeks),sum(lessthen2weeks),sum(intransit),sum(total) from #result
drop table #result

--exec [sp_HubSummary] 20111027,1





GO
