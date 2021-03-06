USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_gam_cemUploadCompareOutputTemp2]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE procedure [dbo].[sp_gam_cemUploadCompareOutputTemp2] @keyStamp nvarchar(100)
as
set nocount on
select id=identity(int, 1, 1),code,pn,q1,q2,q3,q4,q5,q6,convert(varchar(100),replace(pn,' ','')) as pn2 
into #tmp from cemFCtable2 where keystamp=@keyStamp

create index pn2 on #tmp (pn2) with fillfactor = 90 on [primary]
create index pn on #tmp (pn) with fillfactor = 90 on [primary]

select id,code,pn,q1,q2,q3,q4,q5,q6 from #tmp

/*
select ipnv=case when len(ipn)=8 then substring(ipn,8,1) else '0' end,*
from dbo.cemFC_customerPN where gamDate >= 20090705 
and (len(ipn)=8 and substring(ipn,1,1) not in('H','0','7','9'))

*/
/*
select id,oem,cpn,ipn,plant,gamDate as lastDate,asp,
case when AvgPrice=0 then maxPrice else AvgPrice end as guessPrice
from #tmp as a join cemFC_customerPN  as b on '%'+ cpn2 +'%' like '%' + pn2 +'%' order by id
*/

select id,oem,cpn,ipn,plant,gamDate as lastDate,asp,
case when AvgPrice=0 then maxPrice else AvgPrice end as guessPrice
from #tmp as a join cemFC_customerPN  as b 
on (cpn2 like '%' + pn2 +'%' or pn2 like '%' + cpn2 +'%') 
order by id,gamDate desc


drop table #tmp

delete cemFCtable2 where keystamp=@keyStamp

set nocount off





GO
