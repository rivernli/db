USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[ShipmentReport_sp_Initial_Forecast]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ShipmentReport_sp_Initial_Forecast]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @Site VARCHAR(50),@Plant VARCHAR(50)
	
	SET @Site='Chi'
	SET @Plant='12'
	INSERT INTO ShipmentReport_Shipped_All_Forecast
	SELECT @Site,@Plant,ShipmentYears,0,0,0,0,0,0,0,0,0,0,0,0
	FROM ShipmentReport_Fiscal_Year
	WHERE ShipmentYears NOT IN (
									SELECT Year
									FROM ShipmentReport_Shipped_All_Forecast
									WHERE Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)
	SET @Site='Chi'
	SET @Plant='2F'
	INSERT INTO ShipmentReport_Shipped_All_Forecast
	SELECT @Site,@Plant,ShipmentYears,0,0,0,0,0,0,0,0,0,0,0,0
	FROM ShipmentReport_Fiscal_Year
	WHERE ShipmentYears NOT IN (
									SELECT Year
									FROM ShipmentReport_Shipped_All_Forecast
									WHERE Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)
	SET @Site='Chi'
	SET @Plant='P2'
	INSERT INTO ShipmentReport_Shipped_All_Forecast
	SELECT @Site,@Plant,ShipmentYears,0,0,0,0,0,0,0,0,0,0,0,0
	FROM ShipmentReport_Fiscal_Year
	WHERE ShipmentYears NOT IN (
									SELECT Year
									FROM ShipmentReport_Shipped_All_Forecast
									WHERE Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)
	SET @Site='Chi'
	SET @Plant='B3'
	INSERT INTO ShipmentReport_Shipped_All_Forecast
	SELECT @Site,@Plant,ShipmentYears,0,0,0,0,0,0,0,0,0,0,0,0
	FROM ShipmentReport_Fiscal_Year
	WHERE ShipmentYears NOT IN (
									SELECT Year
									FROM ShipmentReport_Shipped_All_Forecast
									WHERE Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)
	SET @Site='Chi'
	SET @Plant='B4'
	INSERT INTO ShipmentReport_Shipped_All_Forecast
	SELECT @Site,@Plant,ShipmentYears,0,0,0,0,0,0,0,0,0,0,0,0
	FROM ShipmentReport_Fiscal_Year
	WHERE ShipmentYears NOT IN (
									SELECT Year
									FROM ShipmentReport_Shipped_All_Forecast
									WHERE Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)
	SET @Site='Chi'
	SET @Plant='B5'
	INSERT INTO ShipmentReport_Shipped_All_Forecast
	SELECT @Site,@Plant,ShipmentYears,0,0,0,0,0,0,0,0,0,0,0,0
	FROM ShipmentReport_Fiscal_Year
	WHERE ShipmentYears NOT IN (
									SELECT Year
									FROM ShipmentReport_Shipped_All_Forecast
									WHERE Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)
	SET @Site='Chi'
	SET @Plant='HK'
	INSERT INTO ShipmentReport_Shipped_All_Forecast
	SELECT @Site,@Plant,ShipmentYears,0,0,0,0,0,0,0,0,0,0,0,0
	FROM ShipmentReport_Fiscal_Year
	WHERE ShipmentYears NOT IN (
									SELECT Year
									FROM ShipmentReport_Shipped_All_Forecast
									WHERE Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)
	SET @Site='Chi'
	SET @Plant=''
	INSERT INTO ShipmentReport_Shipped_All_Forecast
	SELECT @Site,@Plant,ShipmentYears,0,0,0,0,0,0,0,0,0,0,0,0
	FROM ShipmentReport_Fiscal_Year
	WHERE ShipmentYears NOT IN (
									SELECT Year
									FROM ShipmentReport_Shipped_All_Forecast
									WHERE Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)
	SET @Site='Dis'
	SET @Plant=''
	INSERT INTO ShipmentReport_Shipped_All_Forecast
	SELECT @Site,@Plant,ShipmentYears,0,0,0,0,0,0,0,0,0,0,0,0
	FROM ShipmentReport_Fiscal_Year
	WHERE ShipmentYears NOT IN (
									SELECT Year
									FROM ShipmentReport_Shipped_All_Forecast
									WHERE Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)
	SET @Site='Nfd'
	SET @Plant=''
	INSERT INTO ShipmentReport_Shipped_All_Forecast
	SELECT @Site,@Plant,ShipmentYears,0,0,0,0,0,0,0,0,0,0,0,0
	FROM ShipmentReport_Fiscal_Year
	WHERE ShipmentYears NOT IN (
									SELECT Year
									FROM ShipmentReport_Shipped_All_Forecast
									WHERE Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)
	SET @Site='Sao'
	SET @Plant=''
	INSERT INTO ShipmentReport_Shipped_All_Forecast
	SELECT @Site,@Plant,ShipmentYears,0,0,0,0,0,0,0,0,0,0,0,0
	FROM ShipmentReport_Fiscal_Year
	WHERE ShipmentYears NOT IN (
									SELECT Year
									FROM ShipmentReport_Shipped_All_Forecast
									WHERE Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)
	SET @Site='Ger'
	SET @Plant=''
	INSERT INTO ShipmentReport_Shipped_All_Forecast
	SELECT @Site,@Plant,ShipmentYears,0,0,0,0,0,0,0,0,0,0,0,0
	FROM ShipmentReport_Fiscal_Year
	WHERE ShipmentYears NOT IN (
									SELECT Year
									FROM ShipmentReport_Shipped_All_Forecast
									WHERE Site=@Site
											AND Plant=@Plant
									GROUP BY Year
								)

END
GO
