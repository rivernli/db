USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[GlobalViewReport_sp_Query_OEM]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GlobalViewReport_sp_Query_OEM] 
	@OEM VARCHAR(2000),
	@Option VARCHAR(50),
	@Year INT=NULL,
	@Period INT=NULL,
	@Week INT=NULL,
	@Date DATETIME=NULL,
	@Plant VARCHAR(50)=NULL
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    DECLARE @DateFrom DATETIME,@DateTo DATETIME
    SET @Plant=(CASE WHEN RTRIM(@Plant)='' THEN NULL ELSE @Plant END)
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
    IF @Option='Yearly'
		BEGIN
			IF @Year IS NULL
				BEGIN
					RAISERROR ('Sorry, year is not null',16,1)
					RETURN
				END
			SET @DateFrom=(SELECT TOP 1 FiscalPeriodFrom FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=1)
			SET @DateTo=(SELECT TOP 1 FiscalPeriodTo FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=12)
		END

	SET @OEM=ISNULL(@OEM,'')
	SET @OEM=ltrim(rtrim(@OEM))+'%'

	IF @Plant IS NULL OR @Plant='Total'
		BEGIN
			SELECT T$CSGS
			FROM TFSOLP121180
			WHERE T$CSGS LIKE @OEM
				AND T$DESC ='Order Intake'
				AND T$TRDT BETWEEN @DateFrom AND @DateTo
			GROUP BY T$CSGS
			ORDER BY T$CSGS

		END
	IF @Plant='TotalEXB2F'
		BEGIN
			SELECT T$CSGS
			FROM TFSOLP121180
			WHERE T$CSGS LIKE @OEM
				AND T$DESC ='Order Intake'
				AND T$TRDT BETWEEN @DateFrom AND @DateTo
				AND T$PLNT<>'2F'
			GROUP BY T$CSGS
			ORDER BY T$CSGS
		END
	IF @Plant IS NOT NULL AND @Plant NOT LIKE 'Total%'
		BEGIN
			SELECT T$CSGS
			FROM TFSOLP121180
			WHERE T$CSGS LIKE @OEM
				AND T$DESC ='Order Intake'
				AND T$TRDT BETWEEN @DateFrom AND @DateTo
				AND (CASE T$PLNT WHEN 'P2' THEN 'B1' WHEN '2F' THEN 'B2F' WHEN 'HK' THEN 'VVI' ELSE T$PLNT END)=@Plant
			GROUP BY T$CSGS
			ORDER BY T$CSGS
		END		
END
GO
