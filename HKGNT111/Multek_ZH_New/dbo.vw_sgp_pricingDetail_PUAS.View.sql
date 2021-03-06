USE [Multek_ZH_New]
GO
/****** Object:  View [dbo].[vw_sgp_pricingDetail_PUAS]    Script Date: 11/06/2014 15:50:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[vw_sgp_pricingDetail_PUAS]
as

select  *,
AMT * bomp / 100 as BOMa, sqft_price * bomp/100 as BOMs,
AMT * edmp / 100 as EDMa, sqft_price * edmp/100 as EDMs,
AMT * mrb_yieldp / 100 as MRB_YIELDa, sqft_price * mrb_yieldp/100 as MRB_YIELDs,
AMT * dlp/100 as DLa,sqft_price * dlp/100 as DLs,
AMT * mohp/100 as MOHa,sqft_price * mohp/100 as MOHs,
AMT * vcp/100 as VCa,sqft_price * vcp/100 AS VCs,
AMT * FREIGHTp/100 as FREIGHTa,sqft_price * FREIGHTp/100 as FREIGHTs,
AMT * MPp/100 as MPa,sqft_price * MPp/100 as MPs,
AMT * DEPRECIATIONp/100 as DEPRECIATIONa,sqft_price * DEPRECIATIONp/100 as DEPRECIATIONs,
AMT * fixedMOHp/100 as fixedMOHa,sqft_price * fixedMOHp/100 as fixedMOHs,
AMT * fixedGnAp/100 as fixedGnAa,sqft_price * fixedGnAp/100 as fixedGnAs,
AMT * FCp/100 as FCa,sqft_price * FCp/100 as FCs,
AMT * OPp/100 as OPa,sqft_price * OPp/100 as OPs
 from Dbo.vw_SGP_pricing_simAll
GO
