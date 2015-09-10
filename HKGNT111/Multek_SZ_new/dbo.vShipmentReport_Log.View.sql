USE [Multek_SZ_New]
GO
/****** Object:  View [dbo].[vShipmentReport_Log]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vShipmentReport_Log]
as
select UserID as UID,OperatedDate as ActionTime,Operation as [action],Remark as [description],'' as URL
from ShipmentReport_Log
GO
