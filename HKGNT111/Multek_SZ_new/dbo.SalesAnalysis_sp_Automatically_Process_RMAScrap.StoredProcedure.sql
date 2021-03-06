USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[SalesAnalysis_sp_Automatically_Process_RMAScrap]    Script Date: 11/06/2014 15:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SalesAnalysis_sp_Automatically_Process_RMAScrap]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	--Period
	--RMA
	INSERT INTO SalesAnalysis_Amount_Fiscal
	SELECT b.*
	FROM SalesAnalysis_Amount_Fiscal a,
		(
			SELECT '105' AS ReportCode,Site,(CASE Plant WHEN '' THEN 'ZhuHai' WHEN 'P2' THEN 'B1' WHEN '2F' THEN 'B2F' WHEN 'HK' THEN 'VVI' ELSE Plant END) AS Plant ,Year,M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12 FROM dbo.DistribitionReport_Amount_Fiscal WHERE Type='RMA' AND ReportCode='001' 
		) b
	WHERE a.ReportCode<>b.ReportCode
		AND a.Site<>b.Site
		AND a.Plant<>b.Plant
		AND a.Year<>b.Year

	UPDATE SalesAnalysis_Amount_Fiscal
	SET M1=b.M1*-1.0,M2=b.M2*-1.0,M3=b.M3*-1.0,M4=b.M4*-1.0,M5=b.M5*-1.0,M6=b.M6*-1.0,M7=b.M7*-1.0,M8=b.M8*-1.0,M9=b.M9*-1.0,M10=b.M10*-1.0,M11=b.M11*-1.0,M12=b.M12*-1.0
	FROM SalesAnalysis_Amount_Fiscal a,
		(
			SELECT '105' AS ReportCode,Site,(CASE Plant WHEN '' THEN 'ZhuHai' WHEN 'P2' THEN 'B1' WHEN '2F' THEN 'B2F' WHEN 'HK' THEN 'VVI' ELSE Plant END) AS Plant ,Year,M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12 FROM dbo.DistribitionReport_Amount_Fiscal WHERE Type='RMA' AND ReportCode='001' 
		) b
	WHERE a.ReportCode=b.ReportCode
		AND a.Site=b.Site
		AND a.Plant=b.Plant
		AND a.Year=b.Year
	--SCRAP
	INSERT INTO SalesAnalysis_Amount_Fiscal
	SELECT b.*
	FROM SalesAnalysis_Amount_Fiscal a,
		(
			SELECT '108' AS ReportCode,Site,(CASE Plant WHEN '' THEN 'ZhuHai' WHEN 'P2' THEN 'B1' WHEN '2F' THEN 'B2F' WHEN 'HK' THEN 'VVI' ELSE Plant END) AS Plant ,Year,M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12 FROM dbo.DistribitionReport_Amount_Fiscal WHERE Type='SCRAP' AND ReportCode='555' 
		) b
	WHERE a.ReportCode<>b.ReportCode
		AND a.Site<>b.Site
		AND a.Plant<>b.Plant
		AND a.Year<>b.Year

	UPDATE SalesAnalysis_Amount_Fiscal
	SET M1=b.M1,M2=b.M2,M3=b.M3,M4=b.M4,M5=b.M5,M6=b.M6,M7=b.M7,M8=b.M8,M9=b.M9,M10=b.M10,M11=b.M11,M12=b.M12
	FROM SalesAnalysis_Amount_Fiscal a,
		(
			SELECT '108' AS ReportCode,Site,(CASE Plant WHEN '' THEN 'ZhuHai' WHEN 'P2' THEN 'B1' WHEN '2F' THEN 'B2F' WHEN 'HK' THEN 'VVI' ELSE Plant END) AS Plant ,Year,M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12 FROM dbo.DistribitionReport_Amount_Fiscal WHERE Type='SCRAP' AND ReportCode='555' 
		) b
	WHERE a.ReportCode=b.ReportCode
		AND a.Site=b.Site
		AND a.Plant=b.Plant
		AND a.Year=b.Year
	--Cancellation
	INSERT INTO SalesAnalysis_Amount_Fiscal
	SELECT b.*
	FROM SalesAnalysis_Amount_Fiscal a,
		(
			SELECT '107' AS ReportCode,Site,(CASE Plant WHEN '' THEN 'ZhuHai' WHEN 'P2' THEN 'B1' WHEN '2F' THEN 'B2F' WHEN 'HK' THEN 'VVI' ELSE Plant END) AS Plant ,Year,M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12 FROM dbo.DistribitionReport_Amount_Fiscal WHERE Type='CANCELLATION' AND ReportCode='666' 
		) b
	WHERE a.ReportCode<>b.ReportCode
		AND a.Site<>b.Site
		AND a.Plant<>b.Plant
		AND a.Year<>b.Year

	UPDATE SalesAnalysis_Amount_Fiscal
	SET M1=b.M1,M2=b.M2,M3=b.M3,M4=b.M4,M5=b.M5,M6=b.M6,M7=b.M7,M8=b.M8,M9=b.M9,M10=b.M10,M11=b.M11,M12=b.M12
	FROM SalesAnalysis_Amount_Fiscal a,
		(
			SELECT '107' AS ReportCode,Site,(CASE Plant WHEN '' THEN 'ZhuHai' WHEN 'P2' THEN 'B1' WHEN '2F' THEN 'B2F' WHEN 'HK' THEN 'VVI' ELSE Plant END) AS Plant ,Year,M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12 FROM dbo.DistribitionReport_Amount_Fiscal WHERE Type='CANCELLATION' AND ReportCode='666' 
		) b
	WHERE a.ReportCode=b.ReportCode
		AND a.Site=b.Site
		AND a.Plant=b.Plant
		AND a.Year=b.Year

	--Quarter
	--RMA
	INSERT INTO SalesAnalysis_Amount_Fiscal
	SELECT b.*
	FROM SalesAnalysis_Amount_Fiscal a,
		(
			SELECT '205' AS ReportCode,Site,(CASE Plant WHEN '' THEN 'ZhuHai' WHEN 'P2' THEN 'B1' WHEN '2F' THEN 'B2F' WHEN 'HK' THEN 'VVI' ELSE Plant END) AS Plant ,Year,M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12 FROM dbo.DistribitionReport_Amount_Fiscal WHERE Type='RMA' AND ReportCode='002' 
		) b
	WHERE a.ReportCode<>b.ReportCode
		AND a.Site<>b.Site
		AND a.Plant<>b.Plant
		AND a.Year<>b.Year

	UPDATE SalesAnalysis_Amount_Fiscal
	SET M1=b.M1*-1.0,M2=b.M2*-1.0,M3=b.M3*-1.0,M4=b.M4*-1.0,M5=b.M5*-1.0,M6=b.M6*-1.0,M7=b.M7*-1.0,M8=b.M8*-1.0,M9=b.M9*-1.0,M10=b.M10*-1.0,M11=b.M11*-1.0,M12=b.M12*-1.0
	FROM SalesAnalysis_Amount_Fiscal a,
		(
			SELECT '205' AS ReportCode,Site,(CASE Plant WHEN '' THEN 'ZhuHai' WHEN 'P2' THEN 'B1' WHEN '2F' THEN 'B2F' WHEN 'HK' THEN 'VVI' ELSE Plant END) AS Plant ,Year,M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12 FROM dbo.DistribitionReport_Amount_Fiscal WHERE Type='RMA' AND ReportCode='002' 
		) b
	WHERE a.ReportCode=b.ReportCode
		AND a.Site=b.Site
		AND a.Plant=b.Plant
		AND a.Year=b.Year
	--SCRAP
	INSERT INTO SalesAnalysis_Amount_Fiscal
	SELECT b.*
	FROM SalesAnalysis_Amount_Fiscal a,
		(
			SELECT '208' AS ReportCode,Site,(CASE Plant WHEN '' THEN 'ZhuHai' WHEN 'P2' THEN 'B1' WHEN '2F' THEN 'B2F' WHEN 'HK' THEN 'VVI' ELSE Plant END) AS Plant ,Year,M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12 FROM dbo.DistribitionReport_Amount_Fiscal WHERE Type='SCRAP' AND ReportCode='554' 
		) b
	WHERE a.ReportCode<>b.ReportCode
		AND a.Site<>b.Site
		AND a.Plant<>b.Plant
		AND a.Year<>b.Year

	UPDATE SalesAnalysis_Amount_Fiscal
	SET M1=b.M1,M2=b.M2,M3=b.M3,M4=b.M4,M5=b.M5,M6=b.M6,M7=b.M7,M8=b.M8,M9=b.M9,M10=b.M10,M11=b.M11,M12=b.M12
	FROM SalesAnalysis_Amount_Fiscal a,
		(
			SELECT '208' AS ReportCode,Site,(CASE Plant WHEN '' THEN 'ZhuHai' WHEN 'P2' THEN 'B1' WHEN '2F' THEN 'B2F' WHEN 'HK' THEN 'VVI' ELSE Plant END) AS Plant ,Year,M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12 FROM dbo.DistribitionReport_Amount_Fiscal WHERE Type='SCRAP' AND ReportCode='554' 
		) b
	WHERE a.ReportCode=b.ReportCode
		AND a.Site=b.Site
		AND a.Plant=b.Plant
		AND a.Year=b.Year
	--CANCELLATION
	INSERT INTO SalesAnalysis_Amount_Fiscal
	SELECT b.*
	FROM SalesAnalysis_Amount_Fiscal a,
		(
			SELECT '207' AS ReportCode,Site,(CASE Plant WHEN '' THEN 'ZhuHai' WHEN 'P2' THEN 'B1' WHEN '2F' THEN 'B2F' WHEN 'HK' THEN 'VVI' ELSE Plant END) AS Plant ,Year,M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12 FROM dbo.DistribitionReport_Amount_Fiscal WHERE Type='CANCELLATION' AND ReportCode='665' 
		) b
	WHERE a.ReportCode<>b.ReportCode
		AND a.Site<>b.Site
		AND a.Plant<>b.Plant
		AND a.Year<>b.Year

	UPDATE SalesAnalysis_Amount_Fiscal
	SET M1=b.M1,M2=b.M2,M3=b.M3,M4=b.M4,M5=b.M5,M6=b.M6,M7=b.M7,M8=b.M8,M9=b.M9,M10=b.M10,M11=b.M11,M12=b.M12
	FROM SalesAnalysis_Amount_Fiscal a,
		(
			SELECT '207' AS ReportCode,Site,(CASE Plant WHEN '' THEN 'ZhuHai' WHEN 'P2' THEN 'B1' WHEN '2F' THEN 'B2F' WHEN 'HK' THEN 'VVI' ELSE Plant END) AS Plant ,Year,M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12 FROM dbo.DistribitionReport_Amount_Fiscal WHERE Type='CANCELLATION' AND ReportCode='665' 
		) b
	WHERE a.ReportCode=b.ReportCode
		AND a.Site=b.Site
		AND a.Plant=b.Plant
		AND a.Year=b.Year

	--other sales 
	--period
	UPDATE SalesAnalysis_Amount_Fiscal
	SET M1=b.M1,M2=b.M2,M3=b.M3,M4=b.M4,M5=b.M5,M6=b.M6,M7=b.M7,M8=b.M8,M9=b.M9,M10=b.M10,M11=b.M11,M12=b.M12
	FROM SalesAnalysis_Amount_Fiscal a,
			(
				--SELECT '106' AS ReportCode,Site,(CASE Plant WHEN '' THEN 'ZhuHai' WHEN 'P2' THEN 'B1' WHEN '2F' THEN 'B2F' WHEN 'HK' THEN 'VVI' ELSE Plant END) AS Plant ,Year,M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12 FROM dbo.DistribitionReport_Amount_Fiscal WHERE Type='Outbound' AND ReportCode='001' 
				SELECT '106' AS ReportCode,Site,(CASE Plant WHEN '' THEN 'ZhuHai' WHEN 'P2' THEN 'B1' WHEN '2F' THEN 'B2F' WHEN 'HK' THEN 'VVI' ELSE Plant END) AS Plant ,Year,M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12 FROM dbo.ShipmentReport_Shipped_All_Fixed_Fiscal WHERE ReportCode BETWEEN '002' AND '003' AND Site='Chi' 
			) b
	WHERE a.ReportCode=b.ReportCode
		AND a.Site=b.Site
		AND a.Plant=b.Plant
		AND a.Year=b.Year
		AND a.ReportCode='106'
	--GL
	UPDATE SalesAnalysis_Amount_Fiscal
	SET M1=b.M1,M2=b.M2,M3=b.M3,M4=b.M4,M5=b.M5,M6=b.M6,M7=b.M7,M8=b.M8,M9=b.M9,M10=b.M10,M11=b.M11,M12=b.M12
	FROM SalesAnalysis_Amount_Fiscal a,
			(
				--SELECT '106' AS ReportCode,Site,(CASE Plant WHEN '' THEN 'ZhuHai' WHEN 'P2' THEN 'B1' WHEN '2F' THEN 'B2F' WHEN 'HK' THEN 'VVI' ELSE Plant END) AS Plant ,Year,M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12 FROM dbo.DistribitionReport_Amount_Fiscal WHERE Type='Outbound' AND ReportCode='001' 
				SELECT Year,SUM(M1) AS M1,SUM(M2) AS M2,SUM(M3) AS M3,SUM(M4) AS M4,SUM(M5) AS M5,SUM(M6) AS M6,SUM(M7) AS M7,SUM(M8) AS M8,SUM(M9)AS M9,SUM(M10) AS M10,SUM(M11) AS M11,SUM(M12) AS M12 FROM dbo.ShipmentReport_Shipped_All_Fixed_Fiscal WHERE (ReportCode ='002' OR ReportCode='999') AND Site='Chi' GROUP BY Year
			) b
	WHERE a.Year=b.Year
		AND a.ReportCode='106'
		AND a.Plant='ZhuHai'		
		
	UPDATE SalesAnalysis_Amount_Fiscal
	SET M1=a.M1-b.M1,M2=a.M2-b.M2,M3=a.M3-b.M3,M4=a.M4-b.M4,M5=a.M5-b.M5,M6=a.M6-b.M6,M7=a.M7-b.M7,M8=a.M8-b.M8,M9=a.M9-b.M9,M10=a.M10-b.M10,M11=a.M11-b.M11,M12=a.M12-b.M12
	FROM SalesAnalysis_Amount_Fiscal a,
			(
				SELECT Site,Plant,Year,SUM(M1) AS M1,SUM(M2) AS M2,SUM(M3) AS M3,SUM(M4) AS M4,SUM(M5) AS M5,SUM(M6) AS M6,SUM(M7) AS M7,SUM(M8) AS M8,SUM(M9) AS M9,SUM(M10) AS M10,SUM(M11) AS M11,SUM(M12) AS M12
				FROM SalesAnalysis_Amount_Fiscal 
				WHERE ReportCode BETWEEN '101' AND '108' 
					  AND ReportCode<>'106'
				GROUP BY Site,Plant,Year
			) b
	WHERE a.Site=b.Site
		AND a.Plant=b.Plant
		AND a.Year=b.Year
		AND a.ReportCode='106'
	--quarter
	UPDATE SalesAnalysis_Amount_Fiscal
	SET M1=b.M1,M2=b.M2,M3=b.M3,M4=b.M4,M5=b.M5,M6=b.M6,M7=b.M7,M8=b.M8,M9=b.M9,M10=b.M10,M11=b.M11,M12=b.M12
	FROM SalesAnalysis_Amount_Fiscal a,
			(
				--SELECT '206' AS ReportCode,Site,(CASE Plant WHEN '' THEN 'ZhuHai' WHEN 'P2' THEN 'B1' WHEN '2F' THEN 'B2F' WHEN 'HK' THEN 'VVI' ELSE Plant END) AS Plant ,Year,M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12 FROM dbo.DistribitionReport_Amount_Fiscal WHERE Type='Outbound' AND ReportCode='002' 
				SELECT '206' AS ReportCode,Site,(CASE Plant WHEN '' THEN 'ZhuHai' WHEN 'P2' THEN 'B1' WHEN '2F' THEN 'B2F' WHEN 'HK' THEN 'VVI' ELSE Plant END) AS Plant ,Year,M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12 FROM dbo.ShipmentReport_Shipped_All_Fixed_Fiscal WHERE ReportCode BETWEEN '004' AND '005' AND Site='Chi' 
			) b
	WHERE a.ReportCode=b.ReportCode
		AND a.Site=b.Site
		AND a.Plant=b.Plant
		AND a.Year=b.Year
		AND a.ReportCode='206'
	--GL
	UPDATE SalesAnalysis_Amount_Fiscal
	SET M1=b.M1,M2=b.M2,M3=b.M3,M4=b.M4,M5=b.M5,M6=b.M6,M7=b.M7,M8=b.M8,M9=b.M9,M10=b.M10,M11=b.M11,M12=b.M12
	FROM SalesAnalysis_Amount_Fiscal a,
			(
				--SELECT '106' AS ReportCode,Site,(CASE Plant WHEN '' THEN 'ZhuHai' WHEN 'P2' THEN 'B1' WHEN '2F' THEN 'B2F' WHEN 'HK' THEN 'VVI' ELSE Plant END) AS Plant ,Year,M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12 FROM dbo.DistribitionReport_Amount_Fiscal WHERE Type='Outbound' AND ReportCode='001' 
				SELECT Year,SUM(M1) AS M1,SUM(M2) AS M2,SUM(M3) AS M3,SUM(M4) AS M4,SUM(M5) AS M5,SUM(M6) AS M6,SUM(M7) AS M7,SUM(M8) AS M8,SUM(M9)AS M9,SUM(M10) AS M10,SUM(M11) AS M11,SUM(M12) AS M12 FROM dbo.ShipmentReport_Shipped_All_Fixed_Fiscal WHERE (ReportCode ='004' OR ReportCode='998') AND Site='Chi' GROUP BY Year
			) b
	WHERE a.Year=b.Year
		AND a.ReportCode='206'
		AND a.Plant='ZhuHai'			
		
	UPDATE SalesAnalysis_Amount_Fiscal
	SET M1=a.M1-b.M1,M2=a.M2-b.M2,M3=a.M3-b.M3,M4=a.M4-b.M4,M5=a.M5-b.M5,M6=a.M6-b.M6,M7=a.M7-b.M7,M8=a.M8-b.M8,M9=a.M9-b.M9,M10=a.M10-b.M10,M11=a.M11-b.M11,M12=a.M12-b.M12
	FROM SalesAnalysis_Amount_Fiscal a,
			(
				SELECT Site,Plant,Year,SUM(M1) AS M1,SUM(M2) AS M2,SUM(M3) AS M3,SUM(M4) AS M4,SUM(M5) AS M5,SUM(M6) AS M6,SUM(M7) AS M7,SUM(M8) AS M8,SUM(M9) AS M9,SUM(M10) AS M10,SUM(M11) AS M11,SUM(M12) AS M12
				FROM SalesAnalysis_Amount_Fiscal 
				WHERE ReportCode BETWEEN '201' AND '208' 
					  AND ReportCode<>'206'
				GROUP BY Site,Plant,Year
			) b
	WHERE a.Site=b.Site
		AND a.Plant=b.Plant
		AND a.Year=b.Year
		AND a.ReportCode='206'
	
	--PROCESS VVI RMA
	UPDATE SalesAnalysis_Amount_Fiscal
	SET M1=a.M1-b.M1,M2=a.M2-b.M2,M3=a.M3-b.M3,M4=a.M4-b.M4,M5=a.M5-b.M5,M6=a.M6-b.M6,M7=a.M7-b.M7,M8=a.M8-b.M8,M9=a.M9-b.M9,M10=a.M10-b.M10,M11=a.M11-b.M11,M12=a.M12-b.M12
	FROM SalesAnalysis_Amount_Fiscal a,
		(
			select * from SalesAnalysis_Amount_Fiscal where ReportCode='105' AND Plant='VVI'
		) b
	WHERE a.ReportCode='105' 
		AND a.Plant='ZhuHai'
		AND a.Year=b.Year		
	UPDATE SalesAnalysis_Amount_Fiscal
	SET M1=a.M1-b.M1,M2=a.M2-b.M2,M3=a.M3-b.M3,M4=a.M4-b.M4,M5=a.M5-b.M5,M6=a.M6-b.M6,M7=a.M7-b.M7,M8=a.M8-b.M8,M9=a.M9-b.M9,M10=a.M10-b.M10,M11=a.M11-b.M11,M12=a.M12-b.M12
	FROM SalesAnalysis_Amount_Fiscal a,
		(
			select * from SalesAnalysis_Amount_Fiscal where ReportCode='205' AND Plant='VVI'
		) b
	WHERE a.ReportCode='205' 
		AND a.Plant='ZhuHai'
		AND a.Year=b.Year

	UPDATE SalesAnalysis_Amount_Fiscal
	SET M1=a.M1+b.M1,M2=a.M2+b.M2,M3=a.M3+b.M3,M4=a.M4+b.M4,M5=a.M5+b.M5,M6=a.M6+b.M6,M7=a.M7+b.M7,M8=a.M8+b.M8,M9=a.M9+b.M9,M10=a.M10+b.M10,M11=a.M11+b.M11,M12=a.M12+b.M12
	FROM SalesAnalysis_Amount_Fiscal a,
		(
			select * from SalesAnalysis_Amount_Fiscal where ReportCode='105' AND Plant='VVI'
		) b
	WHERE a.ReportCode='102' 
		AND a.Plant='ZhuHai'
		AND a.Year=b.Year
	UPDATE SalesAnalysis_Amount_Fiscal
	SET M1=a.M1+b.M1,M2=a.M2+b.M2,M3=a.M3+b.M3,M4=a.M4+b.M4,M5=a.M5+b.M5,M6=a.M6+b.M6,M7=a.M7+b.M7,M8=a.M8+b.M8,M9=a.M9+b.M9,M10=a.M10+b.M10,M11=a.M11+b.M11,M12=a.M12+b.M12
	FROM SalesAnalysis_Amount_Fiscal a,
		(
			select * from SalesAnalysis_Amount_Fiscal where ReportCode='205' AND Plant='VVI'
		) b
	WHERE a.ReportCode='202' 
		AND a.Plant='ZhuHai'
		AND a.Year=b.Year

END
GO
