USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[KOI_sp_Automatically_Process_Weekly_AccidentIncident_Report]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 

CREATE PROCEDURE [dbo].[KOI_sp_Automatically_Process_Weekly_AccidentIncident_Report]
	-- Add the parameters for the stored procedure here
AS
BEGIN

SELECT * INTO #Tmp_PY FROM 
(
	SELECT Plant FROM (
		SELECT Plant FROM KOI_InputByHR
		UNION 
		SELECT Plant FROM KOI_InputByEHS
	) AS T GROUP BY Plant
) AS T1
 JOIN
(
	SELECT FiscalYear+1 AS FiscalYear,FiscalWeek,FiscalWeekFrom, FiscalWeekTo FROM DataWarehouse.dbo.DW_DIM_Calender
	WHERE Calenderdate < CONVERT(VARCHAR(10),GETDATE()-1,120) AND FiscalYear>'2007'
	GROUP BY FiscalYear,FiscalWeek,FiscalWeekFrom, FiscalWeekTo  
) AS T2 
ON 1 =1 


select * into #temp from 
(
select FiscalYear as [Year],FiscalWeek,Plant,
(select ISNULL(SUM(WorkingHours),0) from KOI_InputByHR WHERE KOI_InputByHR.Plant=#Tmp_PY.Plant AND Financey = #Tmp_PY.FiscalYear AND Period in (select FiscalPeriod from DataWarehouse.dbo.DW_DIM_Calender where FiscalYear+1=#Tmp_PY.FiscalYear AND FiscalWeek=#Tmp_PY.FiscalWeek group by FiscalPeriod)) as WorkingHours, 
(select ISNULL(SUM(Incident),0) from KOI_InputByEHS WHERE  KOI_InputByEHS.Plant=#Tmp_PY.Plant AND Date BETWEEN FiscalWeekFrom AND FiscalWeekTo ) as Incident,
(select ISNULL(SUM(First_aid),0) from KOI_InputByEHS WHERE  KOI_InputByEHS.Plant=#Tmp_PY.Plant AND Date BETWEEN FiscalWeekFrom AND FiscalWeekTo ) as First_aid,
(select ISNULL(SUM(Total_Accidents),0) from KOI_InputByEHS WHERE  KOI_InputByEHS.Plant=#Tmp_PY.Plant AND Date BETWEEN FiscalWeekFrom AND FiscalWeekTo ) as Total_Accidents,
(select ISNULL(SUM(Recordable_Accidents),0) from KOI_InputByEHS WHERE  KOI_InputByEHS.Plant=#Tmp_PY.Plant AND Date BETWEEN FiscalWeekFrom AND FiscalWeekTo ) as Recordable_Accidents,
(select ISNULL(SUM(LWD_Accidents),0) from KOI_InputByEHS WHERE  KOI_InputByEHS.Plant=#Tmp_PY.Plant AND Date BETWEEN FiscalWeekFrom AND FiscalWeekTo ) as LWD_Accidents,
(select ISNULL(SUM(Disabled),0) from KOI_InputByEHS WHERE  KOI_InputByEHS.Plant=#Tmp_PY.Plant AND Date BETWEEN FiscalWeekFrom AND FiscalWeekTo ) as Disabled,
(select ISNULL(SUM(Fatal),0) from KOI_InputByEHS WHERE  KOI_InputByEHS.Plant=#Tmp_PY.Plant AND Date BETWEEN FiscalWeekFrom AND FiscalWeekTo ) as Fatal,
(select ISNULL(SUM(Recordable_Accident_Rate),0) from KOI_InputByEHS WHERE  KOI_InputByEHS.Plant=#Tmp_PY.Plant AND Date BETWEEN FiscalWeekFrom AND FiscalWeekTo ) as Recordable_Accident_Rate,
(select ISNULL(SUM(LWD_Accident_Rate),0) from KOI_InputByEHS WHERE  KOI_InputByEHS.Plant=#Tmp_PY.Plant AND Date BETWEEN FiscalWeekFrom AND FiscalWeekTo ) as LWD_Accident_Rate,
(select ISNULL(SUM(Lost_Working_Days),0) from KOI_InputByEHS WHERE  KOI_InputByEHS.Plant=#Tmp_PY.Plant AND Date BETWEEN FiscalWeekFrom AND FiscalWeekTo ) as Lost_Working_Days,
(select ISNULL(SUM(Medical_Expense),0) from KOI_InputByEHS WHERE  KOI_InputByEHS.Plant=#Tmp_PY.Plant AND Date BETWEEN FiscalWeekFrom AND FiscalWeekTo ) as Medical_Expense,
(select ISNULL(SUM(Manpower_Loss),0) from KOI_InputByEHS WHERE  KOI_InputByEHS.Plant=#Tmp_PY.Plant AND Date BETWEEN FiscalWeekFrom AND FiscalWeekTo ) as Manpower_Loss,
(select ISNULL(SUM(Total_Loss),0) from KOI_InputByEHS WHERE  KOI_InputByEHS.Plant=#Tmp_PY.Plant AND Date BETWEEN FiscalWeekFrom AND FiscalWeekTo ) as Total_Loss,
(select ISNULL(SUM(Total_Loss_per_Case),0) from KOI_InputByEHS WHERE  KOI_InputByEHS.Plant=#Tmp_PY.Plant AND Date BETWEEN FiscalWeekFrom AND FiscalWeekTo ) as Total_Loss_per_Case,
(select ISNULL(SUM(Severity_Rate),0) from KOI_InputByEHS WHERE  KOI_InputByEHS.Plant=#Tmp_PY.Plant AND Date BETWEEN FiscalWeekFrom AND FiscalWeekTo ) as Severity_Rate,
(select ISNULL(SUM(Injury_Rate_per_200k_WH),0) from KOI_InputByEHS WHERE  KOI_InputByEHS.Plant=#Tmp_PY.Plant AND Date BETWEEN FiscalWeekFrom AND FiscalWeekTo ) as Injury_Rate_per_200k_WH  
from #Tmp_PY 
UNION ALL 
select FiscalYear as [Year],FiscalWeek,'All' as Plant,
(select ISNULL(SUM(WorkingHours),0) from KOI_InputByHR WHERE Financey = #Tmp_PY.FiscalYear AND Period in (select FiscalPeriod from DataWarehouse.dbo.DW_DIM_Calender where FiscalYear+1=#Tmp_PY.FiscalYear AND FiscalWeek=#Tmp_PY.FiscalWeek group by FiscalPeriod)) as WorkingHours, 
(select ISNULL(SUM(Incident),0) from KOI_InputByEHS WHERE Date BETWEEN FiscalWeekFrom AND FiscalWeekTo ) as Incident,
(select ISNULL(SUM(First_aid),0) from KOI_InputByEHS WHERE Date BETWEEN FiscalWeekFrom AND FiscalWeekTo ) as First_aid,
(select ISNULL(SUM(Total_Accidents),0) from KOI_InputByEHS WHERE Date BETWEEN FiscalWeekFrom AND FiscalWeekTo ) as Total_Accidents,
(select ISNULL(SUM(Recordable_Accidents),0) from KOI_InputByEHS WHERE Date BETWEEN FiscalWeekFrom AND FiscalWeekTo ) as Recordable_Accidents,
(select ISNULL(SUM(LWD_Accidents),0) from KOI_InputByEHS WHERE Date BETWEEN FiscalWeekFrom AND FiscalWeekTo ) as LWD_Accidents,
(select ISNULL(SUM(Disabled),0) from KOI_InputByEHS WHERE Date BETWEEN FiscalWeekFrom AND FiscalWeekTo ) as Disabled,
(select ISNULL(SUM(Fatal),0) from KOI_InputByEHS WHERE Date BETWEEN FiscalWeekFrom AND FiscalWeekTo ) as Fatal,
(select ISNULL(SUM(Recordable_Accident_Rate),0) from KOI_InputByEHS WHERE Date BETWEEN FiscalWeekFrom AND FiscalWeekTo ) as Recordable_Accident_Rate,
(select ISNULL(SUM(LWD_Accident_Rate),0) from KOI_InputByEHS WHERE Date BETWEEN FiscalWeekFrom AND FiscalWeekTo ) as LWD_Accident_Rate,
(select ISNULL(SUM(Lost_Working_Days),0) from KOI_InputByEHS WHERE Date BETWEEN FiscalWeekFrom AND FiscalWeekTo ) as Lost_Working_Days,
(select ISNULL(SUM(Medical_Expense),0) from KOI_InputByEHS WHERE Date BETWEEN FiscalWeekFrom AND FiscalWeekTo ) as Medical_Expense,
(select ISNULL(SUM(Manpower_Loss),0) from KOI_InputByEHS WHERE Date BETWEEN FiscalWeekFrom AND FiscalWeekTo ) as Manpower_Loss,
(select ISNULL(SUM(Total_Loss),0) from KOI_InputByEHS WHERE Date BETWEEN FiscalWeekFrom AND FiscalWeekTo ) as Total_Loss,
(select ISNULL(SUM(Total_Loss_per_Case),0) from KOI_InputByEHS WHERE Date BETWEEN FiscalWeekFrom AND FiscalWeekTo ) as Total_Loss_per_Case,
(select ISNULL(SUM(Severity_Rate),0) from KOI_InputByEHS WHERE Date BETWEEN FiscalWeekFrom AND FiscalWeekTo ) as Severity_Rate,
(select ISNULL(SUM(Injury_Rate_per_200k_WH),0) from KOI_InputByEHS WHERE Date BETWEEN FiscalWeekFrom AND FiscalWeekTo ) as Injury_Rate_per_200k_WH  
from #Tmp_PY group by FiscalYear,FiscalWeek,FiscalWeekFrom,FiscalWeekTo
UNION ALL 
select FiscalYear as [Year],FiscalWeek,'Allexclude2F' as Plant,
(select ISNULL(SUM(WorkingHours),0) from KOI_InputByHR WHERE KOI_InputByHR.Plant<>'2F' AND Financey = #Tmp_PY.FiscalYear AND Period in (select FiscalPeriod from DataWarehouse.dbo.DW_DIM_Calender where FiscalYear+1=#Tmp_PY.FiscalYear AND FiscalWeek=#Tmp_PY.FiscalWeek group by FiscalPeriod)) as WorkingHours, 
(select ISNULL(SUM(Incident),0) from KOI_InputByEHS WHERE  KOI_InputByEHS.Plant<>'2F' AND Date BETWEEN FiscalWeekFrom AND FiscalWeekTo ) as Incident,
(select ISNULL(SUM(First_aid),0) from KOI_InputByEHS WHERE  KOI_InputByEHS.Plant<>'2F' AND Date BETWEEN FiscalWeekFrom AND FiscalWeekTo ) as First_aid,
(select ISNULL(SUM(Total_Accidents),0) from KOI_InputByEHS WHERE  KOI_InputByEHS.Plant<>'2F' AND Date BETWEEN FiscalWeekFrom AND FiscalWeekTo ) as Total_Accidents,
(select ISNULL(SUM(Recordable_Accidents),0) from KOI_InputByEHS WHERE  KOI_InputByEHS.Plant<>'2F' AND Date BETWEEN FiscalWeekFrom AND FiscalWeekTo ) as Recordable_Accidents,
(select ISNULL(SUM(LWD_Accidents),0) from KOI_InputByEHS WHERE  KOI_InputByEHS.Plant<>'2F' AND Date BETWEEN FiscalWeekFrom AND FiscalWeekTo ) as LWD_Accidents,
(select ISNULL(SUM(Disabled),0) from KOI_InputByEHS WHERE  KOI_InputByEHS.Plant<>'2F' AND Date BETWEEN FiscalWeekFrom AND FiscalWeekTo ) as Disabled,
(select ISNULL(SUM(Fatal),0) from KOI_InputByEHS WHERE  KOI_InputByEHS.Plant<>'2F' AND Date BETWEEN FiscalWeekFrom AND FiscalWeekTo ) as Fatal,
(select ISNULL(SUM(Recordable_Accident_Rate),0) from KOI_InputByEHS WHERE  KOI_InputByEHS.Plant<>'2F' AND Date BETWEEN FiscalWeekFrom AND FiscalWeekTo ) as Recordable_Accident_Rate,
(select ISNULL(SUM(LWD_Accident_Rate),0) from KOI_InputByEHS WHERE  KOI_InputByEHS.Plant<>'2F' AND Date BETWEEN FiscalWeekFrom AND FiscalWeekTo ) as LWD_Accident_Rate,
(select ISNULL(SUM(Lost_Working_Days),0) from KOI_InputByEHS WHERE  KOI_InputByEHS.Plant<>'2F' AND Date BETWEEN FiscalWeekFrom AND FiscalWeekTo ) as Lost_Working_Days,
(select ISNULL(SUM(Medical_Expense),0) from KOI_InputByEHS WHERE  KOI_InputByEHS.Plant<>'2F' AND Date BETWEEN FiscalWeekFrom AND FiscalWeekTo ) as Medical_Expense,
(select ISNULL(SUM(Manpower_Loss),0) from KOI_InputByEHS WHERE  KOI_InputByEHS.Plant<>'2F' AND Date BETWEEN FiscalWeekFrom AND FiscalWeekTo ) as Manpower_Loss,
(select ISNULL(SUM(Total_Loss),0) from KOI_InputByEHS WHERE  KOI_InputByEHS.Plant<>'2F' AND Date BETWEEN FiscalWeekFrom AND FiscalWeekTo ) as Total_Loss,
(select ISNULL(SUM(Total_Loss_per_Case),0) from KOI_InputByEHS WHERE  KOI_InputByEHS.Plant<>'2F' AND Date BETWEEN FiscalWeekFrom AND FiscalWeekTo ) as Total_Loss_per_Case,
(select ISNULL(SUM(Severity_Rate),0) from KOI_InputByEHS WHERE  KOI_InputByEHS.Plant<>'2F' AND Date BETWEEN FiscalWeekFrom AND FiscalWeekTo ) as Severity_Rate,
(select ISNULL(SUM(Injury_Rate_per_200k_WH),0) from KOI_InputByEHS WHERE  KOI_InputByEHS.Plant<>'2F' AND Date BETWEEN FiscalWeekFrom AND FiscalWeekTo ) as Injury_Rate_per_200k_WH  
from #Tmp_PY group by FiscalYear,FiscalWeek,FiscalWeekFrom,FiscalWeekTo 
) as tb 


--update
UPDATE KOI_Weekly_AccidentIncident_Report SET WorkingHours=b.WorkingHours,Incident=b.Incident,First_aid=b.First_aid,Total_Accidents=b.Total_Accidents,Recordable_Accidents=b.Recordable_Accidents,
LWD_Accidents=b.LWD_Accidents,Disabled=b.Disabled,Fatal=b.Fatal, Recordable_Accident_Rate=b.Recordable_Accident_Rate,LWD_Accident_Rate=b.LWD_Accident_Rate,Lost_Working_Days=b.Lost_Working_Days,
Medical_Expense=b.Medical_Expense,Manpower_Loss=b.Manpower_Loss,Total_Loss=b.Total_Loss,Total_Loss_per_Case=b.Total_Loss_per_Case,Severity_Rate=b.Severity_Rate,Injury_Rate_per_200k_WH=b.Injury_Rate_per_200k_WH 
from #temp b 
WHERE KOI_Weekly_AccidentIncident_Report.[Year]=b.[Year] AND KOI_Weekly_AccidentIncident_Report.Week=b.FiscalWeek AND KOI_Weekly_AccidentIncident_Report.Plant=b.Plant 

--insert
INSERT INTO KOI_Weekly_AccidentIncident_Report ([Year],Week,Plant,WorkingHours,Incident,First_aid,Total_Accidents,Recordable_Accidents,
LWD_Accidents,Disabled,Fatal, Recordable_Accident_Rate,LWD_Accident_Rate,Lost_Working_Days,
Medical_Expense,Manpower_Loss,Total_Loss,Total_Loss_per_Case,Severity_Rate,Injury_Rate_per_200k_WH)
SELECT * FROM #temp a WHERE not EXISTS (SELECT * FROM KOI_Weekly_AccidentIncident_Report b WHERE a.[Year]=b.[Year] AND a.FiscalWeek=b.Week  AND a.Plant=b.Plant) 


drop table #Tmp_PY 
drop table #temp 


	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
--	SET NOCOUNT ON;
--
--    -- Insert statements for procedure here
--    DECLARE @FiscalYear VARCHAR(4),@FiscalWeek INT,@FiscalWeekFrom VARCHAR(20),@FiscalWeekTo VARCHAR(20),@Plant VARCHAR(20),@SQLString VARCHAR(MAX) 
--	DECLARE @WorkingHours NUMERIC(18,2),@Incident NUMERIC(18,2),@First_aid NUMERIC(18,2),@Total_Accidents NUMERIC(18,2),@Recordable_Accidents NUMERIC(18,2)
--	DECLARE @LWD_Accidents NUMERIC(18,2),@Disabled NUMERIC(18,2),@Fatal NUMERIC(18,2),@Recordable_Accident_Rate NUMERIC(18,2),@LWD_Accident_Rate NUMERIC(18,2)
--	DECLARE @Lost_Working_Days NUMERIC(18,2),@Medical_Expense NUMERIC(18,2),@Manpower_Loss NUMERIC(18,2),@Total_Loss NUMERIC(18,2),@Total_Loss_per_Case NUMERIC(18,2)
--	DECLARE @Severity_Rate NUMERIC(18,2),@Injury_Rate_per_200k_WH NUMERIC(18,2) 
--
--    DECLARE AccidentIncident_Week_C CURSOR FOR
--	SELECT FiscalYear+1 AS FiscalYear,FiscalWeek, CONVERT(varchar(12),FiscalWeekFrom,23) as FiscalWeekFrom,CONVERT(varchar(12),FiscalWeekTo,23) as FiscalWeekTo 
--	FROM DataWarehouse.dbo.DW_DIM_Calender 
--	WHERE Calenderdate < CONVERT(VARCHAR(10),GETDATE()-1,120) AND FiscalYear>'2007'
--	GROUP BY FiscalYear,FiscalWeek,FiscalWeekFrom,FiscalWeekTo
--	ORDER BY FiscalYear DESC,FiscalWeekTo DESC
--
--	OPEN AccidentIncident_Week_C
--	FETCH NEXT FROM AccidentIncident_Week_C INTO @Fiscalyear,@FiscalWeek,@FiscalWeekFrom,@FiscalWeekTo
--	
--	WHILE @@FETCH_STATUS=0
--		BEGIN
--			IF @FiscalWeekTo>CONVERT(VARCHAR(10),DATEADD(DAY,-1,GETDATE()),120)
--				BEGIN
--					SET @FiscalWeekTo=CONVERT(VARCHAR(10),DATEADD(DAY,-1,GETDATE()),120)
--				END
--				
--			SET @Plant='B1'	
--				SET @WorkingHours=(select ISNULL(SUM(WorkingHours),0) from KOI_InputByHR WHERE Period IN (select FiscalPeriod FROM DataWarehouse.dbo.DW_DIM_Calender where FiscalYear+1=@FiscalYear and FiscalWeek=@FiscalWeek) AND Plant=@Plant AND Financey = @FiscalYear)										
--				SET @Incident=(select ISNULL(SUM(Incident),0) from KOI_InputByEHS WHERE  Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )
--				SET @First_aid=(select ISNULL(SUM(First_aid),0) from KOI_InputByEHS WHERE  Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )
--				SET @Total_Accidents=(select ISNULL(SUM(Total_Accidents),0) from KOI_InputByEHS WHERE Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )				
--				SET @Recordable_Accidents=(select ISNULL(SUM(Recordable_Accidents),0) from KOI_InputByEHS WHERE Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )				
--				SET @LWD_Accidents=(select ISNULL(SUM(LWD_Accidents),0) from KOI_InputByEHS WHERE Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )				
--				SET @Disabled=(select ISNULL(SUM(Disabled),0) from KOI_InputByEHS WHERE Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )				
--				SET @Fatal=(select ISNULL(SUM(Fatal),0) from KOI_InputByEHS WHERE Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )				
--				SET @Recordable_Accident_Rate=(select ISNULL(SUM(Recordable_Accident_Rate),0) from KOI_InputByEHS WHERE Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )				
--				SET @LWD_Accident_Rate=(select ISNULL(SUM(LWD_Accident_Rate),0) from KOI_InputByEHS WHERE Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )				
--				SET @Lost_Working_Days=(select ISNULL(SUM(Lost_Working_Days),0) from KOI_InputByEHS WHERE Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )				
--				SET @Medical_Expense=(select ISNULL(SUM(Medical_Expense),0) from KOI_InputByEHS WHERE Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )				
--				SET @Manpower_Loss=(select ISNULL(SUM(Manpower_Loss),0) from KOI_InputByEHS WHERE Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )				
--				SET @Total_Loss=(select ISNULL(SUM(Total_Loss),0) from KOI_InputByEHS WHERE Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )				
--				SET @Total_Loss_per_Case=(select ISNULL(SUM(Total_Loss_per_Case),0) from KOI_InputByEHS WHERE Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )				
--				SET @Severity_Rate=(select ISNULL(SUM(Severity_Rate),0) from KOI_InputByEHS WHERE Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )				
--				SET @Injury_Rate_per_200k_WH=(select ISNULL(SUM(Injury_Rate_per_200k_WH),0) from KOI_InputByEHS WHERE Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )
--
--				SET @SQLString=dbo.KOI_fun_Get_Weekly_AccidentIncident_Report_SQL_String
--						(
--							@FiscalYear,@FiscalWeek,@Plant,@WorkingHours,@Incident,@First_aid,@Total_Accidents,@Recordable_Accidents,@LWD_Accidents,@Disabled,
--							@Fatal,@Recordable_Accident_Rate,@LWD_Accident_Rate,@Lost_Working_Days,@Medical_Expense,@Manpower_Loss,@Total_Loss,
--							@Total_Loss_per_Case,@Severity_Rate,@Injury_Rate_per_200k_WH 
--						)
--				EXECUTE (@SQLString)
--
--			
--			SET @Plant='B2F'				
--				SET @WorkingHours=(select ISNULL(SUM(WorkingHours),0) from KOI_InputByHR WHERE Period IN (select FiscalPeriod FROM DataWarehouse.dbo.DW_DIM_Calender where FiscalYear+1=@FiscalYear and FiscalWeek=@FiscalWeek) AND Plant=@Plant AND Financey = @FiscalYear)	
--				SET @Incident=(select ISNULL(SUM(Incident),0) from KOI_InputByEHS WHERE  Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )
--				SET @First_aid=(select ISNULL(SUM(First_aid),0) from KOI_InputByEHS WHERE  Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )
--				SET @Total_Accidents=(select ISNULL(SUM(Total_Accidents),0) from KOI_InputByEHS WHERE Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )				
--				SET @Recordable_Accidents=(select ISNULL(SUM(Recordable_Accidents),0) from KOI_InputByEHS WHERE Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )				
--				SET @LWD_Accidents=(select ISNULL(SUM(LWD_Accidents),0) from KOI_InputByEHS WHERE Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )				
--				SET @Disabled=(select ISNULL(SUM(Disabled),0) from KOI_InputByEHS WHERE Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )				
--				SET @Fatal=(select ISNULL(SUM(Fatal),0) from KOI_InputByEHS WHERE Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )				
--				SET @Recordable_Accident_Rate=(select ISNULL(SUM(Recordable_Accident_Rate),0) from KOI_InputByEHS WHERE Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )				
--				SET @LWD_Accident_Rate=(select ISNULL(SUM(LWD_Accident_Rate),0) from KOI_InputByEHS WHERE Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )				
--				SET @Lost_Working_Days=(select ISNULL(SUM(Lost_Working_Days),0) from KOI_InputByEHS WHERE Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )				
--				SET @Medical_Expense=(select ISNULL(SUM(Medical_Expense),0) from KOI_InputByEHS WHERE Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )				
--				SET @Manpower_Loss=(select ISNULL(SUM(Manpower_Loss),0) from KOI_InputByEHS WHERE Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )				
--				SET @Total_Loss=(select ISNULL(SUM(Total_Loss),0) from KOI_InputByEHS WHERE Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )				
--				SET @Total_Loss_per_Case=(select ISNULL(SUM(Total_Loss_per_Case),0) from KOI_InputByEHS WHERE Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )				
--				SET @Severity_Rate=(select ISNULL(SUM(Severity_Rate),0) from KOI_InputByEHS WHERE Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )				
--				SET @Injury_Rate_per_200k_WH=(select ISNULL(SUM(Injury_Rate_per_200k_WH),0) from KOI_InputByEHS WHERE Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )
--
--				SET @SQLString=dbo.KOI_fun_Get_Weekly_AccidentIncident_Report_SQL_String
--						(
--							@FiscalYear,@FiscalWeek,@Plant,@WorkingHours,@Incident,@First_aid,@Total_Accidents,@Recordable_Accidents,@LWD_Accidents,@Disabled,
--							@Fatal,@Recordable_Accident_Rate,@LWD_Accident_Rate,@Lost_Working_Days,@Medical_Expense,@Manpower_Loss,@Total_Loss,
--							@Total_Loss_per_Case,@Severity_Rate,@Injury_Rate_per_200k_WH 
--						)
--				EXECUTE (@SQLString)
--
--			SET @Plant='B3'			
--				SET @WorkingHours=(select ISNULL(SUM(WorkingHours),0) from KOI_InputByHR WHERE Period IN (select FiscalPeriod FROM DataWarehouse.dbo.DW_DIM_Calender where FiscalYear+1=@FiscalYear and FiscalWeek=@FiscalWeek) AND Plant=@Plant AND Financey = @FiscalYear)	
--				SET @Incident=(select ISNULL(SUM(Incident),0) from KOI_InputByEHS WHERE  Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )
--				SET @First_aid=(select ISNULL(SUM(First_aid),0) from KOI_InputByEHS WHERE  Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )
--				SET @Total_Accidents=(select ISNULL(SUM(Total_Accidents),0) from KOI_InputByEHS WHERE Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )				
--				SET @Recordable_Accidents=(select ISNULL(SUM(Recordable_Accidents),0) from KOI_InputByEHS WHERE Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )				
--				SET @LWD_Accidents=(select ISNULL(SUM(LWD_Accidents),0) from KOI_InputByEHS WHERE Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )				
--				SET @Disabled=(select ISNULL(SUM(Disabled),0) from KOI_InputByEHS WHERE Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )				
--				SET @Fatal=(select ISNULL(SUM(Fatal),0) from KOI_InputByEHS WHERE Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )				
--				SET @Recordable_Accident_Rate=(select ISNULL(SUM(Recordable_Accident_Rate),0) from KOI_InputByEHS WHERE Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )				
--				SET @LWD_Accident_Rate=(select ISNULL(SUM(LWD_Accident_Rate),0) from KOI_InputByEHS WHERE Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )				
--				SET @Lost_Working_Days=(select ISNULL(SUM(Lost_Working_Days),0) from KOI_InputByEHS WHERE Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )				
--				SET @Medical_Expense=(select ISNULL(SUM(Medical_Expense),0) from KOI_InputByEHS WHERE Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )				
--				SET @Manpower_Loss=(select ISNULL(SUM(Manpower_Loss),0) from KOI_InputByEHS WHERE Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )				
--				SET @Total_Loss=(select ISNULL(SUM(Total_Loss),0) from KOI_InputByEHS WHERE Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )				
--				SET @Total_Loss_per_Case=(select ISNULL(SUM(Total_Loss_per_Case),0) from KOI_InputByEHS WHERE Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )				
--				SET @Severity_Rate=(select ISNULL(SUM(Severity_Rate),0) from KOI_InputByEHS WHERE Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )				
--				SET @Injury_Rate_per_200k_WH=(select ISNULL(SUM(Injury_Rate_per_200k_WH),0) from KOI_InputByEHS WHERE Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )
--
--				SET @SQLString=dbo.KOI_fun_Get_Weekly_AccidentIncident_Report_SQL_String
--						(
--							@FiscalYear,@FiscalWeek,@Plant,@WorkingHours,@Incident,@First_aid,@Total_Accidents,@Recordable_Accidents,@LWD_Accidents,@Disabled,
--							@Fatal,@Recordable_Accident_Rate,@LWD_Accident_Rate,@Lost_Working_Days,@Medical_Expense,@Manpower_Loss,@Total_Loss,
--							@Total_Loss_per_Case,@Severity_Rate,@Injury_Rate_per_200k_WH 
--						)
--				EXECUTE (@SQLString)
--
--			SET @Plant='B4'			
--				SET @WorkingHours=(select ISNULL(SUM(WorkingHours),0) from KOI_InputByHR WHERE Period IN (select FiscalPeriod FROM DataWarehouse.dbo.DW_DIM_Calender where FiscalYear+1=@FiscalYear and FiscalWeek=@FiscalWeek) AND Plant=@Plant AND Financey = @FiscalYear)	
--				SET @Incident=(select ISNULL(SUM(Incident),0) from KOI_InputByEHS WHERE  Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )
--				SET @First_aid=(select ISNULL(SUM(First_aid),0) from KOI_InputByEHS WHERE  Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )
--				SET @Total_Accidents=(select ISNULL(SUM(Total_Accidents),0) from KOI_InputByEHS WHERE Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )				
--				SET @Recordable_Accidents=(select ISNULL(SUM(Recordable_Accidents),0) from KOI_InputByEHS WHERE Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )				
--				SET @LWD_Accidents=(select ISNULL(SUM(LWD_Accidents),0) from KOI_InputByEHS WHERE Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )				
--				SET @Disabled=(select ISNULL(SUM(Disabled),0) from KOI_InputByEHS WHERE Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )				
--				SET @Fatal=(select ISNULL(SUM(Fatal),0) from KOI_InputByEHS WHERE Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )				
--				SET @Recordable_Accident_Rate=(select ISNULL(SUM(Recordable_Accident_Rate),0) from KOI_InputByEHS WHERE Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )				
--				SET @LWD_Accident_Rate=(select ISNULL(SUM(LWD_Accident_Rate),0) from KOI_InputByEHS WHERE Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )				
--				SET @Lost_Working_Days=(select ISNULL(SUM(Lost_Working_Days),0) from KOI_InputByEHS WHERE Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )				
--				SET @Medical_Expense=(select ISNULL(SUM(Medical_Expense),0) from KOI_InputByEHS WHERE Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )				
--				SET @Manpower_Loss=(select ISNULL(SUM(Manpower_Loss),0) from KOI_InputByEHS WHERE Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )				
--				SET @Total_Loss=(select ISNULL(SUM(Total_Loss),0) from KOI_InputByEHS WHERE Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )				
--				SET @Total_Loss_per_Case=(select ISNULL(SUM(Total_Loss_per_Case),0) from KOI_InputByEHS WHERE Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )				
--				SET @Severity_Rate=(select ISNULL(SUM(Severity_Rate),0) from KOI_InputByEHS WHERE Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )				
--				SET @Injury_Rate_per_200k_WH=(select ISNULL(SUM(Injury_Rate_per_200k_WH),0) from KOI_InputByEHS WHERE Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )
--
--				SET @SQLString=dbo.KOI_fun_Get_Weekly_AccidentIncident_Report_SQL_String
--						(
--							@FiscalYear,@FiscalWeek,@Plant,@WorkingHours,@Incident,@First_aid,@Total_Accidents,@Recordable_Accidents,@LWD_Accidents,@Disabled,
--							@Fatal,@Recordable_Accident_Rate,@LWD_Accident_Rate,@Lost_Working_Days,@Medical_Expense,@Manpower_Loss,@Total_Loss,
--							@Total_Loss_per_Case,@Severity_Rate,@Injury_Rate_per_200k_WH 
--						)
--				EXECUTE (@SQLString)
--
--			SET @Plant='B5'				
--				SET @WorkingHours=(select ISNULL(SUM(WorkingHours),0) from KOI_InputByHR WHERE Period IN (select FiscalPeriod FROM DataWarehouse.dbo.DW_DIM_Calender where FiscalYear+1=@FiscalYear and FiscalWeek=@FiscalWeek) AND Plant=@Plant AND Financey = @FiscalYear)	
--				SET @Incident=(select ISNULL(SUM(Incident),0) from KOI_InputByEHS WHERE  Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )
--				SET @First_aid=(select ISNULL(SUM(First_aid),0) from KOI_InputByEHS WHERE  Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )
--				SET @Total_Accidents=(select ISNULL(SUM(Total_Accidents),0) from KOI_InputByEHS WHERE Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )				
--				SET @Recordable_Accidents=(select ISNULL(SUM(Recordable_Accidents),0) from KOI_InputByEHS WHERE Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )				
--				SET @LWD_Accidents=(select ISNULL(SUM(LWD_Accidents),0) from KOI_InputByEHS WHERE Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )				
--				SET @Disabled=(select ISNULL(SUM(Disabled),0) from KOI_InputByEHS WHERE Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )				
--				SET @Fatal=(select ISNULL(SUM(Fatal),0) from KOI_InputByEHS WHERE Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )				
--				SET @Recordable_Accident_Rate=(select ISNULL(SUM(Recordable_Accident_Rate),0) from KOI_InputByEHS WHERE Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )				
--				SET @LWD_Accident_Rate=(select ISNULL(SUM(LWD_Accident_Rate),0) from KOI_InputByEHS WHERE Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )				
--				SET @Lost_Working_Days=(select ISNULL(SUM(Lost_Working_Days),0) from KOI_InputByEHS WHERE Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )				
--				SET @Medical_Expense=(select ISNULL(SUM(Medical_Expense),0) from KOI_InputByEHS WHERE Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )				
--				SET @Manpower_Loss=(select ISNULL(SUM(Manpower_Loss),0) from KOI_InputByEHS WHERE Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )				
--				SET @Total_Loss=(select ISNULL(SUM(Total_Loss),0) from KOI_InputByEHS WHERE Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )				
--				SET @Total_Loss_per_Case=(select ISNULL(SUM(Total_Loss_per_Case),0) from KOI_InputByEHS WHERE Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )				
--				SET @Severity_Rate=(select ISNULL(SUM(Severity_Rate),0) from KOI_InputByEHS WHERE Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )				
--				SET @Injury_Rate_per_200k_WH=(select ISNULL(SUM(Injury_Rate_per_200k_WH),0) from KOI_InputByEHS WHERE Plant=@Plant AND Date BETWEEN @FiscalWeekFrom AND @FiscalWeekTo )
--
--				SET @SQLString=dbo.KOI_fun_Get_Weekly_AccidentIncident_Report_SQL_String
--						(
--							@FiscalYear,@FiscalWeek,@Plant,@WorkingHours,@Incident,@First_aid,@Total_Accidents,@Recordable_Accidents,@LWD_Accidents,@Disabled,
--							@Fatal,@Recordable_Accident_Rate,@LWD_Accident_Rate,@Lost_Working_Days,@Medical_Expense,@Manpower_Loss,@Total_Loss,
--							@Total_Loss_per_Case,@Severity_Rate,@Injury_Rate_per_200k_WH 
--						)
--				EXECUTE (@SQLString)
--
--			SET @Plant='All'
--				SET @WorkingHours=(select ISNULL(SUM(WorkingHours),0) from KOI_Weekly_AccidentIncident_Report WHERE Plant<>'All' AND Plant<>'Allexclude2F' AND [Year] = @FiscalYear AND Week=@FiscalWeek)
--				SET @Incident=(select ISNULL(SUM(Incident),0) from KOI_Weekly_AccidentIncident_Report WHERE Plant<>'All' AND Plant<>'Allexclude2F' AND [Year] = @FiscalYear AND Week=@FiscalWeek)
--				SET @First_aid=(select ISNULL(SUM(First_aid),0) from KOI_Weekly_AccidentIncident_Report WHERE Plant<>'All' AND Plant<>'Allexclude2F' AND [Year] = @FiscalYear AND Week=@FiscalWeek)
--				SET @Total_Accidents=(select ISNULL(SUM(Total_Accidents),0) from KOI_Weekly_AccidentIncident_Report WHERE Plant<>'All' AND Plant<>'Allexclude2F' AND [Year] = @FiscalYear AND Week=@FiscalWeek)
--				SET @Recordable_Accidents=(select ISNULL(SUM(Recordable_Accidents),0) from KOI_Weekly_AccidentIncident_Report WHERE Plant<>'All' AND Plant<>'Allexclude2F' AND [Year] = @FiscalYear AND Week=@FiscalWeek)	
--				SET @LWD_Accidents=(select ISNULL(SUM(LWD_Accidents),0) from KOI_Weekly_AccidentIncident_Report WHERE Plant<>'All' AND Plant<>'Allexclude2F' AND [Year] = @FiscalYear AND Week=@FiscalWeek)
--				SET @Disabled=(select ISNULL(SUM(Disabled),0) from KOI_Weekly_AccidentIncident_Report WHERE Plant<>'All' AND Plant<>'Allexclude2F' AND [Year] = @FiscalYear AND Week=@FiscalWeek)
--				SET @Fatal=(select ISNULL(SUM(Fatal),0) from KOI_Weekly_AccidentIncident_Report WHERE Plant<>'All' AND Plant<>'Allexclude2F' AND [Year] = @FiscalYear AND Week=@FiscalWeek)	
--				SET @Recordable_Accident_Rate=(select ISNULL(SUM(Recordable_Accident_Rate),0) from KOI_Weekly_AccidentIncident_Report WHERE Plant<>'All' AND Plant<>'Allexclude2F' AND [Year] = @FiscalYear AND Week=@FiscalWeek)	
--				SET @LWD_Accident_Rate=(select ISNULL(SUM(LWD_Accident_Rate),0) from KOI_Weekly_AccidentIncident_Report WHERE Plant<>'All' AND Plant<>'Allexclude2F' AND [Year] = @FiscalYear AND Week=@FiscalWeek)
--				SET @Lost_Working_Days=(select ISNULL(SUM(Lost_Working_Days),0) from KOI_Weekly_AccidentIncident_Report WHERE Plant<>'All' AND Plant<>'Allexclude2F' AND [Year] = @FiscalYear AND Week=@FiscalWeek)
--				SET @Medical_Expense=(select ISNULL(SUM(Medical_Expense),0) from KOI_Weekly_AccidentIncident_Report WHERE Plant<>'All' AND Plant<>'Allexclude2F' AND [Year] = @FiscalYear AND Week=@FiscalWeek)		
--				SET @Manpower_Loss=(select ISNULL(SUM(Manpower_Loss),0) from KOI_Weekly_AccidentIncident_Report WHERE Plant<>'All' AND Plant<>'Allexclude2F' AND [Year] = @FiscalYear AND Week=@FiscalWeek)
--				SET @Total_Loss=(select ISNULL(SUM(Total_Loss),0) from KOI_Weekly_AccidentIncident_Report WHERE Plant<>'All' AND Plant<>'Allexclude2F' AND [Year] = @FiscalYear AND Week=@FiscalWeek)	
--				SET @Total_Loss_per_Case=(select ISNULL(SUM(Total_Loss_per_Case),0) from KOI_Weekly_AccidentIncident_Report WHERE Plant<>'All' AND Plant<>'Allexclude2F' AND [Year] = @FiscalYear AND Week=@FiscalWeek)
--				SET @Severity_Rate=(select ISNULL(SUM(Severity_Rate),0) from KOI_Weekly_AccidentIncident_Report WHERE Plant<>'All' AND Plant<>'Allexclude2F' AND [Year] = @FiscalYear AND Week=@FiscalWeek)
--				SET @Injury_Rate_per_200k_WH=(select ISNULL(SUM(Injury_Rate_per_200k_WH),0) from KOI_Weekly_AccidentIncident_Report WHERE Plant<>'All' AND Plant<>'Allexclude2F' AND [Year] = @FiscalYear AND Week=@FiscalWeek)
--
--				SET @SQLString=dbo.KOI_fun_Get_Weekly_AccidentIncident_Report_SQL_String
--						(
--							@FiscalYear,@FiscalWeek,@Plant,@WorkingHours,@Incident,@First_aid,@Total_Accidents,@Recordable_Accidents,@LWD_Accidents,@Disabled,
--							@Fatal,@Recordable_Accident_Rate,@LWD_Accident_Rate,@Lost_Working_Days,@Medical_Expense,@Manpower_Loss,@Total_Loss,
--							@Total_Loss_per_Case,@Severity_Rate,@Injury_Rate_per_200k_WH 
--						)
--				EXECUTE (@SQLString)
--
--			SET @Plant='Allexclude2F'	
--				SET @WorkingHours=(select ISNULL(SUM(WorkingHours),0) from KOI_Weekly_AccidentIncident_Report WHERE Plant<>'All' AND Plant<>'Allexclude2F' AND Plant<>'B2F' AND [Year] = @FiscalYear AND Week=@FiscalWeek)
--				SET @Incident=(select ISNULL(SUM(Incident),0) from KOI_Weekly_AccidentIncident_Report WHERE Plant<>'All' AND Plant<>'Allexclude2F' AND Plant<>'B2F' AND [Year] = @FiscalYear AND Week=@FiscalWeek)
--				SET @First_aid=(select ISNULL(SUM(First_aid),0) from KOI_Weekly_AccidentIncident_Report WHERE Plant<>'All' AND Plant<>'Allexclude2F' AND Plant<>'B2F' AND [Year] = @FiscalYear AND Week=@FiscalWeek)
--				SET @Total_Accidents=(select ISNULL(SUM(Total_Accidents),0) from KOI_Weekly_AccidentIncident_Report WHERE Plant<>'All' AND Plant<>'Allexclude2F' AND Plant<>'B2F' AND [Year] = @FiscalYear AND Week=@FiscalWeek)	
--				SET @Recordable_Accidents=(select ISNULL(SUM(Recordable_Accidents),0) from KOI_Weekly_AccidentIncident_Report WHERE Plant<>'All' AND Plant<>'Allexclude2F' AND Plant<>'B2F' AND [Year] = @FiscalYear AND Week=@FiscalWeek)
--				SET @LWD_Accidents=(select ISNULL(SUM(LWD_Accidents),0) from KOI_Weekly_AccidentIncident_Report WHERE Plant<>'All' AND Plant<>'Allexclude2F' AND Plant<>'B2F' AND [Year] = @FiscalYear AND Week=@FiscalWeek)
--				SET @Disabled=(select ISNULL(SUM(Disabled),0) from KOI_Weekly_AccidentIncident_Report WHERE Plant<>'All' AND Plant<>'Allexclude2F' AND Plant<>'B2F' AND [Year] = @FiscalYear AND Week=@FiscalWeek)
--				SET @Fatal=(select ISNULL(SUM(Fatal),0) from KOI_Weekly_AccidentIncident_Report WHERE Plant<>'All' AND Plant<>'Allexclude2F' AND Plant<>'B2F' AND [Year] = @FiscalYear AND Week=@FiscalWeek)		
--				SET @Recordable_Accident_Rate=(select ISNULL(SUM(Recordable_Accident_Rate),0) from KOI_Weekly_AccidentIncident_Report WHERE Plant<>'All' AND Plant<>'Allexclude2F' AND Plant<>'B2F' AND [Year] = @FiscalYear AND Week=@FiscalWeek)	
--				SET @LWD_Accident_Rate=(select ISNULL(SUM(LWD_Accident_Rate),0) from KOI_Weekly_AccidentIncident_Report WHERE Plant<>'All' AND Plant<>'Allexclude2F' AND Plant<>'B2F' AND [Year] = @FiscalYear AND Week=@FiscalWeek)
--				SET @Lost_Working_Days=(select ISNULL(SUM(Lost_Working_Days),0) from KOI_Weekly_AccidentIncident_Report WHERE Plant<>'All' AND Plant<>'Allexclude2F' AND Plant<>'B2F' AND [Year] = @FiscalYear AND Week=@FiscalWeek)
--				SET @Medical_Expense=(select ISNULL(SUM(Medical_Expense),0) from KOI_Weekly_AccidentIncident_Report WHERE Plant<>'All' AND Plant<>'Allexclude2F' AND Plant<>'B2F' AND [Year] = @FiscalYear AND Week=@FiscalWeek)		
--				SET @Manpower_Loss=(select ISNULL(SUM(Manpower_Loss),0) from KOI_Weekly_AccidentIncident_Report WHERE Plant<>'All' AND Plant<>'Allexclude2F' AND Plant<>'B2F' AND [Year] = @FiscalYear AND Week=@FiscalWeek)
--				SET @Total_Loss=(select ISNULL(SUM(Total_Loss),0) from KOI_Weekly_AccidentIncident_Report WHERE Plant<>'All' AND Plant<>'Allexclude2F' AND Plant<>'B2F' AND [Year] = @FiscalYear AND Week=@FiscalWeek)
--				SET @Total_Loss_per_Case=(select ISNULL(SUM(Total_Loss_per_Case),0) from KOI_Weekly_AccidentIncident_Report WHERE Plant<>'All' AND Plant<>'Allexclude2F' AND Plant<>'B2F' AND [Year] = @FiscalYear AND Week=@FiscalWeek)	
--				SET @Severity_Rate=(select ISNULL(SUM(Severity_Rate),0) from KOI_Weekly_AccidentIncident_Report WHERE Plant<>'All' AND Plant<>'Allexclude2F' AND Plant<>'B2F' AND [Year] = @FiscalYear AND Week=@FiscalWeek)
--				SET @Injury_Rate_per_200k_WH=(select ISNULL(SUM(Injury_Rate_per_200k_WH),0) from KOI_Weekly_AccidentIncident_Report WHERE Plant<>'All' AND Plant<>'Allexclude2F' AND Plant<>'B2F' AND [Year] = @FiscalYear AND Week=@FiscalWeek)
--
--				SET @SQLString=dbo.KOI_fun_Get_Weekly_AccidentIncident_Report_SQL_String
--						(
--							@FiscalYear,@FiscalWeek,@Plant,@WorkingHours,@Incident,@First_aid,@Total_Accidents,@Recordable_Accidents,@LWD_Accidents,@Disabled,
--							@Fatal,@Recordable_Accident_Rate,@LWD_Accident_Rate,@Lost_Working_Days,@Medical_Expense,@Manpower_Loss,@Total_Loss,
--							@Total_Loss_per_Case,@Severity_Rate,@Injury_Rate_per_200k_WH 
--						)
--				EXECUTE (@SQLString)		
--							
--			FETCH NEXT FROM AccidentIncident_Week_C INTO @Fiscalyear,@FiscalWeek,@FiscalWeekFrom,@FiscalWeekTo 
--		END
--	CLOSE AccidentIncident_Week_C
--	DEALLOCATE AccidentIncident_Week_C
	
END







GO
