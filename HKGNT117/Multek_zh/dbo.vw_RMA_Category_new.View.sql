USE [Multek_ZH]
GO
/****** Object:  View [dbo].[vw_RMA_Category_new]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vw_RMA_Category_new]
AS
SELECT     (CASE WHEN (A.FSRMA IS NULL OR
                      A.FSRMA = '') THEN '1st RMA' WHEN A.quant < 0 AND (A.FSRMA IS NOT NULL OR
                      A.FSRMA <> '') THEN 'CRN' WHEN A.quant >= 0 AND (A.FSRMA IS NOT NULL OR
                      A.FSRMA <> '') THEN '2nd RMA' END) AS Category,
			A.CATEG,A.PLANT,
			A.EDATE  as END_Date,
			A.TTLPR,
	(
		select top 1 b.t$YDSC from FactoryLoading.dbo.TTFGLD005180 as a left join FactoryLoading.dbo.TTFGLD006180 as b
		on a.t$year = b. t$year
		where t$stdt < convert(nvarchar(11),EDATE,120)
		and	t$ptyp = 1
		order by t$stdt desc
	)
	T$year,
	(
		select top 1 t$prno from FactoryLoading.dbo.TTFGLD005180 
		where t$stdt < convert(nvarchar(11),A.EDATE,120)
		and	t$ptyp = 1
		order by t$stdt desc
	)
	t$prod
FROM         HKGNT141.it.dbo.vw_RMA_Category AS A 
WHERE     (CATEG IS NOT NULL)


GO
