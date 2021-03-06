USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[DistributionReport_sp_Query_Techincs_Amount_RMA_Detail]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DistributionReport_sp_Query_Techincs_Amount_RMA_Detail]
	-- Add the parameters for the stored procedure here
	@ReportCode VARCHAR(20),
	@Type VARCHAR(20),
	@Site VARCHAR(50),
	@Plant VARCHAR(50),
	@Year VARCHAR(4)
AS
BEGIN
	SET NOCOUNT ON;
	
	SET @Plant=(CASE @Plant WHEN 'B1' THEN 'P2' WHEN 'B2F' THEN '2F' WHEN 'VVI' THEN 'HK' WHEN 'ZhuHai' THEN '%' ELSE @Plant END)

    -- Insert statements for procedure here
 
	SELECT (CASE WHEN @ReportCode='001' THEN a.YEAR ELSE a.Year+0 END) AS Year,a.Site,a.Plant,a.Technics,M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12,Amount
	INTO #Temp
	FROM DistributionReport_Technics_Amount a
	WHERE a.ReportCode=@ReportCode
		AND a.TYPE=@Type
		AND a.Site=@Site
		AND a.Plant LIKE @Plant
		AND a.YEAR=@Year
	ORDER BY a.YEAR,a.Technics,a.Site,a.Plant

	IF @@ROWCOUNT=0
		BEGIN
			SELECT @Year AS Year,@Site AS Site,@Plant AS Plant,'' AS Technics,0 AS M1,0 AS M2,0 AS M3,0 AS M4,0 AS M5,00 AS M6,0 AS M7,0 AS M8,0 AS M9,0 AS M10,0 AS M11,0 AS M12,0 AS Amount
		END
	
	IF @Plant='%'
		BEGIN
			SELECT YEAR,'' AS Site,'ZZZZZTotal' AS Plant,Technics,SUM(M1) AS M1,SUM(M2) AS M2,SUM(M3) AS M3,SUM(M4) AS M4,SUM(M5) AS M5,SUM(M6) AS M6,SUM(M7) AS M7,SUM(M8) AS M8,SUM(M9) AS M9,SUM(M10) AS M10,SUM(M11) AS M11,SUM(M12) AS M12,SUM(Amount) AS Amount
			INTO #TempGroupYearTechnics
			FROM #Temp
			GROUP BY YEAR,Technics
		END
	SELECT YEAR,'' AS Site,'' AS Plant,'ZZZZZTotal' AS Technics,SUM(M1) AS M1,SUM(M2) AS M2,SUM(M3) AS M3,SUM(M4) AS M4,SUM(M5) AS M5,SUM(M6) AS M6,SUM(M7) AS M7,SUM(M8) AS M8,SUM(M9) AS M9,SUM(M10) AS M10,SUM(M11) AS M11,SUM(M12) AS M12,SUM(Amount) AS Amount
	INTO #TempGroupYear
	FROM #Temp
	GROUP BY YEAR

	INSERT INTO #Temp
	SELECT * FROM #TempGroupYear
	
	IF @Plant='%'
		BEGIN
			INSERT INTO #Temp
			SELECT * FROM #TempGroupYearTechnics
		END
	
	UPDATE #Temp
	SET Plant=(CASE Plant WHEN 'P2' THEN 'B1' WHEN '2F' THEN 'B2F' WHEN 'HK' THEN 'VVI' ELSE Plant END)

	SELECT * FROM #Temp 	WHERE Amount<>0  ORDER BY YEAR,Technics,Plant
	
	/*
	ALTER TABLE #Temp ADD TempAmount NUMERIC(19,8) 
	UPDATE #Temp SET TempAmount=Amount

	UPDATE #Temp
	SET TempAmount=TempAmount/999999999.99999999
	
	SELECT * INTO #Temp1 FROM #Temp 	WHERE Amount<>0 ORDER BY YEAR,TempAmount DESC,Technics,Plant
	
	ALTER TABLE #Temp1 DROP COLUMN TempAmount

	SELECT * FROM #Temp1
	*/
END
GO
