USE [Multek_ZH]
GO
/****** Object:  View [dbo].[vw_tfsolp100180]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vw_tfsolp100180]
as
select * from openquery(as1p1,'select 
		t$orno
		,t$pono
		,t$bad1
		,t$bad2
		,t$coba
		,t$cuno
		,t$cunm
		,t$cwar
		,t$refa
		,t$eono
		,t$item
		,t$cupn
		,t$oqua
from baan.tfsolp100180')
GO
