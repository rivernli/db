USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[KOI_sp_Automatically_Process_Yearly_DPPM_By_Unit_Calender]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[KOI_sp_Automatically_Process_Yearly_DPPM_By_Unit_Calender]
	-- Add the parameters for the stored procedure here
AS
BEGIN

SELECT * INTO #Tmp_PY FROM 
(	
	SELECT T$PLNT FROM TFSOLP105180 WHERE T$PLNT<>'P1' AND T$PLNT<>'HK' AND T$PLNT<>'12' GROUP BY T$PLNT
) AS T1
 JOIN
(
	SELECT CalenderYear, CalenderDateFrom, CalenderDateTo FROM vw_KOI_Calender_Year 
	WHERE  CalenderYear>'2007'
	GROUP BY CalenderYear,CalenderDateFrom, CalenderDateTo 
) AS T2
ON 1 =1 


select * into #temp from 
(
select ReportCode,[Year],Plant,(CASE DQUA WHEN 0 THEN 0 ELSE OQTY / DQUA * cast(power(10,6) as bigint) END) as Unit from 
(
select '002' as ReportCode,CalenderYear as [Year],(CASE T$PLNT WHEN 'P2' THEN 'B1' WHEN '2F' THEN 'B2F' ELSE T$PLNT END )AS Plant, 
(SELECT ABS(ISNULL(SUM(T$OQTY),0)) FROM V_VWFSOLP109180 WHERE Plant = #Tmp_PY.T$PLNT AND T$Date BETWEEN CalenderDateFrom AND CalenderDateTo) as OQTY,
(
select max(DQUA)  from 
(
select ABS(ISNULL(SUM(T$DQUA),0)) as DQUA from TFSOLP105180 
where T$PLNT = #Tmp_PY.T$PLNT AND T$Date BETWEEN CalenderDateFrom AND CalenderDateTo 
UNION 
select ABS(ISNULL(SUM(T$DQUA),0)) as DQUA from TFSOLP105180 
where T$PLNT = #Tmp_PY.T$PLNT AND T$HKDT BETWEEN CalenderDateFrom AND CalenderDateTo 
) tb105180 
) DQUA 
from #Tmp_PY 
) tb 

UNION ALL

select ReportCode,[Year],Plant,(CASE DQUA WHEN 0 THEN 0 ELSE OQTY / DQUA * cast(power(10,6) as bigint) END) as Unit from 
(
select '002' as ReportCode,CalenderYear as [Year],'All' AS Plant, 
(SELECT ABS(ISNULL(SUM(T$OQTY),0)) FROM V_VWFSOLP109180 WHERE Plant<>'' AND T$PLNT<>'HK' AND T$Date BETWEEN CalenderDateFrom AND CalenderDateTo) as OQTY,
(
select max(DQUA) from 
(
select ABS(ISNULL(SUM(T$DQUA),0)) as DQUA from TFSOLP105180 
where T$PLNT<>'P1' AND T$PLNT<>'HK' AND T$PLNT<>'12' AND T$Date BETWEEN CalenderDateFrom AND CalenderDateTo 
UNION 
select ABS(ISNULL(SUM(T$DQUA),0)) as DQUA from TFSOLP105180 
WHERE T$PLNT<>'P1' AND T$PLNT<>'HK' AND T$PLNT<>'12' AND T$HKDT BETWEEN CalenderDateFrom AND CalenderDateTo 
) tb105180 
) as DQUA 
from #Tmp_PY GROUP BY CalenderYear,CalenderDateFrom,CalenderDateTo 
) tb2

UNION ALL

select ReportCode,[Year],Plant,(CASE DQUA WHEN 0 THEN 0 ELSE OQTY / DQUA * cast(power(10,6) as bigint) END) as Unit from 
(
select '002' as ReportCode,CalenderYear as [Year],'Allexclude2F' AS Plant, 
(SELECT ABS(ISNULL(SUM(T$OQTY),0)) FROM V_VWFSOLP109180 WHERE Plant<>'' AND T$PLNT<>'HK' AND T$PLNT<>'2F' AND T$Date BETWEEN CalenderDateFrom AND CalenderDateTo) as OQTY,
(
select max(DQUA)  from 
(
select ABS(ISNULL(SUM(T$DQUA),0)) as DQUA from TFSOLP105180 
where T$PLNT<>'P1' AND T$PLNT<>'HK' AND T$PLNT<>'12' AND T$PLNT<>'2F' AND T$Date BETWEEN CalenderDateFrom AND CalenderDateTo 
UNION 
select ABS(ISNULL(SUM(T$DQUA),0)) as DQUA from TFSOLP105180 
WHERE T$PLNT<>'P1' AND T$PLNT<>'HK' AND T$PLNT<>'12' AND T$PLNT<>'2F' AND T$HKDT BETWEEN CalenderDateFrom AND CalenderDateTo 
) tb105180 
) as DQUA
from #Tmp_PY GROUP BY CalenderYear,CalenderDateFrom,CalenderDateTo 
) tb3 

) as tbtemp 


--update
UPDATE KOI_Yearly_DPPM_By_Unit SET Unit=b.Unit 
from #temp b 
WHERE KOI_Yearly_DPPM_By_Unit.ReportCode=b.ReportCode AND KOI_Yearly_DPPM_By_Unit.[Year]=b.[Year] AND KOI_Yearly_DPPM_By_Unit.Plant=b.Plant 

--insert
INSERT INTO KOI_Yearly_DPPM_By_Unit (ReportCode,[Year],Plant,Unit)
SELECT * FROM #temp a WHERE not EXISTS (SELECT * FROM KOI_Yearly_DPPM_By_Unit b WHERE a.ReportCode=b.ReportCode AND a.[Year]=b.[Year]  AND a.Plant=b.Plant) 

drop table #Tmp_PY 
drop table #temp 

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
--	SET NOCOUNT ON;
--
--    -- Insert statements for procedure here
--    DECLARE @CalenderYear VARCHAR(4), @CalenderDateFrom VARCHAR(20),@CalenderDateTo VARCHAR(20),@ReportCode VARCHAR(3),@Plant NVARCHAR(50),@Amount NUMERIC(18,2),@SQLString VARCHAR(MAX) 
--	SET @ReportCode='002'
--
--    DECLARE CalenderYear_C CURSOR FOR 
--
--	select CalenderYear,CalenderDateFrom,CalenderDateTo	FROM vw_KOI_Calender_Year   
--	WHERE CalenderYear > '2007'
--	GROUP BY CalenderYear,CalenderDateFrom,CalenderDateTo
--	ORDER BY CalenderYear DESC,CalenderDateTo DESC 
--
--	OPEN CalenderYear_C
--	FETCH NEXT FROM CalenderYear_C INTO @CalenderYear,@CalenderDateFrom,@CalenderDateTo 
--	
--	WHILE @@FETCH_STATUS=0
--		BEGIN
--			IF @CalenderDateTo>CONVERT(VARCHAR(10),DATEADD(DAY,-1,GETDATE()),120)
--				BEGIN
--					SET @CalenderDateTo=CONVERT(VARCHAR(10),DATEADD(DAY,-1,GETDATE()),120)
--				END
--
--			SET @Plant='B1'		
--			SET @Amount=(CASE (SELECT ABS(ISNULL(SUM(T$DQUA),0)) FROM TFSOLP105180 WHERE  T$PLNT = 'P2' AND T$Date >= @CalenderDateFrom AND T$HKDT <= @CalenderDateTo) WHEN 0 THEN 0	
--			ELSE (SELECT ABS(ISNULL(SUM(T$OQTY),0)) FROM V_VWFSOLP109180 WHERE  Plant = 'P2' AND T$Date BETWEEN @CalenderDateFrom AND @CalenderDateTo)/
--			(SELECT ABS(ISNULL(SUM(T$DQUA),0)) FROM TFSOLP105180 WHERE  T$PLNT = 'P2' AND T$Date >= @CalenderDateFrom AND T$HKDT <= @CalenderDateTo)
--				END)*cast(power(10,6) as bigint)  
--			SET @SQLString=dbo.KOI_fun_Get_Yearly_DPPM_By_Unit_SQL_String(@ReportCode,@CalenderYear,@Plant,@Amount)
--			EXECUTE (@SQLString)
--			
--			SET @Plant='B2F'
--			SET @Amount=(CASE (SELECT ABS(ISNULL(SUM(T$DQUA),0)) FROM TFSOLP105180 WHERE  T$PLNT = '2F' AND T$Date >= @CalenderDateFrom AND T$HKDT <= @CalenderDateTo) WHEN 0 THEN 0	
--			ELSE (SELECT ABS(ISNULL(SUM(T$OQTY),0)) FROM V_VWFSOLP109180 WHERE  Plant = '2F' AND T$Date BETWEEN @CalenderDateFrom AND @CalenderDateTo)/
--			(SELECT ABS(ISNULL(SUM(T$DQUA),0)) FROM TFSOLP105180 WHERE  T$PLNT = '2F' AND T$Date >= @CalenderDateFrom AND T$HKDT <= @CalenderDateTo)
--				END)*cast(power(10,6) as bigint)  
--			SET @SQLString=dbo.KOI_fun_Get_Yearly_DPPM_By_Unit_SQL_String(@ReportCode,@CalenderYear,@Plant,@Amount)
--			EXECUTE (@SQLString)
--
--			SET @Plant='B3'
--			SET @Amount=(CASE (SELECT ABS(ISNULL(SUM(T$DQUA),0)) FROM TFSOLP105180 WHERE  T$PLNT = 'B3' AND T$Date >= @CalenderDateFrom AND T$HKDT <= @CalenderDateTo) WHEN 0 THEN 0	
--			ELSE (SELECT ABS(ISNULL(SUM(T$OQTY),0)) FROM V_VWFSOLP109180 WHERE  Plant = 'B3' AND T$Date BETWEEN @CalenderDateFrom AND @CalenderDateTo)/
--			(SELECT ABS(ISNULL(SUM(T$DQUA),0)) FROM TFSOLP105180 WHERE  T$PLNT = 'B3' AND T$Date >= @CalenderDateFrom AND T$HKDT <= @CalenderDateTo)
--				END)*cast(power(10,6) as bigint)  
--			SET @SQLString=dbo.KOI_fun_Get_Yearly_DPPM_By_Unit_SQL_String(@ReportCode,@CalenderYear,@Plant,@Amount)
--			EXECUTE (@SQLString)
--
--			SET @Plant='B4'
--			SET @Amount=(CASE (SELECT ABS(ISNULL(SUM(T$DQUA),0)) FROM TFSOLP105180 WHERE  T$PLNT = 'B4' AND T$Date >= @CalenderDateFrom AND T$HKDT <= @CalenderDateTo) WHEN 0 THEN 0	
--			ELSE (SELECT ABS(ISNULL(SUM(T$OQTY),0)) FROM V_VWFSOLP109180 WHERE  Plant = 'B4' AND T$Date BETWEEN @CalenderDateFrom AND @CalenderDateTo)/
--			(SELECT ABS(ISNULL(SUM(T$DQUA),0)) FROM TFSOLP105180 WHERE  T$PLNT = 'B4' AND T$Date >= @CalenderDateFrom AND T$HKDT <= @CalenderDateTo)
--				END)*cast(power(10,6) as bigint)  
--			SET @SQLString=dbo.KOI_fun_Get_Yearly_DPPM_By_Unit_SQL_String(@ReportCode,@CalenderYear,@Plant,@Amount)
--			EXECUTE (@SQLString)
--
--			SET @Plant='B5'
--			SET @Amount=(CASE (SELECT ABS(ISNULL(SUM(T$DQUA),0)) FROM TFSOLP105180 WHERE  T$PLNT = 'B5' AND T$Date >= @CalenderDateFrom AND T$HKDT <= @CalenderDateTo) WHEN 0 THEN 0	
--			ELSE (SELECT ABS(ISNULL(SUM(T$OQTY),0)) FROM V_VWFSOLP109180 WHERE  Plant = 'B5' AND T$Date BETWEEN @CalenderDateFrom AND @CalenderDateTo)/
--			(SELECT ABS(ISNULL(SUM(T$DQUA),0)) FROM TFSOLP105180 WHERE  T$PLNT = 'B5' AND T$Date >= @CalenderDateFrom AND T$HKDT <= @CalenderDateTo)
--				END)*cast(power(10,6) as bigint)  
--			SET @SQLString=dbo.KOI_fun_Get_Yearly_DPPM_By_Unit_SQL_String(@ReportCode,@CalenderYear,@Plant,@Amount)
--			EXECUTE (@SQLString)		
--
--			SET @Plant='All'
--			SET @Amount=(select ISNULL(SUM(Unit),0) from KOI_Yearly_DPPM_By_Unit where ReportCode=@ReportCode AND Plant<>'All' AND Plant<>'Allexclude2F' AND [Year]=@CalenderYear) 
--			SET @SQLString=dbo.KOI_fun_Get_Yearly_DPPM_By_Unit_SQL_String(@ReportCode,@CalenderYear,@Plant,@Amount)
--			EXECUTE (@SQLString)
--
--			SET @Plant='Allexclude2F'	
--			SET @Amount=(select ISNULL(SUM(Unit),0) from KOI_Yearly_DPPM_By_Unit where ReportCode=@ReportCode AND Plant<>'All' AND Plant<>'Allexclude2F' AND Plant<>'B2F' AND [Year]=@CalenderYear)
--			SET @SQLString=dbo.KOI_fun_Get_Yearly_DPPM_By_Unit_SQL_String(@ReportCode,@CalenderYear,@Plant,@Amount)
--			EXECUTE (@SQLString)
--							
--			FETCH NEXT FROM CalenderYear_C INTO @CalenderYear,@CalenderDateFrom,@CalenderDateTo 
--		END
--	CLOSE CalenderYear_C 
--	DEALLOCATE CalenderYear_C 

END
 







GO
