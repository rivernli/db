USE [FactoryLoading]
GO
/****** Object:  View [dbo].[vw_TFSBOM421180_by_Unit]    Script Date: 2014/11/12 17:06:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--select * from dbo.TFSBOM421180
--
--SELECT TOP 1 @unitNum = t$unst * t$cbpn FROM FactoryLoading.dbo.TFSAMI002180 
--	WHERE	left(t$pjno,10) = @temp_pjno
--	ORDER BY T$SIDE ASC
CREATE view [dbo].[vw_TFSBOM421180_by_Unit]
as
select a.t$pjno,t$sern,cast((cast(SUM(T$BOMC) as decimal(18,4))/
	(
		SELECT TOP 1 
			case b.t$unst * b.t$cbpn 
			when 0 then 1
			else b.t$unst * b.t$cbpn
			end
		FROM FactoryLoading.dbo.TFSAMI002180 as b 
		WHERE	T$prjf = a.t$pjno
		ORDER BY T$SIDE ASC)
	) as decimal(18,4)) AS BOCOS 

from dbo.TFSBOM421180 as a
GROUP BY a.t$pjno,t$sern
GO
