USE [Multek_ZH]
GO
/****** Object:  UserDefinedFunction [dbo].[KOI_fun_Get_Periodly_Productivity_Image_Layer_SQL_String]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[KOI_fun_Get_Periodly_Productivity_Image_Layer_SQL_String]
(
	-- Add the parameters for the function here
	@Year VARCHAR(4),
	@Period SMALLINT ,
	@Plant VARCHAR(50),
	@Sale NVARCHAR(50), 
	@WorkingHours NUMERIC(18,2),
	@Headcount NUMERIC(18,2),
	@ALC NUMERIC(18,2),
	@FGOut_sqft NUMERIC(18,2),
	@Efficiency NUMERIC(18,2)
)
RETURNS VARCHAR(MAX)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ReturnString VARCHAR(MAX)

	-- Add the T-SQL statements to compute the return value here
SET @ReturnString=''
	SET @ReturnString=@ReturnString+'			IF NOT EXISTS(SELECT * FROM KOI_Periodly_Productivity_Image_Layer WHERE Year='+''''+@Year+''''+' AND Sale='+''''+@Sale+''''+' AND Period='+CONVERT(VARCHAR(3),@Period)+' AND Plant='+''''+@Plant+''''+' ) '
	SET @ReturnString=@ReturnString+'				BEGIN '
	SET @ReturnString=@ReturnString+'					INSERT INTO KOI_Periodly_Productivity_Image_Layer(Year,Period,Plant,Sale,WorkingHours,Headcount,ALC,FGOut_sqft,Efficiency)'
	SET @ReturnString=@ReturnString+'						VALUES('+''''+@Year+''''+','+CONVERT(VARCHAR(3),@Period)+','+''''+@Plant+''''+','+''''+@Sale+''''+',0,0,0,0,0)'
	SET @ReturnString=@ReturnString+'				END'
	SET @ReturnString=@ReturnString+'			UPDATE KOI_Periodly_Productivity_Image_Layer'
	SET @ReturnString=@ReturnString+'			SET WorkingHours='+''''+CONVERT(VARCHAR(50),@WorkingHours)+''''+',Headcount='+''''+CONVERT(VARCHAR(50),@Headcount)+''''+',ALC='+''''+CONVERT(VARCHAR(50),@ALC)+''''+',FGOut_sqft='+''''+CONVERT(VARCHAR(50),@FGOut_sqft)+''''+',Efficiency='+''''+CONVERT(VARCHAR(50),@Efficiency)+''''+' '
	SET @ReturnString=@ReturnString+'			WHERE Year='+''''+@Year+''''+' AND Period='+CONVERT(VARCHAR(3),@Period)+' AND Plant='+''''+@Plant+''' AND Sale='+''''+@Sale+''''+' '

	-- Return the result of the function
	RETURN (ISNULL(@ReturnString,''))

END











GO
