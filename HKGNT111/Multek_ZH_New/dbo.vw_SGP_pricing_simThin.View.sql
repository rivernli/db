USE [Multek_ZH_New]
GO
/****** Object:  View [dbo].[vw_SGP_pricing_simThin]    Script Date: 11/06/2014 15:50:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[vw_SGP_pricing_simThin]
as
select costId,Y,P,Q,status,
BOMu,BOMp,EDMu,EDMp,MRB_YIELDu,MRB_YIELDp,
DLu,DLp,MOHu,MOHp,FREIGHTu,FREIGHTp,VCu,VCp,
MPu,MPp,DEPRECIATIONu,DEPRECIATIONp,
fixedMOHu,fixedMOHp,fixedGnAu,fixedGnAp,
FCu,FCp,OPu,OPp
from vw_SGP_pricing_simAll
GO
