USE [multekchi_realtime]
GO
/****** Object:  View [dbo].[shipment_backlog_wh]    Script Date: 2014/11/12 17:13:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE view [dbo].[shipment_backlog_wh]
as 
 --select T$PLNT,T$CWAR from TFSCPP201180_cons
 --union all
 --select T$PLNT,T$CWAR from TFSCPP201180
 select T$PLNT,T$CWAR from FactoryLoading.dbo.TFSCPP201180
 union all 
 select T$PLNT,T$CWAR from FactoryLoading.dbo.TFSCPP201183
 union all
  select T$PLNT,T$CWAR from  dbo.Makeup_Warehouse

GO
