USE [Multek_ZH]
GO
/****** Object:  UserDefinedFunction [dbo].[KOI_fun_Get_Periodly_ASP_ALC_PPL_SQL_String]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
create FUNCTION [dbo].[KOI_fun_Get_Periodly_ASP_ALC_PPL_SQL_String]
(
	-- Add the parameters for the function here
	@ReportCode VARCHAR(3),
	@Year VARCHAR(4),
	@Period SMALLINT ,
	@Plant NVARCHAR(50),
	@Sale NVARCHAR(50),
	@ASP NUMERIC(18,2),
	@ALC NUMERIC(18,2),
	@PPL NUMERIC(18,2)
)
RETURNS VARCHAR(MAX)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ReturnString VARCHAR(MAX)

	-- Add the T-SQL statements to compute the return value here
	SET @ReturnString=''
	SET @ReturnString=@ReturnString+'			IF NOT EXISTS(SELECT * FROM KOI_Periodly_ASP_ALC_PPL WHERE ReportCode='+''''+@ReportCode+''''+' AND Year='+''''+@Year+''''+' AND Period='+CONVERT(VARCHAR(3),@Period)+' AND Plant='+''''+@Plant+''''+' AND Sale='+''''+@Sale+''''+') '
	SET @ReturnString=@ReturnString+'				BEGIN '
	SET @ReturnString=@ReturnString+'					INSERT INTO KOI_Periodly_ASP_ALC_PPL(ReportCode,Year,Period,Plant,Sale,ASP,ALC,PPL)'
	SET @ReturnString=@ReturnString+'						VALUES('+''''+@ReportCode+''''+','+''''+@Year+''''+','+CONVERT(VARCHAR(3),@Period)+','+''''+@Plant+''''+','+''''+@Sale+''''+',0,0,0)'
	SET @ReturnString=@ReturnString+'				END'
	SET @ReturnString=@ReturnString+'			UPDATE KOI_Periodly_ASP_ALC_PPL'
	SET @ReturnString=@ReturnString+'			SET ASP='+''''+CONVERT(VARCHAR(50),@ASP)+''''+',ALC='+''''+CONVERT(VARCHAR(50),@ALC)+''''+',PPL='+''''+CONVERT(VARCHAR(50),@PPL)+''''+' '
	SET @ReturnString=@ReturnString+'			WHERE ReportCode='+''''+@ReportCode+''''+' AND Year='+''''+@Year+''''+' AND Period='+CONVERT(VARCHAR(3),@Period)+'  AND Plant='+''''+@Plant+''' AND Sale='+''''+@Sale+''' '

	-- Return the result of the function
	RETURN (ISNULL(@ReturnString,''))

END





GO
