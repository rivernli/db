USE [BOC]
GO
/****** Object:  UserDefinedFunction [dbo].[fun_Get_Full_Period_Name]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[fun_Get_Full_Period_Name]
(
	-- Add the parameters for the function here
	@Period INT
)
RETURNS VARCHAR(50)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Full_Period_Name VARCHAR(50)

	-- Add the T-SQL statements to compute the return value here
	SET @Full_Period_Name=(
							CASE @Period WHEN 1 THEN 'Apr(P1)' 
										WHEN 2 THEN 'May(P2)' 
										WHEN 3 THEN 'Jun(P3)' 
										WHEN 4 THEN 'Jul(P4)' 
										WHEN 5 THEN 'Aug(P5)' 
										WHEN 6 THEN 'Sep(P6)' 
										WHEN 7 THEN 'Oct(P7)' 
										WHEN 8 THEN 'Nov(P8)' 
										WHEN 9 THEN 'Dec(P9)' 
										WHEN 10 THEN 'Jan(P10)' 
										WHEN 11 THEN 'Feb(P11)' 
										WHEN 12 THEN 'Mar(P12)'	
									ELSE ''
									END
							)

	-- Return the result of the function
	RETURN @Full_Period_Name

END



GO
