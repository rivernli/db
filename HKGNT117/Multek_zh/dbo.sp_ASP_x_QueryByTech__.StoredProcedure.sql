USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_ASP_x_QueryByTech__]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		Name
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[sp_ASP_x_QueryByTech__]
	@tl VARCHAR(10),
	@y1	INT, 
	@y2	INT,
	@q1 INT=1,
	@q2 INT=4,
	@m1 INT=1,
	@m2 INT=12,
	@tr VARCHAR(3)=NULL,
	@sp VARCHAR(20)=NULL,
	@st VARCHAR(60)=NULL,
	@cu VARCHAR(100)=NULL,
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
		IF OBJECT_ID(N'tempdb.dbo.#TEMPX','U') IS NOT NULL
			DROP TABLE #TEMPX
		SELECT * INTO #TEMPX
		FROM TFSOLP112180 t
		LEFT JOIN vw_Calender c ON t.T$DATE=c.calenderDate
		WHERE t.T$SOUR=@sp
			AND CHARINDEX(t.T$PLNT,@st)>0--t.T$PLNT=@st
			AND t.T$ORNO<>0
			AND	YEAR(t.T$DATE) BETWEEN @y1 AND @y2
		
		IF @cu<>''
			DELETE FROM #TEMPX WHERE T$PRDT<>@cu
			
			
		--
		SELECT
			G1,
			PRICE,
			ROW_NUMBER() OVER(ORDER BY PRICE DESC) AS ROWID
		INTO #TEMP
		FROM (
			SELECT
				t.T$PRDT AS G1,
				/*
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
				END)
				*/
				SUM(t.T$AMNT) AS PRICE
			FROM #TEMPX t --TFSOLP112180 t
			--LEFT JOIN vw_Calender c ON t.T$DATE=c.calenderDate
			--WHERE t.T$SOUR=@sp
			--	AND CHARINDEX(t.T$PLNT,@st)>0--t.T$PLNT=@st
			--	AND t.T$ORNO<>0
			--	AND	YEAR(t.T$DATE) BETWEEN @y1 AND @y2
			GROUP BY t.T$PRDT
		) A
		
		IF @tp=0
			SELECT @tp=COUNT(*) FROM #TEMP

		-- DETAIL AVG
		INSERT INTO #MYTEMP
		SELECT
			t.TECH AS G1,
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
					WHEN a.T$PRDT=b.G1 THEN a.T$PRDT
					ELSE 'ZZZ-Others'
				END) AS TECH
			FROM #TEMPX a --TFSOLP112180 a
			LEFT JOIN (SELECT * FROM #TEMP WHERE ROWID<=@tp) b ON a.T$PRDT=b.G1
			) t
		--LEFT JOIN vw_Calender c ON t.T$DATE=c.calenderDate
		--WHERE t.T$SOUR=@sp
		--	AND CHARINDEX(t.T$PLNT,@st)>0--t.T$PLNT=@st
		--	AND t.T$ORNO<>0
		--	AND	YEAR(t.T$DATE) BETWEEN @y1 AND @y2
		GROUP BY t.TECH,CONVERT(VARCHAR,YEAR(t.T$DATE))
		
		-- ROW AVG
		INSERT INTO #MYTEMP
		SELECT
			t.TECH AS G1,
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
					WHEN a.T$PRDT=b.G1 THEN a.T$PRDT
					ELSE 'ZZZ-Others'
				END) AS TECH
			FROM #TEMPX a --TFSOLP112180 a
			LEFT JOIN (SELECT * FROM #TEMP WHERE ROWID<=@tp) b ON a.T$PRDT=b.G1
			) t
		--LEFT JOIN vw_Calender c ON t.T$DATE=c.calenderDate
		--WHERE t.T$SOUR=@sp
		--	AND CHARINDEX(t.T$PLNT,@st)>0--t.T$PLNT=@st
		--	AND t.T$ORNO<>0
		--	AND	YEAR(t.T$DATE) BETWEEN @y1 AND @y2
		GROUP BY t.TECH

		-- COL AVG
		INSERT INTO #MYTEMP
		SELECT
			'__COL__' AS G1,
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
					WHEN a.T$PRDT=b.G1 THEN a.T$PRDT
					ELSE 'ZZZ-Others'
				END) AS TECH
			FROM #TEMPX a --TFSOLP112180 a
			LEFT JOIN (SELECT * FROM #TEMP WHERE ROWID<=@tp) b ON a.T$PRDT=b.G1
			) t
		--LEFT JOIN vw_Calender c ON t.T$DATE=c.calenderDate
		--WHERE t.T$SOUR=@sp
		--	AND CHARINDEX(t.T$PLNT,@st)>0--t.T$PLNT=@st
		--	AND t.T$ORNO<>0
		--	AND	YEAR(t.T$DATE) BETWEEN @y1 AND @y2
		GROUP BY CONVERT(VARCHAR,YEAR(t.T$DATE))

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
					WHEN a.T$PRDT=b.G1 THEN a.T$PRDT
					ELSE 'ZZZ-Others'
				END) AS TECH
			FROM #TEMPX a --TFSOLP112180 a
			LEFT JOIN (SELECT * FROM #TEMP WHERE ROWID<=@tp) b ON a.T$PRDT=b.G1
			) t
		--LEFT JOIN vw_Calender c ON t.T$DATE=c.calenderDate
		--WHERE t.T$SOUR=@sp
		--	AND CHARINDEX(t.T$PLNT,@st)>0--t.T$PLNT=@st
		--	AND t.T$ORNO<>0
		--	AND	YEAR(t.T$DATE) BETWEEN @y1 AND @y2
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
			AND CHARINDEX(t.T$PLNT,@st)>0--t.T$PLNT=@st
			AND t.T$ORNO<>0
			AND	YEAR(t.T$DATE) BETWEEN @y1 AND @y2
		
		IF @cu<>''
			DELETE FROM #TEMPXX WHERE T$PRDT<>@cu

		SELECT
			G1,
			PRICE,
			ROW_NUMBER() OVER(ORDER BY PRICE DESC) AS ROWID
		INTO #TEMP2
		FROM (
			SELECT
				t.T$PRDT AS G1,
				/*
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
				END)
				*/
				SUM(t.T$AMNT) AS PRICE
			FROM #TEMPXX t
			--	(
			--	SELECT *, 
			--		YEAR(T$DATE) AS [YEAR],
			--		(CASE 
			--			 WHEN MONTH(T$DATE)>=1 AND MONTH(T$DATE)<=3 THEN 1
			--			 WHEN MONTH(T$DATE)>=4 AND MONTH(T$DATE)<=6 THEN 2
			--			 WHEN MONTH(T$DATE)>=7 AND MONTH(T$DATE)<=9 THEN 3
			--			 WHEN MONTH(T$DATE)>=10 AND MONTH(T$DATE)<=12 THEN 4
			--		END) AS QUARTER
			--	FROM TFSOLP112180) t
			--LEFT JOIN vw_Calender c ON t.T$DATE=c.calenderDate
			--WHERE t.T$SOUR=@sp
			--	AND CHARINDEX(t.T$PLNT,@st)>0--t.T$PLNT=@st
			--	AND t.T$ORNO<>0
			--	AND	t.[YEAR]*100+t.QUARTER BETWEEN @p1 AND @p2
			GROUP BY t.T$PRDT
		) A
		
		IF @tp=0
			SELECT @tp=COUNT(*) FROM #TEMP2

		-- DETAIL AVG
		INSERT INTO #MYTEMP
		SELECT
			t.TECH AS G1,
			t.calenderQuarterDesc AS G2,
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
					WHEN a.T$PRDT=b.G1 THEN a.T$PRDT
					ELSE 'ZZZ-Others'
				END) AS TECH
			FROM #TEMPXX a
				--(SELECT *, 
				--		YEAR(T$DATE) AS [YEAR],
				--		(CASE 
				--			 WHEN MONTH(T$DATE)>=1 AND MONTH(T$DATE)<=3 THEN 1
				--			 WHEN MONTH(T$DATE)>=4 AND MONTH(T$DATE)<=6 THEN 2
				--			 WHEN MONTH(T$DATE)>=7 AND MONTH(T$DATE)<=9 THEN 3
				--			 WHEN MONTH(T$DATE)>=10 AND MONTH(T$DATE)<=12 THEN 4
				--		END) AS QUARTER
				--	FROM TFSOLP112180) a
			LEFT JOIN (SELECT * FROM #TEMP2 WHERE ROWID<=@tp) b ON a.T$PRDT=b.G1
			) t
		--LEFT JOIN vw_Calender c ON t.T$DATE=c.calenderDate
		--WHERE t.T$SOUR=@sp
		--	AND CHARINDEX(t.T$PLNT,@st)>0--t.T$PLNT=@st
		--	AND t.T$ORNO<>0
		--	AND	t.[YEAR]*100+t.QUARTER BETWEEN @p1 AND @p2
		GROUP BY t.TECH,t.calenderQuarterDesc
		

		-- ROW AVG
		INSERT INTO #MYTEMP
		SELECT
			t.TECH AS G1,
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
					WHEN a.T$PRDT=b.G1 THEN a.T$PRDT
					ELSE 'ZZZ-Others'
				END) AS TECH
			FROM #TEMPXX a
				--(SELECT *, 
				--		YEAR(T$DATE) AS [YEAR],
				--		(CASE 
				--			 WHEN MONTH(T$DATE)>=1 AND MONTH(T$DATE)<=3 THEN 1
				--			 WHEN MONTH(T$DATE)>=4 AND MONTH(T$DATE)<=6 THEN 2
				--			 WHEN MONTH(T$DATE)>=7 AND MONTH(T$DATE)<=9 THEN 3
				--			 WHEN MONTH(T$DATE)>=10 AND MONTH(T$DATE)<=12 THEN 4
				--		END) AS QUARTER
				--	FROM TFSOLP112180) a
			LEFT JOIN (SELECT * FROM #TEMP2 WHERE ROWID<=@tp) b ON a.T$PRDT=b.G1
			) t
		--LEFT JOIN vw_Calender c ON t.T$DATE=c.calenderDate
		--WHERE t.T$SOUR=@sp
		--	AND CHARINDEX(t.T$PLNT,@st)>0--t.T$PLNT=@st
		--	AND t.T$ORNO<>0
		--	AND	t.[YEAR]*100+t.QUARTER BETWEEN @p1 AND @p2
		GROUP BY t.TECH
	
		-- COL AVG
		INSERT INTO #MYTEMP
		SELECT
			'__COL__' AS G1,
			t.calenderQuarterDesc AS G2,
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
					WHEN a.T$PRDT=b.G1 THEN a.T$PRDT
					ELSE 'ZZZ-Others'
				END) AS TECH
			FROM #TEMPXX a
				--(SELECT *, 
				--		YEAR(T$DATE) AS [YEAR],
				--		(CASE 
				--			 WHEN MONTH(T$DATE)>=1 AND MONTH(T$DATE)<=3 THEN 1
				--			 WHEN MONTH(T$DATE)>=4 AND MONTH(T$DATE)<=6 THEN 2
				--			 WHEN MONTH(T$DATE)>=7 AND MONTH(T$DATE)<=9 THEN 3
				--			 WHEN MONTH(T$DATE)>=10 AND MONTH(T$DATE)<=12 THEN 4
				--		END) AS QUARTER
				--	FROM TFSOLP112180) a
			LEFT JOIN (SELECT * FROM #TEMP2 WHERE ROWID<=@tp) b ON a.T$PRDT=b.G1
			) t
		--LEFT JOIN vw_Calender c ON t.T$DATE=c.calenderDate
		--WHERE t.T$SOUR=@sp
		--	AND CHARINDEX(t.T$PLNT,@st)>0--t.T$PLNT=@st
		--	AND t.T$ORNO<>0
		--	AND	t.[YEAR]*100+t.QUARTER BETWEEN @p1 AND @p2
		GROUP BY t.calenderQuarterDesc

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
					WHEN a.T$PRDT=b.G1 THEN a.T$PRDT
					ELSE 'ZZZ-Others'
				END) AS TECH
			FROM #TEMPXX a
				--(SELECT *, 
				--		YEAR(T$DATE) AS [YEAR],
				--		(CASE 
				--			 WHEN MONTH(T$DATE)>=1 AND MONTH(T$DATE)<=3 THEN 1
				--			 WHEN MONTH(T$DATE)>=4 AND MONTH(T$DATE)<=6 THEN 2
				--			 WHEN MONTH(T$DATE)>=7 AND MONTH(T$DATE)<=9 THEN 3
				--			 WHEN MONTH(T$DATE)>=10 AND MONTH(T$DATE)<=12 THEN 4
				--		END) AS QUARTER
				--	FROM TFSOLP112180) a
			LEFT JOIN (SELECT * FROM #TEMP2 WHERE ROWID<=@tp) b ON a.T$PRDT=b.G1
			) t
		--LEFT JOIN vw_Calender c ON t.T$DATE=c.calenderDate
		--WHERE t.T$SOUR=@sp
		--	AND CHARINDEX(t.T$PLNT,@st)>0--t.T$PLNT=@st
		--	AND t.T$ORNO<>0
		--	AND	t.[YEAR]*100+t.QUARTER BETWEEN @p1 AND @p2
	END

	-- Monthly
	ELSE IF @tl='Monthly'
	BEGIN

		SET @p1=@y1*100+@m1
		SET @p2=@y2*100+@m2
		
		--
		IF OBJECT_ID(N'tempdb.dbo.#TEMPXXX','U') IS NOT NULL
			DROP TABLE #TEMPXXX
		SELECT * INTO #TEMPXXX
		FROM TFSOLP112180 t
		LEFT JOIN vw_Calender c ON t.T$DATE=c.calenderDate
		WHERE t.T$SOUR=@sp
			AND CHARINDEX(t.T$PLNT,@st)>0--t.T$PLNT=@st
			AND t.T$ORNO<>0
			AND YEAR(t.T$DATE)*100+MONTH(t.T$DATE) BETWEEN @p1 AND @p2
		
		IF @cu<>''
			DELETE FROM #TEMPXXX WHERE T$PRDT<>@cu
			
		--

		SELECT
			G1,
			PRICE,
			ROW_NUMBER() OVER(ORDER BY PRICE DESC) AS ROWID
		INTO #TEMP3
		FROM (
			SELECT
				t.T$PRDT AS G1,
				/*
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
				END)
				*/
				SUM(t.T$AMNT) AS PRICE
			FROM #TEMPXXX t --TFSOLP112180 t
			--LEFT JOIN vw_Calender c ON t.T$DATE=c.calenderDate
			--WHERE t.T$SOUR=@sp
			--	AND CHARINDEX(t.T$PLNT,@st)>0--t.T$PLNT=@st
			--	AND t.T$ORNO<>0
			--	AND YEAR(t.T$DATE)*100+MONTH(t.T$DATE) BETWEEN @p1 AND @p2
			GROUP BY t.T$PRDT
		) A
		
		IF @tp=0
			SELECT @tp=COUNT(*) FROM #TEMP3

		-- DETAIL AVG
		INSERT INTO #MYTEMP
		SELECT
			t.TECH AS G1,
			t.calenderMonthDesc AS G2,
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
					WHEN a.T$PRDT=b.G1 THEN a.T$PRDT
					ELSE 'ZZZ-Others'
				END) AS TECH
			FROM #TEMPXXX a --TFSOLP112180 a
			LEFT JOIN (SELECT * FROM #TEMP3 WHERE ROWID<=@tp) b ON a.T$PRDT=b.G1
			) t
		--LEFT JOIN vw_Calender c ON t.T$DATE=c.calenderDate
		--WHERE t.T$SOUR=@sp
		--	AND CHARINDEX(t.T$PLNT,@st)>0--t.T$PLNT=@st
		--	AND t.T$ORNO<>0
		--	AND YEAR(t.T$DATE)*100+MONTH(t.T$DATE) BETWEEN @p1 AND @p2
		GROUP BY t.TECH,t.calenderMonthDesc
		
		-- ROW AVG
		INSERT INTO #MYTEMP
		SELECT
			t.TECH AS G1,
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
					WHEN a.T$PRDT=b.G1 THEN a.T$PRDT
					ELSE 'ZZZ-Others'
				END) AS TECH
			FROM #TEMPXXX a --TFSOLP112180 a
			LEFT JOIN (SELECT * FROM #TEMP3 WHERE ROWID<=@tp) b ON a.T$PRDT=b.G1
			) t
		--LEFT JOIN vw_Calender c ON t.T$DATE=c.calenderDate
		--WHERE t.T$SOUR=@sp
		--	AND CHARINDEX(t.T$PLNT,@st)>0--t.T$PLNT=@st
		--	AND t.T$ORNO<>0
		--	AND YEAR(t.T$DATE)*100+MONTH(t.T$DATE) BETWEEN @p1 AND @p2
		GROUP BY t.TECH

		-- COL AVG
		INSERT INTO #MYTEMP
		SELECT
			'__COL__' AS G1,
			t.calenderMonthDesc AS G2,
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
					WHEN a.T$PRDT=b.G1 THEN a.T$PRDT
					ELSE 'ZZZ-Others'
				END) AS TECH
			FROM #TEMPXXX a --TFSOLP112180 a
			LEFT JOIN (SELECT * FROM #TEMP3 WHERE ROWID<=@tp) b ON a.T$PRDT=b.G1
			) t
		--LEFT JOIN vw_Calender c ON t.T$DATE=c.calenderDate
		--WHERE t.T$SOUR=@sp
		--	AND CHARINDEX(t.T$PLNT,@st)>0--t.T$PLNT=@st
		--	AND t.T$ORNO<>0
		--	AND YEAR(t.T$DATE)*100+MONTH(t.T$DATE) BETWEEN @p1 AND @p2
		GROUP BY t.calenderMonthDesc

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
					WHEN a.T$PRDT=b.G1 THEN a.T$PRDT
					ELSE 'ZZZ-Others'
				END) AS TECH
			FROM #TEMPXXX a --TFSOLP112180 a
			LEFT JOIN (SELECT * FROM #TEMP3 WHERE ROWID<=@tp) b ON a.T$PRDT=b.G1
			) t
		--LEFT JOIN vw_Calender c ON t.T$DATE=c.calenderDate
		--WHERE t.T$SOUR=@sp
		--	AND CHARINDEX(t.T$PLNT,@st)>0--t.T$PLNT=@st
		--	AND t.T$ORNO<>0
		--	AND YEAR(t.T$DATE)*100+MONTH(t.T$DATE) BETWEEN @p1 AND @p2
	END

	SELECT * FROM #MYTEMP

	DROP TABLE #MYTEMP
END




GO
