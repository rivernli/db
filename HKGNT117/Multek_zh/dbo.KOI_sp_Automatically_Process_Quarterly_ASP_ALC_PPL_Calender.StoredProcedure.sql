USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[KOI_sp_Automatically_Process_Quarterly_ASP_ALC_PPL_Calender]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


 
CREATE PROCEDURE [dbo].[KOI_sp_Automatically_Process_Quarterly_ASP_ALC_PPL_Calender]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

select * into #temp from 
(
SELECT '002' as ReportCode,
(CASE T$PLNT WHEN '2F' THEN 'B2F' ELSE T$PLNT END )AS Plant,T$SOUR AS Sale,b.CalenderYear AS Year,b.CalenderQuarter,
ISNULL((CASE convert(numeric(18,2),SUM(T$AREA)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$AMNT)/SUM(T$AREA)) END),0) AS ASP,
ISNULL((CASE convert(numeric(18,2),SUM(T$AREA)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$LYER*T$AREA)/SUM(T$AREA)) END),0) AS ALC,
ISNULL((CASE convert(numeric(18,2),SUM(T$LYER*T$AREA)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$AMNT)/SUM(T$LYER*T$AREA)) END),0) AS PPL 
FROM TFSOLP112180 a,DataWarehouse.dbo.DW_DIM_Calender b
WHERE T$PLNT<>'HK' AND T$PLNT<>'12' AND a.T$Date=b.CalenderDate
AND b.Calenderdate < CONVERT(VARCHAR(10),GETDATE()-1,120)  AND b.CalenderYear>'2007'
GROUP BY a.T$PLNT,a.T$SOUR,b.CalenderYear,b.CalenderQuarter 
UNION ALL
SELECT '002' as ReportCode,
'All' AS Plant,T$SOUR AS Sale,b.CalenderYear AS Year,b.CalenderQuarter,
ISNULL((CASE convert(numeric(18,2),SUM(T$AREA)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$AMNT)/SUM(T$AREA)) END),0) AS ASP,
ISNULL((CASE convert(numeric(18,2),SUM(T$AREA)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$LYER*T$AREA)/SUM(T$AREA)) END),0) AS ALC,
ISNULL((CASE convert(numeric(18,2),SUM(T$LYER*T$AREA)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$AMNT)/SUM(T$LYER*T$AREA)) END),0) AS PPL 
FROM TFSOLP112180 a,DataWarehouse.dbo.DW_DIM_Calender b
WHERE T$PLNT<>'HK' AND T$PLNT<>'12' AND a.T$Date=b.CalenderDate
AND b.Calenderdate < CONVERT(VARCHAR(10),GETDATE()-1,120)  AND b.CalenderYear>'2007'
GROUP BY a.T$SOUR,b.CalenderYear,b.CalenderQuarter 
UNION ALL 
SELECT '002' as ReportCode,
'Allexclude2F' AS Plant,T$SOUR AS Sale,b.CalenderYear AS Year,b.CalenderQuarter,
ISNULL((CASE convert(numeric(18,2),SUM(T$AREA)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$AMNT)/SUM(T$AREA)) END),0) AS ASP,
ISNULL((CASE convert(numeric(18,2),SUM(T$AREA)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$LYER*T$AREA)/SUM(T$AREA)) END),0) AS ALC,
ISNULL((CASE convert(numeric(18,2),SUM(T$LYER*T$AREA)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$AMNT)/SUM(T$LYER*T$AREA)) END),0) AS PPL 
FROM TFSOLP112180 a,DataWarehouse.dbo.DW_DIM_Calender b
WHERE T$PLNT<>'HK' AND T$PLNT<>'12' AND T$PLNT<>'2F' AND a.T$Date=b.CalenderDate
AND b.Calenderdate < CONVERT(VARCHAR(10),GETDATE()-1,120)  AND b.CalenderYear>'2007'
GROUP BY a.T$SOUR,b.CalenderYear,b.CalenderQuarter 
) as tb  


--update
UPDATE KOI_Quarterly_ASP_ALC_PPL SET ASP=b.ASP,ALC=b.ALC,PPL=b.PPL 
from #temp b 
WHERE KOI_Quarterly_ASP_ALC_PPL.ReportCode=b.ReportCode AND KOI_Quarterly_ASP_ALC_PPL.[Year]=b.[Year] AND KOI_Quarterly_ASP_ALC_PPL.Quarter=b.CalenderQuarter AND KOI_Quarterly_ASP_ALC_PPL.Plant=b.Plant AND KOI_Quarterly_ASP_ALC_PPL.Sale=b.Sale 

