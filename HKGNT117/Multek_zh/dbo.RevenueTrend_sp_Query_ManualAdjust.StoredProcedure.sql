USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[RevenueTrend_sp_Query_ManualAdjust]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[RevenueTrend_sp_Query_ManualAdjust] 
	@Plant varchar(50),
	@FiscalYear varchar(50)
AS
BEGIN	

/* *以前做的版本*
	select 
(
	SELECT ISNULL(SUM(ISNULL(Revenue,0)),0)
				FROM vw_RevenueTrend_RevenueAdjust
				where Period='Apr(P1)' AND Plant=@Plant AND FiscalYear=@FiscalYear
) AS M1,
(
	SELECT ISNULL(SUM(ISNULL(Revenue,0)),0)
				FROM vw_RevenueTrend_RevenueAdjust
				where Period='May(P2)' AND Plant=@Plant AND FiscalYear=@FiscalYear
) AS M2,
(
	SELECT ISNULL(SUM(ISNULL(Revenue,0)),0)
				FROM vw_RevenueTrend_RevenueAdjust
				where Period='Jun(P3)' AND Plant=@Plant AND FiscalYear=@FiscalYear
) AS M3,
(
	SELECT ISNULL(SUM(ISNULL(Revenue,0)),0)
				FROM vw_RevenueTrend_RevenueAdjust
				where Period='Jul(P4)' AND Plant=@Plant AND FiscalYear=@FiscalYear
) AS M4,
(
	SELECT ISNULL(SUM(ISNULL(Revenue,0)),0)
				FROM vw_RevenueTrend_RevenueAdjust
				where Period='Aug(P5)' AND Plant=@Plant AND FiscalYear=@FiscalYear
) AS M5,
(
	SELECT ISNULL(SUM(ISNULL(Revenue,0)),0)
				FROM vw_RevenueTrend_RevenueAdjust
				where Period='Sep(P6)' AND Plant=@Plant AND FiscalYear=@FiscalYear
) AS M6,
(
	SELECT ISNULL(SUM(ISNULL(Revenue,0)),0)
				FROM vw_RevenueTrend_RevenueAdjust
				where Period='Oct(P7)' AND Plant=@Plant AND FiscalYear=@FiscalYear
) AS M7,
(
	SELECT ISNULL(SUM(ISNULL(Revenue,0)),0)
				FROM vw_RevenueTrend_RevenueAdjust
				where Period='Nov(P8)' AND Plant=@Plant AND FiscalYear=@FiscalYear
) AS M8,
(
	SELECT ISNULL(SUM(ISNULL(Revenue,0)),0)
				FROM vw_RevenueTrend_RevenueAdjust
				where Period='Dec(P9)' AND Plant=@Plant AND FiscalYear=@FiscalYear
) AS M9,
 (
	SELECT ISNULL(SUM(ISNULL(Revenue,0)),0)
				FROM vw_RevenueTrend_RevenueAdjust
				where Period='Jan(P10)' AND Plant=@Plant AND FiscalYear=@FiscalYear
) AS M10,
(
	SELECT ISNULL(SUM(ISNULL(Revenue,0)),0)
				FROM vw_RevenueTrend_RevenueAdjust
				where Period='Feb(P11)' AND Plant=@Plant AND FiscalYear=@FiscalYear
) AS M11,
(
	SELECT ISNULL(SUM(ISNULL(Revenue,0)),0)
				FROM vw_RevenueTrend_RevenueAdjust
				where Period='Mar(P12)' AND Plant=@Plant AND FiscalYear=@FiscalYear
) AS M12
 */


