USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[SalesAnalysis_sp_Automatically_Process_Fiscal_Quarter_ASPALCPPL_For_OEM]    Script Date: 11/06/2014 15:47:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SalesAnalysis_sp_Automatically_Process_Fiscal_Quarter_ASPALCPPL_For_OEM]
	-- Add the parameters for the stored procedure here
	@Type VARCHAR(50),
	@CalculateQuarter INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SET NOCOUNT ON;

    DECLARE @Year CHAR(4),@i INT,@j INT,@k INT,@SQLString VARCHAR(MAX),@Color VARCHAR(50),@DateFrom DATETIME,@DateTo DATETIME ,@Period INT,@Quarter INT,
			@Amount BIGINT,@Site VARCHAR(50),@Plant VARCHAR(50),@Lay INT,@Customer VARCHAR(500),@OEM VARCHAR(500),@ReportCode VARCHAR(3)
	CREATE TABLE #FiscalYearQuarter (AutoID INT IDENTITY(1,1),FiscalYear SMALLINT,FiscalQuarter TINYINT) 

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

	SET @Site='Chi'
	SET @ReportCode=(CASE @Type WHEN 'ASP' THEN '211' WHEN 'ALC' THEN '212' WHEN 'PPL' THEN '213' ELSE '' END)
	--We calculate only three fiscal periods
	DECLARE @OEMCustomerLayer VARCHAR(300)
	DECLARE OEMCustomer_C CURSOR FOR 
	SELECT TOP 5 OEM
	FROM ShipmentReport_Shipped_All_Fixed_Top_20_OEM_Fiscal_By_Loc
	WHERE Loc='Chi'
	ORDER BY Amount DESC
	
	OPEN OEMCustomer_C
	FETCH NEXT FROM OEMCustomer_C INTO @OEMCustomerLayer
	
	WHILE @@FETCH_STATUS=0
		BEGIN
			WHILE @i<=@CalculateQuarter
				BEGIN
					SET @Year=(SELECT FiscalYear FROM #FiscalYearquarter WHERE AutoID=@i)
					SET @Quarter=(SELECT Fiscalquarter FROM #FiscalYearquarter WHERE AutoID=@i)
					SET @DateFrom=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM #TempFiscal WHERE FiscalYear=@Year AND FiscalQuarter=@Quarter) 
					SET @DateTo=  (SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM #TempFiscal WHERE FiscalYear=@Year AND FiscalQuarter=@Quarter) 

					SET @Plant='ZhuHai'
					SET @Amount=dbo.SalesAnalysis_fun_Get_Amount_ASPALCPPL_For_OEM (@Type,'Chi',@Plant,@DatefROM,@DateTo,@OEMCustomerLayer)
					SET @SQLString=dbo.SalesAnalysis_fun_Get_Fiscal_SQL_For_OEMCustomerLayer_String(@Year,@Period,@Site,@Plant,@ReportCode,@Amount,@OEMCustomerLayer)

					EXECUTE (@SQLString)
				SET @i=@i+1
			END
			FETCH NEXT FROM OEMCustomer_C INTO @OEMCustomerLayer
		END
	IF @Type='PPL'
		BEGIN
			UPDATE SalesAnalysis_Amount_Fiscal_OEMCustomerLayer
			SET M1=(CASE WHEN c.M1<>0 THEN b.M1/c.M1*1.0000 ELSE 0 END),
				M2=(CASE WHEN c.M2<>0 THEN b.M2/c.M2*1.0000 ELSE 0 END),
				M3=(CASE WHEN c.M3<>0 THEN b.M3/c.M3*1.0000 ELSE 0 END),
				M4=(CASE WHEN c.M4<>0 THEN b.M4/c.M4*1.0000 ELSE 0 END),
				M5=(CASE WHEN c.M5<>0 THEN b.M5/c.M5*1.0000 ELSE 0 END),
				M6=(CASE WHEN c.M6<>0 THEN b.M6/c.M6*1.0000 ELSE 0 END),
				M7=(CASE WHEN c.M7<>0 THEN b.M7/c.M7*1.0000 ELSE 0 END),
				M8=(CASE WHEN c.M8<>0 THEN b.M8/c.M8*1.0000 ELSE 0 END),
				M9=(CASE WHEN c.M9<>0 THEN b.M9/c.M9*1.0000 ELSE 0 END),
				M10=(CASE WHEN c.M10<>0 THEN b.M10/c.M10*1.0000 ELSE 0 END),
				M11=(CASE WHEN c.M11<>0 THEN b.M11/c.M11*1.0000 ELSE 0 END),
				M12=(CASE WHEN c.M12<>0 THEN b.M12/c.M12*1.0000 ELSE 0 END)
			FROM SalesAnalysis_Amount_Fiscal_OEMCustomerLayer a,
				(SELECT * FROM SalesAnalysis_Amount_Fiscal_OEMCustomerLayer WHERE ReportCode='211') b,
				(SELECT * FROM SalesAnalysis_Amount_Fiscal_OEMCustomerLayer WHERE ReportCode='212') c
			WHERE a.ReportCode='213'
				AND a.Site=b.Site
				AND a.Plant=b.Plant
				AND a.OEMCustomerLayer=b.OEMCustomerLayer
				AND a.Year=b.Year
				AND a.Site=c.Site
				AND a.Plant=c.Plant
				AND a.Year=c.Year
				AND a.OEMCustomerLayer=c.OEMCustomerLayer
		END
END
GO
