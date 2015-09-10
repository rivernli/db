USE [Multek_ZH]
GO
/****** Object:  View [dbo].[EXR2_VW_DETAILS]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[EXR2_VW_DETAILS]
AS
-- FG OUT 
SELECT 'FG OUT' AS CATEGORY, A.T$PLNT,A.T$ORNO,A.T$PONO,A.T$DATE,A.T$DESC,A.T$ITEM,A.T$LAYS,A.T$DQUA,A.T$AMNT,A.T$COST AS BOM_100_YIELD,B.T$ASTR AS PROD,D.T$STAD,C.T$ASTR AS SURF
FROM HKGNT111.MULTEK_SZ_NEW.DBO.TFSOLP105180 AS A,
	FACTORYLOADING.DBO.TFIATT006180 AS B,
	FACTORYLOADING.DBO.TFIATT006180 AS C,
	dbo.EXR2_vw_TFSAMI028180		AS D
WHERE A.T$ITEM = B.T$ITEM AND B.T$ATTR = 'TYPE'
AND	A.T$ITEM = C.T$ITEM AND C.T$ATTR = 'SURF'
AND	D.T$VALU = B.T$ASTR

--UNION

---- FG IN
--SELECT 'FG IN' AS CATEGORY, A.T$PLNT,A.T$ORNO,A.T$PONO,A.T$DATE,A.T$DESC,A.T$ITEM,A.T$LAYS,A.T$DQUA,A.T$AMNT,A.T$COST AS BOM_100_YIELD,B.T$ASTR AS PROD,D.T$STAD,C.T$ASTR AS SURF
--FROM HKGNT111.MULTEK_SZ_NEW.DBO.TFSOLP107180 AS A,
--	FACTORYLOADING.DBO.TFIATT006180 AS B,
--	FACTORYLOADING.DBO.TFIATT006180 AS C,
--	dbo.EXR2_vw_TFSAMI028180		AS D
--WHERE A.T$ITEM = B.T$ITEM AND B.T$ATTR = 'TYPE'
--AND	A.T$ITEM = C.T$ITEM AND C.T$ATTR = 'SURF'
--AND	D.T$VALU = B.T$ASTR


--UNION 

---- INVOICE 
--SELECT 'INVOICE' AS CATEGORY, A.T$PLNT,A.T$ORNO,A.T$PONO,A.T$DATE,A.T$DESC,A.T$ITEM,A.T$LAYS,A.T$DQUA,A.T$AMNT,A.T$COST AS BOM_100_YIELD,B.T$ASTR AS PROD,D.T$STAD,C.T$ASTR AS SURF
--FROM HKGNT111.MULTEK_SZ_NEW.DBO.TFSOLP106180 AS A,
--	FACTORYLOADING.DBO.TFIATT006180 AS B,
--	FACTORYLOADING.DBO.TFIATT006180 AS C,
--	dbo.EXR2_vw_TFSAMI028180		AS D
--WHERE A.T$ITEM = B.T$ITEM AND B.T$ATTR = 'TYPE'
--AND	A.T$ITEM = C.T$ITEM AND C.T$ATTR = 'SURF'
--AND	D.T$VALU = B.T$ASTR
GO
