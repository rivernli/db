USE [multekchi_realtime]
GO
/****** Object:  View [dbo].[vw_TFSOLP100180_temp]    Script Date: 2014/11/12 17:13:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE view [dbo].[vw_TFSOLP100180_temp]
as 
SELECT     a.T$ORNO, a.T$PONO, a.T$BAD1, a.T$BAD2, a.T$COBA, a.T$CUNO, a.T$CUNM, a.T$CWAR, a.T$REFA, a.T$EONO, a.T$ITEM, a.T$CUPN, a.T$PODT, a.T$DDTA, 
                      a.T$RQDT, a.T$OQUA, a.T$BQUA, a.T$CCUR, CAST(a.T$PRIC AS decimal(15, 4)) AS T$PRIC, CAST(a.T$AMNT AS decimal(15, 4)) AS T$AMNT, 
                      CAST(a.T$AREA AS decimal(15, 4)) AS T$AREA, a.T$ECDT, a.T$ADDR, a.T$NAMA, a.T$CSCO, a.T$USNM, a.T$SEGM, a.T$CDSC, a.T$COTP, a.T$STAT, a.T$STYP, 
                      a.T$PSPL, CASE WHEN len(rtrim(ltrim(a.T$ITEM))) < 9 THEN a.T$PRDN WHEN len(rtrim(ltrim(a.T$ITEM))) > 9 THEN c.T$PRDN END AS T$PRDN, a.T$FLEX, a.T$ISEG, 
                      a.T$DESC, b.T$CDEL, c.T$OTYP,d.T$SSTS
FROM         dbo.TFSOLP100180 AS a LEFT OUTER JOIN
                     -- dbo.TFSOLP102180 AS b ON a.T$ORNO = b.T$ORNO AND a.T$PONO = b.T$pono LEFT OUTER JOIN
						dbo.TFSOLP142180 AS b on a.T$ORNO = b.T$ORNO  LEFT OUTER JOIN
                      dbo.vTFSCPP200180 AS c ON a.T$ITEM = c.T$ITEM   LEFT OUTER JOIN
                      Multek_ZH.dbo.ttdsls041180_shipment_Status AS d ON a.T$ORNO = d.T$ORNO and a.T$PONO = d.T$PONO
                                     
                      


GO
