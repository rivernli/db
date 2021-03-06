USE [Multek_ZH_New]
GO
/****** Object:  View [dbo].[vw_SGP_pricing_simALL]    Script Date: 11/06/2014 15:50:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[vw_SGP_pricing_simALL]
as
select  
gpid,c.costid,pricingid,rfq,salesman,name,oem,cem,programme,
tpn,rev,layers,payment_terms,unit_set,set_pnl,pnl_area,au_width,au_length,au_unit,
sqft_price,aspLayer,
project,plant,pricingYield,status,last_update as pricingDate,

Y,P,Q,AMT,
cast(BOM as decimal(18,6)) as BOMu,BOMp *100 as BOMp,
EDMu,EDMp * 100 as EDMp,
MRB_YIELDu,MRB_YIELDp *100 as MRB_YIELDp,
DLu,DLp *100 as DLp,
MOHu,MOHp *100 as MOHp,
FREIGHTu,FREIGHTp *100 as FREIGHTp,
VCu,
case when P=0 then 0 else cast(vcu/p *100 as decimal(18,6)) end as VCp,
case when P=0 then 0 else cast(p-vcu as decimal(18,6)) end as MPu,
case when P=0 then 0 else cast((p-vcu)/p * 100 as decimal(18,6)) end as MPp,

cast(depreciation as decimal(18,6)) as DEPRECIATIONu,
case when P=0 then 0 else cast(depreciation/p *100 as decimal(18,6)) end as DEPRECIATIONp,
cast(idl as decimal(18,6)) as fixedMOHu,
case when P=0 then 0 else cast(idl/p*100 as decimal(18,6)) end as fixedMOHp,
cast(fixed_GnA as decimal(18,6)) as fixedGnAu,
case when P=0 then 0 else cast(fixed_GnA/p*100 as decimal(18,6)) end as fixedGnAp,
FCu,
case when P=0 then 0 else cast(fcu/p*100 as decimal(18,6)) end as FCp,
case when P=0 then 0 else cast(p-vcu-fcu as decimal(18,6)) end as OPu,
case when P=0 then 0 else cast( (p-vcu-fcu)/p *100 as decimal(18,6)) end as OPp
,priced, adate, datediff(hh,adate,GETDATE()) hours2go
from vw_SGP_pricing_sim2 as p left join vw_sgp_QuoteCostPricing as c on p.costId=c.costId
/*
left join 
SGP_Dictionary on DefineId=status and DictTypeId=1
*/
GO
