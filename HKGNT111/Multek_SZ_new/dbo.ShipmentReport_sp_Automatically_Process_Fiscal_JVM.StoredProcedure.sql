USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[ShipmentReport_sp_Automatically_Process_Fiscal_JVM]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ShipmentReport_sp_Automatically_Process_Fiscal_JVM]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	--DELETE ShipmentReport_Shipped_All_Fixed_Fiscal WHERE ReportCode='999'
	INSERT INTO ShipmentReport_Shipped_All_Fixed_Fiscal
	SELECT *
	FROM (
				SELECT '999' AS ReportCode,
					'Chi' AS Site,
					'HK' AS Plant,
					ShipmentYears AS Year,
					0 AS Period1,0 AS Period2,0 AS Period3,0 AS Period4,0 AS Period5,0 AS Period6,0 AS Period7,0 AS Period8,0 AS Period9,0 AS Period10,0 AS Period11,0 AS Period12
				FROM ShipmentReport_Fiscal_Year
				UNION
				SELECT '999' AS ReportCode,
					'Chi' AS Site,
					'B1' AS Plant,
					ShipmentYears AS Year,
					0 AS Period1,0 AS Period2,0 AS Period3,0 AS Period4,0 AS Period5,0 AS Period6,0 AS Period7,0 AS Period8,0 AS Period9,0 AS Period10,0 AS Period11,0 AS Period12
				FROM ShipmentReport_Fiscal_Year
				UNION
				SELECT '999' AS ReportCode,
					'Chi' AS Site,
					'B2F' AS Plant,
					ShipmentYears AS Year,
					0 AS Period1,0 AS Period2,0 AS Period3,0 AS Period4,0 AS Period5,0 AS Period6,0 AS Period7,0 AS Period8,0 AS Period9,0 AS Period10,0 AS Period11,0 AS Period12
				FROM ShipmentReport_Fiscal_Year
				UNION
				SELECT '999' AS ReportCode,
					'Chi' AS Site,
					'B3' AS Plant,
					ShipmentYears AS Year,
					0 AS Period1,0 AS Period2,0 AS Period3,0 AS Period4,0 AS Period5,0 AS Period6,0 AS Period7,0 AS Period8,0 AS Period9,0 AS Period10,0 AS Period11,0 AS Period12
				FROM ShipmentReport_Fiscal_Year
				UNION
				SELECT '999' AS ReportCode,
					'Chi' AS Site,
					'B4' AS Plant,
					ShipmentYears AS Year,
					0 AS Period1,0 AS Period2,0 AS Period3,0 AS Period4,0 AS Period5,0 AS Period6,0 AS Period7,0 AS Period8,0 AS Period9,0 AS Period10,0 AS Period11,0 AS Period12
				FROM ShipmentReport_Fiscal_Year
				UNION
				SELECT '999' AS ReportCode,
					'Chi' AS Site,
					'B5' AS Plant,
					ShipmentYears AS Year,
					0 AS Period1,0 AS Period2,0 AS Period3,0 AS Period4,0 AS Period5,0 AS Period6,0 AS Period7,0 AS Period8,0 AS Period9,0 AS Period10,0 AS Period11,0 AS Period12
				FROM ShipmentReport_Fiscal_Year
		) a
	WHERE NOT EXISTS(SELECT * FROM ShipmentReport_Shipped_All_Fixed_Fiscal b WHERE b.ReportCode+b.Site+b.Plant+b.Year=a.ReportCode+a.Site+a.Plant+a.Year)
	
	--DELETE ShipmentReport_Shipped_All_Fixed_Fiscal WHERE ReportCode='998'
	INSERT INTO ShipmentReport_Shipped_All_Fixed_Fiscal
	SELECT * 
	FROM (
			SELECT '998' AS ReportCode,
				'Chi' AS Site,
				'HK' AS Plant,
				ShipmentYears AS Year,
				0 AS Period1,
				0 AS Period2,
				0 AS Period3,
				0 AS Period4,
				0 AS Period5,0 AS Period6,0 AS Period7,0 AS Period8,0 AS Period9,0 AS Period10,0 AS Period11,0 AS Period12
			FROM ShipmentReport_Fiscal_Year
			UNION
			SELECT '998' AS ReportCode,
				'Chi' AS Site,
				'B1' AS Plant,
				ShipmentYears AS Year,
				0 AS Period1,
				0 AS Period2,
				0 AS Period3,
				0 AS Period4,
				0 AS Period5,0 AS Period6,0 AS Period7,0 AS Period8,0 AS Period9,0 AS Period10,0 AS Period11,0 AS Period12
			FROM ShipmentReport_Fiscal_Year
			UNION
			SELECT '998' AS ReportCode,
				'Chi' AS Site,
				'B2F' AS Plant,
				ShipmentYears AS Year,
				0 AS Period1,
				0 AS Period2,
				0 AS Period3,
				0 AS Period4,
				0 AS Period5,0 AS Period6,0 AS Period7,0 AS Period8,0 AS Period9,0 AS Period10,0 AS Period11,0 AS Period12
			FROM ShipmentReport_Fiscal_Year
			UNION
			SELECT '998' AS ReportCode,
				'Chi' AS Site,
				'B3' AS Plant,
				ShipmentYears AS Year,
				0 AS Period1,
				0 AS Period2,
				0 AS Period3,
				0 AS Period4,
				0 AS Period5,0 AS Period6,0 AS Period7,0 AS Period8,0 AS Period9,0 AS Period10,0 AS Period11,0 AS Period12
			FROM ShipmentReport_Fiscal_Year
			UNION
			SELECT '998' AS ReportCode,
				'Chi' AS Site,
				'B4' AS Plant,
				ShipmentYears AS Year,
				0 AS Period1,
				0 AS Period2,
				0 AS Period3,
				0 AS Period4,
				0 AS Period5,0 AS Period6,0 AS Period7,0 AS Period8,0 AS Period9,0 AS Period10,0 AS Period11,0 AS Period12
			FROM ShipmentReport_Fiscal_Year
			UNION
			SELECT '998' AS ReportCode,
				'Chi' AS Site,
				'B5' AS Plant,
				ShipmentYears AS Year,
				0 AS Period1,
				0 AS Period2,
				0 AS Period3,
				0 AS Period4,
				0 AS Period5,0 AS Period6,0 AS Period7,0 AS Period8,0 AS Period9,0 AS Period10,0 AS Period11,0 AS Period12
			FROM ShipmentReport_Fiscal_Year
		) a
	WHERE NOT EXISTS(SELECT * FROM ShipmentReport_Shipped_All_Fixed_Fiscal b WHERE b.ReportCode+b.Site+b.Plant+b.Year=a.ReportCode+a.Site+a.Plant+a.Year)

	--DELETE ShipmentReport_Shipped_All_Fixed_Fiscal WHERE ReportCode='997'
	INSERT INTO ShipmentReport_Shipped_All_Fixed_Fiscal
	SELECT *
	FROM (
				SELECT '997' AS ReportCode,
					'Dis' AS Site,
					'' AS Plant,
					ShipmentYears AS Year,
					0 AS Period1,0 AS Period2,0 AS Period3,0 AS Period4,0 AS Period5,0 AS Period6,0 AS Period7,0 AS Period8,0 AS Period9,0 AS Period10,0 AS Period11,0 AS Period12
				FROM ShipmentReport_Fiscal_Year
		) a
	WHERE NOT EXISTS(SELECT * FROM ShipmentReport_Shipped_All_Fixed_Fiscal b WHERE b.ReportCode+b.Site+b.Plant+b.Year=a.ReportCode+a.Site+a.Plant+a.Year)

	--DELETE ShipmentReport_Shipped_All_Fixed_Fiscal WHERE ReportCode='996'
	INSERT INTO ShipmentReport_Shipped_All_Fixed_Fiscal
	SELECT *
	FROM (
			SELECT '996' AS ReportCode,
				'Dis' AS Site,
				'' AS Plant,
				ShipmentYears AS Year,
				0 AS Period1,
				0 AS Period2,
				0 AS Period3,
				0 AS Period4,
				0 AS Period5,0 AS Period6,0 AS Period7,0 AS Period8,0 AS Period9,0 AS Period10,0 AS Period11,0 AS Period12
			FROM ShipmentReport_Fiscal_Year
		) a
	WHERE NOT EXISTS(SELECT * FROM ShipmentReport_Shipped_All_Fixed_Fiscal b WHERE b.ReportCode+b.Site+b.Plant+b.Year=a.ReportCode+a.Site+a.Plant+a.Year)

	--DELETE ShipmentReport_Shipped_All_Fixed_Fiscal WHERE ReportCode='995'
	INSERT INTO ShipmentReport_Shipped_All_Fixed_Fiscal
	SELECT *
	FROM (
			SELECT '995' AS ReportCode,
				'Ger' AS Site,
				'' AS Plant,
				ShipmentYears AS Year,
				0 AS Period1,0 AS Period2,0 AS Period3,0 AS Period4,0 AS Period5,0 AS Period6,0 AS Period7,0 AS Period8,0 AS Period9,0 AS Period10,0 AS Period11,0 AS Period12
			FROM ShipmentReport_Fiscal_Year
		) a
	WHERE NOT EXISTS(SELECT * FROM ShipmentReport_Shipped_All_Fixed_Fiscal b WHERE b.ReportCode+b.Site+b.Plant+b.Year=a.ReportCode+a.Site+a.Plant+a.Year)

	--DELETE ShipmentReport_Shipped_All_Fixed_Fiscal WHERE ReportCode='994'
	INSERT INTO ShipmentReport_Shipped_All_Fixed_Fiscal
	SELECT *
	FROM (
			SELECT '994' AS ReportCode,
				'Ger' AS Site,
				'' AS Plant,
				ShipmentYears AS Year,
				0 AS Period1,0 AS Period2,0 AS Period3,0 AS Period4,0 AS Period5,0 AS Period6,0 AS Period7,0 AS Period8,0 AS Period9,0 AS Period10,0 AS Period11,0 AS Period12
			FROM ShipmentReport_Fiscal_Year
		) a
	WHERE NOT EXISTS(SELECT * FROM ShipmentReport_Shipped_All_Fixed_Fiscal b WHERE b.ReportCode+b.Site+b.Plant+b.Year=a.ReportCode+a.Site+a.Plant+a.Year)

	--DELETE ShipmentReport_Shipped_All_Fixed_Fiscal WHERE ReportCode='993'
	INSERT INTO ShipmentReport_Shipped_All_Fixed_Fiscal
	SELECT *
	FROM (
			SELECT '993' AS ReportCode,
				'Sao' AS Site,
				'' AS Plant,
				ShipmentYears AS Year,
				0 AS Period1,0 AS Period2,0 AS Period3,0 AS Period4,0 AS Period5,0 AS Period6,0 AS Period7,0 AS Period8,0 AS Period9,0 AS Period10,0 AS Period11,0 AS Period12
			FROM ShipmentReport_Fiscal_Year
		) a
	WHERE NOT EXISTS(SELECT * FROM ShipmentReport_Shipped_All_Fixed_Fiscal b WHERE b.ReportCode+b.Site+b.Plant+b.Year=a.ReportCode+a.Site+a.Plant+a.Year)

	--DELETE ShipmentReport_Shipped_All_Fixed_Fiscal WHERE ReportCode='992'
	INSERT INTO ShipmentReport_Shipped_All_Fixed_Fiscal
	SELECT *
	FROM (
			SELECT '992' AS ReportCode,
				'Sao' AS Site,
				'' AS Plant,
				ShipmentYears AS Year,
				0 AS Period1,0 AS Period2,0 AS Period3,0 AS Period4,0 AS Period5,0 AS Period6,0 AS Period7,0 AS Period8,0 AS Period9,0 AS Period10,0 AS Period11,0 AS Period12
			FROM ShipmentReport_Fiscal_Year
		) a
	WHERE NOT EXISTS(SELECT * FROM ShipmentReport_Shipped_All_Fixed_Fiscal b WHERE b.ReportCode+b.Site+b.Plant+b.Year=a.ReportCode+a.Site+a.Plant+a.Year)

	--DELETE ShipmentReport_Shipped_All_Fixed_Fiscal WHERE ReportCode='991'
	INSERT INTO ShipmentReport_Shipped_All_Fixed_Fiscal
	SELECT *
	FROM (
			SELECT '991' AS ReportCode,
				'Nfd' AS Site,
				'' AS Plant,
				ShipmentYears AS Year,
				0 AS Period1,0 AS Period2,0 AS Period3,0 AS Period4,0 AS Period5,0 AS Period6,0 AS Period7,0 AS Period8,0 AS Period9,0 AS Period10,0 AS Period11,0 AS Period12
			FROM ShipmentReport_Fiscal_Year
		) a
	WHERE NOT EXISTS(SELECT * FROM ShipmentReport_Shipped_All_Fixed_Fiscal b WHERE b.ReportCode+b.Site+b.Plant+b.Year=a.ReportCode+a.Site+a.Plant+a.Year)

	--DELETE ShipmentReport_Shipped_All_Fixed_Fiscal WHERE ReportCode='990'
	INSERT INTO ShipmentReport_Shipped_All_Fixed_Fiscal
	SELECT *
	FROM (
			SELECT '990' AS ReportCode,
				'Nfd' AS Site,
				'' AS Plant,
				ShipmentYears AS Year,
				0 AS Period1,0 AS Period2,0 AS Period3,0 AS Period4,0 AS Period5,0 AS Period6,0 AS Period7,0 AS Period8,0 AS Period9,0 AS Period10,0 AS Period11,0 AS Period12
			FROM ShipmentReport_Fiscal_Year
		) a
	WHERE NOT EXISTS(SELECT * FROM ShipmentReport_Shipped_All_Fixed_Fiscal b WHERE b.ReportCode+b.Site+b.Plant+b.Year=a.ReportCode+a.Site+a.Plant+a.Year)

	UPDATE ShipmentReport_Shipped_All_Fixed_Fiscal
	SET M1=0,M2=0,M3=0,M4=0,M5=0,M6=0,M7=0,M8=0,M9=0,M10=0,M11=0,M12=0
	WHERE ReportCode BETWEEN '999' AND '990'

END
GO
