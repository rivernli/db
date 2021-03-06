USE [Multek_ZH]
GO
/****** Object:  View [dbo].[v_CACT_TFSBOM519180]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[v_CACT_TFSBOM519180]
AS
	SELECT CASE WHEN T$PLNT = 'P2' THEN 'B1' WHEN T$PLNT = '2F' THEN 'B2F' ELSE RTRIM(LTRIM(T$PLNT)) END AS T$PLNT, 
		T$FYER, T$PRNO, T$QBOM, T$QTKS, T$QCPK, T$QELC, T$QACT, T$CFFI, T$CFFB, RTRIM(FiscalYearDesc) FiscalYearDesc, RTRIM(FiscalPeriodDesc) FiscalPeriodDesc
	FROM TFSBOM519180 T1 LEFT JOIN (SELECT FiscalYear,Fiscalperiod,FiscalYearDesc,FiscalPeriodDesc FROM DataWarehouse.dbo.DW_DIM_Calender GROUP BY FiscalYear,Fiscalperiod,FiscalYearDesc,FiscalPeriodDesc) T2 ON T2.FiscalYear = T1.T$FYER AND T2.Fiscalperiod = T1.T$PRNO


GO
