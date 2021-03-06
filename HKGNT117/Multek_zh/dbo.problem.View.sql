USE [Multek_ZH]
GO
/****** Object:  View [dbo].[problem]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[problem]
as
SELECT A.T$ORNO,A.T$PONO,A.T$ITEM,A.T$ECDT,(A.T$PRIC*C.fgqy) AS FG_avaible, (A.T$OQUA - C.T$HUBQ)*(A.T$AMNT/A.T$BQUA) AS T$AMNT,A.T$DDTA,B.T$PLNT,A.T$CDSC
FROM MULTEKCHI_REALTIME.DBO.TFSOLP100180 AS A,FactoryLoading.dbo.TFSCPP201 AS B,FactoryLoading.dbo.vw_fscpp253180 AS C,dbo.TFSOLP120180 AS D
WHERE A.T$COTP IN ('CNG','CLT')
AND	A.T$CWAR = B.T$CWAR
AND	A.T$ORNO = C.T$ORNO
AND	A.T$PONO = C.T$PONO
--and A.T$ORNO+A.T$PONO <> D.T$ORNO+D.T$PONO
AND A.T$ORNO <> D.T$ORNO
AND A.T$PONO <> D.T$PONO
AND convert(char(10),D.T$DATE,120) = convert(char(10),getdate()-1,120)
GO
