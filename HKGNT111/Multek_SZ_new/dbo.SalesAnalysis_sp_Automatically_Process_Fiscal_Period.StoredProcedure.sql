USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[SalesAnalysis_sp_Automatically_Process_Fiscal_Period]    Script Date: 11/06/2014 15:47:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SalesAnalysis_sp_Automatically_Process_Fiscal_Period]
	-- Add the parameters for the stored procedure here
	@Type VARCHAR(50),
	@CalculatePeriod INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SET NOCOUNT ON;

    DECLARE @Year CHAR(4),@i INT,@j INT,@k INT,@SQLString VARCHAR(MAX),@Color VARCHAR(50),@DateFrom DATETIME,@DateTo DATETIME ,@Period INT,
			@Amount BIGINT,@Site VARCHAR(50),@Plant VARCHAR(50),@Lay INT,@Customer VARCHAR(500),@OEM VARCHAR(500),@ReportCode VARCHAR(3)
	CREATE TABLE #FiscalYearPeriod (AutoID INT IDENTITY(1,1),FiscalYear SMALLINT,FiscalPeriod TINYINT) 

	SELECT CalenderDate,FiscalYear,FiscalPeriod,FiscalQuarter INTO #TempFiscal FROM Calendar WHERE CalenderDate>=CONVERT(VARCHAR(10),DATEADD(YEAR,-5,GETDATE()-1),120) AND CalenderDate<=(SELECT MAX(CalenderDate) FROM Calendar WHERE FiscalYear=(SELECT MAX(Year) FROM dbo.DistributionReport_Fiscal_Year) AND FiscalPeriod=12)
	INSERT INTO #FiscalYearPeriod(FiscalYear,FiscalPeriod)
	SELECT FiscalYear,FiscalPeriod
	FROM #TempFiscal
	WHERE FiscalYear<(SELECT a.FiscalYear FROM #TempFiscal a WHERE a.CalenderDate=CONVERT(VARCHAR(10),GETDATE(),120))
		OR 
		(
			FiscalYear=(SELECT a.FiscalYear FROM #TempFiscal a WHERE a.CalenderDate=CONVERT(VARCHAR(10),GETDATE(),120))
			AND FiscalPeriod<=(SELECT a.FiscalPeriod FROM #TempFiscal a WHERE a.CalenderDate=CONVERT(VARCHAR(10),GETDATE(),120))
		)
	GROUP BY FiscalYear,FiscalPeriod
	ORDER BY FiscalYear DESC,FiscalPeriod DESC

	SET @Site='Chi'
	SET @ReportCode=(CASE @Type WHEN 'PlantSales' THEN '101' WHEN 'VVI' THEN '102' WHEN 'SAMPLE' THEN '103' WHEN 'TOOLING' THEN '104' WHEN 'RMA' THEN '105' WHEN 'OTHERSALES' THEN '106' WHEN 'JVM' THEN '107' WHEN 'SCRAP' THEN '108' ELSE '' END)
	--We calculate only three fiscal periods
	SET @i=1
	WHILE @i<=@CalculatePeriod
		BEGIN
			SET @Year=(SELECT FiscalYear FROM #FiscalYearPeriod WHERE AutoID=@i)
			SET @Period=(SELECT FiscalPeriod FROM #FiscalYearPeriod WHERE AutoID=@i)
			SET @DateFrom=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM #TempFiscal WHERE FiscalYear=@Year AND FiscalPeriod=@Period) 
			SET @DateTo=  (SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM #TempFiscal WHERE FiscalYear=@Year AND FiscalPeriod=@Period) 

			SET @Plant='B1'
			SET @Amount=dbo.SalesAnalysis_fun_Get_Amount (@Type,'Chi',@Plant,@DatefROM,@DateTo)
			SET @SQLString=dbo.SalesAnalysis_fun_Get_Fiscal_SQL_String(@Year,@Period,@Site,@Plant,@ReportCode,@Amount)
			EXECUTE (@SQLString)
			SET @Plant='B2F'
			SET @Amount=dbo.SalesAnalysis_fun_Get_Amount (@Type,'Chi',@Plant,@DatefROM,@DateTo)
			SET @SQLString=dbo.SalesAnalysis_fun_Get_Fiscal_SQL_String(@Year,@Period,@Site,@Plant,@ReportCode,@Amount)
			EXECUTE (@SQLString)
			SET @Plant='B3'
			SET @Amount=dbo.SalesAnalysis_fun_Get_Amount (@Type,'Chi',@Plant,@DatefROM,@DateTo)
			SET @SQLString=dbo.SalesAnalysis_fun_Get_Fiscal_SQL_String(@Year,@Period,@Site,@Plant,@ReportCode,@Amount)
			EXECUTE (@SQLString)
			SET @Plant='B4'
			SET @Amount=dbo.SalesAnalysis_fun_Get_Amount (@Type,'Chi',@Plant,@DatefROM,@DateTo)
			SET @SQLString=dbo.SalesAnalysis_fun_Get_Fiscal_SQL_String(@Year,@Period,@Site,@Plant,@ReportCode,@Amount)
			EXECUTE (@SQLString)
			SET @Plant='B5'
			SET @Amount=dbo.SalesAnalysis_fun_Get_Amount (@Type,'Chi',@Plant,@DatefROM,@DateTo)
			SET @SQLString=dbo.SalesAnalysis_fun_Get_Fiscal_SQL_String(@Year,@Period,@Site,@Plant,@ReportCode,@Amount)
			EXECUTE (@SQLString)
			SET @Plant='VVI'
			SET @Amount=dbo.SalesAnalysis_fun_Get_Amount (@Type,'Chi',@Plant,@DatefROM,@DateTo)
			SET @SQLString=dbo.SalesAnalysis_fun_Get_Fiscal_SQL_String(@Year,@Period,@Site,@Plant,@ReportCode,@Amount)
			EXECUTE (@SQLString)
			SET @Plant='ZhuHai'
			SET @Amount=dbo.SalesAnalysis_fun_Get_Amount (@Type,'Chi',@Plant,@DatefROM,@DateTo)
			SET @SQLString=dbo.SalesAnalysis_fun_Get_Fiscal_SQL_String(@Year,@Period,@Site,@Plant,@ReportCode,@Amount)

			EXECUTE (@SQLString)
		SET @i=@i+1
	END
END
GO
