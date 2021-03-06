USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[sp_Exr2_TotalOutSqft]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		<Author,,Rivern Li>
-- Create date: <Create Date,2010/01/22>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE  [dbo].[sp_Exr2_TotalOutSqft]
@FYear nvarchar(15),
@Plant nvarchar(15)
AS
BEGIN
	
	SET NOCOUNT ON;
--	if @plant <> 'All'
--		begin
--			select Plant,FYear,Period,cast(TotalSQFT as decimal(18,0)) as SQFT from dbo.CostTotal
--			where	FYear = @FYear
--			and		Plant = @Plant
--			order by plant
--		end
--	else
--		begin
--			select 'ALL' as Plant,FYear,Period,sum(cast(TotalSQFT as decimal(18,0))) as SQFT from dbo.CostTotal
--			where	FYear = @FYear
--			and plant <> 'Total'
--			group by FYear,Period
--			order by plant
--		end		
	if @plant <> 'All'
		begin
			select Plant,FYear,Period,cast(sum([ShipmentArea(SQFT)]) as decimal(18,0)) as SQFT from dbo.CostDetail
			where	FYear = @FYear
			and		Plant = @Plant
			group by Plant,FYear,Period
			order by Plant,FYear,Period
		end
	else
		begin
			select 'ALL' as Plant,FYear,Period,cast(sum([ShipmentArea(SQFT)]) as decimal(18,0)) as SQFT from dbo.CostDetail
			where	FYear = @FYear
			and plant <> 'Total'
			group by FYear,Period
			order by Plant,FYear,Period
		end	
END





GO
