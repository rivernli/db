USE [Multek_ZH]
GO
/****** Object:  View [dbo].[v_scrap_sales_items_no_use]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[v_scrap_sales_items_no_use]
as

SELECT convert(varchar(8),t$sdat,112) as iDate,
 dbo.fx_getFiscalYearAndPeriod(D.FiscalYear+1, d.FiscalPeriod) AS iPeriod,
 D.FiscalYear+1 as FYear,
 A.T$PRNO as period, A.T$PLNT as plant,

 CASE A.T$LOCA WHEN 1 THEN 'Zhuhai' WHEN 2 THEN 'HK' END AS locastion, C.t$DSCA as description, CAST(B.T$AMNT AS decimal(18, 2)) 
                      AS amount
FROM         FactoryLoading.dbo.TFSSLS023180 AS A LEFT OUTER JOIN
                      FactoryLoading.dbo.TFSSLS024180 AS B ON A.T$ORNO = B.T$ORNO LEFT OUTER JOIN
                      FactoryLoading.dbo.TFSSLS021180 AS C ON B.T$ITEM = C.T$ITEM LEFT OUTER JOIN
                      DataWarehouse.dbo.DW_DIM_Calender AS D ON D.calenderDate = A.t$sdat
WHERE     (A.T$STAT = 4)
and 
 dbo.fx_getFiscalYearAndPeriod(D.FiscalYear+1, d.FiscalPeriod) >= 201208
GO
