USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_OnHoldOrders_Aging]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		Name
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[sp_OnHoldOrders_Aging] 
	@year		INT,
	@period		INT,
	@kusd		BIT=TRUE
AS
BEGIN

	SET NOCOUNT ON;

    DECLARE @CalDate DATETIME
	DECLARE C_Cal CURSOR FOR
	SELECT CalenderDate
	  FROM vw_Calendar_A
	  where FiscalYearDesc='FY'+convert(varchar(4),@year) AND FiscalPeriod=@period

	CREATE TABLE #TEMP(DAT DATETIME,AMT DECIMAL(18,3), AGING VARCHAR(10))

	OPEN C_Cal
	FETCH NEXT FROM C_Cal INTO @CalDate
	WHILE @@FETCH_STATUS=0
	BEGIN
		INSERT INTO #TEMP
		SELECT
		DAT,
		(CASE @kusd
			WHEN 1 THEN ROUND(SUM(T$AMNT)*1.000/1000,3) -- ROUND(SUM(T$AMNT)/1000,0), changed by abill 2012.2.3
			ELSE SUM(T$AMNT)
		END) AS AMT,
		AGING
		FROM (SELECT *,@CalDate AS DAT,
		(CASE
			WHEN DATEDIFF(DAY,T$OHDT,@CalDate)<=30 THEN 'A1' --within 1 month
			WHEN DATEDIFF(DAY,T$OHDT,@CalDate) BETWEEN 30 AND 60 THEN 'A2' -- 1-2 months
			WHEN DATEDIFF(DAY,T$OHDT,@CalDate) BETWEEN 60 AND 180 THEN 'A3' -- 2-6 months
			WHEN DATEDIFF(DAY,T$OHDT,@CalDate) BETWEEN 180 AND 360 THEN 'A4' -- 6-12 months
			ELSE 'A5' -- over 1 year
		END) AS AGING FROM TFSOLP120180 where @CalDate = t$date+1) A
		GROUP BY DAT,AGING
		
		IF @@ROWCOUNT = 0
			BEGIN
				INSERT INTO #TEMP(DAT,AMT,AGING) VALUES(@CalDate,0,'A1')
				INSERT INTO #TEMP(DAT,AMT,AGING) VALUES(@CalDate,0,'A2')
				INSERT INTO #TEMP(DAT,AMT,AGING) VALUES(@CalDate,0,'A3')
				INSERT INTO #TEMP(DAT,AMT,AGING) VALUES(@CalDate,0,'A4')
				INSERT INTO #TEMP(DAT,AMT,AGING) VALUES(@CalDate,0,'A5')
			END

		FETCH NEXT FROM C_Cal INTO @CalDate
	END

	CLOSE C_Cal
	DEALLOCATE C_Cal

	SELECT * FROM #TEMP
	DROP TABLE #TEMP
END




GO
