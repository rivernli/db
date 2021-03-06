USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[KOI_sp_Automatically_Process_Quarterly_Productivity_Image_Layer_Fiscal]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[KOI_sp_Automatically_Process_Quarterly_Productivity_Image_Layer_Fiscal]
	-- Add the parameters for the stored procedure here
AS
BEGIN

select * into #temp from 
(
select *,
ISNULL(CASE WorkingHours WHEN 0 THEN 0 ELSE (FGOut_sqft*ALC) / WorkingHours END,0) as Efficiency 
 from 
(
SELECT 
(CASE T$PLNT WHEN '2F' THEN 'B2F' ELSE T$PLNT END )AS Plant,T$SOUR AS Sale,b.FiscalYear+1 AS Year, b.FiscalQuarter as Quarter,
(SELECT ISNULL(SUM(WorkingHours),0) FROM KOI_InputByHR where Financey=b.FiscalYear+1 AND Plant=a.T$PLNT AND Period in (select FiscalPeriod from DataWarehouse.dbo.DW_DIM_Calender where FiscalYear=b.FiscalYear AND FiscalQuarter=b.FiscalQuarter group by FiscalPeriod))AS WorkingHours,
(SELECT ISNULL(SUM(Headcount),0) FROM KOI_InputByHR where Financey=b.FiscalYear+1 AND Plant=a.T$PLNT AND Period in (select FiscalPeriod from DataWarehouse.dbo.DW_DIM_Calender where FiscalYear=b.FiscalYear AND FiscalQuarter=b.FiscalQuarter group by FiscalPeriod)) AS Headcount, 
(select ISNULL(sum([ShipmentArea(SQFT)]),0) from dbo.EXR2_Details where replace(FYear,'FY','') = b.FiscalYear+1 and Plant = a.T$PLNT AND Period in (select FiscalPeriodDesc from DataWarehouse.dbo.DW_DIM_Calender where FiscalYear=b.FiscalYear AND FiscalQuarter=b.FiscalQuarter group by FiscalPeriodDesc)) AS FGOut_sqft, 
ISNULL((CASE convert(numeric(18,2),SUM(T$AREA)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$LYER*T$AREA)/SUM(T$AREA)) END),0) AS ALC 
FROM TFSOLP112180 a,DataWarehouse.dbo.DW_DIM_Calender b
WHERE T$PLNT<>'HK' AND T$PLNT<>'12' AND a.T$Date=b.CalenderDate
AND b.Calenderdate < CONVERT(VARCHAR(10),GETDATE()-1,120)  AND b.FiscalYear>'2007'
GROUP BY a.T$PLNT,a.T$SOUR,b.FiscalYear,b.FiscalQuarter 
) tb 

UNION ALL

select *,
ISNULL(CASE WorkingHours WHEN 0 THEN 0 ELSE (FGOut_sqft*ALC) / WorkingHours END,0) as Efficiency 
 from 
(
SELECT 
'All' AS Plant,T$SOUR AS Sale,b.FiscalYear+1 AS Year, b.FiscalQuarter as Quarter,
(SELECT ISNULL(SUM(WorkingHours),0) FROM KOI_InputByHR where Financey=b.FiscalYear+1 AND Period in (select FiscalPeriod from DataWarehouse.dbo.DW_DIM_Calender where FiscalYear=b.FiscalYear AND FiscalQuarter=b.FiscalQuarter group by FiscalPeriod))AS WorkingHours,
(SELECT ISNULL(SUM(Headcount),0) FROM KOI_InputByHR where Financey=b.FiscalYear+1 AND Period in (select FiscalPeriod from DataWarehouse.dbo.DW_DIM_Calender where FiscalYear=b.FiscalYear AND FiscalQuarter=b.FiscalQuarter group by FiscalPeriod)) AS Headcount, 
(select ISNULL(sum([ShipmentArea(SQFT)]),0) from dbo.EXR2_Details where replace(FYear,'FY','') = b.FiscalYear+1 AND Period in (select FiscalPeriodDesc from DataWarehouse.dbo.DW_DIM_Calender where FiscalYear=b.FiscalYear AND FiscalQuarter=b.FiscalQuarter group by FiscalPeriodDesc)) AS FGOut_sqft, 
ISNULL((CASE convert(numeric(18,2),SUM(T$AREA)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$LYER*T$AREA)/SUM(T$AREA)) END),0) AS ALC 
FROM TFSOLP112180 a,DataWarehouse.dbo.DW_DIM_Calender b
WHERE T$PLNT<>'HK' AND T$PLNT<>'12' AND a.T$Date=b.CalenderDate
AND b.Calenderdate < CONVERT(VARCHAR(10),GETDATE()-1,120)  AND b.FiscalYear>'2007'
GROUP BY a.T$SOUR,b.FiscalYear,b.FiscalQuarter 
) tb1

UNION ALL 

select *,
ISNULL(CASE WorkingHours WHEN 0 THEN 0 ELSE (FGOut_sqft*ALC) / WorkingHours END,0) as Efficiency 
 from 
