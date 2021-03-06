USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[EXR2_New_sp_Automatically_Update_DateRange - job step 1]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- ===============================================
-- Author	   : Rivern
-- Create date : 2011-05-10
-- Description : Auto Calcute EXR2 calc date range
-- ===============================================
CREATE PROCEDURE [dbo].[EXR2_New_sp_Automatically_Update_DateRange - job step 1]
	@Period_Count	INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	DECLARE	@LOOP					INT
	DECLARE	@MAX					INT
	DECLARE	@Period_start_date		DATETIME
	DECLARE	@Period_end_date		DATETIME
	DECLARE	@Last_Period_startdate	DATETIME
	DECLARE	@TEMP_FIS_YEAR		INT
	DECLARE	@TEMP_FIS_PERIOD		INT
	DECLARE	@TEMP					INT
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SET @Period_Count = ISNULL(@Period_Count,0)

    -- Insert statements for procedure here
		IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#USED_FINANCE_YEAR_PERIOD') AND TYPE = 'U')
			DROP TABLE #USED_FINANCE_YEAR_PERIOD

		IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#GET_USED_FINANCE_Calender') AND TYPE = 'U')
			DROP TABLE #GET_USED_FINANCE_Calender

		SELECT TOP 1 @TEMP_FIS_YEAR = FiscalYear,@TEMP_FIS_PERIOD = FiscalPeriod
		FROM	DataWarehouse.dbo.DW_DIM_Calender
		WHERE	calenderDate = CONVERT(VARCHAR(100),GETDATE(),23)

		SET @TEMP = @TEMP_FIS_YEAR*12 + @TEMP_FIS_PERIOD - @Period_Count
		SET	@TEMP_FIS_YEAR = @TEMP /12
		SET @TEMP_FIS_PERIOD = @TEMP - @TEMP_FIS_YEAR*12
		IF @TEMP_FIS_PERIOD = 0 
			BEGIN
				SET @TEMP_FIS_YEAR = @TEMP_FIS_YEAR -1 
				SET @TEMP_FIS_PERIOD = 12
			END

	-----------------------------------------------------------------------------------------------------
		;WITH GET_Current_FINANCE_YEAR_PERIOD(calenderDate,FiscalYear,FiscalYearDesc,FiscalPeriod,FiscalPeriodDesc) AS 
		(
			SELECT calenderDate,FiscalYear,FiscalYearDesc,FiscalPeriod,FiscalPeriodDesc 
			FROM DataWarehouse.dbo.DW_DIM_Calender
			WHERE	FiscalYearDesc+FiscalPeriodDesc IN
			(
				SELECT	FiscalYearDesc+FiscalPeriodDesc 
				FROM	DataWarehouse.dbo.DW_DIM_Calender
				WHERE	calenderDate = CONVERT(VARCHAR(100),GETDATE(),23)
			)
		)
		,
		GET_PERIOD_START_DATE(calenderDate) AS
		(
			SELECT	TOP 1 A.calenderDate
			FROM	DataWarehouse.dbo.DW_DIM_Calender AS A--,GET_Current_FINANCE_YEAR_PERIOD AS B
			WHERE	A.FiscalYear = @TEMP_FIS_YEAR
			AND		A.FiscalPeriod = @TEMP_FIS_PERIOD
		)

		,
		GET_Last_FINANCE_YEAR_PERIOD(calenderDate,FiscalYear,FiscalYearDesc,FiscalPeriod,FiscalPeriodDesc) AS 
		(
			SELECT	calenderDate,FiscalYear,FiscalYearDesc,FiscalPeriod,FiscalPeriodDesc 
			FROM	DataWarehouse.dbo.DW_DIM_Calender
			WHERE	calenderDate >=
					(
						SELECT TOP 1 calenderDate FROM GET_PERIOD_START_DATE
					)
			AND		calenderDate <
					(
						SELECT TOP 1 calenderDate FROM GET_Current_FINANCE_YEAR_PERIOD ORDER BY calenderDate
					)
		)
		,
		GET_USED_FINANCE_Calender(calenderDate,FiscalYear,FiscalPeriod,FiscalYearDesc,FiscalPeriodDesc) AS 
		(
			SELECT	calenderDate,FiscalYear,FiscalPeriod,FiscalYearDesc,FiscalPeriodDesc 
			FROM	GET_Last_FINANCE_YEAR_PERIOD
			WHERE	LTRIM(RTRIM(FiscalYearDesc))+LTRIM(RTRIM(FiscalPeriodDesc)) NOT IN
			(
				SELECT LTRIM(RTRIM(T$FYER))+LTRIM(RTRIM(T$FPRD)) FROM dbo.EXR2_Details_new GROUP BY T$FYER,T$FPRD
			)
		)

		SELECT * INTO #GET_USED_FINANCE_Calender FROM GET_USED_FINANCE_Calender ORDER BY calenderDate

		SELECT IDENTITY(INT,1,1) AS ID,FiscalYearDesc,FiscalPeriodDesc	INTO #USED_FINANCE_YEAR_PERIOD 
		FROM #GET_USED_FINANCE_Calender GROUP BY FiscalYearDesc,FiscalPeriodDesc ORDER BY FiscalYearDesc,FiscalPeriodDesc

	-----------------------------------------------------------------------------------------------------
		SET @LOOP = 1
		SELECT @MAX = MAX(ID) FROM #USED_FINANCE_YEAR_PERIOD

		IF @MAX > 0 
			BEGIN
				WHILE @LOOP <= @MAX
					BEGIN
						SELECT	@Period_start_date = MIN(calenderDate),@Period_end_date = MAX(calenderDate)
						FROM	#GET_USED_FINANCE_Calender 
						WHERE	FiscalYearDesc+FiscalPeriodDesc IN
							(
								SELECT FiscalYearDesc+FiscalPeriodDesc 
								FROM #USED_FINANCE_YEAR_PERIOD
								WHERE ID = @LOOP
							)
						EXEC	[dbo].[EXR2_New_sp_AUTO_UPDATE_Details] @Period_Start_date,@Period_End_date,'INSERT'

						SET @LOOP = @LOOP + 1 
					END
			END
END











GO
