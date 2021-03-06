USE [Multek_SZ_New]
GO
/****** Object:  UserDefinedFunction [dbo].[SalesAnalysis_fun_Get_Fiscal_SQL_For_OEMCustomerLayer_String]    Script Date: 11/06/2014 15:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[SalesAnalysis_fun_Get_Fiscal_SQL_For_OEMCustomerLayer_String]
(
	-- Add the parameters for the function here
	@Year CHAR(4),
	@Month INT,
	@Site VARCHAR(50),
	@Plant VARCHAR(50),
	@ReportCode CHAR(3),
	@Amount NUMERIC(19,2),
	@OEMCustomerLayer VARCHAR(300)
)
RETURNS VARCHAR(MAX)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ReturnString VARCHAR(MAX)

	-- Add the T-SQL statements to compute the return value here
	SET @ReturnString=''
	SET @ReturnString=@ReturnString+'			IF NOT EXISTS(SELECT * FROM SalesAnalysis_Amount_Fiscal_For_OEMCustomerLayer WHERE ReportCode='+''''+@ReportCode+''''+' AND Year='+''''+@Year+''''+' AND Site='+''''+@Site+''''+' AND Plant='+''''+@Plant+''''+' AND OEMCustomerLayer='+''''+@OEMCustomerLayer+''''+') '
	SET @ReturnString=@ReturnString+'				BEGIN '
	SET @ReturnString=@ReturnString+'					INSERT INTO SalesAnalysis_Amount_Fiscal_For_OEMCustomerLayer(ReportCode,Site,Plant,Year,OEMCustomerLayer,M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12)'
	SET @ReturnString=@ReturnString+'						VALUES('+''''+@ReportCode+''''+','+''''+@Site+''''+','+''''+@Plant+''''+','+''''+@Year+''''+','+''''+@OEMCustomerLayer+''''+',0,0,0,0,0,0,0,0,0,0,0,0)'
	SET @ReturnString=@ReturnString+'				END'
	SET @ReturnString=@ReturnString+'			UPDATE SalesAnalysis_Amount_Fiscal_For_OEMCustomerLayer'
	SET @ReturnString=@ReturnString+'			SET M'+CONVERT(VARCHAR(2),@Month)+'='+CONVERT(VARCHAR(50),@Amount)
	SET @ReturnString=@ReturnString+'			WHERE ReportCode='+''''+@ReportCode+''''+' AND Year='+''''+@Year+''''+' AND Site='+''''+@Site+''''+' AND Plant='+''''+@Plant+''''+' AND OEMCustomerLayer='+''''+@OEMCustomerLayer+''''

	-- Return the result of the function
	RETURN (ISNULL(@ReturnString,''))

END
GO
