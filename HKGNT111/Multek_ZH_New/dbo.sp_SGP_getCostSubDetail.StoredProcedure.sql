USE [Multek_ZH_New]
GO
/****** Object:  StoredProcedure [dbo].[sp_SGP_getCostSubDetail]    Script Date: 11/06/2014 15:50:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_SGP_getCostSubDetail] @cost_id int
as

select a.id,
cast(laminate as decimal(18,6)) as Laminate,
cast(prepreg as decimal(18,6)) as Prepreg,
cast(copper_foil as decimal(18,6)) as CopperFoil,
cast(rcc_foil as decimal(18,6)) as RccFoil,
cast(coin as decimal(18,6)) as Coin,

cast(dry_film/isnull(b.yield,a.yield) as decimal(18,6)) as DryFilm,
cast(SMCM/isnull(b.yield,a.yield) as decimal(18,6)) as SMCM,
cast(FCCL/isnull(b.yield,a.yield) as decimal(18,6)) as FCCL,
cast(Coverlay/isnull(b.yield,a.yield) as decimal(18,6)) as Coverlay,
cast(adhesive/isnull(b.yield,a.yield) as decimal(18,6)) as Adhesive,
cast(Stiffener/isnull(b.yield,a.yield) as decimal(18,6)) as Stiffener,
cast(Sheildling_Film/isnull(b.yield,a.yield) as decimal(18,6)) as SheildlingFilm,
cast(Gold/isnull(b.yield,a.yield) as decimal(18,6)) as Gold,
cast(Drill_bit/isnull(b.yield,a.yield) as decimal(18,6)) as DrillBit,
cast(Bevelling_Tool/isnull(b.yield,a.yield) as decimal(18,6)) as BevellingTool,
cast(Countersink/isnull(b.yield,a.yield) as decimal(18,6)) as Countersink,
cast(Miling_Tool/isnull(b.yield,a.yield) as decimal(18,6)) as MilingTool,
cast(Router/isnull(b.yield,a.yield) as decimal(18,6)) as Router,
cast(Other_EDM_Mat/isnull(b.yield,a.yield) as decimal(18,6)) as OtherEDMMat,

cast(Equipment_Expenses/isnull(b.yield,a.yield) as decimal(18,6)) as EquipmentExpenses,
cast(Facilities_Utilities/isnull(b.yield,a.yield) as decimal(18,6)) as FacilitiesUtilities,
cast(Computer_Related/isnull(b.yield,a.yield) as decimal(18,6)) as ComputerRelated,
cast(Supplies/isnull(b.yield,a.yield) as decimal(18,6)) as Supplies,
cast(Travel_Entertainment/isnull(b.yield,a.yield) as decimal(18,6)) as TravelEntertainment,
cast(Other_Expenses/isnull(b.yield,a.yield) as decimal(18,6)) as OtherExpenses
 from dbo.vw_sgp_cost as a left join sgp_pricing as b  on a.id=cost_id 
 where a.id=@cost_id
GO
