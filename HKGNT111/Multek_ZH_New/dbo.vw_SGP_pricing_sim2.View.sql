USE [Multek_ZH_New]
GO
/****** Object:  View [dbo].[vw_SGP_pricing_sim2]    Script Date: 11/06/2014 15:50:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[vw_SGP_pricing_sim2]
as
select p.*,
cast(bom+edmu+mrb_yieldU+dlu+mohu+FREIGHTu as decimal(18,6)) as VCu,
cast(depreciation+idl+fixed_gna  as decimal(18,6)) as FCu,
case when P=0 then 0 else cast(bom/P as decimal(18,6)) end as BOMp,
case when P=0 then 0 else cast(edmu/P as decimal(18,6))  end as EDMp,
case when p=0 then 0 else cast(mrb_yieldu/p as decimal(18,6)) end as MRB_YIELDp,
case when P=0 then 0 else cast(dlu/P as decimal(18,6))  end as DLp,
case when P=0 then 0 else cast(mohu/P as decimal(18,6))  end as MOHp,
case when P=0 then 0 else cast(FREIGHTu/P as decimal(18,6))  end as FREIGHTp
from vw_SGP_pricing_sim1 as p left join vw_sgp_QuoteCostPricing as c on p.costId=c.costId
GO
