USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[DistributionReport_sp_Automatically_Process_Weekly_RMA]    Script Date: 11/06/2014 15:47:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DistributionReport_sp_Automatically_Process_Weekly_RMA]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    DECLARE @FiscalYear VARCHAR(4),@FiscalWeek INT,@FiscalWeekDesc VARCHAR(50),@FiscalWeekFrom DATE,@FiscalWeekTo DATE,@ReportCode VARCHAR(3),@Plant VARCHAR(10),@Amount NUMERIC(18,2),@SQLString VARCHAR(MAX),@AmountFGOut NUMERIC(19,2),@Option VARCHAR(50)
    DECLARE TOPWeek_C CURSOR FOR
	SELECT TOP 260  FiscalYear,FiscalWeek,'Week '+(CASE WHEN FiscalWeek<10 THEN '0'+CONVERT(CHAR(1),FiscalWeek) ELSE CONVERT(CHAR(2),FiscalWeek) END)+' ('+CONVERT(CHAR(10),FiscalWeekFrom,101)+' - '+CONVERT(CHAR(10),FiscalWeekTo,101)+')' AS FiscalWeekDesc,FiscalWeekFrom,FiscalWeekTo
	FROM Calendar
	WHERE Calenderdate < CONVERT(VARCHAR(10),GETDATE()-1,120)
	GROUP BY FiscalYear,FiscalWeek,FiscalWeekDesc,FiscalWeekFrom,FiscalWeekTo
	ORDER BY FiscalYear DESC,FiscalWeekTo DESC

	OPEN TOPWeek_C
	FETCH NEXT FROM TOPWeek_C INTO @Fiscalyear,@FiscalWeek,@FiscalWeekDesc,@FiscalWeekFrom,@FiscalWeekTo
	
	WHILE @@FETCH_STATUS=0
		BEGIN
			IF @FiscalWeekTo>CONVERT(VARCHAR(10),DATEADD(DAY,-1,GETDATE()),120)
				BEGIN
					SET @FiscalWeekTo=CONVERT(VARCHAR(10),DATEADD(DAY,-1,GETDATE()),120)
				END

			SET @Plant='B1'
			SET @Option='Lot'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalWeekFrom,@FiscalWeekTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Weekly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalWeek,@FiscalWeekDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='Unit'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalWeekFrom,@FiscalWeekTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Weekly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalWeek,@FiscalWeekDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='SQFT'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalWeekFrom,@FiscalWeekTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Weekly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalWeek,@FiscalWeekDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='Cost'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalWeekFrom,@FiscalWeekTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Weekly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalWeek,@FiscalWeekDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='PCB'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalWeekFrom,@FiscalWeekTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Weekly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalWeek,@FiscalWeekDesc,@Plant,@Amount)
			EXECUTE (@SQLString)

			SET @Plant='B2F'
			SET @Option='Lot'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalWeekFrom,@FiscalWeekTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Weekly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalWeek,@FiscalWeekDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='Unit'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalWeekFrom,@FiscalWeekTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Weekly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalWeek,@FiscalWeekDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='SQFT'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalWeekFrom,@FiscalWeekTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Weekly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalWeek,@FiscalWeekDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='Cost'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalWeekFrom,@FiscalWeekTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Weekly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalWeek,@FiscalWeekDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='PCB'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalWeekFrom,@FiscalWeekTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Weekly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalWeek,@FiscalWeekDesc,@Plant,@Amount)
			EXECUTE (@SQLString)

			SET @Plant='B3'
			SET @Option='Lot'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalWeekFrom,@FiscalWeekTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Weekly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalWeek,@FiscalWeekDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='Unit'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalWeekFrom,@FiscalWeekTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Weekly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalWeek,@FiscalWeekDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='SQFT'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalWeekFrom,@FiscalWeekTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Weekly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalWeek,@FiscalWeekDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='Cost'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalWeekFrom,@FiscalWeekTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Weekly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalWeek,@FiscalWeekDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='PCB'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalWeekFrom,@FiscalWeekTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Weekly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalWeek,@FiscalWeekDesc,@Plant,@Amount)
			EXECUTE (@SQLString)

			SET @Plant='B4'
			SET @Option='Lot'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalWeekFrom,@FiscalWeekTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Weekly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalWeek,@FiscalWeekDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='Unit'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalWeekFrom,@FiscalWeekTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Weekly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalWeek,@FiscalWeekDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='SQFT'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalWeekFrom,@FiscalWeekTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Weekly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalWeek,@FiscalWeekDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='Cost'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalWeekFrom,@FiscalWeekTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Weekly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalWeek,@FiscalWeekDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='PCB'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalWeekFrom,@FiscalWeekTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Weekly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalWeek,@FiscalWeekDesc,@Plant,@Amount)
			EXECUTE (@SQLString)

			SET @Plant='B5'
			SET @Option='Lot'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalWeekFrom,@FiscalWeekTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Weekly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalWeek,@FiscalWeekDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='Unit'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalWeekFrom,@FiscalWeekTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Weekly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalWeek,@FiscalWeekDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='SQFT'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalWeekFrom,@FiscalWeekTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Weekly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalWeek,@FiscalWeekDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='Cost'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalWeekFrom,@FiscalWeekTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Weekly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalWeek,@FiscalWeekDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='PCB'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalWeekFrom,@FiscalWeekTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Weekly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalWeek,@FiscalWeekDesc,@Plant,@Amount)
			EXECUTE (@SQLString)

			SET @Plant='VVI'
			SET @Option='Lot'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalWeekFrom,@FiscalWeekTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Weekly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalWeek,@FiscalWeekDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='Unit'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalWeekFrom,@FiscalWeekTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Weekly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalWeek,@FiscalWeekDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='SQFT'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalWeekFrom,@FiscalWeekTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Weekly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalWeek,@FiscalWeekDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='Cost'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalWeekFrom,@FiscalWeekTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Weekly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalWeek,@FiscalWeekDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='PCB'
			SET @Amount=dbo.DistributionReport_fun_Get_RMA_Amount(@Option,@Plant,@FiscalWeekFrom,@FiscalWeekTo)
			SET @SQLString=dbo.DistributionReport_fun_Get_Weekly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalWeek,@FiscalWeekDesc,@Plant,@Amount)
			EXECUTE (@SQLString)

			SET @Plant='ZTotal'
			SET @Option='Lot'
			SET @Amount=(SELECT SUM(Lot) FROM DistributionReport_Weekly_RMA WHERE WeekDesc=@FiscalWeekDesc AND Plant<>'ZTotal')
			SET @SQLString=dbo.DistributionReport_fun_Get_Weekly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalWeek,@FiscalWeekDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='Unit'
			SET @Amount=(SELECT SUM(Unit) FROM DistributionReport_Weekly_RMA WHERE WeekDesc=@FiscalWeekDesc AND Plant<>'ZTotal')
			SET @SQLString=dbo.DistributionReport_fun_Get_Weekly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalWeek,@FiscalWeekDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='SQFT'
			SET @Amount=(SELECT SUM(SQFT) FROM DistributionReport_Weekly_RMA WHERE WeekDesc=@FiscalWeekDesc AND Plant<>'ZTotal')
			SET @SQLString=dbo.DistributionReport_fun_Get_Weekly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalWeek,@FiscalWeekDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='Cost'
			SET @Amount=(SELECT SUM(Cost) FROM DistributionReport_Weekly_RMA WHERE WeekDesc=@FiscalWeekDesc AND Plant<>'ZTotal')
			SET @SQLString=dbo.DistributionReport_fun_Get_Weekly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalWeek,@FiscalWeekDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
			SET @Option='PCB'
			SET @Amount=(SELECT SUM(PCB) FROM DistributionReport_Weekly_RMA WHERE WeekDesc=@FiscalWeekDesc AND Plant<>'ZTotal')
			SET @SQLString=dbo.DistributionReport_fun_Get_Weekly_RMA_Fiscal_SQL_String(@Option,@FiscalYear,@FiscalWeek,@FiscalWeekDesc,@Plant,@Amount)
			EXECUTE (@SQLString)
							
			FETCH NEXT FROM TOPWeek_C INTO @FiscalYear,@FiscalWeek,@FiscalWeekDesc,@FiscalWeekFrom,@FiscalWeekTo
		END
	CLOSE TOPWeek_C
	DEALLOCATE TOPWeek_C

	UPDATE DistributionReport_Weekly_RMA
	SET PCBA=Cost-PCB,PCBRLP=0
	
END
GO