(
SELECT 
'Allexclude2F' AS Plant,T$SOUR AS Sale,b.FiscalYear+1 AS Year, b.FiscalQuarter as Quarter,
(SELECT ISNULL(SUM(WorkingHours),0) FROM KOI_InputByHR where Financey=b.FiscalYear+1 AND Plant<>'B2F' AND Period in (select FiscalPeriod from DataWarehouse.dbo.DW_DIM_Calender where FiscalYear=b.FiscalYear AND FiscalQuarter=b.FiscalQuarter group by FiscalPeriod))AS WorkingHours,
(SELECT ISNULL(SUM(Headcount),0) FROM KOI_InputByHR where Financey=b.FiscalYear+1 AND Plant<>'B2F' AND Period in (select FiscalPeriod from DataWarehouse.dbo.DW_DIM_Calender where FiscalYear=b.FiscalYear AND FiscalQuarter=b.FiscalQuarter group by FiscalPeriod)) AS Headcount, 
(select ISNULL(sum([ShipmentArea(SQFT)]),0) from dbo.EXR2_Details where replace(FYear,'FY','') = b.FiscalYear+1 and Plant<>'B2F' AND Period in (select FiscalPeriodDesc from DataWarehouse.dbo.DW_DIM_Calender where FiscalYear=b.FiscalYear AND FiscalQuarter=b.FiscalQuarter group by FiscalPeriodDesc)) AS FGOut_sqft, 
ISNULL((CASE convert(numeric(18,2),SUM(T$AREA)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$LYER*T$AREA)/SUM(T$AREA)) END),0) AS ALC 
FROM TFSOLP112180 a,DataWarehouse.dbo.DW_DIM_Calender b
WHERE T$PLNT<>'HK' AND T$PLNT<>'12' AND T$PLNT<>'2F' AND a.T$Date=b.CalenderDate
AND b.Calenderdate < CONVERT(VARCHAR(10),GETDATE()-1,120)  AND b.FiscalYear>'2007'
GROUP BY a.T$SOUR,b.FiscalYear,b.FiscalQuarter 
) tb2 

) as temptb 
 

--update
UPDATE KOI_Quarterly_Productivity_Image_Layer SET WorkingHours=b.WorkingHours,Headcount=b.Headcount,ALC=b.ALC,FGOut_sqft=b.FGOut_sqft,Efficiency=b.Efficiency 
from #temp b 
WHERE KOI_Quarterly_Productivity_Image_Layer.[Year]=b.[Year] AND KOI_Quarterly_Productivity_Image_Layer.Quarter=b.Quarter AND KOI_Quarterly_Productivity_Image_Layer.Plant=b.Plant AND KOI_Quarterly_Productivity_Image_Layer.Sale=b.Sale 

--insert
INSERT INTO KOI_Quarterly_Productivity_Image_Layer (Plant,Sale,[Year],Quarter,WorkingHours,Headcount,FGOut_sqft,ALC,Efficiency)
SELECT * FROM #temp a WHERE not EXISTS (SELECT * FROM KOI_Quarterly_Productivity_Image_Layer b WHERE a.[Year]=b.[Year] AND a.Quarter=b.Quarter AND a.Plant=b.Plant AND a.Sale=b.Sale) 


	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
