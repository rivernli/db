USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[GlobalViewReport_sp_Query_WeeklyIncoming_Range]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GlobalViewReport_sp_Query_WeeklyIncoming_Range]
	-- Add the parameters for the stored procedure here
	@Plant VARCHAR(50),
	@WeekYearFrom CHAR(7),
	@WeekYearTo CHAR(7)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
    -- Insert statements for procedure here
	DECLARE @Quarter INT,@Year INT,@WeekFrom INT,@WeekTo INT,@YearFrom INT,@YearTo INT,@SQLString VARCHAR(MAX),@WeekPeriodYear VARCHAR(50),@Amount NUMERIC(19,4),@DateFrom DATE,@DateTo DATE,@Forecast NUMERIC(19,4),@WeekNumber INT
	SET @WeekFrom=SUBSTRING(@WeekYearFrom,2,2)
	SET @YearFrom='20'+RIGHT(@WeekYearFrom,2)
	SET @WeekTo=SUBSTRING(@WeekYearTo,2,2)
	SET @YearTo='20'+RIGHT(@WeekYearTo,2)
	SET @Quarter=ISNULL(@Quarter,1)
	SELECT (CASE FiscalPeriod WHEN 1 THEN 'Apr' WHEN 2 THEN 'May' WHEN 3 THEN 'Jun' WHEN 4 THEN 'Jul' WHEN 5 THEN 'Aug' WHEN 6 THEN 'Sep' WHEN 7 THEN 'Oct' WHEN 8 THEN 'Nov' WHEN 9 THEN 'Dec' WHEN 10 THEN 'Jan' WHEN 11 THEN 'Feb' ELSE 'Mar' END) 
		    +'(P'+(CASE WHEN FiscalPeriod<10 THEN '0' ELSE '' END)+CONVERT(VARCHAR(2),FiscalPeriod)+') , '
			+CONVERT(VARCHAR(4),FiscalYear) AS PeriodYear
	FROM Calendar  
	WHERE calenderDate BETWEEN 
			(
				SELECT MIN(calenderDate) FROM Calendar WHERE FiscalWeek=@WeekFrom AND FiscalYear=@YearFrom
			) 
			AND
			(
				SELECT MAX(calenderDate) FROM Calendar WHERE FiscalWeek=@WeekTo AND FiscalYear=@YearTo
			) 
	GROUP BY FiscalYear,FiscalPeriod

	DECLARE @TempForecast TABLE (Period INT,Amount NUMERIC(19,4))
	DECLARE @ForecastAmount NUMERIC(19,4)
	SET @ForecastAmount=(SELECT M1 FROM DistributionReport_Forecast WHERE TYPE='Incoming' AND Site='Chi' AND Plant=(CASE @Plant WHEN 'B1' THEN 'P2' WHEN 'B2F' THEN '2F' WHEN 'B3' THEN 'B3' WHEN 'B4' THEN 'B4' WHEN 'B5' THEN 'B5' WHEN 'VVI' THEN 'HK' WHEN 'SUB' THEN 'SUB' WHEN 'TOTAL' THEN '' WHEN 'RIGID' THEN 'ZhuHaiEXB2F' ELSE 'N/A' END) AND Year=2012)
	INSERT INTO @TempForecast VALUES(1,@ForecastAmount)
	SET @ForecastAmount=(SELECT M2 FROM DistributionReport_Forecast WHERE TYPE='Incoming' AND Site='Chi' AND Plant=(CASE @Plant WHEN 'B1' THEN 'P2' WHEN 'B2F' THEN '2F' WHEN 'B3' THEN 'B3' WHEN 'B4' THEN 'B4' WHEN 'B5' THEN 'B5' WHEN 'VVI' THEN 'HK' WHEN 'SUB' THEN 'SUB' WHEN 'TOTAL' THEN '' WHEN 'RIGID' THEN 'ZhuHaiEXB2F' ELSE 'N/A' END) AND Year=2012)
	INSERT INTO @TempForecast VALUES(2,@ForecastAmount)
	SET @ForecastAmount=(SELECT M3 FROM DistributionReport_Forecast WHERE TYPE='Incoming' AND Site='Chi' AND Plant=(CASE @Plant WHEN 'B1' THEN 'P2' WHEN 'B2F' THEN '2F' WHEN 'B3' THEN 'B3' WHEN 'B4' THEN 'B4' WHEN 'B5' THEN 'B5' WHEN 'VVI' THEN 'HK' WHEN 'SUB' THEN 'SUB' WHEN 'TOTAL' THEN '' WHEN 'RIGID' THEN 'ZhuHaiEXB2F' ELSE 'N/A' END) AND Year=2012)
	INSERT INTO @TempForecast VALUES(3,@ForecastAmount)
	SET @ForecastAmount=(SELECT M4 FROM DistributionReport_Forecast WHERE TYPE='Incoming' AND Site='Chi' AND Plant=(CASE @Plant WHEN 'B1' THEN 'P2' WHEN 'B2F' THEN '2F' WHEN 'B3' THEN 'B3' WHEN 'B4' THEN 'B4' WHEN 'B5' THEN 'B5' WHEN 'VVI' THEN 'HK' WHEN 'SUB' THEN 'SUB' WHEN 'TOTAL' THEN '' WHEN 'RIGID' THEN 'ZhuHaiEXB2F' ELSE 'N/A' END) AND Year=2012)
	INSERT INTO @TempForecast VALUES(4,@ForecastAmount)
	SET @ForecastAmount=(SELECT M5 FROM DistributionReport_Forecast WHERE TYPE='Incoming' AND Site='Chi' AND Plant=(CASE @Plant WHEN 'B1' THEN 'P2' WHEN 'B2F' THEN '2F' WHEN 'B3' THEN 'B3' WHEN 'B4' THEN 'B4' WHEN 'B5' THEN 'B5' WHEN 'VVI' THEN 'HK' WHEN 'SUB' THEN 'SUB' WHEN 'TOTAL' THEN '' WHEN 'RIGID' THEN 'ZhuHaiEXB2F' ELSE 'N/A' END) AND Year=2012)
	INSERT INTO @TempForecast VALUES(5,@ForecastAmount)
	SET @ForecastAmount=(SELECT M6 FROM DistributionReport_Forecast WHERE TYPE='Incoming' AND Site='Chi' AND Plant=(CASE @Plant WHEN 'B1' THEN 'P2' WHEN 'B2F' THEN '2F' WHEN 'B3' THEN 'B3' WHEN 'B4' THEN 'B4' WHEN 'B5' THEN 'B5' WHEN 'VVI' THEN 'HK' WHEN 'SUB' THEN 'SUB' WHEN 'TOTAL' THEN '' WHEN 'RIGID' THEN 'ZhuHaiEXB2F' ELSE 'N/A' END) AND Year=2012)
	INSERT INTO @TempForecast VALUES(6,@ForecastAmount)
	SET @ForecastAmount=(SELECT M7 FROM DistributionReport_Forecast WHERE TYPE='Incoming' AND Site='Chi' AND Plant=(CASE @Plant WHEN 'B1' THEN 'P2' WHEN 'B2F' THEN '2F' WHEN 'B3' THEN 'B3' WHEN 'B4' THEN 'B4' WHEN 'B5' THEN 'B5' WHEN 'VVI' THEN 'HK' WHEN 'SUB' THEN 'SUB' WHEN 'TOTAL' THEN '' WHEN 'RIGID' THEN 'ZhuHaiEXB2F' ELSE 'N/A' END) AND Year=2012)
	INSERT INTO @TempForecast VALUES(7,@ForecastAmount)
	SET @ForecastAmount=(SELECT M8 FROM DistributionReport_Forecast WHERE TYPE='Incoming' AND Site='Chi' AND Plant=(CASE @Plant WHEN 'B1' THEN 'P2' WHEN 'B2F' THEN '2F' WHEN 'B3' THEN 'B3' WHEN 'B4' THEN 'B4' WHEN 'B5' THEN 'B5' WHEN 'VVI' THEN 'HK' WHEN 'SUB' THEN 'SUB' WHEN 'TOTAL' THEN '' WHEN 'RIGID' THEN 'ZhuHaiEXB2F' ELSE 'N/A' END) AND Year=2012)
	INSERT INTO @TempForecast VALUES(8,@ForecastAmount)
	SET @ForecastAmount=(SELECT M9 FROM DistributionReport_Forecast WHERE TYPE='Incoming' AND Site='Chi' AND Plant=(CASE @Plant WHEN 'B1' THEN 'P2' WHEN 'B2F' THEN '2F' WHEN 'B3' THEN 'B3' WHEN 'B4' THEN 'B4' WHEN 'B5' THEN 'B5' WHEN 'VVI' THEN 'HK' WHEN 'SUB' THEN 'SUB' WHEN 'TOTAL' THEN '' WHEN 'RIGID' THEN 'ZhuHaiEXB2F' ELSE 'N/A' END) AND Year=2012)
	INSERT INTO @TempForecast VALUES(9,@ForecastAmount)
	SET @ForecastAmount=(SELECT M10 FROM DistributionReport_Forecast WHERE TYPE='Incoming' AND Site='Chi' AND Plant=(CASE @Plant WHEN 'B1' THEN 'P2' WHEN 'B2F' THEN '2F' WHEN 'B3' THEN 'B3' WHEN 'B4' THEN 'B4' WHEN 'B5' THEN 'B5' WHEN 'VVI' THEN 'HK' WHEN 'SUB' THEN 'SUB' WHEN 'TOTAL' THEN '' WHEN 'RIGID' THEN 'ZhuHaiEXB2F' ELSE 'N/A' END) AND Year=2012)
	INSERT INTO @TempForecast VALUES(10,@ForecastAmount)
	SET @ForecastAmount=(SELECT M11 FROM DistributionReport_Forecast WHERE TYPE='Incoming' AND Site='Chi' AND Plant=(CASE @Plant WHEN 'B1' THEN 'P2' WHEN 'B2F' THEN '2F' WHEN 'B3' THEN 'B3' WHEN 'B4' THEN 'B4' WHEN 'B5' THEN 'B5' WHEN 'VVI' THEN 'HK' WHEN 'SUB' THEN 'SUB' WHEN 'TOTAL' THEN '' WHEN 'RIGID' THEN 'ZhuHaiEXB2F' ELSE 'N/A' END) AND Year=2012)
	INSERT INTO @TempForecast VALUES(11,@ForecastAmount)
	SET @ForecastAmount=(SELECT M12 FROM DistributionReport_Forecast WHERE TYPE='Incoming' AND Site='Chi' AND Plant=(CASE @Plant WHEN 'B1' THEN 'P2' WHEN 'B2F' THEN '2F' WHEN 'B3' THEN 'B3' WHEN 'B4' THEN 'B4' WHEN 'B5' THEN 'B5' WHEN 'VVI' THEN 'HK' WHEN 'SUB' THEN 'SUB' WHEN 'TOTAL' THEN '' WHEN 'RIGID' THEN 'ZhuHaiEXB2F' ELSE 'N/A' END) AND Year=2012)
	INSERT INTO @TempForecast VALUES(12,@ForecastAmount)
