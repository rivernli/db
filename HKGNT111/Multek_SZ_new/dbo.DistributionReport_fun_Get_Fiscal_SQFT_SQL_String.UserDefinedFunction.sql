USE [Multek_SZ_New]
GO
/****** Object:  UserDefinedFunction [dbo].[DistributionReport_fun_Get_Fiscal_SQFT_SQL_String]    Script Date: 11/06/2014 15:47:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[DistributionReport_fun_Get_Fiscal_SQFT_SQL_String]
(
	-- Add the parameters for the function here
	@Year CHAR(4),
	@Month INT,
	@Type VARCHAR(10),
	@Site VARCHAR(50),
	@Plant VARCHAR(50),
	@ReportCode CHAR(3),
	@Amount NUMERIC(19,2)
)
RETURNS VARCHAR(MAX)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ReturnString VARCHAR(MAX)

	-- Add the T-SQL statements to compute the return value here
	SET @Amount=ISNULL(@Amount,0)
	SET @ReturnString=''
	SET @ReturnString=@ReturnString+'			IF NOT EXISTS(SELECT * FROM DistribitionReport_SQFT_Fiscal WHERE ReportCode='+''''+@ReportCode+''''+' AND Type='+''''+@Type+''''+' AND Site='+''''+@Site+''''+'AND Plant='+''''+@Plant+''''+' AND Year='+''''+@Year+''''+')'
	SET @ReturnString=@ReturnString+'				BEGIN '
	SET @ReturnString=@ReturnString+'					INSERT INTO DistribitionReport_SQFT_Fiscal(ReportCode,Type,Site,Plant,Year,M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12)'
	SET @ReturnString=@ReturnString+'						VALUES('+''''+@ReportCode+''''+','+''''+@Type+''''+','+''''+@Site+''''+','+''''+@Plant+''''+','+''''+@Year+''''+',0,0,0,0,0,0,0,0,0,0,0,0)'
	SET @ReturnString=@ReturnString+'				END'
	SET @ReturnString=@ReturnString+'			UPDATE DistribitionReport_SQFT_Fiscal'
	SET @ReturnString=@ReturnString+'			SET M'+CONVERT(VARCHAR(2),@Month)+'='+CONVERT(VARCHAR(50),@Amount)
	SET @ReturnString=@ReturnString+'			WHERE ReportCode='+''''+@ReportCode+''''+' AND Type='+''''+@Type+''''+' AND Site='+''''+@Site+''''+' AND Plant='+''''+@Plant+''''+' AND Year='+''''+@Year+''''

	-- Return the result of the function
	RETURN (ISNULL(@ReturnString,''))

END
GO
