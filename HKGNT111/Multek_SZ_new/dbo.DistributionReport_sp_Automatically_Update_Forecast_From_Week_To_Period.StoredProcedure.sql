USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[DistributionReport_sp_Automatically_Update_Forecast_From_Week_To_Period]    Script Date: 11/06/2014 15:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DistributionReport_sp_Automatically_Update_Forecast_From_Week_To_Period]
	@OPlant VARCHAR(20),
	@OYear VARCHAR(4)
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @i int,@j int,@SQLString varchar(max),@type varchar(50),@site varchar(50),@Plant varchar(50),@Year VARCHAR(4),@Forecast BIGINT
	CREATE TABLE #Temp (Forecast BIGINT)
	DECLARE forecast_c CURSOR FORWARD_ONLY READ_ONLY FOR
	SELECT Type,Site,Plant,Year FROM DistributionReport_Forecast WHERE Type='incoming' AND YEAR=@OYear AND Plant=@OPlant

	open forecast_c
	FETCH NEXT FROM Forecast_C INTO @Type,@Site,@Plant,@Year
	WHILE @@FETCH_STATUS=0
		BEGIN
			SET @i=1
			SET @j=(SELECT MAX(FiscalWeek) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=1)
			SET @SQLString='INSERT INTO #Temp SELECT '
			WHILE @i<=@j
				BEGIN
					SET @SQLString=@SQLString+' W'+CONVERT(VARCHAR(2),@i)+'+'
					SET @i=@i+1
				END
			SET @SQLString=LEFT(@SQLString,LEN(@SQLString)-1)
			SET @SQLString=@SQLString+' FROM DistributionReport_Forecast_Weekly WHERE TYPE='+''''+@type+''''+' AND Site='+''''+@Site+''''+' AND Plant='+''''+@Plant+''''+' AND Year='+@Year
			TRUNCATE TABLE #Temp
			EXECUTE (@SQLString)
			SET @Forecast=ISNULL((SELECT Forecast FROM #Temp),0)
			UPDATE DistributionReport_Forecast 
			SET M1=@Forecast
			where Type=@Type
				AND Site=@Site
				AND Plant=@Plant
				AND Year=@Year
			SET @i=@j+1
			SET @j=(SELECT MAX(FiscalWeek) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=2)
			SET @SQLString='INSERT INTO #Temp SELECT '
			WHILE @i<=@j
				BEGIN
					SET @SQLString=@SQLString+' W'+CONVERT(VARCHAR(2),@i)+'+'
					SET @i=@i+1
				END
			SET @SQLString=LEFT(@SQLString,LEN(@SQLString)-1)
			SET @SQLString=@SQLString+' FROM DistributionReport_Forecast_Weekly WHERE TYPE='+''''+@type+''''+' AND Site='+''''+@Site+''''+' AND Plant='+''''+@Plant+''''+' AND Year='+@Year
			TRUNCATE TABLE #Temp
			EXECUTE (@SQLString)
			SET @Forecast=ISNULL((SELECT Forecast FROM #Temp),0)
			UPDATE DistributionReport_Forecast 
			SET M2=@Forecast
			where Type=@Type
				AND Site=@Site
				AND Plant=@Plant
				AND Year=@Year
			SET @i=@j+1
			SET @j=(SELECT MAX(FiscalWeek) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=3)
			SET @SQLString='INSERT INTO #Temp SELECT '
			WHILE @i<=@j
				BEGIN
					SET @SQLString=@SQLString+' W'+CONVERT(VARCHAR(2),@i)+'+'
					SET @i=@i+1
				END
			SET @SQLString=LEFT(@SQLString,LEN(@SQLString)-1)
			SET @SQLString=@SQLString+' FROM DistributionReport_Forecast_Weekly WHERE TYPE='+''''+@type+''''+' AND Site='+''''+@Site+''''+' AND Plant='+''''+@Plant+''''+' AND Year='+@Year
			TRUNCATE TABLE #Temp
			EXECUTE (@SQLString)
			SET @Forecast=ISNULL((SELECT Forecast FROM #Temp),0)
			UPDATE DistributionReport_Forecast 
			SET M3=@Forecast
			where Type=@Type
				AND Site=@Site
				AND Plant=@Plant
				AND Year=@Year
			SET @i=@j+1
			SET @j=(SELECT MAX(FiscalWeek) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=4)
			SET @SQLString='INSERT INTO #Temp SELECT '
			WHILE @i<=@j
				BEGIN
					SET @SQLString=@SQLString+' W'+CONVERT(VARCHAR(2),@i)+'+'
					SET @i=@i+1
				END
			SET @SQLString=LEFT(@SQLString,LEN(@SQLString)-1)
			SET @SQLString=@SQLString+' FROM DistributionReport_Forecast_Weekly WHERE TYPE='+''''+@type+''''+' AND Site='+''''+@Site+''''+' AND Plant='+''''+@Plant+''''+' AND Year='+@Year
			TRUNCATE TABLE #Temp
			EXECUTE (@SQLString)
			SET @Forecast=ISNULL((SELECT Forecast FROM #Temp),0)
			UPDATE DistributionReport_Forecast 
			SET M4=@Forecast
			where Type=@Type
				AND Site=@Site
				AND Plant=@Plant
				AND Year=@Year
			SET @i=@j+1
			SET @j=(SELECT MAX(FiscalWeek) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=5)
			SET @SQLString='INSERT INTO #Temp SELECT '
			WHILE @i<=@j
				BEGIN
					SET @SQLString=@SQLString+' W'+CONVERT(VARCHAR(2),@i)+'+'
					SET @i=@i+1
				END
			SET @SQLString=LEFT(@SQLString,LEN(@SQLString)-1)
			SET @SQLString=@SQLString+' FROM DistributionReport_Forecast_Weekly WHERE TYPE='+''''+@type+''''+' AND Site='+''''+@Site+''''+' AND Plant='+''''+@Plant+''''+' AND Year='+@Year
			TRUNCATE TABLE #Temp
			EXECUTE (@SQLString)
			SET @Forecast=ISNULL((SELECT Forecast FROM #Temp),0)
			UPDATE DistributionReport_Forecast 
			SET M5=@Forecast
			where Type=@Type
				AND Site=@Site
				AND Plant=@Plant
				AND Year=@Year
			SET @i=@j+1
			SET @j=(SELECT MAX(FiscalWeek) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=6)
			SET @SQLString='INSERT INTO #Temp SELECT '
			WHILE @i<=@j
				BEGIN
					SET @SQLString=@SQLString+' W'+CONVERT(VARCHAR(2),@i)+'+'
					SET @i=@i+1
				END
			SET @SQLString=LEFT(@SQLString,LEN(@SQLString)-1)
			SET @SQLString=@SQLString+' FROM DistributionReport_Forecast_Weekly WHERE TYPE='+''''+@type+''''+' AND Site='+''''+@Site+''''+' AND Plant='+''''+@Plant+''''+' AND Year='+@Year
			TRUNCATE TABLE #Temp
			EXECUTE (@SQLString)
			SET @Forecast=ISNULL((SELECT Forecast FROM #Temp),0)
			UPDATE DistributionReport_Forecast 
			SET M6=@Forecast
			where Type=@Type
				AND Site=@Site
				AND Plant=@Plant
				AND Year=@Year
			SET @i=@j+1
			SET @j=(SELECT MAX(FiscalWeek) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=7)
			SET @SQLString='INSERT INTO #Temp SELECT '
			WHILE @i<=@j
				BEGIN
					SET @SQLString=@SQLString+' W'+CONVERT(VARCHAR(2),@i)+'+'
					SET @i=@i+1
				END
			SET @SQLString=LEFT(@SQLString,LEN(@SQLString)-1)
			SET @SQLString=@SQLString+' FROM DistributionReport_Forecast_Weekly WHERE TYPE='+''''+@type+''''+' AND Site='+''''+@Site+''''+' AND Plant='+''''+@Plant+''''+' AND Year='+@Year
			TRUNCATE TABLE #Temp
			EXECUTE (@SQLString)
			SET @Forecast=ISNULL((SELECT Forecast FROM #Temp),0)
			UPDATE DistributionReport_Forecast 
			SET M7=@Forecast
			where Type=@Type
				AND Site=@Site
				AND Plant=@Plant
				AND Year=@Year
			SET @i=@j+1
			SET @j=(SELECT MAX(FiscalWeek) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=8)
			SET @SQLString='INSERT INTO #Temp SELECT '
			WHILE @i<=@j
				BEGIN
					SET @SQLString=@SQLString+' W'+CONVERT(VARCHAR(2),@i)+'+'
					SET @i=@i+1
				END
			SET @SQLString=LEFT(@SQLString,LEN(@SQLString)-1)
			SET @SQLString=@SQLString+' FROM DistributionReport_Forecast_Weekly WHERE TYPE='+''''+@type+''''+' AND Site='+''''+@Site+''''+' AND Plant='+''''+@Plant+''''+' AND Year='+@Year
			TRUNCATE TABLE #Temp
			EXECUTE (@SQLString)
			SET @Forecast=ISNULL((SELECT Forecast FROM #Temp),0)
			UPDATE DistributionReport_Forecast 
			SET M8=@Forecast
			where Type=@Type
				AND Site=@Site
				AND Plant=@Plant
				AND Year=@Year
			SET @i=@j+1
			SET @j=(SELECT MAX(FiscalWeek) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=9)
			SET @SQLString='INSERT INTO #Temp SELECT '
			WHILE @i<=@j
				BEGIN
					SET @SQLString=@SQLString+' W'+CONVERT(VARCHAR(2),@i)+'+'
					SET @i=@i+1
				END
			SET @SQLString=LEFT(@SQLString,LEN(@SQLString)-1)
			SET @SQLString=@SQLString+' FROM DistributionReport_Forecast_Weekly WHERE TYPE='+''''+@type+''''+' AND Site='+''''+@Site+''''+' AND Plant='+''''+@Plant+''''+' AND Year='+@Year
			TRUNCATE TABLE #Temp
			EXECUTE (@SQLString)
			SET @Forecast=ISNULL((SELECT Forecast FROM #Temp),0)
			UPDATE DistributionReport_Forecast 
			SET M9=@Forecast
			where Type=@Type
				AND Site=@Site
				AND Plant=@Plant
				AND Year=@Year
			SET @i=@j+1
			SET @j=(SELECT MAX(FiscalWeek) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=10)
			SET @SQLString='INSERT INTO #Temp SELECT '
			WHILE @i<=@j
				BEGIN
					SET @SQLString=@SQLString+' W'+CONVERT(VARCHAR(2),@i)+'+'
					SET @i=@i+1
				END
			SET @SQLString=LEFT(@SQLString,LEN(@SQLString)-1)
			SET @SQLString=@SQLString+' FROM DistributionReport_Forecast_Weekly WHERE TYPE='+''''+@type+''''+' AND Site='+''''+@Site+''''+' AND Plant='+''''+@Plant+''''+' AND Year='+@Year
			TRUNCATE TABLE #Temp
			EXECUTE (@SQLString)
			SET @Forecast=ISNULL((SELECT Forecast FROM #Temp),0)
			UPDATE DistributionReport_Forecast 
			SET M10=@Forecast
			where Type=@Type
				AND Site=@Site
				AND Plant=@Plant
				AND Year=@Year
			SET @i=@j+1
			SET @j=(SELECT MAX(FiscalWeek) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=11)
			SET @SQLString='INSERT INTO #Temp SELECT '
			WHILE @i<=@j
				BEGIN
					SET @SQLString=@SQLString+' W'+CONVERT(VARCHAR(2),@i)+'+'
					SET @i=@i+1
				END
			SET @SQLString=LEFT(@SQLString,LEN(@SQLString)-1)
			SET @SQLString=@SQLString+' FROM DistributionReport_Forecast_Weekly WHERE TYPE='+''''+@type+''''+' AND Site='+''''+@Site+''''+' AND Plant='+''''+@Plant+''''+' AND Year='+@Year
			TRUNCATE TABLE #Temp
			EXECUTE (@SQLString)
			SET @Forecast=ISNULL((SELECT Forecast FROM #Temp),0)
			UPDATE DistributionReport_Forecast 
			SET M11=@Forecast
			where Type=@Type
				AND Site=@Site
				AND Plant=@Plant
				AND Year=@Year
			SET @i=@j+1
			SET @j=(SELECT MAX(FiscalWeek) FROM Calendar WHERE FiscalYear=@Year AND FiscalPeriod=12)
			SET @SQLString='INSERT INTO #Temp SELECT '
			WHILE @i<=@j
				BEGIN
					SET @SQLString=@SQLString+' W'+CONVERT(VARCHAR(2),@i)+'+'
					SET @i=@i+1
				END
			SET @SQLString=LEFT(@SQLString,LEN(@SQLString)-1)
			SET @SQLString=@SQLString+' FROM DistributionReport_Forecast_Weekly WHERE TYPE='+''''+@type+''''+' AND Site='+''''+@Site+''''+' AND Plant='+''''+@Plant+''''+' AND Year='+@Year
			TRUNCATE TABLE #Temp
			EXECUTE (@SQLString)
			SET @Forecast=ISNULL((SELECT Forecast FROM #Temp),0)
			UPDATE DistributionReport_Forecast 
			SET M12=@Forecast
			where Type=@Type
				AND Site=@Site
				AND Plant=@Plant
				AND Year=@Year
				
			FETCH NEXT FROM Forecast_C INTO @Type,@Site,@Plant,@Year
		END
	CLOSE Forecast_C
	DEALLOCATE Forecast_C

END
GO