SELECT * FROM @TempForecast
	SELECT FiscalYear,FiscalQuarter,
		(
			SELECT M1+M2+M3+ M4+ M5+ M6+ M7+ M8+ M9+ M10+ M11+ M12 
			FROM DistributionReport_Forecast 
				WHERE TYPE='Incoming' 
				AND Site='Chi'
				AND Plant=(CASE @Plant WHEN 'B1' THEN 'P2' WHEN 'B2F' THEN '2F' WHEN 'B3' THEN 'B3' WHEN 'B4' THEN 'B4' WHEN 'B5' THEN 'B5' WHEN 'VVI' THEN 'HK' WHEN 'SUB' THEN 'SUB' WHEN 'TOTAL' THEN '' WHEN 'RIGID' THEN 'ZhuHaiEXB2F' ELSE 'N/A' END)
				AND Year=Calendar.FiscalYear
		) AS Forecast
	FROM Calendar  
	WHERE calenderDate BETWEEN 
			(
				SELECT MIN(calenderDate) FROM Calendar WHERE FiscalWeek=@WeekFrom AND FiscalYear=@YearFrom
			) 
			AND
			(
				SELECT MAX(calenderDate) FROM Calendar WHERE FiscalWeek=@WeekTo AND FiscalYear=@YearTo
			) 
	GROUP BY FiscalYear,FiscalQuarter
	
	CREATE TABLE #Temp (Item VARCHAR(10))
	INSERT INTO #Temp VALUES ('Order')
	INSERT INTO #Temp VALUES ('FIN CST')
	INSERT INTO #Temp VALUES ('GAP')
	
	DECLARE WeekPeriodYear_C CURSOR FORWARD_ONLY READ_ONLY
	FOR
	SELECT  'W'+(CASE WHEN FiscalWeek<10 THEN '0' ELSE '' END)+CONVERT(VARCHAR(2),FiscalWeek)+' , '+
			+(CASE FiscalPeriod WHEN 1 THEN 'Apr' WHEN 2 THEN 'May' WHEN 3 THEN 'Jun' WHEN 4 THEN 'Jul' WHEN 5 THEN 'Aug' WHEN 6 THEN 'Sep' WHEN 7 THEN 'Oct' WHEN 8 THEN 'Nov' WHEN 9 THEN 'Dec' WHEN 10 THEN 'Jan' WHEN 11 THEN 'Feb' ELSE 'Mar' END) 
		    +'(P'+(CASE WHEN FiscalPeriod<10 THEN '0' ELSE '' END)+CONVERT(VARCHAR(2),FiscalPeriod)+') , '
			+CONVERT(VARCHAR(4),FiscalYear) AS WeekPeriodYear
	FROM Calendar  
	WHERE calenderDate BETWEEN 
			(
				SELECT MIN(calenderDate) FROM Calendar WHERE FiscalWeek=@WeekFrom AND FiscalYear=@YearFrom
			) 
			AND
			(
				SELECT MAX(calenderDate) FROM Calendar WHERE FiscalWeek=@WeekTo AND FiscalYear=@YearTo
			) 
	GROUP BY FiscalYear,FiscalPeriod,FiscalWeek
	OPEN WeekPeriodYear_C
	FETCH NEXT FROM WeekPeriodYear_C INTO @WeekPeriodYear
	WHILE @@FETCH_STATUS=0
		BEGIN
			SET @SQLString='ALTER TABLE #Temp ADD ['+@WeekPeriodYear+'] NUMERIC(19,4)'
			EXECUTE (@SQLString)
			SET @DateFrom=(
							SELECT MIN(calenderDate)
							FROM Calendar 
							WHERE FiscalWeek=SUBSTRING(@WeekPeriodYear,2,2)
									AND FiscalYear=RIGHT(@WeekPeriodYear,4)
						  )
			SET @DateFrom=(CASE WHEN @DateFrom >CONVERT(VARCHAR(10),GETDATE(),120) THEN CONVERT(VARCHAR(10),GETDATE(),120) ELSE @DateFrom END)	  
			SET @DateTo=(
							SELECT MAX(calenderDate)
							FROM Calendar 
							WHERE FiscalWeek=SUBSTRING(@WeekPeriodYear,2,2)
									AND FiscalYear=RIGHT(@WeekPeriodYear,4)
						  )
			SET @DateTo=(CASE WHEN @DateTo >CONVERT(VARCHAR(10),GETDATE(),120) THEN CONVERT(VARCHAR(10),GETDATE(),120) ELSE @DateTo END)	  
			SET @WeekNumber=(SELECT MAX(FiscalWeek) FROM Calendar WHERE FiscalPeriod=SUBSTRING(@WeekPeriodYear,12,2) AND FiscalYear=RIGHT(@WeekPeriodYear,4))
			IF @Plant='B1'
				BEGIN
					SET @Amount=(
									SELECT ISNULL(SUM(T$MAMT),0)
									FROM TFSOLP121180   WITH (INDEX (DescPlantTrDt))
									WHERE T$DESC ='Order Intake'
										AND T$PLNT='P2'
										AND T$TRDT BETWEEN @DateFrom AND @DateTo
								)
					SET @Forecast=dbo.DistributionReport_fun_Get_Forecast('P2',SUBSTRING(@WeekPeriodYear,12,2),RIGHT(@WeekPeriodYear,4))/@WeekNumber*1.0000
				END
			IF @Plant='B2F'
				BEGIN
					SET @Amount=(
									SELECT ISNULL(SUM(T$MAMT),0)
									FROM TFSOLP121180   WITH (INDEX (DescPlantTrDt))
									WHERE T$DESC ='Order Intake'
										AND T$PLNT='2F'
										AND T$TRDT BETWEEN @DateFrom AND @DateTo
								)
					SET @Forecast=dbo.DistributionReport_fun_Get_Forecast('2F',SUBSTRING(@WeekPeriodYear,12,2),RIGHT(@WeekPeriodYear,4))/@WeekNumber*1.0000
				END
			IF @Plant='B3'
				BEGIN
					SET @Amount=(
									SELECT ISNULL(SUM(T$MAMT),0)
									FROM TFSOLP121180   WITH (INDEX (DescPlantTrDt))
									WHERE T$DESC ='Order Intake'
										AND T$PLNT='B3'
										AND T$TRDT BETWEEN @DateFrom AND @DateTo
								)
					SET @Forecast=dbo.DistributionReport_fun_Get_Forecast('B3',SUBSTRING(@WeekPeriodYear,12,2),RIGHT(@WeekPeriodYear,4))/@WeekNumber*1.0000
				END
			IF @Plant='B4'
				BEGIN
					SET @Amount=(
									SELECT ISNULL(SUM(T$MAMT),0)
									FROM TFSOLP121180   WITH (INDEX (DescPlantTrDt))
									WHERE T$DESC ='Order Intake'
										AND T$PLNT='B4'
										AND T$TRDT BETWEEN @DateFrom AND @DateTo
								)
					SET @Forecast=dbo.DistributionReport_fun_Get_Forecast('B4',SUBSTRING(@WeekPeriodYear,12,2),RIGHT(@WeekPeriodYear,4))/@WeekNumber*1.0000
				END
			IF @Plant='B5'
				BEGIN
					SET @Amount=(
									SELECT ISNULL(SUM(T$MAMT),0)
									FROM TFSOLP121180  WITH (INDEX (DescPlantTrDt))
									WHERE T$DESC ='Order Intake'
										AND T$PLNT='B5'
										AND T$TRDT BETWEEN @DateFrom AND @DateTo
								)
					SET @Forecast=dbo.DistributionReport_fun_Get_Forecast('B5',SUBSTRING(@WeekPeriodYear,12,2),RIGHT(@WeekPeriodYear,4))/@WeekNumber*1.0000
				END
			IF @Plant='VVI'
				BEGIN
					SET @Amount=(
									SELECT ISNULL(SUM(T$MAMT),0)
									FROM TFSOLP121180 
									WHERE T$DESC ='Order Intake'
										AND T$PLNT='HK'
										AND T$COTP IN ('SLT','CLT')
										AND T$TRDT BETWEEN @DateFrom AND @DateTo
								)
					SET @Forecast=dbo.DistributionReport_fun_Get_Forecast('HK',SUBSTRING(@WeekPeriodYear,12,2),RIGHT(@WeekPeriodYear,4))/@WeekNumber*1.0000
				END
			IF @Plant='SUB'
				BEGIN
					SET @Amount=(
									SELECT ISNULL(SUM(T$MAMT),0)
									FROM TFSOLP121180 
									WHERE T$DESC ='Order Intake'
										AND T$PLNT='HK'
										AND T$COTP IN ('SLS','CNG','BFS')
										AND T$TRDT BETWEEN @DateFrom AND @DateTo
								)
					SET @Forecast=dbo.DistributionReport_fun_Get_Forecast('SUB',SUBSTRING(@WeekPeriodYear,12,2),RIGHT(@WeekPeriodYear,4))/@WeekNumber*1.0000
				END
			IF @Plant='Total'
				BEGIN
					SET @Amount=(
									SELECT ISNULL(SUM(T$MAMT),0)
									FROM TFSOLP121180 WITH(INDEX (DescTrDt))
									WHERE T$DESC ='Order Intake'
										AND T$TRDT BETWEEN @DateFrom AND @DateTo
								)
					SET @Forecast=dbo.DistributionReport_fun_Get_Forecast('',SUBSTRING(@WeekPeriodYear,12,2),RIGHT(@WeekPeriodYear,4))/@WeekNumber*1.0000
				END
			IF @Plant='Rigid'
				BEGIN
					SET @Amount=(
									SELECT ISNULL(SUM(T$MAMT),0)
									FROM TFSOLP121180 
									WHERE T$DESC ='Order Intake'
											AND T$PLNT<>'2F'
										    AND T$TRDT BETWEEN @DateFrom AND @DateTo
								)
					SET @Forecast=dbo.DistributionReport_fun_Get_Forecast('ZhuHaiEXB2F',SUBSTRING(@WeekPeriodYear,12,2),RIGHT(@WeekPeriodYear,4))/@WeekNumber*1.0000
				END
				
			SET @SQLString='UPDATE #Temp SET ['+@WeekPeriodYear+']='+CONVERT(VARCHAR(50),@Amount)+' WHERE Item='+''''+'Order'+''''
			EXECUTE (@SQLString)
			SET @SQLString='UPDATE #Temp SET ['+@WeekPeriodYear+']='+CONVERT(VARCHAR(50),@Forecast)+' WHERE Item='+''''+'FIN CST'+''''
			EXECUTE (@SQLString)
			SET @SQLString='UPDATE #Temp SET ['+@WeekPeriodYear+']='+CONVERT(VARCHAR(50),@Amount-@Forecast)+' WHERE Item='+''''+'GAP'+''''
			EXECUTE (@SQLString)
						
			FETCH NEXT FROM WeekPeriodYear_C INTO @WeekPeriodYear
		END
	CLOSE WeekPeriodYear_C
	DEALLOCATE WeekPeriodYear_C
	
	SELECT * FROM #Temp
END
GO
