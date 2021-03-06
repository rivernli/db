USE [Multek_ZH_New]
GO
/****** Object:  View [dbo].[vw_sgp_cost_bk_DivideUnitPanel]    Script Date: 11/06/2014 15:50:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vw_sgp_cost_bk_DivideUnitPanel]
as
select  *,
(laminate+prepreg+Copper_Foil + RCC_Foil +coin)/(unit_pnl) as BOM,
(Dry_Film + smcm + fccl + Coverlay + Adhesive + Stiffener + Sheildling_Film  + gold + drill_bit + bevelling_tool
+ Countersink + Miling_tool + router + other_EDM_mat) /unit_pnl as EDM,
direct_labor/unit_pnl as DL,
indirect_salaries_benefit/unit_pnl as IDL,
(equipment_expenses + Facilities_Utilities  + computer_related + Supplies + Travel_Entertainment + Other_Expenses )/unit_pnl as Variable_MOH,
depreciation_amortization/unit_pnl as depreciation ,
SGA_Cost/unit_pnl as fixed_GnA
from [vw_sgp_cost_detail]
GO
