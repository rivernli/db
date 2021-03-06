USE [Multek_ZH_New]
GO
/****** Object:  View [dbo].[vw_SGP_WorkflowStatus]    Script Date: 11/06/2014 15:50:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[vw_SGP_WorkflowStatus]
as

select 
a.*,
start_time,
vps_id,vps_name,vps_date,vps_status,
gm_id,gm_name,gm_date,gm_status,
vpo_id,vpo_name,vpo_date,vpo_status,
pres_id,pres_name,pres_date,pres_status,
isnull(b.status,0) as WFStatus,
rej_id,rej_name,rej_date,modDate

,case when b.status=0 then
	datediff(hh,start_time,getdate())
else
	isnull(datediff(hh,start_time,isnull(modDate,getdate())),0)
end as time2go
 from dbo.vw_SGP_pricing_simALL as a left join
 vw_sgp_workFlow as b
on b.id=a.costid
where a.status = 2
GO
