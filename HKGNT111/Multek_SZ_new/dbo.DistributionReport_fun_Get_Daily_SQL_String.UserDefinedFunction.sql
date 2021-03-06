USE [Multek_SZ_New]
GO
/****** Object:  UserDefinedFunction [dbo].[DistributionReport_fun_Get_Daily_SQL_String]    Script Date: 11/06/2014 15:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[DistributionReport_fun_Get_Daily_SQL_String]
(
	-- Add the parameters for the function here
	@Type VARCHAR(10),
	@Site VARCHAR(50),
	@Plant VARCHAR(50),
	@Date	DATETIME,
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
	SET @ReturnString=@ReturnString+'			IF NOT EXISTS(SELECT * FROM DistribitionReport_Daily WHERE Type='+''''+@Type+''''+' AND Site='+''''+@Site+''''+' AND Plant='+''''+@Plant+''''+' AND Day='+''''+CONVERT(VARCHAR(10),@Date,120)+''''+') '
	SET @ReturnString=@ReturnString+'				BEGIN '
	SET @ReturnString=@ReturnString+'					INSERT INTO DistribitionReport_Daily(Type,Site,Plant,Day,Amount)'
	SET @ReturnString=@ReturnString+'						VALUES('+''''+@Type+''''+','+''''+@Site+''''+','+''''+@Plant+''''+','+''''+CONVERT(VARCHAR(10),@Date,120)+''''+','+CONVERT(VARCHAR(20),@Amount)+')'
	SET @ReturnString=@ReturnString+'				END'
	SET @ReturnString=@ReturnString+'			ELSE'
	SET @ReturnString=@ReturnString+'				BEGIN'
	SET @ReturnString=@ReturnString+'					UPDATE DistribitionReport_Daily'
	SET @ReturnString=@ReturnString+'					SET Amount='+CONVERT(VARCHAR(50),@Amount)
	SET @ReturnString=@ReturnString+'					WHERE Type='+''''+@Type+''''+' AND Site='+''''+@Site+''''+' AND Plant='+''''+@Plant+''''+' AND Day='+''''+CONVERT(VARCHAR(10),@Date,120)+''''
	SET @ReturnString=@ReturnString+'				END'

	-- Return the result of the function
	RETURN (ISNULL(@ReturnString,''))

END
GO
