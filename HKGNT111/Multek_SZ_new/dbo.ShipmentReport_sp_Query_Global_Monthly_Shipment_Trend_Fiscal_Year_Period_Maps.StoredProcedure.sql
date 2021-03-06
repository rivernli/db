USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[ShipmentReport_sp_Query_Global_Monthly_Shipment_Trend_Fiscal_Year_Period_Maps]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ShipmentReport_sp_Query_Global_Monthly_Shipment_Trend_Fiscal_Year_Period_Maps] 
	-- Add the parameters for the stored procedure here
	@Year CHAR(4)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    -- Insert statements for procedure here
    -- Insert statements for procedure here
	DECLARE @Site VARCHAR(50),@Plant VARCHAR(50),@AsiaAmount NUMERIC(19,2),@EuropeAmount NUMERIC(19,2),
			@NorthAmericaAmount NUMERIC(19,2),@SouthAmericaAmount NUMERIC(19,2),@ChinaAmount NUMERIC(19,2),
			@DisplayAmount NUMERIC(19,2),@ChinaB5Amount NUMERIC(19,2),@ChinaHKAmount NUMERIC(19,2),
			@China12Amount NUMERIC(19,2),@China2FAmount NUMERIC(19,2),@ChinaB3Amount NUMERIC(19,2),
			@ChinaB4Amount NUMERIC(19,2),@ChinaP2Amount NUMERIC(19,2),@ChinaNAAmount NUMERIC(19,2)

	SET @Site='CHI'
	SET @ChinaAmount=(
						SELECT SUM(a.M1+a.M2+a.M3+a.M4+a.M5+a.M6+a.M7+a.M8+a.M9+a.M10+a.M11+a.M12)
						FROM (
								SELECT M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12
								FROM ShipmentReport_Shipped_All_Fixed_Fiscal
								WHERE ReportCode='002'
									AND Year=@Year
									AND Site=@Site
							 ) a
					)+
					(
						SELECT SUM(M1+M2+M3+M4+M5+M6+M7+M8+M9+M10+M11+M12) FROM ShipmentReport_Shipped_All_Fixed_Fiscal WHERE ReportCode='999' AND Site='Chi' AND Year=@Year
					)
	SET @Site='DIS'
	SET @DisplayAmount=(
							SELECT SUM(a.M1+a.M2+a.M3+a.M4+a.M5+a.M6+a.M7+a.M8+a.M9+a.M10+a.M11+a.M12)
							FROM (
									SELECT M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12
									FROM ShipmentReport_Shipped_All_Fixed_Fiscal
									WHERE ReportCode='002'
										AND Year=@Year
										AND Site=@Site
								 ) a
						)+
						(
							SELECT SUM(M1+M2+M3+M4+M5+M6+M7+M8+M9+M10+M11+M12) FROM ShipmentReport_Shipped_All_Fixed_Fiscal WHERE ReportCode='997' AND Site='Dis' AND Year=@Year
						)
