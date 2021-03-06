USE [Multek_ZH_New]
GO
/****** Object:  View [dbo].[vw_MI_Information]    Script Date: 11/06/2014 15:50:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create view [dbo].[vw_MI_Information]
as
select	a.t$pjno,
		a.t$plnt,
		a.t$moly,
		a.t$side,
		a.t$code,
		a.t$cutn,
		a.t$boar,
		a.t$date,
		a.t$grad,
		a.t$panl,
		a.t$panw,
		a.t$brdl,
		a.t$brdw,
		a.t$seta,
		a.t$unst,
		a.t$cbpn,
		a.t$bga,
		b.t$fcun,
		b.t$wcun
from [dbo].[TFSAMI002180] as a left join [dbo].[TFSAMI111180] as b
on a.t$code = b.T$CODE
GO
