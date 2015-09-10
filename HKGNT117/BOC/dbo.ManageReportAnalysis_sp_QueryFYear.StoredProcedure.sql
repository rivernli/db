USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[ManageReportAnalysis_sp_QueryFYear]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Rivern Li>
-- Create date: <Create Date,2010/01/22>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE  [dbo].[ManageReportAnalysis_sp_QueryFYear]
AS
BEGIN
	SET NOCOUNT ON;
	SELECT FYear 
	FROM dbo.CostDetail 
	GROUP BY FYear
	ORDER BY FYear DESC
END


GO
