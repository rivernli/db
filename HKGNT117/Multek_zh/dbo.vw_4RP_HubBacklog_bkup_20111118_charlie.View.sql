USE [Multek_ZH]
GO
/****** Object:  View [dbo].[vw_4RP_HubBacklog_bkup_20111118_charlie]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vw_4RP_HubBacklog_bkup_20111118_charlie]
AS
SELECT A.T$ORNO,A.T$PONO,A.T$ITEM,A.T$ECDT,(A.T$PRIC*C.fgqy) AS FG_avaible,A.T$AMNT,A.T$DDTA,B.T$PLNT,A.T$CDSC
FROM MULTEKCHI_REALTIME.DBO.TFSOLP100180 AS A,FactoryLoading.dbo.TFSCPP201 AS B,FactoryLoading.dbo.vw_fscpp253180 AS C
WHERE A.T$COTP IN ('CNG','CLT')
AND	A.T$CWAR = B.T$CWAR
AND	A.T$ORNO = C.T$ORNO
AND	A.T$PONO = C.T$PONO


GO
