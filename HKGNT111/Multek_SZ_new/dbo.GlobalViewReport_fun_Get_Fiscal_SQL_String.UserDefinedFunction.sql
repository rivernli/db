USE [Multek_SZ_New]
GO
/****** Object:  UserDefinedFunction [dbo].[GlobalViewReport_fun_Get_Fiscal_SQL_String]    Script Date: 11/06/2014 15:47:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GlobalViewReport_fun_Get_Fiscal_SQL_String]
(
	-- Add the parameters for the function here
	@ReportCode CHAR(3),
	@Plant VARCHAR(50),
	@FiscalYear VARCHAR(4),
	@FiscalWeek INT,
	@FiscalWeekDesc VARCHAR(50),
	@Amount NUMERIC(18,2)
)
RETURNS VARCHAR(MAX)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ReturnString VARCHAR(MAX)

	-- Add the T-SQL statements to compute the return value here
	SET @ReturnString=''
	SET @ReturnString=@ReturnString+'			IF NOT EXISTS(SELECT * FROM GlobalViewReport_B2B WHERE ReportCode='+''''+@ReportCode+''''+' AND Year='+''''+@FiscalYear+''''+' AND WeekNo='+''''+CONVERT(VARCHAR(10),@FiscalWeek)+''''+' AND WeekDesc='+''''+@FiscalWeekDesc+''''+') '
	SET @ReturnString=@ReturnString+'				BEGIN '
	SET @ReturnString=@ReturnString+'					INSERT INTO GlobalViewReport_B2B(Year,WeekNo,WeekDesc,ReportCode,B1,B2F,B3,B4,B5,VVI,TotalNotVVI,TOTAL)'
	SET @ReturnString=@ReturnString+'						VALUES('+''''+@FiscalYear+''''+','+''''+CONVERT(VARCHAR(10),@FiscalWeek)+''''+','+''''+@FiscalWeekDesc+''''+','+''''+@ReportCode+''''+',0,0,0,0,0,0,0,0)'
	SET @ReturnString=@ReturnString+'				END'
	SET @ReturnString=@ReturnString+'			UPDATE GlobalViewReport_B2B'
	SET @ReturnString=@ReturnString+'			SET '+@Plant+'='+CONVERT(VARCHAR(50),@Amount)
	SET @ReturnString=@ReturnString+'			WHERE ReportCode='+''''+@ReportCode+''''+' AND Year='+''''+@FiscalYear+''''+' AND WeekNo='+''''+CONVERT(VARCHAR(10),@FiscalWeek)+''''+' AND WeekDesc='+''''+@FiscalWeekDesc+''''

	-- Return the result of the function
	RETURN (ISNULL(@ReturnString,''))

END
GO
