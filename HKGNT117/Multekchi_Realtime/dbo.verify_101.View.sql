USE [multekchi_realtime]
GO
/****** Object:  View [dbo].[verify_101]    Script Date: 2014/11/12 17:13:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[verify_101]
as
	select  b.T$plnt,a.T$orno,a.T$pono,a.T$srnb from  dbo.TFSOLP101180 a, FactoryLoading.dbo.TFSCPP201180 b  where  a.T$cwar = b.T$cwar 

GO
