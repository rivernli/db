USE [Multek_ZH_New]
GO
/****** Object:  View [dbo].[vw_sgp_QuoteCostPricing]    Script Date: 11/06/2014 15:50:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--select top 10 * from vw_tfsbom400180

CREATE view [dbo].[vw_sgp_QuoteCostPricing]
as

select a.id as gpId, isnull(b.id,0) as costId, isnull(c.id,0) as pricingId,
case when c.id is null then 0 else 1 end as priced,
rfq,salesman,oem,cem,name,programme,tpn,rev,adate,
a.layers,c.payment_terms,unit_set,set_pnl,pnl_area,
width as au_width,length as au_length, unit as au_unit,

case when price is null or price=0 then 0 else 
price/(pnl_area/unit_set/set_pnl) end as sqft_price,
case when price is null or price=0 then 0 else 
price/layers end as aspLayer,

b.project,plant,b.yield,bom,edm,dl,idl,variable_moh,depreciation,fixed_gnA,
c.price,c.qty,c.yield as pricingYield,isnull(c.status,0) as status,c.last_update

from sgp_data as a 
left join vw_sgp_cost as b on a.id=b.sgp_id
left join sgp_pricing as c on b.id=c.cost_id
GO