--insert
INSERT INTO KOI_Quarterly_ASP_ALC_PPL (ReportCode,Plant,Sale,[Year],[Quarter],ASP,ALC,PPL)
SELECT * FROM #temp a WHERE not EXISTS (SELECT * FROM KOI_Quarterly_ASP_ALC_PPL b 
WHERE a.ReportCode=b.ReportCode AND a.[Year]=b.[Year] AND a.CalenderQuarter=b.[Quarter] AND a.Plant=b.Plant AND a.Sale=b.Sale) 


--    -- Insert statements for procedure here
--    DECLARE @CalenderYear VARCHAR(4),@CalenderQuarter INT,@CalenderDateFrom VARCHAR(20),@CalenderDateTo VARCHAR(20),@ReportCode VARCHAR(3),@Plant NVARCHAR(50),@Sale NVARCHAR(50),@ASP NUMERIC(18,2),@ALC NUMERIC(18,2),@PPL NUMERIC(18,2),@SQLString VARCHAR(MAX) 
--	SET @ReportCode='002'
--
--    DECLARE ASP_ALC_PPL_CalenderQuarter_C CURSOR FOR 
--	SELECT CalenderYear,CalenderQuarter,CalenderDateFrom,CalenderDateTo 
--	FROM vw_KOI_Calender_Quarter WHERE CalenderYear>'2007'
--	GROUP BY CalenderYear,CalenderQuarter,CalenderDateFrom,CalenderDateTo 
--	ORDER BY CalenderYear DESC,CalenderDateTo DESC 
--
--	OPEN ASP_ALC_PPL_CalenderQuarter_C 
--	FETCH NEXT FROM ASP_ALC_PPL_CalenderQuarter_C INTO @CalenderYear,@CalenderQuarter,@CalenderDateFrom,@CalenderDateTo 
--	
--	WHILE @@FETCH_STATUS=0
--		BEGIN
--			IF @CalenderDateTo>CONVERT(VARCHAR(10),DATEADD(DAY,-1,GETDATE()),120)
--				BEGIN
--					SET @CalenderDateTo=CONVERT(VARCHAR(10),DATEADD(DAY,-1,GETDATE()),120)
--				END
--				
--			SET @Plant='B1'		
--				SET @Sale='Ex-factory Sale               '
--				SET @ASP = (SELECT ISNULL((CASE convert(numeric(18,2),SUM(T$AREA)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$AMNT)/SUM(T$AREA)) END),0) AS ASP from TFSOLP112180 WHERE T$PLNT=@Plant AND T$SOUR=@Sale AND T$Date BETWEEN @CalenderDateFrom AND @CalenderDateTo)
--				SET @ALC = (SELECT ISNULL((CASE convert(numeric(18,2),SUM(T$AREA)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$LYER*T$AREA)/SUM(T$AREA)) END),0) AS ALC from TFSOLP112180 WHERE T$PLNT=@Plant AND T$SOUR=@Sale AND T$Date BETWEEN @CalenderDateFrom AND @CalenderDateTo) 
--				SET @PPL = (SELECT ISNULL((CASE convert(numeric(18,2),SUM(T$LYER*T$AREA)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$AMNT)/SUM(T$LYER*T$AREA)) END),0) AS PPL from TFSOLP112180 WHERE T$PLNT=@Plant AND T$SOUR=@Sale AND T$Date BETWEEN @CalenderDateFrom AND @CalenderDateTo) 
--				SET @SQLString=dbo.KOI_fun_Get_Quarterly_ASP_ALC_PPL_SQL_String(@ReportCode,@CalenderYear,@CalenderQuarter,@Plant,@Sale,@ASP,@ALC,@PPL)
--				EXECUTE (@SQLString)
--				SET @Sale='Invoice Sale                  '
--				SET @ASP = (SELECT ISNULL((CASE convert(numeric(18,2),SUM(T$AREA)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$AMNT)/SUM(T$AREA)) END),0) AS ASP from TFSOLP112180 WHERE T$PLNT=@Plant AND T$SOUR=@Sale AND T$Date BETWEEN @CalenderDateFrom AND @CalenderDateTo)
--				SET @ALC = (SELECT ISNULL((CASE convert(numeric(18,2),SUM(T$AREA)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$LYER*T$AREA)/SUM(T$AREA)) END),0) AS ALC from TFSOLP112180 WHERE T$PLNT=@Plant AND T$SOUR=@Sale AND T$Date BETWEEN @CalenderDateFrom AND @CalenderDateTo) 
--				SET @PPL = (SELECT ISNULL((CASE convert(numeric(18,2),SUM(T$LYER*T$AREA)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$AMNT)/SUM(T$LYER*T$AREA)) END),0) AS PPL from TFSOLP112180 WHERE T$PLNT=@Plant AND T$SOUR=@Sale AND T$Date BETWEEN @CalenderDateFrom AND @CalenderDateTo) 
--				SET @SQLString=dbo.KOI_fun_Get_Quarterly_ASP_ALC_PPL_SQL_String(@ReportCode,@CalenderYear,@CalenderQuarter,@Plant,@Sale,@ASP,@ALC,@PPL)
--				EXECUTE (@SQLString)
--				SET @Sale='Production output             '	 
--				SET @ASP = (SELECT ISNULL((CASE convert(numeric(18,2),SUM(T$AREA)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$AMNT)/SUM(T$AREA)) END),0) AS ASP from TFSOLP112180 WHERE T$PLNT=@Plant AND T$SOUR=@Sale AND T$Date BETWEEN @CalenderDateFrom AND @CalenderDateTo)
--				SET @ALC = (SELECT ISNULL((CASE convert(numeric(18,2),SUM(T$AREA)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$LYER*T$AREA)/SUM(T$AREA)) END),0) AS ALC from TFSOLP112180 WHERE T$PLNT=@Plant AND T$SOUR=@Sale AND T$Date BETWEEN @CalenderDateFrom AND @CalenderDateTo) 
--				SET @PPL = (SELECT ISNULL((CASE convert(numeric(18,2),SUM(T$LYER*T$AREA)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$AMNT)/SUM(T$LYER*T$AREA)) END),0) AS PPL from TFSOLP112180 WHERE T$PLNT=@Plant AND T$SOUR=@Sale AND T$Date BETWEEN @CalenderDateFrom AND @CalenderDateTo) 
--				SET @SQLString=dbo.KOI_fun_Get_Quarterly_ASP_ALC_PPL_SQL_String(@ReportCode,@CalenderYear,@CalenderQuarter,@Plant,@Sale,@ASP,@ALC,@PPL)
--				EXECUTE (@SQLString)			
--
--			SET @Plant='B2F' 
--				SET @Sale='Ex-factory Sale               '
--				SET @ASP = (SELECT ISNULL((CASE convert(numeric(18,2),SUM(T$AREA)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$AMNT)/SUM(T$AREA)) END),0) AS ASP from TFSOLP112180 WHERE T$PLNT='2F' AND T$SOUR=@Sale AND T$Date BETWEEN @CalenderDateFrom AND @CalenderDateTo)
--				SET @ALC = (SELECT ISNULL((CASE convert(numeric(18,2),SUM(T$AREA)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$LYER*T$AREA)/SUM(T$AREA)) END),0) AS ALC from TFSOLP112180 WHERE T$PLNT='2F' AND T$SOUR=@Sale AND T$Date BETWEEN @CalenderDateFrom AND @CalenderDateTo) 
--				SET @PPL = (SELECT ISNULL((CASE convert(numeric(18,2),SUM(T$LYER*T$AREA)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$AMNT)/SUM(T$LYER*T$AREA)) END),0) AS PPL from TFSOLP112180 WHERE T$PLNT='2F' AND T$SOUR=@Sale AND T$Date BETWEEN @CalenderDateFrom AND @CalenderDateTo) 
--				SET @SQLString=dbo.KOI_fun_Get_Quarterly_ASP_ALC_PPL_SQL_String(@ReportCode,@CalenderYear,@CalenderQuarter,@Plant,@Sale,@ASP,@ALC,@PPL)
--				EXECUTE (@SQLString)
--				SET @Sale='Invoice Sale                  '
--				SET @ASP = (SELECT ISNULL((CASE convert(numeric(18,2),SUM(T$AREA)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$AMNT)/SUM(T$AREA)) END),0) AS ASP from TFSOLP112180 WHERE T$PLNT='2F' AND T$SOUR=@Sale AND T$Date BETWEEN @CalenderDateFrom AND @CalenderDateTo)
--				SET @ALC = (SELECT ISNULL((CASE convert(numeric(18,2),SUM(T$AREA)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$LYER*T$AREA)/SUM(T$AREA)) END),0) AS ALC from TFSOLP112180 WHERE T$PLNT='2F' AND T$SOUR=@Sale AND T$Date BETWEEN @CalenderDateFrom AND @CalenderDateTo) 
--				SET @PPL = (SELECT ISNULL((CASE convert(numeric(18,2),SUM(T$LYER*T$AREA)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$AMNT)/SUM(T$LYER*T$AREA)) END),0) AS PPL from TFSOLP112180 WHERE T$PLNT='2F' AND T$SOUR=@Sale AND T$Date BETWEEN @CalenderDateFrom AND @CalenderDateTo) 
--				SET @SQLString=dbo.KOI_fun_Get_Quarterly_ASP_ALC_PPL_SQL_String(@ReportCode,@CalenderYear,@CalenderQuarter,@Plant,@Sale,@ASP,@ALC,@PPL)
--				EXECUTE (@SQLString)
--				SET @Sale='Production output             '	 
--				SET @ASP = (SELECT ISNULL((CASE convert(numeric(18,2),SUM(T$AREA)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$AMNT)/SUM(T$AREA)) END),0) AS ASP from TFSOLP112180 WHERE T$PLNT='2F' AND T$SOUR=@Sale AND T$Date BETWEEN @CalenderDateFrom AND @CalenderDateTo)
--				SET @ALC = (SELECT ISNULL((CASE convert(numeric(18,2),SUM(T$AREA)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$LYER*T$AREA)/SUM(T$AREA)) END),0) AS ALC from TFSOLP112180 WHERE T$PLNT='2F' AND T$SOUR=@Sale AND T$Date BETWEEN @CalenderDateFrom AND @CalenderDateTo) 
--				SET @PPL = (SELECT ISNULL((CASE convert(numeric(18,2),SUM(T$LYER*T$AREA)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$AMNT)/SUM(T$LYER*T$AREA)) END),0) AS PPL from TFSOLP112180 WHERE T$PLNT='2F' AND T$SOUR=@Sale AND T$Date BETWEEN @CalenderDateFrom AND @CalenderDateTo) 
--				SET @SQLString=dbo.KOI_fun_Get_Quarterly_ASP_ALC_PPL_SQL_String(@ReportCode,@CalenderYear,@CalenderQuarter,@Plant,@Sale,@ASP,@ALC,@PPL)
--				EXECUTE (@SQLString)
--
--			SET @Plant='B3' 
--			SET @Sale='Ex-factory Sale               '
--				SET @ASP = (SELECT ISNULL((CASE convert(numeric(18,2),SUM(T$AREA)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$AMNT)/SUM(T$AREA)) END),0) AS ASP from TFSOLP112180 WHERE T$PLNT=@Plant AND T$SOUR=@Sale AND T$Date BETWEEN @CalenderDateFrom AND @CalenderDateTo)
--				SET @ALC = (SELECT ISNULL((CASE convert(numeric(18,2),SUM(T$AREA)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$LYER*T$AREA)/SUM(T$AREA)) END),0) AS ALC from TFSOLP112180 WHERE T$PLNT=@Plant AND T$SOUR=@Sale AND T$Date BETWEEN @CalenderDateFrom AND @CalenderDateTo) 
--				SET @PPL = (SELECT ISNULL((CASE convert(numeric(18,2),SUM(T$LYER*T$AREA)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$AMNT)/SUM(T$LYER*T$AREA)) END),0) AS PPL from TFSOLP112180 WHERE T$PLNT=@Plant AND T$SOUR=@Sale AND T$Date BETWEEN @CalenderDateFrom AND @CalenderDateTo) 
--				SET @SQLString=dbo.KOI_fun_Get_Quarterly_ASP_ALC_PPL_SQL_String(@ReportCode,@CalenderYear,@CalenderQuarter,@Plant,@Sale,@ASP,@ALC,@PPL)
--				EXECUTE (@SQLString)
--				SET @Sale='Invoice Sale                  '
--				SET @ASP = (SELECT ISNULL((CASE convert(numeric(18,2),SUM(T$AREA)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$AMNT)/SUM(T$AREA)) END),0) AS ASP from TFSOLP112180 WHERE T$PLNT=@Plant AND T$SOUR=@Sale AND T$Date BETWEEN @CalenderDateFrom AND @CalenderDateTo)
--				SET @ALC = (SELECT ISNULL((CASE convert(numeric(18,2),SUM(T$AREA)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$LYER*T$AREA)/SUM(T$AREA)) END),0) AS ALC from TFSOLP112180 WHERE T$PLNT=@Plant AND T$SOUR=@Sale AND T$Date BETWEEN @CalenderDateFrom AND @CalenderDateTo) 
--				SET @PPL = (SELECT ISNULL((CASE convert(numeric(18,2),SUM(T$LYER*T$AREA)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$AMNT)/SUM(T$LYER*T$AREA)) END),0) AS PPL from TFSOLP112180 WHERE T$PLNT=@Plant AND T$SOUR=@Sale AND T$Date BETWEEN @CalenderDateFrom AND @CalenderDateTo) 
--				SET @SQLString=dbo.KOI_fun_Get_Quarterly_ASP_ALC_PPL_SQL_String(@ReportCode,@CalenderYear,@CalenderQuarter,@Plant,@Sale,@ASP,@ALC,@PPL)
--				EXECUTE (@SQLString)
--				SET @Sale='Production output             '	 
--				SET @ASP = (SELECT ISNULL((CASE convert(numeric(18,2),SUM(T$AREA)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$AMNT)/SUM(T$AREA)) END),0) AS ASP from TFSOLP112180 WHERE T$PLNT=@Plant AND T$SOUR=@Sale AND T$Date BETWEEN @CalenderDateFrom AND @CalenderDateTo)
--				SET @ALC = (SELECT ISNULL((CASE convert(numeric(18,2),SUM(T$AREA)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$LYER*T$AREA)/SUM(T$AREA)) END),0) AS ALC from TFSOLP112180 WHERE T$PLNT=@Plant AND T$SOUR=@Sale AND T$Date BETWEEN @CalenderDateFrom AND @CalenderDateTo) 
--				SET @PPL = (SELECT ISNULL((CASE convert(numeric(18,2),SUM(T$LYER*T$AREA)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$AMNT)/SUM(T$LYER*T$AREA)) END),0) AS PPL from TFSOLP112180 WHERE T$PLNT=@Plant AND T$SOUR=@Sale AND T$Date BETWEEN @CalenderDateFrom AND @CalenderDateTo) 
--				SET @SQLString=dbo.KOI_fun_Get_Quarterly_ASP_ALC_PPL_SQL_String(@ReportCode,@CalenderYear,@CalenderQuarter,@Plant,@Sale,@ASP,@ALC,@PPL)
--				EXECUTE (@SQLString)
--
--			SET @Plant='B4' 
--				SET @Sale='Ex-factory Sale               '
--				SET @ASP = (SELECT ISNULL((CASE convert(numeric(18,2),SUM(T$AREA)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$AMNT)/SUM(T$AREA)) END),0) AS ASP from TFSOLP112180 WHERE T$PLNT=@Plant AND T$SOUR=@Sale AND T$Date BETWEEN @CalenderDateFrom AND @CalenderDateTo)
--				SET @ALC = (SELECT ISNULL((CASE convert(numeric(18,2),SUM(T$AREA)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$LYER*T$AREA)/SUM(T$AREA)) END),0) AS ALC from TFSOLP112180 WHERE T$PLNT=@Plant AND T$SOUR=@Sale AND T$Date BETWEEN @CalenderDateFrom AND @CalenderDateTo) 
--				SET @PPL = (SELECT ISNULL((CASE convert(numeric(18,2),SUM(T$LYER*T$AREA)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$AMNT)/SUM(T$LYER*T$AREA)) END),0) AS PPL from TFSOLP112180 WHERE T$PLNT=@Plant AND T$SOUR=@Sale AND T$Date BETWEEN @CalenderDateFrom AND @CalenderDateTo) 
--				SET @SQLString=dbo.KOI_fun_Get_Quarterly_ASP_ALC_PPL_SQL_String(@ReportCode,@CalenderYear,@CalenderQuarter,@Plant,@Sale,@ASP,@ALC,@PPL)
--				EXECUTE (@SQLString)
--				SET @Sale='Invoice Sale                  '
--				SET @ASP = (SELECT ISNULL((CASE convert(numeric(18,2),SUM(T$AREA)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$AMNT)/SUM(T$AREA)) END),0) AS ASP from TFSOLP112180 WHERE T$PLNT=@Plant AND T$SOUR=@Sale AND T$Date BETWEEN @CalenderDateFrom AND @CalenderDateTo)
--				SET @ALC = (SELECT ISNULL((CASE convert(numeric(18,2),SUM(T$AREA)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$LYER*T$AREA)/SUM(T$AREA)) END),0) AS ALC from TFSOLP112180 WHERE T$PLNT=@Plant AND T$SOUR=@Sale AND T$Date BETWEEN @CalenderDateFrom AND @CalenderDateTo) 
--				SET @PPL = (SELECT ISNULL((CASE convert(numeric(18,2),SUM(T$LYER*T$AREA)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$AMNT)/SUM(T$LYER*T$AREA)) END),0) AS PPL from TFSOLP112180 WHERE T$PLNT=@Plant AND T$SOUR=@Sale AND T$Date BETWEEN @CalenderDateFrom AND @CalenderDateTo) 
--				SET @SQLString=dbo.KOI_fun_Get_Quarterly_ASP_ALC_PPL_SQL_String(@ReportCode,@CalenderYear,@CalenderQuarter,@Plant,@Sale,@ASP,@ALC,@PPL)
--				EXECUTE (@SQLString)
--				SET @Sale='Production output             '	 
--				SET @ASP = (SELECT ISNULL((CASE convert(numeric(18,2),SUM(T$AREA)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$AMNT)/SUM(T$AREA)) END),0) AS ASP from TFSOLP112180 WHERE T$PLNT=@Plant AND T$SOUR=@Sale AND T$Date BETWEEN @CalenderDateFrom AND @CalenderDateTo)
--				SET @ALC = (SELECT ISNULL((CASE convert(numeric(18,2),SUM(T$AREA)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$LYER*T$AREA)/SUM(T$AREA)) END),0) AS ALC from TFSOLP112180 WHERE T$PLNT=@Plant AND T$SOUR=@Sale AND T$Date BETWEEN @CalenderDateFrom AND @CalenderDateTo) 
--				SET @PPL = (SELECT ISNULL((CASE convert(numeric(18,2),SUM(T$LYER*T$AREA)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$AMNT)/SUM(T$LYER*T$AREA)) END),0) AS PPL from TFSOLP112180 WHERE T$PLNT=@Plant AND T$SOUR=@Sale AND T$Date BETWEEN @CalenderDateFrom AND @CalenderDateTo) 
--				SET @SQLString=dbo.KOI_fun_Get_Quarterly_ASP_ALC_PPL_SQL_String(@ReportCode,@CalenderYear,@CalenderQuarter,@Plant,@Sale,@ASP,@ALC,@PPL)
--				EXECUTE (@SQLString)
--
--			SET @Plant='B5' 
--				SET @Sale='Ex-factory Sale               '
--				SET @ASP = (SELECT ISNULL((CASE convert(numeric(18,2),SUM(T$AREA)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$AMNT)/SUM(T$AREA)) END),0) AS ASP from TFSOLP112180 WHERE T$PLNT=@Plant AND T$SOUR=@Sale AND T$Date BETWEEN @CalenderDateFrom AND @CalenderDateTo)
--				SET @ALC = (SELECT ISNULL((CASE convert(numeric(18,2),SUM(T$AREA)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$LYER*T$AREA)/SUM(T$AREA)) END),0) AS ALC from TFSOLP112180 WHERE T$PLNT=@Plant AND T$SOUR=@Sale AND T$Date BETWEEN @CalenderDateFrom AND @CalenderDateTo) 
--				SET @PPL = (SELECT ISNULL((CASE convert(numeric(18,2),SUM(T$LYER*T$AREA)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$AMNT)/SUM(T$LYER*T$AREA)) END),0) AS PPL from TFSOLP112180 WHERE T$PLNT=@Plant AND T$SOUR=@Sale AND T$Date BETWEEN @CalenderDateFrom AND @CalenderDateTo) 
--				SET @SQLString=dbo.KOI_fun_Get_Quarterly_ASP_ALC_PPL_SQL_String(@ReportCode,@CalenderYear,@CalenderQuarter,@Plant,@Sale,@ASP,@ALC,@PPL)
--				EXECUTE (@SQLString)
--				SET @Sale='Invoice Sale                  '
--				SET @ASP = (SELECT ISNULL((CASE convert(numeric(18,2),SUM(T$AREA)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$AMNT)/SUM(T$AREA)) END),0) AS ASP from TFSOLP112180 WHERE T$PLNT=@Plant AND T$SOUR=@Sale AND T$Date BETWEEN @CalenderDateFrom AND @CalenderDateTo)
--				SET @ALC = (SELECT ISNULL((CASE convert(numeric(18,2),SUM(T$AREA)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$LYER*T$AREA)/SUM(T$AREA)) END),0) AS ALC from TFSOLP112180 WHERE T$PLNT=@Plant AND T$SOUR=@Sale AND T$Date BETWEEN @CalenderDateFrom AND @CalenderDateTo) 
--				SET @PPL = (SELECT ISNULL((CASE convert(numeric(18,2),SUM(T$LYER*T$AREA)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$AMNT)/SUM(T$LYER*T$AREA)) END),0) AS PPL from TFSOLP112180 WHERE T$PLNT=@Plant AND T$SOUR=@Sale AND T$Date BETWEEN @CalenderDateFrom AND @CalenderDateTo) 
--				SET @SQLString=dbo.KOI_fun_Get_Quarterly_ASP_ALC_PPL_SQL_String(@ReportCode,@CalenderYear,@CalenderQuarter,@Plant,@Sale,@ASP,@ALC,@PPL)
--				EXECUTE (@SQLString)
--				SET @Sale='Production output             '	 
--				SET @ASP = (SELECT ISNULL((CASE convert(numeric(18,2),SUM(T$AREA)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$AMNT)/SUM(T$AREA)) END),0) AS ASP from TFSOLP112180 WHERE T$PLNT=@Plant AND T$SOUR=@Sale AND T$Date BETWEEN @CalenderDateFrom AND @CalenderDateTo)
--				SET @ALC = (SELECT ISNULL((CASE convert(numeric(18,2),SUM(T$AREA)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$LYER*T$AREA)/SUM(T$AREA)) END),0) AS ALC from TFSOLP112180 WHERE T$PLNT=@Plant AND T$SOUR=@Sale AND T$Date BETWEEN @CalenderDateFrom AND @CalenderDateTo) 
--				SET @PPL = (SELECT ISNULL((CASE convert(numeric(18,2),SUM(T$LYER*T$AREA)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$AMNT)/SUM(T$LYER*T$AREA)) END),0) AS PPL from TFSOLP112180 WHERE T$PLNT=@Plant AND T$SOUR=@Sale AND T$Date BETWEEN @CalenderDateFrom AND @CalenderDateTo) 
--				SET @SQLString=dbo.KOI_fun_Get_Quarterly_ASP_ALC_PPL_SQL_String(@ReportCode,@CalenderYear,@CalenderQuarter,@Plant,@Sale,@ASP,@ALC,@PPL)
--				EXECUTE (@SQLString)
--
--			SET @Plant='All'
--				SET @Sale='Ex-factory Sale               '
--				SET @ASP=(select ISNULL(SUM(ASP),0) from KOI_Quarterly_ASP_ALC_PPL where ReportCode=@ReportCode AND Plant<>'All' AND Plant<>'Allexclude2F' AND Sale=@Sale AND [Year]=@CalenderYear AND Quarter=@CalenderQuarter) 
--				SET @ALC=(select ISNULL(SUM(ALC),0) from KOI_Quarterly_ASP_ALC_PPL where ReportCode=@ReportCode AND Plant<>'All' AND Plant<>'Allexclude2F' AND Sale=@Sale AND [Year]=@CalenderYear AND Quarter=@CalenderQuarter) 
--				SET @PPL=(select ISNULL(SUM(PPL),0) from KOI_Quarterly_ASP_ALC_PPL where ReportCode=@ReportCode AND Plant<>'All' AND Plant<>'Allexclude2F' AND Sale=@Sale AND [Year]=@CalenderYear AND Quarter=@CalenderQuarter) 
--				SET @SQLString=dbo.KOI_fun_Get_Quarterly_ASP_ALC_PPL_SQL_String(@ReportCode,@CalenderYear,@CalenderQuarter,@Plant,@Sale,@ASP,@ALC,@PPL) 
--				EXECUTE (@SQLString)
--				SET @Sale='Invoice Sale                  '
--				SET @ASP=(select ISNULL(SUM(ASP),0) from KOI_Quarterly_ASP_ALC_PPL where ReportCode=@ReportCode AND Plant<>'All' AND Plant<>'Allexclude2F' AND Sale=@Sale AND [Year]=@CalenderYear AND Quarter=@CalenderQuarter) 
--				SET @ALC=(select ISNULL(SUM(ALC),0) from KOI_Quarterly_ASP_ALC_PPL where ReportCode=@ReportCode AND Plant<>'All' AND Plant<>'Allexclude2F' AND Sale=@Sale AND [Year]=@CalenderYear AND Quarter=@CalenderQuarter) 
--				SET @PPL=(select ISNULL(SUM(PPL),0) from KOI_Quarterly_ASP_ALC_PPL where ReportCode=@ReportCode AND Plant<>'All' AND Plant<>'Allexclude2F' AND Sale=@Sale AND [Year]=@CalenderYear AND Quarter=@CalenderQuarter) 
--				SET @SQLString=dbo.KOI_fun_Get_Quarterly_ASP_ALC_PPL_SQL_String(@ReportCode,@CalenderYear,@CalenderQuarter,@Plant,@Sale,@ASP,@ALC,@PPL) 
--				EXECUTE (@SQLString)
--				SET @Sale='Production output             '	 
--				SET @ASP=(select ISNULL(SUM(ASP),0) from KOI_Quarterly_ASP_ALC_PPL where ReportCode=@ReportCode AND Plant<>'All' AND Plant<>'Allexclude2F' AND Sale=@Sale AND [Year]=@CalenderYear AND Quarter=@CalenderQuarter) 
--				SET @ALC=(select ISNULL(SUM(ALC),0) from KOI_Quarterly_ASP_ALC_PPL where ReportCode=@ReportCode AND Plant<>'All' AND Plant<>'Allexclude2F' AND Sale=@Sale AND [Year]=@CalenderYear AND Quarter=@CalenderQuarter) 
--				SET @PPL=(select ISNULL(SUM(PPL),0) from KOI_Quarterly_ASP_ALC_PPL where ReportCode=@ReportCode AND Plant<>'All' AND Plant<>'Allexclude2F' AND Sale=@Sale AND [Year]=@CalenderYear AND Quarter=@CalenderQuarter) 
--				SET @SQLString=dbo.KOI_fun_Get_Quarterly_ASP_ALC_PPL_SQL_String(@ReportCode,@CalenderYear,@CalenderQuarter,@Plant,@Sale,@ASP,@ALC,@PPL) 
--				EXECUTE (@SQLString)
--
--			SET @Plant='Allexclude2F'	
--				SET @Sale='Ex-factory Sale               '				
--				SET @ASP=(select ISNULL(SUM(ASP),0) from KOI_Quarterly_ASP_ALC_PPL where ReportCode=@ReportCode AND Plant<>'All' AND Plant<>'Allexclude2F' AND Plant<>'B2F' AND Sale=@Sale AND [Year]=@CalenderYear AND Quarter=@CalenderQuarter)
--				SET @ALC=(select ISNULL(SUM(ALC),0) from KOI_Quarterly_ASP_ALC_PPL where ReportCode=@ReportCode AND Plant<>'All' AND Plant<>'Allexclude2F' AND Plant<>'B2F' AND Sale=@Sale AND [Year]=@CalenderYear AND Quarter=@CalenderQuarter)
--				SET @PPL=(select ISNULL(SUM(PPL),0) from KOI_Quarterly_ASP_ALC_PPL where ReportCode=@ReportCode AND Plant<>'All' AND Plant<>'Allexclude2F' AND Plant<>'B2F' AND Sale=@Sale AND [Year]=@CalenderYear AND Quarter=@CalenderQuarter)
--				SET @SQLString=dbo.KOI_fun_Get_Quarterly_ASP_ALC_PPL_SQL_String(@ReportCode,@CalenderYear,@CalenderQuarter,@Plant,@Sale,@ASP,@ALC,@PPL) 
--				EXECUTE (@SQLString)		
--				SET @Sale='Invoice Sale                  '
--				SET @ASP=(select ISNULL(SUM(ASP),0) from KOI_Quarterly_ASP_ALC_PPL where ReportCode=@ReportCode AND Plant<>'All' AND Plant<>'Allexclude2F' AND Plant<>'B2F' AND Sale=@Sale AND [Year]=@CalenderYear AND Quarter=@CalenderQuarter)
--				SET @ALC=(select ISNULL(SUM(ALC),0) from KOI_Quarterly_ASP_ALC_PPL where ReportCode=@ReportCode AND Plant<>'All' AND Plant<>'Allexclude2F' AND Plant<>'B2F' AND Sale=@Sale AND [Year]=@CalenderYear AND Quarter=@CalenderQuarter)
--				SET @PPL=(select ISNULL(SUM(PPL),0) from KOI_Quarterly_ASP_ALC_PPL where ReportCode=@ReportCode AND Plant<>'All' AND Plant<>'Allexclude2F' AND Plant<>'B2F' AND Sale=@Sale AND [Year]=@CalenderYear AND Quarter=@CalenderQuarter)
--				SET @SQLString=dbo.KOI_fun_Get_Quarterly_ASP_ALC_PPL_SQL_String(@ReportCode,@CalenderYear,@CalenderQuarter,@Plant,@Sale,@ASP,@ALC,@PPL) 
--				EXECUTE (@SQLString)	
--				SET @Sale='Production output             '	 
--				SET @ASP=(select ISNULL(SUM(ASP),0) from KOI_Quarterly_ASP_ALC_PPL where ReportCode=@ReportCode AND Plant<>'All' AND Plant<>'Allexclude2F' AND Plant<>'B2F' AND Sale=@Sale AND [Year]=@CalenderYear AND Quarter=@CalenderQuarter)
--				SET @ALC=(select ISNULL(SUM(ALC),0) from KOI_Quarterly_ASP_ALC_PPL where ReportCode=@ReportCode AND Plant<>'All' AND Plant<>'Allexclude2F' AND Plant<>'B2F' AND Sale=@Sale AND [Year]=@CalenderYear AND Quarter=@CalenderQuarter)
--				SET @PPL=(select ISNULL(SUM(PPL),0) from KOI_Quarterly_ASP_ALC_PPL where ReportCode=@ReportCode AND Plant<>'All' AND Plant<>'Allexclude2F' AND Plant<>'B2F' AND Sale=@Sale AND [Year]=@CalenderYear AND Quarter=@CalenderQuarter)
--				SET @SQLString=dbo.KOI_fun_Get_Quarterly_ASP_ALC_PPL_SQL_String(@ReportCode,@CalenderYear,@CalenderQuarter,@Plant,@Sale,@ASP,@ALC,@PPL) 
--				EXECUTE (@SQLString)	
--							
--			FETCH NEXT FROM ASP_ALC_PPL_CalenderQuarter_C INTO @CalenderYear,@CalenderQuarter,@CalenderDateFrom,@CalenderDateTo 
--		END
--	CLOSE ASP_ALC_PPL_CalenderQuarter_C
--	DEALLOCATE ASP_ALC_PPL_CalenderQuarter_C
	
END










GO
