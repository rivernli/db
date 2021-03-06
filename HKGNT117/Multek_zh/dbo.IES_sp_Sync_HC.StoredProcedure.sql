USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[IES_sp_Sync_HC]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[IES_sp_Sync_HC] 	
AS
	TRUNCATE TABLE IES_ProcessMapMaxtrix
	INSERT INTO IES_ProcessMapMaxtrix(Building, Project, WorkCenter, SubWorkCenter, FlowCount)
		SELECT t1.Building, t2.Project, t1.WorkCenter, t1.SubWorkCenter,
			(SELECT COUNT(*) FROM IES_WorkFlow WHERE Building = t1.Building AND WorkCenter = t1.SubWorkCenter AND Project LIKE t2.Project + '%' ) 
		FROM IES_MCWorkCenter t1,(SELECT DISTINCT Building, Project FROM IES_ByMPSCalc) AS t2
		WHERE t1.Building = t2.Building

	TRUNCATE TABLE IES_WCDMByMPS
	INSERT INTO IES_WCDMByMPS(MPSID, WorkCenter, SqFt)
		SELECT t1.ID, t2.WorkCenter, t1.BacklogSqFt*t2.FlowCount FROM IES_ByMPSCalc t1, 
			(SELECT Building, Project, WorkCenter, SUM(FlowCount) AS FlowCount 
				FROM IES_ProcessMapMaxtrix 
				GROUP BY Building, Project, WorkCenter) t2
			WHERE t1.Building = t2.Building AND t1.Project = t2.Project

	TRUNCATE TABLE IES_WCHCSummary
	INSERT INTO IES_WCHCSummary(MCID, Year, Month, YearWeek, Loading, HC)
	SELECT ID, Year, Month, YearWeek, Loading, CASE WHEN DaysPerWeek = 0 THEN 0 ELSE CEILING((CEILING(NOM*Loading)*NOHMS*NoPerDay*NoPerWeek/DaysPerWeek)*MCCUD) END
	FROM (
		SELECT t1.ID, t3.Year, t3.Month, t3.YearWeek, t1.NOM, t1.NOHMS, t1.NoPerDay, t1.NoPerWeek, t1.DaysPerWeek, t1.MCCUD,
			CASE WHEN t3.Loading > t1.AMR THEN t1.AMR ELSE t3.Loading END Loading
			FROM IES_MCDatabase t1 INNER JOIN IES_ProcessByPlant t2
				ON t1.Building = t2.Building AND t1.Process = t2.Process AND t1.SubProcess = t2.KeyMachine
			INNER JOIN IES_WeeklyLoading t3 ON t2.Building = t2.Building AND t2.ID = t3.PBPID
			WHERE t1.MonitorByIE = 1) AS T

	INSERT INTO IES_WCHCSummary(MCID, Year, Month, YearWeek, Loading, HC)
	SELECT ID, Year, Month, YearWeek, Loading, CASE WHEN DaysPerWeek = 0 THEN 0 ELSE CEILING((CEILING(NOM*Loading)*NOHMS*NoPerDay*NoPerWeek/DaysPerWeek)*MCCUD) END
	FROM (
		SELECT t0.ID, t3.Year, t3.Month, t3.YearWeek, t0.NOM, t0.NOHMS, t0.NoPerDay, t0.NoPerWeek, t0.DaysPerWeek, t0.MCCUD,
			CASE WHEN UPH = 0 OR HrsPerDay = 0 OR NOM = 0 OR t3.WorkingDay = 0 THEN 0 
			ELSE 
				CASE WHEN t3.SqFt/UPH/HrsPerDay/NOM/WorkingDay > t0.AMR THEN t0.AMR
				ELSE t3.SqFt/UPH/HrsPerDay/NOM/WorkingDay END
			END Loading FROM IES_MCDatabase t0,
		(
			SELECT t1.Building, t1.Year, t1.Month, t1.YearWeek, t2.WorkCenter, SUM(t2.SqFt) SqFt, t4.WorkingDay
				FROM IES_ByMPSCalc t1, IES_WCDMByMPS t2, IES_Calendar t4
				WHERE t1.ID = t2.MPSID AND t1.CalendarDate = t4.CalendarDate AND t1.Building = t4.Building
				GROUP BY t1.Building, t1.Year, t1.Month, t1.YearWeek, t2.WorkCenter, t4.WorkingDay
		) AS t3
		WHERE t0.Building = t3.Building AND t0.DMWC = t3.WorkCenter) T

	TRUNCATE TABLE IES_WCHCSummaryTotal
	INSERT INTO IES_WCHCSummaryTotal(Building,Process,KeyMachine,Year,Month,YearWeek,Loading,DataType,HC)
	SELECT t1.Building,t1.Process,t1.HCCalc,t3.Year,t3.Month,t3.YearWeek,t3.Loading,'Supporting',
		CEILING((
			SELECT TotalFixedLabors+(TotalNonFixedLabors*t3.Loading) FROM IES_SupportingHC t4
				WHERE t4.Building = t1.Building AND t4.Process = t4.Process AND t4.HCCalc = t1.HCCalc
		))
		FROM IES_MCDatabase t1, IES_ProcessByPlant t2, IES_WeeklyLoading t3
		WHERE t1.Building = t2.Building AND t1.Process = t2.Process AND t1.HCCalc = t2.KeyMachine
		AND t2.Building = t3.Building AND t2.ID = t3.PBPID

	INSERT INTO IES_WCHCSummaryTotal(Building,Process,KeyMachine,Year,Month,YearWeek,Loading,DataType,HC)
	SELECT Building,Process,'' AS KeyMachine,Year,Month,YearWeek,0 AS Loading, 'Total', SUM(HC)
		FROM (
			SELECT t1.Building,t1.Process,t2.Year,t2.Month,t2.YearWeek, t2.HC 
				FROM IES_MCDatabase t1, IES_WCHCSummary t2 WHERE t1.ID = t2.MCID
			UNION ALL 
			SELECT Building,Process,Year,Month,YearWeek,HC FROM IES_WCHCSummaryTotal WHERE DataType = 'Supporting'
	) T GROUP BY Building,Process,Year,Month,YearWeek

GO
