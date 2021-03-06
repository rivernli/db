USE [Multek_ZH_New]
GO
/****** Object:  StoredProcedure [dbo].[sp_SGP_Pricing_PLSimulation]    Script Date: 11/06/2014 15:50:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_SGP_Pricing_PLSimulation] @id int,@price float, @subcontractingCost float=0, 
@yield float=null, @DLp float=0,@freight_others float = 0.05
as

--declare @DLp float,@freight_others float, @price float, @project nvarchar(20),@yield float, @id int, @SubcontractingCost float,

--select @price = 10, @id=1, @DLp = 0.0, @freight_others = 0.05 --< fixed

if (@yield is null or @yield = 0)
select @yield = yield from  vw_sgp_cost where id= @id -- and Project = @project 
if(@SubcontractingCost is null)
	select @SubcontractingCost = 0

declare @BOMu decimal(8,3),@EDMu decimal(8,3), @MRB_YIELDu decimal(8,3), @DLu decimal(8,3),
@MOHu decimal(8,3), @FREIGHT_OTHERSu decimal(8,3),@DEPRECIATIONu decimal(8,3),
@fixedMOHu decimal(8,3), @fixedGnAu decimal(8,3),@VCu decimal(8,3),@FCu decimal(8,3)
--,@SubcontractingCOSTu decimal(8,3),@SubcontractingCOSTp decimal(8,3)

select @BOMu= BOM, @EDMu=EDM/@yield,
@MRB_YIELDu = BOM/@yield - BOM,
@DLu= DL/@yield* (1+@DLp),
@MOHu=Variable_MOH/@yield,
@FREIGHT_OTHERSu=BOM * @freight_others,
@DEPRECIATIONu=depreciation ,
@fixedMOHu=IDL, @fixedGnAu=fixed_GnA,
@VCu = @BOMu+@EDMu+@MRB_YIELDu+@DLu + @MOHu + @FREIGHT_OTHERSu + @SubcontractingCost,
@FCu = @DEPRECIATIONu + @fixedMOHu + @fixedGnAu
from  vw_sgp_cost
where id=@id

select id as cost_id, sgp_id, plant,MOH_version,project,@yield as YIELD,@price as Price,
round(@BOMu,3) as BOMu, 
@BOMu/@price as BOMp,
@EDMu as EDMu, 
@EDMu/@price as EDMp,
round(@MRB_YIELDu,3) as MRB_YIELDu, 
round(@MRB_YIELDu/@price,3) as MRB_YIELDp,
@DLu as DLu,@DLu/@price as DLp,
@MOHu as MOHu, @MOHu/@price as MOHp,
@FREIGHT_OTHERSu as FREIGHT_OTHERSu, @FREIGHT_OTHERSu/@price as FREIGHT_OTHERSp,
@SubcontractingCost as SubcontractingCOSTu, @SubcontractingCost/@price as SubcontractingCOSTp,
@VCu as VCu, @VCu/@price as VCp,
@price- @VCu as MPu, (@price-@VCu)/@price as MPp,
@DEPRECIATIONu as DEPRECIATIONu, @DEPRECIATIONu/@price as DEPRECIATIONp,
@fixedMOHu as fixedMOHu, @fixedMOHu/@price as fixedMOHp,
@fixedGnAu as fixedGnAu, @fixedGnAu/@price as fixedGnAp,
@FCu as FCu, @FCu/@price as FCp,
(@price-@VCu)-@FCu as OPu,
((@price-@VCu)-@FCu)/@price as OPp
from vw_sgp_cost where id=@id
GO
