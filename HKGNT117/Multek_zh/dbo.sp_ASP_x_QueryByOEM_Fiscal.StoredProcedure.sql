USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_ASP_x_QueryByOEM_Fiscal]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		Name
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[sp_ASP_x_QueryByOEM_Fiscal]
	@tl VARCHAR(10),
	@y1	INT, 
	@y2	INT,
	@q1 INT=1,
	@q2 INT=4,
	@m1 INT=1,
	@m2 INT=12,
	@tr VARCHAR(3)=NULL,
	@sp VARCHAR(20)=NULL,
	@st VARCHAR(10)=NULL,
	@tp INT=5
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @p1 INT, @p2 INT

	-- Yearly
	IF @tl='Yearly'
	BEGIN
		--
		SELECT
			G1,
			PRICE,
			ROW_NUMBER() OVER(ORDER BY PRICE DESC) AS ROWID
		INTO #TEMP
		FROM (
			SELECT
				t.T$CSGS AS G1,
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
			FROM TFSOLP112180 t
			LEFT JOIN vw_Calender c ON t.T$DATE=c.calenderDate
			WHERE t.T$SOUR=@sp
				AND t.T$PLNT=@st
				AND	c.FiscalYear BETWEEN @y1 AND @y2
			GROUP BY t.T$CSGS
		) A

		--
		SELECT
			t.OEM AS G1,
			c.FiscalYearDesc AS G2,
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
		FROM (SELECT a.*,
				(CASE
					WHEN a.T$CSGS=b.G1 THEN a.T$CSGS
					ELSE 'ZZZ-Others'
				END) AS OEM
			FROM TFSOLP112180 a
			LEFT JOIN (SELECT * FROM #TEMP WHERE ROWID<=@tp) b ON a.T$CSGS=b.G1
			) t
		LEFT JOIN vw_Calender c ON t.T$DATE=c.calenderDate
		WHERE t.T$SOUR=@sp
			AND t.T$PLNT=@st
			AND	c.FiscalYear BETWEEN @y1 AND @y2
		GROUP BY t.OEM,c.FiscalYearDesc
		ORDER BY t.OEM,c.FiscalYearDesc

	END

	-- Quarterly
	ELSE IF @tl='Quarterly'
	BEGIN

		SET @p1=@y1*100+@q1
		SET @p2=@y2*100+@q2

		SELECT
			G1,
			PRICE,
			ROW_NUMBER() OVER(ORDER BY PRICE DESC) AS ROWID
		INTO #TEMP2
		FROM (
			SELECT
				t.T$CSGS AS G1,
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
			FROM TFSOLP112180 t
			LEFT JOIN vw_Calender c ON t.T$DATE=c.calenderDate
			WHERE t.T$SOUR=@sp
				AND t.T$PLNT=@st
				AND	c.FiscalYear*100+c.FiscalQuarter BETWEEN @p1 AND @p2
			GROUP BY t.T$CSGS
		) A

		--
		SELECT
			t.OEM AS G1,
			c.FiscalQuarterDesc AS G2,
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
		FROM (SELECT a.*,
				(CASE
					WHEN a.T$CSGS=b.G1 THEN a.T$CSGS
					ELSE 'ZZZ-Others'
				END) AS OEM
			FROM TFSOLP112180 a
			LEFT JOIN (SELECT * FROM #TEMP2 WHERE ROWID<=@tp) b ON a.T$CSGS=b.G1
			) t
		LEFT JOIN vw_Calender c ON t.T$DATE=c.calenderDate
		WHERE t.T$SOUR=@sp
			AND t.T$PLNT=@st
			AND	c.FiscalYear*100+c.FiscalQuarter BETWEEN @p1 AND @p2
		GROUP BY t.OEM,c.FiscalQuarterDesc
		ORDER BY t.OEM,c.FiscalQuarterDesc
	
	END

	-- Monthly
	ELSE IF @tl='Monthly'
	BEGIN

		SET @p1=@y1*100+@m1
		SET @p2=@y2*100+@m2

		SELECT
			G1,
			PRICE,
			ROW_NUMBER() OVER(ORDER BY PRICE DESC) AS ROWID
		INTO #TEMP3
		FROM (
			SELECT
				t.T$CSGS AS G1,
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
			FROM TFSOLP112180 t
			LEFT JOIN vw_Calender c ON t.T$DATE=c.calenderDate
			WHERE t.T$SOUR=@sp
				AND t.T$PLNT=@st
				AND c.FiscalYear*100+c.FiscalPeriod BETWEEN @p1 AND @p2
			GROUP BY t.T$CSGS
		) A

		--
		SELECT
			t.OEM AS G1,
			c.FiscalPeriodDesc AS G2,
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
		FROM (SELECT a.*,
				(CASE
					WHEN a.T$CSGS=b.G1 THEN a.T$CSGS
					ELSE 'ZZZ-Others'
				END) AS OEM
			FROM TFSOLP112180 a
			LEFT JOIN (SELECT * FROM #TEMP3 WHERE ROWID<=@tp) b ON a.T$CSGS=b.G1
			) t
		LEFT JOIN vw_Calender c ON t.T$DATE=c.calenderDate
		WHERE t.T$SOUR=@sp
			AND t.T$PLNT=@st
			AND c.FiscalYear*100+c.FiscalPeriod BETWEEN @p1 AND @p2
		GROUP BY t.OEM,c.FiscalPeriodDesc
		ORDER BY t.OEM,c.FiscalPeriodDesc
	END
END



GO
