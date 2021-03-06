USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[DistributionReport_sp_Query_DailyYearPeriod]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DistributionReport_sp_Query_DailyYearPeriod]
	-- Add the parameters for the stored procedure here
	@Site VARCHAR(50),
	@Plant VARCHAR(50),
	@Type VARCHAR(10),
	@Year VARCHAR(4)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SET @Plant=(CASE @Plant WHEN 'B1' THEN 'P2' WHEN 'B2F' THEN '2F' WHEN 'VVI' THEN 'HK' WHEN 'ZhuHai' THEN '' ELSE @Plant END)

    -- Insert statements for procedure here
    DECLARE @Period TABLE (Period VARCHAR(3))
    DECLARE @P TINYINT,@PP VARCHAR(3)
    
    SET @P=1
    SET @PP='P'+CONVERT(VARCHAR(3),@P)
    IF (SELECT SUM(ABS(b.Amount))FROM DistribitionReport_Daily b WHERE Type=@Type AND Site=@Site AND Plant=@Plant AND Day BETWEEN (SELECT MIN(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM Calendar b WHERE RIGHT(b.FiscalYearDesc,4)=@Year AND b.FiscalPeriod=@P) AND (SELECT MAX(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM Calendar b WHERE RIGHT(b.FiscalYearDesc,4)=@Year AND b.FiscalPeriod=@P))>0
		BEGIN
			INSERT INTO @Period (Period) VALUES(@PP)				
		END
    SET @P=2
    SET @PP='P'+CONVERT(VARCHAR(3),@P)
    IF (SELECT SUM(ABS(b.Amount))FROM DistribitionReport_Daily b WHERE Type=@Type AND Site=@Site AND Plant=@Plant AND Day BETWEEN (SELECT MIN(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM Calendar b WHERE RIGHT(b.FiscalYearDesc,4)=@Year AND b.FiscalPeriod=@P) AND (SELECT MAX(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM Calendar b WHERE RIGHT(b.FiscalYearDesc,4)=@Year AND b.FiscalPeriod=@P))>0
		BEGIN
			INSERT INTO @Period (Period) VALUES(@PP)				
		END
    SET @P=3
    SET @PP='P'+CONVERT(VARCHAR(3),@P)
    IF (SELECT SUM(ABS(b.Amount))FROM DistribitionReport_Daily b WHERE Type=@Type AND Site=@Site AND Plant=@Plant AND Day BETWEEN (SELECT MIN(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM Calendar b WHERE RIGHT(b.FiscalYearDesc,4)=@Year AND b.FiscalPeriod=@P) AND (SELECT MAX(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM Calendar b WHERE RIGHT(b.FiscalYearDesc,4)=@Year AND b.FiscalPeriod=@P))>0
		BEGIN
			INSERT INTO @Period (Period) VALUES(@PP)				
		END
    SET @P=4
    SET @PP='P'+CONVERT(VARCHAR(3),@P)
    IF (SELECT SUM(ABS(b.Amount))FROM DistribitionReport_Daily b WHERE Type=@Type AND Site=@Site AND Plant=@Plant AND Day BETWEEN (SELECT MIN(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM Calendar b WHERE RIGHT(b.FiscalYearDesc,4)=@Year AND b.FiscalPeriod=@P) AND (SELECT MAX(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM Calendar b WHERE RIGHT(b.FiscalYearDesc,4)=@Year AND b.FiscalPeriod=@P))>0
		BEGIN
			INSERT INTO @Period (Period) VALUES(@PP)				
		END
    SET @P=5
    SET @PP='P'+CONVERT(VARCHAR(3),@P)
    IF (SELECT SUM(ABS(b.Amount))FROM DistribitionReport_Daily b WHERE Type=@Type AND Site=@Site AND Plant=@Plant AND Day BETWEEN (SELECT MIN(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM Calendar b WHERE RIGHT(b.FiscalYearDesc,4)=@Year AND b.FiscalPeriod=@P) AND (SELECT MAX(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM Calendar b WHERE RIGHT(b.FiscalYearDesc,4)=@Year AND b.FiscalPeriod=@P))>0
		BEGIN
			INSERT INTO @Period (Period) VALUES(@PP)				
		END
    SET @P=6
    SET @PP='P'+CONVERT(VARCHAR(3),@P)
    IF (SELECT SUM(ABS(b.Amount))FROM DistribitionReport_Daily b WHERE Type=@Type AND Site=@Site AND Plant=@Plant AND Day BETWEEN (SELECT MIN(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM Calendar b WHERE RIGHT(b.FiscalYearDesc,4)=@Year AND b.FiscalPeriod=@P) AND (SELECT MAX(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM Calendar b WHERE RIGHT(b.FiscalYearDesc,4)=@Year AND b.FiscalPeriod=@P))>0
		BEGIN
			INSERT INTO @Period (Period) VALUES(@PP)				
		END
    SET @P=7
    SET @PP='P'+CONVERT(VARCHAR(3),@P)
    IF (SELECT SUM(ABS(b.Amount))FROM DistribitionReport_Daily b WHERE Type=@Type AND Site=@Site AND Plant=@Plant AND Day BETWEEN (SELECT MIN(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM Calendar b WHERE RIGHT(b.FiscalYearDesc,4)=@Year AND b.FiscalPeriod=@P) AND (SELECT MAX(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM Calendar b WHERE RIGHT(b.FiscalYearDesc,4)=@Year AND b.FiscalPeriod=@P))>0
		BEGIN
			INSERT INTO @Period (Period) VALUES(@PP)				
		END
    SET @P=8
    SET @PP='P'+CONVERT(VARCHAR(3),@P)
    IF (SELECT SUM(ABS(b.Amount))FROM DistribitionReport_Daily b WHERE Type=@Type AND Site=@Site AND Plant=@Plant AND Day BETWEEN (SELECT MIN(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM Calendar b WHERE RIGHT(b.FiscalYearDesc,4)=@Year AND b.FiscalPeriod=@P) AND (SELECT MAX(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM Calendar b WHERE RIGHT(b.FiscalYearDesc,4)=@Year AND b.FiscalPeriod=@P))>0
		BEGIN
			INSERT INTO @Period (Period) VALUES(@PP)				
		END
    SET @P=9
    SET @PP='P'+CONVERT(VARCHAR(3),@P)
    IF (SELECT SUM(ABS(b.Amount))FROM DistribitionReport_Daily b WHERE Type=@Type AND Site=@Site AND Plant=@Plant AND Day BETWEEN (SELECT MIN(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM Calendar b WHERE RIGHT(b.FiscalYearDesc,4)=@Year AND b.FiscalPeriod=@P) AND (SELECT MAX(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM Calendar b WHERE RIGHT(b.FiscalYearDesc,4)=@Year AND b.FiscalPeriod=@P))>0
		BEGIN
			INSERT INTO @Period (Period) VALUES(@PP)				
		END
    SET @P=10
    SET @PP='P'+CONVERT(VARCHAR(3),@P)
    IF (SELECT SUM(ABS(b.Amount))FROM DistribitionReport_Daily b WHERE Type=@Type AND Site=@Site AND Plant=@Plant AND Day BETWEEN (SELECT MIN(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM Calendar b WHERE RIGHT(b.FiscalYearDesc,4)=@Year AND b.FiscalPeriod=@P) AND (SELECT MAX(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM Calendar b WHERE RIGHT(b.FiscalYearDesc,4)=@Year AND b.FiscalPeriod=@P))>0
		BEGIN
			INSERT INTO @Period (Period) VALUES(@PP)				
		END
    SET @P=11
    SET @PP='P'+CONVERT(VARCHAR(3),@P)
    IF (SELECT SUM(ABS(b.Amount))FROM DistribitionReport_Daily b WHERE Type=@Type AND Site=@Site AND Plant=@Plant AND Day BETWEEN (SELECT MIN(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM Calendar b WHERE RIGHT(b.FiscalYearDesc,4)=@Year AND b.FiscalPeriod=@P) AND (SELECT MAX(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM Calendar b WHERE RIGHT(b.FiscalYearDesc,4)=@Year AND b.FiscalPeriod=@P))>0
		BEGIN
			INSERT INTO @Period (Period) VALUES(@PP)				
		END
    SET @P=12
    SET @PP='P'+CONVERT(VARCHAR(3),@P)   
    IF (SELECT SUM(ABS(b.Amount))FROM DistribitionReport_Daily b WHERE Type=@Type AND Site=@Site AND Plant=@Plant AND Day BETWEEN (SELECT MIN(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM Calendar b WHERE RIGHT(b.FiscalYearDesc,4)=@Year AND b.FiscalPeriod=@P) AND (SELECT MAX(CONVERT(VARCHAR(10),b.CalenderDate,120)) FROM Calendar b WHERE RIGHT(b.FiscalYearDesc,4)=@Year AND b.FiscalPeriod=@P))>0
		BEGIN
			INSERT INTO @Period (Period) VALUES(@PP)				
		END

	SELECT * FROM @Period
END
GO
