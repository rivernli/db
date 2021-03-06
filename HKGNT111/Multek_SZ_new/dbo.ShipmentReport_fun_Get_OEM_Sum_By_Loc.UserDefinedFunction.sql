USE [Multek_SZ_New]
GO
/****** Object:  UserDefinedFunction [dbo].[ShipmentReport_fun_Get_OEM_Sum_By_Loc]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[ShipmentReport_fun_Get_OEM_Sum_By_Loc] 
(
	-- Add the parameters for the function here
	@Year CHAR(4),
	@OEM VARCHAR(500),
	@Loc VARCHAR(3),
	@Plant VARCHAR(10)
)
RETURNS NUMERIC(19,2)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Amount NUMERIC(19,2),@DateFrom DATETIME,@DateTo DATETIME

	-- Add the T-SQL statements to compute the return value here
	SET @DateFrom=@Year+'-01-01' 
	SET @DateTo=CONVERT(CHAR(4),CONVERT(INT,@Year)+1)+'-01-01' 

	SET @Amount=(
					SELECT ISNULL(SUM(ISNULL(a.ShDols,0)),0) AS Amount
					FROM ShipmentReport_Shipped_All a
					WHERE a.ShDate>=@DateFrom
					    AND a.ShDate<@DateTo
						AND a.Loc=@Loc
						AND a.Plant=@Plant
						AND a.Real_OEM=@OEM
				)

	RETURN (ISNULL(@Amount,0))
END
GO
