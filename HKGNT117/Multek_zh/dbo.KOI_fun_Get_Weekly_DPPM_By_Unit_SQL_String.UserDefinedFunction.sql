USE [Multek_ZH]
GO
/****** Object:  UserDefinedFunction [dbo].[KOI_fun_Get_Weekly_DPPM_By_Unit_SQL_String]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[KOI_fun_Get_Weekly_DPPM_By_Unit_SQL_String]
(
	-- Add the parameters for the function here
	@ReportCode VARCHAR(3),
	@Year VARCHAR(4),
	@Week SMALLINT , 
	@Plant VARCHAR(50),
	@Amount NUMERIC(18,2)
)
RETURNS VARCHAR(MAX)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ReturnString VARCHAR(MAX)

	-- Add the T-SQL statements to compute the return value here
	SET @ReturnString=''
	SET @ReturnString=@ReturnString+'			IF NOT EXISTS(SELECT * FROM KOI_Weekly_DPPM_by_unit WHERE ReportCode='+''''+@ReportCode+''''+' AND Year='+''''+@Year+''''+' AND Week='+CONVERT(VARCHAR(3),@Week)+' AND Plant='+''''+@Plant+''''+') '
	SET @ReturnString=@ReturnString+'				BEGIN '
	SET @ReturnString=@ReturnString+'					INSERT INTO KOI_Weekly_DPPM_by_unit(ReportCode,Year,Week,Plant,Unit)'
	SET @ReturnString=@ReturnString+'						VALUES('+''''+@ReportCode+''''+','+''''+@Year+''''+','+CONVERT(VARCHAR(3),@Week)+','+''''+@Plant+''''+',0)'
	SET @ReturnString=@ReturnString+'				END'
	SET @ReturnString=@ReturnString+'			UPDATE KOI_Weekly_DPPM_by_unit'
	SET @ReturnString=@ReturnString+'			SET Unit='+CONVERT(VARCHAR(50),@Amount)
	SET @ReturnString=@ReturnString+'			WHERE ReportCode='+''''+@ReportCode+''''+' AND Year='+''''+@Year+''''+' AND Week='+CONVERT(VARCHAR(3),@Week)+' AND Plant='+''''+@Plant+''''

	-- Return the result of the function
	RETURN (ISNULL(@ReturnString,''))

END





GO
