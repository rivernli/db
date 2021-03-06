USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_ASP_x_QueryByCust]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		Name
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[sp_ASP_x_QueryByCust]
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
				t.T$CUNO AS G1,
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
				AND	YEAR(t.T$DATE) BETWEEN @y1 AND @y2
			GROUP BY t.T$CUNO
		) A

		--
		SELECT
			t.CUST AS G1,
			CONVERT(VARCHAR,YEAR(t.T$DATE)) AS G2,
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
					WHEN a.T$CUNO=b.G1 THEN a.T$CUNO
					ELSE 'ZZZ-Others'
				END) AS CUST
			FROM TFSOLP112180 a
			LEFT JOIN (SELECT * FROM #TEMP WHERE ROWID<=@tp) b ON a.T$CUNO=b.G1
			) t
		LEFT JOIN vw_Calender c ON t.T$DATE=c.calenderDate
		WHERE t.T$SOUR=@sp
			AND t.T$PLNT=@st
			AND	YEAR(t.T$DATE) BETWEEN @y1 AND @y2
		GROUP BY t.CUST,CONVERT(VARCHAR,YEAR(t.T$DATE))
		ORDER BY t.CUST,CONVERT(VARCHAR,YEAR(t.T$DATE))

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
				t.T$CUNO AS G1,
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
			FROM (
				SELECT *, 
					YEAR(T$DATE) AS [YEAR],
					(CASE 
						 WHEN MONTH(T$DATE)>=1 AND MONTH(T$DATE)<=3 THEN 1
						 WHEN MONTH(T$DATE)>=4 AND MONTH(T$DATE)<=6 THEN 2
						 WHEN MONTH(T$DATE)>=7 AND MONTH(T$DATE)<=9 THEN 3
						 WHEN MONTH(T$DATE)>=10 AND MONTH(T$DATE)<=12 THEN 4
					END) AS QUARTER
				FROM TFSOLP112180) t
			LEFT JOIN vw_Calender c ON t.T$DATE=c.calenderDate
			WHERE t.T$SOUR=@sp
				AND t.T$PLNT=@st
				AND	t.[YEAR]*100+t.QUARTER BETWEEN @p1 AND @p2
			GROUP BY t.T$CUNO
		) A

		--
		SELECT
			t.CUST AS G1,
			c.calenderQuarterDesc AS G2,
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
					WHEN a.T$CUNO=b.G1 THEN a.T$CUNO
					ELSE 'ZZZ-Others'
				END) AS CUST
			FROM (SELECT *, 
						YEAR(T$DATE) AS [YEAR],
						(CASE 
							 WHEN MONTH(T$DATE)>=1 AND MONTH(T$DATE)<=3 THEN 1
							 WHEN MONTH(T$DATE)>=4 AND MONTH(T$DATE)<=6 THEN 2
							 WHEN MONTH(T$DATE)>=7 AND MONTH(T$DATE)<=9 THEN 3
							 WHEN MONTH(T$DATE)>=10 AND MONTH(T$DATE)<=12 THEN 4
						END) AS QUARTER
					FROM TFSOLP112180) a
			LEFT JOIN (SELECT * FROM #TEMP2 WHERE ROWID<=@tp) b ON a.T$CUNO=b.G1
			) t
		LEFT JOIN vw_Calender c ON t.T$DATE=c.calenderDate
		WHERE t.T$SOUR=@sp
			AND t.T$PLNT=@st
			AND	t.[YEAR]*100+t.QUARTER BETWEEN @p1 AND @p2
		GROUP BY t.CUST,c.calenderQuarterDesc
		ORDER BY t.CUST,c.calenderQuarterDesc
	
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
				t.T$CUNO AS G1,
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
				AND YEAR(t.T$DATE)*100+MONTH(t.T$DATE) BETWEEN @p1 AND @p2
			GROUP BY t.T$CUNO
		) A

		--
		SELECT
			t.CUST AS G1,
			c.calenderMonthDesc AS G2,
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
					WHEN a.T$CUNO=b.G1 THEN a.T$CUNO
					ELSE 'ZZZ-Others'
				END) AS CUST
			FROM TFSOLP112180 a
			LEFT JOIN (SELECT * FROM #TEMP3 WHERE ROWID<=@tp) b ON a.T$CUNO=b.G1
			) t
		LEFT JOIN vw_Calender c ON t.T$DATE=c.calenderDate
		WHERE t.T$SOUR=@sp
			AND t.T$PLNT=@st
			AND YEAR(t.T$DATE)*100+MONTH(t.T$DATE) BETWEEN @p1 AND @p2
		GROUP BY t.CUST,c.calenderMonthDesc
		ORDER BY t.CUST,c.calenderMonthDesc
	END
END



GO
