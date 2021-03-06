USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[KOI_sp_Automatically_Process_Yearly_Yield_trend_by_plant_Fiscal]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[KOI_sp_Automatically_Process_Yearly_Yield_trend_by_plant_Fiscal] 
	-- Add the parameters for the stored procedure here
AS
BEGIN 


SELECT * INTO #Tmp_PY FROM 
(	
	SELECT T$PLNT FROM TFSOLP107180 WHERE T$PLNT<>'P1' AND T$PLNT<>'HK' AND T$PLNT<>'12' GROUP BY T$PLNT
) AS T1
 JOIN
(
	SELECT FiscalYear+1 AS FiscalYear, FiscalYearFrom, FiscalYearTo FROM DataWarehouse.dbo.DW_DIM_Calender
	WHERE Calenderdate < CONVERT(VARCHAR(10),GETDATE()-1,120) AND FiscalYear>'2007'
	GROUP BY FiscalYear,FiscalYearFrom, FiscalYearTo 
) AS T2
ON 1 =1


select * into #temp from 
(
select '001' AS ReportCode,[Year],Plant,
ISNULL(CASE Yield_Percentage WHEN 0 THEN 0 ELSE FGin_sqft*(1-Yield_Percentage)/Yield_Percentage END,0) as Scrap_sqft,
FGin_sqft,Yield_Percentage
 from 
(
SELECT FiscalYear as [Year],(CASE T$PLNT WHEN 'P2' THEN 'B1' WHEN '2F' THEN 'B2F' ELSE T$PLNT END) as Plant, 
(SELECT ISNULL(SUM(T$SQFT),0) from TFSOLP107180 WHERE T$PLNT=#Tmp_PY.T$PLNT AND T$Date BETWEEN FiscalYearFrom AND FiscalYearTo) as FGin_sqft
,
(select CASE SUM(Ydas_Yied) WHEN '0' THEN '0' ELSE SUM(T$YDAS)/SUM(Ydas_Yied) END aa from 
(
	(
		SELECT CASE ISNULL(T$YIED,0) WHEN '0' THEN '0'  ELSE ISNULL(T$YDAS/T$YIED,0) END as Ydas_Yied, ISNULL(T$YDAS,0) as T$YDAS 
		from TFSOLP108180 where T$OUDT BETWEEN FiscalYearFrom and FiscalYearTo AND T$YIED<>0 AND T$PLNT= (CASE #Tmp_PY.T$PLNT WHEN 'P2' THEN 'B1' ELSE #Tmp_PY.T$PLNT END)
	) 
) a) Yield_Percentage

FROM #Tmp_PY 
) tb

UNION ALL

select '001' AS ReportCode,[Year],'All' as Plant,
ISNULL(CASE Yield_Percentage WHEN 0 THEN 0 ELSE FGin_sqft*(1-Yield_Percentage)/Yield_Percentage END,0) as Scrap_sqft,
FGin_sqft,Yield_Percentage
 from 
(
SELECT FiscalYear as [Year],
(SELECT ISNULL(SUM(T$SQFT),0) from TFSOLP107180 WHERE T$PLNT<>'P1' AND T$PLNT<>'HK' AND T$PLNT<>'12' AND T$Date BETWEEN FiscalYearFrom AND FiscalYearTo) as FGin_sqft
,
(select CASE SUM(Ydas_Yied) WHEN '0' THEN '0' ELSE SUM(T$YDAS)/SUM(Ydas_Yied) END aa from 
(
	(
		SELECT CASE ISNULL(T$YIED,0) WHEN '0' THEN '0'  ELSE ISNULL(T$YDAS/T$YIED,0) END as Ydas_Yied, ISNULL(T$YDAS,0) as T$YDAS 
		from TFSOLP108180 where T$PLNT<>'P1' AND T$OUDT BETWEEN FiscalYearFrom and FiscalYearTo AND T$YIED<>0 
	) 
) a) Yield_Percentage

FROM #Tmp_PY group by FiscalYear,FiscalYearFrom,FiscalYearTo
) tbAll 

UNION ALL

select '001' AS ReportCode,[Year],'Allexclude2F' as Plant,
ISNULL(CASE Yield_Percentage WHEN 0 THEN 0 ELSE FGin_sqft*(1-Yield_Percentage)/Yield_Percentage END,0) as Scrap_sqft,
FGin_sqft,Yield_Percentage
 from 
(
SELECT FiscalYear as [Year],
(SELECT ISNULL(SUM(T$SQFT),0) from TFSOLP107180 WHERE T$PLNT<>'P1' AND T$PLNT<>'HK' AND T$PLNT<>'12' AND T$PLNT<>'2F' AND T$Date BETWEEN FiscalYearFrom AND FiscalYearTo) as FGin_sqft
,
(select CASE SUM(Ydas_Yied) WHEN '0' THEN '0' ELSE SUM(T$YDAS)/SUM(Ydas_Yied) END aa from 
(
	(
		SELECT CASE ISNULL(T$YIED,0) WHEN '0' THEN '0'  ELSE ISNULL(T$YDAS/T$YIED,0) END as Ydas_Yied, ISNULL(T$YDAS,0) as T$YDAS 
		from TFSOLP108180 where T$PLNT<>'P1' AND T$OUDT BETWEEN FiscalYearFrom and FiscalYearTo AND T$YIED<>0 
	) 
) a) Yield_Percentage

FROM #Tmp_PY group by FiscalYear,FiscalYearFrom,FiscalYearTo
) tbAllexclude2F
) as tbtemp

 --update
UPDATE KOI_Yearly_Yield_trend_by_plant SET Scrap_sqft=b.Scrap_sqft,FGin_sqft=b.FGin_sqft,Yield_Percentage=b.Yield_Percentage 
from #temp b 
WHERE KOI_Yearly_Yield_trend_by_plant.ReportCode=b.ReportCode AND KOI_Yearly_Yield_trend_by_plant.[Year]=b.[Year] AND KOI_Yearly_Yield_trend_by_plant.Plant=b.Plant 

--insert
INSERT INTO KOI_Yearly_Yield_trend_by_plant (ReportCode,[Year],Plant,Scrap_sqft,FGin_sqft,Yield_Percentage)
SELECT * FROM #temp a WHERE not EXISTS (SELECT * FROM KOI_Yearly_Yield_trend_by_plant b WHERE a.ReportCode=b.ReportCode AND a.[Year]=b.[Year]  AND a.Plant=b.Plant ) 


drop table #Tmp_PY 
drop table #temp 

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
--	SET NOCOUNT ON;
--
--    -- Insert statements for procedure here
--    DECLARE @FiscalYear VARCHAR(4),@FiscalYearFrom VARCHAR(20),@FiscalYearTo VARCHAR(20),@ReportCode VARCHAR(3),@Plant NVARCHAR(50),@Scrap_sqft NUMERIC(18,2),@FGin_sqft NUMERIC(18,2),@Yield_Percentage float,@SQLString VARCHAR(MAX) 
--	SET @ReportCode='001' 	
--
--    DECLARE Yield_trend_by_plant_FiscalYear_C CURSOR FOR	
--
--	select FiscalYear+1 AS FiscalYear, CONVERT(varchar(12),FiscalYearFrom,23) as FiscalYearFrom,CONVERT(varchar(12),FiscalYearTo,23) as FiscalYearTo
--	FROM DataWarehouse.dbo.DW_DIM_Calender 
--	WHERE Calenderdate < CONVERT(VARCHAR(10),GETDATE()-1,120) AND FiscalYear>'2007'
--	GROUP BY FiscalYear,FiscalYearFrom,FiscalYearTo
--	ORDER BY FiscalYear DESC,FiscalYearTo DESC
--
--	OPEN Yield_trend_by_plant_FiscalYear_C
--	FETCH NEXT FROM Yield_trend_by_plant_FiscalYear_C INTO @Fiscalyear,@FiscalYearFrom,@FiscalYearTo 
--	
--	WHILE @@FETCH_STATUS=0
--		BEGIN
--			IF @FiscalYearTo>CONVERT(VARCHAR(10),DATEADD(DAY,-1,GETDATE()),120)
--				BEGIN
--					SET @FiscalYearTo=CONVERT(VARCHAR(10),DATEADD(DAY,-1,GETDATE()),120)
--				END
--
--			SET @Plant='B1'	
--				SET @FGin_sqft = (SELECT ISNULL(SUM(T$SQFT),0) from TFSOLP107180 WHERE T$PLNT='P2' AND T$Date BETWEEN @FiscalYearFrom AND @FiscalYearTo) 			
--				SET @Yield_Percentage = (SELECT ISNULL(SUM(T$YDAS)/SUM(T$YDAS/T$YIED),0) AS YIELD from TFSOLP108180 where T$OUDT BETWEEN @FiscalYearFrom and @FiscalYearTo AND T$YIED<>0 AND T$PLNT=@Plant ) 
--				SET @Scrap_sqft = (SELECT ISNULL(CASE @Yield_Percentage WHEN 0 THEN 0 ELSE @FGin_sqft*(1-@Yield_Percentage)/@Yield_Percentage END,0))      --Scrap=FG in*(1-Yield)/Yield
--				SET @SQLString=dbo.KOI_fun_Get_Yearly_Yield_trend_by_plant_SQL_String(@ReportCode,@FiscalYear,@Plant,@Scrap_sqft,@FGin_sqft,@Yield_Percentage) 
--				EXECUTE (@SQLString) 			
--			
----			SET @Plant='B2F'
----				SET @FGin_sqft = (SELECT SUM(T$SQFT) from TFSOLP112180 WHERE T$PLNT='2F' AND T$Date BETWEEN @FiscalYearFrom AND @FiscalYearTo) 			
----				SET @Yield_Percentage = (SELECT SUM(T$YDAS)/SUM(T$YDAS/T$YIED) AS YIELD from TFSOLP108180 where T$OUDT BETWEEN @FiscalYearFrom and @FiscalYearTo AND T$YIED<>0 AND T$PLNT=@Plant ) 
----				SET @Scrap_sqft = (SELECT CASE @Yield_Percentage WHEN 0 THEN 0 ELSE @FGin_sqft*(1-@Yield_Percentage)/@Yield_Percentage)       --Scrap=FG in*(1-Yield)/Yield
----				SET @SQLString=dbo.KOI_fun_Get_Yearly_Yield_trend_by_plant_SQL_String(@ReportCode,@FiscalYear,@Plant,@Scrap_sqft,@FGin_sqft,@Yield_Percentage) 
----				EXECUTE (@SQLString) 	
--
--			SET @Plant='B3'
--				SET @FGin_sqft = (SELECT ISNULL(SUM(T$SQFT),0) from TFSOLP107180 WHERE T$PLNT=@Plant AND T$Date BETWEEN @FiscalYearFrom AND @FiscalYearTo) 			
--				SET @Yield_Percentage = (SELECT ISNULL(SUM(T$YDAS)/SUM(T$YDAS/T$YIED),0) AS YIELD from TFSOLP108180 where T$OUDT BETWEEN @FiscalYearFrom and @FiscalYearTo AND T$YIED<>0 AND T$PLNT=@Plant ) 
--				SET @Scrap_sqft = (SELECT ISNULL(CASE @Yield_Percentage WHEN 0 THEN 0 ELSE @FGin_sqft*(1-@Yield_Percentage)/@Yield_Percentage END,0))       --Scrap=FG in*(1-Yield)/Yield
--				SET @SQLString=dbo.KOI_fun_Get_Yearly_Yield_trend_by_plant_SQL_String(@ReportCode,@FiscalYear,@Plant,@Scrap_sqft,@FGin_sqft,@Yield_Percentage) 
--				EXECUTE (@SQLString) 
--				
--			SET @Plant='B4'				
--				SET @FGin_sqft = (SELECT ISNULL(SUM(T$SQFT),0) from TFSOLP107180 WHERE T$PLNT=@Plant AND T$Date BETWEEN @FiscalYearFrom AND @FiscalYearTo) 			
--				SET @Yield_Percentage = (SELECT ISNULL(SUM(T$YDAS)/SUM(T$YDAS/T$YIED),0) AS YIELD from TFSOLP108180 where T$OUDT BETWEEN @FiscalYearFrom and @FiscalYearTo AND T$YIED<>0 AND T$PLNT=@Plant ) 
--				SET @Scrap_sqft = (SELECT ISNULL(CASE @Yield_Percentage WHEN 0 THEN 0 ELSE @FGin_sqft*(1-@Yield_Percentage)/@Yield_Percentage END,0))       --Scrap=FG in*(1-Yield)/Yield
--				SET @SQLString=dbo.KOI_fun_Get_Yearly_Yield_trend_by_plant_SQL_String(@ReportCode,@FiscalYear,@Plant,@Scrap_sqft,@FGin_sqft,@Yield_Percentage) 
--				EXECUTE (@SQLString)				
--
--			SET @Plant='B5'				
--				SET @FGin_sqft = (SELECT ISNULL(SUM(T$SQFT),0) from TFSOLP107180 WHERE T$PLNT=@Plant AND T$Date BETWEEN @FiscalYearFrom AND @FiscalYearTo) 			
--				SET @Yield_Percentage = (SELECT ISNULL(SUM(T$YDAS)/SUM(T$YDAS/T$YIED),0) AS YIELD from TFSOLP108180 where T$OUDT BETWEEN @FiscalYearFrom and @FiscalYearTo AND T$YIED<>0 AND T$PLNT=@Plant ) 
--				SET @Scrap_sqft = (SELECT ISNULL(CASE @Yield_Percentage WHEN 0 THEN 0 ELSE @FGin_sqft*(1-@Yield_Percentage)/@Yield_Percentage END,0))       --Scrap=FG in*(1-Yield)/Yield
--				SET @SQLString=dbo.KOI_fun_Get_Yearly_Yield_trend_by_plant_SQL_String(@ReportCode,@FiscalYear,@Plant,@Scrap_sqft,@FGin_sqft,@Yield_Percentage) 
--				EXECUTE (@SQLString)			
--
--			SET @Plant='All'	
--				SET @FGin_sqft = (SELECT ISNULL(SUM(T$SQFT),0) from TFSOLP107180 WHERE T$PLNT<>'12' AND T$PLNT<>'2F' AND T$PLNT<>'HK' AND T$Date BETWEEN @FiscalYearFrom AND @FiscalYearTo) 			
--				SET @Yield_Percentage = (SELECT ISNULL(SUM(T$YDAS)/SUM(T$YDAS/T$YIED),0) AS YIELD from TFSOLP108180 where T$OUDT BETWEEN @FiscalYearFrom and @FiscalYearTo AND T$YIED<>0 AND T$PLNT<>'P1' ) 
--				SET @Scrap_sqft = (SELECT ISNULL(CASE @Yield_Percentage WHEN 0 THEN 0 ELSE @FGin_sqft*(1-@Yield_Percentage)/@Yield_Percentage END,0))       --Scrap=FG in*(1-Yield)/Yield
--				SET @SQLString=dbo.KOI_fun_Get_Yearly_Yield_trend_by_plant_SQL_String(@ReportCode,@FiscalYear,@Plant,@Scrap_sqft,@FGin_sqft,@Yield_Percentage) 
--				EXECUTE (@SQLString)	
--			
----				SET @FGin_sqft=(select ISNULL(SUM(FGin_sqft),0) from KOI_Yearly_Yield_trend_by_plant where ReportCode=@ReportCode AND Plant<>'All' AND [Year]=@Fiscalyear) 				
----				SET @Yield_Percentage=(select ISNULL(SUM(Yield_Percentage),0) from KOI_Yearly_Yield_trend_by_plant where ReportCode=@ReportCode AND Plant<>'All' AND [Year]=@Fiscalyear) 				
----				SET @Scrap_sqft=(select ISNULL(SUM(Scrap_sqft),0) from KOI_Yearly_Yield_trend_by_plant where ReportCode=@ReportCode AND Plant<>'All' AND [Year]=@Fiscalyear) 				
----				SET @SQLString=dbo.KOI_fun_Get_Yearly_Yield_trend_by_plant_SQL_String(@ReportCode,@FiscalYear,@Plant,@Scrap_sqft,@FGin_sqft,@Yield_Percentage) 
--				EXECUTE (@SQLString) 	
--
----			SET @Plant='Allexclude2F'					
----				SET @Amount=(select ISNULL(SUM(ASP),0) from KOI_Yearly_Yield_trend_by_plant where ReportCode=@ReportCode AND Plant<>'All' AND Plant<>'Allexclude2F' AND Plant<>'B2F' AND [Year]=@Fiscalyear)				
----				SET @SQLString=dbo.KOI_fun_Get_Yearly_Yield_trend_by_plant_SQL_String(@ReportCode,@FiscalYear,@Plant,@Amount) 		
----				EXECUTE (@SQLString)
--							
--			FETCH NEXT FROM Yield_trend_by_plant_FiscalYear_C INTO @Fiscalyear,@FiscalYearFrom,@FiscalYearTo 
--		END
--	CLOSE Yield_trend_by_plant_FiscalYear_C 
--	DEALLOCATE Yield_trend_by_plant_FiscalYear_C 

END
 








GO
