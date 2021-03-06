USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[sp_Query_Fiscal_Week_by_Fiscal_Year]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Query_Fiscal_Week_by_Fiscal_Year]
	-- Add the parameters for the stored procedure here
	@FiscalYear INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT a.FiscalYear,a.FiscalWeek ,
		'W'+(CASE WHEN a.FiscalWeek<10 THEN '0' ELSE '' END)+CONVERT(VARCHAR(2),a.FiscalWeek)+'FY'+RIGHT(CONVERT(VARCHAR(4),a.FiscalYear),2) AS WeekDesc,
		(SELECT TOP 1 CONVERT(VARCHAR(10),b.FiscalWeekFrom,120)+' -> '+CONVERT(VARCHAR(10),b.FiscalWeekTo,120) FROM Calendar b WHERE b.FiscalYear=a.FiscalYear AND b.FiscalWeek=a.FiscalWeek)  AS WeekRange
	FROM Calendar a
	WHERE a.FiscalYear=@FiscalYear
	GROUP BY a.FiscalYear,a.FiscalWeek

END
GO