select 
(
	SELECT ISNULL(SUM(ISNULL(Manual_Local+Manual_Oversea+ScrapSales_Local+ScrapSales_Oversea+ScrapSales_in_Local+ScrapSales_in_Oversea,0)),0)
				FROM RevenueTrend_RevenueAdjust
				where Period='Apr(P1)' AND Plant=@Plant AND FiscalYear=@FiscalYear
) AS M1,
(
	SELECT ISNULL(SUM(ISNULL(Manual_Local+Manual_Oversea+ScrapSales_Local+ScrapSales_Oversea+ScrapSales_in_Local+ScrapSales_in_Oversea,0)),0)
				FROM RevenueTrend_RevenueAdjust
				where Period='May(P2)' AND Plant=@Plant AND FiscalYear=@FiscalYear
) AS M2,
(
	SELECT ISNULL(SUM(ISNULL(Manual_Local+Manual_Oversea+ScrapSales_Local+ScrapSales_Oversea+ScrapSales_in_Local+ScrapSales_in_Oversea,0)),0)
				FROM RevenueTrend_RevenueAdjust
				where Period='Jun(P3)' AND Plant=@Plant AND FiscalYear=@FiscalYear
) AS M3,
(
	SELECT ISNULL(SUM(ISNULL(Manual_Local+Manual_Oversea+ScrapSales_Local+ScrapSales_Oversea+ScrapSales_in_Local+ScrapSales_in_Oversea,0)),0)
				FROM RevenueTrend_RevenueAdjust
				where Period='Jul(P4)' AND Plant=@Plant AND FiscalYear=@FiscalYear
) AS M4,
(
	SELECT ISNULL(SUM(ISNULL(Manual_Local+Manual_Oversea+ScrapSales_Local+ScrapSales_Oversea+ScrapSales_in_Local+ScrapSales_in_Oversea,0)),0)
				FROM RevenueTrend_RevenueAdjust
				where Period='Aug(P5)' AND Plant=@Plant AND FiscalYear=@FiscalYear
) AS M5,
(
	SELECT ISNULL(SUM(ISNULL(Manual_Local+Manual_Oversea+ScrapSales_Local+ScrapSales_Oversea+ScrapSales_in_Local+ScrapSales_in_Oversea,0)),0)
				FROM RevenueTrend_RevenueAdjust
				where Period='Sep(P6)' AND Plant=@Plant AND FiscalYear=@FiscalYear
) AS M6,
(
	SELECT ISNULL(SUM(ISNULL(Manual_Local+Manual_Oversea+ScrapSales_Local+ScrapSales_Oversea+ScrapSales_in_Local+ScrapSales_in_Oversea,0)),0)
				FROM RevenueTrend_RevenueAdjust
				where Period='Oct(P7)' AND Plant=@Plant AND FiscalYear=@FiscalYear
) AS M7,
(
	SELECT ISNULL(SUM(ISNULL(Manual_Local+Manual_Oversea+ScrapSales_Local+ScrapSales_Oversea+ScrapSales_in_Local+ScrapSales_in_Oversea,0)),0)
				FROM RevenueTrend_RevenueAdjust
				where Period='Nov(P8)' AND Plant=@Plant AND FiscalYear=@FiscalYear
) AS M8,
(
	SELECT ISNULL(SUM(ISNULL(Manual_Local+Manual_Oversea+ScrapSales_Local+ScrapSales_Oversea+ScrapSales_in_Local+ScrapSales_in_Oversea,0)),0)
				FROM RevenueTrend_RevenueAdjust
				where Period='Dec(P9)' AND Plant=@Plant AND FiscalYear=@FiscalYear
) AS M9,
 (
	SELECT ISNULL(SUM(ISNULL(Manual_Local+Manual_Oversea,0)),0)
				FROM RevenueTrend_RevenueAdjust
				where Period='Jan(P10)' AND Plant=@Plant AND FiscalYear=@FiscalYear
) AS M10,
(
	SELECT ISNULL(SUM(ISNULL(Manual_Local+Manual_Oversea+ScrapSales_Local+ScrapSales_Oversea+ScrapSales_in_Local+ScrapSales_in_Oversea,0)),0)
				FROM RevenueTrend_RevenueAdjust
				where Period='Feb(P11)' AND Plant=@Plant AND FiscalYear=@FiscalYear
) AS M11,
(
	SELECT ISNULL(SUM(ISNULL(Manual_Local+Manual_Oversea+ScrapSales_Local+ScrapSales_Oversea+ScrapSales_in_Local+ScrapSales_in_Oversea,0)),0)
				FROM RevenueTrend_RevenueAdjust
				where Period='Mar(P12)' AND Plant=@Plant AND FiscalYear=@FiscalYear
) AS M12

END







GO
