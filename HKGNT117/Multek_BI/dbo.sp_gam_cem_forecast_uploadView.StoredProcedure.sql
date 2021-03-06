USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_gam_cem_forecast_uploadView]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE procedure [dbo].[sp_gam_cem_forecast_uploadView] @keyStamp nvarchar(100)
as
set nocount on



select id=identity(int, 1, 1),code,pn,sum(q1) as q1,sum(q2) as q2,sum(q3) as q3,
sum(q4) as q4,sum(q5) as q5,sum(q6) as q6,convert(varchar(100),replace(pn,' ','')) as pn2 
into #tmp from cemFCtable2 where keystamp=@keyStamp and (q1+q2+q3+q4+q5+q6 >0) group by code,pn


create index pn2 on #tmp (pn2) with fillfactor = 90 on [primary]
create index pn on #tmp (pn) with fillfactor = 90 on [primary]

select id,code,pn,q1,q2,q3,q4,q5,q6 from #tmp

select myid=identity(int,1,1),id,customer_code,oem,cpn,ipn,plant,convert(datetime, gamDate, 112) as lastDate,asp,
case when AvgPrice=0 then PMaxPrice else AvgPrice end as guessPrice
,q1,q2,q3,q4,q5,q6 into #tmp2
from #tmp as a join vw_cemFC_customerPN_byDate2  as b on (cpn2 like '%' + pn2 +'%' or pn2 like '%' + cpn2 +'%')
and code=customer_code
where (len(ipn)=8 and substring(ipn,1,1) not in ('H','Q','7','9')) or len(ipn) <> 8
order by id,gamDate desc

update #tmp2 set q1=0,q2=0,q3=0,q4=0,q5=0,q6=0
from #tmp2 join (
select id,min(myid) as bid from #tmp2 group by id having count(id) > 1
) as b
on #tmp2.id=b.id and myid <> bid

--select * from #tmp2

select a.*,isnull(b.price,0) as priceMaster from #tmp2 as a left join vw_priceMaster as b 
on a.customer_Code=b.customerCode and project=ipn

drop table #tmp2
drop table #tmp

delete cemFCtable2 where keystamp=@keyStamp

set nocount off









GO
