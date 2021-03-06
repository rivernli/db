USE [Multek_ZH]
GO
/****** Object:  UserDefinedFunction [dbo].[VI_Report_fun_Get_Amount]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE FUNCTION [dbo].[VI_Report_fun_Get_Amount] 
(
	-- Add the parameters for the function here		
	@Loc varchar(10),
	@DateFrom DATETIME,
	@DateTo DATETIME
)
RETURNS BIGINT
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ReturnValue NUMERIC(18,0)	

			SET @ReturnValue=(
									SELECT SUM(SHDols) 
									FROM VI_Report_Shipped_All 
									WHERE  Loc = @Loc 
										AND SHDate BETWEEN @DateFrom AND @DateTo
							)

	-- Return the result of the function
	RETURN ABS(ISNULL(@ReturnValue,0))

END 




GO
