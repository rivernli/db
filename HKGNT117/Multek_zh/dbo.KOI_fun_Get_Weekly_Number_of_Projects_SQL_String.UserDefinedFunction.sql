USE [Multek_ZH]
GO
/****** Object:  UserDefinedFunction [dbo].[KOI_fun_Get_Weekly_Number_of_Projects_SQL_String]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
create FUNCTION [dbo].[KOI_fun_Get_Weekly_Number_of_Projects_SQL_String]
(
	-- Add the parameters for the function here
	@ReportCode VARCHAR(3),
	@Year VARCHAR(4),
	@Week SMALLINT ,
	@Plant VARCHAR(50),
	@Sale nvarchar(50),
	@Over1000Sqft int,
	@To501_1000Sqft int,
	@To301_500Sqft int,
	@To101_300Sqft int,
	@To100Sqft int,
	@Total int
)
RETURNS VARCHAR(MAX)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ReturnString VARCHAR(MAX)

	-- Add the T-SQL statements to compute the return value here
	SET @ReturnString=''
	SET @ReturnString=@ReturnString+'			IF NOT EXISTS(SELECT * FROM KOI_Weekly_Number_of_Projects WHERE ReportCode='+''''+@ReportCode+''''+' AND Year='+''''+@Year+''''+' AND Week='+CONVERT(VARCHAR(3),@Week)+' AND Plant='+''''+@Plant+''''+' AND Sale='+''''+@Sale+''''+' ) '
	SET @ReturnString=@ReturnString+'				BEGIN '
	SET @ReturnString=@ReturnString+'					INSERT INTO KOI_Weekly_Number_of_Projects(ReportCode,Year,Week,Plant,Sale,Over1000Sqft,To501_1000Sqft,To301_500Sqft,To101_300Sqft,To100Sqft,Total)'
	SET @ReturnString=@ReturnString+'						VALUES('+''''+@ReportCode+''''+','+''''+@Year+''''+','+CONVERT(VARCHAR(3),@Week)+','+''''+@Plant+''''+','+''''+@Sale+''''+',0,0,0,0,0,0)'
	SET @ReturnString=@ReturnString+'				END'
	SET @ReturnString=@ReturnString+'			UPDATE KOI_Weekly_Number_of_Projects'
	SET @ReturnString=@ReturnString+'			SET Over1000Sqft='+''''+CONVERT(VARCHAR(50),@Over1000Sqft)+''''+',To501_1000Sqft='+''''+CONVERT(VARCHAR(50),@To501_1000Sqft)+''''+',To301_500Sqft='+''''+CONVERT(VARCHAR(50),@To301_500Sqft)+''''+',To101_300Sqft='+''''+CONVERT(VARCHAR(50),@To101_300Sqft)+''''+',To100Sqft='+''''+CONVERT(VARCHAR(50),@To100Sqft)+''''+',Total='+''''+CONVERT(VARCHAR(50),@Total)+''''+' ' 
	SET @ReturnString=@ReturnString+'			WHERE ReportCode='+''''+@ReportCode+''''+' AND Year='+''''+@Year+''''+' AND Week='+CONVERT(VARCHAR(3),@Week)+' AND Plant='+''''+@Plant+''' AND Sale='+''''+@Sale+''' '

	-- Return the result of the function
	RETURN (ISNULL(@ReturnString,''))

END







GO
