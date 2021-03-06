USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[GlobalViewReport_sp_Query_Periodly_Order_Incoming_OEM_Project]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GlobalViewReport_sp_Query_Periodly_Order_Incoming_OEM_Project]
	@Year NUMERIC(19,4),
	@Plant VARCHAR(20),
	@TargetOEM VARCHAR(200)=NULL
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    DECLARE @DateFrom DATE,@DateTo DATE,@i AS TINYINT

	DECLARE @TempResult TABLE (Project VARCHAR(200),CustomerPart VARCHAR(100),M1 NUMERIC(19,4),M2 NUMERIC(19,4),M3 NUMERIC(19,4),M4 NUMERIC(19,4),M5 NUMERIC(19,4),M6 NUMERIC(19,4),M7 NUMERIC(19,4),M8 NUMERIC(19,4),M9 NUMERIC(19,4),M10 NUMERIC(19,4),M11 NUMERIC(19,4),M12 NUMERIC(19,4),Total NUMERIC(19,4))

	IF @Plant NOT LIKE 'Total%'
		BEGIN
			SET @DateFrom=(SELECT FiscalPeriodFrom FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=1 GROUP BY FiscalPeriodFrom)
			SET @DateTo=(SELECT FiscalPeriodTo FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=12 GROUP BY FiscalPeriodTo)

			INSERT INTO @TempResult (Project,CustomerPart)
			SELECT a.T$ITEM,
					(SELECT b.t$dsca FROM ttiitm001180 b WHERE a.T$ITEM=b.T$ITEM) AS T$DSCA
			FROM TFSOLP121180 a
			WHERE a.T$DESC='Order Intake'
				AND a.T$TRDT  BETWEEN @DateFrom AND @DateTo
				AND (CASE a.T$PLNT WHEN 'P2' THEN 'B1' WHEN '2F' THEN 'B2F' WHEN 'HK' THEN 'VVI' ELSE a.T$PLNT END)=@Plant
				AND a.T$CSGS=@TargetOEM
			GROUP BY a.T$ITEM
			
			SET @i=1
			SET @DateFrom=(SELECT FiscalPeriodFrom FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@i GROUP BY FiscalPeriodFrom)
			SET @DateTo=(SELECT FiscalPeriodTo FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@i GROUP BY FiscalPeriodTo)
			UPDATE @TempResult
			SET M1=(SELECT ISNULL(SUM(T$MAMT),0) FROM TFSOLP121180 WHERE T$DESC='Order Intake' AND T$TRDT  BETWEEN @DateFrom AND @DateTo AND T$CSGS=@TargetOEM AND T$ITEM=Project AND (CASE T$PLNT WHEN 'P2' THEN 'B1' WHEN '2F' THEN 'B2F' WHEN 'HK' THEN 'VVI' ELSE T$PLNT END)=@Plant)
			SET @i=2
			SET @DateFrom=(SELECT FiscalPeriodFrom FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@i GROUP BY FiscalPeriodFrom)
			SET @DateTo=(SELECT FiscalPeriodTo FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@i GROUP BY FiscalPeriodTo)
			UPDATE @TempResult
			SET M2=(SELECT ISNULL(SUM(T$MAMT),0) FROM TFSOLP121180 WHERE T$DESC='Order Intake' AND T$TRDT  BETWEEN @DateFrom AND @DateTo AND T$CSGS=@TargetOEM AND T$ITEM=Project AND (CASE T$PLNT WHEN 'P2' THEN 'B1' WHEN '2F' THEN 'B2F' WHEN 'HK' THEN 'VVI' ELSE T$PLNT END)=@Plant)
			SET @i=3
			SET @DateFrom=(SELECT FiscalPeriodFrom FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@i GROUP BY FiscalPeriodFrom)
			SET @DateTo=(SELECT FiscalPeriodTo FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@i GROUP BY FiscalPeriodTo)
			UPDATE @TempResult
			SET M3=(SELECT ISNULL(SUM(T$MAMT),0) FROM TFSOLP121180 WHERE T$DESC='Order Intake' AND T$TRDT  BETWEEN @DateFrom AND @DateTo AND T$CSGS=@TargetOEM AND T$ITEM=Project AND (CASE T$PLNT WHEN 'P2' THEN 'B1' WHEN '2F' THEN 'B2F' WHEN 'HK' THEN 'VVI' ELSE T$PLNT END)=@Plant)
			SET @i=4
			SET @DateFrom=(SELECT FiscalPeriodFrom FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@i GROUP BY FiscalPeriodFrom)
			SET @DateTo=(SELECT FiscalPeriodTo FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@i GROUP BY FiscalPeriodTo)
			UPDATE @TempResult
			SET M4=(SELECT ISNULL(SUM(T$MAMT),0) FROM TFSOLP121180 WHERE T$DESC='Order Intake' AND T$TRDT  BETWEEN @DateFrom AND @DateTo AND T$CSGS=@TargetOEM AND T$ITEM=Project AND (CASE T$PLNT WHEN 'P2' THEN 'B1' WHEN '2F' THEN 'B2F' WHEN 'HK' THEN 'VVI' ELSE T$PLNT END)=@Plant)
			SET @i=5
			SET @DateFrom=(SELECT FiscalPeriodFrom FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@i GROUP BY FiscalPeriodFrom)
			SET @DateTo=(SELECT FiscalPeriodTo FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@i GROUP BY FiscalPeriodTo)
			UPDATE @TempResult
			SET M5=(SELECT ISNULL(SUM(T$MAMT),0) FROM TFSOLP121180 WHERE T$DESC='Order Intake' AND T$TRDT  BETWEEN @DateFrom AND @DateTo AND T$CSGS=@TargetOEM AND T$ITEM=Project AND (CASE T$PLNT WHEN 'P2' THEN 'B1' WHEN '2F' THEN 'B2F' WHEN 'HK' THEN 'VVI' ELSE T$PLNT END)=@Plant)
			SET @i=6
			SET @DateFrom=(SELECT FiscalPeriodFrom FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@i GROUP BY FiscalPeriodFrom)
			SET @DateTo=(SELECT FiscalPeriodTo FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@i GROUP BY FiscalPeriodTo)
			UPDATE @TempResult
			SET M6=(SELECT ISNULL(SUM(T$MAMT),0) FROM TFSOLP121180 WHERE T$DESC='Order Intake' AND T$TRDT  BETWEEN @DateFrom AND @DateTo AND T$CSGS=@TargetOEM AND T$ITEM=Project AND (CASE T$PLNT WHEN 'P2' THEN 'B1' WHEN '2F' THEN 'B2F' WHEN 'HK' THEN 'VVI' ELSE T$PLNT END)=@Plant)
			SET @i=7
			SET @DateFrom=(SELECT FiscalPeriodFrom FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@i GROUP BY FiscalPeriodFrom)
			SET @DateTo=(SELECT FiscalPeriodTo FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@i GROUP BY FiscalPeriodTo)
			UPDATE @TempResult
			SET M7=(SELECT ISNULL(SUM(T$MAMT),0) FROM TFSOLP121180 WHERE T$DESC='Order Intake' AND T$TRDT  BETWEEN @DateFrom AND @DateTo AND T$CSGS=@TargetOEM AND T$ITEM=Project AND (CASE T$PLNT WHEN 'P2' THEN 'B1' WHEN '2F' THEN 'B2F' WHEN 'HK' THEN 'VVI' ELSE T$PLNT END)=@Plant)
			SET @i=8
			SET @DateFrom=(SELECT FiscalPeriodFrom FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@i GROUP BY FiscalPeriodFrom)
			SET @DateTo=(SELECT FiscalPeriodTo FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@i GROUP BY FiscalPeriodTo)
			UPDATE @TempResult
			SET M8=(SELECT ISNULL(SUM(T$MAMT),0) FROM TFSOLP121180 WHERE T$DESC='Order Intake' AND T$TRDT  BETWEEN @DateFrom AND @DateTo AND T$CSGS=@TargetOEM AND T$ITEM=Project AND (CASE T$PLNT WHEN 'P2' THEN 'B1' WHEN '2F' THEN 'B2F' WHEN 'HK' THEN 'VVI' ELSE T$PLNT END)=@Plant)
			SET @i=9
			SET @DateFrom=(SELECT FiscalPeriodFrom FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@i GROUP BY FiscalPeriodFrom)
			SET @DateTo=(SELECT FiscalPeriodTo FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@i GROUP BY FiscalPeriodTo)
			UPDATE @TempResult
			SET M9=(SELECT ISNULL(SUM(T$MAMT),0) FROM TFSOLP121180 WHERE T$DESC='Order Intake' AND T$TRDT  BETWEEN @DateFrom AND @DateTo AND T$CSGS=@TargetOEM AND T$ITEM=Project AND (CASE T$PLNT WHEN 'P2' THEN 'B1' WHEN '2F' THEN 'B2F' WHEN 'HK' THEN 'VVI' ELSE T$PLNT END)=@Plant)
			SET @i=10
			SET @DateFrom=(SELECT FiscalPeriodFrom FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@i GROUP BY FiscalPeriodFrom)
			SET @DateTo=(SELECT FiscalPeriodTo FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@i GROUP BY FiscalPeriodTo)
			UPDATE @TempResult
			SET M10=(SELECT ISNULL(SUM(T$MAMT),0) FROM TFSOLP121180 WHERE T$DESC='Order Intake' AND T$TRDT  BETWEEN @DateFrom AND @DateTo AND T$CSGS=@TargetOEM AND T$ITEM=Project AND (CASE T$PLNT WHEN 'P2' THEN 'B1' WHEN '2F' THEN 'B2F' WHEN 'HK' THEN 'VVI' ELSE T$PLNT END)=@Plant)
			SET @i=11
			SET @DateFrom=(SELECT FiscalPeriodFrom FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@i GROUP BY FiscalPeriodFrom)
			SET @DateTo=(SELECT FiscalPeriodTo FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@i GROUP BY FiscalPeriodTo)
			UPDATE @TempResult
			SET M11=(SELECT ISNULL(SUM(T$MAMT),0) FROM TFSOLP121180 WHERE T$DESC='Order Intake' AND T$TRDT  BETWEEN @DateFrom AND @DateTo AND T$CSGS=@TargetOEM AND T$ITEM=Project AND (CASE T$PLNT WHEN 'P2' THEN 'B1' WHEN '2F' THEN 'B2F' WHEN 'HK' THEN 'VVI' ELSE T$PLNT END)=@Plant)
			SET @i=12
			SET @DateFrom=(SELECT FiscalPeriodFrom FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@i GROUP BY FiscalPeriodFrom)
			SET @DateTo=(SELECT FiscalPeriodTo FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@i GROUP BY FiscalPeriodTo)
			UPDATE @TempResult
			SET M12=(SELECT ISNULL(SUM(T$MAMT),0) FROM TFSOLP121180 WHERE T$DESC='Order Intake' AND T$TRDT  BETWEEN @DateFrom AND @DateTo AND T$CSGS=@TargetOEM AND T$ITEM=Project AND (CASE T$PLNT WHEN 'P2' THEN 'B1' WHEN '2F' THEN 'B2F' WHEN 'HK' THEN 'VVI' ELSE T$PLNT END)=@Plant)
		END
	IF @Plant ='Total'
		BEGIN
			SET @DateFrom=(SELECT FiscalPeriodFrom FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=1 GROUP BY FiscalPeriodFrom)
			SET @DateTo=(SELECT FiscalPeriodTo FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=12 GROUP BY FiscalPeriodTo)

			INSERT INTO @TempResult (Project,CustomerPart)
			SELECT a.T$ITEM,
					(SELECT b.t$dsca FROM ttiitm001180 b WHERE a.T$ITEM=b.T$ITEM) AS T$DSCA
			FROM TFSOLP121180 a
			WHERE a.T$DESC='Order Intake'
				AND a.T$TRDT  BETWEEN @DateFrom AND @DateTo
				--AND (CASE T$PLNT WHEN 'P2' THEN 'B1' WHEN '2F' THEN 'B2F' WHEN 'HK' THEN 'VVI' ELSE T$PLNT END)=@Plant
				AND a.T$CSGS=@TargetOEM
			GROUP BY T$ITEM
			SET @i=1
			SET @DateFrom=(SELECT FiscalPeriodFrom FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@i GROUP BY FiscalPeriodFrom)
			SET @DateTo=(SELECT FiscalPeriodTo FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@i GROUP BY FiscalPeriodTo)
			UPDATE @TempResult
			SET M1=(SELECT ISNULL(SUM(T$MAMT),0) FROM TFSOLP121180 WHERE T$DESC='Order Intake' AND T$TRDT  BETWEEN @DateFrom AND @DateTo AND T$CSGS=@TargetOEM AND T$ITEM=Project )
			SET @i=2
			SET @DateFrom=(SELECT FiscalPeriodFrom FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@i GROUP BY FiscalPeriodFrom)
			SET @DateTo=(SELECT FiscalPeriodTo FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@i GROUP BY FiscalPeriodTo)
			UPDATE @TempResult
			SET M2=(SELECT ISNULL(SUM(T$MAMT),0) FROM TFSOLP121180 WHERE T$DESC='Order Intake' AND T$TRDT  BETWEEN @DateFrom AND @DateTo AND T$CSGS=@TargetOEM AND T$ITEM=Project )
			SET @i=3
			SET @DateFrom=(SELECT FiscalPeriodFrom FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@i GROUP BY FiscalPeriodFrom)
			SET @DateTo=(SELECT FiscalPeriodTo FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@i GROUP BY FiscalPeriodTo)
			UPDATE @TempResult
			SET M3=(SELECT ISNULL(SUM(T$MAMT),0) FROM TFSOLP121180 WHERE T$DESC='Order Intake' AND T$TRDT  BETWEEN @DateFrom AND @DateTo AND T$CSGS=@TargetOEM AND T$ITEM=Project )
			SET @i=4
			SET @DateFrom=(SELECT FiscalPeriodFrom FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@i GROUP BY FiscalPeriodFrom)
			SET @DateTo=(SELECT FiscalPeriodTo FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@i GROUP BY FiscalPeriodTo)
			UPDATE @TempResult
			SET M4=(SELECT ISNULL(SUM(T$MAMT),0) FROM TFSOLP121180 WHERE T$DESC='Order Intake' AND T$TRDT  BETWEEN @DateFrom AND @DateTo AND T$CSGS=@TargetOEM AND T$ITEM=Project )
			SET @i=5
			SET @DateFrom=(SELECT FiscalPeriodFrom FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@i GROUP BY FiscalPeriodFrom)
			SET @DateTo=(SELECT FiscalPeriodTo FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@i GROUP BY FiscalPeriodTo)
			UPDATE @TempResult
			SET M5=(SELECT ISNULL(SUM(T$MAMT),0) FROM TFSOLP121180 WHERE T$DESC='Order Intake' AND T$TRDT  BETWEEN @DateFrom AND @DateTo AND T$CSGS=@TargetOEM AND T$ITEM=Project )
			SET @i=6
			SET @DateFrom=(SELECT FiscalPeriodFrom FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@i GROUP BY FiscalPeriodFrom)
			SET @DateTo=(SELECT FiscalPeriodTo FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@i GROUP BY FiscalPeriodTo)
			UPDATE @TempResult
			SET M6=(SELECT ISNULL(SUM(T$MAMT),0) FROM TFSOLP121180 WHERE T$DESC='Order Intake' AND T$TRDT  BETWEEN @DateFrom AND @DateTo AND T$CSGS=@TargetOEM AND T$ITEM=Project )
			SET @i=7
			SET @DateFrom=(SELECT FiscalPeriodFrom FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@i GROUP BY FiscalPeriodFrom)
			SET @DateTo=(SELECT FiscalPeriodTo FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@i GROUP BY FiscalPeriodTo)
			UPDATE @TempResult
			SET M7=(SELECT ISNULL(SUM(T$MAMT),0) FROM TFSOLP121180 WHERE T$DESC='Order Intake' AND T$TRDT  BETWEEN @DateFrom AND @DateTo AND T$CSGS=@TargetOEM AND T$ITEM=Project )
			SET @i=8
			SET @DateFrom=(SELECT FiscalPeriodFrom FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@i GROUP BY FiscalPeriodFrom)
			SET @DateTo=(SELECT FiscalPeriodTo FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@i GROUP BY FiscalPeriodTo)
			UPDATE @TempResult
			SET M8=(SELECT ISNULL(SUM(T$MAMT),0) FROM TFSOLP121180 WHERE T$DESC='Order Intake' AND T$TRDT  BETWEEN @DateFrom AND @DateTo AND T$CSGS=@TargetOEM AND T$ITEM=Project )
			SET @i=9
			SET @DateFrom=(SELECT FiscalPeriodFrom FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@i GROUP BY FiscalPeriodFrom)
			SET @DateTo=(SELECT FiscalPeriodTo FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@i GROUP BY FiscalPeriodTo)
			UPDATE @TempResult
			SET M9=(SELECT ISNULL(SUM(T$MAMT),0) FROM TFSOLP121180 WHERE T$DESC='Order Intake' AND T$TRDT  BETWEEN @DateFrom AND @DateTo AND T$CSGS=@TargetOEM AND T$ITEM=Project )
			SET @i=10
			SET @DateFrom=(SELECT FiscalPeriodFrom FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@i GROUP BY FiscalPeriodFrom)
			SET @DateTo=(SELECT FiscalPeriodTo FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@i GROUP BY FiscalPeriodTo)
			UPDATE @TempResult
			SET M10=(SELECT ISNULL(SUM(T$MAMT),0) FROM TFSOLP121180 WHERE T$DESC='Order Intake' AND T$TRDT  BETWEEN @DateFrom AND @DateTo AND T$CSGS=@TargetOEM AND T$ITEM=Project )
			SET @i=11
			SET @DateFrom=(SELECT FiscalPeriodFrom FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@i GROUP BY FiscalPeriodFrom)
			SET @DateTo=(SELECT FiscalPeriodTo FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@i GROUP BY FiscalPeriodTo)
			UPDATE @TempResult
			SET M11=(SELECT ISNULL(SUM(T$MAMT),0) FROM TFSOLP121180 WHERE T$DESC='Order Intake' AND T$TRDT  BETWEEN @DateFrom AND @DateTo AND T$CSGS=@TargetOEM AND T$ITEM=Project )
			SET @i=12
			SET @DateFrom=(SELECT FiscalPeriodFrom FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@i GROUP BY FiscalPeriodFrom)
			SET @DateTo=(SELECT FiscalPeriodTo FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@i GROUP BY FiscalPeriodTo)
			UPDATE @TempResult
			SET M12=(SELECT ISNULL(SUM(T$MAMT),0) FROM TFSOLP121180 WHERE T$DESC='Order Intake' AND T$TRDT  BETWEEN @DateFrom AND @DateTo AND T$CSGS=@TargetOEM AND T$ITEM=Project )
		END
	IF @Plant ='TotalEXB2F'
		BEGIN
			SET @DateFrom=(SELECT FiscalPeriodFrom FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=1 GROUP BY FiscalPeriodFrom)
			SET @DateTo=(SELECT FiscalPeriodTo FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=12 GROUP BY FiscalPeriodTo)

			INSERT INTO @TempResult (Project,CustomerPart)
			SELECT a.T$ITEM,
					(SELECT b.t$dsca FROM ttiitm001180 b WHERE a.T$ITEM=b.T$ITEM) AS T$DSCA
			FROM TFSOLP121180 a
			WHERE a.T$DESC='Order Intake'
				AND a.T$TRDT  BETWEEN @DateFrom AND @DateTo
				AND (CASE a.T$PLNT WHEN 'P2' THEN 'B1' WHEN '2F' THEN 'B2F' WHEN 'HK' THEN 'VVI' ELSE a.T$PLNT END)=@Plant
				AND a.T$PLNT <>'2F'
				AND a.T$CSGS=@TargetOEM
			GROUP BY T$ITEM
			SET @i=1
			SET @DateFrom=(SELECT FiscalPeriodFrom FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@i GROUP BY FiscalPeriodFrom)
			SET @DateTo=(SELECT FiscalPeriodTo FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@i GROUP BY FiscalPeriodTo)
			UPDATE @TempResult
			SET M1=(SELECT ISNULL(SUM(T$MAMT),0) FROM TFSOLP121180 WHERE T$DESC='Order Intake' AND T$TRDT  BETWEEN @DateFrom AND @DateTo AND T$CSGS=@TargetOEM AND T$ITEM=Project AND T$PLNT<>'2F')
			SET @i=2
			SET @DateFrom=(SELECT FiscalPeriodFrom FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@i GROUP BY FiscalPeriodFrom)
			SET @DateTo=(SELECT FiscalPeriodTo FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@i GROUP BY FiscalPeriodTo)
			UPDATE @TempResult
			SET M2=(SELECT ISNULL(SUM(T$MAMT),0) FROM TFSOLP121180 WHERE T$DESC='Order Intake' AND T$TRDT  BETWEEN @DateFrom AND @DateTo AND T$CSGS=@TargetOEM AND T$ITEM=Project AND T$PLNT<>'2F')
			SET @i=3
			SET @DateFrom=(SELECT FiscalPeriodFrom FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@i GROUP BY FiscalPeriodFrom)
			SET @DateTo=(SELECT FiscalPeriodTo FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@i GROUP BY FiscalPeriodTo)
			UPDATE @TempResult
			SET M3=(SELECT ISNULL(SUM(T$MAMT),0) FROM TFSOLP121180 WHERE T$DESC='Order Intake' AND T$TRDT  BETWEEN @DateFrom AND @DateTo AND T$CSGS=@TargetOEM AND T$ITEM=Project AND T$PLNT<>'2F')
			SET @i=4
			SET @DateFrom=(SELECT FiscalPeriodFrom FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@i GROUP BY FiscalPeriodFrom)
			SET @DateTo=(SELECT FiscalPeriodTo FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@i GROUP BY FiscalPeriodTo)
			UPDATE @TempResult
			SET M4=(SELECT ISNULL(SUM(T$MAMT),0) FROM TFSOLP121180 WHERE T$DESC='Order Intake' AND T$TRDT  BETWEEN @DateFrom AND @DateTo AND T$CSGS=@TargetOEM AND T$ITEM=Project AND T$PLNT<>'2F')
			SET @i=5
			SET @DateFrom=(SELECT FiscalPeriodFrom FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@i GROUP BY FiscalPeriodFrom)
			SET @DateTo=(SELECT FiscalPeriodTo FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@i GROUP BY FiscalPeriodTo)
			UPDATE @TempResult
			SET M5=(SELECT ISNULL(SUM(T$MAMT),0) FROM TFSOLP121180 WHERE T$DESC='Order Intake' AND T$TRDT  BETWEEN @DateFrom AND @DateTo AND T$CSGS=@TargetOEM AND T$ITEM=Project AND T$PLNT<>'2F')
			SET @i=6
			SET @DateFrom=(SELECT FiscalPeriodFrom FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@i GROUP BY FiscalPeriodFrom)
			SET @DateTo=(SELECT FiscalPeriodTo FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@i GROUP BY FiscalPeriodTo)
			UPDATE @TempResult
			SET M6=(SELECT ISNULL(SUM(T$MAMT),0) FROM TFSOLP121180 WHERE T$DESC='Order Intake' AND T$TRDT  BETWEEN @DateFrom AND @DateTo AND T$CSGS=@TargetOEM AND T$ITEM=Project AND T$PLNT<>'2F')
			SET @i=7
			SET @DateFrom=(SELECT FiscalPeriodFrom FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@i GROUP BY FiscalPeriodFrom)
			SET @DateTo=(SELECT FiscalPeriodTo FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@i GROUP BY FiscalPeriodTo)
			UPDATE @TempResult
			SET M7=(SELECT ISNULL(SUM(T$MAMT),0) FROM TFSOLP121180 WHERE T$DESC='Order Intake' AND T$TRDT  BETWEEN @DateFrom AND @DateTo AND T$CSGS=@TargetOEM AND T$ITEM=Project AND T$PLNT<>'2F')
			SET @i=8
			SET @DateFrom=(SELECT FiscalPeriodFrom FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@i GROUP BY FiscalPeriodFrom)
			SET @DateTo=(SELECT FiscalPeriodTo FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@i GROUP BY FiscalPeriodTo)
			UPDATE @TempResult
			SET M8=(SELECT ISNULL(SUM(T$MAMT),0) FROM TFSOLP121180 WHERE T$DESC='Order Intake' AND T$TRDT  BETWEEN @DateFrom AND @DateTo AND T$CSGS=@TargetOEM AND T$ITEM=Project AND T$PLNT<>'2F')
			SET @i=9
			SET @DateFrom=(SELECT FiscalPeriodFrom FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@i GROUP BY FiscalPeriodFrom)
			SET @DateTo=(SELECT FiscalPeriodTo FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@i GROUP BY FiscalPeriodTo)
			UPDATE @TempResult
			SET M9=(SELECT ISNULL(SUM(T$MAMT),0) FROM TFSOLP121180 WHERE T$DESC='Order Intake' AND T$TRDT  BETWEEN @DateFrom AND @DateTo AND T$CSGS=@TargetOEM AND T$ITEM=Project AND T$PLNT<>'2F')
			SET @i=10
			SET @DateFrom=(SELECT FiscalPeriodFrom FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@i GROUP BY FiscalPeriodFrom)
			SET @DateTo=(SELECT FiscalPeriodTo FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@i GROUP BY FiscalPeriodTo)
			UPDATE @TempResult
			SET M10=(SELECT ISNULL(SUM(T$MAMT),0) FROM TFSOLP121180 WHERE T$DESC='Order Intake' AND T$TRDT  BETWEEN @DateFrom AND @DateTo AND T$CSGS=@TargetOEM AND T$ITEM=Project AND T$PLNT<>'2F')
			SET @i=11
			SET @DateFrom=(SELECT FiscalPeriodFrom FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@i GROUP BY FiscalPeriodFrom)
			SET @DateTo=(SELECT FiscalPeriodTo FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@i GROUP BY FiscalPeriodTo)
			UPDATE @TempResult
			SET M11=(SELECT ISNULL(SUM(T$MAMT),0) FROM TFSOLP121180 WHERE T$DESC='Order Intake' AND T$TRDT  BETWEEN @DateFrom AND @DateTo AND T$CSGS=@TargetOEM AND T$ITEM=Project AND T$PLNT<>'2F')
			SET @i=12
			SET @DateFrom=(SELECT FiscalPeriodFrom FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@i GROUP BY FiscalPeriodFrom)
			SET @DateTo=(SELECT FiscalPeriodTo FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=@i GROUP BY FiscalPeriodTo)
			UPDATE @TempResult
			SET M12=(SELECT ISNULL(SUM(T$MAMT),0) FROM TFSOLP121180 WHERE T$DESC='Order Intake' AND T$TRDT  BETWEEN @DateFrom AND @DateTo AND T$CSGS=@TargetOEM AND T$ITEM=Project AND T$PLNT<>'2F')
		END
	
	UPDATE @TempResult
	SET Total=M1+M2+M3+M4+M5+M6+M7+M8+M9+M10+M11+M12

	SELECT * FROM @TempResult ORDER BY Total DESC

END
GO
