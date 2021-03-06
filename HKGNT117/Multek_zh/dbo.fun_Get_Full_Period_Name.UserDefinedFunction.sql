USE [Multek_ZH]
GO
/****** Object:  UserDefinedFunction [dbo].[fun_Get_Full_Period_Name]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[fun_Get_Full_Period_Name]
(
	-- Add the parameters for the function here
	@FYear INT
	,@Period INT
)
RETURNS VARCHAR(50)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Full_Period_Name VARCHAR(50)

	-- Add the T-SQL statements to compute the return value here
	SET @Full_Period_Name=(
							CASE @Period WHEN 1 THEN 'P01FY' + substring(CONVERT(VARCHAR(4), @FYear), 3, 2) + '(Apr)' 
										WHEN 2 THEN 'P02FY' + substring(CONVERT(VARCHAR(4), @FYear), 3, 2) + '(May)' 
										WHEN 3 THEN 'P03FY' + substring(CONVERT(VARCHAR(4), @FYear), 3, 2) + '(Jun)' 
										WHEN 4 THEN 'P04FY' + substring(CONVERT(VARCHAR(4), @FYear), 3, 2) + '(Jul)' 
										WHEN 5 THEN 'P05FY' + substring(CONVERT(VARCHAR(4), @FYear), 3, 2) + '(Aug)' 
										WHEN 6 THEN 'P06FY' + substring(CONVERT(VARCHAR(4), @FYear), 3, 2) + '(Sep)' 
										WHEN 7 THEN 'P07FY' + substring(CONVERT(VARCHAR(4), @FYear), 3, 2) + '(Oct)' 
										WHEN 8 THEN 'P08FY' + substring(CONVERT(VARCHAR(4), @FYear), 3, 2) + '(Nov)' 
										WHEN 9 THEN 'P09FY' + substring(CONVERT(VARCHAR(4), @FYear), 3, 2) + '(Dec)' 
										WHEN 10 THEN 'P10FY' + substring(CONVERT(VARCHAR(4), @FYear), 3, 2) + '(Jan)' 
										WHEN 11 THEN 'P11FY' + substring(CONVERT(VARCHAR(4), @FYear), 3, 2) + '(Feb)' 
										WHEN 12 THEN 'P12FY' + substring(CONVERT(VARCHAR(4), @FYear), 3, 2) + '(Mar)'	
									ELSE ''
									END
							)

	-- Return the result of the function
	RETURN @Full_Period_Name

END


GO
