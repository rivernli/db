USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[DistributionReport_sp_Initial_Forecast]    Script Date: 11/06/2014 15:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DistributionReport_sp_Initial_Forecast]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @Type VARCHAR(50),@Site VARCHAR(3),@Plant VARCHAR(50)
	
	UPDATE TFSOLP104180 SET T$PLNT='B3' WHERE T$PLNT='12'
	UPDATE TFSOLP105180 SET T$PLNT='B3' WHERE T$PLNT='12'
	UPDATE TFSOLP106180 SET T$PLNT='B3' WHERE T$PLNT='12'
	UPDATE TFSOLP107180 SET T$PLNT='B3' WHERE T$PLNT='12'
	
	SET @Type='Output'
	SET @Site='Chi'
	SET @Plant='SUB'
	INSERT INTO DistributionReport_Forecast
	SELECT @Type,@Site,@Plant,Year,0,0,0,0,0,0,0,0,0,0,0,0
	FROM DistributionReport_Fiscal_Year
	WHERE Year NOT IN (
									SELECT Year
									FROM DistributionReport_Forecast
									WHERE Type=@Type
											AND Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)
	SET @Plant='P2'
	INSERT INTO DistributionReport_Forecast
	SELECT @Type,@Site,@Plant,Year,0,0,0,0,0,0,0,0,0,0,0,0
	FROM DistributionReport_Fiscal_Year
	WHERE Year NOT IN (
									SELECT Year
									FROM DistributionReport_Forecast
									WHERE Type=@Type
											AND Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)
	SET @Plant='2F'
	INSERT INTO DistributionReport_Forecast
	SELECT @Type,@Site,@Plant,Year,0,0,0,0,0,0,0,0,0,0,0,0
	FROM DistributionReport_Fiscal_Year
	WHERE Year NOT IN (
									SELECT Year
									FROM DistributionReport_Forecast
									WHERE Type=@Type
											AND Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)
	SET @Plant='B3'
	INSERT INTO DistributionReport_Forecast
	SELECT @Type,@Site,@Plant,Year,0,0,0,0,0,0,0,0,0,0,0,0
	FROM DistributionReport_Fiscal_Year
	WHERE Year NOT IN (
									SELECT Year
									FROM DistributionReport_Forecast
									WHERE Type=@Type
											AND Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)

	SET @Plant='B4'
	INSERT INTO DistributionReport_Forecast
	SELECT @Type,@Site,@Plant,Year,0,0,0,0,0,0,0,0,0,0,0,0
	FROM DistributionReport_Fiscal_Year
	WHERE Year NOT IN (
									SELECT Year
									FROM DistributionReport_Forecast
									WHERE Type=@Type
											AND Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)
	SET @Plant='B5'
	INSERT INTO DistributionReport_Forecast
	SELECT @Type,@Site,@Plant,Year,0,0,0,0,0,0,0,0,0,0,0,0
	FROM DistributionReport_Fiscal_Year
	WHERE Year NOT IN (
									SELECT Year
									FROM DistributionReport_Forecast
									WHERE Type=@Type
											AND Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)
	SET @Plant='HK'
	INSERT INTO DistributionReport_Forecast
	SELECT @Type,@Site,@Plant,Year,0,0,0,0,0,0,0,0,0,0,0,0
	FROM DistributionReport_Fiscal_Year
	WHERE Year NOT IN (
									SELECT Year
									FROM DistributionReport_Forecast
									WHERE Type=@Type
											AND Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)
	SET @Plant=''
	INSERT INTO DistributionReport_Forecast
	SELECT @Type,@Site,@Plant,Year,0,0,0,0,0,0,0,0,0,0,0,0
	FROM DistributionReport_Fiscal_Year
	WHERE Year NOT IN (
									SELECT Year
									FROM DistributionReport_Forecast
									WHERE Type=@Type
											AND Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)
	SET @Plant='ZhuHaiEXB2F'
	INSERT INTO DistributionReport_Forecast
	SELECT @Type,@Site,@Plant,Year,0,0,0,0,0,0,0,0,0,0,0,0
	FROM DistributionReport_Fiscal_Year
	WHERE Year NOT IN (
									SELECT Year
									FROM DistributionReport_Forecast
									WHERE Type=@Type
											AND Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)
	SET @Type='Shipment'
	SET @Site='Chi'
	SET @Plant='SUB'
	INSERT INTO DistributionReport_Forecast
	SELECT @Type,@Site,@Plant,Year,0,0,0,0,0,0,0,0,0,0,0,0
	FROM DistributionReport_Fiscal_Year
	WHERE Year NOT IN (
									SELECT Year
									FROM DistributionReport_Forecast
									WHERE Type=@Type
											AND Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)
	SET @Plant='P2'
	INSERT INTO DistributionReport_Forecast
	SELECT @Type,@Site,@Plant,Year,0,0,0,0,0,0,0,0,0,0,0,0
	FROM DistributionReport_Fiscal_Year
	WHERE Year NOT IN (
									SELECT Year
									FROM DistributionReport_Forecast
									WHERE Type=@Type
											AND Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)
	SET @Plant='2F'
	INSERT INTO DistributionReport_Forecast
	SELECT @Type,@Site,@Plant,Year,0,0,0,0,0,0,0,0,0,0,0,0
	FROM DistributionReport_Fiscal_Year
	WHERE Year NOT IN (
									SELECT Year
									FROM DistributionReport_Forecast
									WHERE Type=@Type
											AND Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)
	SET @Plant='B3'
	INSERT INTO DistributionReport_Forecast
	SELECT @Type,@Site,@Plant,Year,0,0,0,0,0,0,0,0,0,0,0,0
	FROM DistributionReport_Fiscal_Year
	WHERE Year NOT IN (
									SELECT Year
									FROM DistributionReport_Forecast
									WHERE Type=@Type
											AND Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)

	SET @Plant='B4'
	INSERT INTO DistributionReport_Forecast
	SELECT @Type,@Site,@Plant,Year,0,0,0,0,0,0,0,0,0,0,0,0
	FROM DistributionReport_Fiscal_Year
	WHERE Year NOT IN (
									SELECT Year
									FROM DistributionReport_Forecast
									WHERE Type=@Type
											AND Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)
	SET @Plant='B5'
	INSERT INTO DistributionReport_Forecast
	SELECT @Type,@Site,@Plant,Year,0,0,0,0,0,0,0,0,0,0,0,0
	FROM DistributionReport_Fiscal_Year
	WHERE Year NOT IN (
									SELECT Year
									FROM DistributionReport_Forecast
									WHERE Type=@Type
											AND Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)
	SET @Plant='HK'
	INSERT INTO DistributionReport_Forecast
	SELECT @Type,@Site,@Plant,Year,0,0,0,0,0,0,0,0,0,0,0,0
	FROM DistributionReport_Fiscal_Year
	WHERE Year NOT IN (
									SELECT Year
									FROM DistributionReport_Forecast
									WHERE Type=@Type
											AND Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)
	SET @Plant=''
	INSERT INTO DistributionReport_Forecast
	SELECT @Type,@Site,@Plant,Year,0,0,0,0,0,0,0,0,0,0,0,0
	FROM DistributionReport_Fiscal_Year
	WHERE Year NOT IN (
									SELECT Year
									FROM DistributionReport_Forecast
									WHERE Type=@Type
											AND Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)
	SET @Plant='ZhuHaiEXB2F'
	INSERT INTO DistributionReport_Forecast
	SELECT @Type,@Site,@Plant,Year,0,0,0,0,0,0,0,0,0,0,0,0
	FROM DistributionReport_Fiscal_Year
	WHERE Year NOT IN (
									SELECT Year
									FROM DistributionReport_Forecast
									WHERE Type=@Type
											AND Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)
	SET @Type='Outbound'
	SET @Site='Chi'
	SET @Plant='SUB'
	INSERT INTO DistributionReport_Forecast
	SELECT @Type,@Site,@Plant,Year,0,0,0,0,0,0,0,0,0,0,0,0
	FROM DistributionReport_Fiscal_Year
	WHERE Year NOT IN (
									SELECT Year
									FROM DistributionReport_Forecast
									WHERE Type=@Type
											AND Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)
	SET @Plant='P2'
	INSERT INTO DistributionReport_Forecast
	SELECT @Type,@Site,@Plant,Year,0,0,0,0,0,0,0,0,0,0,0,0
	FROM DistributionReport_Fiscal_Year
	WHERE Year NOT IN (
									SELECT Year
									FROM DistributionReport_Forecast
									WHERE Type=@Type
											AND Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)
	SET @Plant='2F'
	INSERT INTO DistributionReport_Forecast
	SELECT @Type,@Site,@Plant,Year,0,0,0,0,0,0,0,0,0,0,0,0
	FROM DistributionReport_Fiscal_Year
	WHERE Year NOT IN (
									SELECT Year
									FROM DistributionReport_Forecast
									WHERE Type=@Type
											AND Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)
	SET @Plant='B3'
	INSERT INTO DistributionReport_Forecast
	SELECT @Type,@Site,@Plant,Year,0,0,0,0,0,0,0,0,0,0,0,0
	FROM DistributionReport_Fiscal_Year
	WHERE Year NOT IN (
									SELECT Year
									FROM DistributionReport_Forecast
									WHERE Type=@Type
											AND Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)

	SET @Plant='B4'
	INSERT INTO DistributionReport_Forecast
	SELECT @Type,@Site,@Plant,Year,0,0,0,0,0,0,0,0,0,0,0,0
	FROM DistributionReport_Fiscal_Year
	WHERE Year NOT IN (
									SELECT Year
									FROM DistributionReport_Forecast
									WHERE Type=@Type
											AND Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)
	SET @Plant='B5'
	INSERT INTO DistributionReport_Forecast
	SELECT @Type,@Site,@Plant,Year,0,0,0,0,0,0,0,0,0,0,0,0
	FROM DistributionReport_Fiscal_Year
	WHERE Year NOT IN (
									SELECT Year
									FROM DistributionReport_Forecast
									WHERE Type=@Type
											AND Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)
	SET @Plant='HK'
	INSERT INTO DistributionReport_Forecast
	SELECT @Type,@Site,@Plant,Year,0,0,0,0,0,0,0,0,0,0,0,0
	FROM DistributionReport_Fiscal_Year
	WHERE Year NOT IN (
									SELECT Year
									FROM DistributionReport_Forecast
									WHERE Type=@Type
											AND Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)
	SET @Plant=''
	INSERT INTO DistributionReport_Forecast
	SELECT @Type,@Site,@Plant,Year,0,0,0,0,0,0,0,0,0,0,0,0
	FROM DistributionReport_Fiscal_Year
	WHERE Year NOT IN (
									SELECT Year
									FROM DistributionReport_Forecast
									WHERE Type=@Type
											AND Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)
	SET @Plant='ZhuHaiEXB2F'
	INSERT INTO DistributionReport_Forecast
	SELECT @Type,@Site,@Plant,Year,0,0,0,0,0,0,0,0,0,0,0,0
	FROM DistributionReport_Fiscal_Year
	WHERE Year NOT IN (
									SELECT Year
									FROM DistributionReport_Forecast
									WHERE Type=@Type
											AND Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)
	SET @Type='HubIn'
	SET @Site='Chi'
	SET @Plant='SUB'
	INSERT INTO DistributionReport_Forecast
	SELECT @Type,@Site,@Plant,Year,0,0,0,0,0,0,0,0,0,0,0,0
	FROM DistributionReport_Fiscal_Year
	WHERE Year NOT IN (
									SELECT Year
									FROM DistributionReport_Forecast
									WHERE Type=@Type
											AND Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)
	SET @Plant='P2'
	INSERT INTO DistributionReport_Forecast
	SELECT @Type,@Site,@Plant,Year,0,0,0,0,0,0,0,0,0,0,0,0
	FROM DistributionReport_Fiscal_Year
	WHERE Year NOT IN (
									SELECT Year
									FROM DistributionReport_Forecast
									WHERE Type=@Type
											AND Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)
	SET @Plant='2F'
	INSERT INTO DistributionReport_Forecast
	SELECT @Type,@Site,@Plant,Year,0,0,0,0,0,0,0,0,0,0,0,0
	FROM DistributionReport_Fiscal_Year
	WHERE Year NOT IN (
									SELECT Year
									FROM DistributionReport_Forecast
									WHERE Type=@Type
											AND Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)
	SET @Plant='B3'
	INSERT INTO DistributionReport_Forecast
	SELECT @Type,@Site,@Plant,Year,0,0,0,0,0,0,0,0,0,0,0,0
	FROM DistributionReport_Fiscal_Year
	WHERE Year NOT IN (
									SELECT Year
									FROM DistributionReport_Forecast
									WHERE Type=@Type
											AND Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)

	SET @Plant='B4'
	INSERT INTO DistributionReport_Forecast
	SELECT @Type,@Site,@Plant,Year,0,0,0,0,0,0,0,0,0,0,0,0
	FROM DistributionReport_Fiscal_Year
	WHERE Year NOT IN (
									SELECT Year
									FROM DistributionReport_Forecast
									WHERE Type=@Type
											AND Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)
	SET @Plant='B5'
	INSERT INTO DistributionReport_Forecast
	SELECT @Type,@Site,@Plant,Year,0,0,0,0,0,0,0,0,0,0,0,0
	FROM DistributionReport_Fiscal_Year
	WHERE Year NOT IN (
									SELECT Year
									FROM DistributionReport_Forecast
									WHERE Type=@Type
											AND Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)
	SET @Plant='HK'
	INSERT INTO DistributionReport_Forecast
	SELECT @Type,@Site,@Plant,Year,0,0,0,0,0,0,0,0,0,0,0,0
	FROM DistributionReport_Fiscal_Year
	WHERE Year NOT IN (
									SELECT Year
									FROM DistributionReport_Forecast
									WHERE Type=@Type
											AND Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)
	SET @Plant=''
	INSERT INTO DistributionReport_Forecast
	SELECT @Type,@Site,@Plant,Year,0,0,0,0,0,0,0,0,0,0,0,0
	FROM DistributionReport_Fiscal_Year
	WHERE Year NOT IN (
									SELECT Year
									FROM DistributionReport_Forecast
									WHERE Type=@Type
											AND Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)
	SET @Plant='ZhuHaiEXB2F'
	INSERT INTO DistributionReport_Forecast
	SELECT @Type,@Site,@Plant,Year,0,0,0,0,0,0,0,0,0,0,0,0
	FROM DistributionReport_Fiscal_Year
	WHERE Year NOT IN (
									SELECT Year
									FROM DistributionReport_Forecast
									WHERE Type=@Type
											AND Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)
	SET @Type='RMA'
	SET @Site='Chi'
	SET @Plant='SUB'
	INSERT INTO DistributionReport_Forecast
	SELECT @Type,@Site,@Plant,Year,0,0,0,0,0,0,0,0,0,0,0,0
	FROM DistributionReport_Fiscal_Year
	WHERE Year NOT IN (
									SELECT Year
									FROM DistributionReport_Forecast
									WHERE Type=@Type
											AND Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)
	SET @Plant='P2'
	INSERT INTO DistributionReport_Forecast
	SELECT @Type,@Site,@Plant,Year,0,0,0,0,0,0,0,0,0,0,0,0
	FROM DistributionReport_Fiscal_Year
	WHERE Year NOT IN (
									SELECT Year
									FROM DistributionReport_Forecast
									WHERE Type=@Type
											AND Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)
	SET @Plant='2F'
	INSERT INTO DistributionReport_Forecast
	SELECT @Type,@Site,@Plant,Year,0,0,0,0,0,0,0,0,0,0,0,0
	FROM DistributionReport_Fiscal_Year
	WHERE Year NOT IN (
									SELECT Year
									FROM DistributionReport_Forecast
									WHERE Type=@Type
											AND Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)
	SET @Plant='B3'
	INSERT INTO DistributionReport_Forecast
	SELECT @Type,@Site,@Plant,Year,0,0,0,0,0,0,0,0,0,0,0,0
	FROM DistributionReport_Fiscal_Year
	WHERE Year NOT IN (
									SELECT Year
									FROM DistributionReport_Forecast
									WHERE Type=@Type
											AND Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)

	SET @Plant='B4'
	INSERT INTO DistributionReport_Forecast
	SELECT @Type,@Site,@Plant,Year,0,0,0,0,0,0,0,0,0,0,0,0
	FROM DistributionReport_Fiscal_Year
	WHERE Year NOT IN (
									SELECT Year
									FROM DistributionReport_Forecast
									WHERE Type=@Type
											AND Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)
	SET @Plant='B5'
	INSERT INTO DistributionReport_Forecast
	SELECT @Type,@Site,@Plant,Year,0,0,0,0,0,0,0,0,0,0,0,0
	FROM DistributionReport_Fiscal_Year
	WHERE Year NOT IN (
									SELECT Year
									FROM DistributionReport_Forecast
									WHERE Type=@Type
											AND Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)
	SET @Plant='HK'
	INSERT INTO DistributionReport_Forecast
	SELECT @Type,@Site,@Plant,Year,0,0,0,0,0,0,0,0,0,0,0,0
	FROM DistributionReport_Fiscal_Year
	WHERE Year NOT IN (
									SELECT Year
									FROM DistributionReport_Forecast
									WHERE Type=@Type
											AND Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)
	SET @Plant=''
	INSERT INTO DistributionReport_Forecast
	SELECT @Type,@Site,@Plant,Year,0,0,0,0,0,0,0,0,0,0,0,0
	FROM DistributionReport_Fiscal_Year
	WHERE Year NOT IN (
									SELECT Year
									FROM DistributionReport_Forecast
									WHERE Type=@Type
											AND Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)
	SET @Plant='ZhuHaiEXB2F'
	INSERT INTO DistributionReport_Forecast
	SELECT @Type,@Site,@Plant,Year,0,0,0,0,0,0,0,0,0,0,0,0
	FROM DistributionReport_Fiscal_Year
	WHERE Year NOT IN (
									SELECT Year
									FROM DistributionReport_Forecast
									WHERE Type=@Type
											AND Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)
	SET @Type='SCRAP'
	SET @Site='Chi'
	SET @Plant='SUB'
	INSERT INTO DistributionReport_Forecast
	SELECT @Type,@Site,@Plant,Year,0,0,0,0,0,0,0,0,0,0,0,0
	FROM DistributionReport_Fiscal_Year
	WHERE Year NOT IN (
									SELECT Year
									FROM DistributionReport_Forecast
									WHERE Type=@Type
											AND Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)
	SET @Plant='P2'
	INSERT INTO DistributionReport_Forecast
	SELECT @Type,@Site,@Plant,Year,0,0,0,0,0,0,0,0,0,0,0,0
	FROM DistributionReport_Fiscal_Year
	WHERE Year NOT IN (
									SELECT Year
									FROM DistributionReport_Forecast
									WHERE Type=@Type
											AND Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)
	SET @Plant='2F'
	INSERT INTO DistributionReport_Forecast
	SELECT @Type,@Site,@Plant,Year,0,0,0,0,0,0,0,0,0,0,0,0
	FROM DistributionReport_Fiscal_Year
	WHERE Year NOT IN (
									SELECT Year
									FROM DistributionReport_Forecast
									WHERE Type=@Type
											AND Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)
	SET @Plant='B3'
	INSERT INTO DistributionReport_Forecast
	SELECT @Type,@Site,@Plant,Year,0,0,0,0,0,0,0,0,0,0,0,0
	FROM DistributionReport_Fiscal_Year
	WHERE Year NOT IN (
									SELECT Year
									FROM DistributionReport_Forecast
									WHERE Type=@Type
											AND Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)

	SET @Plant='B4'
	INSERT INTO DistributionReport_Forecast
	SELECT @Type,@Site,@Plant,Year,0,0,0,0,0,0,0,0,0,0,0,0
	FROM DistributionReport_Fiscal_Year
	WHERE Year NOT IN (
									SELECT Year
									FROM DistributionReport_Forecast
									WHERE Type=@Type
											AND Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)
	SET @Plant='B5'
	INSERT INTO DistributionReport_Forecast
	SELECT @Type,@Site,@Plant,Year,0,0,0,0,0,0,0,0,0,0,0,0
	FROM DistributionReport_Fiscal_Year
	WHERE Year NOT IN (
									SELECT Year
									FROM DistributionReport_Forecast
									WHERE Type=@Type
											AND Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)
	SET @Plant='HK'
	INSERT INTO DistributionReport_Forecast
	SELECT @Type,@Site,@Plant,Year,0,0,0,0,0,0,0,0,0,0,0,0
	FROM DistributionReport_Fiscal_Year
	WHERE Year NOT IN (
									SELECT Year
									FROM DistributionReport_Forecast
									WHERE Type=@Type
											AND Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)
	SET @Plant=''
	INSERT INTO DistributionReport_Forecast
	SELECT @Type,@Site,@Plant,Year,0,0,0,0,0,0,0,0,0,0,0,0
	FROM DistributionReport_Fiscal_Year
	WHERE Year NOT IN (
									SELECT Year
									FROM DistributionReport_Forecast
									WHERE Type=@Type
											AND Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)
	SET @Plant='ZhuHaiEXB2F'
	INSERT INTO DistributionReport_Forecast
	SELECT @Type,@Site,@Plant,Year,0,0,0,0,0,0,0,0,0,0,0,0
	FROM DistributionReport_Fiscal_Year
	WHERE Year NOT IN (
									SELECT Year
									FROM DistributionReport_Forecast
									WHERE Type=@Type
											AND Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)
	SET @Type='Incoming'
	SET @Site='Chi'
	SET @Plant='SUB'
	INSERT INTO DistributionReport_Forecast
	SELECT @Type,@Site,@Plant,Year,0,0,0,0,0,0,0,0,0,0,0,0
	FROM DistributionReport_Fiscal_Year
	WHERE Year NOT IN (
									SELECT Year
									FROM DistributionReport_Forecast
									WHERE Type=@Type
											AND Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)
	INSERT INTO DistributionReport_Forecast_Weekly
	SELECT @Type,@Site,@Plant,Year,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	FROM DistributionReport_Fiscal_Year
	WHERE Year NOT IN (
									SELECT Year
									FROM DistributionReport_Forecast_Weekly
									WHERE Type=@Type
											AND Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)
	SET @Plant='P2'
	INSERT INTO DistributionReport_Forecast
	SELECT @Type,@Site,@Plant,Year,0,0,0,0,0,0,0,0,0,0,0,0
	FROM DistributionReport_Fiscal_Year
	WHERE Year NOT IN (
									SELECT Year
									FROM DistributionReport_Forecast
									WHERE Type=@Type
											AND Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)
	INSERT INTO DistributionReport_Forecast_Weekly
	SELECT @Type,@Site,@Plant,Year,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	FROM DistributionReport_Fiscal_Year
	WHERE Year NOT IN (
									SELECT Year
									FROM DistributionReport_Forecast_Weekly
									WHERE Type=@Type
											AND Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)
	SET @Plant='2F'
	INSERT INTO DistributionReport_Forecast
	SELECT @Type,@Site,@Plant,Year,0,0,0,0,0,0,0,0,0,0,0,0
	FROM DistributionReport_Fiscal_Year
	WHERE Year NOT IN (
									SELECT Year
									FROM DistributionReport_Forecast
									WHERE Type=@Type
											AND Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)
	INSERT INTO DistributionReport_Forecast_Weekly
	SELECT @Type,@Site,@Plant,Year,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	FROM DistributionReport_Fiscal_Year
	WHERE Year NOT IN (
									SELECT Year
									FROM DistributionReport_Forecast_Weekly
									WHERE Type=@Type
											AND Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)
	SET @Plant='B3'
	INSERT INTO DistributionReport_Forecast
	SELECT @Type,@Site,@Plant,Year,0,0,0,0,0,0,0,0,0,0,0,0
	FROM DistributionReport_Fiscal_Year
	WHERE Year NOT IN (
									SELECT Year
									FROM DistributionReport_Forecast
									WHERE Type=@Type
											AND Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)
	INSERT INTO DistributionReport_Forecast_Weekly
	SELECT @Type,@Site,@Plant,Year,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	FROM DistributionReport_Fiscal_Year
	WHERE Year NOT IN (
									SELECT Year
									FROM DistributionReport_Forecast_Weekly
									WHERE Type=@Type
											AND Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)

	SET @Plant='B4'
	INSERT INTO DistributionReport_Forecast
	SELECT @Type,@Site,@Plant,Year,0,0,0,0,0,0,0,0,0,0,0,0
	FROM DistributionReport_Fiscal_Year
	WHERE Year NOT IN (
									SELECT Year
									FROM DistributionReport_Forecast
									WHERE Type=@Type
											AND Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)
	INSERT INTO DistributionReport_Forecast_Weekly
	SELECT @Type,@Site,@Plant,Year,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	FROM DistributionReport_Fiscal_Year
	WHERE Year NOT IN (
									SELECT Year
									FROM DistributionReport_Forecast_Weekly
									WHERE Type=@Type
											AND Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)
	SET @Plant='B5'
	INSERT INTO DistributionReport_Forecast
	SELECT @Type,@Site,@Plant,Year,0,0,0,0,0,0,0,0,0,0,0,0
	FROM DistributionReport_Fiscal_Year
	WHERE Year NOT IN (
									SELECT Year
									FROM DistributionReport_Forecast
									WHERE Type=@Type
											AND Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)
	INSERT INTO DistributionReport_Forecast_Weekly
	SELECT @Type,@Site,@Plant,Year,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	FROM DistributionReport_Fiscal_Year
	WHERE Year NOT IN (
									SELECT Year
									FROM DistributionReport_Forecast_Weekly
									WHERE Type=@Type
											AND Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)
	SET @Plant='HK'
	INSERT INTO DistributionReport_Forecast
	SELECT @Type,@Site,@Plant,Year,0,0,0,0,0,0,0,0,0,0,0,0
	FROM DistributionReport_Fiscal_Year
	WHERE Year NOT IN (
									SELECT Year
									FROM DistributionReport_Forecast
									WHERE Type=@Type
											AND Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)
	INSERT INTO DistributionReport_Forecast_Weekly
	SELECT @Type,@Site,@Plant,Year,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	FROM DistributionReport_Fiscal_Year
	WHERE Year NOT IN (
									SELECT Year
									FROM DistributionReport_Forecast_Weekly
									WHERE Type=@Type
											AND Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)
	SET @Plant=''
	INSERT INTO DistributionReport_Forecast
	SELECT @Type,@Site,@Plant,Year,0,0,0,0,0,0,0,0,0,0,0,0
	FROM DistributionReport_Fiscal_Year
	WHERE Year NOT IN (
									SELECT Year
									FROM DistributionReport_Forecast
									WHERE Type=@Type
											AND Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)
	INSERT INTO DistributionReport_Forecast_Weekly
	SELECT @Type,@Site,@Plant,Year,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	FROM DistributionReport_Fiscal_Year
	WHERE Year NOT IN (
									SELECT Year
									FROM DistributionReport_Forecast_Weekly
									WHERE Type=@Type
											AND Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)				
	SET @Plant='ZhuHaiEXB2F'
	INSERT INTO DistributionReport_Forecast
	SELECT @Type,@Site,@Plant,Year,0,0,0,0,0,0,0,0,0,0,0,0
	FROM DistributionReport_Fiscal_Year
	WHERE Year NOT IN (
									SELECT Year
									FROM DistributionReport_Forecast
									WHERE Type=@Type
											AND Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)
	INSERT INTO DistributionReport_Forecast_Weekly
	SELECT @Type,@Site,@Plant,Year,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	FROM DistributionReport_Fiscal_Year
	WHERE Year NOT IN (
									SELECT Year
									FROM DistributionReport_Forecast_Weekly
									WHERE Type=@Type
											AND Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)

END
GO
