USE [Multek_ZH]
GO
/****** Object:  UserDefinedFunction [dbo].[VI_Report_fun_Get_Weekly_Fiscal_SQL_String]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create FUNCTION [dbo].[VI_Report_fun_Get_Weekly_Fiscal_SQL_String]
(
	-- Add the parameters for the function here	
	@Year VARCHAR(4),
	@Week SMALLINT ,
	@FiscalWeekDesc VARCHAR(50),
	@Loc VARCHAR(10),
	@Amount NUMERIC(18,2)
)
RETURNS VARCHAR(MAX)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ReturnString VARCHAR(MAX)

	-- Add the T-SQL statements to compute the return value here
	SET @ReturnString=''
	SET @ReturnString=@ReturnString+'			IF NOT EXISTS(SELECT * FROM VI_Report_Weekly WHERE Year='+''''+@Year+''''+' AND Week='+CONVERT(VARCHAR(3),@Week)+' AND WeekDesc='+''''+@FiscalWeekDesc+''''+' AND Loc='+''''+@Loc+''''+') '
	SET @ReturnString=@ReturnString+'				BEGIN '
	SET @ReturnString=@ReturnString+'					INSERT INTO VI_Report_Weekly(Year,Week,WeekDesc,Loc,Amount)'
	SET @ReturnString=@ReturnString+'						VALUES('+''''+@Year+''''+','+CONVERT(VARCHAR(3),@Week)+','+''''+@FiscalWeekDesc+''''+','+''''+@Loc+''''+',0)'
	SET @ReturnString=@ReturnString+'				END'
	SET @ReturnString=@ReturnString+'			UPDATE VI_Report_Weekly'
	SET @ReturnString=@ReturnString+'			SET Amount='+CONVERT(VARCHAR(50),@Amount)
	SET @ReturnString=@ReturnString+'			WHERE Year='+''''+@Year+''''+' AND Week='+CONVERT(VARCHAR(3),@Week)+' AND WeekDesc='+''''+@FiscalWeekDesc+''''+' AND Loc='+''''+@Loc+''''

	-- Return the result of the function
	RETURN (ISNULL(@ReturnString,''))

END




GO
