USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_MRBST_Sycn_Weekly_V2]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_MRBST_Sycn_Weekly_V2]
AS
	TRUNCATE TABLE [MRBST_Weekly_V2]

	DECLARE @EndDate datetime
	SET @EndDate = DATEADD(wk, DATEDIFF(wk,0,GETDATE()), 4)
	IF DATEDIFF(DD,GETDATE(),@EndDate) >= 0
		SET @EndDate = DATEADD(wk, -1, @EndDate)

	INSERT INTO [MRBST_Weekly_V2]
           ([Plant],[Defect],[Process],[MRBCost],[MRBSqft],
			[FgInCost],[FgInSqft],[FgInSqftRigid],[FgInSqftRigidL],[CalenderDateMax],[CalenderDateMin],
			[CalenderYear],[CalenderMonthDesc],[CalenderQuarterDesc],[CalenderWeekDesc],
			[FiscalYearDesc],[FiscalQuarterDesc],[FiscalPeriodDesc],[FiscalWeekDesc],[RWeek])
		
		SELECT REPLACE(T$PLNT, '2F', 'B2F') AS T$PLNT, T$MDSC, T$PROC, 
			SUM(T$MCOS) AS T$MCOS, SUM(T$MSQF) AS T$MSQF, 
			SUM(T$ICOS) AS T$ICOS, SUM(T$QSQF) AS T$QSQF,
			SUM(FgInSqftRigid) AS FgInSqftRigid, SUM(FgInSqftRigidL) AS FgInSqftRigidL,
			MAX(T$DATE) AS MAXDATE, MIN(T$DATE) AS MINDATE, CalenderYear, 
			CalenderMonthDesc, CalenderQuarterDesc, CalenderWeekDesc, 
			FiscalYearDesc, FiscalQuarterDesc, 
			FiscalPeriodDesc, FiscalWeekDesc,RWeek
			FROM (
				SELECT RTRIM(LTRIM(T$PLNT)) AS T$PLNT, 
					RTRIM(LTRIM(T$MDSC)) AS T$MDSC, 
					RTRIM(LTRIM(T$PROC)) AS T$PROC, 
					SUM(T$MCOS*T$LCNT) AS T$MCOS, SUM(T$MSQF*T$LCNT) T$MSQF, 
					SUM(T$ICOS*T$LCNT) AS T$ICOS, SUM(T$QSQF*T$LCNT) T$QSQF, 
					SUM(CASE WHEN ASCII(LEFT(T$ITEM,1)) > 47 AND ASCII(LEFT(T$ITEM,1)) < 58 THEN 0 ELSE T$QSQF*T$LCNT END) FgInSqftRigid,
					SUM(CASE WHEN ASCII(LEFT(T$ITEM,1)) > 47 AND ASCII(LEFT(T$ITEM,1)) < 58 THEN 0 ELSE T$QSQF*T$LCNT*CAST(SUBSTRING(T$ITEM, 2, 2) AS INT) END) FgInSqftRigidL,T$DATE,
					CASE WHEN T$DATE > @EndDate THEN -1 ELSE DATEDIFF(d, T$DATE, @EndDate) / 7 END AS RWeek
					FROM TFSOLP128180
				GROUP BY T$PLNT, T$MDSC, T$PROC, T$DATE
			 ) AS T1
		LEFT JOIN VW_Calender_MRBST T2 ON T1.T$DATE = T2.CalenderDate 
		GROUP BY T$PLNT, T$MDSC, T$PROC, RWeek,
		calenderYear, CalenderQuarterDesc, CalenderMonthDesc,
		CalenderWeekDesc, FiscalYearDesc, FiscalQuarterDesc, 
		FiscalPeriodDesc, FiscalWeekDesc



GO
