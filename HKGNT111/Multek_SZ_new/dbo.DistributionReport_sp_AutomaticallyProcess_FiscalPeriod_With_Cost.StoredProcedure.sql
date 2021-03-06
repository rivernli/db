USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[DistributionReport_sp_AutomaticallyProcess_FiscalPeriod_With_Cost]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DistributionReport_sp_AutomaticallyProcess_FiscalPeriod_With_Cost]
	-- Add the parameters for the stored procedure here
	@Type VARCHAR(10),
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

	--We calculate only three fiscal periods
	SET @i=1
	WHILE @i<=@CalculatePeriod
		BEGIN
			SET @Year=(SELECT FiscalYear FROM #FiscalYearPeriod WHERE AutoID=@i)
			SET @Period=(SELECT FiscalPeriod FROM #FiscalYearPeriod WHERE AutoID=@i)
			SET @DateFrom=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM #TempFiscal WHERE FiscalYear=@Year AND FiscalPeriod=@Period) 
			SET @DateTo=  (SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM #TempFiscal WHERE FiscalYear=@Year AND FiscalPeriod=@Period) 

			-- ReportCode:001 Process Global Monthly Shipment Trend  
			SET @Site='Chi'
			SET @Plant='P2'
			SET @ReportCode='001'
			SET @Amount=ISNULL(dbo.DistributionReport_fun_Get_Amount('FiscalPeriod',@Type,@Site,@Plant,@DateFrom,@DateTo,NULL),0)
			SET @SQLString=dbo.DistributionReport_fun_Get_Fiscal_SQL_String(@Year,@Period,@Type,@Site,@Plant,@ReportCode,@Amount)
			EXECUTE (@SQLString)
			SET @Plant='2F'
			SET @Amount=dbo.DistributionReport_fun_Get_Amount('FiscalPeriod',@Type,@Site,@Plant,@DateFrom,@DateTo,NULL)
			SET @SQLString=dbo.DistributionReport_fun_Get_Fiscal_SQL_String(@Year,@Period,@Type,@Site,@Plant,@ReportCode,@Amount)
			EXECUTE (@SQLString)
			SET @Plant='B3'
			SET @Amount=dbo.DistributionReport_fun_Get_Amount('FiscalPeriod',@Type,@Site,@Plant,@DateFrom,@DateTo,NULL)
			SET @SQLString=dbo.DistributionReport_fun_Get_Fiscal_SQL_String(@Year,@Period,@Type,@Site,@Plant,@ReportCode,@Amount)
			EXECUTE (@SQLString)
			SET @Plant='B4'
			SET @Amount=dbo.DistributionReport_fun_Get_Amount('FiscalPeriod',@Type,@Site,@Plant,@DateFrom,@DateTo,NULL)
			SET @SQLString=dbo.DistributionReport_fun_Get_Fiscal_SQL_String(@Year,@Period,@Type,@Site,@Plant,@ReportCode,@Amount)
			EXECUTE (@SQLString)
			SET @Plant='B5'
			SET @Amount=dbo.DistributionReport_fun_Get_Amount('FiscalPeriod',@Type,@Site,@Plant,@DateFrom,@DateTo,NULL)
			SET @SQLString=dbo.DistributionReport_fun_Get_Fiscal_SQL_String(@Year,@Period,@Type,@Site,@Plant,@ReportCode,@Amount)
			EXECUTE (@SQLString)
			SET @Plant='HK'
			SET @Amount=dbo.DistributionReport_fun_Get_Amount('FiscalPeriod',@Type,@Site,@Plant,@DateFrom,@DateTo,NULL)
			SET @SQLString=dbo.DistributionReport_fun_Get_Fiscal_SQL_String(@Year,@Period,@Type,@Site,@Plant,@ReportCode,@Amount)
			EXECUTE (@SQLString)
			SET @Plant=''
			SET @Amount=dbo.DistributionReport_fun_Get_Amount('FiscalPeriod',@Type,@Site,@Plant,@DateFrom,@DateTo,NULL)
			SET @SQLString=dbo.DistributionReport_fun_Get_Fiscal_SQL_String(@Year,@Period,@Type,@Site,@Plant,@ReportCode,@Amount)
			EXECUTE (@SQLString)

			SET @i=@i+1	
		END

END
GO