--	SET NOCOUNT ON;
--
--    -- Insert statements for procedure here
--    DECLARE @FiscalYear VARCHAR(4),@FiscalQuarter INT,@FiscalQuarterFrom VARCHAR(20),@FiscalQuarterTo VARCHAR(20),@Plant NVARCHAR(50),@WorkingHours NUMERIC(18,2),@Headcount NUMERIC(18,2),@ALC NUMERIC(18,2),@FGOut_sqft NUMERIC(18,2),@Efficiency NUMERIC(18,2),@SQLString VARCHAR(MAX),@Sale NVARCHAR(20)   
--    DECLARE Layer_Quarter_C CURSOR FOR 
--
--	SELECT FiscalYear+1  AS FiscalYear, FiscalQuarter,CONVERT(varchar(12),FiscalQuarterFrom,23) as FiscalQuarterFrom,CONVERT(varchar(12),FiscalQuarterTo,23) as FiscalQuarterTo  
--	FROM DataWarehouse.dbo.DW_DIM_Calender 
--	WHERE Calenderdate < CONVERT(VARCHAR(10),GETDATE()-1,120) AND FiscalYear>'2007' 
--	GROUP BY FiscalYear,FiscalQuarter,FiscalQuarterFrom,FiscalQuarterTo 
--	ORDER BY FiscalYear DESC,FiscalQuarterTo DESC 
--
--	OPEN Layer_Quarter_C  
--	FETCH NEXT FROM Layer_Quarter_C INTO @Fiscalyear,@FiscalQuarter,@FiscalQuarterFrom,@FiscalQuarterTo
--	
--	WHILE @@FETCH_STATUS=0
--		BEGIN
--			IF @FiscalQuarterTo>CONVERT(VARCHAR(10),DATEADD(DAY,-1,GETDATE()),120)
--				BEGIN
--					SET @FiscalQuarterTo=CONVERT(VARCHAR(10),DATEADD(DAY,-1,GETDATE()),120)
--				END
--	
--					SET @Plant='B1'					
--				if @FiscalQuarter='1'					
--					BEGIN
--					SET @WorkingHours=(select ISNULL(SUM(WorkingHours),0) from KOI_InputByHR WHERE Plant=@Plant AND Financey = @FiscalYear AND Period BETWEEN 1 AND 3)					
--					SET @Headcount =(SELECT ISNULL(SUM(Headcount),0) FROM KOI_InputByHR where Financey=@FiscalYear AND Plant=@Plant AND Period BETWEEN 1 AND 3) 
--					SET @FGOut_sqft =(select ISNULL(sum([ShipmentArea(SQFT)]),0) from dbo.EXR2_Details where replace(FYear,'FY','') = @FiscalYear and Plant = @Plant AND Period BETWEEN 'P01' AND 'P03') 
--					END
--				if @FiscalQuarter='2'
--					BEGIN
--					SET @WorkingHours=(select ISNULL(SUM(WorkingHours),0) from KOI_InputByHR WHERE Plant=@Plant AND Financey = @FiscalYear AND Period BETWEEN 4 AND 6)
--					SET @Headcount =(SELECT ISNULL(SUM(Headcount),0) FROM KOI_InputByHR where Financey=@FiscalYear AND Plant=@Plant AND Period BETWEEN 4 AND 6) 
--					SET @FGOut_sqft =(select ISNULL(sum([ShipmentArea(SQFT)]),0) from dbo.EXR2_Details where replace(FYear,'FY','') = @FiscalYear and Plant = @Plant AND Period BETWEEN 'P04' AND 'P06') 
--					END
--				if @FiscalQuarter='3'
--					BEGIN
--					SET @WorkingHours=(select ISNULL(SUM(WorkingHours),0) from KOI_InputByHR WHERE Plant=@Plant AND Financey = @FiscalYear AND Period BETWEEN 7 AND 9)
--					SET @Headcount =(SELECT ISNULL(SUM(Headcount),0) FROM KOI_InputByHR where Financey=@FiscalYear AND Plant=@Plant AND Period BETWEEN 7 AND 9) 
--					SET @FGOut_sqft =(select ISNULL(sum([ShipmentArea(SQFT)]),0) from dbo.EXR2_Details where replace(FYear,'FY','') = @FiscalYear and Plant = @Plant AND Period BETWEEN 'P07' AND 'P09') 
--					END
--				if @FiscalQuarter='4'
--					BEGIN
--					SET @WorkingHours=(select ISNULL(SUM(WorkingHours),0) from KOI_InputByHR WHERE Plant=@Plant AND Financey = @FiscalYear AND Period BETWEEN 10 AND 12)
--					SET @Headcount =(SELECT ISNULL(SUM(Headcount),0) FROM KOI_InputByHR where Financey=@FiscalYear AND Plant=@Plant AND Period BETWEEN 10 AND 12) 
--					SET @FGOut_sqft =(select ISNULL(sum([ShipmentArea(SQFT)]),0) from dbo.EXR2_Details where replace(FYear,'FY','') = @FiscalYear and Plant = @Plant AND Period BETWEEN 'P10' AND 'P12') 
--					END	
--
--					SET @Sale='Ex-factory Sale               '								
--					SET @ALC = (SELECT ISNULL((CASE convert(numeric(18,2),SUM(T$AREA)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$LYER*T$AREA)/SUM(T$AREA)) END),0) AS ALC from TFSOLP112180 WHERE T$PLNT=@Plant AND T$SOUR=@Sale AND T$Date BETWEEN @FiscalQuarterFrom AND @FiscalQuarterTo) 				
--					--Efficiency=FG out (sqft) * ALC /DL Working Hours
--					SET @Efficiency = (SELECT ISNULL(CASE @WorkingHours WHEN 0 THEN 0 ELSE (@FGOut_sqft*@ALC) / @WorkingHours END,0)) 
--					SET @SQLString=dbo.KOI_fun_Get_Quarterly_Productivity_Image_Layer_SQL_String(@FiscalYear,@FiscalQuarter,@Plant,@Sale,@WorkingHours,@Headcount,@ALC,@FGOut_sqft,@Efficiency) 
--					EXECUTE (@SQLString)
--
--					SET @Sale='Invoice Sale                  '
--					SET @ALC = (SELECT ISNULL((CASE convert(numeric(18,2),SUM(T$AREA)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$LYER*T$AREA)/SUM(T$AREA)) END),0) AS ALC from TFSOLP112180 WHERE T$PLNT=@Plant AND T$SOUR=@Sale AND T$Date BETWEEN @FiscalQuarterFrom AND @FiscalQuarterTo)  
--					SET @Efficiency = (SELECT ISNULL(CASE @WorkingHours WHEN 0 THEN 0 ELSE (@FGOut_sqft*@ALC) / @WorkingHours END,0)) 
--					SET @SQLString=dbo.KOI_fun_Get_Quarterly_Productivity_Image_Layer_SQL_String(@FiscalYear,@FiscalQuarter,@Plant,@Sale,@WorkingHours,@Headcount,@ALC,@FGOut_sqft,@Efficiency) 
--					EXECUTE (@SQLString)
--
--					SET @Sale='Production output             '				
--					SET @ALC = (SELECT ISNULL((CASE convert(numeric(18,2),SUM(T$AREA)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$LYER*T$AREA)/SUM(T$AREA)) END),0) AS ALC from TFSOLP112180 WHERE T$PLNT=@Plant AND T$SOUR=@Sale AND T$Date BETWEEN @FiscalQuarterFrom AND @FiscalQuarterTo) 
--					SET @Efficiency = (SELECT ISNULL(CASE @WorkingHours WHEN 0 THEN 0 ELSE (@FGOut_sqft*@ALC) / @WorkingHours END,0)) 
--					SET @SQLString=dbo.KOI_fun_Get_Quarterly_Productivity_Image_Layer_SQL_String(@FiscalYear,@FiscalQuarter,@Plant,@Sale,@WorkingHours,@Headcount,@ALC,@FGOut_sqft,@Efficiency) 
--					EXECUTE (@SQLString)	
--
--					SET @Plant='B3'					
--				if @FiscalQuarter='1'					
--					BEGIN
--					SET @WorkingHours=(select ISNULL(SUM(WorkingHours),0) from KOI_InputByHR WHERE Plant=@Plant AND Financey = @FiscalYear AND Period BETWEEN 1 AND 3)					
--					SET @Headcount =(SELECT ISNULL(SUM(Headcount),0) FROM KOI_InputByHR where Financey=@FiscalYear AND Plant=@Plant AND Period BETWEEN 1 AND 3) 
--					SET @FGOut_sqft =(select ISNULL(sum([ShipmentArea(SQFT)]),0) from dbo.EXR2_Details where replace(FYear,'FY','') = @FiscalYear and Plant = @Plant AND Period BETWEEN 'P01' AND 'P03') 
--					END
--				if @FiscalQuarter='2'
--					BEGIN
--					SET @WorkingHours=(select ISNULL(SUM(WorkingHours),0) from KOI_InputByHR WHERE Plant=@Plant AND Financey = @FiscalYear AND Period BETWEEN 4 AND 6)
--					SET @Headcount =(SELECT ISNULL(SUM(Headcount),0) FROM KOI_InputByHR where Financey=@FiscalYear AND Plant=@Plant AND Period BETWEEN 4 AND 6) 
--					SET @FGOut_sqft =(select ISNULL(sum([ShipmentArea(SQFT)]),0) from dbo.EXR2_Details where replace(FYear,'FY','') = @FiscalYear and Plant = @Plant AND Period BETWEEN 'P04' AND 'P06') 
--					END
--				if @FiscalQuarter='3'
--					BEGIN
--					SET @WorkingHours=(select ISNULL(SUM(WorkingHours),0) from KOI_InputByHR WHERE Plant=@Plant AND Financey = @FiscalYear AND Period BETWEEN 7 AND 9)
--					SET @Headcount =(SELECT ISNULL(SUM(Headcount),0) FROM KOI_InputByHR where Financey=@FiscalYear AND Plant=@Plant AND Period BETWEEN 7 AND 9) 
--					SET @FGOut_sqft =(select ISNULL(sum([ShipmentArea(SQFT)]),0) from dbo.EXR2_Details where replace(FYear,'FY','') = @FiscalYear and Plant = @Plant AND Period BETWEEN 'P07' AND 'P09') 
--					END
--				if @FiscalQuarter='4'
--					BEGIN
--					SET @WorkingHours=(select ISNULL(SUM(WorkingHours),0) from KOI_InputByHR WHERE Plant=@Plant AND Financey = @FiscalYear AND Period BETWEEN 10 AND 12)
--					SET @Headcount =(SELECT ISNULL(SUM(Headcount),0) FROM KOI_InputByHR where Financey=@FiscalYear AND Plant=@Plant AND Period BETWEEN 10 AND 12) 
--					SET @FGOut_sqft =(select ISNULL(sum([ShipmentArea(SQFT)]),0) from dbo.EXR2_Details where replace(FYear,'FY','') = @FiscalYear and Plant = @Plant AND Period BETWEEN 'P10' AND 'P12') 
--					END	
--
--					SET @Sale='Ex-factory Sale               '								
--					SET @ALC = (SELECT ISNULL((CASE convert(numeric(18,2),SUM(T$AREA)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$LYER*T$AREA)/SUM(T$AREA)) END),0) AS ALC from TFSOLP112180 WHERE T$PLNT=@Plant AND T$SOUR=@Sale AND T$Date BETWEEN @FiscalQuarterFrom AND @FiscalQuarterTo) 				
--					--Efficiency=FG out (sqft) * ALC /DL Working Hours
--					SET @Efficiency = (SELECT ISNULL(CASE @WorkingHours WHEN 0 THEN 0 ELSE (@FGOut_sqft*@ALC) / @WorkingHours END,0)) 
--					SET @SQLString=dbo.KOI_fun_Get_Quarterly_Productivity_Image_Layer_SQL_String(@FiscalYear,@FiscalQuarter,@Plant,@Sale,@WorkingHours,@Headcount,@ALC,@FGOut_sqft,@Efficiency) 
--					EXECUTE (@SQLString)
--
--					SET @Sale='Invoice Sale                  '
--					SET @ALC = (SELECT ISNULL((CASE convert(numeric(18,2),SUM(T$AREA)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$LYER*T$AREA)/SUM(T$AREA)) END),0) AS ALC from TFSOLP112180 WHERE T$PLNT=@Plant AND T$SOUR=@Sale AND T$Date BETWEEN @FiscalQuarterFrom AND @FiscalQuarterTo)  
--					SET @Efficiency = (SELECT ISNULL(CASE @WorkingHours WHEN 0 THEN 0 ELSE (@FGOut_sqft*@ALC) / @WorkingHours END,0)) 
--					SET @SQLString=dbo.KOI_fun_Get_Quarterly_Productivity_Image_Layer_SQL_String(@FiscalYear,@FiscalQuarter,@Plant,@Sale,@WorkingHours,@Headcount,@ALC,@FGOut_sqft,@Efficiency) 
--					EXECUTE (@SQLString)
--
--					SET @Sale='Production output             '				
--					SET @ALC = (SELECT ISNULL((CASE convert(numeric(18,2),SUM(T$AREA)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$LYER*T$AREA)/SUM(T$AREA)) END),0) AS ALC from TFSOLP112180 WHERE T$PLNT=@Plant AND T$SOUR=@Sale AND T$Date BETWEEN @FiscalQuarterFrom AND @FiscalQuarterTo) 
--					SET @Efficiency = (SELECT ISNULL(CASE @WorkingHours WHEN 0 THEN 0 ELSE (@FGOut_sqft*@ALC) / @WorkingHours END,0)) 
--					SET @SQLString=dbo.KOI_fun_Get_Quarterly_Productivity_Image_Layer_SQL_String(@FiscalYear,@FiscalQuarter,@Plant,@Sale,@WorkingHours,@Headcount,@ALC,@FGOut_sqft,@Efficiency) 
--					EXECUTE (@SQLString)
--
--					SET @Plant='B4'					
--				if @FiscalQuarter='1'					
--					BEGIN
--					SET @WorkingHours=(select ISNULL(SUM(WorkingHours),0) from KOI_InputByHR WHERE Plant=@Plant AND Financey = @FiscalYear AND Period BETWEEN 1 AND 3)					
--					SET @Headcount =(SELECT ISNULL(SUM(Headcount),0) FROM KOI_InputByHR where Financey=@FiscalYear AND Plant=@Plant AND Period BETWEEN 1 AND 3) 
--					SET @FGOut_sqft =(select ISNULL(sum([ShipmentArea(SQFT)]),0) from dbo.EXR2_Details where replace(FYear,'FY','') = @FiscalYear and Plant = @Plant AND Period BETWEEN 'P01' AND 'P03') 
--					END
--				if @FiscalQuarter='2'
--					BEGIN
--					SET @WorkingHours=(select ISNULL(SUM(WorkingHours),0) from KOI_InputByHR WHERE Plant=@Plant AND Financey = @FiscalYear AND Period BETWEEN 4 AND 6)
--					SET @Headcount =(SELECT ISNULL(SUM(Headcount),0) FROM KOI_InputByHR where Financey=@FiscalYear AND Plant=@Plant AND Period BETWEEN 4 AND 6) 
--					SET @FGOut_sqft =(select ISNULL(sum([ShipmentArea(SQFT)]),0) from dbo.EXR2_Details where replace(FYear,'FY','') = @FiscalYear and Plant = @Plant AND Period BETWEEN 'P04' AND 'P06') 
--					END
--				if @FiscalQuarter='3'
--					BEGIN
--					SET @WorkingHours=(select ISNULL(SUM(WorkingHours),0) from KOI_InputByHR WHERE Plant=@Plant AND Financey = @FiscalYear AND Period BETWEEN 7 AND 9)
--					SET @Headcount =(SELECT ISNULL(SUM(Headcount),0) FROM KOI_InputByHR where Financey=@FiscalYear AND Plant=@Plant AND Period BETWEEN 7 AND 9) 
--					SET @FGOut_sqft =(select ISNULL(sum([ShipmentArea(SQFT)]),0) from dbo.EXR2_Details where replace(FYear,'FY','') = @FiscalYear and Plant = @Plant AND Period BETWEEN 'P07' AND 'P09') 
--					END
--				if @FiscalQuarter='4'
--					BEGIN
--					SET @WorkingHours=(select ISNULL(SUM(WorkingHours),0) from KOI_InputByHR WHERE Plant=@Plant AND Financey = @FiscalYear AND Period BETWEEN 10 AND 12)
--					SET @Headcount =(SELECT ISNULL(SUM(Headcount),0) FROM KOI_InputByHR where Financey=@FiscalYear AND Plant=@Plant AND Period BETWEEN 10 AND 12) 
--					SET @FGOut_sqft =(select ISNULL(sum([ShipmentArea(SQFT)]),0) from dbo.EXR2_Details where replace(FYear,'FY','') = @FiscalYear and Plant = @Plant AND Period BETWEEN 'P10' AND 'P12') 
--					END	
--
--					SET @Sale='Ex-factory Sale               '								
--					SET @ALC = (SELECT ISNULL((CASE convert(numeric(18,2),SUM(T$AREA)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$LYER*T$AREA)/SUM(T$AREA)) END),0) AS ALC from TFSOLP112180 WHERE T$PLNT=@Plant AND T$SOUR=@Sale AND T$Date BETWEEN @FiscalQuarterFrom AND @FiscalQuarterTo) 				
--					--Efficiency=FG out (sqft) * ALC /DL Working Hours
--					SET @Efficiency = (SELECT ISNULL(CASE @WorkingHours WHEN 0 THEN 0 ELSE (@FGOut_sqft*@ALC) / @WorkingHours END,0)) 
--					SET @SQLString=dbo.KOI_fun_Get_Quarterly_Productivity_Image_Layer_SQL_String(@FiscalYear,@FiscalQuarter,@Plant,@Sale,@WorkingHours,@Headcount,@ALC,@FGOut_sqft,@Efficiency) 
--					EXECUTE (@SQLString)
--
--					SET @Sale='Invoice Sale                  '
--					SET @ALC = (SELECT ISNULL((CASE convert(numeric(18,2),SUM(T$AREA)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$LYER*T$AREA)/SUM(T$AREA)) END),0) AS ALC from TFSOLP112180 WHERE T$PLNT=@Plant AND T$SOUR=@Sale AND T$Date BETWEEN @FiscalQuarterFrom AND @FiscalQuarterTo)  
--					SET @Efficiency = (SELECT ISNULL(CASE @WorkingHours WHEN 0 THEN 0 ELSE (@FGOut_sqft*@ALC) / @WorkingHours END,0)) 
--					SET @SQLString=dbo.KOI_fun_Get_Quarterly_Productivity_Image_Layer_SQL_String(@FiscalYear,@FiscalQuarter,@Plant,@Sale,@WorkingHours,@Headcount,@ALC,@FGOut_sqft,@Efficiency) 
--					EXECUTE (@SQLString)
--
--					SET @Sale='Production output             '				
--					SET @ALC = (SELECT ISNULL((CASE convert(numeric(18,2),SUM(T$AREA)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$LYER*T$AREA)/SUM(T$AREA)) END),0) AS ALC from TFSOLP112180 WHERE T$PLNT=@Plant AND T$SOUR=@Sale AND T$Date BETWEEN @FiscalQuarterFrom AND @FiscalQuarterTo) 
--					SET @Efficiency = (SELECT ISNULL(CASE @WorkingHours WHEN 0 THEN 0 ELSE (@FGOut_sqft*@ALC) / @WorkingHours END,0)) 
--					SET @SQLString=dbo.KOI_fun_Get_Quarterly_Productivity_Image_Layer_SQL_String(@FiscalYear,@FiscalQuarter,@Plant,@Sale,@WorkingHours,@Headcount,@ALC,@FGOut_sqft,@Efficiency) 
--					EXECUTE (@SQLString)				
--							
--					SET @Plant='B5'					
--				if @FiscalQuarter='1'					
--					BEGIN
--					SET @WorkingHours=(select ISNULL(SUM(WorkingHours),0) from KOI_InputByHR WHERE Plant=@Plant AND Financey = @FiscalYear AND Period BETWEEN 1 AND 3)					
--					SET @Headcount =(SELECT ISNULL(SUM(Headcount),0) FROM KOI_InputByHR where Financey=@FiscalYear AND Plant=@Plant AND Period BETWEEN 1 AND 3) 
--					SET @FGOut_sqft =(select ISNULL(sum([ShipmentArea(SQFT)]),0) from dbo.EXR2_Details where replace(FYear,'FY','') = @FiscalYear and Plant = @Plant AND Period BETWEEN 'P01' AND 'P03') 
--					END
--				if @FiscalQuarter='2'
--					BEGIN
--					SET @WorkingHours=(select ISNULL(SUM(WorkingHours),0) from KOI_InputByHR WHERE Plant=@Plant AND Financey = @FiscalYear AND Period BETWEEN 4 AND 6)
--					SET @Headcount =(SELECT ISNULL(SUM(Headcount),0) FROM KOI_InputByHR where Financey=@FiscalYear AND Plant=@Plant AND Period BETWEEN 4 AND 6) 
--					SET @FGOut_sqft =(select ISNULL(sum([ShipmentArea(SQFT)]),0) from dbo.EXR2_Details where replace(FYear,'FY','') = @FiscalYear and Plant = @Plant AND Period BETWEEN 'P04' AND 'P06') 
--					END
--				if @FiscalQuarter='3'
--					BEGIN
--					SET @WorkingHours=(select ISNULL(SUM(WorkingHours),0) from KOI_InputByHR WHERE Plant=@Plant AND Financey = @FiscalYear AND Period BETWEEN 7 AND 9)
--					SET @Headcount =(SELECT ISNULL(SUM(Headcount),0) FROM KOI_InputByHR where Financey=@FiscalYear AND Plant=@Plant AND Period BETWEEN 7 AND 9) 
--					SET @FGOut_sqft =(select ISNULL(sum([ShipmentArea(SQFT)]),0) from dbo.EXR2_Details where replace(FYear,'FY','') = @FiscalYear and Plant = @Plant AND Period BETWEEN 'P07' AND 'P09') 
--					END
--				if @FiscalQuarter='4'
--					BEGIN
--					SET @WorkingHours=(select ISNULL(SUM(WorkingHours),0) from KOI_InputByHR WHERE Plant=@Plant AND Financey = @FiscalYear AND Period BETWEEN 10 AND 12)
--					SET @Headcount =(SELECT ISNULL(SUM(Headcount),0) FROM KOI_InputByHR where Financey=@FiscalYear AND Plant=@Plant AND Period BETWEEN 10 AND 12) 
--					SET @FGOut_sqft =(select ISNULL(sum([ShipmentArea(SQFT)]),0) from dbo.EXR2_Details where replace(FYear,'FY','') = @FiscalYear and Plant = @Plant AND Period BETWEEN 'P10' AND 'P12') 
--					END	
--
--					SET @Sale='Ex-factory Sale               '								
--					SET @ALC = (SELECT ISNULL((CASE convert(numeric(18,2),SUM(T$AREA)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$LYER*T$AREA)/SUM(T$AREA)) END),0) AS ALC from TFSOLP112180 WHERE T$PLNT=@Plant AND T$SOUR=@Sale AND T$Date BETWEEN @FiscalQuarterFrom AND @FiscalQuarterTo) 				
--					--Efficiency=FG out (sqft) * ALC /DL Working Hours
--					SET @Efficiency = (SELECT ISNULL(CASE @WorkingHours WHEN 0 THEN 0 ELSE (@FGOut_sqft*@ALC) / @WorkingHours END,0)) 
--					SET @SQLString=dbo.KOI_fun_Get_Quarterly_Productivity_Image_Layer_SQL_String(@FiscalYear,@FiscalQuarter,@Plant,@Sale,@WorkingHours,@Headcount,@ALC,@FGOut_sqft,@Efficiency) 
--					EXECUTE (@SQLString)
--
--					SET @Sale='Invoice Sale                  '
--					SET @ALC = (SELECT ISNULL((CASE convert(numeric(18,2),SUM(T$AREA)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$LYER*T$AREA)/SUM(T$AREA)) END),0) AS ALC from TFSOLP112180 WHERE T$PLNT=@Plant AND T$SOUR=@Sale AND T$Date BETWEEN @FiscalQuarterFrom AND @FiscalQuarterTo)  
--					SET @Efficiency = (SELECT ISNULL(CASE @WorkingHours WHEN 0 THEN 0 ELSE (@FGOut_sqft*@ALC) / @WorkingHours END,0)) 
--					SET @SQLString=dbo.KOI_fun_Get_Quarterly_Productivity_Image_Layer_SQL_String(@FiscalYear,@FiscalQuarter,@Plant,@Sale,@WorkingHours,@Headcount,@ALC,@FGOut_sqft,@Efficiency) 
--					EXECUTE (@SQLString)
--
--					SET @Sale='Production output             '				
--					SET @ALC = (SELECT ISNULL((CASE convert(numeric(18,2),SUM(T$AREA)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$LYER*T$AREA)/SUM(T$AREA)) END),0) AS ALC from TFSOLP112180 WHERE T$PLNT=@Plant AND T$SOUR=@Sale AND T$Date BETWEEN @FiscalQuarterFrom AND @FiscalQuarterTo) 
--					SET @Efficiency = (SELECT ISNULL(CASE @WorkingHours WHEN 0 THEN 0 ELSE (@FGOut_sqft*@ALC) / @WorkingHours END,0)) 
--					SET @SQLString=dbo.KOI_fun_Get_Quarterly_Productivity_Image_Layer_SQL_String(@FiscalYear,@FiscalQuarter,@Plant,@Sale,@WorkingHours,@Headcount,@ALC,@FGOut_sqft,@Efficiency) 
--					EXECUTE (@SQLString)	
--
--					SET @Plant='All'
--					SET @Sale='Ex-factory Sale               '		
--					SET @WorkingHours=(select ISNULL(SUM(WorkingHours),0) from KOI_Quarterly_Productivity_Image_Layer where Plant<>'All' AND Plant<>'Allexclude2F' AND [Year]=@Fiscalyear AND Quarter=@FiscalQuarter AND Sale=@Sale) 
--					SET @Headcount=(select ISNULL(SUM(Headcount),0) from KOI_Quarterly_Productivity_Image_Layer where Plant<>'All' AND Plant<>'Allexclude2F' AND [Year]=@Fiscalyear AND Quarter=@FiscalQuarter AND Sale=@Sale) 
--					SET @ALC=(select ISNULL(SUM(ALC),0) from KOI_Quarterly_Productivity_Image_Layer where Plant<>'All' AND Plant<>'Allexclude2F' AND [Year]=@Fiscalyear AND Quarter=@FiscalQuarter AND Sale=@Sale) 
--					SET @FGOut_sqft=(select ISNULL(SUM(FGOut_sqft),0) from KOI_Quarterly_Productivity_Image_Layer where Plant<>'All' AND Plant<>'Allexclude2F' AND [Year]=@Fiscalyear AND Quarter=@FiscalQuarter AND Sale=@Sale) 
--					SET @Efficiency=(select ISNULL(SUM(Efficiency),0) from KOI_Quarterly_Productivity_Image_Layer where Plant<>'All' AND Plant<>'Allexclude2F' AND [Year]=@Fiscalyear AND Quarter=@FiscalQuarter AND Sale=@Sale) 
--					SET @SQLString=dbo.KOI_fun_Get_Quarterly_Productivity_Image_Layer_SQL_String(@FiscalYear,@FiscalQuarter,@Plant,@Sale,@WorkingHours,@Headcount,@ALC,@FGOut_sqft,@Efficiency) 
--					EXECUTE (@SQLString)
--					SET @Sale='Invoice Sale                  '
--					SET @WorkingHours=(select ISNULL(SUM(WorkingHours),0) from KOI_Quarterly_Productivity_Image_Layer where Plant<>'All' AND Plant<>'Allexclude2F' AND [Year]=@Fiscalyear AND Quarter=@FiscalQuarter AND Sale=@Sale) 
--					SET @Headcount=(select ISNULL(SUM(Headcount),0) from KOI_Quarterly_Productivity_Image_Layer where Plant<>'All' AND Plant<>'Allexclude2F' AND [Year]=@Fiscalyear AND Quarter=@FiscalQuarter AND Sale=@Sale) 
--					SET @ALC=(select ISNULL(SUM(ALC),0) from KOI_Quarterly_Productivity_Image_Layer where Plant<>'All' AND Plant<>'Allexclude2F' AND [Year]=@Fiscalyear AND Quarter=@FiscalQuarter AND Sale=@Sale) 
--					SET @FGOut_sqft=(select ISNULL(SUM(FGOut_sqft),0) from KOI_Quarterly_Productivity_Image_Layer where Plant<>'All' AND Plant<>'Allexclude2F' AND [Year]=@Fiscalyear AND Quarter=@FiscalQuarter AND Sale=@Sale) 
--					SET @Efficiency=(select ISNULL(SUM(Efficiency),0) from KOI_Quarterly_Productivity_Image_Layer where Plant<>'All' AND Plant<>'Allexclude2F' AND [Year]=@Fiscalyear AND Quarter=@FiscalQuarter AND Sale=@Sale) 
--					SET @SQLString=dbo.KOI_fun_Get_Quarterly_Productivity_Image_Layer_SQL_String(@FiscalYear,@FiscalQuarter,@Plant,@Sale,@WorkingHours,@Headcount,@ALC,@FGOut_sqft,@Efficiency) 
--					EXECUTE (@SQLString)
--					SET @Sale='Production output             '		
--					SET @WorkingHours=(select ISNULL(SUM(WorkingHours),0) from KOI_Quarterly_Productivity_Image_Layer where Plant<>'All' AND Plant<>'Allexclude2F' AND [Year]=@Fiscalyear AND Quarter=@FiscalQuarter AND Sale=@Sale) 
--					SET @Headcount=(select ISNULL(SUM(Headcount),0) from KOI_Quarterly_Productivity_Image_Layer where Plant<>'All' AND Plant<>'Allexclude2F' AND [Year]=@Fiscalyear AND Quarter=@FiscalQuarter AND Sale=@Sale) 
--					SET @ALC=(select ISNULL(SUM(ALC),0) from KOI_Quarterly_Productivity_Image_Layer where Plant<>'All' AND Plant<>'Allexclude2F' AND [Year]=@Fiscalyear AND Quarter=@FiscalQuarter AND Sale=@Sale) 
--					SET @FGOut_sqft=(select ISNULL(SUM(FGOut_sqft),0) from KOI_Quarterly_Productivity_Image_Layer where Plant<>'All' AND Plant<>'Allexclude2F' AND [Year]=@Fiscalyear AND Quarter=@FiscalQuarter AND Sale=@Sale) 
--					SET @Efficiency=(select ISNULL(SUM(Efficiency),0) from KOI_Quarterly_Productivity_Image_Layer where Plant<>'All' AND Plant<>'Allexclude2F' AND [Year]=@Fiscalyear AND Quarter=@FiscalQuarter AND Sale=@Sale) 
--					SET @SQLString=dbo.KOI_fun_Get_Quarterly_Productivity_Image_Layer_SQL_String(@FiscalYear,@FiscalQuarter,@Plant,@Sale,@WorkingHours,@Headcount,@ALC,@FGOut_sqft,@Efficiency) 
--					EXECUTE (@SQLString)			
--
--			FETCH NEXT FROM Layer_Quarter_C INTO @Fiscalyear,@FiscalQuarter,@FiscalQuarterFrom,@FiscalQuarterTo
--		END
--	CLOSE Layer_Quarter_C 
--	DEALLOCATE Layer_Quarter_C 
	
END











GO
