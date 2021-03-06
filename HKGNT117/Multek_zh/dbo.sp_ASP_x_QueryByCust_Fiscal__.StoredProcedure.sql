USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_ASP_x_QueryByCust_Fiscal__]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






-- =============================================
-- Author:		Name
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[sp_ASP_x_QueryByCust_Fiscal__]
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
	@tp INT=5
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @p1 INT, @p2 INT

	CREATE TABLE #MYTEMP
	(
		G1 VARCHAR(100),
		G2 VARCHAR(100),
		Price float(53)
	)

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
				UPPER(t.T$CUNO) AS G1,
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
				AND CHARINDEX(t.T$PLNT,@st)>0--t.T$PLNT=@st
				AND t.T$ORNO<>0
				AND	c.FiscalYear BETWEEN @y1 AND @y2
			GROUP BY t.T$CUNO
		) A

		-- DETAIL AVG
		INSERT INTO #MYTEMP
		SELECT
			UPPER(t.CUST) AS G1,
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
					WHEN UPPER(a.T$CUNO)=b.G1 THEN a.T$CUNO
					ELSE 'ZZZ-Others'
				END) AS CUST
			FROM TFSOLP112180 a
			LEFT JOIN (SELECT * FROM #TEMP WHERE ROWID<=@tp) b ON UPPER(a.T$CUNO)=b.G1
			) t
		LEFT JOIN vw_Calender c ON t.T$DATE=c.calenderDate
		WHERE t.T$SOUR=@sp
			AND CHARINDEX(t.T$PLNT,@st)>0--t.T$PLNT=@st
			AND t.T$ORNO<>0
			AND	c.FiscalYear BETWEEN @y1 AND @y2
		GROUP BY t.CUST,c.FiscalYearDesc

		-- ROW AVG
		INSERT INTO #MYTEMP
		SELECT
			UPPER(t.CUST) AS G1,
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
		FROM (SELECT a.*,
				(CASE
					WHEN UPPER(a.T$CUNO)=b.G1 THEN a.T$CUNO
					ELSE 'ZZZ-Others'
				END) AS CUST
			FROM TFSOLP112180 a
			LEFT JOIN (SELECT * FROM #TEMP WHERE ROWID<=@tp) b ON UPPER(a.T$CUNO)=b.G1
			) t
		LEFT JOIN vw_Calender c ON t.T$DATE=c.calenderDate
		WHERE t.T$SOUR=@sp
			AND CHARINDEX(t.T$PLNT,@st)>0--t.T$PLNT=@st
			AND t.T$ORNO<>0
			AND	c.FiscalYear BETWEEN @y1 AND @y2
		GROUP BY t.CUST

		-- COL AVG
		INSERT INTO #MYTEMP
		SELECT
			'__COL__' AS G1,
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
					WHEN UPPER(a.T$CUNO)=b.G1 THEN a.T$CUNO
					ELSE 'ZZZ-Others'
				END) AS CUST
			FROM TFSOLP112180 a
			LEFT JOIN (SELECT * FROM #TEMP WHERE ROWID<=@tp) b ON UPPER(a.T$CUNO)=b.G1
			) t
		LEFT JOIN vw_Calender c ON t.T$DATE=c.calenderDate
		WHERE t.T$SOUR=@sp
			AND CHARINDEX(t.T$PLNT,@st)>0--t.T$PLNT=@st
			AND t.T$ORNO<>0
			AND	c.FiscalYear BETWEEN @y1 AND @y2
		GROUP BY c.FiscalYearDesc

		-- ALL AVG
		INSERT INTO #MYTEMP
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
		FROM (SELECT a.*,
				(CASE
					WHEN UPPER(a.T$CUNO)=b.G1 THEN a.T$CUNO
					ELSE 'ZZZ-Others'
				END) AS CUST
			FROM TFSOLP112180 a
			LEFT JOIN (SELECT * FROM #TEMP WHERE ROWID<=@tp) b ON UPPER(a.T$CUNO)=b.G1
			) t
		LEFT JOIN vw_Calender c ON t.T$DATE=c.calenderDate
		WHERE t.T$SOUR=@sp
			AND CHARINDEX(t.T$PLNT,@st)>0--t.T$PLNT=@st
			AND t.T$ORNO<>0
			AND	c.FiscalYear BETWEEN @y1 AND @y2
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
				UPPER(t.T$CUNO) AS G1,
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
				AND CHARINDEX(t.T$PLNT,@st)>0--t.T$PLNT=@st
				AND t.T$ORNO<>0
				AND	c.FiscalYear*100+c.FiscalQuarter BETWEEN @p1 AND @p2
			GROUP BY t.T$CUNO
		) A

		-- DETAIL AVG
		INSERT INTO #MYTEMP
		SELECT
			UPPER(t.CUST) AS G1,
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
					WHEN UPPER(a.T$CUNO)=b.G1 THEN a.T$CUNO
					ELSE 'ZZZ-Others'
				END) AS CUST
			FROM TFSOLP112180 a
			LEFT JOIN (SELECT * FROM #TEMP2 WHERE ROWID<=@tp) b ON UPPER(a.T$CUNO)=b.G1
			) t
		LEFT JOIN vw_Calender c ON t.T$DATE=c.calenderDate
		WHERE t.T$SOUR=@sp
			AND CHARINDEX(t.T$PLNT,@st)>0--t.T$PLNT=@st
			AND t.T$ORNO<>0
			AND	c.FiscalYear*100+c.FiscalQuarter BETWEEN @p1 AND @p2
		GROUP BY t.CUST,c.FiscalQuarterDesc
		
		-- ROW AVG
		INSERT INTO #MYTEMP
		SELECT
			UPPER(t.CUST) AS G1,
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
		FROM (SELECT a.*,
				(CASE
					WHEN UPPER(a.T$CUNO)=b.G1 THEN a.T$CUNO
					ELSE 'ZZZ-Others'
				END) AS CUST
			FROM TFSOLP112180 a
			LEFT JOIN (SELECT * FROM #TEMP2 WHERE ROWID<=@tp) b ON UPPER(a.T$CUNO)=b.G1
			) t
		LEFT JOIN vw_Calender c ON t.T$DATE=c.calenderDate
		WHERE t.T$SOUR=@sp
			AND CHARINDEX(t.T$PLNT,@st)>0--t.T$PLNT=@st
			AND t.T$ORNO<>0
			AND	c.FiscalYear*100+c.FiscalQuarter BETWEEN @p1 AND @p2
		GROUP BY t.CUST

		-- COL AVG
		INSERT INTO #MYTEMP
		SELECT
			'__COL__' AS G1,
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
					WHEN UPPER(a.T$CUNO)=b.G1 THEN a.T$CUNO
					ELSE 'ZZZ-Others'
				END) AS CUST
			FROM TFSOLP112180 a
			LEFT JOIN (SELECT * FROM #TEMP2 WHERE ROWID<=@tp) b ON UPPER(a.T$CUNO)=b.G1
			) t
		LEFT JOIN vw_Calender c ON t.T$DATE=c.calenderDate
		WHERE t.T$SOUR=@sp
			AND CHARINDEX(t.T$PLNT,@st)>0--t.T$PLNT=@st
			AND t.T$ORNO<>0
			AND	c.FiscalYear*100+c.FiscalQuarter BETWEEN @p1 AND @p2
		GROUP BY c.FiscalQuarterDesc
	
		-- ALL AVG
		INSERT INTO #MYTEMP
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
		FROM (SELECT a.*,
				(CASE
					WHEN UPPER(a.T$CUNO)=b.G1 THEN a.T$CUNO
					ELSE 'ZZZ-Others'
				END) AS CUST
			FROM TFSOLP112180 a
			LEFT JOIN (SELECT * FROM #TEMP2 WHERE ROWID<=@tp) b ON UPPER(a.T$CUNO)=b.G1
			) t
		LEFT JOIN vw_Calender c ON t.T$DATE=c.calenderDate
		WHERE t.T$SOUR=@sp
			AND CHARINDEX(t.T$PLNT,@st)>0--t.T$PLNT=@st
			AND t.T$ORNO<>0
			AND	c.FiscalYear*100+c.FiscalQuarter BETWEEN @p1 AND @p2
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
				UPPER(t.T$CUNO) AS G1,
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
				AND CHARINDEX(t.T$PLNT,@st)>0--t.T$PLNT=@st
				AND t.T$ORNO<>0
				AND c.FiscalYear*100+c.FiscalPeriod BETWEEN @p1 AND @p2
			GROUP BY t.T$CUNO
		) A

		-- DETAIL AVG
		INSERT INTO #MYTEMP
		SELECT
			UPPER(t.CUST) AS G1,
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
					WHEN UPPER(a.T$CUNO)=b.G1 THEN a.T$CUNO
					ELSE 'ZZZ-Others'
				END) AS CUST
			FROM TFSOLP112180 a
			LEFT JOIN (SELECT * FROM #TEMP3 WHERE ROWID<=@tp) b ON UPPER(a.T$CUNO)=b.G1
			) t
		LEFT JOIN vw_Calender c ON t.T$DATE=c.calenderDate
		WHERE t.T$SOUR=@sp
			AND CHARINDEX(t.T$PLNT,@st)>0--t.T$PLNT=@st
			AND t.T$ORNO<>0
			AND c.FiscalYear*100+c.FiscalPeriod BETWEEN @p1 AND @p2
		GROUP BY t.CUST,c.FiscalPeriodDesc
		
		-- ROW AVG
		INSERT INTO #MYTEMP
		SELECT
			UPPER(t.CUST) AS G1,
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
		FROM (SELECT a.*,
				(CASE
					WHEN UPPER(a.T$CUNO)=b.G1 THEN a.T$CUNO
					ELSE 'ZZZ-Others'
				END) AS CUST
			FROM TFSOLP112180 a
			LEFT JOIN (SELECT * FROM #TEMP3 WHERE ROWID<=@tp) b ON UPPER(a.T$CUNO)=b.G1
			) t
		LEFT JOIN vw_Calender c ON t.T$DATE=c.calenderDate
		WHERE t.T$SOUR=@sp
			AND CHARINDEX(t.T$PLNT,@st)>0--t.T$PLNT=@st
			AND t.T$ORNO<>0
			AND c.FiscalYear*100+c.FiscalPeriod BETWEEN @p1 AND @p2
		GROUP BY t.CUST

		-- COL AVG
		INSERT INTO #MYTEMP
		SELECT
			'__COL__' AS G1,
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
					WHEN UPPER(a.T$CUNO)=b.G1 THEN a.T$CUNO
					ELSE 'ZZZ-Others'
				END) AS CUST
			FROM TFSOLP112180 a
			LEFT JOIN (SELECT * FROM #TEMP3 WHERE ROWID<=@tp) b ON UPPER(a.T$CUNO)=b.G1
			) t
		LEFT JOIN vw_Calender c ON t.T$DATE=c.calenderDate
		WHERE t.T$SOUR=@sp
			AND CHARINDEX(t.T$PLNT,@st)>0--t.T$PLNT=@st
			AND t.T$ORNO<>0
			AND c.FiscalYear*100+c.FiscalPeriod BETWEEN @p1 AND @p2
		GROUP BY c.FiscalPeriodDesc

		-- ALL AVG
		INSERT INTO #MYTEMP
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
		FROM (SELECT a.*,
				(CASE
					WHEN UPPER(a.T$CUNO)=b.G1 THEN a.T$CUNO
					ELSE 'ZZZ-Others'
				END) AS CUST
			FROM TFSOLP112180 a
			LEFT JOIN (SELECT * FROM #TEMP3 WHERE ROWID<=@tp) b ON UPPER(a.T$CUNO)=b.G1
			) t
		LEFT JOIN vw_Calender c ON t.T$DATE=c.calenderDate
		WHERE t.T$SOUR=@sp
			AND CHARINDEX(t.T$PLNT,@st)>0--t.T$PLNT=@st
			AND t.T$ORNO<>0
			AND c.FiscalYear*100+c.FiscalPeriod BETWEEN @p1 AND @p2
	END

	SELECT * FROM #MYTEMP

	DROP TABLE #MYTEMP
END






GO
