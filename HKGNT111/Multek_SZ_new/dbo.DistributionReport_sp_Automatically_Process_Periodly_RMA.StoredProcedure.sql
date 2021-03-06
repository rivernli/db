USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[DistributionReport_sp_Automatically_Process_Periodly_RMA]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DistributionReport_sp_Automatically_Process_Periodly_RMA]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    DECLARE @FiscalYear VARCHAR(4),@FiscalPeriod INT,@FiscalPeriodDesc VARCHAR(50),@FiscalPeriodFrom DATE,@FiscalPeriodTo DATE,@ReportCode VARCHAR(3),@Plant VARCHAR(10),@Amount NUMERIC(18,2),@SQLString VARCHAR(MAX),@AmountFGOut NUMERIC(19,2),@Option VARCHAR(50)
    DECLARE TOPPeriod_C CURSOR FOR
	SELECT TOP 20  FiscalYear,FiscalPeriod,'Period '+(CASE WHEN FiscalPeriod<10 THEN '0' ELSE '' END)+CONVERT(VARCHAR(2),FiscalPeriod)+' ('+CONVERT(CHAR(10),FiscalPeriodFrom,101)+' - '+CONVERT(CHAR(10),FiscalPeriodTo,101)+')' AS FiscalPeriodDesc,FiscalPeriodFrom,FiscalPeriodTo
	FROM Calendar
	WHERE Calenderdate < CONVERT(VARCHAR(10),GETDATE()-1,120)
	GROUP BY FiscalYear,FiscalPeriod,FiscalPeriodFrom,FiscalPeriodTo
	ORDER BY FiscalYear DESC,FiscalPeriodTo DESC

	OPEN TOPPeriod_C
	FETCH NEXT FROM TOPPeriod_C INTO @Fiscalyear,@FiscalPeriod,@FiscalPeriodDesc,@FiscalPeriodFrom,@FiscalPeriodTo
	
	WHILE @@FETCH_STATUS=0
		BEGIN
			IF @FiscalPeriodTo>CONVERT(VARCHAR(10),DATEADD(DAY,-1,GETDATE()),120)
				BEGIN
					SET @FiscalPeriodTo=CONVERT(VARCHAR(10),DATEADD(DAY,-1,GETDATE()),120)
				END
				
			SET @Plant='B1'
			SET @Option='Lot'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalPeriodFrom,@FiscalPeriodTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Periodly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalPeriod,@FiscalPeriodDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='Unit'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalPeriodFrom,@FiscalPeriodTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Periodly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalPeriod,@FiscalPeriodDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='SQFT'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalPeriodFrom,@FiscalPeriodTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Periodly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalPeriod,@FiscalPeriodDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='Cost'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalPeriodFrom,@FiscalPeriodTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Periodly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalPeriod,@FiscalPeriodDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='PCB'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalPeriodFrom,@FiscalPeriodTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Periodly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalPeriod,@FiscalPeriodDesc,@Plant,@Amount)
			EXECUTE (@SQLString)

			SET @Plant='B2F'
			SET @Option='Lot'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalPeriodFrom,@FiscalPeriodTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Periodly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalPeriod,@FiscalPeriodDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='Unit'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalPeriodFrom,@FiscalPeriodTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Periodly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalPeriod,@FiscalPeriodDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='SQFT'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalPeriodFrom,@FiscalPeriodTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Periodly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalPeriod,@FiscalPeriodDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='Cost'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalPeriodFrom,@FiscalPeriodTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Periodly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalPeriod,@FiscalPeriodDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='PCB'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalPeriodFrom,@FiscalPeriodTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Periodly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalPeriod,@FiscalPeriodDesc,@Plant,@Amount)
			EXECUTE (@SQLString)

			SET @Plant='B3'
			SET @Option='Lot'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalPeriodFrom,@FiscalPeriodTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Periodly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalPeriod,@FiscalPeriodDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='Unit'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalPeriodFrom,@FiscalPeriodTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Periodly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalPeriod,@FiscalPeriodDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='SQFT'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalPeriodFrom,@FiscalPeriodTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Periodly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalPeriod,@FiscalPeriodDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='Cost'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalPeriodFrom,@FiscalPeriodTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Periodly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalPeriod,@FiscalPeriodDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='PCB'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalPeriodFrom,@FiscalPeriodTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Periodly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalPeriod,@FiscalPeriodDesc,@Plant,@Amount)
			EXECUTE (@SQLString)

			SET @Plant='B4'
			SET @Option='Lot'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalPeriodFrom,@FiscalPeriodTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Periodly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalPeriod,@FiscalPeriodDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='Unit'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalPeriodFrom,@FiscalPeriodTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Periodly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalPeriod,@FiscalPeriodDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='SQFT'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalPeriodFrom,@FiscalPeriodTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Periodly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalPeriod,@FiscalPeriodDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='Cost'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalPeriodFrom,@FiscalPeriodTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Periodly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalPeriod,@FiscalPeriodDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='PCB'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalPeriodFrom,@FiscalPeriodTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Periodly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalPeriod,@FiscalPeriodDesc,@Plant,@Amount)
			EXECUTE (@SQLString)

			SET @Plant='B5'
			SET @Option='Lot'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalPeriodFrom,@FiscalPeriodTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Periodly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalPeriod,@FiscalPeriodDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='Unit'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalPeriodFrom,@FiscalPeriodTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Periodly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalPeriod,@FiscalPeriodDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='SQFT'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalPeriodFrom,@FiscalPeriodTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Periodly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalPeriod,@FiscalPeriodDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='Cost'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalPeriodFrom,@FiscalPeriodTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Periodly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalPeriod,@FiscalPeriodDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='PCB'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalPeriodFrom,@FiscalPeriodTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Periodly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalPeriod,@FiscalPeriodDesc,@Plant,@Amount)
			EXECUTE (@SQLString)

			SET @Plant='VVI'
			SET @Option='Lot'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalPeriodFrom,@FiscalPeriodTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Periodly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalPeriod,@FiscalPeriodDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='Unit'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalPeriodFrom,@FiscalPeriodTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Periodly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalPeriod,@FiscalPeriodDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='SQFT'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalPeriodFrom,@FiscalPeriodTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Periodly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalPeriod,@FiscalPeriodDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='Cost'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalPeriodFrom,@FiscalPeriodTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Periodly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalPeriod,@FiscalPeriodDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='PCB'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalPeriodFrom,@FiscalPeriodTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Periodly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalPeriod,@FiscalPeriodDesc,@Plant,@Amount)
			EXECUTE (@SQLString)

			SET @Plant='ZTotal'
			SET @Option='Lot'
			SET @Amount=(SELECT SUM(Lot) FROM DistributionReport_Periodly_RMA WHERE PeriodDesc=@FiscalPeriodDesc AND Plant<>'ZTotal')
			SET @SQLString=dbo.DistributionReport_fun_Get_Periodly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalPeriod,@FiscalPeriodDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='Unit'
			SET @Amount=(SELECT SUM(Unit) FROM DistributionReport_Periodly_RMA WHERE PeriodDesc=@FiscalPeriodDesc AND Plant<>'ZTotal')
			SET @SQLString=dbo.DistributionReport_fun_Get_Periodly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalPeriod,@FiscalPeriodDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='SQFT'
			SET @Amount=(SELECT SUM(SQFT) FROM DistributionReport_Periodly_RMA WHERE PeriodDesc=@FiscalPeriodDesc AND Plant<>'ZTotal')
			SET @SQLString=dbo.DistributionReport_fun_Get_Periodly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalPeriod,@FiscalPeriodDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='Cost'
			SET @Amount=(SELECT SUM(Cost) FROM DistributionReport_Periodly_RMA WHERE PeriodDesc=@FiscalPeriodDesc AND Plant<>'ZTotal')
			SET @SQLString=dbo.DistributionReport_fun_Get_Periodly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalPeriod,@FiscalPeriodDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='PCB'
			SET @Amount=(SELECT SUM(PCB) FROM DistributionReport_Periodly_RMA WHERE PeriodDesc=@FiscalPeriodDesc AND Plant<>'ZTotal')
			SET @SQLString=dbo.DistributionReport_fun_Get_Periodly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalPeriod,@FiscalPeriodDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
							
			FETCH NEXT FROM TOPPeriod_C INTO @FiscalYear,@FiscalPeriod,@FiscalPeriodDesc,@FiscalPeriodFrom,@FiscalPeriodTo
		END
	CLOSE TOPPeriod_C
	DEALLOCATE TOPPeriod_C

	UPDATE DistributionReport_Periodly_RMA
	SET PCBA=Cost-PCB,PCBRLP=0
	
END
GO
