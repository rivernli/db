USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[SalesAnalysis_sp_Query_PToday]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SalesAnalysis_sp_Query_PToday] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT CONVERT(CHAR(4),GETDATE(),120) AS CalendarYear,
		   LEFT(DATENAME(MONTH,GETDATE()),3) AS CalendarMonth,
		   (SELECT FiscalYear FROM Calendar WHERE CalenderDate=CONVERT(VARCHAR(10),GETDATE(),120)) AS FiscalYear,
		   (SELECT (CASE FiscalPeriod WHEN 1 THEN 'Apr(P1)' WHEN 2 THEN 'May(P2)' WHEN 3 THEN 'Jun(P3)' WHEN 4 THEN 'Jul(P4)' WHEN 5 THEN 'Aug(P5)' WHEN 6 THEN 'Sep(P6)' WHEN 7 THEN 'Oct(P7)' WHEN 8 THEN 'Nov(P8)' WHEN 9 THEN 'Dec(P9)' WHEN 10 THEN 'Jan(P10)' WHEN 11 THEN 'Feb(P11)' WHEN 12 THEN 'Mar(P12)' END) FROM Calendar WHERE CalenderDate=CONVERT(VARCHAR(10),GETDATE(),120)) AS FiscalPeriod,
		   (SELECT (CASE FiscalQuarter WHEN 1 THEN 'Quarter1' WHEN 2 THEN 'Quarter2' WHEN 3 THEN 'Quarter3' WHEN 4 THEN 'Quarter4' END) FROM Calendar WHERE CalenderDate=CONVERT(VARCHAR(10),GETDATE(),120)) AS FiscalQuarter,
		   (SELECT FiscalPeriod FROM Calendar WHERE CalenderDate=CONVERT(VARCHAR(10),GETDATE(),120)) AS FiscalPeriodNo

			
END
GO
