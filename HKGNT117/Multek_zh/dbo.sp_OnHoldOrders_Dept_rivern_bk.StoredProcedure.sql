USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_OnHoldOrders_Dept_rivern_bk]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Name
-- Create date: 
-- Description:	
-- =============================================
create PROCEDURE [dbo].[sp_OnHoldOrders_Dept_rivern_bk] 
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
	  where FiscalYear=@year AND FiscalPeriod=@period

	CREATE TABLE #TEMP(DAT DATETIME,AMT DECIMAL(18,2), AGING VARCHAR(10))

	OPEN C_Cal
	FETCH NEXT FROM C_Cal INTO @CalDate
	WHILE @@FETCH_STATUS=0
	BEGIN
		INSERT INTO #TEMP
		SELECT
		DAT,
		(CASE @kusd
			WHEN 1 THEN ROUND(SUM(T$AMNT)/1000,0)
			ELSE SUM(T$AMNT)
		END) AS AMT,
		DEPT
		FROM (SELECT @CalDate AS DAT,T$OHDT,T$DPAT AS DEPT,T$AMNT FROM TFSOLP120180) A
		WHERE T$OHDT <=@CalDate
		GROUP BY DAT,DEPT
		
		FETCH NEXT FROM C_Cal INTO @CalDate
	END

	CLOSE C_Cal
	DEALLOCATE C_Cal

	SELECT * FROM #TEMP
	DROP TABLE #TEMP
END



GO
