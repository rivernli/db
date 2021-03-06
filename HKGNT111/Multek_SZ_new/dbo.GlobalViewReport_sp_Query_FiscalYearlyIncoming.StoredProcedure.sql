USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[GlobalViewReport_sp_Query_FiscalYearlyIncoming]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GlobalViewReport_sp_Query_FiscalYearlyIncoming]
	-- Add the parameters for the stored procedure here
	@Plant VARCHAR(50),
	@Year INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    DECLARE @DateFrom DATE,@DateTo DATE
    SET @DateFrom=(SELECT TOP 1 FiscalYearFrom FROM Calendar WHERE FiscalYear=@Year)
    SET @DateTo=(SELECT TOP 1 FiscalYearTo FROM Calendar WHERE FiscalYear=@Year)
    SET @DateFrom=(CASE WHEN @DateFrom>CONVERT(VARCHAR(10),GETDATE()-1,120) THEN CONVERT(VARCHAR(10),GETDATE()-1,120) ELSE @DateFrom END)
    SET @DateTo=(CASE WHEN @DateTo>CONVERT(VARCHAR(10),GETDATE()-1,120) THEN CONVERT(VARCHAR(10),GETDATE()-1,120) ELSE @DateTo END)
    	IF @Plant='B1'
		BEGIN
			SELECT ISNULL(SUM(T$PB12),0) AS Amount
			FROM TFSOLP119180 b
			WHERE b.T$ODAT BETWEEN @DateFrom AND @DateTo
		END
	IF @Plant='B2F'
		BEGIN
			SELECT ISNULL(SUM(T$B2F),0) AS Amount
			FROM TFSOLP119180 b
			WHERE b.T$ODAT BETWEEN @DateFrom AND @DateTo
		END
	IF @Plant='B3'
		BEGIN
			SELECT ISNULL(SUM(T$PB3),0) AS Amount
			FROM TFSOLP119180 b
			WHERE b.T$ODAT BETWEEN @DateFrom AND @DateTo

		END
	IF @Plant='B4'
		BEGIN
			SELECT ISNULL(SUM(T$PB4),0) AS Amount
			FROM TFSOLP119180 b
			WHERE b.T$ODAT BETWEEN @DateFrom AND @DateTo
		END
	IF @Plant='B5'
		BEGIN
			SELECT ISNULL(SUM(T$PB5),0) AS Amount
			FROM TFSOLP119180 b
			WHERE b.T$ODAT BETWEEN @DateFrom AND @DateTo

		END
	IF @Plant='VVI'
		BEGIN
			SELECT ISNULL(SUM(T$SUB1),0) AS Amount
			FROM TFSOLP119180 b
			WHERE b.T$ODAT BETWEEN @DateFrom AND @DateTo
		END
	IF @Plant='SUB'
		BEGIN
			SELECT ISNULL(SUM(T$SUB2),0) AS Amount
			FROM TFSOLP119180 b
			WHERE b.T$ODAT BETWEEN @DateFrom AND @DateTo
		END
	IF @Plant='Total'
		BEGIN
			SELECT ISNULL(SUM(T$PB12),0)+
				  ISNULL(SUM(T$B2F),0)+
				  ISNULL(SUM(T$PB3),0)+
				  ISNULL(SUM(T$PB4),0)+
				  ISNULL(SUM(T$PB5),0)+
				  ISNULL(SUM(T$SUB1),0)+
				  ISNULL(SUM(T$SUB2),0)AS Amount
			FROM TFSOLP119180 b
			WHERE b.T$ODAT BETWEEN @DateFrom AND @DateTo
		END
END
GO
