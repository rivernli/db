USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_HubInv_AgingGetK]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  procedure [dbo].[sp_HubInv_AgingGetK] 
@iDate int,
@PlantGroup bit = 0
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
	(select oem,plant,round(sum(amount)/1000,0) as totalK from #tmp group by oem,plant) as nme
full join 
	(select round(sum(amount)/1000,0) as w1amt,oem,plant from #tmp where days <=0 group by oem,plant) as w1 
	on nme.oem=w1.oem and nme.plant = w1.plant --in transit
full join 
	(select round(sum(amount)/1000,0) as w2amt,oem,plant from #tmp where days between 1 and 14 group by oem,plant) as w2 
	on nme.oem=w2.oem and nme.plant = w2.plant --below 2
full join 
	(select round(sum(amount)/1000,0) as w4amt,oem,plant from #tmp where days between 15 and 28 group by oem,plant) as w4
	on nme.oem=w4.oem and nme.plant = w4.plant --2 - 4
full join 
	(select round(sum(amount)/1000,0) as w6amt,oem,plant from #tmp where days between 29 and 42 group by oem,plant) as w6 
	on nme.oem=w6.oem and nme.plant = w6.plant --4 - 6
full join 
	(select round(sum(amount)/1000,0) as w8amt,oem,plant from #tmp where days between 43 and 56 group by oem,plant) as w8 
	on nme.oem=w8.oem and nme.plant = w8.plant --6 - 8
full join 
	(select round(sum(amount)/1000,0) as w12amt,oem,plant from #tmp where days between 57 and 84 group by oem,plant) as w12 
	on nme.oem=w12.oem and nme.plant = w12.plant --8 - 12
full join 
	(select round(sum(amount)/1000,0) as wOV12amt,oem,plant from #tmp where days > 84 group by oem,plant) as wOV12 
	on nme.oem=wOV12.oem and nme.plant = wOV12.plant --over  12

drop table #tmp
if @PlantGroup=0
	select oem,plant,wOV12amt,w12amt,w8amt,w6amt,w4amt,w2amt,w1amt,totalK from #tmp2 order by plant,oem
else
	select '' as oem,plant,
	sum(wOV12amt) as wOV12amt,sum(w12amt) as w12amt,sum(w8amt) as w8amt,
	sum(w6amt) as w6amt,sum(w4amt) as w4amt,sum(w2amt) as w2amt,sum(w1amt) as w1amt,sum(totalk) as totalk
	from #tmp2 group by plant order by plant

drop table #tmp2








GO
