USE [Multek_ZH]
GO
/****** Object:  UserDefinedFunction [dbo].[KOI_fun_Get_Yearly_Revenue_by_Technology_SQL_String]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[KOI_fun_Get_Yearly_Revenue_by_Technology_SQL_String]
(
	-- Add the parameters for the function here
	@ReportCode VARCHAR(4),	
	@Sale NVARCHAR(20),
	@Year VARCHAR(4),	
	@Plant NVARCHAR(50),
	@Technology NVARCHAR(200),
	@Amount float 
)
RETURNS VARCHAR(MAX)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ReturnString VARCHAR(MAX)

	-- Add the T-SQL statements to compute the return value here
	SET @ReturnString=''
	SET @ReturnString=@ReturnString+'			IF NOT EXISTS(SELECT * FROM KOI_Yearly_Revenue_by_Technology WHERE ReportCode='+''''+@ReportCode+''''+' AND Sale='+''''+@Sale+''''+' AND Year='+''''+@Year+''''+' AND Plant='+''''+@Plant+''''+' AND Technology='+''''+@Technology+''''+') '
	SET @ReturnString=@ReturnString+'				BEGIN '
	SET @ReturnString=@ReturnString+'					INSERT INTO KOI_Yearly_Revenue_by_Technology(ReportCode,Sale,Year,Plant,Technology,Revenue)'
	SET @ReturnString=@ReturnString+'						VALUES('+''''+@ReportCode+''''+','+''''+@Sale+''''+','+''''+@Year+''''+','+''''+@Plant+''''+','+''''+@Technology+''''+',0)'
	SET @ReturnString=@ReturnString+'				END'
	SET @ReturnString=@ReturnString+'			UPDATE KOI_Yearly_Revenue_by_Technology'
	SET @ReturnString=@ReturnString+'			SET Revenue='+CONVERT(VARCHAR(50),@Amount)
	SET @ReturnString=@ReturnString+'			WHERE ReportCode='+''''+@ReportCode+''''+' AND Sale='+''''+@Sale+''''+' AND Year='+''''+@Year+''''+' AND Technology='+''''+@Technology+''''+'  AND Plant='+''''+@Plant+''''

	-- Return the result of the function
	RETURN (ISNULL(@ReturnString,''))

END







GO