--add by joe 2012-12-03
set @DisplayAmount = 0

	SET @AsiaAmount=@ChinaAmount+@DisplayAmount
	SET @Site='Ger'
	SET @EuropeAmount=(
						SELECT SUM(a.M1+a.M2+a.M3+a.M4+a.M5+a.M6+a.M7+a.M8+a.M9+a.M10+a.M11+a.M12)
						FROM (
								SELECT M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12
								FROM ShipmentReport_Shipped_All_Fixed_Fiscal
								WHERE ReportCode='002'
									AND Year=@Year
									AND Site=@Site
							 ) a
					)+
					(
						SELECT SUM(M1+M2+M3+M4+M5+M6+M7+M8+M9+M10+M11+M12) FROM ShipmentReport_Shipped_All_Fixed_Fiscal WHERE ReportCode='995' AND Site='Ger' AND Year=@Year
					)
	SET @Site='Nfd'
	SET @NorthAmericaAmount=(
						SELECT SUM(a.M1+a.M2+a.M3+a.M4+a.M5+a.M6+a.M7+a.M8+a.M9+a.M10+a.M11+a.M12)
						FROM (
								SELECT M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12
								FROM ShipmentReport_Shipped_All_Fixed_Fiscal
								WHERE ReportCode='002'
									AND Year=@Year
									AND Site=@Site
							 ) a
					)
	SET @Site='Sao'
	SET @SouthAmericaAmount=(
						SELECT SUM(a.M1+a.M2+a.M3+a.M4+a.M5+a.M6+a.M7+a.M8+a.M9+a.M10+a.M11+a.M12)
						FROM (
								SELECT M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12
								FROM ShipmentReport_Shipped_All_Fixed_Fiscal
								WHERE ReportCode='002'
									AND Year=@Year
									AND Site=@Site
							 ) a
					)+
					(
						SELECT SUM(M1+M2+M3+M4+M5+M6+M7+M8+M9+M10+M11+M12) FROM ShipmentReport_Shipped_All_Fixed_Fiscal WHERE ReportCode='993' AND Site='Sao' AND Year=@Year
					)
	SET @Site='CHI'
	SET @Plant='Tooling'
	SET @ChinaNAAmount=(
						SELECT SUM(a.M1+a.M2+a.M3+a.M4+a.M5+a.M6+a.M7+a.M8+a.M9+a.M10+a.M11+a.M12)
						FROM (
								SELECT M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12
								FROM ShipmentReport_Shipped_All_Fixed_Fiscal
								WHERE ReportCode='003'
									AND Year=@Year
									AND Site=@Site
									AND Plant=@Plant
							 ) a
					)

	SET @Site='CHI'
	SET @Plant='B5'
	SET @ChinaB5Amount=(
						SELECT SUM(a.M1+a.M2+a.M3+a.M4+a.M5+a.M6+a.M7+a.M8+a.M9+a.M10+a.M11+a.M12)
						FROM (
								SELECT M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12
								FROM ShipmentReport_Shipped_All_Fixed_Fiscal
								WHERE ReportCode='003'
									AND Year=@Year
									AND Site=@Site
									AND Plant=@Plant
							 ) a
					)
	SET @Site='CHI'
	SET @Plant='HK'
	SET @ChinaHKAmount=(
						SELECT SUM(a.M1+a.M2+a.M3+a.M4+a.M5+a.M6+a.M7+a.M8+a.M9+a.M10+a.M11+a.M12)
						FROM (
								SELECT M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12
								FROM ShipmentReport_Shipped_All_Fixed_Fiscal
								WHERE ReportCode='003'
									AND Year=@Year
									AND Site=@Site
									AND Plant=@Plant
							 ) a
					)
	SET @Site='CHI'
	SET @Plant='12'
	SET @China12Amount=(
						SELECT SUM(a.M1+a.M2+a.M3+a.M4+a.M5+a.M6+a.M7+a.M8+a.M9+a.M10+a.M11+a.M12)
						FROM (
								SELECT M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12
								FROM ShipmentReport_Shipped_All_Fixed_Fiscal
								WHERE ReportCode='003'
									AND Year=@Year
									AND Site=@Site
									AND Plant=@Plant
							 ) a
					)
	SET @Site='CHI'
	SET @Plant='2F'
	SET @China2FAmount=(
						SELECT SUM(a.M1+a.M2+a.M3+a.M4+a.M5+a.M6+a.M7+a.M8+a.M9+a.M10+a.M11+a.M12)
						FROM (
								SELECT M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12
								FROM ShipmentReport_Shipped_All_Fixed_Fiscal
								WHERE ReportCode='003'
									AND Year=@Year
									AND Site=@Site
									AND Plant=@Plant
							 ) a
					)
	SET @Site='CHI'
	SET @Plant='B3'
	SET @ChinaB3Amount=(
						SELECT SUM(a.M1+a.M2+a.M3+a.M4+a.M5+a.M6+a.M7+a.M8+a.M9+a.M10+a.M11+a.M12)
						FROM (
								SELECT M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12
								FROM ShipmentReport_Shipped_All_Fixed_Fiscal
								WHERE ReportCode='003'
									AND Year=@Year
									AND Site=@Site
									AND Plant=@Plant
							 ) a
					)
	SET @Site='CHI'
	SET @Plant='B4'
	SET @ChinaB4Amount=(
						SELECT SUM(a.M1+a.M2+a.M3+a.M4+a.M5+a.M6+a.M7+a.M8+a.M9+a.M10+a.M11+a.M12)
						FROM (
								SELECT M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12
								FROM ShipmentReport_Shipped_All_Fixed_Fiscal
								WHERE ReportCode='003'
									AND Year=@Year
									AND Site=@Site
									AND Plant=@Plant
							 ) a
					)
	SET @Site='CHI'
	SET @Plant='P2'
	SET @ChinaP2Amount=(
						SELECT SUM(a.M1+a.M2+a.M3+a.M4+a.M5+a.M6+a.M7+a.M8+a.M9+a.M10+a.M11+a.M12)
						FROM (
								SELECT M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12
								FROM ShipmentReport_Shipped_All_Fixed_Fiscal
								WHERE ReportCode='003'
									AND Year=@Year
									AND Site=@Site
									AND Plant=@Plant
							 ) a
					)

	SELECT  ISNULL(@AsiaAmount,0) AS AsiaAmount,
			ISNULL(@EuropeAmount,0) AS EuropeAmount,
			ISNULL(@NorthAmericaAmount,0) AS NorthAmericaAmount,
			ISNULL(@SouthAmericaAmount,0) AS SouthAmericaAmount,
			ISNULL(@ChinaAmount,0) AS ChinaAmount,
			ISNULL(@DisplayAmount,0) AS DisplayAmount,
			ISNULL(@ChinaB5Amount,0)AS ChinaB5Amount,
			ISNULL(@ChinaHKAmount,0) AS ChinaHKAmount,
			ISNULL(@China12Amount,0) AS China12Amount,
			ISNULL(@China2FAmount,0) AS China2FAmount,
			ISNULL(@ChinaB3Amount,0) AS ChinaB3Amount,
			ISNULL(@ChinaB4Amount,0) AS ChinaB4Amount,
			ISNULL(@ChinaP2Amount,0) AS ChinaP2Amount,
			ISNULL(@ChinaNAAmount,0) AS ChinaNAAmount

	SELECT 'Germany' AS Site,SUM(M1) AS M1,SUM(M2) AS M2,SUM(M3) AS M3,SUM(M4) AS M4,SUM(M5) AS M5,SUM(M6) AS M6,SUM(M7) AS M7,SUM(M8) AS M8,SUM(M9) AS M9,SUM(M10) AS M10,SUM(M11) AS M11,SUM(M12) AS M12
	FROM (
			SELECT M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12
			FROM ShipmentReport_Shipped_All_Fixed_Fiscal
			WHERE ReportCode='002'
				AND Year=@Year
				AND Site='Ger'
			UNION
			SELECT SUM(M1) AS M1,SUM(M2) AS M2,SUM(M3) AS M3,SUM(M4) AS M4,SUM(M5) AS M5,SUM(M6) AS M6,SUM(M7) AS M7,SUM(M8) AS M8,SUM(M9) AS M9,SUM(M10) AS M10,SUM(M11) AS M11,SUM(M12) AS M12
			FROM ShipmentReport_Shipped_All_Fixed_Fiscal 
			WHERE ReportCode='995'
				 AND Site='Ger' 
				 AND Year=@Year
		) a
	UNION
	SELECT 'Brazil' AS Site,SUM(M1) AS M1,SUM(M2) AS M2,SUM(M3) AS M3,SUM(M4) AS M4,SUM(M5) AS M5,SUM(M6) AS M6,SUM(M7) AS M7,SUM(M8) AS M8,SUM(M9) AS M9,SUM(M10) AS M10,SUM(M11) AS M11,SUM(M12) AS M12
	FROM (
			SELECT M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12
			FROM ShipmentReport_Shipped_All_Fixed_Fiscal
			WHERE ReportCode='002'
				AND Year=@Year
				AND Site='Sao'
			UNION
			SELECT SUM(M1) AS M1,SUM(M2) AS M2,SUM(M3) AS M3,SUM(M4) AS M4,SUM(M5) AS M5,SUM(M6) AS M6,SUM(M7) AS M7,SUM(M8) AS M8,SUM(M9) AS M9,SUM(M10) AS M10,SUM(M11) AS M11,SUM(M12) AS M12
			FROM ShipmentReport_Shipped_All_Fixed_Fiscal 
			WHERE ReportCode='993'
				 AND Site='Sao' 
				 AND Year=@Year
		) a
	UNION
	SELECT 'NorthField' AS Site,M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12
	FROM ShipmentReport_Shipped_All_Fixed_Fiscal
	WHERE ReportCode='002'
		AND Year=@Year
		AND Site='Nfd'
	UNION
	SELECT 'China' AS Site,SUM(M1) AS M1,SUM(M2) AS M2,SUM(M3) AS M3,SUM(M4) AS M4,SUM(M5) AS M5,SUM(M6) AS M6,SUM(M7) AS M7,SUM(M8) AS M8,SUM(M9) AS M9,SUM(M10) AS M10,SUM(M11) AS M11,SUM(M12) AS M12
	FROM (
			SELECT M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12
			FROM ShipmentReport_Shipped_All_Fixed_Fiscal
			WHERE ReportCode='002'
				AND Year=@Year
				and (Site = 'chi')
				--AND (Site='Chi' OR Site='Dis') /*by joe 2012-12-03*/
			UNION
			SELECT SUM(M1) AS M1,SUM(M2) AS M2,SUM(M3) AS M3,SUM(M4) AS M4,SUM(M5) AS M5,SUM(M6) AS M6,SUM(M7) AS M7,SUM(M8) AS M8,SUM(M9) AS M9,SUM(M10) AS M10,SUM(M11) AS M11,SUM(M12) AS M12
			FROM ShipmentReport_Shipped_All_Fixed_Fiscal 
			WHERE ReportCode='999'
				 AND Site='Chi' 
				 AND Year=@Year
			/*by joe 2012-12-03	 
			UNION
			SELECT SUM(M1) AS M1,SUM(M2) AS M2,SUM(M3) AS M3,SUM(M4) AS M4,SUM(M5) AS M5,SUM(M6) AS M6,SUM(M7) AS M7,SUM(M8) AS M8,SUM(M9) AS M9,SUM(M10) AS M10,SUM(M11) AS M11,SUM(M12) AS M12
			FROM ShipmentReport_Shipped_All_Fixed_Fiscal 
			WHERE ReportCode='997'
				 AND Site='Dis' 
				 AND Year=@Year
			*/	 
		) a
	
	SELECT 'Zhuhai Scrap Sales' AS Plant,M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12
	FROM DistribitionReport_Amount_Fiscal
	WHERE ReportCode='555'
		AND Type='Scrap'
		AND Year=@Year
		AND Site='Chi'
		AND Plant=''
	UNION
	SELECT 'Zhuhai Misc Adjustment' AS Plant,SUM(M1) AS M1,SUM(M2) AS M2,SUM(M3) AS M3,SUM(M4) AS M4,SUM(M5) AS M5,SUM(M6) AS M6,SUM(M7) AS M7,SUM(M8) AS M8,SUM(M9) AS M9,SUM(M10) AS M10,SUM(M11) AS M11,SUM(M12) AS M12
	FROM (
			SELECT 'Tooling' AS Plant,M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12
			FROM ShipmentReport_Shipped_All_Fixed_Fiscal
			WHERE ReportCode='003'
				AND Year=@Year
				AND Site='Chi'
				AND Plant='Tooling'
			UNION 
			SELECT 'JVM' AS Plant,SUM(M1) AS M1,SUM(M2) AS M2,SUM(M3) AS M3,SUM(M4) AS M4,SUM(M5) AS M5,SUM(M6) AS M6,SUM(M7) AS M7,SUM(M8) AS M8,SUM(M9) AS M9,SUM(M10) AS M10,SUM(M11) AS M11,SUM(M12) AS M12
			FROM ShipmentReport_Shipped_All_Fixed_Fiscal 
			WHERE ReportCode='999'
				 AND Site='Chi' 
				 AND Year=@Year
			UNION
			SELECT 'Scrap' AS Plant,-M1,-M2,-M3,-M4,-M5,-M6,-M7,-M8,-M9,-M10,-M11,-M12
			FROM DistribitionReport_Amount_Fiscal
			WHERE ReportCode='555'
				AND Type='Scrap'
				AND Year=@Year
				AND Site='Chi'
				AND Plant=''
		) a
	/*by joe 2012-12-03
	UNION
	SELECT 'Display Misc adjustments' AS Plant,SUM(M1) AS M1,SUM(M2) AS M2,SUM(M3) AS M3,SUM(M4) AS M4,SUM(M5) AS M5,SUM(M6) AS M6,SUM(M7) AS M7,SUM(M8) AS M8,SUM(M9) AS M9,SUM(M10) AS M10,SUM(M11) AS M11,SUM(M12) AS M12
	FROM (
			SELECT 'JVM' AS Plant,SUM(M1) AS M1,SUM(M2) AS M2,SUM(M3) AS M3,SUM(M4) AS M4,SUM(M5) AS M5,SUM(M6) AS M6,SUM(M7) AS M7,SUM(M8) AS M8,SUM(M9) AS M9,SUM(M10) AS M10,SUM(M11) AS M11,SUM(M12) AS M12
			FROM ShipmentReport_Shipped_All_Fixed_Fiscal 
			WHERE ReportCode='997'
				 AND Site='Dis' 
				 AND Year=@Year
		) a
	*/
	UNION
	SELECT 'B5' AS Plant,M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12
	FROM ShipmentReport_Shipped_All_Fixed_Fiscal
	WHERE ReportCode='003'
		AND Year=@Year
		AND Site='Chi'
		AND Plant='B5'
	UNION
	SELECT 'B4' AS Plant,M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12
	FROM ShipmentReport_Shipped_All_Fixed_Fiscal
	WHERE ReportCode='003'
		AND Year=@Year
		AND Site='Chi'
		AND Plant='B4'
	UNION
	SELECT 'B3' AS Plant,SUM(M1) AS M1,SUM(M2) AS M2,SUM(M3) AS M3,SUM(M4) AS M4,SUM(M5) AS M5,SUM(M6) AS M6,SUM(M7) AS M7,SUM(M8) AS M8,SUM(M9) AS M9,SUM(M10) AS M10,SUM(M11) AS M11,SUM(M12) AS M12
	FROM ShipmentReport_Shipped_All_Fixed_Fiscal
	WHERE ReportCode='003'
		AND Year=@Year
		AND Site='Chi'
		AND (Plant='B3' OR Plant='12')
	UNION
	SELECT 'VVI' AS Plant,M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12
	FROM ShipmentReport_Shipped_All_Fixed_Fiscal
	WHERE ReportCode='003'
		AND Year=@Year
		AND Site='Chi'
		AND Plant='HK'
	/*
	UNION
	SELECT 'B12' AS Plant,M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12
	FROM ShipmentReport_Shipped_All_Fixed_Fiscal
	WHERE ReportCode='003'
		AND Year=@Year
		AND Site='Chi'
		AND Plant='12'
	*/
	UNION
	SELECT 'B2F' AS Plant,M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12
	FROM ShipmentReport_Shipped_All_Fixed_Fiscal
	WHERE ReportCode='003'
		AND Year=@Year
		AND Site='Chi'
		AND Plant='2F'
	UNION
	SELECT 'B1' AS Plant,M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12
	FROM ShipmentReport_Shipped_All_Fixed_Fiscal
	WHERE ReportCode='003'
		AND Year=@Year
		AND Site='Chi'
		AND Plant='P2'
	/* by joe 2012-12-03	
	UNION
	SELECT 'Display' AS Plant,M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12
	FROM ShipmentReport_Shipped_All_Fixed_Fiscal
	WHERE ReportCode='002'
		AND Year=@Year
		AND Site='Dis'
	*/
	SELECT @Year AS Year,SUM(M1) AS M1,SUM(M2) AS M2,SUM(M3) AS M3,SUM(M4) AS M4,SUM(M5) AS M5,SUM(M6) AS M6,SUM(M7) AS M7,SUM(M8) AS M8,SUM(M9) AS M9,SUM(M10) AS M10,SUM(M11) AS M11,SUM(M12) AS M12
	FROM (
			SELECT 'Germany' AS Site,M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12
			FROM ShipmentReport_Shipped_All_Fixed_Fiscal
			WHERE ReportCode='002'
				AND Year=@Year
				AND Site='Ger'
			UNION
			SELECT 'Germany' AS Site,SUM(M1) AS M1,SUM(M2) AS M2,SUM(M3) AS M3,SUM(M4) AS M4,SUM(M5) AS M5,SUM(M6) AS M6,SUM(M7) AS M7,SUM(M8) AS M8,SUM(M9) AS M9,SUM(M10) AS M10,SUM(M11) AS M11,SUM(M12) AS M12
			FROM ShipmentReport_Shipped_All_Fixed_Fiscal 
			WHERE ReportCode='995'
				 AND Site='Ger' 
				 AND Year=@Year
			UNION
			SELECT 'Brazil' AS Site,M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12
			FROM ShipmentReport_Shipped_All_Fixed_Fiscal
			WHERE ReportCode='002'
				AND Year=@Year
				AND Site='Sao'
			UNION
			SELECT 'Brazil' AS Site,SUM(M1) AS M1,SUM(M2) AS M2,SUM(M3) AS M3,SUM(M4) AS M4,SUM(M5) AS M5,SUM(M6) AS M6,SUM(M7) AS M7,SUM(M8) AS M8,SUM(M9) AS M9,SUM(M10) AS M10,SUM(M11) AS M11,SUM(M12) AS M12
			FROM ShipmentReport_Shipped_All_Fixed_Fiscal 
			WHERE ReportCode='993'
				 AND Site='Sao' 
				 AND Year=@Year
			UNION
			SELECT 'NorthField' AS Site,M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12
			FROM ShipmentReport_Shipped_All_Fixed_Fiscal
			WHERE ReportCode='002'
				AND Year=@Year
				AND Site='Nfd'
			UNION
			SELECT 'China' AS Site,SUM(M1) AS M1,SUM(M2) AS M2,SUM(M3) AS M3,SUM(M4) AS M4,SUM(M5) AS M5,SUM(M6) AS M6,SUM(M7) AS M7,SUM(M8) AS M8,SUM(M9) AS M9,SUM(M10) AS M10,SUM(M11) AS M11,SUM(M12) AS M12
			FROM (
					SELECT M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12
					FROM ShipmentReport_Shipped_All_Fixed_Fiscal
					WHERE ReportCode='002'
						AND Year=@Year
						AND (Site='Chi' OR Site='Dis')
				) a
			UNION
			SELECT 'China' AS Site,SUM(M1) AS M1,SUM(M2) AS M2,SUM(M3) AS M3,SUM(M4) AS M4,SUM(M5) AS M5,SUM(M6) AS M6,SUM(M7) AS M7,SUM(M8) AS M8,SUM(M9) AS M9,SUM(M10) AS M10,SUM(M11) AS M11,SUM(M12) AS M12
			FROM ShipmentReport_Shipped_All_Fixed_Fiscal 
			WHERE ReportCode='999'
				 AND Site='Chi' 
				 AND Year=@Year
			/*by joe 2012-12-03
			UNION
			SELECT 'China' AS Site,SUM(M1) AS M1,SUM(M2) AS M2,SUM(M3) AS M3,SUM(M4) AS M4,SUM(M5) AS M5,SUM(M6) AS M6,SUM(M7) AS M7,SUM(M8) AS M8,SUM(M9) AS M9,SUM(M10) AS M10,SUM(M11) AS M11,SUM(M12) AS M12
			FROM ShipmentReport_Shipped_All_Fixed_Fiscal 
			WHERE ReportCode='997'
				 AND Site='Dis' 
				 AND Year=@Year
			*/
		) a

	SELECT 'Germany' AS Site,M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12
	FROM ShipmentReport_Shipped_All_Fixed_Fiscal
	WHERE ReportCode='002'
		AND Year=@Year
		AND Site='Ger'
	UNION
	SELECT 'Germany Misc adjustments' AS Plant,SUM(M1) AS M1,SUM(M2) AS M2,SUM(M3) AS M3,SUM(M4) AS M4,SUM(M5) AS M5,SUM(M6) AS M6,SUM(M7) AS M7,SUM(M8) AS M8,SUM(M9) AS M9,SUM(M10) AS M10,SUM(M11) AS M11,SUM(M12) AS M12
	FROM (
			SELECT 'JVM' AS Plant,SUM(M1) AS M1,SUM(M2) AS M2,SUM(M3) AS M3,SUM(M4) AS M4,SUM(M5) AS M5,SUM(M6) AS M6,SUM(M7) AS M7,SUM(M8) AS M8,SUM(M9) AS M9,SUM(M10) AS M10,SUM(M11) AS M11,SUM(M12) AS M12
			FROM ShipmentReport_Shipped_All_Fixed_Fiscal 
			WHERE ReportCode='995'
				 AND Site='Ger' 
				 AND Year=@Year
		) a


END
GO
