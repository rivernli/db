USE [Multek_ZH_New]
GO
/****** Object:  View [dbo].[vw_sgp_cost]    Script Date: 11/06/2014 15:50:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[vw_sgp_cost]
as
select  *,
(laminate+prepreg+Copper_Foil + RCC_Foil +coin) as BOM,
(Dry_Film + smcm + fccl + Coverlay + Adhesive + Stiffener + Sheildling_Film  + gold + drill_bit + bevelling_tool
+ Countersink + Miling_tool + router + other_EDM_mat) as EDM,
direct_labor as DL,
indirect_salaries_benefit as IDL,
(equipment_expenses + Facilities_Utilities  + computer_related + Supplies + Travel_Entertainment + Other_Expenses ) as Variable_MOH,
depreciation_amortization as depreciation ,
SGA_Cost as fixed_GnA
from [vw_sgp_cost_detail]
GO
