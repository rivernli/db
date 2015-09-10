USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[ManageReportAnalysis_sp_QueryPeriodCount]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Rivern Li>
-- Create date: <Create Date,2010/01/22>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE  [dbo].[ManageReportAnalysis_sp_QueryPeriodCount]
@FYear nvarchar(15)
AS
BEGIN
	SET NOCOUNT ON;
	select distinct Period
	from dbo.CostDetail 
	where Fyear = @FYear
	order by Period
END




GO
