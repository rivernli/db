USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[KOI_sp_Automatically_Process_Yearly_Attrition_rate_vs_MRB_rate_Fiscal]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[KOI_sp_Automatically_Process_Yearly_Attrition_rate_vs_MRB_rate_Fiscal]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

select * into #temp from 
(
SELECT '001' as ReportCode,
(CASE T$PLNT WHEN 'P2' THEN 'B1' WHEN '2F' THEN 'B2F' ELSE T$PLNT END )AS Plant,b.FiscalYear+1 AS Year,
ISNULL((CASE convert(numeric(18,2),SUM(T$IQTY)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),(SUM(T$IQTY)-SUM(T$OQTY))/SUM(T$IQTY)) END),0) AS Attrition_Rate, 
ISNULL((CASE convert(numeric(18,2),SUM(T$AMNT)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$MCOS)/SUM(T$AMNT)) END),0) AS MRB_rate 
FROM vw_KOI_Attrition_MRB_rate a,DataWarehouse.dbo.DW_DIM_Calender b
WHERE a.T$Date=b.CalenderDate
AND b.Calenderdate < CONVERT(VARCHAR(10),GETDATE()-1,120)  AND b.FiscalYear>'2007'
GROUP BY a.T$PLNT,b.FiscalYear 

UNION ALL

SELECT '001' as ReportCode,
'All' AS Plant,b.FiscalYear+1 AS Year,
ISNULL((CASE convert(numeric(18,2),SUM(T$IQTY)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),(SUM(T$IQTY)-SUM(T$OQTY))/SUM(T$IQTY)) END),0) AS Attrition_Rate, 
ISNULL((CASE convert(numeric(18,2),SUM(T$AMNT)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$MCOS)/SUM(T$AMNT)) END),0) AS MRB_rate 
FROM vw_KOI_Attrition_MRB_rate a,DataWarehouse.dbo.DW_DIM_Calender b
WHERE a.T$Date=b.CalenderDate
AND b.Calenderdate < CONVERT(VARCHAR(10),GETDATE()-1,120)  AND b.FiscalYear>'2007'
GROUP BY b.FiscalYear

UNION ALL 

SELECT '001' as ReportCode,
'Allexclude2F' AS Plant,b.FiscalYear+1 AS Year,
ISNULL((CASE convert(numeric(18,2),SUM(T$IQTY)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),(SUM(T$IQTY)-SUM(T$OQTY))/SUM(T$IQTY)) END),0) AS Attrition_Rate, 
ISNULL((CASE convert(numeric(18,2),SUM(T$AMNT)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$MCOS)/SUM(T$AMNT)) END),0) AS MRB_rate 
FROM vw_KOI_Attrition_MRB_rate a,DataWarehouse.dbo.DW_DIM_Calender b
WHERE T$PLNT<>'2F' AND a.T$Date=b.CalenderDate
AND b.Calenderdate < CONVERT(VARCHAR(10),GETDATE()-1,120)  AND b.FiscalYear>'2007'
GROUP BY b.FiscalYear
) as tb  


--update
UPDATE KOI_Yearly_Attrition_rate_vs_MRB_rate SET Attrition_Rate=b.Attrition_Rate,MRB_rate=b.MRB_rate 
from #temp b 
WHERE KOI_Yearly_Attrition_rate_vs_MRB_rate.ReportCode=b.ReportCode AND KOI_Yearly_Attrition_rate_vs_MRB_rate.[Year]=b.[Year]  AND KOI_Yearly_Attrition_rate_vs_MRB_rate.Plant=b.Plant 

--insert
INSERT INTO KOI_Yearly_Attrition_rate_vs_MRB_rate (ReportCode,Plant,[Year],Attrition_Rate,MRB_rate)
SELECT * FROM #temp a WHERE not EXISTS (SELECT * FROM KOI_Yearly_Attrition_rate_vs_MRB_rate b WHERE a.ReportCode=b.ReportCode AND a.[Year]=b.[Year]  AND a.Plant=b.Plant) 



END


GO
