USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[KOI_sp_Automatically_Process_Quarterly_Number_of_Projects_Fiscal]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[KOI_sp_Automatically_Process_Quarterly_Number_of_Projects_Fiscal]
	-- Add the parameters for the stored procedure here
AS
BEGIN 

SELECT * INTO #Tmp_PY FROM 
(
		SELECT T$PLNT FROM TFSOLP107180 WHERE T$PLNT<>'12' AND T$PLNT<>'HK' GROUP BY T$PLNT 
) AS T1
 JOIN
(
	SELECT FiscalYear+1 AS FiscalYear,FiscalQuarter,FiscalQuarterFrom, FiscalQuarterTo FROM DataWarehouse.dbo.DW_DIM_Calender
	WHERE Calenderdate < CONVERT(VARCHAR(10),GETDATE()-1,120) AND FiscalYear>'2007'
	GROUP BY FiscalYear,FiscalQuarter,FiscalQuarterFrom, FiscalQuarterTo 
) AS T2
ON 1 =1 


SELECT * INTO #Tmp_PY_Group FROM 
(
select FiscalYear,FiscalQuarter,FiscalQuarterFrom, FiscalQuarterTo from #Tmp_PY group by FiscalYear,FiscalQuarter,FiscalQuarterFrom, FiscalQuarterTo
) as T3


