USE [Multek_ZH]
GO
/****** Object:  UserDefinedFunction [dbo].[EXR2_New_fun_standard_cost]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[EXR2_New_fun_standard_cost]
(
	-- Add the parameters for the function here
	@temp_pjno	NVARCHAR(10),
	@temp_sern	INT
)
RETURNS DECIMAL(18,4)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ret_stand_cost DECIMAL(18,4),@unitNum	INT

	-- Add the T-SQL statements to compute the return value here
	SET @unitNum =  1

	SELECT TOP 1 @unitNum = t$unst * t$cbpn FROM FactoryLoading.dbo.TFSAMI002180 
	WHERE	left(t$pjno,10) = @temp_pjno
	ORDER BY T$SIDE ASC

	SET @unitNum = ISNULL(@unitNum,1)
	IF @unitNum = 0 
		BEGIN
			SET @unitNum = 1
		END

	SELECT	@ret_stand_cost = SUM(cast(BOMCOST AS DECIMAL(18,4)))	FROM	FactoryLoading.dbo.TFSBOM421180
	WHERE	T$PJNO = @temp_pjno	AND		T$SERN = @temp_sern

	SET @ret_stand_cost = ISNULL(@ret_stand_cost,0)
	SET @ret_stand_cost = CAST((@ret_stand_cost/@unitNum) AS DECIMAL(18,4))

	-- Return the result of the function
	RETURN @ret_stand_cost

END

GO
