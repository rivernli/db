USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[VI_Report_sp_Automatically_Process_Weekly]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- exec [dbo].[VI_Report_sp_Automatically_Process_Weekly]

CREATE PROCEDURE [dbo].[VI_Report_sp_Automatically_Process_Weekly]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    DECLARE @FiscalYear VARCHAR(4),@FiscalWeek INT,@FiscalWeekDesc VARCHAR(50),@FiscalWeekFrom datetime ,@FiscalWeekTo datetime,@ReportCode VARCHAR(3),@Loc VARCHAR(10),@Amount NUMERIC(18,2),@AmountValue NUMERIC(18,2),@SQLString VARCHAR(MAX),@AmountFGOut NUMERIC(19,2)
    DECLARE TOPWeek_C CURSOR FOR

	SELECT TOP 260  FiscalYear,FiscalWeek,'Week '+(CASE WHEN FiscalWeek<10 THEN '0'+CONVERT(CHAR(1),FiscalWeek) ELSE CONVERT(CHAR(2),FiscalWeek) END)+' ('+CONVERT(CHAR(10),FiscalWeekFrom,101)+' - '+CONVERT(CHAR(10),FiscalWeekTo,101)+')' AS FiscalWeekDesc,FiscalWeekFrom,FiscalWeekTo
	FROM DataWarehouse.dbo.DW_DIM_Calender
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

				SET @Loc='Chi'				
				SET @Amount=dbo.VI_Report_fun_Get_Amount(@Loc,@FiscalWeekFrom,@FiscalWeekTo)
				SET @SQLString=dbo.VI_Report_fun_Get_Weekly_Fiscal_SQL_String(@FiscalYear,@FiscalWeek,@FiscalWeekDesc,@Loc,@Amount)
				EXECUTE (@SQLString)

				SET @Loc='Dis'				
				SET @Amount=dbo.VI_Report_fun_Get_Amount(@Loc,@FiscalWeekFrom,@FiscalWeekTo)
				SET @SQLString=dbo.VI_Report_fun_Get_Weekly_Fiscal_SQL_String(@FiscalYear,@FiscalWeek,@FiscalWeekDesc,@Loc,@Amount)
				EXECUTE (@SQLString)

				SET @Loc='Ger'				
				SET @Amount=dbo.VI_Report_fun_Get_Amount(@Loc,@FiscalWeekFrom,@FiscalWeekTo)
				SET @SQLString=dbo.VI_Report_fun_Get_Weekly_Fiscal_SQL_String(@FiscalYear,@FiscalWeek,@FiscalWeekDesc,@Loc,@Amount)
				EXECUTE (@SQLString)

				SET @Loc='Nfd'				
				SET @Amount=dbo.VI_Report_fun_Get_Amount(@Loc,@FiscalWeekFrom,@FiscalWeekTo)
				SET @SQLString=dbo.VI_Report_fun_Get_Weekly_Fiscal_SQL_String(@FiscalYear,@FiscalWeek,@FiscalWeekDesc,@Loc,@Amount)
				EXECUTE (@SQLString)

				SET @Loc='Sao'				
				SET @Amount=dbo.VI_Report_fun_Get_Amount(@Loc,@FiscalWeekFrom,@FiscalWeekTo)
				SET @SQLString=dbo.VI_Report_fun_Get_Weekly_Fiscal_SQL_String(@FiscalYear,@FiscalWeek,@FiscalWeekDesc,@Loc,@Amount)
				EXECUTE (@SQLString)
							
			FETCH NEXT FROM TOPWeek_C INTO @FiscalYear,@FiscalWeek,@FiscalWeekDesc,@FiscalWeekFrom,@FiscalWeekTo
		END
	CLOSE TOPWeek_C
	DEALLOCATE TOPWeek_C
	
END
































GO
