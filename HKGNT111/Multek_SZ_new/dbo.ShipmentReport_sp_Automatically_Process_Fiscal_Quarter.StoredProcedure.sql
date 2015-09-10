USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[ShipmentReport_sp_Automatically_Process_Fiscal_Quarter]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ShipmentReport_sp_Automatically_Process_Fiscal_Quarter]
	-- Add the parameters for the stored procedure here
	@CalculateQuarter INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SET NOCOUNT ON;

    DECLARE @Year CHAR(4),@i INT,@j INT,@k INT,@SQLString VARCHAR(MAX),@Color VARCHAR(50),@DateFrom DATETIME,@DateTo DATETIME ,@Quarter INT,
			@Amount BIGINT,@Site VARCHAR(50),@Plant VARCHAR(50),@Lay INT,@Customer VARCHAR(500),@OEM VARCHAR(500),@ReportCode VARCHAR(3)
	CREATE TABLE #FiscalYearQuarter (AutoID INT IDENTITY(1,1),FiscalYear SMALLINT,FiscalQuarter TINYINT) 

	/*
	SELECT CalenderDate,FiscalYear,FiscalQuarter INTO #TempFiscal FROM Calendar WHERE CalenderDate>=CONVERT(VARCHAR(10),DATEADD(YEAR,-5,GETDATE()-1),120) AND CalenderDate<=(SELECT MAX(CalenderDate) FROM Calendar WHERE FiscalYear=CONVERT(VARCHAR(4),GETDATE()-1,120) AND FiscalQuarter=4)
	INSERT INTO #FiscalYearQuarter(FiscalYear,FiscalQuarter)
	SELECT FiscalYear,FiscalQuarter
	FROM #TempFiscal
	WHERE FiscalYear<=(SELECT a.FiscalYear FROM #TempFiscal a WHERE a.CalenderDate=CONVERT(VARCHAR(10),DATEADD(HOUR,15,GETDATE()-1),120))
		AND FiscalQuarter<=(SELECT a.FiscalQuarter FROM #TempFiscal a WHERE a.CalenderDate=CONVERT(VARCHAR(10),DATEADD(HOUR,15,GETDATE()-1),120))
	GROUP BY FiscalYear,FiscalQuarter
	ORDER BY FiscalYear DESC,FiscalQuarter DESC
	*/
	SELECT CalenderDate,FiscalYear,FiscalPeriod,FiscalQuarter INTO #TempFiscal FROM Calendar WHERE CalenderDate>=CONVERT(VARCHAR(10),DATEADD(YEAR,-5,GETDATE()-1),120) AND CalenderDate<=(SELECT MAX(CalenderDate) FROM Calendar WHERE FiscalYear=(SELECT MAX(ShipmentYears) FROM dbo.ShipmentReport_Fiscal_Year) AND FiscalPeriod=12)
	INSERT INTO #FiscalYearQuarter(FiscalYear,FiscalQuarter)
	SELECT FiscalYear,FiscalQuarter
	FROM #TempFiscal
	WHERE FiscalYear<(SELECT a.FiscalYear FROM #TempFiscal a WHERE a.CalenderDate=CONVERT(VARCHAR(10),GETDATE(),120))
		OR 
		(
			FiscalYear=(SELECT a.FiscalYear FROM #TempFiscal a WHERE a.CalenderDate=CONVERT(VARCHAR(10),GETDATE(),120))
			AND FiscalPeriod<=(SELECT a.FiscalPeriod FROM #TempFiscal a WHERE a.CalenderDate=CONVERT(VARCHAR(10),GETDATE(),120))
		)
	GROUP BY FiscalYear,FiscalQuarter
	ORDER BY FiscalYear DESC,FiscalQuarter DESC
	
	--We calculate only three fiscal periods
	SET @i=1
	WHILE @i<=@CalculateQuarter
		BEGIN
			SET @Year=(SELECT FiscalYear FROM #FiscalYearquarter WHERE AutoID=@i)
			SET @Quarter=(SELECT Fiscalquarter FROM #FiscalYearquarter WHERE AutoID=@i)
			SET @DateFrom=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM #TempFiscal WHERE FiscalYear=@Year AND FiscalQuarter=@Quarter) 
			SET @DateTo=  (SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM #TempFiscal WHERE FiscalYear=@Year AND FiscalQuarter=@Quarter) 

			-- ReportCode:004 Process Global Monthly Shipment Trend  
			SET @Site='Dis'
			SET @Plant=''
			SET @ReportCode='004'
			SET @Amount=dbo.ShipmentReport_fun_Get_Amount(@Site,@Plant,'',@DateFrom,@DateTo)
			SET @SQLString=dbo.ShipmentReport_fun_Get_Fiscal_SQL_String(@Year,@Quarter,@Site,@Plant,@ReportCode,@Amount)
			EXECUTE (@SQLString)
			SET @Site='Chi'
			SET @Amount=dbo.ShipmentReport_fun_Get_Amount(@Site,@Plant,'',@DateFrom,@DateTo)
			SET @SQLString=dbo.ShipmentReport_fun_Get_Fiscal_SQL_String(@Year,@Quarter,@Site,@Plant,@ReportCode,@Amount)
			EXECUTE (@SQLString)
			SET @Site='Ger'
			SET @Amount=dbo.ShipmentReport_fun_Get_Amount(@Site,@Plant,'',@DateFrom,@DateTo)
			SET @SQLString=dbo.ShipmentReport_fun_Get_Fiscal_SQL_String(@Year,@Quarter,@Site,@Plant,@ReportCode,@Amount)
			EXECUTE (@SQLString)
			SET @Site='Nfd'
			SET @Amount=dbo.ShipmentReport_fun_Get_Amount(@Site,@Plant,'',@DateFrom,@DateTo)
			SET @SQLString=dbo.ShipmentReport_fun_Get_Fiscal_SQL_String(@Year,@Quarter,@Site,@Plant,@ReportCode,@Amount)
			EXECUTE (@SQLString)
			SET @Site='Sao'
			SET @Amount=dbo.ShipmentReport_fun_Get_Amount(@Site,@Plant,'',@DateFrom,@DateTo)
			SET @SQLString=dbo.ShipmentReport_fun_Get_Fiscal_SQL_String(@Year,@Quarter,@Site,@Plant,@ReportCode,@Amount)
			EXECUTE (@SQLString)
			-- ReportCode:005 Process Site(chi) Plant 12 Monthly Shipment Trend   Code:0003
			SET @Site='Chi'
			SET @Plant='12'
			SET @ReportCode='005'
			SET @Amount=dbo.ShipmentReport_fun_Get_Amount(@Site,@Plant,'',@DateFrom,@DateTo)
			SET @SQLString=dbo.ShipmentReport_fun_Get_Fiscal_SQL_String(@Year,@Quarter,@Site,@Plant,@ReportCode,@Amount)
			EXECUTE (@SQLString)
			SET @Site='Chi'
			SET @Plant='2F'
			SET @Amount=dbo.ShipmentReport_fun_Get_Amount(@Site,@Plant,'',@DateFrom,@DateTo)
			SET @SQLString=dbo.ShipmentReport_fun_Get_Fiscal_SQL_String(@Year,@Quarter,@Site,@Plant,@ReportCode,@Amount)
			EXECUTE (@SQLString)
			SET @Site='Chi'
			SET @Plant='B3'
			SET @Amount=dbo.ShipmentReport_fun_Get_Amount(@Site,@Plant,'',@DateFrom,@DateTo)
			SET @SQLString=dbo.ShipmentReport_fun_Get_Fiscal_SQL_String(@Year,@Quarter,@Site,@Plant,@ReportCode,@Amount)
			EXECUTE (@SQLString)
			SET @Site='Chi'
			SET @Plant='B4'
			SET @Amount=dbo.ShipmentReport_fun_Get_Amount(@Site,@Plant,'',@DateFrom,@DateTo)
			SET @SQLString=dbo.ShipmentReport_fun_Get_Fiscal_SQL_String(@Year,@Quarter,@Site,@Plant,@ReportCode,@Amount)
			EXECUTE (@SQLString)
			SET @Site='Chi'
			SET @Plant='B5'
			SET @Amount=dbo.ShipmentReport_fun_Get_Amount(@Site,@Plant,'',@DateFrom,@DateTo)
			SET @SQLString=dbo.ShipmentReport_fun_Get_Fiscal_SQL_String(@Year,@Quarter,@Site,@Plant,@ReportCode,@Amount)
			EXECUTE (@SQLString)
			SET @Site='Chi'
			SET @Plant='HK'
			SET @Amount=dbo.ShipmentReport_fun_Get_Amount(@Site,@Plant,'',@DateFrom,@DateTo)
			SET @SQLString=dbo.ShipmentReport_fun_Get_Fiscal_SQL_String(@Year,@Quarter,@Site,@Plant,@ReportCode,@Amount)
			EXECUTE (@SQLString)
			SET @Site='Chi'
			SET @Plant='P2'
			SET @Amount=dbo.ShipmentReport_fun_Get_Amount(@Site,@Plant,'',@DateFrom,@DateTo)
			SET @SQLString=dbo.ShipmentReport_fun_Get_Fiscal_SQL_String(@Year,@Quarter,@Site,@Plant,@ReportCode,@Amount)
			EXECUTE (@SQLString)
			SET @Site='Chi'
			SET @Plant='NA'
			SET @Amount=dbo.ShipmentReport_fun_Get_Amount(@Site,@Plant,'',@DateFrom,@DateTo)
			SET @SQLString=dbo.ShipmentReport_fun_Get_Fiscal_SQL_String(@Year,@Quarter,@Site,'Tooling',@ReportCode,@Amount)
			EXECUTE (@SQLString)
			SET @i=@i+1	
		END

END
GO
