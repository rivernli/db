USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[GlobalViewReport_sp_Query_Order_Price_Change_Detail]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GlobalViewReport_sp_Query_Order_Price_Change_Detail]
	@OEM VARCHAR(500),
	@Option VARCHAR(10),
	@Year INT=NULL,
	@Week INT=NULL,
	@Period INT=NULL,
	@Quarter INT=NULL,
	@Date DATETIME=NULL
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    DECLARE @DateFrom DATETIME,@DateTo DATETIME
    IF @Option='Daily'
		BEGIN
			IF @Date IS NULL
				BEGIN
					RAISERROR ('Sorry, date is not null',16,1)
					RETURN
				END
			SET @DateFrom=@Date
			SET @DateTo=@Date
		END
    IF @Option='Weekly'
		BEGIN
			IF @Year IS NULL
				BEGIN
					RAISERROR ('Sorry, year is not null',16,1)
					RETURN
				END
			IF @Week IS NULL
				BEGIN
					RAISERROR ('Sorry, week is not null',16,1)
					RETURN
				END
			SET @DateFrom=(SELECT TOP 1 FiscalWeekFrom FROM Calendar WHERE FiscalYear=@Year AND FiscalWeek=@Week)
			SET @DateTo=(SELECT TOP 1 FiscalWeekTo FROM Calendar WHERE FiscalYear=@Year AND FiscalWeek=@Week)
		END
    IF @Option='Periodly'
		BEGIN
			IF @Year IS NULL
				BEGIN
					RAISERROR ('Sorry, year is not null',16,1)
					RETURN
				END
			IF @Period IS NULL
				BEGIN
					RAISERROR ('Sorry, period is not null',16,1)
					RETURN
				END
			SET @DateFrom=(SELECT TOP 1 FiscalPeriodFrom FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@Period)
			SET @DateTo=(SELECT TOP 1 FiscalPeriodTo FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@Period)
		END
    IF @Option='Quarterly'
		BEGIN
			IF @Year IS NULL
				BEGIN
					RAISERROR ('Sorry, year is not null',16,1)
					RETURN
				END
			IF @Quarter IS NULL
				BEGIN
					RAISERROR ('Sorry, quarter is not null',16,1)
					RETURN
				END
			SET @DateFrom=(SELECT TOP 1 FiscalQuarterFrom FROM Calendar WHERE FiscalYear=@Year AND FiscalQuarter=@Quarter)
			SET @DateTo=(SELECT TOP 1 FiscalQuarterTo FROM Calendar WHERE FiscalYear=@Year AND FiscalQuarter=@Quarter)
		END
		
	SELECT ISNULL(T$PREA,'') AS Reason
	INTO #Temp
	FROM TFSOLP121180 
	WHERE T$DESC='Price Change' 
		AND T$CSGS=@OEM
		AND T$TRDT BETWEEN @DateFrom AND @DateTo
		AND T$MAMN<>T$MAMT
	GROUP BY ISNULL(T$PREA,'')
	ORDER BY ISNULL(T$PREA,'')
	
	SELECT * FROM #Temp
	
	SELECT a.Reason,b.T$ITEM,(SUM(b.T$MAMN)-SUM(b.T$MAMT)) AS Offset,(CASE b.T$PLNT WHEN 'P2' THEN 'B1' WHEN '2F' THEN 'B2F' WHEN 'HK' THEN 'VVI' ELSE b.T$PLNT END) AS Plant
	FROM #Temp a,TFSOLP121180 b
	WHERE a.Reason=ISNULL(b.T$PREA,'')
		AND b.T$DESC='Price Change' 
		AND b.T$CSGS=@OEM
		AND b.T$TRDT BETWEEN @DateFrom AND @DateTo
		AND B.T$MAMN<>B.T$MAMT
	GROUP BY a.Reason,b.T$ITEM,b.T$PLNT
	ORDER BY a.Reason,b.T$ITEM,b.T$PLNT
END
GO
