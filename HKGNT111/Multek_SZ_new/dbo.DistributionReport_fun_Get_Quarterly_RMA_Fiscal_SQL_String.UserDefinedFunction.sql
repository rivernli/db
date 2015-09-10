USE [Multek_SZ_New]
GO
/****** Object:  UserDefinedFunction [dbo].[DistributionReport_fun_Get_Quarterly_RMA_Fiscal_SQL_String]    Script Date: 11/06/2014 15:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[DistributionReport_fun_Get_Quarterly_RMA_Fiscal_SQL_String]
(
	-- Add the parameters for the function here
	@Option VARCHAR(50),
	@Year VARCHAR(4),
	@Quarter SMALLINT ,
	@FiscalQuarterDesc VARCHAR(50),
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
	SET @ReturnString=@ReturnString+'			IF NOT EXISTS(SELECT * FROM DistributionReport_Quarterly_RMA WHERE Year='+''''+@Year+''''+' AND Quarter='+CONVERT(VARCHAR(3),@Quarter)+' AND QuarterDesc='+''''+@FiscalQuarterDesc+''''+' AND Plant='+''''+@Plant+''''+') '
	SET @ReturnString=@ReturnString+'				BEGIN '
	SET @ReturnString=@ReturnString+'					INSERT INTO DistributionReport_Quarterly_RMA(Year,Quarter,QuarterDesc,Plant,Lot,Unit,SQFT,Cost,PCB,PCBA,PCBRLP)'
	SET @ReturnString=@ReturnString+'						VALUES('+''''+@Year+''''+','+CONVERT(VARCHAR(3),@Quarter)+','+''''+@FiscalQuarterDesc+''''+','+''''+@Plant+''''+',0,0,0,0,0,0,0)'
	SET @ReturnString=@ReturnString+'				END'
	SET @ReturnString=@ReturnString+'			UPDATE DistributionReport_Quarterly_RMA'
	SET @ReturnString=@ReturnString+'			SET '+@Option+'='+CONVERT(VARCHAR(50),@Amount)
	SET @ReturnString=@ReturnString+'			WHERE Year='+''''+@Year+''''+' AND Quarter='+CONVERT(VARCHAR(3),@Quarter)+' AND QuarterDesc='+''''+@FiscalQuarterDesc+''''+' AND Plant='+''''+@Plant+''''

	-- Return the result of the function
	RETURN (ISNULL(@ReturnString,''))

END
GO
