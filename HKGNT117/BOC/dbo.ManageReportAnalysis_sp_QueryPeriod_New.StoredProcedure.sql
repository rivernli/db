USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[ManageReportAnalysis_sp_QueryPeriod_New]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ManageReportAnalysis_sp_QueryPeriod_New]
AS
BEGIN

	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT Period from dbo.ManageReportAnalysis_Fixed_Period order by id asc
END


GO
