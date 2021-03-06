USE [Multek_ZH_New]
GO
/****** Object:  View [dbo].[vw_SGP_pricing_sim1]    Script Date: 11/06/2014 15:50:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[vw_SGP_pricing_sim1]
as
select b.*,P*Q as AMT,
cast(edm/Y as decimal(18,6)) as EDMu,
cast(bom/Y - bom as decimal(18,6)) as MRB_YIELDu,
cast(dl/Y as decimal(18,6)) as DLu,
cast(variable_moh/Y as decimal(18,6)) as MOHu,
cast(bom * 0.05 as decimal(18,6)) as FREIGHTu
from vw_sgp_QuoteCostPricing  as a
join (
	select costId,isnull(pricingYield,yield) as Y,isnull(price,0) as P, ISNULL(qty,0) as Q from vw_sgp_QuoteCostPricing
) as b
on a.costid=b.costid where a.costId > 0
GO
