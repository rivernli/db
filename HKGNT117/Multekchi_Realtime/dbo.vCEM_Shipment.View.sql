USE [multekchi_realtime]
GO
/****** Object:  View [dbo].[vCEM_Shipment]    Script Date: 2014/11/12 17:13:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vCEM_Shipment]
as
select cem_name from dbo.vMKT_Shipment_CN_New group by cem_name
union all
select cem_name from dbo.vMKT_Shipment_DE_New group by cem_name
union all
select cem_name from dbo.vMKT_Shipment_BR_New group by cem_name
GO
