USE [DataWarehouse]
GO
/****** Object:  StoredProcedure [dbo].[DW_DIM_Calender_Auto_Insert]    Script Date: 2014/11/12 17:04:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DW_DIM_Calender_Auto_Insert]
AS
BEGIN
	SET NOCOUNT ON;

	SET LANGUAGE 'US_ENGLISH'
	SET DATEFIRST 1							-- Set First date is monday

	DECLARE	@Start_Date		DATETIME
	DECLARE	@End_date		DATETIME
	DECLARE	@Loop			INT
	DECLARE	@maxID			INT
	DECLARE	@FYear			INT
	DECLARE	@FYear_Desc		NVARCHAR(50)
	DECLARE	@FPeriod		INT
	DECLARE	@FPeriod_Desc	NVARCHAR(50)
	DECLARE	@FQuarter		INT
	DECLARE	@FQuarter_Desc	NVARCHAR(50)
	DECLARE	@FWeek			INT
	DECLARE	@FWeek_Desc		NVARCHAR(50)

    -- synchronous BAAN TABLE TTFGLD005180 / TTFGLD006180

		IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#temp_TTFGLD005180') AND TYPE = 'U')
			DROP TABLE #temp_TTFGLD005180

		IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#temp_TTFGLD006180') AND TYPE = 'U')
			DROP TABLE #temp_TTFGLD006180

		IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#temp_TFSCPP301180') AND TYPE = 'U')
			DROP TABLE #temp_TFSCPP301180

--		SELECT * INTO #temp_TTFGLD005180 FROM OPENQUERY(AS1P1,'SELECT T$PTYP,T$YEAR,T$PRNO,CASE WHEN T$STDT < TO_DATE(''1753-01-01'',''YYYY-MM-DD'')   THEN TO_DATE(''1753-01-01'',''YYYY-MM-DD'') ELSE T$STDT END AS T$STDT,T$DESC,T$CORR FROM BAAN.TTFGLD005180 WHERE T$PTYP = 1')

		SELECT * INTO #temp_TTFGLD006180 FROM OPENQUERY(AS1P1,'SELECT T$YEAR,T$YDSC,CASE WHEN T$FPDT < TO_DATE(''1753-01-01'',''YYYY-MM-DD'') THEN TO_DATE(''1753-01-01'',''YYYY-MM-DD'') ELSE T$FPDT END AS T$FPDT FROM BAAN.TTFGLD006180')
		UPDATE #temp_TTFGLD006180 SET T$YDSC = 'FY1999' WHERE T$YEAR = 1998
		UPDATE #temp_TTFGLD006180 SET T$YDSC = 'FY2000' WHERE T$YEAR = 1999
		UPDATE #temp_TTFGLD006180 SET T$YDSC = 'FY2001' WHERE T$YEAR = 2000
		UPDATE #temp_TTFGLD006180 SET T$YDSC = 'FY2002' WHERE T$YEAR = 2001
		UPDATE #temp_TTFGLD006180 SET T$YDSC = 'FY2003' WHERE T$YEAR = 2002
		UPDATE #temp_TTFGLD006180 SET T$YDSC = 'FY2004' WHERE T$YEAR = 2003
		UPDATE #temp_TTFGLD006180 SET T$YDSC = 'FY2015' WHERE T$YEAR = 2014

		SELECT * INTO #temp_TFSCPP301180 FROM OPENQUERY(AS1P1,'SELECT CASE WHEN T$DATE < TO_DATE(''1753-01-01'',''YYYY-MM-DD'') THEN TO_DATE(''1753-01-01'',''YYYY-MM-DD'') ELSE T$DATE END AS T$DATE ,T$FIWK FROM BAAN.TFSCPP301180')

--		DELETE #temp_TTFGLD005180 WHERE T$STDT IN (SELECT calenderDate FROM dbo.DW_DIM_Calender)
		SELECT * INTO #temp_TTFGLD005180 FROM OPENQUERY(AS1P1,'SELECT T$PTYP,T$YEAR,T$PRNO,CASE WHEN T$STDT < TO_DATE(''1753-01-01'',''YYYY-MM-DD'')   THEN TO_DATE(''1753-01-01'',''YYYY-MM-DD'') ELSE T$STDT END AS T$STDT,T$DESC,T$CORR FROM BAAN.TTFGLD005180 WHERE T$PTYP = 1')
		WHERE T$YEAR NOT IN 
		(
			SELECT T$YEAR FROM #temp_TTFGLD006180 WHERE T$YDSC IN
				(SELECT FiscalYearDesc FROM dbo.DW_DIM_Calender )
		)
		CREATE INDEX FYear_Period ON #temp_TTFGLD005180(T$YEAR,T$PRNO)
		ALTER  TABLE #temp_TTFGLD005180 ADD ID INT IDENTITY
		CREATE INDEX TABLE_ID     ON #temp_TTFGLD005180(ID)
		CREATE INDEX FYear_d      ON #temp_TTFGLD006180(T$YEAR)

		UPDATE #temp_TTFGLD005180 SET T$STDT = (SELECT T$FPDT+1 FROM #temp_TTFGLD006180 AS X WHERE #temp_TTFGLD005180.T$YEAR = X.T$YEAR) WHERE T$PRNO = 13

	-- INIT VARIABLE
		-- GET START DATE
		SELECT TOP 1 @Start_Date = T$STDT FROM #temp_TTFGLD005180 AS A WHERE A.ID = 1
		SELECT @maxID = MAX(ID) FROM #temp_TTFGLD005180

	-- INSERT TARGET TABLE 
		IF EXISTS(SELECT TOP 1 * FROM #temp_TTFGLD005180 WHERE T$PRNO <> 13)
			BEGIN
				SET @Loop = 1 
				WHILE @Loop < @maxID
					BEGIN
						SELECT TOP 1 @FYear = T$YEAR,@FPeriod = T$PRNO FROM #temp_TTFGLD005180 WHERE ID = @Loop
						SELECT @FYear_Desc = T$YDSC FROM #temp_TTFGLD006180 WHERE T$YEAR = @FYear
						IF @FPeriod = 13 
							BEGIN 
								SET @Loop = @Loop + 1	
								SELECT TOP 1 @FYear = T$YEAR,@FPeriod = T$PRNO FROM #temp_TTFGLD005180 WHERE ID = @Loop
								SELECT @FYear_Desc = T$YDSC FROM #temp_TTFGLD006180 WHERE T$YEAR = @FYear
							END
						SET @Loop = @Loop + 1
						IF @FPeriod < 4
							BEGIN
								SET @FQuarter = 1	SET @FQuarter_Desc = 'Q1'
							END
						IF @FPeriod > 3 AND @FPeriod < 7
							BEGIN
								SET @FQuarter = 2	SET @FQuarter_Desc = 'Q2'
							END
						IF @FPeriod > 6 AND @FPeriod < 10
							BEGIN
								SET @FQuarter = 3	SET @FQuarter_Desc = 'Q3'
							END
						IF @FPeriod > 9
							BEGIN
								SET @FQuarter = 4	SET @FQuarter_Desc = 'Q4'
							END
						SET @FPeriod_Desc = 'P' + CASE LEN(@FPeriod) WHEN 1 THEN '0'+CAST(@FPeriod AS NVARCHAR(2)) ELSE CAST(@FPeriod AS NVARCHAR(2)) END

						SELECT TOP 1 @End_date = T$STDT FROM #temp_TTFGLD005180 AS A WHERE A.ID = @Loop ORDER BY T$STDT ASC

						WHILE @Start_Date <> @End_date
							BEGIN
								SELECT @FWeek = T$FIWK FROM #temp_TFSCPP301180 WHERE T$DATE = @Start_Date
								SET @FWeek_Desc = 'FW'+CASE LEN(@FWeek) WHEN 1 THEN '0'+CAST(@FWeek AS NVARCHAR(2)) ELSE CAST(@FWeek AS NVARCHAR(2)) END

								INSERT INTO dbo.DW_DIM_Calender
								(
									[calenderDate],
									[calenderYear],
									[calenderMonth],
									[calenderquarter],
									[calenderYearWeek],
									[calenderWeek],
									[enWeek],
									[enWeekSub],
									[enMonth],
									[FiscalYear],
									[FiscalYearDesc],
									[FiscalQuarter],
									[FiscalQuarterDesc],
									[FiscalPeriod],
									[FiscalPeriodDesc],
									[FiscalWeek],
									[FiscalWeekDesc]
								)
								SELECT @Start_Date,DATEPART(YYYY,@Start_Date),DATEPART(MM,@Start_Date),DATEPART(QQ,@Start_Date),DATEPART(WK,@Start_Date),DATEPART(WEEKDAY,@Start_Date),datename(WEEKDAY,@Start_Date),Left(datename(WEEKDAY,@Start_Date),3),right(left(replace(convert(varchar(30),@Start_Date,106),' ','-'),6),3),@FYear,@FYear_Desc,@FQuarter,@FQuarter_Desc,@FPeriod,@FPeriod_Desc,@FWeek,@FWeek_Desc
								SET @Start_Date = @Start_Date + 1
							END
					END
			END
		ELSE
			BEGIN
				RETURN
			END

	-- Update Period start date & period end date , & others reveneue / Vi report used field
		UPDATE DataWarehouse.dbo.DW_DIM_Calender 
		SET FiscalPeriodFrom=(
									SELECT (SELECT MIN(b.CalenderDate) FROM DataWarehouse.dbo.DW_DIM_Calender  b WHERE b.Fiscalyear=a.FiscalYear AND b.FiscalPeriod=a.FiscalPeriod)
									FROM DataWarehouse.dbo.DW_DIM_Calender  a 
									WHERE a.CalenderDate=DataWarehouse.dbo.DW_DIM_Calender .CalenderDate
							)
		UPDATE DataWarehouse.dbo.DW_DIM_Calender 
		SET FiscalPeriodTo=(
									SELECT (SELECT MAX(b.CalenderDate) FROM DataWarehouse.dbo.DW_DIM_Calender b WHERE b.Fiscalyear=a.FiscalYear AND b.FiscalPeriod=a.FiscalPeriod)
									FROM DataWarehouse.dbo.DW_DIM_Calender a 
									WHERE a.CalenderDate=DataWarehouse.dbo.DW_DIM_Calender.CalenderDate
							)

		UPDATE DataWarehouse.dbo.DW_DIM_Calender
		SET FiscalYearFrom=(
									SELECT (SELECT MIN(b.CalenderDate) FROM DataWarehouse.dbo.DW_DIM_Calender b WHERE b.Fiscalyear=a.FiscalYear)
									FROM DataWarehouse.dbo.DW_DIM_Calender a 
									WHERE a.CalenderDate=DataWarehouse.dbo.DW_DIM_Calender.CalenderDate
							)
		UPDATE DataWarehouse.dbo.DW_DIM_Calender
		SET FiscalYearTo=(
									SELECT (SELECT MAX(b.CalenderDate) FROM DataWarehouse.dbo.DW_DIM_Calender b WHERE b.Fiscalyear=a.FiscalYear)
									FROM DataWarehouse.dbo.DW_DIM_Calender a 
									WHERE a.CalenderDate=DataWarehouse.dbo.DW_DIM_Calender.CalenderDate
							)
		
		UPDATE DataWarehouse.dbo.DW_DIM_Calender
		SET FiscalQuarterFrom=(
									SELECT (SELECT MIN(b.CalenderDate) FROM DataWarehouse.dbo.DW_DIM_Calender b WHERE b.Fiscalyear=a.FiscalYear AND b.FiscalQuarter=a.FiscalQuarter)
									FROM DataWarehouse.dbo.DW_DIM_Calender a 
									WHERE a.CalenderDate=DataWarehouse.dbo.DW_DIM_Calender.CalenderDate
							)

		UPDATE DataWarehouse.dbo.DW_DIM_Calender
		SET FiscalQuarterTo=(
									SELECT (SELECT MAX(b.CalenderDate) FROM DataWarehouse.dbo.DW_DIM_Calender b WHERE b.Fiscalyear=a.FiscalYear AND b.FiscalQuarter=a.FiscalQuarter)
									FROM DataWarehouse.dbo.DW_DIM_Calender a 
									WHERE a.CalenderDate=DataWarehouse.dbo.DW_DIM_Calender.CalenderDate
							)
		
		UPDATE DataWarehouse.dbo.DW_DIM_Calender
		SET FiscalWeekFrom=(
									SELECT (SELECT MIN(b.CalenderDate) FROM DataWarehouse.dbo.DW_DIM_Calender b WHERE b.Fiscalyear=a.FiscalYear AND b.FiscalWeek=a.FiscalWeek)
									FROM DataWarehouse.dbo.DW_DIM_Calender a 
									WHERE a.CalenderDate=DataWarehouse.dbo.DW_DIM_Calender.CalenderDate
							  )				
		UPDATE DataWarehouse.dbo.DW_DIM_Calender
		SET FiscalWeekTo=(
									SELECT (SELECT MAX(b.CalenderDate) FROM DataWarehouse.dbo.DW_DIM_Calender b WHERE b.Fiscalyear=a.FiscalYear AND b.FiscalWeek=a.FiscalWeek)
									FROM DataWarehouse.dbo.DW_DIM_Calender a 
									WHERE a.CalenderDate=DataWarehouse.dbo.DW_DIM_Calender.CalenderDate
							  )		
END




GO
