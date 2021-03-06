USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[VI_Report_sp_Query_PToday]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[VI_Report_sp_Query_PToday] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT CONVERT(CHAR(4),GETDATE(),120) AS CalendarYear,
		   LEFT(DATENAME(MONTH,GETDATE()),3) AS CalendarMonth,
		   (SELECT FiscalYear FROM DataWarehouse.dbo.DW_DIM_Calender WHERE CalenderDate=CONVERT(VARCHAR(10),GETDATE(),120)) AS FiscalYear,
		   (SELECT (CASE FiscalPeriod WHEN 1 THEN 'Jan' WHEN 2 THEN 'Feb' WHEN 3 THEN 'Mar' WHEN 4 THEN 'Apr' WHEN 5 THEN 'May' WHEN 6 THEN 'Jun' WHEN 7 THEN 'Jul' WHEN 8 THEN 'Aug' WHEN 9 THEN 'Sep' WHEN 10 THEN 'Oct' WHEN 11 THEN 'Nov' WHEN 12 THEN 'Dec' END) FROM DataWarehouse.dbo.DW_DIM_Calender WHERE CalenderDate=CONVERT(VARCHAR(10),GETDATE(),120)) AS FiscalPeriod,
		   (SELECT (CASE FiscalQuarter WHEN 1 THEN 'Quarter1' WHEN 2 THEN 'Quarter2' WHEN 3 THEN 'Quarter3' WHEN 4 THEN 'Quarter4' END) FROM DataWarehouse.dbo.DW_DIM_Calender WHERE CalenderDate=CONVERT(VARCHAR(10),GETDATE(),120)) AS FiscalQuarter,
		   (SELECT FiscalPeriod FROM DataWarehouse.dbo.DW_DIM_Calender WHERE CalenderDate=CONVERT(VARCHAR(10),GETDATE(),120)) AS FiscalPeriodNo,
		   (SELECT FiscalWeek FROM DataWarehouse.dbo.DW_DIM_Calender WHERE CalenderDate=CONVERT(VARCHAR(10),GETDATE(),120)) AS FiscalWeek
			
END
GO
