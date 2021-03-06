USE [Multek_SZ_New]
GO
/****** Object:  UserDefinedFunction [dbo].[ShipmentReport_fun_Get_Amount]    Script Date: 11/06/2014 15:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[ShipmentReport_fun_Get_Amount]
(
	-- Add the parameters for the function here
	@Site VARCHAR(10),
	@Plant VARCHAR(10),
	@Layer VARCHAR(10),
	@DateFrom DATETIME,
	@DateTo DATETIME
)
RETURNS BIGINT
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ReturnValue NUMERIC(18,0)


	SET @Site='%'+LTRIM(RTRIM(@Site))+'%'
	SET @Plant='%'+LTRIM(RTRIM(@Plant))+'%'

-- Add the T-SQL statements to compute the return value here
	IF @Layer=''	
		BEGIN
				IF @Site='%NFD%'
					BEGIN
						SET @ReturnValue=(SELECT SUM(InvoicedDollarsInUSD)
										FROM NorthfieldSalesDataupdateshippeddate
										WHERE ShippedDate1 BETWEEN @DateFrom AND @DateTo
										)
					END
				ELSE
					BEGIN
						SET @ReturnValue=(
										SELECT SUM(SHDols) 
										FROM ShipmentReport_Shipped_All 
										WHERE Loc LIKE @Site
											AND Plant LIKE @Plant
											--AND Lays LIKE @Layer
											AND SHDate BETWEEN @DateFrom AND @DateTo
									 )
					END
				
		END
	ELSE
		BEGIN
				IF @Site='%NFD%'
					BEGIN
						SET @ReturnValue=(SELECT SUM(InvoicedDollarsInUSD)
										FROM NorthfieldSalesDataupdateshippeddate
										WHERE CONVERT(INT,BusUnitNo) = @Layer
											AND ShippedDate1 BETWEEN @DateFrom AND @DateTo
										)
					END
				ELSE
					BEGIN
						SET @ReturnValue=(
										SELECT SUM(SHDols) 
										FROM ShipmentReport_Shipped_All --WITH(INDEX (LOCPLANTSHDATELAYER))
										WHERE Lays = @Layer
											AND Loc LIKE @Site
											AND Plant LIKE @Plant	
											AND SHDate BETWEEN @DateFrom AND @DateTo
									 )
					END
		END
	

	-- Return the result of the function
	RETURN ISNULL(@ReturnValue,0)

END
GO
