USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[EXR2_sp_Query_Output_Amount]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Author,,Rivern Li>
-- Create date: <Create Date,2010/01/22>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE  [dbo].[EXR2_sp_Query_Output_Amount]
@FYear nvarchar(15),
@Plant nvarchar(15)
AS
BEGIN
	
	SET NOCOUNT ON;
	if @plant <> 'All'
		begin
			select Plant,FYear,Period,sum(cast(SalesAmount as decimal(18,0))) as Amount from dbo.EXR2_Details
			where	FYear = @FYear
			and		Plant = @Plant
			group by Plant,FYear,Period
			order by plant
		end
	else
		begin
			select 'ALL' as Plant,FYear,Period,sum(cast(SalesAmount as decimal(18,0))) as Amount from dbo.EXR2_Details
			where	FYear = @FYear
			and plant <> 'Total'
			group by FYear,Period
			order by plant
		end
END




GO
