USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_gam_cemUploadCompareOutputTemp5]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO













CREATE procedure [dbo].[sp_gam_cemUploadCompareOutputTemp5] @keyStamp nvarchar(100)
as
set nocount on
select id=identity(int, 1, 1),code,pn,q1,q2,q3,q4,q5,q6,convert(varchar(100),replace(pn,' ','')) as pn2 
into #tmp from cemFCtable2 where keystamp=@keyStamp
and (q1+q2+q3+q4+q5+q6 >0)

create index pn2 on #tmp (pn2) with fillfactor = 90 on [primary]
create index pn on #tmp (pn) with fillfactor = 90 on [primary]
/*
select id,q1,q2,q3,q4,q5,q6,
customer_code,oem,plant,pn,cpn,ipn,asp,case when AvgPrice=0 then PMaxPrice else AvgPrice end as guessPrice
from #tmp as a join vw_cemFC_customerPN_byDate2  as b on (cpn2 like '%' + pn2 +'%' or pn2 like '%' + cpn2 +'%')
and code=customer_code
where (len(ipn)=8 and substring(ipn,1,1) not in ('H','Q','7','9')) or len(ipn) <> 8
order by id,gamDate desc
*/

-- new start! --
select id,q1,q2,q3,q4,q5,q6,customer_code,oem,plant,pn,cpn,ipn,asp
,case when AvgPrice=0 then PMaxPrice else AvgPrice end as guessPrice,'Production' as isSample into #tmp2
from #tmp as a join vw_cemFC_customerPN_byDate2  as b on (cpn2 like '%' + pn2 +'%' or pn2 like '%' + cpn2 +'%')
and code=customer_code 
where (len(ipn)=8 and substring(ipn,1,1) not in ('H','Q','7','9')) or len(ipn) <> 8
order by id,gamDate desc

delete #tmp where id in (select id from #tmp2)

insert into #tmp2
select id,q1,q2,q3,q4,q5,q6,
customer_code,oem,plant,pn,cpn,ipn,asp,case when AvgPrice=0 then PMaxPrice else AvgPrice end as guessPrice
,'Sample' as isSample
from #tmp as a join vw_cemFC_customerPN_byDate2  as b on (cpn2 like '%' + pn2 +'%' or pn2 like '%' + cpn2 +'%')
and code=customer_code
where (len(ipn)=8 and substring(ipn,1,1) in ('H','Q','7','9'))
order by id,gamDate desc

delete #tmp where id in (select id from #tmp2)

select * from #tmp2 union all
select id,q1,q2,q3,q4,q5,q6,code,'' as oem, '' as plant,pn,'' as cpn,'' as ipn,0 as asp,0 as guessPrice
,'Cannot Matched' as issample 
from #tmp

drop table #tmp2
-- new end! --

drop table #tmp
delete cemFCtable2 where keystamp=@keyStamp

set nocount off










GO
