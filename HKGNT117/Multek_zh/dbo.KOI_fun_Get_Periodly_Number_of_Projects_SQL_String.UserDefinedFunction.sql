USE [Multek_ZH]
GO
/****** Object:  UserDefinedFunction [dbo].[KOI_fun_Get_Periodly_Number_of_Projects_SQL_String]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
create FUNCTION [dbo].[KOI_fun_Get_Periodly_Number_of_Projects_SQL_String]
(
	-- Add the parameters for the function here
	@ReportCode VARCHAR(3),
	@Year VARCHAR(4),
	@Period SMALLINT ,
	@Plant NVARCHAR(50),	
	@Sale NVARCHAR(50),	
	@Over1000Sqft INT,
	@To501_1000Sqft INT,
	@To301_500Sqft INT,
	@To101_300Sqft INT,
	@To100Sqft INT,
	@Total INT
)
RETURNS VARCHAR(MAX)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ReturnString VARCHAR(MAX)

	-- Add the T-SQL statements to compute the return value here
	SET @ReturnString=''
	SET @ReturnString=@ReturnString+'			IF NOT EXISTS(SELECT * FROM KOI_Periodly_Number_of_Projects WHERE ReportCode='+''''+@ReportCode+''''+' AND Year='+''''+@Year+''''+' AND Period='+CONVERT(VARCHAR(3),@Period)+' AND Plant='+''''+@Plant+''''+' AND Sale='+''''+@Sale+''''+' ) '
	SET @ReturnString=@ReturnString+'				BEGIN '
	SET @ReturnString=@ReturnString+'					INSERT INTO KOI_Periodly_Number_of_Projects(ReportCode,Year,Period,Plant,Sale,Over1000Sqft,To501_1000Sqft,To301_500Sqft,To101_300Sqft,To100Sqft,Total)'
	SET @ReturnString=@ReturnString+'						VALUES('+''''+@ReportCode+''''+','+''''+@Year+''''+','+CONVERT(VARCHAR(3),@Period)+','+''''+@Plant+''''+','+''''+@Sale+''''+',0,0,0,0,0,0)'
	SET @ReturnString=@ReturnString+'				END'
	SET @ReturnString=@ReturnString+'			UPDATE KOI_Periodly_Number_of_Projects'
	SET @ReturnString=@ReturnString+'			SET Over1000Sqft='+''''+CONVERT(VARCHAR(50),@Over1000Sqft)+''''+',To501_1000Sqft='+''''+CONVERT(VARCHAR(50),@To501_1000Sqft)+''''+',To301_500Sqft='+''''+CONVERT(VARCHAR(50),@To301_500Sqft)+''''+',To101_300Sqft='+''''+CONVERT(VARCHAR(50),@To101_300Sqft)+''''+',To100Sqft='+''''+CONVERT(VARCHAR(50),@To100Sqft)+''''+',Total='+''''+CONVERT(VARCHAR(50),@Total)+''''+' '
	SET @ReturnString=@ReturnString+'			WHERE ReportCode='+''''+@ReportCode+''''+' AND Year='+''''+@Year+''''+' AND Period='+CONVERT(VARCHAR(3),@Period)+'  AND Plant='+''''+@Plant+''' AND Sale='+''''+@Sale+''' '

	-- Return the result of the function
	RETURN (ISNULL(@ReturnString,''))

END







GO
