USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_gam_cemUploadCompareOutputTemp3]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









CREATE procedure [dbo].[sp_gam_cemUploadCompareOutputTemp3] @keyStamp nvarchar(100)
as
set nocount on
select id=identity(int, 1, 1),code,pn,q1,q2,q3,q4,q5,q6,convert(varchar(100),replace(pn,' ','')) as pn2 
into #tmp from cemFCtable2 where keystamp=@keyStamp
and (q1+q2+q3+q4+q5+q6 >0)

create index pn2 on #tmp (pn2) with fillfactor = 90 on [primary]
create index pn on #tmp (pn) with fillfactor = 90 on [primary]

select id,code,pn,q1,q2,q3,q4,q5,q6 from #tmp order by code,pn

select id,oem,cpn,ipn,plant,convert(datetime, gamDate, 112) as lastDate,asp,case when AvgPrice=0 then maxPrice else AvgPrice end as guessPrice
from #tmp as a join vw_cemFC_customerPN_byDate  as b on (cpn2 like '%' + pn2 +'%' or pn2 like '%' + cpn2 +'%')
where (len(ipn)=8 and substring(ipn,1,1) not in ('H','Q','7','9')) or len(ipn) <> 8
order by id, gamDate desc
--order by id, case when len(cpn2) > len(pn2) then 0 else 1 end, gamDate desc

drop table #tmp
delete cemFCtable2 where keystamp=@keyStamp

set nocount off









GO
