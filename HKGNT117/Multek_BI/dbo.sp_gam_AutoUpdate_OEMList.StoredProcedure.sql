USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_gam_AutoUpdate_OEMList]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









CREATE procedure [dbo].[sp_gam_AutoUpdate_OEMList]
as
insert into GAM_BaanOEMList (OEMName,Plant,collectDate)
select baanoem.*,getdate() from 
(
	SELECT ltrim(rtrim(OEM)) as oem, rtrim(plant) as plant FROM  gam_sales GROUP BY OEM, plant 
) as baanoem left join 
gam_baanOEMList on baanoem.oem = gam_baanOEMList.oemname and isnull(baanoem.plant,0) = isnull(gam_baanOEMList.plant,0)
where BaanOEMId is null and oem <>''


insert into GAM_BaanOEMList (OEMName,Plant,collectDate)

select oem,tmp.plant,getdate() from 
(
select oem, case when plant = 'P1' or plant ='p2' then 'B1' else plant end as plant 
from multekchi_realtime.dbo.vw_gam__shipment_SMP_Tooling_OEM
) as tmp 
left join GAM_BaanOEMList 
on oemname=oem and tmp.plant = gam_baanoemlist.plant
where baanoemid is null


update GAM_BaanOEMList set groupName='' where groupName is null




GO
