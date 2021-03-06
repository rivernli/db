USE [Multek_ZH_New]
GO
/****** Object:  StoredProcedure [dbo].[sp_MRBST_Sycn_Weekly_V1]    Script Date: 11/06/2014 15:50:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_MRBST_Sycn_Weekly_V1]
AS
	TRUNCATE TABLE [MRBST_Weekly_V1]

	DECLARE @EndDate datetime
	SET @EndDate = DATEADD(wk, DATEDIFF(wk,0,GETDATE()), 4)
	IF DATEDIFF(DD,GETDATE(),@EndDate) >= 0
		SET @EndDate = DATEADD(wk, -1, @EndDate)

	INSERT INTO [MRBST_Weekly_V1]
           ([Plant],[Customer],[OEM],[Technology],[MRBCost],[MRBSqft],
			[FgInCost],[FgInSqft],[FgInSqftRigid],[FgInSqftRigidL],[FgOutCost],[CalenderDateMax],[CalenderDateMin],
			[CalenderYear],[CalenderMonthDesc],[CalenderQuarterDesc],[CalenderWeekDesc],
			[FiscalYearDesc],[FiscalQuarterDesc],[FiscalPeriodDesc],[FiscalWeekDesc],[RWeek])
		
		SELECT REPLACE(T$PLNT, '2F', 'B2F') AS T$PLNT, T$CUST, T$OEMN, T$TECH, 
			SUM(T$MCOS) AS T$MCOS, SUM(T$MSQF) AS T$MSQF, 
			SUM(T$ICOS) AS T$ICOS, SUM(T$QSQF) AS T$QSQF,
			SUM(FgInSqftRigid) AS FgInSqftRigid, SUM(FgInSqftRigidL) AS FgInSqftRigidL,
			SUM(T$AMNT) AS T$AMNT, MAX(T$DATE) AS MAXDATE, MIN(T$DATE) AS MINDATE, CalenderYear, 
			CalenderMonthDesc, CalenderQuarterDesc, CalenderWeekDesc, 
			FiscalYearDesc, FiscalQuarterDesc, 
			FiscalPeriodDesc, FiscalWeekDesc,RWeek
			FROM (
				SELECT * FROM 
					(SELECT RTRIM(LTRIM(T$PLNT)) AS T$PLNT, 
						RTRIM(LTRIM(T$CUST)) AS T$CUST, 
						RTRIM(LTRIM(T$OEMN)) AS T$OEMN, 
						RTRIM(LTRIM(T$TECH)) AS T$TECH,
						RTRIM(LTRIM(T$ITEM)) AS T$ITEM,
						SUM(T$MCOS*T$LCNT) AS T$MCOS, SUM(T$MSQF*T$LCNT) T$MSQF, 
						SUM(T$ICOS*T$LCNT) AS T$ICOS, SUM(T$QSQF*T$LCNT) T$QSQF, 
						SUM(CASE WHEN ASCII(LEFT(T$ITEM,1)) > 47 AND ASCII(LEFT(T$ITEM,1)) < 58 THEN 0 ELSE T$QSQF*T$LCNT END) FgInSqftRigid,
					SUM(CASE WHEN ASCII(LEFT(T$ITEM,1)) > 47 AND ASCII(LEFT(T$ITEM,1)) < 58 THEN 0 ELSE T$QSQF*T$LCNT*CAST(SUBSTRING(T$ITEM, 2, 2) AS INT) END) FgInSqftRigidL,T$DATE,
						CASE WHEN T$DATE > @EndDate THEN -1 ELSE DATEDIFF(d, T$DATE, @EndDate) / 7 END AS RWeek, 0 AS T$AMNT
						FROM TFSOLP128180
					GROUP BY T$PLNT, T$CUST, T$OEMN, T$TECH, T$DATE, T$ITEM
					) AS TN1
					UNION ALL
				SELECT * FROM 
					(SELECT CASE WHEN T$PLNT = 'P2' THEN 'B1' ELSE RTRIM(LTRIM(T$PLNT)) END AS T$PLNT, 
							'' AS T$CUST,
							RTRIM(LTRIM(T$CSGS)) AS T$OEMN, 
							(SELECT TOP 1 RTRIM(LTRIM(T$ASTR)) FROM Multek_SZ_New.dbo.TFIATT006180 t02 WHERE t01.T$ITEM = t02.T$ITEM AND t02.T$ATTR = 'type') AS T$TECH,
							RTRIM(LTRIM(T$ITEM)) AS T$ITEM,
							0 AS T$MCOS,0 AS T$MSQF,0 AS T$ICOS,0 AS T$QSQF,
							0 AS FgInSqftRigid,
							0 AS FgInSqftRigidL,T$DATE,
						CASE WHEN T$DATE > @EndDate THEN -1 ELSE DATEDIFF(d, T$DATE, @EndDate) / 7 END AS RWeek,				
							SUM(T$AMNT) AS T$AMNT
							FROM Multek_SZ_New.dbo.TFSOLP106180 t01 WHERE T$PLNT <> '' AND T$PLNT <> 'HK'
						GROUP BY T$PLNT, T$CSGS, T$DATE, T$ITEM) AS TN2
					--LEFT JOIN 
					--(
					--	SELECT RTRIM(LTRIM(T$PLNT)) AS T$PLNT, 
					--		RTRIM(LTRIM(T$DACA)) AS T$CUST, 
					--		RTRIM(LTRIM(T$ITEM)) AS T$ITEM,
					--		SUM(T$AMNT) AS T$AMNT, 
					--		T$DATE FROM Multek_SZ_New.dbo.TFSOLP106180
					--	GROUP BY T$PLNT, T$DACA, T$DATE, T$ITEM
					--) AS TN2
					--ON TN1.T$PLNT = TN2.T$PLNT 
					--	AND TN1.T$CUST = TN2.T$CUST 
					--	AND TN1.T$DATE = TN2.T$DATE 
					--	AND TN1.T$ITEM = TN2.T$ITEM
			 ) AS T1
		LEFT JOIN MRBST_Calender T2 ON T1.T$DATE = T2.CalenderDate 
		GROUP BY 
		T$PLNT, T$CUST, T$OEMN, T$TECH, RWeek,
		calenderYear, CalenderQuarterDesc, CalenderMonthDesc,
		CalenderWeekDesc, FiscalYearDesc, FiscalQuarterDesc, 
		FiscalPeriodDesc, FiscalWeekDesc
GO
