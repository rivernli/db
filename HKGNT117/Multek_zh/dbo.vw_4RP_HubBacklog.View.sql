USE [Multek_ZH]
GO
/****** Object:  View [dbo].[vw_4RP_HubBacklog]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_4RP_HubBacklog] 
AS
SELECT A.T$ORNO,A.T$PONO,A.T$ITEM,A.T$ECDT,((A.T$AMNT/A.T$BQUA)*C.fgqy) AS FG_avaible, (A.T$OQUA - C.T$HUBQ)*(A.T$AMNT/A.T$BQUA) AS T$AMNT,A.T$DDTA,B.T$PLNT,A.T$CDSC
FROM multekchi_realtime.dbo.vw_TFSOLP100180 AS A,FactoryLoading.dbo.TFSCPP201 AS B,FactoryLoading.dbo.vw_fscpp253180 AS C--,dbo.TFSOLP120180 AS D
WHERE A.T$COTP IN ('CNG','CLT')
AND	A.T$CWAR = B.T$CWAR
AND	A.T$ORNO = C.T$ORNO
AND	A.T$PONO = C.T$PONO
AND ltrim(rtrim(cast(A.T$orno as char(6))))+ ltrim(rtrim(cast(A.T$Pono as char(4))))  not in (select ltrim(rtrim(cast(T$orno as char(6))))+ ltrim(rtrim(cast(T$Pono as char(4)))) from dbo.TFSOLP120180 where  convert(char(10),T$DATE,120) = convert(char(10),getdate()-1,120))
GO
