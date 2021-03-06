USE [Multek_ZH]
GO
/****** Object:  View [dbo].[vw_RevenueTrend_RevenueAdjust]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vw_RevenueTrend_RevenueAdjust]
as
SELECT FiscalYear,Period, Plant=attribute, Revenue=value
FROM RevenueTrend_RevenueAdjust
  UNPIVOT
  (
    value FOR attribute IN([B1], [B2F], [B3], [B4], [B5], [vvi])
  ) AS UPV
GO
