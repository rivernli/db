USE [Multek_ZH]
GO
/****** Object:  View [dbo].[Multek_IE_MPS_Calc]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[Multek_IE_MPS_Calc]
AS
SELECT CASE WHEN T$PLNT = '2F' THEN 'B2F' ELSE T$PLNT END T$PLNT,T$ITEM,T$DSCA,T$WODT,T$OUUA,cast(T$SQFT as decimal(18,4)) as T$SQFT
FROM DBO.TFSOLP125180
WHERE DATEDIFF(DD,T$JDAT,GETDATE()) = 0
AND T$PLNT <> 'HK'

GO
