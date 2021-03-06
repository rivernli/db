USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_ASP_x_QueryBySite]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Name
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[sp_ASP_x_QueryBySite]
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
		SELECT
			T$PLNT AS G1,
			CONVERT(VARCHAR,YEAR(T$DATE)) AS G2,
			(CASE @tr
				WHEN 'ASP' THEN
					(CASE SUM(T$AREA)
						WHEN 0 THEN 0
						ELSE SUM(T$AMNT)/SUM(T$AREA)
					END)
				WHEN 'ALC' THEN
					(CASE SUM(T$AREA)
						WHEN 0 THEN 0
						ELSE SUM(T$LYER*T$AREA)/SUM(T$AREA)
					END)
				WHEN 'PPL' THEN
					(CASE SUM(T$LYER*T$AREA)
						WHEN 0 THEN 0
						ELSE SUM(T$AMNT)/SUM(T$LYER*T$AREA)
					END)
			END) AS PRICE
		FROM TFSOLP112180
		WHERE T$SOUR=@sp
		AND YEAR(T$DATE) BETWEEN @y1 AND @y2
		GROUP BY T$PLNT,CONVERT(VARCHAR,YEAR(T$DATE))
		ORDER BY T$PLNT,CONVERT(VARCHAR,YEAR(T$DATE))
	END

	-- Quarterly
	ELSE IF @tl='Quarterly'
	BEGIN

		SET @p1=@y1*100+@q1
		SET @p2=@y2*100+@q2

		SELECT
			t.T$PLNT AS G1,
			c.calenderQuarterDesc AS G2,
			(CASE @tr
				WHEN 'ASP' THEN
					(CASE SUM(t.T$AREA)
						WHEN 0 THEN 0
						ELSE SUM(t.T$AMNT)/SUM(t.T$AREA)
					END)
				WHEN 'ALC' THEN
					(CASE SUM(T$AREA)
						WHEN 0 THEN 0
						ELSE SUM(T$LYER*T$AREA)/SUM(t.T$AREA)
					END)
				WHEN 'PPL' THEN
					(CASE SUM(t.T$LYER*t.T$AREA)
						WHEN 0 THEN 0
						ELSE SUM(t.T$AMNT)/SUM(t.T$LYER*t.T$AREA)
					END)
			END) AS PRICE
		FROM
			(SELECT *, 
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
		AND t.[YEAR]*100+t.QUARTER BETWEEN @p1 AND @p2
		GROUP BY t.T$PLNT,c.calenderQuarterDesc
		ORDER BY t.T$PLNT,c.calenderQuarterDesc
	END

	-- Monthly
	ELSE IF @tl='Monthly'
	BEGIN

		SET @p1=@y1*100+@m1
		SET @p2=@y2*100+@m2

		SELECT
			t.T$PLNT AS G1,
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
		FROM TFSOLP112180 t
		LEFT JOIN vw_Calender c ON t.T$DATE=c.calenderDate
		WHERE t.T$SOUR=@sp
		AND YEAR(t.T$DATE)*100+MONTH(t.T$DATE) BETWEEN @p1 AND @p2
		GROUP BY t.T$PLNT,c.calenderMonthDesc
		ORDER BY t.T$PLNT,c.calenderMonthDesc
	END
END


GO
