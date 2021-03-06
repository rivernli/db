USE [Multek_ZH]
GO
/****** Object:  UserDefinedFunction [dbo].[Cancellation_Charge_fun_Query_WIP_CostSheet]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[Cancellation_Charge_fun_Query_WIP_CostSheet]
(
@item			NVARCHAR(35),
@work_center	NVARCHAR(3),
@plant			NVARCHAR(2)
)
RETURNS DECIMAL(18,4)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @wip_cost	DECIMAL(18,4)

	-- Add the T-SQL statements to compute the return value here
	SELECT TOP 1 @wip_cost= T$AMTR FROM dbo.Cancellation_Charge_WIP_CostSheet 
	WHERE T$PLNT= @PLANT 
	AND T$PJNO	= @ITEM 
	AND T$CWOC	= @work_center 
	ORDER BY T$PONO DESC

	-- Return the result of the function
	RETURN @wip_cost

END

GO
