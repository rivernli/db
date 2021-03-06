USE [Multek_SZ_New]
GO
/****** Object:  UserDefinedFunction [dbo].[ShipmentReport_fun_Get_Sum_By_Year_Site_Customer]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[ShipmentReport_fun_Get_Sum_By_Year_Site_Customer]
(
	-- Add the parameters for the function here
	@DateFrom DATETIME,
	@DateTo DATETIME,
	@Site VARCHAR(50)=NULL,
	@Customer VARCHAR(300)=NULL,
	@Plant VARCHAR(10)

)
RETURNS NUMERIC(19,2)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Sum NUMERIC(19,2)
	-- Add the T-SQL statements to compute the return value here
	SET @Sum=(
				SELECT ISNULL(SUM(ISNULL(ShDols,0)),0)
				FROM ShipmentReport_Shipped_All
				WHERE ShDate>=@DateFrom
					  AND ShDate<@DateTo
					  AND Loc =@Site
					  AND Real_Customer=@Customer
					  AND ISNULL(Plant,'') LIKE @Plant
			  )
	-- Return the result of the function
	RETURN (@Sum)

END
GO
