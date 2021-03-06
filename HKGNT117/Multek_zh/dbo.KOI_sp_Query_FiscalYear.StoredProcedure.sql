USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[KOI_sp_Query_FiscalYear]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[KOI_sp_Query_FiscalYear]
as
SELECT  TOP 5 FiscalYear + 1 AS FiscalYear,FiscalYearDesc 
	From DataWarehouse.dbo.DW_DIM_Calender
	WHERE calenderDate<=CONVERT(VARCHAR(10),GETDATE()-1,120)
	GROUP BY FiscalYear,FiscalYearDesc
	ORDER BY FiscalYear DESC 
GO
