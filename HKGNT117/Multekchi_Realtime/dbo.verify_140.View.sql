USE [multekchi_realtime]
GO
/****** Object:  View [dbo].[verify_140]    Script Date: 2014/11/12 17:13:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[verify_140]
as
	 select  T$plnt,T$orno,T$pono,T$srnb from  dbo.TFSOLP140180 
GO
