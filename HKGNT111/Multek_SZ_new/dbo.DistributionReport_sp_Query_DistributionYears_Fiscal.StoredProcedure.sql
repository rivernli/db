USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[DistributionReport_sp_Query_DistributionYears_Fiscal]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DistributionReport_sp_Query_DistributionYears_Fiscal] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
		SELECT RIGHT(a.FiscalYearDesc,4) AS FiscalYear,
			   (
					SELECT MIN(CONVERT(VARCHAR(10),b.CalenderDate,120)) From Calendar b WHERE b.FiscalYearDesc=a.FiscalYearDesc AND b.FiscalPeriod=1
			   ) + ' -> '	+
			   (
					SELECT MAX(CONVERT(VARCHAR(10),b.CalenderDate,120)) From Calendar b WHERE b.FiscalYearDesc=a.FiscalYearDesc AND b.FiscalPeriod=1
			   ) AS Period1,
			   (
					SELECT MIN(CONVERT(VARCHAR(10),b.CalenderDate,120)) From Calendar b WHERE b.FiscalYearDesc=a.FiscalYearDesc AND b.FiscalPeriod=2
			   ) + ' -> '	+
			   (
					SELECT MAX(CONVERT(VARCHAR(10),b.CalenderDate,120)) From Calendar b WHERE b.FiscalYearDesc=a.FiscalYearDesc AND b.FiscalPeriod=2
			   ) AS Period2,
			   (
					SELECT MIN(CONVERT(VARCHAR(10),b.CalenderDate,120)) From Calendar b WHERE b.FiscalYearDesc=a.FiscalYearDesc AND b.FiscalPeriod=3
			   ) + ' -> '	+
			   (
					SELECT MAX(CONVERT(VARCHAR(10),b.CalenderDate,120)) From Calendar b WHERE b.FiscalYearDesc=a.FiscalYearDesc AND b.FiscalPeriod=3
			   ) AS Period3,
			   (
					SELECT MIN(CONVERT(VARCHAR(10),b.CalenderDate,120)) From Calendar b WHERE b.FiscalYearDesc=a.FiscalYearDesc AND b.FiscalPeriod=4
			   ) + ' -> '	+
			   (
					SELECT MAX(CONVERT(VARCHAR(10),b.CalenderDate,120)) From Calendar b WHERE b.FiscalYearDesc=a.FiscalYearDesc AND b.FiscalPeriod=4
			   ) AS Period4,
			   (
					SELECT MIN(CONVERT(VARCHAR(10),b.CalenderDate,120)) From Calendar b WHERE b.FiscalYearDesc=a.FiscalYearDesc AND b.FiscalPeriod=5
			   ) + ' -> '	+
			   (
					SELECT MAX(CONVERT(VARCHAR(10),b.CalenderDate,120)) From Calendar b WHERE b.FiscalYearDesc=a.FiscalYearDesc AND b.FiscalPeriod=5
			   ) AS Period5,
			   (
					SELECT MIN(CONVERT(VARCHAR(10),b.CalenderDate,120)) From Calendar b WHERE b.FiscalYearDesc=a.FiscalYearDesc AND b.FiscalPeriod=6
			   ) + ' -> '	+
			   (
					SELECT MAX(CONVERT(VARCHAR(10),b.CalenderDate,120)) From Calendar b WHERE b.FiscalYearDesc=a.FiscalYearDesc AND b.FiscalPeriod=6
			   ) AS Period6,
			   (
					SELECT MIN(CONVERT(VARCHAR(10),b.CalenderDate,120)) From Calendar b WHERE b.FiscalYearDesc=a.FiscalYearDesc AND b.FiscalPeriod=7
			   ) + ' -> '	+
			   (
					SELECT MAX(CONVERT(VARCHAR(10),b.CalenderDate,120)) From Calendar b WHERE b.FiscalYearDesc=a.FiscalYearDesc AND b.FiscalPeriod=7
			   ) AS Period7,
			   (
					SELECT MIN(CONVERT(VARCHAR(10),b.CalenderDate,120)) From Calendar b WHERE b.FiscalYearDesc=a.FiscalYearDesc AND b.FiscalPeriod=8
			   ) + ' -> '	+
			   (
					SELECT MAX(CONVERT(VARCHAR(10),b.CalenderDate,120)) From Calendar b WHERE b.FiscalYearDesc=a.FiscalYearDesc AND b.FiscalPeriod=8
			   ) AS Period8,
			   (
					SELECT MIN(CONVERT(VARCHAR(10),b.CalenderDate,120)) From Calendar b WHERE b.FiscalYearDesc=a.FiscalYearDesc AND b.FiscalPeriod=9
			   ) + ' -> '	+
			   (
					SELECT MAX(CONVERT(VARCHAR(10),b.CalenderDate,120)) From Calendar b WHERE b.FiscalYearDesc=a.FiscalYearDesc AND b.FiscalPeriod=9
			   ) AS Period9,
			   (
					SELECT MIN(CONVERT(VARCHAR(10),b.CalenderDate,120)) From Calendar b WHERE b.FiscalYearDesc=a.FiscalYearDesc AND b.FiscalPeriod=10
			   ) + ' -> '	+
			   (
					SELECT MAX(CONVERT(VARCHAR(10),b.CalenderDate,120)) From Calendar b WHERE b.FiscalYearDesc=a.FiscalYearDesc AND b.FiscalPeriod=10
			   ) AS Period10,
			   (
					SELECT MIN(CONVERT(VARCHAR(10),b.CalenderDate,120)) From Calendar b WHERE b.FiscalYearDesc=a.FiscalYearDesc AND b.FiscalPeriod=11
			   ) + ' -> '	+
			   (
					SELECT MAX(CONVERT(VARCHAR(10),b.CalenderDate,120)) From Calendar b WHERE b.FiscalYearDesc=a.FiscalYearDesc AND b.FiscalPeriod=11
			   ) AS Period11,
			   (
					SELECT MIN(CONVERT(VARCHAR(10),b.CalenderDate,120)) From Calendar b WHERE b.FiscalYearDesc=a.FiscalYearDesc AND b.FiscalPeriod=12
			   ) + ' -> '	+
			   (
					SELECT MAX(CONVERT(VARCHAR(10),b.CalenderDate,120)) From Calendar b WHERE b.FiscalYearDesc=a.FiscalYearDesc AND b.FiscalPeriod=12
			   ) AS Period12,
			   (
					SELECT MIN(CONVERT(VARCHAR(10),b.CalenderDate,120)) From Calendar b WHERE b.FiscalYearDesc=a.FiscalYearDesc AND b.FiscalQuarter=1
			   ) + ' -> '	+
			   (
					SELECT MAX(CONVERT(VARCHAR(10),b.CalenderDate,120)) From Calendar b WHERE b.FiscalYearDesc=a.FiscalYearDesc AND b.FiscalQuarter=1
			   ) AS Quarter1,
			   (
					SELECT MIN(CONVERT(VARCHAR(10),b.CalenderDate,120)) From Calendar b WHERE b.FiscalYearDesc=a.FiscalYearDesc AND b.FiscalQuarter=2
			   ) + ' -> '	+
			   (
					SELECT MAX(CONVERT(VARCHAR(10),b.CalenderDate,120)) From Calendar b WHERE b.FiscalYearDesc=a.FiscalYearDesc AND b.FiscalQuarter=2
			   ) AS Quarter2,
			   (
					SELECT MIN(CONVERT(VARCHAR(10),b.CalenderDate,120)) From Calendar b WHERE b.FiscalYearDesc=a.FiscalYearDesc AND b.FiscalQuarter=3
			   ) + ' -> '	+
			   (
					SELECT MAX(CONVERT(VARCHAR(10),b.CalenderDate,120)) From Calendar b WHERE b.FiscalYearDesc=a.FiscalYearDesc AND b.FiscalQuarter=3
			   ) AS Quarter3,
			   (
					SELECT MIN(CONVERT(VARCHAR(10),b.CalenderDate,120)) From Calendar b WHERE b.FiscalYearDesc=a.FiscalYearDesc AND b.FiscalQuarter=4
			   ) + ' -> '	+
			   (
					SELECT MAX(CONVERT(VARCHAR(10),b.CalenderDate,120)) From Calendar b WHERE b.FiscalYearDesc=a.FiscalYearDesc AND b.FiscalQuarter=4
			   ) AS Quarter4
		
		FROM (
				SELECT TOP 5 FiscalYearDesc
				From Calendar
				WHERE LEFT(FiscalYearDesc,2)='FY'
					AND calenderDate<=CONVERT(VARCHAR(10),GETDATE(),120)
				GROUP BY FiscalYearDesc
				ORDER BY FiscalYearDesc DESC
			  ) a
		ORDER BY a.FiscalYear DESC

END
GO
