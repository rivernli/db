USE [Multek_ZH_New]
GO
/****** Object:  View [dbo].[vw_sgp_pricingDetail_PUAS_BK]    Script Date: 11/06/2014 15:50:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[vw_sgp_pricingDetail_PUAS_BK]
as
select 
gpid,costid,pricingid,rfq,salesman,name,oem,cem,programme,tpn,rev,layers, payment_terms,
project,cast(aspLayer as decimal(18,6)) as ASPLayer,cast(sqft_price as decimal(18,6)) as SQFTPrice,Y,P,Q,
BOMp,BOMu,
AMT * bomp / 100 as BOMa, sqft_price * bomp/100 as BOMs,
EDMp,EDMu,
AMT * edmp / 100 as EDMa, sqft_price * edmp/100 as EDMs,
MRB_YIELDp,MRB_YIELDu,
AMT * mrb_yieldp / 100 as MRB_YIELDa, sqft_price * mrb_yieldp/100 as MRB_YIELDs,
DLp,DLu,
AMT * dlp/100 as DLa,sqft_price * dlp/100 as DLs,
MOHp,MOHu,
AMT * mohp/100 as MOHa,sqft_price * mohp/100 as MOHs,
FREIGHTp,FREIGHTu,
AMT * FREIGHTp/100 as FREIGHTa,sqft_price * FREIGHTp/100 as FREIGHTs,
MPp,MPu,
AMT * MPp/100 as MPa,sqft_price * MPp/100 as MPs,
DEPRECIATIONp,DEPRECIATIONu,
AMT * DEPRECIATIONp/100 as DEPRECIATIONa,sqft_price * DEPRECIATIONp/100 as DEPRECIATIONs,
fixedMOHp,fixedMOHu,
AMT * fixedMOHp/100 as fixedMOHa,sqft_price * fixedMOHp/100 as fixedMOHs,
fixedGnAp,fixedGnAu,
AMT * fixedGnAp/100 as fixedGnAa,sqft_price * fixedGnAp/100 as fixedGnAs,
FCp,FCu,
AMT * FCp/100 as FCa,sqft_price * FCp/100 as FCs,
OPp,OPu,
AMT * OPp/100 as OPa,sqft_price * OPp/100 as OPs
 from Dbo.vw_SGP_pricing_simAll
GO
