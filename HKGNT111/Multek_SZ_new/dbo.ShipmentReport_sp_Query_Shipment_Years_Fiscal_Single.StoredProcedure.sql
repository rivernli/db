USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[ShipmentReport_sp_Query_Shipment_Years_Fiscal_Single]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name
-- Create date: <Create Date,,
-- Description:	<Description,,
-- =============================================
CREATE PROCEDURE [dbo].[ShipmentReport_sp_Query_Shipment_Years_Fiscal_Single] 
	@Year INT
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
		SELECT 1 AS AutoID,'Q1' AS PQ,
			   (
					SELECT MIN(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM Calendar b WHERE RIGHT(b.FiscalYearDesc,4)=@Year AND b.FiscalQuarter=1
			   ) + ' - '	+
			   (
					SELECT MAX(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM Calendar b WHERE RIGHT(b.FiscalYearDesc,4)=@Year AND b.FiscalQuarter=1
			   ) AS DataRange
		UNION
		SELECT 2 AS AutoID,'Q2' AS PQ,
			   (
					SELECT MIN(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM Calendar b WHERE RIGHT(b.FiscalYearDesc,4)=@Year AND b.FiscalQuarter=2
			   ) + ' - '	+
			   (
					SELECT MAX(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM Calendar b WHERE RIGHT(b.FiscalYearDesc,4)=@Year AND b.FiscalQuarter=2
			   ) AS DataRange
		UNION
		SELECT 3 AS AutoID,'Q3' AS PQ,
			   (
					SELECT MIN(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM Calendar b WHERE RIGHT(b.FiscalYearDesc,4)=@Year AND b.FiscalQuarter=3
			   ) + ' - '	+
			   (
					SELECT MAX(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM Calendar b WHERE RIGHT(b.FiscalYearDesc,4)=@Year AND b.FiscalQuarter=3
			   ) AS DataRange
		UNION
		SELECT 4 AS AutoID,'Q4' AS PQ,
			   (
					SELECT MIN(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM Calendar b WHERE RIGHT(b.FiscalYearDesc,4)=@Year AND b.FiscalQuarter=4
			   ) + ' - '	+
			   (
					SELECT MAX(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM Calendar b WHERE RIGHT(b.FiscalYearDesc,4)=@Year AND b.FiscalQuarter=4
			   ) AS DataRange
		UNION
		SELECT 5 AS AutoID,'P1' AS PQ,
			   (
					SELECT MIN(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM Calendar b WHERE RIGHT(b.FiscalYearDesc,4)=@Year AND b.FiscalPeriod=1
			   ) + ' - '	+
			   (
					SELECT MAX(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM Calendar b WHERE RIGHT(b.FiscalYearDesc,4)=@Year AND b.FiscalPeriod=1
			   ) AS DataRange
		UNION
		SELECT 6 AS AutoID,'P2' AS PQ,
			   (
					SELECT MIN(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM Calendar b WHERE RIGHT(b.FiscalYearDesc,4)=@Year AND b.FiscalPeriod=2
			   ) + ' - '	+
			   (
					SELECT MAX(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM Calendar b WHERE RIGHT(b.FiscalYearDesc,4)=@Year AND b.FiscalPeriod=2
			   ) AS DataRange
		UNION
		SELECT 7 AS AutoID,'P3' AS PQ,
			   (
					SELECT MIN(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM Calendar b WHERE RIGHT(b.FiscalYearDesc,4)=@Year AND b.FiscalPeriod=3
			   ) + ' - '	+
			   (
					SELECT MAX(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM Calendar b WHERE RIGHT(b.FiscalYearDesc,4)=@Year AND b.FiscalPeriod=3
			   ) AS DataRange
		UNION
		SELECT 8 AS AutoID,'P4' AS PQ,
			   (
					SELECT MIN(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM Calendar b WHERE RIGHT(b.FiscalYearDesc,4)=@Year AND b.FiscalPeriod=4
			   ) + ' - '	+
			   (
					SELECT MAX(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM Calendar b WHERE RIGHT(b.FiscalYearDesc,4)=@Year AND b.FiscalPeriod=4
			   ) AS DataRange
		UNION
		SELECT 9 AS AutoID,'P5' AS PQ,
			   (
					SELECT MIN(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM Calendar b WHERE RIGHT(b.FiscalYearDesc,4)=@Year AND b.FiscalPeriod=5
			   ) + ' - '	+
			   (
					SELECT MAX(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM Calendar b WHERE RIGHT(b.FiscalYearDesc,4)=@Year AND b.FiscalPeriod=5
			   ) AS DataRange
		UNION
		SELECT 10 AS AutoID,'P6' AS PQ,
			   (
					SELECT MIN(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM Calendar b WHERE RIGHT(b.FiscalYearDesc,4)=@Year AND b.FiscalPeriod=6
			   ) + ' - '	+
			   (
					SELECT MAX(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM Calendar b WHERE RIGHT(b.FiscalYearDesc,4)=@Year AND b.FiscalPeriod=6
			   ) AS DataRange
		UNION
		SELECT 11 AS AutoID,'P7' AS PQ,
			   (
					SELECT MIN(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM Calendar b WHERE RIGHT(b.FiscalYearDesc,4)=@Year AND b.FiscalPeriod=7
			   ) + ' - '	+
			   (
					SELECT MAX(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM Calendar b WHERE RIGHT(b.FiscalYearDesc,4)=@Year AND b.FiscalPeriod=7
			   ) AS DataRange
		UNION
		SELECT 12 AS AutoID,'P8' AS PQ,
			   (
					SELECT MIN(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM Calendar b WHERE RIGHT(b.FiscalYearDesc,4)=@Year AND b.FiscalPeriod=8
			   ) + ' - '	+
			   (
					SELECT MAX(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM Calendar b WHERE RIGHT(b.FiscalYearDesc,4)=@Year AND b.FiscalPeriod=8
			   ) AS DataRange
		UNION
		SELECT 13 AS AutoID,'P9' AS PQ,
			   (
					SELECT MIN(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM Calendar b WHERE RIGHT(b.FiscalYearDesc,4)=@Year AND b.FiscalPeriod=9
			   ) + ' - '	+
			   (
					SELECT MAX(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM Calendar b WHERE RIGHT(b.FiscalYearDesc,4)=@Year AND b.FiscalPeriod=9
			   ) AS DataRange
		UNION
		SELECT 14 AS AutoID,'P10' AS PQ,
			   (
					SELECT MIN(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM Calendar b WHERE RIGHT(b.FiscalYearDesc,4)=@Year AND b.FiscalPeriod=10
			   ) + ' - '	+
			   (
					SELECT MAX(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM Calendar b WHERE RIGHT(b.FiscalYearDesc,4)=@Year AND b.FiscalPeriod=10
			   ) AS DataRange
		UNION
		SELECT 15 AS AutoID,'P11' AS PQ,
			   (
					SELECT MIN(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM Calendar b WHERE RIGHT(b.FiscalYearDesc,4)=@Year AND b.FiscalPeriod=11
			   ) + ' - '	+
			   (
					SELECT MAX(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM Calendar b WHERE RIGHT(b.FiscalYearDesc,4)=@Year AND b.FiscalPeriod=11
			   ) AS DataRange
		UNION
		SELECT 16 AS AutoID,'P12' AS PQ,
			   (
					SELECT MIN(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM Calendar b WHERE RIGHT(b.FiscalYearDesc,4)=@Year AND b.FiscalPeriod=12
			   ) + ' - '	+
			   (
					SELECT MAX(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM Calendar b WHERE RIGHT(b.FiscalYearDesc,4)=@Year AND b.FiscalPeriod=12
			   ) AS DataRange
END
GO
