USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[ShipmentReport_sp_Query_Global_Monthly_Shipment_Trend_Maps_For_CrystalReport]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ShipmentReport_sp_Query_Global_Monthly_Shipment_Trend_Maps_For_CrystalReport] 
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
								FROM ShipmentReport_Shipped_All_Fixed
								WHERE ReportCode='002'
									AND Year=@Year
									AND Site=@Site
							 ) a
					)
	SET @Site='DIS'
	SET @DisplayAmount=(
							SELECT SUM(a.M1+a.M2+a.M3+a.M4+a.M5+a.M6+a.M7+a.M8+a.M9+a.M10+a.M11+a.M12)
							FROM (
									SELECT M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12
									FROM ShipmentReport_Shipped_All_Fixed
									WHERE ReportCode='002'
										AND Year=@Year
										AND Site=@Site
								 ) a
						)
	SET @AsiaAmount=@ChinaAmount+@DisplayAmount
	SET @Site='Ger'
	SET @EuropeAmount=(
						SELECT SUM(a.M1+a.M2+a.M3+a.M4+a.M5+a.M6+a.M7+a.M8+a.M9+a.M10+a.M11+a.M12)
						FROM (
								SELECT M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12
								FROM ShipmentReport_Shipped_All_Fixed
								WHERE ReportCode='002'
									AND Year=@Year
									AND Site=@Site
							 ) a
					)
	SET @Site='Nfd'
	SET @NorthAmericaAmount=(
						SELECT SUM(a.M1+a.M2+a.M3+a.M4+a.M5+a.M6+a.M7+a.M8+a.M9+a.M10+a.M11+a.M12)
						FROM (
								SELECT M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12
								FROM ShipmentReport_Shipped_All_Fixed
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
								FROM ShipmentReport_Shipped_All_Fixed
								WHERE ReportCode='002'
									AND Year=@Year
									AND Site=@Site
							 ) a
					)
	SET @Site='CHI'
	SET @Plant='NA'
	SET @ChinaNAAmount=(
						SELECT SUM(a.M1+a.M2+a.M3+a.M4+a.M5+a.M6+a.M7+a.M8+a.M9+a.M10+a.M11+a.M12)
						FROM (
								SELECT M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12
								FROM ShipmentReport_Shipped_All_Fixed
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
								FROM ShipmentReport_Shipped_All_Fixed
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
								FROM ShipmentReport_Shipped_All_Fixed
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
								FROM ShipmentReport_Shipped_All_Fixed
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
								FROM ShipmentReport_Shipped_All_Fixed
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
								FROM ShipmentReport_Shipped_All_Fixed
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
								FROM ShipmentReport_Shipped_All_Fixed
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
								FROM ShipmentReport_Shipped_All_Fixed
								WHERE ReportCode='003'
									AND Year=@Year
									AND Site=@Site
									AND Plant=@Plant
							 ) a
					)

	--SELECT  'Asia' AS Site,ISNULL(@AsiaAmount,0) AS Amount
	--UNION
	SELECT		'Germany' AS Site,ISNULL(@EuropeAmount,0) AS Amount
	UNION
	SELECT  'Northfield'AS Site,ISNULL(@NorthAmericaAmount,0) AS Amount
	UNION
	SELECT		 'Brazil' AS Site,ISNULL(@SouthAmericaAmount,0) AS Amount
	UNION
	--SELECT		 'China' AS Site,			ISNULL(@ChinaAmount,0) AS Amount
	--UNION
	SELECT		 'China-Display' AS Site,			ISNULL(@DisplayAmount,0) AS Amount
	UNION
	SELECT		 'China-B5' AS Site,			ISNULL(@ChinaB5Amount,0)AS Amount
	UNION
	SELECT		 'China-VVI' AS Site,			ISNULL(@ChinaHKAmount,0) AS Amount
	UNION
	SELECT		 'China-B12' AS Site,			ISNULL(@China12Amount,0) AS Amount
	UNION
	SELECT		 'China-B2F' AS Site,			ISNULL(@China2FAmount,0) AS Amount
	UNION
	SELECT		 'China-B3' AS Site,			ISNULL(@ChinaB3Amount,0) AS Amount
	UNION
	SELECT		 'China-B4' AS Site,			ISNULL(@ChinaB4Amount,0) AS Amount
	UNION
	SELECT		 'China-B1' AS Site,			ISNULL(@ChinaP2Amount,0) AS Amount
	UNION
	SELECT		 'China-NA' AS Site,			ISNULL(@ChinaNAAmount,0) AS Amount
END
GO
