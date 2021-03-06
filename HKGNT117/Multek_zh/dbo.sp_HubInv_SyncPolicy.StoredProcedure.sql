USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_HubInv_SyncPolicy]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE procedure [dbo].[sp_HubInv_SyncPolicy]
as
--for billing policy
insert into hubInventoryOEMPolicy (billingPolicy,transit,warehouseId)
select distinct 0,0,a.warehouseId
from dbo.vw_4RP_HubInv as a
left join hubInventoryOEMPolicy as b on a.warehouseId=b.warehouseId
where b.warehouseId is null


--for cem location
select distinct t$cuno as cu into #tmp from TFSOLP114180 where t$cuno <> ''
delete #tmp where cu ='' or cu is null

insert into hubInventoryCEMLocation (customer_code)
select cu from #tmp where cu not in (select customer_code from hubInventoryCEMLocation)
drop table #tmp


GO
