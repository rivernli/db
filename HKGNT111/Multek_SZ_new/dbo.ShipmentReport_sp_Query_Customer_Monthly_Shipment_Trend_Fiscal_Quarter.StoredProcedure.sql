USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[ShipmentReport_sp_Query_Customer_Monthly_Shipment_Trend_Fiscal_Quarter]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ShipmentReport_sp_Query_Customer_Monthly_Shipment_Trend_Fiscal_Quarter] 
	-- Add the parameters for the stored procedure here
	@Year CHAR(4),
	@Customer VARCHAR(2000)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	set ansi_nulls off;

    -- Insert statements for procedure here
    -- Insert statements for procedure here
	DECLARE @YearMonth VARCHAR(7)

	SET @Customer=RTRIM(LTRIM(@Customer))
	IF RIGHT(@Customer,1)=']'
		BEGIN
			SET @Customer=LEFT(@Customer,LEN(@Customer)-CHARINDEX('[',REVERSE(@Customer))-3)	
		END

	SET @Customer=@Customer+'%'

	SELECT (
				SELECT ISNULL(SUM(ISNULL(ShDols,0)),0)
				FROM ShipmentReport_Shipped_All
				WHERE ShDate>=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalQuarter=1) 
					  AND ShDate<=(SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalQuarter=1) 
					  AND [Customer Name]LIKE @Customer
			) AS M1,
			(
				SELECT ISNULL(SUM(ISNULL(ShDols,0)),0)
				FROM ShipmentReport_Shipped_All
				WHERE ShDate>=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalQuarter=2) 
					  AND ShDate<=(SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalQuarter=2) 
					  AND [Customer Name]LIKE @Customer
			)AS M2,
			(
				SELECT ISNULL(SUM(ISNULL(ShDols,0)),0)
				FROM ShipmentReport_Shipped_All
				WHERE ShDate>=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalQuarter=3) 
					  AND ShDate<=(SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalQuarter=3) 
					  AND [Customer Name]LIKE @Customer
			)AS M3,
			(
				SELECT ISNULL(SUM(ISNULL(ShDols,0)),0)
				FROM ShipmentReport_Shipped_All
				WHERE ShDate>=(SELECT MIN(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalQuarter=4) 
					  AND ShDate<=(SELECT MAX(CONVERT(VARCHAR(10),CalenderDate,120)) FROM Calendar WHERE FiscalYear=@Year AND FiscalQuarter=4) 
					  AND [Customer Name]LIKE @Customer
			)AS M4,
			(
				0
			)AS M5,
			(
				0
			)AS M6,
			(
				0
			)AS M7,
			(
				0
			)AS M8,
			(
				0
			)AS M9,
			(
				0
			)AS M10,
			(
				0
			)AS M11,
			(
				0
			) AS M12

END
GO
