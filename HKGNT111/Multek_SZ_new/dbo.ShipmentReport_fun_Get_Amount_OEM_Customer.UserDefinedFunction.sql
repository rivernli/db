USE [Multek_SZ_New]
GO
/****** Object:  UserDefinedFunction [dbo].[ShipmentReport_fun_Get_Amount_OEM_Customer]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[ShipmentReport_fun_Get_Amount_OEM_Customer]
(
	-- Add the parameters for the function here
	@Option VARCHAR(10),
	@OEMCustomer VARCHAR(300),
	@Loc VARCHAR(10),
	@Plant VARCHAR(10),
	@DateFrom DATETIME,
	@DateTo DATETIME
)
RETURNS BIGINT
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ReturnValue BIGINT

	--SET @Plant='%'+RTRIM(LTRIM(@Plant))+'%'
	-- Add the T-SQL statements to compute the return value here
	IF @Option='Customer' AND @Plant<>''
		BEGIN
			IF @Loc='NFD'
				BEGIN
					SET @ReturnValue=(
									SELECT SUM(InvoicedDollarsInUSD)
									FROM NorthfieldSalesDataupdateShippedDate
									WHERE FlexCustName=@OEMCustomer
										AND ShippedDate1 BETWEEN @DateFrom AND @DateTo
								    )
				END
			ELSE
				BEGIN
					SET @ReturnValue=(
									SELECT SUM(SHDols) 
									FROM ShipmentReport_Shipped_All 
									WHERE Loc = @Loc
										AND Plant = @Plant
										AND Real_Customer=@OEMCustomer
										AND SHDate BETWEEN @DateFrom AND @DateTo
								 )
				END
		END
	IF @Option='Customer' AND @Plant=''
		BEGIN
			IF @Loc='NFD'
				BEGIN
					SET @ReturnValue=(
									SELECT SUM(InvoicedDollarsInUSD)
									FROM NorthfieldSalesDataupdateShippedDate
									WHERE FlexCustName=@OEMCustomer
										AND ShippedDate1 BETWEEN @DateFrom AND @DateTo
								    )
				END
			ELSE
				BEGIN
					SET @ReturnValue=(
									SELECT SUM(SHDols) 
									FROM ShipmentReport_Shipped_All 
									WHERE Loc = @Loc
										--AND Plant LIKE @Plant
										AND Real_Customer=@OEMCustomer
										AND SHDate BETWEEN @DateFrom AND @DateTo
								 )
				END
		END
	IF @Option='OEM' AND @Plant<>''
		BEGIN
			SET @ReturnValue=(
							SELECT SUM(SHDols) 
							FROM ShipmentReport_Shipped_All 
							WHERE Loc = @Loc
								AND Plant = @Plant
								AND Real_OEM=@OEMCustomer
								AND SHDate BETWEEN @DateFrom AND @DateTo
						 )
		END
	IF @Option='OEM' AND @Plant=''
		BEGIN
			SET @ReturnValue=(
							SELECT SUM(SHDols) 
							FROM ShipmentReport_Shipped_All 
							WHERE Loc = @Loc
								--AND Plant = @Plant
								AND Real_OEM=@OEMCustomer
								AND SHDate BETWEEN @DateFrom AND @DateTo
						 )
		END
	-- Return the result of the function
	RETURN (ISNULL(@ReturnValue,0))

END
GO
