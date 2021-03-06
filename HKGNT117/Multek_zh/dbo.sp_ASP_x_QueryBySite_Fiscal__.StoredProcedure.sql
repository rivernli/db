USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_ASP_x_QueryBySite_Fiscal__]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		Name
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[sp_ASP_x_QueryBySite_Fiscal__]
	@tl VARCHAR(10),
	@y1	INT, 
	@y2	INT,
	@q1 INT=1,
	@q2 INT=4,
	@m1 INT=1,
	@m2 INT=12,
	@tr VARCHAR(3)=NULL,
	@sp VARCHAR(20)=NULL,
	@st VARCHAR(50)=NULL,
	@cu VARCHAR(100)=NULL,
	@tp INT=5
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @p1 INT, @p2 INT

	CREATE TABLE #TEMP
	(
		G1 VARCHAR(100),
		G2 VARCHAR(100),
		Price float(53)
	)

	-- Yearly
	IF @tl='Yearly'
	BEGIN
	
		--
		IF OBJECT_ID(N'tempdb.dbo.#TEMPX','U') IS NOT NULL
			DROP TABLE #TEMPX
		SELECT * INTO #TEMPX
		FROM TFSOLP112180 t
		LEFT JOIN vw_Calender c ON t.T$DATE=c.calenderDate
		WHERE t.T$SOUR=@sp 
		AND c.FiscalYear BETWEEN @y1 AND @y2

		--IF @cu<>''
		--	DELETE FROM #TEMPX WHERE T$CSGS<>@cu
			
			
		-- detail avg
		INSERT INTO #TEMP
		SELECT
			t.T$PLNT AS G1,
			t.FiscalYearDesc AS G2,
			(CASE @tr
				WHEN 'ASP' THEN
					(CASE SUM(t.T$AREA)
						WHEN 0 THEN 0
						ELSE SUM(t.T$AMNT)/SUM(t.T$AREA)
					END)
				WHEN 'ALC' THEN
					(CASE SUM(t.T$AREA)
						WHEN 0 THEN 0
						ELSE SUM(t.T$LYER*t.T$AREA)/SUM(t.T$AREA)
					END)
				WHEN 'PPL' THEN
					(CASE SUM(t.T$LYER*t.T$AREA)
						WHEN 0 THEN 0
						ELSE SUM(t.T$AMNT)/SUM(t.T$LYER*t.T$AREA)
					END)
			END) AS PRICE
		FROM #TEMPX t
		--LEFT JOIN vw_Calender c ON t.T$DATE=c.calenderDate
		--WHERE t.T$SOUR=@sp 
		--AND c.FiscalYear BETWEEN @y1 AND @y2
		GROUP BY t.T$PLNT,t.FiscalYearDesc

		-- ROW AVG
		INSERT INTO #TEMP
		SELECT
			t.T$PLNT AS G1,
			'__ROW__' AS G2,
			(CASE @tr
				WHEN 'ASP' THEN
					(CASE SUM(t.T$AREA)
						WHEN 0 THEN 0
						ELSE SUM(t.T$AMNT)/SUM(t.T$AREA)
					END)
				WHEN 'ALC' THEN
					(CASE SUM(t.T$AREA)
						WHEN 0 THEN 0
						ELSE SUM(t.T$LYER*t.T$AREA)/SUM(t.T$AREA)
					END)
				WHEN 'PPL' THEN
					(CASE SUM(t.T$LYER*t.T$AREA)
						WHEN 0 THEN 0
						ELSE SUM(t.T$AMNT)/SUM(t.T$LYER*t.T$AREA)
					END)
			END) AS PRICE
		FROM #TEMPX t
		--LEFT JOIN vw_Calender c ON t.T$DATE=c.calenderDate
		--WHERE t.T$SOUR=@sp 
		--AND c.FiscalYear BETWEEN @y1 AND @y2
		GROUP BY t.T$PLNT

		-- COL AVG
		INSERT INTO #TEMP
		SELECT
			'__COL__' AS G1,
			t.FiscalYearDesc AS G2,
			(CASE @tr
				WHEN 'ASP' THEN
					(CASE SUM(t.T$AREA)
						WHEN 0 THEN 0
						ELSE SUM(t.T$AMNT)/SUM(t.T$AREA)
					END)
				WHEN 'ALC' THEN
					(CASE SUM(t.T$AREA)
						WHEN 0 THEN 0
						ELSE SUM(t.T$LYER*t.T$AREA)/SUM(t.T$AREA)
					END)
				WHEN 'PPL' THEN
					(CASE SUM(t.T$LYER*t.T$AREA)
						WHEN 0 THEN 0
						ELSE SUM(t.T$AMNT)/SUM(t.T$LYER*t.T$AREA)
					END)
			END) AS PRICE
		FROM #TEMPX t
		--LEFT JOIN vw_Calender c ON t.T$DATE=c.calenderDate
		--WHERE t.T$SOUR=@sp 
		--AND c.FiscalYear BETWEEN @y1 AND @y2
		GROUP BY t.FiscalYearDesc
		
		-- ALL AVG
		INSERT INTO #TEMP
		SELECT
			'__ALL__' AS G1,
			'__ALL__' AS G2,
			(CASE @tr
				WHEN 'ASP' THEN
					(CASE SUM(t.T$AREA)
						WHEN 0 THEN 0
						ELSE SUM(t.T$AMNT)/SUM(t.T$AREA)
					END)
				WHEN 'ALC' THEN
					(CASE SUM(t.T$AREA)
						WHEN 0 THEN 0
						ELSE SUM(t.T$LYER*t.T$AREA)/SUM(t.T$AREA)
					END)
				WHEN 'PPL' THEN
					(CASE SUM(t.T$LYER*t.T$AREA)
						WHEN 0 THEN 0
						ELSE SUM(t.T$AMNT)/SUM(t.T$LYER*t.T$AREA)
					END)
			END) AS PRICE
		FROM #TEMPX t
		--LEFT JOIN vw_Calender c ON t.T$DATE=c.calenderDate
		--WHERE t.T$SOUR=@sp 
		--AND c.FiscalYear BETWEEN @y1 AND @y2
	END

	-- Quarterly
	ELSE IF @tl='Quarterly'
	BEGIN

		SET @p1=@y1*100+@q1
		SET @p2=@y2*100+@q2
		
		--
		IF OBJECT_ID(N'tempdb.dbo.#TEMPXX','U') IS NOT NULL
			DROP TABLE #TEMPXX
		SELECT * INTO #TEMPXX
		FROM TFSOLP112180 t
		LEFT JOIN vw_Calender c ON t.T$DATE=c.calenderDate
		WHERE t.T$SOUR=@sp
		AND	c.FiscalYear*100+c.FiscalQuarter BETWEEN @p1 AND @p2

		--IF @cu<>''
		--	DELETE FROM #TEMPXX WHERE T$CSGS<>@cu

		--DETAIL AVG
		INSERT INTO #TEMP
		SELECT
			t.T$PLNT AS G1,
			t.FiscalQuarterDesc AS G2,
			(CASE @tr
				WHEN 'ASP' THEN
					(CASE SUM(t.T$AREA)
						WHEN 0 THEN 0
						ELSE SUM(t.T$AMNT)/SUM(t.T$AREA)
					END)
				WHEN 'ALC' THEN
					(CASE SUM(t.T$AREA)
						WHEN 0 THEN 0
						ELSE SUM(t.T$LYER*t.T$AREA)/SUM(t.T$AREA)
					END)
				WHEN 'PPL' THEN
					(CASE SUM(t.T$LYER*t.T$AREA)
						WHEN 0 THEN 0
						ELSE SUM(t.T$AMNT)/SUM(t.T$LYER*t.T$AREA)
					END)
			END) AS PRICE
		FROM #TEMPXX t
		--LEFT JOIN vw_Calender c ON t.T$DATE=c.calenderDate
		--WHERE t.T$SOUR=@sp
		--AND	c.FiscalYear*100+c.FiscalQuarter BETWEEN @p1 AND @p2
		GROUP BY t.T$PLNT,t.FiscalQuarterDesc

		-- ROW AVG
		INSERT INTO #TEMP
		SELECT
			t.T$PLNT AS G1,
			'__ROW__' AS G2,
			(CASE @tr
				WHEN 'ASP' THEN
					(CASE SUM(t.T$AREA)
						WHEN 0 THEN 0
						ELSE SUM(t.T$AMNT)/SUM(t.T$AREA)
					END)
				WHEN 'ALC' THEN
					(CASE SUM(t.T$AREA)
						WHEN 0 THEN 0
						ELSE SUM(t.T$LYER*t.T$AREA)/SUM(t.T$AREA)
					END)
				WHEN 'PPL' THEN
					(CASE SUM(t.T$LYER*t.T$AREA)
						WHEN 0 THEN 0
						ELSE SUM(t.T$AMNT)/SUM(t.T$LYER*t.T$AREA)
					END)
			END) AS PRICE
		FROM #TEMPXX t
		--LEFT JOIN vw_Calender c ON t.T$DATE=c.calenderDate
		--WHERE t.T$SOUR=@sp
		--AND	c.FiscalYear*100+c.FiscalQuarter BETWEEN @p1 AND @p2
		GROUP BY t.T$PLNT

		-- COL AVG
		INSERT INTO #TEMP
		SELECT
			'__COL__' AS G1,
			t.FiscalQuarterDesc AS G2,
			(CASE @tr
				WHEN 'ASP' THEN
					(CASE SUM(t.T$AREA)
						WHEN 0 THEN 0
						ELSE SUM(t.T$AMNT)/SUM(t.T$AREA)
					END)
				WHEN 'ALC' THEN
					(CASE SUM(t.T$AREA)
						WHEN 0 THEN 0
						ELSE SUM(t.T$LYER*t.T$AREA)/SUM(t.T$AREA)
					END)
				WHEN 'PPL' THEN
					(CASE SUM(t.T$LYER*t.T$AREA)
						WHEN 0 THEN 0
						ELSE SUM(t.T$AMNT)/SUM(t.T$LYER*t.T$AREA)
					END)
			END) AS PRICE
		FROM #TEMPXX t
		--LEFT JOIN vw_Calender c ON t.T$DATE=c.calenderDate
		--WHERE t.T$SOUR=@sp
		--AND	c.FiscalYear*100+c.FiscalQuarter BETWEEN @p1 AND @p2
		GROUP BY t.FiscalQuarterDesc

		-- ALL AVG
		INSERT INTO #TEMP
		SELECT
			'__ALL__' AS G1,
			'__ALL__' AS G2,
			(CASE @tr
				WHEN 'ASP' THEN
					(CASE SUM(t.T$AREA)
						WHEN 0 THEN 0
						ELSE SUM(t.T$AMNT)/SUM(t.T$AREA)
					END)
				WHEN 'ALC' THEN
					(CASE SUM(t.T$AREA)
						WHEN 0 THEN 0
						ELSE SUM(t.T$LYER*t.T$AREA)/SUM(t.T$AREA)
					END)
				WHEN 'PPL' THEN
					(CASE SUM(t.T$LYER*t.T$AREA)
						WHEN 0 THEN 0
						ELSE SUM(t.T$AMNT)/SUM(t.T$LYER*t.T$AREA)
					END)
			END) AS PRICE
		FROM #TEMPXX t
		--LEFT JOIN vw_Calender c ON t.T$DATE=c.calenderDate
		--WHERE t.T$SOUR=@sp
		--AND	c.FiscalYear*100+c.FiscalQuarter BETWEEN @p1 AND @p2
	END

	-- Monthly
	ELSE IF @tl='Monthly'
	BEGIN

		SET @p1=@y1*100+@m1
		SET @p2=@y2*100+@m2
		
		IF OBJECT_ID(N'tempdb.dbo.#TEMPXXX','U') IS NOT NULL
			DROP TABLE #TEMPXXX
		SELECT * INTO #TEMPXXX
		FROM TFSOLP112180 t
		LEFT JOIN vw_Calender c ON t.T$DATE=c.calenderDate
		WHERE t.T$SOUR=@sp
		AND	c.FiscalYear*100+c.FiscalPeriod BETWEEN @p1 AND @p2

		--IF @cu<>''
		--	DELETE FROM #TEMPXXX WHERE T$CSGS<>@cu

		--DETAIL AVG
		INSERT INTO #TEMP
		SELECT
			t.T$PLNT AS G1,
			t.FiscalPeriodDesc AS G2,
			(CASE @tr
				WHEN 'ASP' THEN
					(CASE SUM(t.T$AREA)
						WHEN 0 THEN 0
						ELSE SUM(t.T$AMNT)/SUM(t.T$AREA)
					END)
				WHEN 'ALC' THEN
					(CASE SUM(t.T$AREA)
						WHEN 0 THEN 0
						ELSE SUM(t.T$LYER*t.T$AREA)/SUM(t.T$AREA)
					END)
				WHEN 'PPL' THEN
					(CASE SUM(t.T$LYER*t.T$AREA)
						WHEN 0 THEN 0
						ELSE SUM(t.T$AMNT)/SUM(t.T$LYER*t.T$AREA)
					END)
			END) AS PRICE
		FROM #TEMPXXX t
		--LEFT JOIN vw_Calender c ON t.T$DATE=c.calenderDate
		--WHERE t.T$SOUR=@sp
		--AND	c.FiscalYear*100+c.FiscalPeriod BETWEEN @p1 AND @p2
		GROUP BY t.T$PLNT,t.FiscalPeriodDesc

		-- ROW AVG
		INSERT INTO #TEMP
		SELECT
			t.T$PLNT AS G1,
			'__ROW__' AS G2,
			(CASE @tr
				WHEN 'ASP' THEN
					(CASE SUM(t.T$AREA)
						WHEN 0 THEN 0
						ELSE SUM(t.T$AMNT)/SUM(t.T$AREA)
					END)
				WHEN 'ALC' THEN
					(CASE SUM(t.T$AREA)
						WHEN 0 THEN 0
						ELSE SUM(t.T$LYER*t.T$AREA)/SUM(t.T$AREA)
					END)
				WHEN 'PPL' THEN
					(CASE SUM(t.T$LYER*t.T$AREA)
						WHEN 0 THEN 0
						ELSE SUM(t.T$AMNT)/SUM(t.T$LYER*t.T$AREA)
					END)
			END) AS PRICE
		FROM #TEMPXXX t
		--LEFT JOIN vw_Calender c ON t.T$DATE=c.calenderDate
		--WHERE t.T$SOUR=@sp
		--AND	c.FiscalYear*100+c.FiscalPeriod BETWEEN @p1 AND @p2
		GROUP BY t.T$PLNT

		-- COL AVG
		INSERT INTO #TEMP
		SELECT
			'__COL__' AS G1,
			t.FiscalPeriodDesc AS G2,
			(CASE @tr
				WHEN 'ASP' THEN
					(CASE SUM(t.T$AREA)
						WHEN 0 THEN 0
						ELSE SUM(t.T$AMNT)/SUM(t.T$AREA)
					END)
				WHEN 'ALC' THEN
					(CASE SUM(t.T$AREA)
						WHEN 0 THEN 0
						ELSE SUM(t.T$LYER*t.T$AREA)/SUM(t.T$AREA)
					END)
				WHEN 'PPL' THEN
					(CASE SUM(t.T$LYER*t.T$AREA)
						WHEN 0 THEN 0
						ELSE SUM(t.T$AMNT)/SUM(t.T$LYER*t.T$AREA)
					END)
			END) AS PRICE
		FROM #TEMPXXX t
		--LEFT JOIN vw_Calender c ON t.T$DATE=c.calenderDate
		--WHERE t.T$SOUR=@sp
		--AND	c.FiscalYear*100+c.FiscalPeriod BETWEEN @p1 AND @p2
		GROUP BY t.FiscalPeriodDesc

		-- ALL AVG
		INSERT INTO #TEMP
		SELECT
			'__ALL__' AS G1,
			'__ALL__' AS G2,
			(CASE @tr
				WHEN 'ASP' THEN
					(CASE SUM(t.T$AREA)
						WHEN 0 THEN 0
						ELSE SUM(t.T$AMNT)/SUM(t.T$AREA)
					END)
				WHEN 'ALC' THEN
					(CASE SUM(t.T$AREA)
						WHEN 0 THEN 0
						ELSE SUM(t.T$LYER*t.T$AREA)/SUM(t.T$AREA)
					END)
				WHEN 'PPL' THEN
					(CASE SUM(t.T$LYER*t.T$AREA)
						WHEN 0 THEN 0
						ELSE SUM(t.T$AMNT)/SUM(t.T$LYER*t.T$AREA)
					END)
			END) AS PRICE
		FROM #TEMPXXX t
		--LEFT JOIN vw_Calender c ON t.T$DATE=c.calenderDate
		--WHERE t.T$SOUR=@sp
		--AND	c.FiscalYear*100+c.FiscalPeriod BETWEEN @p1 AND @p2
	END

	SELECT * FROM #TEMP

	DROP TABLE #TEMP
END




GO
