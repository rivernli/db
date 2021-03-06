USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_gam_cem_forecast_uploadConfirm]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[sp_gam_cem_forecast_uploadConfirm] @keyStamp nvarchar(100)
as

set nocount on

select id=identity(int, 1, 1),code,pn,sum(q1) as q1,sum(q2) as q2,sum(q3) as q3,
sum(q4) as q4,sum(q5) as q5,sum(q6) as q6,convert(varchar(100),replace(pn,' ','')) as pn2 
into #tmp from cemFCtable2 where keystamp=@keyStamp and (q1+q2+q3+q4+q5+q6 >0) group by code,pn

create index pn2 on #tmp (pn2) with fillfactor = 90 on [primary]
create index pn on #tmp (pn) with fillfactor = 90 on [primary]

select myid=identity(int,1,1),id,
customer_code,oem,cpn,ipn,plant,convert(datetime, gamDate, 112) as lastDate,asp,
case when AvgPrice=0 then PMaxPrice else AvgPrice end as guessPrice,
iperiod,
case when isnull(pMaxPrice,0) > 0 and isnull(pSqft,0) > 0 then pmaxPrice/pSqft else 0 end as maxASP,
case when isnull(pMinPrice,0) > 0 and isnull(pSqft,0) > 0 then pMinPrice/pSqft else 0 end  as minASP,
pAmt as ttlAMT,pQty as ttlQTY,pSqft as ttlSQFT,
case when (ASCII(SUBSTRING(ipn, 2, 1)) BETWEEN 48 AND 57) AND (ASCII(SUBSTRING(ipn, 3, 1)) BETWEEN 48 AND 57) 
then CONVERT(int, SUBSTRING(ipn, 2, 2)) else null end as layer
,q1,q2,q3,q4,q5,q6
into #tmp2
from #tmp as a join vw_cemFC_customerPN_byDate2  as b 
on (cpn2 like '%' + pn2 +'%' or pn2 like '%' + cpn2 +'%') and code=customer_code
where (len(ipn)=8 and substring(ipn,1,1) not in ('H','Q','7','9')) or len(ipn) <> 8
order by id,gamDate desc

update #tmp2 set q1=0,q2=0,q3=0,q4=0,q5=0,q6=0 from #tmp2 join 
(select id,min(myid) as bid from #tmp2 group by id having count(id) > 1) as b
on #tmp2.id=b.id and myid <> bid 

delete #tmp2 where q1=0 and q2=0 and q3=0 and q4=0 and q5=0 and q6=0

declare @currentPeriod int
select @currentPeriod=multek_zh.dbo.fx_getCurrentPeriod()
delete gam_cem_forecast where period=@currentPeriod


insert into gam_cem_forecast 
(customer_code,oem,cpn,ipn,plant,lastDate,asp,guessPrice,q1,q2,q3,q4,q5,q6,period,uploadtime,
iperiod,maxASP,minASP,ttlAMT,ttlQTY,ttlSQFT,layer,tech,surf,priceMaster)
select 
customer_code,oem,cpn,ipn,plant,lastDate,asp,guessPrice,q1,q2,q3,q4,q5,q6,@currentPeriod,getdate(),
iperiod,maxASP,minASP,ttlAMT,ttlQTY,ttlSQFT,layer,b.t$astr as tech,c.t$astr as surf ,isnull(d.price,0)
from #tmp2 as a 
left join FactoryLoading.dbo.TFIATT006180 as b on a.ipn=b.t$item and b.t$attr='type' 
left join FactoryLoading.dbo.TFIATT006180 as c on a.ipn=c.t$item and c.t$attr='surf'
left join vw_priceMaster as d on a.customer_Code=d.customerCode and a.ipn=project

update gam_cem_forecast set p1=q1*priceMaster,p2=q2*priceMaster,p3=q3*priceMaster,
p4=q4*priceMaster,p5=q5*priceMaster,p6=q6*priceMaster
where period=@currentPeriod

drop table #tmp2
drop table #tmp

delete cemFCtable2 where keystamp=@keyStamp

exec dbo.sp_gam_forecat_ReCal_OEMPlantAmt_All_auto

set nocount off


GO
