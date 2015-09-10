USE [Multek_SZ_New]
GO
/****** Object:  UserDefinedFunction [dbo].[ShipmentReport_fun_Get_TOP_20_Customer_OEM_By_LocPlant]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[ShipmentReport_fun_Get_TOP_20_Customer_OEM_By_LocPlant]
(	
	-- Add the parameters for the function here
	@OEMCustomer VARCHAR(20),
	@Site VARCHAR(10),
	@Plant VARCHAR(10),
	@DateFrom DATETIME,
	@DateTo DATETIME
)
RETURNS @ReturnTable TABLE 
(
	OEMCustomer VARCHAR(500),
	Amount BIGINT
)
AS
BEGIN
	-- Fill the table variable with the rows for your result set
	--SET @Plant=@Plant+'%'
	
	IF @OEMCustomer='Customer'
		BEGIN
			INSERT INTO @ReturnTable
			SELECT TOP 20 Real_Customer AS OEMCustomer,SUM(SHDOLS) AS Amount
			FROM dbo.ShipmentReport_Shipped_All
			WHERE SHDate BETWEEN @DateFrom AND @DateTo
				AND Loc=@Site
				AND Plant=@Plant
				AND Real_Customer>''
			GROUP BY Real_Customer
			ORDER BY SUM(SHDOLS) DESC
		END
	IF @OEMCustomer='OEM'
		BEGIN
			INSERT INTO @ReturnTable
			SELECT TOP 20 Real_OEM AS OEMCustomer,SUM(SHDOLS) AS Amount
			FROM dbo.ShipmentReport_Shipped_All
			WHERE SHDate BETWEEN @DateFrom AND @DateTo
				AND Loc=@Site
				AND Plant=@Plant
				AND Real_OEM>''
			GROUP BY Real_OEM
			ORDER BY SUM(SHDOLS) DESC
		END
	
	UPDATE @ReturnTable
	SET OEMCustomer=dbo.ShipmentReport_fun_Valid_SQL_String(OEMCustomer)
	
	RETURN 
END
GO
