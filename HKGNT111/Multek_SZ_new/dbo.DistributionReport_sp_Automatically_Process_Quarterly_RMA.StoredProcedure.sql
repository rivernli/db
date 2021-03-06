USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[DistributionReport_sp_Automatically_Process_Quarterly_RMA]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DistributionReport_sp_Automatically_Process_Quarterly_RMA]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    DECLARE @FiscalYear VARCHAR(4),@FiscalQuarter INT,@FiscalQuarterDesc VARCHAR(50),@FiscalQuarterFrom DATE,@FiscalQuarterTo DATE,@ReportCode VARCHAR(3),@Plant VARCHAR(10),@Amount NUMERIC(18,2),@SQLString VARCHAR(MAX),@AmountFGOut NUMERIC(19,2),@Option VARCHAR(50)
    DECLARE TOPQuarter_C CURSOR FOR
	SELECT TOP 20  FiscalYear,FiscalQuarter,'Quarter 0'+CONVERT(CHAR(1),FiscalQuarter)+' ('+CONVERT(CHAR(10),FiscalQuarterFrom,101)+' - '+CONVERT(CHAR(10),FiscalQuarterTo,101)+')' AS FiscalQuarterDesc,FiscalQuarterFrom,FiscalQuarterTo
	FROM Calendar
	WHERE Calenderdate < CONVERT(VARCHAR(10),GETDATE()-1,120)
	GROUP BY FiscalYear,FiscalQuarter,FiscalQuarterFrom,FiscalQuarterTo
	ORDER BY FiscalYear DESC,FiscalQuarterTo DESC

	OPEN TOPQuarter_C
	FETCH NEXT FROM TOPQuarter_C INTO @Fiscalyear,@FiscalQuarter,@FiscalQuarterDesc,@FiscalQuarterFrom,@FiscalQuarterTo
	
	WHILE @@FETCH_STATUS=0
		BEGIN
			IF @FiscalQuarterTo>CONVERT(VARCHAR(10),DATEADD(DAY,-1,GETDATE()),120)
				BEGIN
					SET @FiscalQuarterTo=CONVERT(VARCHAR(10),DATEADD(DAY,-1,GETDATE()),120)
				END
				
			SET @Plant='B1'
			SET @Option='Lot'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalQuarterFrom,@FiscalQuarterTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Quarterly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalQuarter,@FiscalQuarterDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='Unit'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalQuarterFrom,@FiscalQuarterTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Quarterly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalQuarter,@FiscalQuarterDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='SQFT'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalQuarterFrom,@FiscalQuarterTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Quarterly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalQuarter,@FiscalQuarterDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='Cost'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalQuarterFrom,@FiscalQuarterTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Quarterly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalQuarter,@FiscalQuarterDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='PCB'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalQuarterFrom,@FiscalQuarterTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Quarterly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalQuarter,@FiscalQuarterDesc,@Plant,@Amount)
			EXECUTE (@SQLString)

			SET @Plant='B2F'
			SET @Option='Lot'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalQuarterFrom,@FiscalQuarterTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Quarterly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalQuarter,@FiscalQuarterDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='Unit'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalQuarterFrom,@FiscalQuarterTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Quarterly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalQuarter,@FiscalQuarterDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='SQFT'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalQuarterFrom,@FiscalQuarterTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Quarterly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalQuarter,@FiscalQuarterDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='Cost'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalQuarterFrom,@FiscalQuarterTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Quarterly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalQuarter,@FiscalQuarterDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='PCB'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalQuarterFrom,@FiscalQuarterTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Quarterly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalQuarter,@FiscalQuarterDesc,@Plant,@Amount)
			EXECUTE (@SQLString)

			SET @Plant='B3'
			SET @Option='Lot'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalQuarterFrom,@FiscalQuarterTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Quarterly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalQuarter,@FiscalQuarterDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='Unit'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalQuarterFrom,@FiscalQuarterTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Quarterly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalQuarter,@FiscalQuarterDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='SQFT'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalQuarterFrom,@FiscalQuarterTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Quarterly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalQuarter,@FiscalQuarterDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='Cost'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalQuarterFrom,@FiscalQuarterTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Quarterly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalQuarter,@FiscalQuarterDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='PCB'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalQuarterFrom,@FiscalQuarterTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Quarterly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalQuarter,@FiscalQuarterDesc,@Plant,@Amount)
			EXECUTE (@SQLString)

			SET @Plant='B4'
			SET @Option='Lot'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalQuarterFrom,@FiscalQuarterTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Quarterly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalQuarter,@FiscalQuarterDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='Unit'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalQuarterFrom,@FiscalQuarterTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Quarterly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalQuarter,@FiscalQuarterDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='SQFT'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalQuarterFrom,@FiscalQuarterTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Quarterly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalQuarter,@FiscalQuarterDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='Cost'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalQuarterFrom,@FiscalQuarterTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Quarterly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalQuarter,@FiscalQuarterDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='PCB'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalQuarterFrom,@FiscalQuarterTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Quarterly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalQuarter,@FiscalQuarterDesc,@Plant,@Amount)
			EXECUTE (@SQLString)

			SET @Plant='B5'
			SET @Option='Lot'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalQuarterFrom,@FiscalQuarterTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Quarterly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalQuarter,@FiscalQuarterDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='Unit'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalQuarterFrom,@FiscalQuarterTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Quarterly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalQuarter,@FiscalQuarterDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='SQFT'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalQuarterFrom,@FiscalQuarterTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Quarterly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalQuarter,@FiscalQuarterDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='Cost'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalQuarterFrom,@FiscalQuarterTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Quarterly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalQuarter,@FiscalQuarterDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='PCB'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalQuarterFrom,@FiscalQuarterTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Quarterly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalQuarter,@FiscalQuarterDesc,@Plant,@Amount)
			EXECUTE (@SQLString)

			SET @Plant='VVI'
			SET @Option='Lot'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalQuarterFrom,@FiscalQuarterTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Quarterly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalQuarter,@FiscalQuarterDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='Unit'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalQuarterFrom,@FiscalQuarterTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Quarterly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalQuarter,@FiscalQuarterDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='SQFT'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalQuarterFrom,@FiscalQuarterTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Quarterly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalQuarter,@FiscalQuarterDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='Cost'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalQuarterFrom,@FiscalQuarterTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Quarterly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalQuarter,@FiscalQuarterDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='PCB'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalQuarterFrom,@FiscalQuarterTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Quarterly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalQuarter,@FiscalQuarterDesc,@Plant,@Amount)
			EXECUTE (@SQLString)

			SET @Plant='ZTotal'
			SET @Option='Lot'
			SET @Amount=(SELECT SUM(Lot) FROM DistributionReport_Quarterly_RMA WHERE QuarterDesc=@FiscalQuarterDesc AND Plant<>'ZTotal')
			SET @SQLString=dbo.DistributionReport_fun_Get_Quarterly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalQuarter,@FiscalQuarterDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='Unit'
			SET @Amount=(SELECT SUM(Unit) FROM DistributionReport_Quarterly_RMA WHERE QuarterDesc=@FiscalQuarterDesc AND Plant<>'ZTotal')
			SET @SQLString=dbo.DistributionReport_fun_Get_Quarterly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalQuarter,@FiscalQuarterDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='SQFT'
			SET @Amount=(SELECT SUM(SQFT) FROM DistributionReport_Quarterly_RMA WHERE QuarterDesc=@FiscalQuarterDesc AND Plant<>'ZTotal')
			SET @SQLString=dbo.DistributionReport_fun_Get_Quarterly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalQuarter,@FiscalQuarterDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='Cost'
			SET @Amount=(SELECT SUM(Cost) FROM DistributionReport_Quarterly_RMA WHERE QuarterDesc=@FiscalQuarterDesc AND Plant<>'ZTotal')
			SET @SQLString=dbo.DistributionReport_fun_Get_Quarterly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalQuarter,@FiscalQuarterDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='PCB'
			SET @Amount=(SELECT SUM(PCB) FROM DistributionReport_Quarterly_RMA WHERE QuarterDesc=@FiscalQuarterDesc AND Plant<>'ZTotal')
			SET @SQLString=dbo.DistributionReport_fun_Get_Quarterly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalQuarter,@FiscalQuarterDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
							
			FETCH NEXT FROM TOPQuarter_C INTO @FiscalYear,@FiscalQuarter,@FiscalQuarterDesc,@FiscalQuarterFrom,@FiscalQuarterTo
		END
	CLOSE TOPQuarter_C
	DEALLOCATE TOPQuarter_C

	UPDATE DistributionReport_Quarterly_RMA
	SET PCBA=Cost-PCB,PCBRLP=0
	
END
GO
