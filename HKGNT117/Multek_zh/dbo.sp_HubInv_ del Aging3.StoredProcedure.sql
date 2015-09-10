USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_HubInv_|del|Aging3]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE  procedure [dbo].[sp_HubInv_|del|Aging3] 
@iDate int

as
begin

--set @iDate = 20110202
select oem,plant,week,round(sum(amount)/1000,0) as amtK into #tmp from (
	select oem,plant,amount,datediff(d,outDate,inDate)/7 as week from dbo.vw_4RP_HubInv 
	where iDate = @iDate
)as aging group by oem,plant,week order by week,oem,plant


select nme.*,
isnull(w1amt,0) as w1amt,
isnull(w2amt,0) as w2amt,
isnull(w4amt,0) as w4amt,
isnull(w6amt,0) as w6amt,
isnull(w8amt,0) as w8amt,
isnull(w12amt,0) as w12amt,
isnull(wOV12amt,0) as wOV12amt
from 
	(select oem,plant,sum(amtK) as totalK from #tmp group by oem,plant) as nme
full join 
	(select amtK as w1amt,oem,plant from #tmp where week=0) as w1 
	on nme.oem=w1.oem and nme.plant = w1.plant
full join
	(select oem,plant,sum(amtK) as w2amt from #tmp where week between 1 and 2 group by oem,plant) as w2
	on nme.oem=w2.oem and nme.plant=w2.plant
full join
	(select oem,plant,sum(amtK) as w4amt from #tmp where week between 3 and 4 group by oem,plant) as w4
	on nme.oem=w4.oem and nme.plant=w4.plant
full join
	(select oem,plant,sum(amtK) as w6amt from #tmp where week between 5 and 6 group by oem,plant) as w6
	on nme.oem=w6.oem and nme.plant=w6.plant
full join
	(select oem,plant,sum(amtK) as w8amt from #tmp where week between 7 and 8 group by oem,plant) as w8
	on nme.oem=w8.oem and nme.plant=w8.plant
full join
	(select oem,plant,sum(amtK) as w12amt from #tmp where week between 9 and 12 group by oem,plant) as w12
	on nme.oem=w12.oem and nme.plant=w12.plant
full join
	(select oem,plant,sum(amtK) as wOV12amt from #tmp where week >12 group by oem,plant) as wOV12
	on nme.oem=wOV12.oem and nme.plant=wOV12.plant

drop table #tmp

end




GO
