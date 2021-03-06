USE [Multek_ZH]
GO
/****** Object:  View [dbo].[v_Scrap_Sales_Details_bk_2012-09-25]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE View [dbo].[v_Scrap_Sales_Details_bk_2012-09-25]
AS
SELECT (SELECT TOP 1 FiscalYearDesc FROM DataWarehouse.dbo.DW_DIM_Calender WHERE FiscalYear = A.T$YEAR) AS FiscalYearDesc,
			A.T$PRNO,
			A.T$PLNT,
			CASE A.T$LOCA WHEN 1 THEN 'Zhuhai' WHEN 2 THEN 'HK' END AS T$LOCA,
			C.T$ITEM,
			C.T$DSCA,
		cast(B.T$AMND as decimal(18,2)) as T$AMNT
FROM FactoryLoading.dbo.TFSSLS023180 AS A
LEFT JOIN FactoryLoading.dbo.TFSSLS024180 AS B ON A.T$ORNO = B.T$ORNO
LEFT JOIN FactoryLoading.dbo.TFSSLS021180 AS C ON B.T$ITEM = C.T$ITEM
WHERE A.T$STAT = 4



GO
