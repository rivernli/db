USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[ShipmentReport_sp_Query_Customer_Monthly_Shipment_Trend]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ShipmentReport_sp_Query_Customer_Monthly_Shipment_Trend] 
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
				WHERE ShDate>=@Year+'-01-01' 
					  AND ShDate<@Year+'-02-01' 
					  AND [Customer Name]LIKE @Customer
			) AS M1,
			(
				SELECT ISNULL(SUM(ISNULL(ShDols,0)),0)
				FROM ShipmentReport_Shipped_All
				WHERE ShDate>=@Year+'-02-01' 
					  AND ShDate<@Year+'-03-01' 
					  AND [Customer Name]LIKE @Customer
			)AS M2,
			(
				SELECT ISNULL(SUM(ISNULL(ShDols,0)),0)
				FROM ShipmentReport_Shipped_All
				WHERE ShDate>=@Year+'-03-01' 
					  AND ShDate<@Year+'-04-01' 
					  AND [Customer Name]LIKE @Customer
			)AS M3,
			(
				SELECT ISNULL(SUM(ISNULL(ShDols,0)),0)
				FROM ShipmentReport_Shipped_All
				WHERE ShDate>=@Year+'-04-01' 
					  AND ShDate<@Year+'-05-01' 
					  AND [Customer Name]LIKE @Customer
			)AS M4,
			(
				SELECT ISNULL(SUM(ISNULL(ShDols,0)),0)
				FROM ShipmentReport_Shipped_All
				WHERE ShDate>=@Year+'-05-01' 
					  AND ShDate<@Year+'-06-01' 
					  AND [Customer Name]LIKE @Customer
			)AS M5,
			(
				SELECT ISNULL(SUM(ISNULL(ShDols,0)),0)
				FROM ShipmentReport_Shipped_All
				WHERE ShDate>=@Year+'-06-01' 
					  AND ShDate<@Year+'-07-01' 
					  AND [Customer Name]LIKE @Customer
			)AS M6,
			(
				SELECT ISNULL(SUM(ISNULL(ShDols,0)),0)
				FROM ShipmentReport_Shipped_All
				WHERE ShDate>=@Year+'-07-01' 
					  AND ShDate<@Year+'-08-01' 
					  AND [Customer Name]LIKE @Customer
			)AS M7,
			(
				SELECT ISNULL(SUM(ISNULL(ShDols,0)),0)
				FROM ShipmentReport_Shipped_All
				WHERE ShDate>=@Year+'-08-01' 
					  AND ShDate<@Year+'-09-01' 
					  AND [Customer Name]LIKE @Customer
			)AS M8,
			(
				SELECT ISNULL(SUM(ISNULL(ShDols,0)),0)
				FROM ShipmentReport_Shipped_All
				WHERE ShDate>=@Year+'-09-01' 
					  AND ShDate<@Year+'-10-01' 
					  AND [Customer Name]LIKE @Customer
			)AS M9,
			(
				SELECT ISNULL(SUM(ISNULL(ShDols,0)),0)
				FROM ShipmentReport_Shipped_All
				WHERE ShDate>=@Year+'-10-01' 
					  AND ShDate<@Year+'-11-01' 
					  AND [Customer Name]LIKE @Customer
			)AS M10,
			(
				SELECT ISNULL(SUM(ISNULL(ShDols,0)),0)
				FROM ShipmentReport_Shipped_All
				WHERE ShDate>=@Year+'-11-01' 
					  AND ShDate<@Year+'-12-01' 
					  AND [Customer Name]LIKE @Customer
			)AS M11,
			(
				SELECT ISNULL(SUM(ISNULL(ShDols,0)),0)
				FROM ShipmentReport_Shipped_All
				WHERE ShDate>=@Year+'-12-01' 
					  AND ShDate<CONVERT(CHAR(4),CONVERT(INT,@Year)+1)+'-01-01' 
					  AND [Customer Name]LIKE @Customer
			) AS M12

END
GO
