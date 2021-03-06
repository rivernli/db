USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[ManageReportAnalysis_sp_QueryOutputAmount]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Rivern Li>
-- Create date: <Create Date,2010/01/22>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE  [dbo].[ManageReportAnalysis_sp_QueryOutputAmount]
@FYear nvarchar(15),
@Plant nvarchar(15)
AS
BEGIN
	
	SET NOCOUNT ON;
--	if @plant <> 'All'
--		begin
--			select Plant,FYear,Period,cast(SalesAmount as decimal(18,0)) as Amount from dbo.CostTotal
--			where	FYear = @FYear
--			and		Plant = @Plant
--			order by plant
--		end
--	else
--		begin
--			select 'ALL' as Plant,FYear,Period,sum(cast(SalesAmount as decimal(18,0))) as Amount from dbo.CostTotal
--			where	FYear = @FYear
--			and plant <> 'Total'
--			group by FYear,Period
--			order by plant
--		end		
	if @plant <> 'All'
		begin
			select Plant,FYear,Period,sum(cast(SalesAmount as decimal(18,0))) as Amount from dbo.CostDetail
			where	FYear = @FYear
			and		Plant = @Plant
			group by Plant,FYear,Period
			order by plant,FYear,Period
		end
	else
		begin
			select 'ALL' as Plant,FYear,Period,sum(cast(SalesAmount as decimal(18,0))) as Amount from dbo.CostDetail
			where	FYear = @FYear
			and plant <> 'Total'
			group by FYear,Period
			order by plant
		end
END


GO
