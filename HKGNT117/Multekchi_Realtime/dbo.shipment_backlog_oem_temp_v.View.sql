USE [multekchi_realtime]
GO
/****** Object:  View [dbo].[shipment_backlog_oem_temp_v]    Script Date: 2014/11/12 17:13:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[shipment_backlog_oem_temp_v]
as
	select * from shipment_backlog_oem_temp where id in (select min(id) from shipment_backlog_oem_temp group by muid,oem)

GO
