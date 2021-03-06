USE [Multek_ZH]
GO
/****** Object:  UserDefinedFunction [dbo].[Cancellation_Charge_fun_Query_CostSheet]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[Cancellation_Charge_fun_Query_CostSheet]
(
@Item	NVARCHAR(35),
@Plant	NVARCHAR(3)
)
RETURNS DECIMAL(18,4)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Return_Value	DECIMAL(18,4)

	SET @ITEM = ISNULL(@ITEM,'')
	SET @PLANT = ISNULL(@PLANT,'')
	SET @Return_Value = 0

	-- Add the T-SQL statements to compute the return value here
	SELECT TOP 1 @Return_Value = t$cesu from FactoryLoading.dbo.TFSBOM400180 where t$plnt = @plant and LEFT(T$PJNO,8) = ltrim(rtrim(@Item))

	-- Return the result of the function
	SET @Return_Value = ISNULL(@Return_Value,0)
	RETURN @Return_Value

END

GO
