USE [Multek_SZ_New]
GO
/****** Object:  UserDefinedFunction [dbo].[DistributionReport_fun_Get_TOP20CustomerOEM_SQL_String]    Script Date: 11/06/2014 15:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[DistributionReport_fun_Get_TOP20CustomerOEM_SQL_String]
(
	-- Add the parameters for the function here
	@ReportCode VARCHAR(3),
	@Year CHAR(4),
	@Type VARCHAR(10),
	@Site VARCHAR(50),
	@Plant VARCHAR(50),
	@OEMCustomer VARCHAR(500),
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
	SET @ReturnString=@ReturnString+'			IF NOT EXISTS(SELECT * FROM DistributionReport_TOP20CustomerOEM WHERE OEMCustomer='+''''+@OEMCustomer+''''+' AND ReportCode='+''''+@ReportCode+''''+' AND Site='+''''+@Site+''''+' AND Plant='+''''+@Plant+''''+'AND Year='+''''+@Year+''''+')'
	SET @ReturnString=@ReturnString+'				BEGIN '
	SET @ReturnString=@ReturnString+'					INSERT INTO DistributionReport_TOP20CustomerOEM(OEMCustomer,ReportCode,Type,Site,Plant,Year,Amount)'
	SET @ReturnString=@ReturnString+'						VALUES('+''''+@OEMCustomer+''''+','+''''+@ReportCode+''''+','+''''+@Type+''''+','+''''+@Site+''''+','+''''+@Plant+''''+','+''''+@Year+''''+',0)'
	SET @ReturnString=@ReturnString+'				END'
	SET @ReturnString=@ReturnString+'			UPDATE DistributionReport_TOP20CustomerOEM'
	SET @ReturnString=@ReturnString+'			SET Amount='+CONVERT(VARCHAR(50),@Amount)
	SET @ReturnString=@ReturnString+'			WHERE OEMCustomer='+''''+@OEMCustomer+''''+' AND ReportCode='+''''+@ReportCode+''''+' AND Type='+''''+@Type+''''+' AND Site='+''''+@Site+''''+' AND Plant='+''''+@Plant+''''+' AND Year='+''''+@Year+''''+''


	-- Return the result of the function
	RETURN (ISNULL(@ReturnString,''))

END
GO
