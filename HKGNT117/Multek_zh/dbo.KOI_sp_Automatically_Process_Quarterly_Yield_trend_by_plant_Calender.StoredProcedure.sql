USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[KOI_sp_Automatically_Process_Quarterly_Yield_trend_by_plant_Calender]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[KOI_sp_Automatically_Process_Quarterly_Yield_trend_by_plant_Calender]
	-- Add the parameters for the stored procedure here
AS
BEGIN 

SELECT * INTO #Tmp_PY FROM 
(	
	SELECT T$PLNT FROM TFSOLP107180 WHERE T$PLNT<>'P1' AND T$PLNT<>'HK' AND T$PLNT<>'12' GROUP BY T$PLNT
) AS T1
 JOIN
(
	SELECT CalenderYear, CalenderQuarter,CalenderDateFrom, CalenderDateTo FROM vw_KOI_Calender_Quarter
	WHERE  CalenderYear>'2007'
	GROUP BY CalenderYear,CalenderQuarter,CalenderDateFrom, CalenderDateTo 
) AS T2
ON 1 =1


select * into #temp from 
(
select '002' AS ReportCode,[Year],Quarter,Plant,
ISNULL(CASE Yield_Percentage WHEN 0 THEN 0 ELSE FGin_sqft*(1-Yield_Percentage)/Yield_Percentage END,0) as Scrap_sqft,
FGin_sqft,Yield_Percentage
 from 
(
SELECT CalenderYear as [Year],CalenderQuarter as Quarter,(CASE T$PLNT WHEN 'P2' THEN 'B1' WHEN '2F' THEN 'B2F' ELSE T$PLNT END) as Plant, 
(SELECT ISNULL(SUM(T$SQFT),0) from TFSOLP107180 WHERE T$PLNT=#Tmp_PY.T$PLNT AND T$Date BETWEEN CalenderDateFrom AND CalenderDateTo) as FGin_sqft
,
(select CASE SUM(Ydas_Yied) WHEN '0' THEN '0' ELSE SUM(T$YDAS)/SUM(Ydas_Yied) END aa from 
(
	(
		SELECT CASE ISNULL(T$YIED,0) WHEN '0' THEN '0'  ELSE ISNULL(T$YDAS/T$YIED,0) END as Ydas_Yied, ISNULL(T$YDAS,0) as T$YDAS 
		from TFSOLP108180 where T$OUDT BETWEEN CalenderDateFrom and CalenderDateTo AND T$YIED<>0 AND T$PLNT= (CASE #Tmp_PY.T$PLNT WHEN 'P2' THEN 'B1' ELSE #Tmp_PY.T$PLNT END)
	) 
) a) Yield_Percentage

FROM #Tmp_PY 
) tb
UNION ALL
select '002' AS ReportCode,[Year],Quarter,'All' as Plant,
ISNULL(CASE Yield_Percentage WHEN 0 THEN 0 ELSE FGin_sqft*(1-Yield_Percentage)/Yield_Percentage END,0) as Scrap_sqft,
FGin_sqft,Yield_Percentage
 from 
(
SELECT CalenderYear as [Year],CalenderQuarter as Quarter,
(SELECT ISNULL(SUM(T$SQFT),0) from TFSOLP107180 WHERE T$PLNT<>'P1' AND T$PLNT<>'HK' AND T$PLNT<>'12' AND T$Date BETWEEN CalenderDateFrom AND CalenderDateTo) as FGin_sqft
,
(select CASE SUM(Ydas_Yied) WHEN '0' THEN '0' ELSE SUM(T$YDAS)/SUM(Ydas_Yied) END aa from 
(
	(
		SELECT CASE ISNULL(T$YIED,0) WHEN '0' THEN '0'  ELSE ISNULL(T$YDAS/T$YIED,0) END as Ydas_Yied, ISNULL(T$YDAS,0) as T$YDAS 
		from TFSOLP108180 where T$PLNT<>'P1' AND T$OUDT BETWEEN CalenderDateFrom and CalenderDateTo AND T$YIED<>0 
	) 
) a) Yield_Percentage

FROM #Tmp_PY group by CalenderYear,CalenderQuarter,CalenderDateFrom,CalenderDateTo
) tbAll 
UNION ALL
select '002' AS ReportCode,[Year],Quarter,'Allexclude2F' as Plant,
ISNULL(CASE Yield_Percentage WHEN 0 THEN 0 ELSE FGin_sqft*(1-Yield_Percentage)/Yield_Percentage END,0) as Scrap_sqft,
FGin_sqft,Yield_Percentage
 from 
(
SELECT CalenderYear as [Year],CalenderQuarter as Quarter, 
(SELECT ISNULL(SUM(T$SQFT),0) from TFSOLP107180 WHERE T$PLNT<>'P1' AND T$PLNT<>'HK' AND T$PLNT<>'12' AND T$PLNT<>'2F' AND T$Date BETWEEN CalenderDateFrom AND CalenderDateTo) as FGin_sqft
,
(select CASE SUM(Ydas_Yied) WHEN '0' THEN '0' ELSE SUM(T$YDAS)/SUM(Ydas_Yied) END aa from 
(
	(
		SELECT CASE ISNULL(T$YIED,0) WHEN '0' THEN '0'  ELSE ISNULL(T$YDAS/T$YIED,0) END as Ydas_Yied, ISNULL(T$YDAS,0) as T$YDAS 
		from TFSOLP108180 where T$PLNT<>'P1' AND T$OUDT BETWEEN CalenderDateFrom and CalenderDateTo AND T$YIED<>0 
	) 
) a) Yield_Percentage

FROM #Tmp_PY group by CalenderYear,CalenderQuarter,CalenderDateFrom,CalenderDateTo
) tbAllexclude2F
) as tbtemp


 --update
UPDATE KOI_Quarterly_Yield_trend_by_plant SET Scrap_sqft=b.Scrap_sqft,FGin_sqft=b.FGin_sqft,Yield_Percentage=b.Yield_Percentage 
from #temp b 
WHERE KOI_Quarterly_Yield_trend_by_plant.ReportCode=b.ReportCode AND KOI_Quarterly_Yield_trend_by_plant.[Year]=b.[Year] AND KOI_Quarterly_Yield_trend_by_plant.Quarter=b.Quarter AND KOI_Quarterly_Yield_trend_by_plant.Plant=b.Plant 

--insert
INSERT INTO KOI_Quarterly_Yield_trend_by_plant (ReportCode,[Year],Quarter,Plant,Scrap_sqft,FGin_sqft,Yield_Percentage)
SELECT * FROM #temp a WHERE not EXISTS (SELECT * FROM KOI_Quarterly_Yield_trend_by_plant b WHERE a.ReportCode=b.ReportCode AND a.[Year]=b.[Year] AND a.Quarter=b.Quarter  AND a.Plant=b.Plant ) 


drop table #Tmp_PY 
drop table #temp 



	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
--	SET NOCOUNT ON;
--
--    -- Insert statements for procedure here
--    DECLARE @CalenderYear VARCHAR(4),@CalenderQuarter INT,@CalenderDateFrom VARCHAR(20),@CalenderDateTo VARCHAR(20),@ReportCode VARCHAR(3),@Plant NVARCHAR(50),@Scrap_sqft NUMERIC(18,2),@FGin_sqft NUMERIC(18,2),@Yield_Percentage float,@SQLString VARCHAR(MAX) 
--	SET @ReportCode='002'
--
--    DECLARE Yield_trend_by_plant_CalenderQuarter_C CURSOR FOR 
--	SELECT CalenderYear,CalenderQuarter,CalenderDateFrom,CalenderDateTo 
--	FROM vw_KOI_Calender_Quarter WHERE CalenderYear>'2007'
--	GROUP BY CalenderYear,CalenderQuarter,CalenderDateFrom,CalenderDateTo 
--	ORDER BY CalenderYear DESC,CalenderDateTo DESC 
--
--	OPEN Yield_trend_by_plant_CalenderQuarter_C 
--	FETCH NEXT FROM Yield_trend_by_plant_CalenderQuarter_C INTO @CalenderYear,@CalenderQuarter,@CalenderDateFrom,@CalenderDateTo 
--	
--	WHILE @@FETCH_STATUS=0
--		BEGIN
--			IF @CalenderDateTo>CONVERT(VARCHAR(10),DATEADD(DAY,-1,GETDATE()),120)
--				BEGIN
--					SET @CalenderDateTo=CONVERT(VARCHAR(10),DATEADD(DAY,-1,GETDATE()),120)
--				END
--				
--			SET @Plant='B1'		
--				SET @FGin_sqft = (SELECT ISNULL(SUM(T$SQFT),0) from TFSOLP107180 WHERE T$PLNT='P2' AND T$Date BETWEEN @CalenderDateFrom AND @CalenderDateTo) 			
--				SET @Yield_Percentage = (SELECT ISNULL(SUM(T$YDAS)/SUM(T$YDAS/T$YIED),0) AS YIELD from TFSOLP108180 where T$OUDT BETWEEN @CalenderDateFrom and @CalenderDateTo AND T$YIED<>0 AND T$PLNT=@Plant ) 
--				SET @Scrap_sqft = (SELECT ISNULL(CASE @Yield_Percentage WHEN 0 THEN 0 ELSE @FGin_sqft*(1-@Yield_Percentage)/@Yield_Percentage END,0))      --Scrap=FG in*(1-Yield)/Yield
--				SET @SQLString=dbo.KOI_fun_Get_Quarterly_Yield_trend_by_plant_SQL_String(@ReportCode,@CalenderYear,@CalenderQuarter,@Plant,@Scrap_sqft,@FGin_sqft,@Yield_Percentage) 
--				EXECUTE (@SQLString) 
--			
--			SET @Plant='B3' 
--				SET @FGin_sqft = (SELECT ISNULL(SUM(T$SQFT),0) from TFSOLP107180 WHERE T$PLNT=@Plant AND T$Date BETWEEN @CalenderDateFrom AND @CalenderDateTo) 			
--				SET @Yield_Percentage = (SELECT ISNULL(SUM(T$YDAS)/SUM(T$YDAS/T$YIED),0) AS YIELD from TFSOLP108180 where T$OUDT BETWEEN @CalenderDateFrom and @CalenderDateTo AND T$YIED<>0 AND T$PLNT=@Plant ) 
--				SET @Scrap_sqft = (SELECT ISNULL(CASE @Yield_Percentage WHEN 0 THEN 0 ELSE @FGin_sqft*(1-@Yield_Percentage)/@Yield_Percentage END,0))      --Scrap=FG in*(1-Yield)/Yield
--				SET @SQLString=dbo.KOI_fun_Get_Quarterly_Yield_trend_by_plant_SQL_String(@ReportCode,@CalenderYear,@CalenderQuarter,@Plant,@Scrap_sqft,@FGin_sqft,@Yield_Percentage) 
--				EXECUTE (@SQLString) 
--
--			SET @Plant='B4' 
--				SET @FGin_sqft = (SELECT ISNULL(SUM(T$SQFT),0) from TFSOLP107180 WHERE T$PLNT=@Plant AND T$Date BETWEEN @CalenderDateFrom AND @CalenderDateTo) 			
--				SET @Yield_Percentage = (SELECT ISNULL(SUM(T$YDAS)/SUM(T$YDAS/T$YIED),0) AS YIELD from TFSOLP108180 where T$OUDT BETWEEN @CalenderDateFrom and @CalenderDateTo AND T$YIED<>0 AND T$PLNT=@Plant ) 
--				SET @Scrap_sqft = (SELECT ISNULL(CASE @Yield_Percentage WHEN 0 THEN 0 ELSE @FGin_sqft*(1-@Yield_Percentage)/@Yield_Percentage END,0))      --Scrap=FG in*(1-Yield)/Yield
--				SET @SQLString=dbo.KOI_fun_Get_Quarterly_Yield_trend_by_plant_SQL_String(@ReportCode,@CalenderYear,@CalenderQuarter,@Plant,@Scrap_sqft,@FGin_sqft,@Yield_Percentage) 
--				EXECUTE (@SQLString) 
--
--			SET @Plant='B5' 
--				SET @FGin_sqft = (SELECT ISNULL(SUM(T$SQFT),0) from TFSOLP107180 WHERE T$PLNT=@Plant AND T$Date BETWEEN @CalenderDateFrom AND @CalenderDateTo) 			
--				SET @Yield_Percentage = (SELECT ISNULL(SUM(T$YDAS)/SUM(T$YDAS/T$YIED),0) AS YIELD from TFSOLP108180 where T$OUDT BETWEEN @CalenderDateFrom and @CalenderDateTo AND T$YIED<>0 AND T$PLNT=@Plant ) 
--				SET @Scrap_sqft = (SELECT ISNULL(CASE @Yield_Percentage WHEN 0 THEN 0 ELSE @FGin_sqft*(1-@Yield_Percentage)/@Yield_Percentage END,0))      --Scrap=FG in*(1-Yield)/Yield
--				SET @SQLString=dbo.KOI_fun_Get_Quarterly_Yield_trend_by_plant_SQL_String(@ReportCode,@CalenderYear,@CalenderQuarter,@Plant,@Scrap_sqft,@FGin_sqft,@Yield_Percentage) 
--				EXECUTE (@SQLString) 
--
--			SET @Plant='All'
--				SET @FGin_sqft = (SELECT ISNULL(SUM(T$SQFT),0) from TFSOLP107180 WHERE T$PLNT<>'12' AND T$PLNT<>'2F' AND T$PLNT<>'HK' AND T$Date BETWEEN @CalenderDateFrom AND @CalenderDateTo) 			
--				SET @Yield_Percentage = (SELECT ISNULL(SUM(T$YDAS)/SUM(T$YDAS/T$YIED),0) AS YIELD from TFSOLP108180 where T$OUDT BETWEEN @CalenderDateFrom and @CalenderDateTo AND T$YIED<>0 AND T$PLNT<>'P1') 
--				SET @Scrap_sqft = (SELECT ISNULL(CASE @Yield_Percentage WHEN 0 THEN 0 ELSE @FGin_sqft*(1-@Yield_Percentage)/@Yield_Percentage END,0))      --Scrap=FG in*(1-Yield)/Yield
--				SET @SQLString=dbo.KOI_fun_Get_Quarterly_Yield_trend_by_plant_SQL_String(@ReportCode,@CalenderYear,@CalenderQuarter,@Plant,@Scrap_sqft,@FGin_sqft,@Yield_Percentage) 
--				EXECUTE (@SQLString) 				
--							
--			FETCH NEXT FROM Yield_trend_by_plant_CalenderQuarter_C INTO @CalenderYear,@CalenderQuarter,@CalenderDateFrom,@CalenderDateTo 
--		END
--	CLOSE Yield_trend_by_plant_CalenderQuarter_C
--	DEALLOCATE Yield_trend_by_plant_CalenderQuarter_C
	
END


GO
