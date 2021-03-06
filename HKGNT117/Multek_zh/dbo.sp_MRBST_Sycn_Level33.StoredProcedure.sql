USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_MRBST_Sycn_Level33]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_MRBST_Sycn_Level33]
AS
	TRUNCATE TABLE [MRBST_Level33]

	DECLARE @CurDate DATETIME
	DECLARE @REndDate DATETIME
	DECLARE @Week DATETIME
	DECLARE @Period DATETIME
	DECLARE @Quarter DATETIME
	DECLARE @Year DATETIME
	DECLARE @R4W DATETIME
	DECLARE @R13W DATETIME
	SET @CurDate = DATEADD(dd, DATEDIFF(dd,0,GETDATE()), -1)
	SET @REndDate = DATEADD(wk, DATEDIFF(wk,0,@CurDate), 4)
	IF DATEDIFF(dd,@CurDate,@REndDate) > 0
		SET @REndDate = DATEADD(wk, -1, @REndDate)

	SELECT @Week = MIN(CalenderDate) FROM VW_Calender_MRBST WHERE FiscalWeekDesc IN 
		(SELECT FiscalWeekDesc FROM VW_Calender_MRBST WHERE CalenderDate = @CurDate)

	SELECT @Period = MIN(CalenderDate) FROM VW_Calender_MRBST WHERE FiscalPeriodDesc IN 
		(SELECT FiscalPeriodDesc FROM VW_Calender_MRBST WHERE CalenderDate = @CurDate)
	
	SELECT @Quarter = MIN(CalenderDate) FROM VW_Calender_MRBST WHERE FiscalQuarterDesc IN 
		(SELECT FiscalQuarterDesc FROM VW_Calender_MRBST WHERE CalenderDate = @CurDate)

	SELECT @Year = MIN(CalenderDate) FROM VW_Calender_MRBST WHERE FiscalYearDesc IN 
		(SELECT FiscalYearDesc FROM VW_Calender_MRBST WHERE CalenderDate = @CurDate)

	SET @R4W = DATEADD(wk, -4, @REndDate)
	SET @R13W = DATEADD(wk, -13, @REndDate)

	INSERT INTO [MRBST_Level33]
           ([Plant],[Project],[Customer],[OEM],[Defect],[Technology],[Process],[OuterOrInner]
           ,[MRBSqftDay],[FgInSqftDay],[RateDay]
           ,[MRBSqftWeekToDay],[FgInSqftWeekToDay],[RateWeekToDay]
           ,[MRBSqftPeriodToDay],[FgInSqftPeriodToDay],[RatePeriodToDay]
           ,[MRBSqftQuarterToDay],[FgInSqftQuarterToDay],[RateQuarterToDay]
           ,[MRBSqftYearToDay],[FgInSqftYearToDay],[RateYearToDay]
           ,[MRBSqftR4W],[FgInSqftR4W],[RateR4W]
           ,[MRBSqftR13W],[FgInSqftR13W],[RateR13W])

	SELECT Plant, T$ITEM, T$CUST, T$OEMN, T$MDSC, T$TECH, T$PROC, CASE WHEN T$OUTE = 'Yes' THEN 'Outer' ELSE 'Inner' END AS OuterOrInner,
			MRBSqftDay, FgInSqftDay, CASE WHEN FgInSqftDay = 0 THEN 0 ELSE MRBSqftDay / FgInSqftDay END,
			MRBSqfWeekToDay, FgInSqftWeekToDay, CASE WHEN FgInSqftWeekToDay = 0 THEN 0 ELSE MRBSqfWeekToDay / FgInSqftWeekToDay END,
			MRBSqfPeriodToDay, FgInSqftPeriodToDay, CASE WHEN FgInSqftPeriodToDay = 0 THEN 0 ELSE MRBSqfPeriodToDay / FgInSqftPeriodToDay END,
			MRBSqftQuarterToDay, FgInSqftQuarterToDay, CASE WHEN FgInSqftQuarterToDay = 0 THEN 0 ELSE MRBSqftQuarterToDay / FgInSqftQuarterToDay END,
			MRBSqftYearToDay, FgInSqftYearToDay, CASE WHEN FgInSqftYearToDay = 0 THEN 0 ELSE MRBSqftYearToDay / FgInSqftYearToDay END,
			MRBSqftR4W, FgInSqftR4W, CASE WHEN FgInSqftR4W = 0 THEN 0 ELSE MRBSqftR4W / FgInSqftR4W END,
			MRBSqftR13W, FgInSqftR13W, CASE WHEN FgInSqftR13W = 0 THEN 0 ELSE MRBSqftR13W / FgInSqftR13W END 
		FROM (
			SELECT REPLACE(T$PLNT, '2F', 'B2F') AS Plant, RTRIM(LTRIM(T$ITEM)) AS T$ITEM, 
				RTRIM(LTRIM(T$CUST)) AS T$CUST, RTRIM(LTRIM(T$OEMN)) AS T$OEMN, 
				RTRIM(LTRIM(T$MDSC)) AS T$MDSC,	RTRIM(LTRIM(T$TECH)) AS T$TECH,
				RTRIM(LTRIM(T$PROC)) AS T$PROC, RTRIM(LTRIM(T$OUTE)) AS T$OUTE,
				SUM(CASE WHEN T$DATE = @CurDate THEN T$MSQF*T$LCNT ELSE 0 END) AS MRBSqftDay,
				SUM(CASE WHEN T$DATE = @CurDate THEN T$QSQF*T$LCNT ELSE 0 END) AS FgInSqftDay,
				SUM(CASE WHEN T$DATE <= @CurDate AND T$DATE >= @Week THEN T$MSQF*T$LCNT ELSE 0 END) AS MRBSqfWeekToDay,
				SUM(CASE WHEN T$DATE <= @CurDate AND T$DATE >= @Week THEN T$QSQF*T$LCNT ELSE 0 END) AS FgInSqftWeekToDay,
				SUM(CASE WHEN T$DATE <= @CurDate AND T$DATE >= @Period THEN T$MSQF*T$LCNT ELSE 0 END) AS MRBSqfPeriodToDay,
				SUM(CASE WHEN T$DATE <= @CurDate AND T$DATE >= @Period THEN T$QSQF*T$LCNT ELSE 0 END) AS FgInSqftPeriodToDay,
				SUM(CASE WHEN T$DATE <= @CurDate AND T$DATE >= @Quarter THEN T$MSQF*T$LCNT ELSE 0 END) AS MRBSqftQuarterToDay,
				SUM(CASE WHEN T$DATE <= @CurDate AND T$DATE >= @Quarter THEN T$QSQF*T$LCNT ELSE 0 END) AS FgInSqftQuarterToDay,
				SUM(CASE WHEN T$DATE <= @CurDate AND T$DATE >= @Year THEN T$MSQF*T$LCNT ELSE 0 END) AS MRBSqftYearToDay,
				SUM(CASE WHEN T$DATE <= @CurDate AND T$DATE >= @Year THEN T$QSQF*T$LCNT ELSE 0 END) AS FgInSqftYearToDay,
				SUM(CASE WHEN T$DATE <= @CurDate AND T$DATE > @R4W THEN T$MSQF*T$LCNT ELSE 0 END) AS MRBSqftR4W,
				SUM(CASE WHEN T$DATE <= @CurDate AND T$DATE > @R4W THEN T$QSQF*T$LCNT ELSE 0 END) AS FgInSqftR4W,
				SUM(CASE WHEN T$DATE <= @CurDate AND T$DATE > @R13W THEN T$MSQF*T$LCNT ELSE 0 END) AS MRBSqftR13W,
				SUM(CASE WHEN T$DATE <= @CurDate AND T$DATE > @R13W THEN T$QSQF*T$LCNT ELSE 0 END) AS FgInSqftR13W
			FROM TFSOLP128180 GROUP BY T$PLNT, T$ITEM, T$CUST, T$OEMN, T$MDSC, T$TECH, T$PROC, T$OUTE
		) AS TMP



GO
