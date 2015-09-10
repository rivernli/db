USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[ManageReportAnalysis_sp_QueryPlant]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Rivern Li>
-- Create date: <Create Date,2010/01/22>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE  [dbo].[ManageReportAnalysis_sp_QueryPlant]
AS
BEGIN
	SET NOCOUNT ON;
	select Plant into #Temp
	from dbo.CostDetail 
	group by plant
	order by plant

	alter table #Temp add Secquence int
	update #Temp set Secquence = 1
	insert #Temp (Plant,Secquence) values('ALL',2)

	select Plant from #Temp order by Secquence
END



GO
