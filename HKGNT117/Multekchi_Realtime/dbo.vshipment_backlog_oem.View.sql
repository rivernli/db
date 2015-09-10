USE [multekchi_realtime]
GO
/****** Object:  View [dbo].[vshipment_backlog_oem]    Script Date: 2014/11/12 17:13:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[vshipment_backlog_oem]
as
	select * from shipment_backlog_oem where id in (select min(id) from shipment_backlog_oem group by muid,oem)
GO
