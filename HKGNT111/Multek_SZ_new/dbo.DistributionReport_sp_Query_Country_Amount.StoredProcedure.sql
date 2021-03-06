USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[DistributionReport_sp_Query_Country_Amount]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DistributionReport_sp_Query_Country_Amount]
	-- Add the parameters for the stored procedure here
	@ReportCode VARCHAR(20),
	@Type VARCHAR(20),
	@Site VARCHAR(50),
	@Plant VARCHAR(50),
	@Year VARCHAR(4)
AS
BEGIN
	SET NOCOUNT ON;
	
	SET @Plant='%'+(CASE @Plant WHEN 'ZhuHai' THEN '' ELSE @Plant END)+'%'

    -- Insert statements for procedure here
	SELECT (CASE WHEN @ReportCode='001' THEN YEAR ELSE Year+0 END) AS Year,Site,Plant,Country,Continent,M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12,Amount
	INTO #Temp
	FROM DistributionReport_uvw_Amount_Location
	WHERE ReportCode=@ReportCode
		AND TYPE=@Type
		AND Site=@Site
		AND Plant LIKE @Plant
		AND YEAR=@Year
	ORDER BY YEAR,Continent,Country,Site,Plant
	IF @@ROWCOUNT=0
		BEGIN
			SELECT @Year AS Year,@Site AS Site,@Plant AS Plant,'' AS Country,'' AS Continent,0 AS M1,0 AS M2,0 AS M3,0 AS M4,0 AS M5,00 AS M6,0 AS M7,0 AS M8,0 AS M9,0 AS M10,0 AS M11,0 AS M12,0 AS Amount
		END
	
	IF @Plant='%'
		BEGIN
			SELECT YEAR,'' AS Site,'ZZZZZTotal' AS Plant,Country,Continent,SUM(M1) AS M1,SUM(M2) AS M2,SUM(M3) AS M3,SUM(M4) AS M4,SUM(M5) AS M5,SUM(M6) AS M6,SUM(M7) AS M7,SUM(M8) AS M8,SUM(M9) AS M9,SUM(M10) AS M10,SUM(M11) AS M11,SUM(M12) AS M12,SUM(Amount) AS Amount
			INTO #TempGroupYearContinentCountry
			FROM #Temp
			GROUP BY YEAR,Continent,Country
		END
			
	SELECT YEAR,'' AS Site,'' AS Plant,'ZZZZZTotal' AS Country,Continent,SUM(M1) AS M1,SUM(M2) AS M2,SUM(M3) AS M3,SUM(M4) AS M4,SUM(M5) AS M5,SUM(M6) AS M6,SUM(M7) AS M7,SUM(M8) AS M8,SUM(M9) AS M9,SUM(M10) AS M10,SUM(M11) AS M11,SUM(M12) AS M12,SUM(Amount) AS Amount
	INTO #TempGroupYearContinent
	FROM #Temp
	GROUP BY YEAR,Continent

	SELECT YEAR,'' AS Site,'' AS Plant,'' AS Country,'ZZZZZTotal' AS Continent,SUM(M1) AS M1,SUM(M2) AS M2,SUM(M3) AS M3,SUM(M4) AS M4,SUM(M5) AS M5,SUM(M6) AS M6,SUM(M7) AS M7,SUM(M8) AS M8,SUM(M9) AS M9,SUM(M10) AS M10,SUM(M11) AS M11,SUM(M12) AS M12,SUM(Amount) AS Amount
	INTO #TempGroupYear
	FROM #Temp
	GROUP BY YEAR

	IF @Plant='%'
		BEGIN
			INSERT INTO #Temp
			SELECT * FROM #TempGroupYearContinentCountry
		END
	INSERT INTO #Temp
	SELECT * FROM #TempGroupYearContinent
	INSERT INTO #Temp
	SELECT * FROM #TempGroupYear
	
	SELECT * FROM #Temp 	ORDER BY YEAR,Continent,Country,Plant
END
GO
