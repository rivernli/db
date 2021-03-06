USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_HubInv_stockOverSit]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE procedure [dbo].[sp_HubInv_stockOverSit] @idate int, @unit int = 1000,
@PlantGroup bit = 0
as
/*
need to be check if less the 1?
select cast(round(600/1000.0,0) as int)
*/
select inHubDays-bp-ov as overdueDays, OEM,plant,warehouseId,amount,qty into #temp from (
select a.OEM,a.plant,a.warehouseId,amount,qty,isnull(billingpolicy,0) as bp ,isnull(transit,0) as ov,
datediff(d,outDate,inDate) as inHubDays
from dbo.vw_4RP_HubInv as a left join dbo.hubInventoryOEMPolicy as b on 
a.warehouseId=b.warehouseId
where iDate=@idate
) as ov

select OEM,plant,round(sum(amount)/@unit,0) as totalAmt into #result from #temp group by OEM,plant order by OEM,Plant

select #result.*,
round(isnull(less5,0)/@unit,0) as MN28,
round(isnull(less4,0)/@unit,0) as N28toN22,
round(isnull(less3,0)/@unit,0) as N21toN15,
round(isnull(less2,0)/@unit,0) as N14toN8,
round(isnull(less1,0)/@unit,0) as N7toN1,
round(isnull(curr,0)/@unit,0) as D0toD14,
round(isnull(curr2,0)/@unit,0) as D15toD28,
round(isnull(curr3,0)/@unit,0) as MD28
into #tmp2
from #result 
left join 
(select OEM,plant,sum(amount) as less5 from #temp where overdueDays < -28 group by OEM,plant) as l5
on #result.OEM=l5.OEM and #result.plant=l5.plant
left join 
(select OEM,plant,sum(amount) as less4 from #temp where overdueDays between -28 and -22 group by OEM,plant) as l4
on #result.OEM=l4.OEM and #result.plant=l4.plant
left join 
(select OEM,plant,sum(amount) as less3 from #temp where overdueDays between -21 and -15 group by OEM,plant) as l3
on #result.OEM=l3.OEM and #result.plant=l3.plant
left join 
(select OEM,plant,sum(amount) as less2 from #temp where overdueDays between -14 and -8 group by OEM,plant) as l2
on #result.OEM=l2.OEM and #result.plant=l2.plant
left join 
(select OEM,plant,sum(amount) as less1 from #temp where overdueDays between -7 and -1 group by OEM,plant) as l1
on #result.OEM=l1.OEM and #result.plant=l1.plant
left join 
(select OEM,plant,sum(amount) as curr from #temp where overdueDays between 0 and 14 group by OEM,plant) as d1
on #result.OEM=d1.OEM and #result.plant=d1.plant
left join 
(select OEM,plant,sum(amount) as curr2 from #temp where overdueDays between 15 and 28 group by OEM,plant) as d2
on #result.OEM=d2.OEM and #result.plant=d2.plant
left join 
(select OEM,plant,sum(amount) as curr3 from #temp where overdueDays > 28 group by OEM,plant) as d3
on #result.OEM=d3.OEM and #result.plant=d3.plant

drop table #result
drop table #temp



if(@PlantGroup=0)
	select * from #tmp2
else
	select ''as oem,plant,sum(totalAmt) as totalAmt, sum(MN28) as MN28,sum(N28toN22) as N28toN22,sum(N21toN15) as N21toN15,
	sum(N14toN8) as N14toN8,sum(N7toN1) as N7toN1,sum(D0toD14) as D0toD14,sum(D15toD28) as D15toD28, sum(MD28) as MD28
	from #tmp2 group by plant order by plant

drop table #tmp2




GO
