USE [Multek_ZH_New]
GO
/****** Object:  View [dbo].[vw_sgp_rpt_timeGoing]    Script Date: 11/06/2014 15:50:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[vw_sgp_rpt_timeGoing]
as
select rfq,salesman,oem,tpn,project,
case when start_time is null then -1 else
	datediff(hh,adate,start_time)
end as init2Wf,
case when isnull(b.status,0) >0 then 
	datediff(hh,start_time,modDate)
else
	-1
end as WF,
case when isnull(b.status,0) = 0 then
	hours2go
else
	datediff(hh,adate,modDate)
end as ttlHours,

adate,start_time,modDate,isnull(b.status,-1) as wfStatus

from dbo.vw_SGP_pricing_simALL
as a left join vw_sgp_workflow as b  on b.id=a.costid
--order by adate desc
GO
