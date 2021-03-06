USE [Multek_ZH_New]
GO
/****** Object:  StoredProcedure [dbo].[sp_SGP_getCostSubDetail_bk_DivideUnitPanel]    Script Date: 11/06/2014 15:50:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_SGP_getCostSubDetail_bk_DivideUnitPanel] @cost_id int
as

select a.id,
cast(laminate/unit_pnl as decimal(18,6)) as Laminate,
cast(prepreg/unit_pnl as decimal(18,6)) as Prepreg,
cast(copper_foil/unit_pnl as decimal(18,6)) as CopperFoil,
cast(rcc_foil/unit_pnl as decimal(18,6)) as RccFoil,
cast(coin/unit_pnl as decimal(18,6)) as Coin,

cast(dry_film/unit_pnl/isnull(b.yield,a.yield) as decimal(18,6)) as DryFilm,
cast(SMCM/unit_pnl/isnull(b.yield,a.yield) as decimal(18,6)) as SMCM,
cast(FCCL/unit_pnl/isnull(b.yield,a.yield) as decimal(18,6)) as FCCL,
cast(Coverlay/unit_pnl/isnull(b.yield,a.yield) as decimal(18,6)) as Coverlay,
cast(adhesive/unit_pnl/isnull(b.yield,a.yield) as decimal(18,6)) as Adhesive,
cast(Stiffener/unit_pnl/isnull(b.yield,a.yield) as decimal(18,6)) as Stiffener,
cast(Sheildling_Film/unit_pnl/isnull(b.yield,a.yield) as decimal(18,6)) as SheildlingFilm,
cast(Gold/unit_pnl/isnull(b.yield,a.yield) as decimal(18,6)) as Gold,
cast(Drill_bit/unit_pnl/isnull(b.yield,a.yield) as decimal(18,6)) as DrillBit,
cast(Bevelling_Tool/unit_pnl/isnull(b.yield,a.yield) as decimal(18,6)) as BevellingTool,
cast(Countersink/unit_pnl/isnull(b.yield,a.yield) as decimal(18,6)) as Countersink,
cast(Miling_Tool/unit_pnl/isnull(b.yield,a.yield) as decimal(18,6)) as MilingTool,
cast(Router/unit_pnl/isnull(b.yield,a.yield) as decimal(18,6)) as Router,
cast(Other_EDM_Mat/unit_pnl/isnull(b.yield,a.yield) as decimal(18,6)) as OtherEDMMat,

cast(Equipment_Expenses/unit_pnl/isnull(b.yield,a.yield) as decimal(18,6)) as EquipmentExpenses,
cast(Facilities_Utilities/unit_pnl/isnull(b.yield,a.yield) as decimal(18,6)) as FacilitiesUtilities,
cast(Computer_Related/unit_pnl/isnull(b.yield,a.yield) as decimal(18,6)) as ComputerRelated,
cast(Supplies/unit_pnl/isnull(b.yield,a.yield) as decimal(18,6)) as Supplies,
cast(Travel_Entertainment/unit_pnl/isnull(b.yield,a.yield) as decimal(18,6)) as TravelEntertainment,
cast(Other_Expenses/unit_pnl/isnull(b.yield,a.yield) as decimal(18,6)) as OtherExpenses
 from dbo.vw_sgp_cost as a left join sgp_pricing as b  on a.id=cost_id 
 where a.id=@cost_id
GO
