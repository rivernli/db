USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[KOI_sp_Automatically_Process_Periodly_DPPM_By_Unit_Fiscal]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE PROCEDURE [dbo].[KOI_sp_Automatically_Process_Periodly_DPPM_By_Unit_Fiscal]
	-- Add the parameters for the stored procedure here
AS
BEGIN 

SELECT * INTO #Tmp_PY FROM 
(	
	SELECT T$PLNT FROM TFSOLP105180 WHERE T$PLNT<>'P1' AND T$PLNT<>'HK' AND T$PLNT<>'12' GROUP BY T$PLNT
) AS T1
 JOIN
(
	SELECT FiscalYear+1 AS FiscalYear, FiscalPeriod,FiscalPeriodFrom, FiscalPeriodTo FROM DataWarehouse.dbo.DW_DIM_Calender
	WHERE Calenderdate < CONVERT(VARCHAR(10),GETDATE()-1,120) AND FiscalYear>'2007'
	GROUP BY FiscalYear,FiscalPeriod,FiscalPeriodFrom, FiscalPeriodTo  
) AS T2
ON 1 =1 

select * into #temp from 
(
select ReportCode,[Year],Period,Plant,(CASE DQUA WHEN 0 THEN 0 ELSE OQTY / DQUA * cast(power(10,6) as bigint) END) as Unit from 
(
select '001' as ReportCode,FiscalYear as [Year],FiscalPeriod as Period,(CASE T$PLNT WHEN 'P2' THEN 'B1' WHEN '2F' THEN 'B2F' ELSE T$PLNT END )AS Plant, 
(SELECT ABS(ISNULL(SUM(T$OQTY),0)) FROM V_VWFSOLP109180 WHERE Plant = #Tmp_PY.T$PLNT AND T$Date BETWEEN FiscalPeriodFrom AND FiscalPeriodTo) as OQTY,
(
select max(DQUA)  from 
(
select ABS(ISNULL(SUM(T$DQUA),0)) as DQUA from TFSOLP105180 
where T$PLNT = #Tmp_PY.T$PLNT AND T$Date BETWEEN FiscalPeriodFrom AND FiscalPeriodTo 
UNION 
select ABS(ISNULL(SUM(T$DQUA),0)) as DQUA from TFSOLP105180 
where T$PLNT = #Tmp_PY.T$PLNT AND T$HKDT BETWEEN FiscalPeriodFrom AND FiscalPeriodTo 
) tb105180 
) DQUA 
from #Tmp_PY 
) tb 

UNION ALL

select ReportCode,[Year],Period,Plant,(CASE DQUA WHEN 0 THEN 0 ELSE OQTY / DQUA * cast(power(10,6) as bigint) END) as Unit from 
(
select '001' as ReportCode,FiscalYear as [Year],FiscalPeriod as Period,'All' AS Plant, 
(SELECT ABS(ISNULL(SUM(T$OQTY),0)) FROM V_VWFSOLP109180 WHERE Plant<>'' AND T$PLNT<>'HK' AND T$Date BETWEEN FiscalPeriodFrom AND FiscalPeriodTo) as OQTY,
(
select max(DQUA) from 
(
select ABS(ISNULL(SUM(T$DQUA),0)) as DQUA from TFSOLP105180 
where T$PLNT<>'P1' AND T$PLNT<>'HK' AND T$PLNT<>'12' AND T$Date BETWEEN FiscalPeriodFrom AND FiscalPeriodTo 
UNION 
select ABS(ISNULL(SUM(T$DQUA),0)) as DQUA from TFSOLP105180 
WHERE T$PLNT<>'P1' AND T$PLNT<>'HK' AND T$PLNT<>'12' AND T$HKDT BETWEEN FiscalPeriodFrom AND FiscalPeriodTo 
) tb105180 
) as DQUA 
from #Tmp_PY GROUP BY FiscalYear,FiscalPeriod,FiscalPeriodFrom,FiscalPeriodTo 
) tb2

UNION ALL

select ReportCode,[Year],Period,Plant,(CASE DQUA WHEN 0 THEN 0 ELSE OQTY / DQUA * cast(power(10,6) as bigint) END) as Unit from 
(
select '001' as ReportCode,FiscalYear as [Year],FiscalPeriod as Period,'Allexclude2F' AS Plant, 
(SELECT ABS(ISNULL(SUM(T$OQTY),0)) FROM V_VWFSOLP109180 WHERE Plant<>'' AND T$PLNT<>'HK' AND T$PLNT<>'2F' AND T$Date BETWEEN FiscalPeriodFrom AND FiscalPeriodTo) as OQTY,
(
select max(DQUA)  from 
(
select ABS(ISNULL(SUM(T$DQUA),0)) as DQUA from TFSOLP105180 
where T$PLNT<>'P1' AND T$PLNT<>'HK' AND T$PLNT<>'12' AND T$PLNT<>'2F' AND T$Date BETWEEN FiscalPeriodFrom AND FiscalPeriodTo 
UNION 
select ABS(ISNULL(SUM(T$DQUA),0)) as DQUA from TFSOLP105180 
WHERE T$PLNT<>'P1' AND T$PLNT<>'HK' AND T$PLNT<>'12' AND T$PLNT<>'2F' AND T$HKDT BETWEEN FiscalPeriodFrom AND FiscalPeriodTo 
) tb105180 
) as DQUA
from #Tmp_PY GROUP BY FiscalYear,FiscalPeriod,FiscalPeriodFrom,FiscalPeriodTo 
) tb3 

) as tbtemp 

--update
UPDATE KOI_Periodly_DPPM_By_Unit SET Unit=b.Unit 
from #temp b 
WHERE KOI_Periodly_DPPM_By_Unit.ReportCode=b.ReportCode AND KOI_Periodly_DPPM_By_Unit.[Year]=b.[Year] AND KOI_Periodly_DPPM_By_Unit.Period=b.Period AND KOI_Periodly_DPPM_By_Unit.Plant=b.Plant 

--insert
INSERT INTO KOI_Periodly_DPPM_By_Unit (ReportCode,[Year],Period,Plant,Unit)
SELECT * FROM #temp a WHERE not EXISTS (SELECT * FROM KOI_Periodly_DPPM_By_Unit b WHERE a.ReportCode=b.ReportCode AND a.[Year]=b.[Year] AND a.Period=b.Period AND a.Plant=b.Plant) 



	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
--	SET NOCOUNT ON;
--
--    -- Insert statements for procedure here
--    DECLARE @FiscalYear VARCHAR(4),@FiscalPeriod INT,@FiscalPeriodFrom VARCHAR(20),@FiscalPeriodTo VARCHAR(20),@ReportCode VARCHAR(3),@Plant VARCHAR(20),@Amount NUMERIC(18,2),@SQLString VARCHAR(MAX) 
--	SET @ReportCode='001'
--
--    DECLARE TOPPeriod_C CURSOR FOR
--	SELECT FiscalYear+1 AS FiscalYear,FiscalPeriod,CONVERT(varchar(12),FiscalPeriodFrom,23) as FiscalPeriodFrom,CONVERT(varchar(12),FiscalPeriodTo,23) as FiscalPeriodTo
--	FROM  DataWarehouse.dbo.DW_DIM_Calender 
--	WHERE Calenderdate < CONVERT(VARCHAR(10),GETDATE()-1,120) AND FiscalYear>'2007'
--	GROUP BY FiscalYear,FiscalPeriod,FiscalPeriodFrom,FiscalPeriodTo
--	ORDER BY FiscalYear DESC,FiscalPeriodTo DESC 
--
--	OPEN TOPPeriod_C
--	FETCH NEXT FROM TOPPeriod_C INTO @Fiscalyear,@FiscalPeriod,@FiscalPeriodFrom,@FiscalPeriodTo
--	
--	WHILE @@FETCH_STATUS=0
--		BEGIN
--			IF @FiscalPeriodTo>CONVERT(VARCHAR(10),DATEADD(DAY,-1,GETDATE()),120)
--				BEGIN
--					SET @FiscalPeriodTo=CONVERT(VARCHAR(10),DATEADD(DAY,-1,GETDATE()),120)
--				END
--				
--			SET @Plant='B1' 
--			--DPPM=qty of defective by unit / qty of FG out by unit * 10^6
--			SET @Amount=(CASE (SELECT ABS(ISNULL(SUM(T$DQUA),0)) FROM TFSOLP105180 WHERE  T$PLNT = 'P2' AND T$Date >= @FiscalPeriodFrom AND T$HKDT <= @FiscalPeriodTo) WHEN 0 THEN 0	
--			ELSE (SELECT ABS(ISNULL(SUM(T$OQTY),0)) FROM V_VWFSOLP109180 WHERE  Plant = 'P2' AND T$Date BETWEEN @FiscalPeriodFrom AND @FiscalPeriodTo)/
--			(SELECT ABS(ISNULL(SUM(T$DQUA),0)) FROM TFSOLP105180 WHERE  T$PLNT = 'P2' AND T$Date >= @FiscalPeriodFrom AND T$HKDT <= @FiscalPeriodTo)
--				END)*cast(power(10,6) as bigint)  		
--			
--			SET @SQLString=dbo.KOI_fun_Get_Periodly_DPPM_By_Unit_SQL_String(@ReportCode,@FiscalYear,@FiscalPeriod,@Plant,@Amount)
--			EXECUTE (@SQLString)	
--
--			SET @Plant='B2F'	
--			SET @Amount=(CASE (SELECT ABS(ISNULL(SUM(T$DQUA),0)) FROM TFSOLP105180 WHERE  T$PLNT = '2F' AND T$Date >= @FiscalPeriodFrom AND T$HKDT <= @FiscalPeriodTo) WHEN 0 THEN 0	
--			ELSE (SELECT ABS(ISNULL(SUM(T$OQTY),0)) FROM V_VWFSOLP109180 WHERE  Plant = '2F' AND T$Date BETWEEN @FiscalPeriodFrom AND @FiscalPeriodTo)/
--			(SELECT ABS(ISNULL(SUM(T$DQUA),0)) FROM TFSOLP105180 WHERE  T$PLNT = '2F' AND T$Date >= @FiscalPeriodFrom AND T$HKDT <= @FiscalPeriodTo)
--				END)*cast(power(10,6) as bigint) 
--
--			SET @SQLString=dbo.KOI_fun_Get_Periodly_DPPM_By_Unit_SQL_String(@ReportCode,@FiscalYear,@FiscalPeriod,@Plant,@Amount)
--			EXECUTE (@SQLString)
--
--			SET @Plant='B3'		
--			SET @Amount=(CASE (SELECT ABS(ISNULL(SUM(T$DQUA),0)) FROM TFSOLP105180 WHERE  T$PLNT = 'B3' AND T$Date >= @FiscalPeriodFrom AND T$HKDT <= @FiscalPeriodTo) WHEN 0 THEN 0	
--			ELSE (SELECT ABS(ISNULL(SUM(T$OQTY),0)) FROM V_VWFSOLP109180 WHERE  Plant = 'B3' AND T$Date BETWEEN @FiscalPeriodFrom AND @FiscalPeriodTo)/
--			(SELECT ABS(ISNULL(SUM(T$DQUA),0)) FROM TFSOLP105180 WHERE  T$PLNT = 'B3' AND T$Date >= @FiscalPeriodFrom AND T$HKDT <= @FiscalPeriodTo)
--				END)*cast(power(10,6) as bigint) 
--
--			SET @SQLString=dbo.KOI_fun_Get_Periodly_DPPM_By_Unit_SQL_String(@ReportCode,@FiscalYear,@FiscalPeriod,@Plant,@Amount)
--			EXECUTE (@SQLString)			
--
--			SET @Plant='B4'		
--			SET @Amount=(CASE (SELECT ABS(ISNULL(SUM(T$DQUA),0)) FROM TFSOLP105180 WHERE  T$PLNT = 'B4' AND T$Date >= @FiscalPeriodFrom AND T$HKDT <= @FiscalPeriodTo) WHEN 0 THEN 0	
--			ELSE (SELECT ABS(ISNULL(SUM(T$OQTY),0)) FROM V_VWFSOLP109180 WHERE  Plant = 'B4' AND T$Date BETWEEN @FiscalPeriodFrom AND @FiscalPeriodTo)/
--			(SELECT ABS(ISNULL(SUM(T$DQUA),0)) FROM TFSOLP105180 WHERE  T$PLNT = 'B4' AND T$Date >= @FiscalPeriodFrom AND T$HKDT <= @FiscalPeriodTo)
--				END)*cast(power(10,6) as bigint) 
--
--			SET @SQLString=dbo.KOI_fun_Get_Periodly_DPPM_By_Unit_SQL_String(@ReportCode,@FiscalYear,@FiscalPeriod,@Plant,@Amount)
--			EXECUTE (@SQLString)			
--
--			SET @Plant='B5'			
--			SET @Amount=(CASE (SELECT ABS(ISNULL(SUM(T$DQUA),0)) FROM TFSOLP105180 WHERE T$PLNT = 'B5' AND T$Date >= @FiscalPeriodFrom AND T$HKDT <= @FiscalPeriodTo) WHEN 0 THEN 0	
--			ELSE (SELECT ABS(ISNULL(SUM(T$OQTY),0)) FROM V_VWFSOLP109180 WHERE  Plant = 'B5' AND T$Date BETWEEN @FiscalPeriodFrom AND @FiscalPeriodTo)/
--			(SELECT ABS(ISNULL(SUM(T$DQUA),0)) FROM TFSOLP105180 WHERE  T$PLNT = 'B5' AND T$Date >= @FiscalPeriodFrom AND T$HKDT <= @FiscalPeriodTo)
--				END)*cast(power(10,6) as bigint) 
--
--			SET @SQLString=dbo.KOI_fun_Get_Periodly_DPPM_By_Unit_SQL_String(@ReportCode,@FiscalYear,@FiscalPeriod,@Plant,@Amount)
--			EXECUTE (@SQLString)			
--
--			SET @Plant='All'	 
--			SET @Amount=(select ISNULL(SUM(Unit),0) from KOI_Periodly_DPPM_By_Unit where ReportCode=@ReportCode AND Plant<>'All' AND Plant<>'Allexclude2F' AND [Year]=@Fiscalyear AND Period=@FiscalPeriod)
--
--			SET @SQLString=dbo.KOI_fun_Get_Periodly_DPPM_By_Unit_SQL_String(@ReportCode,@FiscalYear,@FiscalPeriod,@Plant,@Amount)
--			EXECUTE (@SQLString)			
--
--			SET @Plant='Allexclude2F'	 
--			SET @Amount=(select ISNULL(SUM(Unit),0) from KOI_Periodly_DPPM_By_Unit where ReportCode=@ReportCode AND Plant<>'All' AND Plant<>'Allexclude2F' AND Plant<>'B2F' AND [Year]=@Fiscalyear AND Period=@FiscalPeriod)
--
--			SET @SQLString=dbo.KOI_fun_Get_Periodly_DPPM_By_Unit_SQL_String(@ReportCode,@FiscalYear,@FiscalPeriod,@Plant,@Amount) 
--			EXECUTE (@SQLString)			
--							
--			FETCH NEXT FROM TOPPeriod_C INTO @FiscalYear,@FiscalPeriod,@FiscalPeriodFrom,@FiscalPeriodTo
--		END
--	CLOSE TOPPeriod_C
--	DEALLOCATE TOPPeriod_C
	
END








GO