select * into #temp from 
(
--FGIn 
select *,Over1000Sqft+To501_1000Sqft+To301_500Sqft+To101_300Sqft+To100Sqft as Total 
from (
select '001' as ReportCode,FiscalYear as [Year],FiscalQuarter as Quarter,(CASE T$PLNT WHEN 'P2' THEN 'B1' WHEN '2F' THEN 'B2F' ELSE T$PLNT END )AS Plant,'FGIn' as Sale,
(SELECT COUNT(T$SQFT) from TFSOLP107180 WHERE T$PLNT=#Tmp_PY.T$PLNT AND T$Date BETWEEN FiscalQuarterFrom AND FiscalQuarterTo AND T$SQFT>1000) as Over1000Sqft,
(SELECT COUNT(T$SQFT) from TFSOLP107180 WHERE T$PLNT=#Tmp_PY.T$PLNT AND T$Date BETWEEN FiscalQuarterFrom AND FiscalQuarterTo AND T$SQFT BETWEEN 501 AND 1000) as To501_1000Sqft,
(SELECT COUNT(T$SQFT) from TFSOLP107180 WHERE T$PLNT=#Tmp_PY.T$PLNT AND T$Date BETWEEN FiscalQuarterFrom AND FiscalQuarterTo AND T$SQFT BETWEEN 301 AND 500) as To301_500Sqft, 
(SELECT COUNT(T$SQFT) from TFSOLP107180 WHERE T$PLNT=#Tmp_PY.T$PLNT AND T$Date BETWEEN FiscalQuarterFrom AND FiscalQuarterTo AND T$SQFT BETWEEN 101 AND 300) as To101_300Sqft, 
(SELECT COUNT(T$SQFT) from TFSOLP107180 WHERE T$PLNT=#Tmp_PY.T$PLNT AND T$Date BETWEEN FiscalQuarterFrom AND FiscalQuarterTo AND T$SQFT <=100) as To100Sqft 
from #Tmp_PY 
) tb1
UNION ALL
select *,Over1000Sqft+To501_1000Sqft+To301_500Sqft+To101_300Sqft+To100Sqft as Total 
from (
select '001' as ReportCode,FiscalYear as [Year],FiscalQuarter as Quarter,'All' AS Plant,'FGIn' as Sale,
(SELECT COUNT(T$SQFT) from TFSOLP107180 WHERE T$PLNT<>'12' AND T$PLNT<>'HK' AND T$Date BETWEEN FiscalQuarterFrom AND FiscalQuarterTo AND T$SQFT>1000) as Over1000Sqft,
(SELECT COUNT(T$SQFT) from TFSOLP107180 WHERE T$PLNT<>'12' AND T$PLNT<>'HK' AND T$Date BETWEEN FiscalQuarterFrom AND FiscalQuarterTo AND T$SQFT BETWEEN 501 AND 1000) as To501_1000Sqft,
(SELECT COUNT(T$SQFT) from TFSOLP107180 WHERE T$PLNT<>'12' AND T$PLNT<>'HK' AND T$Date BETWEEN FiscalQuarterFrom AND FiscalQuarterTo AND T$SQFT BETWEEN 301 AND 500) as To301_500Sqft, 
(SELECT COUNT(T$SQFT) from TFSOLP107180 WHERE T$PLNT<>'12' AND T$PLNT<>'HK' AND T$Date BETWEEN FiscalQuarterFrom AND FiscalQuarterTo AND T$SQFT BETWEEN 101 AND 300) as To101_300Sqft, 
(SELECT COUNT(T$SQFT) from TFSOLP107180 WHERE T$PLNT<>'12' AND T$PLNT<>'HK' AND T$Date BETWEEN FiscalQuarterFrom AND FiscalQuarterTo AND T$SQFT <=100) as To100Sqft 
from #Tmp_PY_Group
) tb1All
UNION ALL
select *,Over1000Sqft+To501_1000Sqft+To301_500Sqft+To101_300Sqft+To100Sqft as Total 
from (
select '001' as ReportCode,FiscalYear as [Year],FiscalQuarter as Quarter,'Allexclude2F' AS Plant,'FGIn' as Sale,
(SELECT COUNT(T$SQFT) from TFSOLP107180 WHERE T$PLNT<>'12' AND T$PLNT<>'HK' AND T$PLNT<>'2F' AND T$Date BETWEEN FiscalQuarterFrom AND FiscalQuarterTo AND T$SQFT>1000) as Over1000Sqft,
(SELECT COUNT(T$SQFT) from TFSOLP107180 WHERE T$PLNT<>'12' AND T$PLNT<>'HK' AND T$PLNT<>'2F' AND T$Date BETWEEN FiscalQuarterFrom AND FiscalQuarterTo AND T$SQFT BETWEEN 501 AND 1000) as To501_1000Sqft,
(SELECT COUNT(T$SQFT) from TFSOLP107180 WHERE T$PLNT<>'12' AND T$PLNT<>'HK' AND T$PLNT<>'2F' AND T$Date BETWEEN FiscalQuarterFrom AND FiscalQuarterTo AND T$SQFT BETWEEN 301 AND 500) as To301_500Sqft, 
(SELECT COUNT(T$SQFT) from TFSOLP107180 WHERE T$PLNT<>'12' AND T$PLNT<>'HK' AND T$PLNT<>'2F' AND T$Date BETWEEN FiscalQuarterFrom AND FiscalQuarterTo AND T$SQFT BETWEEN 101 AND 300) as To101_300Sqft, 
(SELECT COUNT(T$SQFT) from TFSOLP107180 WHERE T$PLNT<>'12' AND T$PLNT<>'HK' AND T$PLNT<>'2F' AND T$Date BETWEEN FiscalQuarterFrom AND FiscalQuarterTo AND T$SQFT <=100) as To100Sqft 
from #Tmp_PY_Group
) tb1Allexclude2F 
UNION ALL
--FGOut
select *,Over1000Sqft+To501_1000Sqft+To301_500Sqft+To101_300Sqft+To100Sqft as Total 
from (
select '001' as ReportCode,FiscalYear as [Year],FiscalQuarter as Quarter,(CASE T$PLNT WHEN 'P2' THEN 'B1' WHEN '2F' THEN 'B2F' ELSE T$PLNT END )AS Plant,'FGOut' as Sale,
(SELECT COUNT(T$SQFT) from TFSOLP105180 WHERE T$PLNT=#Tmp_PY.T$PLNT AND T$Date BETWEEN FiscalQuarterFrom AND FiscalQuarterTo AND T$SQFT>1000) as Over1000Sqft,
(SELECT COUNT(T$SQFT) from TFSOLP105180 WHERE T$PLNT=#Tmp_PY.T$PLNT AND T$Date BETWEEN FiscalQuarterFrom AND FiscalQuarterTo AND T$SQFT BETWEEN 501 AND 1000) as To501_1000Sqft,
(SELECT COUNT(T$SQFT) from TFSOLP105180 WHERE T$PLNT=#Tmp_PY.T$PLNT AND T$Date BETWEEN FiscalQuarterFrom AND FiscalQuarterTo AND T$SQFT BETWEEN 301 AND 500) as To301_500Sqft, 
(SELECT COUNT(T$SQFT) from TFSOLP105180 WHERE T$PLNT=#Tmp_PY.T$PLNT AND T$Date BETWEEN FiscalQuarterFrom AND FiscalQuarterTo AND T$SQFT BETWEEN 101 AND 300) as To101_300Sqft, 
(SELECT COUNT(T$SQFT) from TFSOLP105180 WHERE T$PLNT=#Tmp_PY.T$PLNT AND T$Date BETWEEN FiscalQuarterFrom AND FiscalQuarterTo AND T$SQFT <=100) as To100Sqft 
from #Tmp_PY 
) tb2
UNION ALL 
select *,Over1000Sqft+To501_1000Sqft+To301_500Sqft+To101_300Sqft+To100Sqft as Total 
from (
select '001' as ReportCode,FiscalYear as [Year],FiscalQuarter as Quarter,'All' AS Plant,'FGOut' as Sale,
(SELECT COUNT(T$SQFT) from TFSOLP105180 WHERE T$PLNT<>'12' AND T$PLNT<>'HK' AND T$Date BETWEEN FiscalQuarterFrom AND FiscalQuarterTo AND T$SQFT>1000) as Over1000Sqft,
(SELECT COUNT(T$SQFT) from TFSOLP105180 WHERE T$PLNT<>'12' AND T$PLNT<>'HK' AND T$Date BETWEEN FiscalQuarterFrom AND FiscalQuarterTo AND T$SQFT BETWEEN 501 AND 1000) as To501_1000Sqft,
(SELECT COUNT(T$SQFT) from TFSOLP105180 WHERE T$PLNT<>'12' AND T$PLNT<>'HK' AND T$Date BETWEEN FiscalQuarterFrom AND FiscalQuarterTo AND T$SQFT BETWEEN 301 AND 500) as To301_500Sqft, 
(SELECT COUNT(T$SQFT) from TFSOLP105180 WHERE T$PLNT<>'12' AND T$PLNT<>'HK' AND T$Date BETWEEN FiscalQuarterFrom AND FiscalQuarterTo AND T$SQFT BETWEEN 101 AND 300) as To101_300Sqft, 
(SELECT COUNT(T$SQFT) from TFSOLP105180 WHERE T$PLNT<>'12' AND T$PLNT<>'HK' AND T$Date BETWEEN FiscalQuarterFrom AND FiscalQuarterTo AND T$SQFT <=100) as To100Sqft 
from #Tmp_PY group by FiscalYear,FiscalQuarter,FiscalQuarterFrom,FiscalQuarterTo 
) tb2All
UNION ALL 
select *,Over1000Sqft+To501_1000Sqft+To301_500Sqft+To101_300Sqft+To100Sqft as Total 
from (
select '001' as ReportCode,FiscalYear as [Year],FiscalQuarter as Quarter,'Allexclude2F' AS Plant,'FGOut' as Sale,
(SELECT COUNT(T$SQFT) from TFSOLP105180 WHERE T$PLNT<>'12' AND T$PLNT<>'HK' AND T$PLNT<>'2F' AND T$Date BETWEEN FiscalQuarterFrom AND FiscalQuarterTo AND T$SQFT>1000) as Over1000Sqft,
(SELECT COUNT(T$SQFT) from TFSOLP105180 WHERE T$PLNT<>'12' AND T$PLNT<>'HK' AND T$PLNT<>'2F' AND T$Date BETWEEN FiscalQuarterFrom AND FiscalQuarterTo AND T$SQFT BETWEEN 501 AND 1000) as To501_1000Sqft,
(SELECT COUNT(T$SQFT) from TFSOLP105180 WHERE T$PLNT<>'12' AND T$PLNT<>'HK' AND T$PLNT<>'2F' AND T$Date BETWEEN FiscalQuarterFrom AND FiscalQuarterTo AND T$SQFT BETWEEN 301 AND 500) as To301_500Sqft, 
(SELECT COUNT(T$SQFT) from TFSOLP105180 WHERE T$PLNT<>'12' AND T$PLNT<>'HK' AND T$PLNT<>'2F' AND T$Date BETWEEN FiscalQuarterFrom AND FiscalQuarterTo AND T$SQFT BETWEEN 101 AND 300) as To101_300Sqft, 
(SELECT COUNT(T$SQFT) from TFSOLP105180 WHERE T$PLNT<>'12' AND T$PLNT<>'HK' AND T$PLNT<>'2F' AND T$Date BETWEEN FiscalQuarterFrom AND FiscalQuarterTo AND T$SQFT <=100) as To100Sqft 
from #Tmp_PY_Group
) tb2Allexclude2F 
UNION ALL
--Invoice
select *,Over1000Sqft+To501_1000Sqft+To301_500Sqft+To101_300Sqft+To100Sqft as Total 
from (
select '001' as ReportCode,FiscalYear as [Year],FiscalQuarter as Quarter,(CASE T$PLNT WHEN 'P2' THEN 'B1' WHEN '2F' THEN 'B2F' ELSE T$PLNT END )AS Plant,'Invoice' as Sale,
(SELECT COUNT(T$SQFT) from TFSOLP106180 WHERE T$PLNT=#Tmp_PY.T$PLNT AND T$Date BETWEEN FiscalQuarterFrom AND FiscalQuarterTo AND T$SQFT>1000) as Over1000Sqft,
(SELECT COUNT(T$SQFT) from TFSOLP106180 WHERE T$PLNT=#Tmp_PY.T$PLNT AND T$Date BETWEEN FiscalQuarterFrom AND FiscalQuarterTo AND T$SQFT BETWEEN 501 AND 1000) as To501_1000Sqft,
(SELECT COUNT(T$SQFT) from TFSOLP106180 WHERE T$PLNT=#Tmp_PY.T$PLNT AND T$Date BETWEEN FiscalQuarterFrom AND FiscalQuarterTo AND T$SQFT BETWEEN 301 AND 500) as To301_500Sqft, 
(SELECT COUNT(T$SQFT) from TFSOLP106180 WHERE T$PLNT=#Tmp_PY.T$PLNT AND T$Date BETWEEN FiscalQuarterFrom AND FiscalQuarterTo AND T$SQFT BETWEEN 101 AND 300) as To101_300Sqft, 
(SELECT COUNT(T$SQFT) from TFSOLP106180 WHERE T$PLNT=#Tmp_PY.T$PLNT AND T$Date BETWEEN FiscalQuarterFrom AND FiscalQuarterTo AND T$SQFT <=100) as To100Sqft 
from #Tmp_PY 
) tb3
UNION ALL
select *,Over1000Sqft+To501_1000Sqft+To301_500Sqft+To101_300Sqft+To100Sqft as Total 
from (
select '001' as ReportCode,FiscalYear as [Year],FiscalQuarter as Quarter,'All' AS Plant,'Invoice' as Sale,
(SELECT COUNT(T$SQFT) from TFSOLP106180 WHERE T$PLNT<>'12' AND T$PLNT<>'HK' AND T$Date BETWEEN FiscalQuarterFrom AND FiscalQuarterTo AND T$SQFT>1000) as Over1000Sqft,
(SELECT COUNT(T$SQFT) from TFSOLP106180 WHERE T$PLNT<>'12' AND T$PLNT<>'HK' AND T$Date BETWEEN FiscalQuarterFrom AND FiscalQuarterTo AND T$SQFT BETWEEN 501 AND 1000) as To501_1000Sqft,
(SELECT COUNT(T$SQFT) from TFSOLP106180 WHERE T$PLNT<>'12' AND T$PLNT<>'HK' AND T$Date BETWEEN FiscalQuarterFrom AND FiscalQuarterTo AND T$SQFT BETWEEN 301 AND 500) as To301_500Sqft, 
(SELECT COUNT(T$SQFT) from TFSOLP106180 WHERE T$PLNT<>'12' AND T$PLNT<>'HK' AND T$Date BETWEEN FiscalQuarterFrom AND FiscalQuarterTo AND T$SQFT BETWEEN 101 AND 300) as To101_300Sqft, 
(SELECT COUNT(T$SQFT) from TFSOLP106180 WHERE T$PLNT<>'12' AND T$PLNT<>'HK' AND T$Date BETWEEN FiscalQuarterFrom AND FiscalQuarterTo AND T$SQFT <=100) as To100Sqft 
from #Tmp_PY_Group
) tb3All
UNION ALL 
select *,Over1000Sqft+To501_1000Sqft+To301_500Sqft+To101_300Sqft+To100Sqft as Total 
from (
select '001' as ReportCode,FiscalYear as [Year],FiscalQuarter as Quarter,'Allexclude2F' AS Plant,'Invoice' as Sale,
(SELECT COUNT(T$SQFT) from TFSOLP106180 WHERE T$PLNT<>'12' AND T$PLNT<>'HK' AND T$PLNT<>'2F' AND T$Date BETWEEN FiscalQuarterFrom AND FiscalQuarterTo AND T$SQFT>1000) as Over1000Sqft,
(SELECT COUNT(T$SQFT) from TFSOLP106180 WHERE T$PLNT<>'12' AND T$PLNT<>'HK' AND T$PLNT<>'2F' AND T$Date BETWEEN FiscalQuarterFrom AND FiscalQuarterTo AND T$SQFT BETWEEN 501 AND 1000) as To501_1000Sqft,
(SELECT COUNT(T$SQFT) from TFSOLP106180 WHERE T$PLNT<>'12' AND T$PLNT<>'HK' AND T$PLNT<>'2F' AND T$Date BETWEEN FiscalQuarterFrom AND FiscalQuarterTo AND T$SQFT BETWEEN 301 AND 500) as To301_500Sqft, 
(SELECT COUNT(T$SQFT) from TFSOLP106180 WHERE T$PLNT<>'12' AND T$PLNT<>'HK' AND T$PLNT<>'2F' AND T$Date BETWEEN FiscalQuarterFrom AND FiscalQuarterTo AND T$SQFT BETWEEN 101 AND 300) as To101_300Sqft, 
(SELECT COUNT(T$SQFT) from TFSOLP106180 WHERE T$PLNT<>'12' AND T$PLNT<>'HK' AND T$PLNT<>'2F' AND T$Date BETWEEN FiscalQuarterFrom AND FiscalQuarterTo AND T$SQFT <=100) as To100Sqft 
from #Tmp_PY WHERE T$PLNT<>'2F' group by FiscalYear,FiscalQuarter,FiscalQuarterFrom,FiscalQuarterTo 
) tb3All 

) as tbtemp

--update
UPDATE KOI_Quarterly_Number_of_Projects SET Over1000Sqft=b.Over1000Sqft,To501_1000Sqft=b.To501_1000Sqft,To301_500Sqft=b.To301_500Sqft,
										 To101_300Sqft=b.To101_300Sqft,To100Sqft=b.To100Sqft,Total=b.Total 
from #temp b 
WHERE KOI_Quarterly_Number_of_Projects.ReportCode=b.ReportCode AND KOI_Quarterly_Number_of_Projects.[Year]=b.[Year] AND KOI_Quarterly_Number_of_Projects.Quarter=b.Quarter AND KOI_Quarterly_Number_of_Projects.Plant=b.Plant AND KOI_Quarterly_Number_of_Projects.Sale=b.Sale 

--insert
INSERT INTO KOI_Quarterly_Number_of_Projects (ReportCode,[Year],Quarter,Plant,Sale,Over1000Sqft,To501_1000Sqft,To301_500Sqft,To101_300Sqft,To100Sqft,Total)
SELECT * FROM #temp a WHERE not EXISTS (SELECT * FROM KOI_Quarterly_Number_of_Projects b WHERE a.ReportCode=b.ReportCode AND a.[Year]=b.[Year] AND a.Quarter=b.Quarter AND a.Plant=b.Plant AND a.Sale=b.Sale) 


drop table #Tmp_PY
drop table #temp 


END

















GO
