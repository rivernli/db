USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[ManageReportAnalysis_sp_QueryPeriod_1]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Author,,Rivern Li>
-- Create date: <Create Date,2010/01/22>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE  [dbo].[ManageReportAnalysis_sp_QueryPeriod_1]
@FYear nvarchar(50)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @SqlString nvarchar(1000)

	SET @SqlString = '
	select distinct (Fyear+Period) as Period
	from dbo.CostDetail 
	where Fyear in ('+@FYear+')
	order by Period'

	EXECUTE(@SqlString)
END




GO
