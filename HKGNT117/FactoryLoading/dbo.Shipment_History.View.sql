USE [FactoryLoading]
GO
/****** Object:  View [dbo].[Shipment_History]    Script Date: 2014/11/12 17:06:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Shipment_History]
AS
select A.*,b.t$plnt from multekchi_realtime.dbo.TFSOLP101180 as A left join dbo.TFSCPP201180 as B on A.t$cwar = b.t$cwar
GO
