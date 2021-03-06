USE [Multek_ZH]
GO
/****** Object:  View [dbo].[vc_Standard_Cost_BOM_DETAILS]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[vc_Standard_Cost_BOM_DETAILS]
AS
select A.T$PITM as [Project Code],A.T$VERS as [Version Number],A.T$CITG as [Item Group],C.T$DSCA as [Item Type],A.T$STEP as [ Step],
A.T$ITEM as [Baan Item Code],B.T$DSCA as [Description],A.T$SEQE as [Sequence],A.T$CWOC as [Work Centre],A.T$MNWC as [MI Work Centre],
A.T$QUTY as [Consumption Qty],A.T$UNIT as [Consumption Unit],A.T$PRIC as [Item Price],A.T$OCUN as [Currency],A.T$COST as [BOM Cost] 
FROM DBO.TFSBOM201180 AS A LEFT JOIN FactoryLoading.dbo.TTIITM001180 AS B 
ON A.T$ITEM = B.T$ITEM LEFT JOIN FactoryLoading.dbo.TTCMCS023180 AS C 
ON A.T$CITG = C.T$CITG 



GO
