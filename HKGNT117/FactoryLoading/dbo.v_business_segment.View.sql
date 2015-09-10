USE [FactoryLoading]
GO
/****** Object:  View [dbo].[v_business_segment]    Script Date: 2014/11/12 17:06:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[v_business_segment]
AS
select (case t$item when '' then t$pfix+t$pitm+t$pver else t$item end) as Project,a.t$iseg,b.t$dsca
from [dbo].[TFSCPP200180] as a left join [dbo].[TFICOM006180] as b on a.t$iseg = b.T$ISEG
GO
